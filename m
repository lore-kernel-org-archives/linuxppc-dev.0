Message-Id: <199909212103.VAA03918@go.hannover.sgh-net.de>
Subject: Stupid question of the day: Ethernet IP aliases on startup
Date: Tue, 21 Sep 1999 23:04:13 +0200
From: John L Grantham <jgrantha@hannover.sgh-net.de>
To: <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

My stupid question of the day, on a similar vein to some other questions 
recently: I'm trying to set up my Linux box (PowerMac G3 MT/266, LinuxPPC 
1999 crossed with YDL 1.1) to start up Ethernet IP aliases each time the 
computer boots. First attempt was using netcfg, which set up the aliases 
okay, and in each case the files for eth0:0 through eth0:7 in 
/etc/sysconfig/ says ONBOOT=YES, but the aliases don't start on boot. So 
I wrote a shell script to do so, and the script works if I call it 
(though it complains that the files already exist, but it does start the 
ports); the script I wrote is in /etc/sysconfig/network-scripts/, with a 
symbolic link pointing to it from /etc/rc.d/init.d/. But no dice--on 
startup, nothing doing, and I have to call the script myself.

What I'm looking to do is bind a specific IP address to an Ethernet 
alias. Then, each IP gets a domain name in my isolated LAN, and also each 
IP is used for a virtual server for HTTP. So long as I run the script, 
everything works. The script looks like this:

#!/bin/sh
# John's attempt at a script to start up Ethernet IP aliases
# /etc/sysconfig/network-scripts/ipaliases

# First set up IPs
/sbin/ifconfig lo 127.0.0.1
/sbin/ifconfig eth0 up
/sbin/ifconfig eth0 192.168.1.1
/sbin/ifconfig eth0:0 192.168.1.10
/sbin/ifconfig eth0:1 192.168.1.11
/sbin/ifconfig eth0:2 192.168.1.12
/sbin/ifconfig eth0:3 192.168.1.13
/sbin/ifconfig eth0:4 192.168.1.14
/sbin/ifconfig eth0:5 192.168.1.15
/sbin/ifconfig eth0:6 192.168.1.16
/sbin/ifconfig eth0:7 192.168.1.17

# Now set up routing and loopback
/sbin/route add -net 127.0.0.0 
/sbin/route add -net 192.168.1.0 dev eth0
/sbin/route add -host 192.168.1.1 dev eth0
/sbin/route add -host 192.168.1.10 dev eth0:0
/sbin/route add -host 192.168.1.11 dev eth0:1
/sbin/route add -host 192.168.1.12 dev eth0:2
/sbin/route add -host 192.168.1.13 dev eth0:3
/sbin/route add -host 192.168.1.14 dev eth0:4
/sbin/route add -host 192.168.1.15 dev eth0:5
/sbin/route add -host 192.168.1.16 dev eth0:6
/sbin/route add -host 192.168.1.17 dev eth0:7
/sbin/route add default gw 192.168.1.200

# End script

Any ideas, O great sirs and madams?

cya

John

---

John Grantham | Freelance Graphic and Web Designer
              | Dipl.-Designer (FH)
              | Homepage: http://surf.to/multimedia
              | MacLinux: http://www.maclinux.de/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
