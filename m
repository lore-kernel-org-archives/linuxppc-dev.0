Return-Path: <johan@borkhuis.com>
Received: from smtp-vbr6.xs4all.nl (smtp-vbr6.xs4all.nl [194.109.24.26])
	by ozlabs.org (Postfix) with ESMTP id D511FDDEFE
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 06:31:20 +1000 (EST)
Received: from borkhuis.com (borkhuis.xs4all.nl [80.127.44.59])
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id l7DKNMKi018577
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 22:23:22 +0200 (CEST)
	(envelope-from johan@borkhuis.com)
Received: from johanspc (johan.borkhuis.com [192.168.253.123])
	by borkhuis.com (8.13.8/8.13.8) with ESMTP id l7DKNF6O031766
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 22:23:21 +0200
From: "Johan Borkhuis" <johan@borkhuis.com>
To: <linuxppc-dev@ozlabs.org>
Subject: PCI BAR mapping problem
Date: Mon, 13 Aug 2007 22:23:02 +0200
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAJIdfqg5uLEqqfQ4KDmHrt8KAAAAQAAAA7FyaMEVWBEOa2ga+dPbyowEAAAAA@borkhuis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I am having some problems with the initialization of BAR registers of 
the PCI bus. I have a number of devices connected to the bus, which have 
a BAR-size of less than PAGE_SIZE. For example:

01:00.0 Network controller: VMIC: Unknown device 5565 (rev 01)
        Subsystem: PLX Technology, Inc.: Unknown device 9656
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 52
        Memory at 00000000dfeffe00 (32-bit, non-prefetchable) [size=512]
        I/O ports at e0ffff00 [size=256]
        Memory at 00000000dfeffdc0 (32-bit, non-prefetchable) [size=64]
        Memory at 00000000d8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [40] Power Management version 0
        Capabilities: [48] #00 [0080]

I want to access the PCI-areas from from user space, so I try to do an 
mmap. The returned address is however rounded to multiple of PAGE_SIZE 
(=0x1000). To access for example BAR0, I have to use the return-value 
from mmap+0xE00. And in the above case, I am able to access the BAR0 and 
BAR2 areas with only 1 mmap call, as the 2 addresses are within one page. 
The problem is that, when running my code on a I386 platform the BAR 
registers are mapped at address 0x0 of the returned area.

When looking at the PCI init code (arch/ppc/syslib/pci_auto.c) I see 
that the BAR-base address and/or size is not corrected for PAGE_SIZE. Is 
this correct behaviour?

I could image the following line being changed from:
        bar_value = (*upper_limit - bar_size) & ~(bar_size - 1);
to:
        bar_value = ((*upper_limit - bar_size) & ~(bar_size - 1)) &
~(PAGE_SIZE-1);

The PCI area is assigned using a top-down method. Using this statement 
the bar_value is rounded down to the first PAGE_SIZE boundary.
This gives the following output:

01:00.0 Network controller: VMIC: Unknown device 5565 (rev 01)
        Subsystem: PLX Technology, Inc.: Unknown device 9656
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 52
        Memory at 00000000dfeff000 (32-bit, non-prefetchable) [size=512]
        I/O ports at e0fff000 [size=256]
        Memory at 00000000dfefe000 (32-bit, non-prefetchable) [size=64]
        Memory at 00000000d8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [40] Power Management version 0
        Capabilities: [48] #00 [0080]

My architecture: MVME3100 board with PPC8540 processor.

Note:
I posted this message to the embedded PPC mailing list, but as this is a
more generic linux-ppc issue, it could be discussed here as well.

Kind regards,
        Johan Borkhuis

-- 
         o o o o o o o . . .   ___J_o_h_a_n___B_o_r_k_h_u_i_s___
        o      _____           ||   http://www.borkhuis.com    |
      .][__n_n_|DD[  ====_____  |      johan@borkhuis.com      |
     >(________|__|_[_________]_|______________________________|
     _/oo OOOOO oo`  ooo   ooo  'o!o!o                    o!o!o`
=== VxWorks-FAQ: http://www.xs4all.nl/~borkhuis/vxworks/vxworks.html ===
