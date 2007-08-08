Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id 80166DDE3B
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 08:20:43 +1000 (EST)
Date: Wed, 8 Aug 2007 22:20:35 -0000
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: pci in arch/powerpc vs arch/ppc
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Message-ID: <twig.1186611635.44657@inaccessnetworks.com>
In-Reply-To: <46BA1FD2.4000705@freescale.com>
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix> <op.twqvg3i0nhx3hy@phoenix>,
	<op.twqvg3i0nhx3hy@phoenix> <twig.1186602365.9125@inaccessnetworks.com>,
	<twig.1186602365.9125@inaccessnetworks.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> No, because as I said, res->start is relative to the start of IO-space. 
>   The in/out functions add isa_io_base to the address.
> 

Hi Scott,

please allow me to insist a little bit more on this. 

1. As far as the device tree is concerned, it is defined that the first 3 
numbers in every line of the ranges property (for our case, with #address-
cells=3) is the PCI address of the device (in this case, host bridge), the 
next one is the local bus base address and the last two the local region 
size. In the case of memory space, res->start for the host bridge takes as a 
value ranges[3], which is actually the local bus base address. Why does the 
code for IO space uses ranges[2]. Shouldn't these two use the same field of 
the corresponding ranges property line? 

2. As far as isa_io_base is concerned: When primary (what does this actually 
mean? primary PCI bus ?) is 1, then indeed 
isa_io_base=ranges[na+2]=ranges[3] (in this case) as it should (while res-
>start=ranges[2] for some reason I don't understand, as I said earlier). And 
this is indeed added in the i/o address of the device during in/out 
operations. However, the driver I use, drivers/net/tulip/dmfe.c, actually 
checks whether res->start for the PCI device is zero, and if it is so, it 
fails. So, assuming that the pci_process_OF_bridges code is correct as is, 
then there is some problem with the driver? Because the same driver worked in 
arch/ppc, which makes me think that there, res->start was NOT 0, but was 
already offset to the actual I/O space of the local bus. 

I would really appreciate your comments (and forgive me for insisting on this
 :) )

Alex

> > Because, currently, based on what I've 
> > described in my previous mail, it gets set to 0. It seems to me like a 
matter 
> > of incorrect parsing of the device tree from 
pci_process_bridge_OF_ranges() 
> > for IO space.
> 
> It is not, at least not in this case.  It does appear to be ignoring the 
> possibility that it needs to do further translation of the address 
> through parent buses, though.
> 
> -Scott
> 



-- 
