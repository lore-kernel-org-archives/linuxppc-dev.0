Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6013D679EB
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 11:58:41 +1000 (EST)
Subject: Re: ppc32 kernel boot problem (pmu related?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Pilatzke <nathanpilatzke@gmail.com>
In-Reply-To: <98889dd30605120540n214800fbk8899fe9e39e972cf@mail.gmail.com>
References: <98889dd30605111207g6afe6158je681717ccacb9e40@mail.gmail.com>
	<1147403525.7343.19.camel@localhost.localdomain>
	<98889dd30605120540n214800fbk8899fe9e39e972cf@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 11:58:29 +1000
Message-Id: <1147658309.21291.73.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Using PowerMac machine description
> Total memory = 640MB; using 2048kB for hash table (at cfe00000)
> Linux version 2.6.17-rc3 (root@the_emac) (gcc version 3.4.5 (Gentoo 3.4.5-r1, ss
> p-3.4.5-1.0, pie-8.7.9)) #11 Thu May 11 09:53:39 EDT 2006
> Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x11
> Mapped at 0xfdfc0000
> Found a Keylargo mac-io controller, rev: 3, mapped at 0xfdf40000
> Processor NAP mode on idle enabled.
> PowerMac motherboard: eMac
> setup_arch: bootmem
> Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
> Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
> Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
> via-pmu: Server Mode is disabled
> PMU driver v2 initialized for Core99, firmware: 0c
> arch: exit
> Top of RAM: 0x28000000, Total RAM: 0x28000000
> Memory hole size: 0MB
> Built 1 zonelists
> Kernel command line: root=/dev/sda8 ro video=ofonly root=/dev/sda8 rootdelay=10
> resume=/dev/sda9
> mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
> mpic: ISU size: 64, shift: 6, mask: 3f
> mpic: Initializing for 64 sources
> PID hash table entries: 4096 (order: 12, 16384 bytes)
> time_init: decrementer frequency = 24.913389 MHz
> time_init: processor frequency   = 700.000000 MHz
> 
> and then the machine freezes and requires a power cycle to restart.
> Without that option enabled I get this:

Hrm... that's pretty much when console_init() gets called, which means
no message until the fbdev kicks in, thus we just "miss" the messages
from there to the crash.... Can you edit arch/powerpc/kernel/udbg.c,
there is a function called disable_early_printk() which contains a #if
1, turn that into #if 0 and tell me if you get a more useful log after
the time_init thing. Thanks !
