Mime-Version: 1.0
Message-Id: <p04330105b8428baee0fe@[24.163.44.170]>
Date: Sun, 16 Dec 2001 12:53:20 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: ethtool failure with tulip 21143
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a PowerPC 6500 with a Farallon 10/100 PCI card connected to a
Netgear 10/100 switch. I have never gotten this card to work right in
this box. If the number of packets is small, the connection seems to
work, but any increase in the number of packets (my theory) causes
the interface/NIC to choke up. I'm using 2.4.14 (bk).

I downloaded Jeff Garzik's ethtool to work on this, but I'm hitting a
brick wall rather rapidly. As per dmesg:

[root@orion ethtool-1.4]# dmesg
Linux Tulip driver version 0.9.15-pre8 (Oct 11, 2001)
PCI: Enabling device 00:0e.0 (0000 -> 0003)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial
PHY (2) block.
tulip0:  Index #1 - Media 10baseT-FDX (#4) described by a 21142
Serial PHY (2) block.
tulip0:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY
(4) block.
tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21143 SYM
PHY (4) block.
tulip0:  Index #4 - Media 100baseTx (#3) described by a 21143 reset
method (5) block.
eth0: Digital DS21143 Tulip rev 65 at 0xc81f2000, 00:00:C5:53:3E:3D, IRQ 25.


I can get some basic information with the -i switch:

[root@orion ethtool-1.4]# ethtool-i eth0
driver: tulip
version: 0.9.15-pre8
firmware-version:
bus-info: 00:0e.0


But any attempts to get (much less set) anything else fail in this fashion:

[root@orion ethtool-1.4]# ethtool eth0
Settings for eth0:
No data available

Trying the register dump yields:

[root@orion ethtool-1.4]# ethtool -d eth0
Cannot get register dump: Operation not supported

I've tried this in a completely different box (9500) with the same
card, and get the same result. Does ethtool not work with the 21143
Tulip?


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
