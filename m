From: "Manie Steyn" <msteyn@wmux.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: All-subnets-directed Broadcast
Date: Thu, 10 Aug 2000 15:55:02 -0700
Message-ID: <NEBBIKAICMIJKJMMELBFIEFJCBAA.msteyn@wmux.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

This is not necessarily an embedded question, so please direct me to a
different forum dealing with  Linux Network programming if none here can
help me.

I have 4 100baseT interfaces on my MCP750, each configured for a different
192.168.x subnet.

sh-2.03# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
192.168.3.0     *               255.255.255.0   U     0      0        0 eth3
192.168.2.0     *               255.255.255.0   U     0      0        0 eth2
192.168.1.0     *               255.255.255.0   U     0      0        0 eth1
192.168.0.0     *               255.255.255.0   U     0      0        0 eth0
sh-2.03#

I am trying to send a broadcast message (as rudimentary synchronization) to
all subnets at the same time. I believe this is called "All-subnets-directed
Broadcast" [from Stevens], and should be possible if the application and
router supports this.

To test this I use ping 192.168.255.255 but receives "Network is
unreachable" error:

sh-2.03# ping -c 1 192.168.255.255
PING 192.168.255.255 (192.168.255.255): 56 data bytes
ping: sendto: Network is unreachable
ping: wrote 192.168.255.255 64 chars, ret=-1

--- 192.168.255.255 ping statistics ---
1 packets transmitted, 0 packets received, 100% packet loss
sh-2.03#

I have also tried ping 192.169.255.0 and ping 255.255.255.255 with same
results.
Ping 192.168.x.255 works for broadcasting on each of the subnets, is called
"Subnet-directed Broadcast" [from Stevens].

I'm sure it must be possible to broadcast to all configured subnets somehow.
Does the problem lie with the router or ping. (Maybe I should stop being
lazy and go write a small tester to check it out :-)

Any suggestions in the mean time?




_______________________________________________________________________

Manie Steyn     Embedded Software Engineer       mailto:msteyn@wmux.com
Western Multiplex, 1367 Redwood Way, Petaluma, CA  Ph:707 792 5390 x 12


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
