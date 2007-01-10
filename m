Return-Path: <andrea.galbusera@teamware.it>
Received: from smtp3.aruba.it (smtpd3.aruba.it [62.149.128.208])
	by ozlabs.org (Postfix) with SMTP id DE0B7DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 01:26:08 +1100 (EST)
Subject: Ethernet fails on MPC5200 based target
From: Andrea Galbusera <andrea.galbusera@teamware.it>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 10 Jan 2007 15:26:52 +0100
Message-Id: <1168439212.5271.70.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have a problem with ethernet on my MPC5200 based board.

Ethernet is failing on my target with both 2.6.16.11-rt18 from Freescale
BSP (based on the ltib tool) and 2.6.16-rc1-g7cdaf877 from Sylvain
Munaut's git tree. On the opposite, it works fine with a relatively old
(April 2006) 2.6.16 from Denx.

What I see is that network is not working (corruption occur). I use a
ramdisk rootfs to boot and I get an up-and-running system. Then, if I
ping it from a remote host I get the following errors:

> ping 192.168.0.183 
> PING 192.168.0.183 (192.168.0.183) 56(84) bytes of data.
> 64 bytes from 192.168.0.183: icmp_seq=1 ttl=64 time=8.00 ms
> 64 bytes from 192.168.0.183: icmp_seq=2 ttl=64 time=0.188 ms
> wrong data byte #20 should be 0x14 but was 0xc0
> #8      8 9 a b c d e f 10 11 12 13 c0 15 16 17 18 19 1a 1b 1c 1d 1e
> 1f 20 21 22 23 24 25 26 27
> #40     28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 34 35 36 37
> 64 bytes from 192.168.0.183: icmp_seq=3 ttl=64 time=0.217 ms
> 64 bytes from 192.168.0.183: icmp_seq=5 ttl=64 time=0.216 ms
> wrong data byte #20 should be 0x14 but was 0x0
> #8      8 9 a b c d e f 10 11 12 13 0 15 16 17 18 19 1a 1b 1c 1d 1e 1f
> 20 21 22 23 24 25 26 27
> #40     28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 34 35 36 37
> 64 bytes from 192.168.0.183: icmp_seq=6 ttl=64 time=0.187 ms

Since my target is heavily based on the Lite5200 I tryed all three
kernels on the Lite5200 too and they all show working ethernet.

This may suggest something related with the different phy hardware, but
consider that the kernel from Denx works fine on it!
My target hardware uses MPC5200B CPU and AMD NetPhy AM79C874 for the
network phy.

Can you suggest what source file may be responsible for this behaviour
in order to dig the trees and maybe, hopefully, fix the problem? I tryed
a first diffing between the Denx and the Freescale trees (this last one
being mostly based on Sylvain's patches) but I can't figure out any
reasonable answer.

Consider I can't unfortunately switch to 2.6.16 from Denx because it
does not support ATA/IDE that I need; also switching to the new powerpc
architecture is not an option at moment, since it would require changes
to the system at whole.

TIA and let me know if you need more details


-- 
Andrea Galbusera
