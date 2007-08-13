Return-Path: <j.borkhuis@dutchspace.nl>
Received: from kirk.dutchspace.nl (kirk.dutchspace.nl [193.200.147.14])
	by ozlabs.org (Postfix) with ESMTP id 6F53CDDE34
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 00:20:58 +1000 (EST)
Received: from [10.21.30.78] (snitkin.dutchspace.nl [10.21.30.78])
	by kirk.dutchspace.nl (8.11.7p1+Sun/8.10.2) with ESMTP id l7DE7QN25937
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 16:07:26 +0200 (MEST)
Message-ID: <46C06678.1010004@dutchspace.nl>
Date: Mon, 13 Aug 2007 16:11:04 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: PCI BAR mapping problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

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
BAR2 areas with only 1 mmap cal, as the 2 addresses are within one page. 
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

Kind regards,
    Johan Borkhuis
