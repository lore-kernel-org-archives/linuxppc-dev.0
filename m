Message-ID: <20000810034057.3645.qmail@kunk.jriver.com>
Subject: Mace on 7200 problem debug output
To: linuxppc-dev@lists.linuxppc.org
Date: Wed, 9 Aug 2000 22:40:56 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here is some possibly interesting info on the problem with the MACE ethernet
on the 7200. I've setup the 7200 with an iMac on a 10 mb hub. Using PCI
ethernet cards on the 7200 works fine. The internal does the following
(note: I set the arps by hand (arp -s) to make the trace easier to
follow). I've come to the conclusion from these dumps that it is the
7200 that is dropping the incoming packets.

This problem occurs on 7200/75 and 7200/90. Both machines tested
HAVE the ethernet xtal. I've tried this with and without the AAUI port.

I've tested several 7200 kernels but this one is 2.2.17pre15

This is with tcpdump listening ON the 7200 and a ping TO the 7200
FROM the iMac....

root@7200 /root]# tcpdump -i eth0
Kernel filter, protocol ALL, datagram packet socket
tcpdump: listening on eth0
21:47:37.370000 P 192.168.1.2 > 192.168.1.1: icmp: echo request
21:47:38.370000 M 192.168.1.2 > 192.168.1.1: icmp: echo request
21:47:38.380000 > 192.168.1.1 > 192.168.1.2: icmp: echo reply
21:47:39.380000 P 192.168.1.2 > 192.168.1.1: icmp: echo request
21:47:40.380000 P 192.168.1.2 > 192.168.1.1: icmp: echo request
21:47:41.380000 P 192.168.1.2 > 192.168.1.1: icmp: echo request
21:47:42.390000 P 192.168.1.2 > 192.168.1.1: icmp: echo request
21:47:43.390000 P 192.168.1.2 > 192.168.1.1: icmp: echo request
21:47:44.390000 P 192.168.1.2 > 192.168.1.1: icmp: echo request
21:47:45.390000 P 192.168.1.2 > 192.168.1.1: icmp: echo request
21:47:46.400000 M 192.168.1.2 > 192.168.1.1: icmp: echo request
21:47:46.400000 > 192.168.1.1 > 192.168.1.2: icmp: echo reply
21:47:47.400000 P 192.168.1.2 > 192.168.1.1: icmp: echo request
21:47:48.400000 P 192.168.1.2 > 192.168.1.1: icmp: echo request

Notice how the 7200 only appears to reply to the pings when the
P flag is NOT set..... (95% packet loss)

However, when tcpdump is listening on the iMac and the 7200 is pinging
the iMac receives and replies to every request but the 7200 doesn't
see any of the replies!! The 7200 and a third machine on the
same network also see the outgoing packets but the third machine
sees the return packets and the 7200 doesn't!!!


22:15:38.560000 > 192.168.1.1 > 192.168.1.2: icmp: echo request
22:15:39.560000 > 192.168.1.1 > 192.168.1.2: icmp: echo request
22:15:40.560000 > 192.168.1.1 > 192.168.1.2: icmp: echo request
22:15:41.560000 > 192.168.1.1 > 192.168.1.2: icmp: echo request
22:15:42.560000 > 192.168.1.1 > 192.168.1.2: icmp: echo request
22:15:43.560000 > 192.168.1.1 > 192.168.1.2: icmp: echo request
22:15:44.560000 > 192.168.1.1 > 192.168.1.2: icmp: echo request
22:15:45.560000 > 192.168.1.1 > 192.168.1.2: icmp: echo request
22:15:46.560000 > 192.168.1.1 > 192.168.1.2: icmp: echo request
22:15:47.560000 > 192.168.1.1 > 192.168.1.2: icmp: echo request

--- 192.168.1.2 ping statistics ---
87 packets transmitted, 0 packets received, 100% packet loss

Any ideas on what to look for next??


Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
