#!/bin/bash

# USE THIS SCRIPT FOR BASIC SYSTEM STATUS DEBUG INFO

# load code software version
source /home/admin/_version.info

# load network
network=`sudo cat /home/admin/.network`

# get chain
chain="test"
isMainChain=$(sudo cat /mnt/hdd/${network}/${network}.conf 2>/dev/null | grep "#testnet=1" -c)
if [ ${isMainChain} -gt 0 ];then
  chain="main"
fi

echo ""
echo "*** RASPIBLITZ LOGS ***"
echo "blitzversion: ${codeVersion}"
echo "chainnetwork: ${network} / ${chain}"
uptime
echo ""

echo "*** CHAINNETWORK SYSTEMD STATUS ***"
sudo systemctl status ${network}d -n2 --no-pager
echo ""

echo "*** LAST 20 CHAINNETWORK LOGS ***"
pathAdd=""
if [ "${chain}" = "test" ]; then
  pathAdd="testnet3/"
fi
sudo tail -n 20 /mnt/hdd/${network}${pathAdd}/debug.log
echo ""

echo "*** LND SYSTEMD STATUS ***"
sudo systemctl status lnd -n2 --no-pager
echo ""

echo "*** LAST 20 LND LOGS ***"
sudo journalctl -u lnd -b --no-pager -n20
echo ""