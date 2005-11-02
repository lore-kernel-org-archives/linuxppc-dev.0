Return-Path: <jpl@xiphos.ca>
Received: from mail.net (custpop.ca.mci.com [142.77.1.111])
	by ozlabs.org (Postfix) with ESMTP id D556D6866B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Nov 2005 03:22:00 +1100 (EST)
Message-ID: <4368D97A.605@xiphos.ca>
Date: Wed, 02 Nov 2005 10:21:30 -0500
From: Joshua Lamorie <jpl@xiphos.ca>
MIME-Version: 1.0
To: xiay@nari-relays.com
References: <200510082230.AA69861636@NARI-RELAYS.COM>
In-Reply-To: <200510082230.AA69861636@NARI-RELAYS.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: onboard pci ethernet controller(i82551)without
 eprom(linuxppc2.2.4 MPC5200)
Reply-To: jpl@xiphos.ca
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=E6=82=A8=E5=A5=BD,

I am using the same chip connected through PCI to a Virtex-II Pro (PPC=20
405).  I do not have an EEPROM connected to the chip.  However, I am=20
having problem with the code because it seems to be built specifically=20
for processors that have coherent cache.  So each time the code tries to =

execute I get a kernel panic. (kernel 2.4.26, with RTAI patch)

This occurs because in many places it executes a bottom-half spin lock=20
before calling pci_free_consistent.  This increments the bottom-half=20
counter and so when pci_free_consistent is called it calls BUG(); and=20
the whole thing goes Tango Uniform.  I'm about to go through and try to=20
fix this, but it seems like an extremely dangerous thing for me to play=20
with.

I seem to be able to get the eepro100.c code to work, but I was hoping=20
to use the e100 driver to program an EEPROM on the board.

=E8=B0=A2=E8=B0=A2

Joshua

=C3=8F=C3=84=C3=93=C3=AA wrote:

>After i modified e100_init() in e100_main.c , the pci ethernet card coul=
d been found :
>
>bash-2.05b# ifconfig -a
>eth0      Link encap:Ethernet  HWaddr FF:FF:FF:FF:FF:FF
>          BROADCAST MULTICAST  MTU:1500  Metric:1
>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>          Memory:40000000-40000038
>
>eth1      Link encap:Ethernet  HWaddr 00:04:9F:00:15:2B
>          inet addr:198.87.102.215  Bcast:198.87.102.255  Mask:255.255.2=
55.0
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:12606 errors:42 dropped:0 overruns:0 frame:0
>          TX packets:7668 errors:3 dropped:0 overruns:3 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:10596597 (10.1 Mb)  TX bytes:1218624 (1.1 Mb)
>          Interrupt:43
>
>lo        Link encap:Local Loopback
>          inet addr:127.0.0.1  Mask:255.0.0.0
>          UP LOOPBACK RUNNING  MTU:16436  Metric:1
>          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>
>But i still could not config eth0:
>
>bash-2.05b# ifconfig eth0 198.87.102.140
>SIOCSIFFLAGS: Resource temporarily unavailable
>
>I noticed that there was message as blow during kernel bootup:
>
>POSIX conformance testing by UNIFIX
>PCI: Probing PCI hardware
>PCI: Cannot allocate resource region 0 of device 00:1a.0
>Linux NET4.0 for Linux 2.4
>
>Intel(R) PRO/100 Network Driver - version 2.3.38-k1
>Copyright (c) 2004 Intel Corporation
>
>PCI: Enabling device 00:18.0 (0006 -> 0007)
>e100: eth0: Intel(R) PRO/100 Network Connection
>Hardware receive checksums enabled
>
>IP-Config: Failed to open eth0
>
>what is wrong?
>
>Best regards
>
>Xiayu
>
>
>
>
>
>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> =20
>

--=20

Xiphos Technologies
(514) 848-9640 x227
(514) 848-9644 fax

www.xiplink.com
_______________________________________________
The information transmitted is intended only for the
person or entity to which it is addressed and may contain
confidential and/or privileged material.  If you have
received this in error, please contact the sender and delete
this communication and any copy immediately. Thank you.
