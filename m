Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 04CC0DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 01:04:23 +1000 (EST)
Message-ID: <46BB2CE2.2060207@freescale.com>
Date: Thu, 09 Aug 2007 10:04:02 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
Subject: Re: pci in arch/powerpc vs arch/ppc
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix> <op.twqvg3i0nhx3hy@phoenix>,
	<op.twqvg3i0nhx3hy@phoenix> <twig.1186602365.9125@inaccessnetworks.com>,
	<twig.1186602365.9125@inaccessnetworks.com>
	<twig.1186611635.44657@inaccessnetworks.com>
In-Reply-To: <twig.1186611635.44657@inaccessnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexandros Kostopoulos wrote:
> Hi Scott,
> 
> please allow me to insist a little bit more on this. 

No problem. :-)

> 1. As far as the device tree is concerned, it is defined that the first 3 
> numbers in every line of the ranges property (for our case, with #address-
> cells=3) is the PCI address of the device (in this case, host bridge), the 
> next one is the local bus base address and the last two the local region 
> size. In the case of memory space, res->start for the host bridge takes as a 
> value ranges[3], which is actually the local bus base address. Why does the 
> code for IO space uses ranges[2]. Shouldn't these two use the same field of 
> the corresponding ranges property line? 

Yes, I see what you mean -- non-primary buses appear to be completely 
broken for IO-space.  One part of the code insists that ranges[2] be 
zero, but later it assumes that it matches the CPU-side offset from the 
start of the primary IO-space (which cannot be zero, because it would 
conflict with the primary bus).

> 2. As far as isa_io_base is concerned: When primary (what does this actually 
> mean? primary PCI bus ?) is 1,

It means the bus on which legacy I/O ports can be found.  It's a fairly 
broken concept; each host bridge should really be treated as a 
completely separate entity, and if something like a VGA card has legacy 
I/O ports that need to be used, they should be looked for on the same 
PCI bus as the card itself.  Legacy ISA ports should be discovered 
through the device tree (or platform devices, or whatever) that 
explicitly state which PCI-to-ISA bridge they're under.

> then indeed 
> isa_io_base=ranges[na+2]=ranges[3] (in this case) as it should (while res-
> 
>>start=ranges[2] for some reason I don't understand, as I said earlier). And 
> 
> this is indeed added in the i/o address of the device during in/out 
> operations. However, the driver I use, drivers/net/tulip/dmfe.c, actually 
> checks whether res->start for the PCI device is zero, and if it is so, it 
> fails. So, assuming that the pci_process_OF_bridges code is correct as is, 

It's not, but even if the above bug were fixed it'd still start at zero 
for the primary bus.

> then there is some problem with the driver?

Yes, apparently -- according to a recent thread here, recent versions of 
the PCI spec removed the wording that prohibited a zero BAR (is there 
then no way to disable a BAR?).  Still, it'd be better to avoid it.

> Because the same driver worked in 
> arch/ppc, which makes me think that there, res->start was NOT 0, but was 
> already offset to the actual I/O space of the local bus. 

The m82xx_pci code in arch/ppc seems to set isa_io_base to the start of 
the I/O region, so I'm not sure why you'd get different behavior.

-Scott
