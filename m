Return-Path: <markc@mail.com>
Message-ID: <005801c5ce5e$a5fd8470$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "apoorv sangal" <apoorvsangal@gmail.com>,
	<Linuxppc-embedded@ozlabs.org>
References: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com>
	<20051007123126.GA6879@cathedrallabs.org>
	<a79669360510100340g2563b441w9418001c034dbe5b@mail.gmail.com>
	<003d01c5cd97$34404470$0301a8c0@chuck2>
	<a79669360510102327o694dffb4pcf8ead02d95c9414@mail.gmail.com>
Date: Tue, 11 Oct 2005 08:23:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Problem Regarding Ping in Linux kernel version 2.4.24
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hi,
I am sending the output from the console of the boot sequence and ifconfig
command as following.
Please check the same and let me know where i am going wrong.
****************************************************************************
***************************
[snip]

eth0: FCC2 ENET Version 0.4, 00:10:EC:40:30:8C

[snip]
init started: BusyBox v0.60.5 (2004.11.09-16:07+0000) multi-call
binarymount: Mounting /dev/ram0 on /tmp failed: Invalid argument
# ifconfig eth0 down
# ifconfig eth0 172.19.56.218
# ifconfig eth0 up
# ifconfig
eth0 Link encap:Ethernet HWaddr 00:10:EC:40:30:8C
inet addr:172.19.56.218 Bcast:172.19.255.255 Mask:255.255.0.0
UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
RX packets:0 errors:0 dropped:0 overruns:0 frame:0
TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:1000
RX bytes:0 (0.0 iB) TX bytes:0 (0.0 iB)
Base address:0x8500
lo Link encap:Local Loopback
inet addr:127.0.0.1 Mask:255.0.0.0
UP LOOPBACK RUNNING MTU:16436 Metric:1
RX packets:0 errors:0 dropped:0 overruns:0 frame:0
TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:0
RX bytes:0 (0.0 iB) TX bytes:0 (0.0 iB)
# ping 127.0.0.1
PING 127.0.0.1 (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: icmp_seq=0 ttl=64 time=0.6 ms
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.2 ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.2 ms
64 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.2 ms
64 bytes from 127.0.0.1: icmp_seq=4 ttl=64 time=0.2 ms
--- 127.0.0.1 ping statistics ---
5 packets transmitted, 5 packets received, 0% packet loss
round-trip min/avg/max = 0.2/0.2/0.6 ms
#
# ping 172.19.59.101
PING 172.19.59.101 (172.19.59.101): 56 data bytes
--- 172.19.59.101 ping statistics ---
6 packets transmitted, 0 packets received, 100% packet loss
****************************************************************************
***************************
Regards,
Apoorv Sangal.


It appears you have correctly assigned MAC and IP addresses.  The problem
does appear to be at
the hardware level, because the ethernet interface is not doing anything at
all.  My guess would be
that the driver is not configured for the correct pins.  You mentioned that
you are using custom hardware,
so look, probably in arch/ppc/8260_io/fcc_enet.c and make sure you have it
configured for Tx and
Rx clock coming in on the right pins, and also check that you are configured
for the correct PHY
interrupt.

Good luck,
Mark Chambers
