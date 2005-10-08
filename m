Return-Path: <xiay@nari-relays.com>
Received: from NARI-RELAYS.COM (unknown [221.226.124.170])
	by ozlabs.org (Postfix) with ESMTP id D0400683BA
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Oct 2005 00:18:08 +1000 (EST)
Date: Sat,  8 Oct 2005 22:30:08 +0800
Message-Id: <200510082230.AA69861636@NARI-RELAYS.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "=?ISO-8859-1?Q?=CF=C4=D3=EA?= " <xiay@nari-relays.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: onboard pci ethernet controller(i82551)without eprom(linuxppc2.2.4
	MPC5200)
Reply-To: xiay@nari-relays.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

After i modified e100_init() in e100_main.c , the pci ethernet card could been found :

bash-2.05b# ifconfig -a
eth0      Link encap:Ethernet  HWaddr FF:FF:FF:FF:FF:FF
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Memory:40000000-40000038

eth1      Link encap:Ethernet  HWaddr 00:04:9F:00:15:2B
          inet addr:198.87.102.215  Bcast:198.87.102.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:12606 errors:42 dropped:0 overruns:0 frame:0
          TX packets:7668 errors:3 dropped:0 overruns:3 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:10596597 (10.1 Mb)  TX bytes:1218624 (1.1 Mb)
          Interrupt:43

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

But i still could not config eth0:

bash-2.05b# ifconfig eth0 198.87.102.140
SIOCSIFFLAGS: Resource temporarily unavailable

I noticed that there was message as blow during kernel bootup:

POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 00:1a.0
Linux NET4.0 for Linux 2.4

Intel(R) PRO/100 Network Driver - version 2.3.38-k1
Copyright (c) 2004 Intel Corporation

PCI: Enabling device 00:18.0 (0006 -> 0007)
e100: eth0: Intel(R) PRO/100 Network Connection
Hardware receive checksums enabled

IP-Config: Failed to open eth0

what is wrong?

Best regards

Xiayu
