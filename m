From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15623.56408.342901.245259@argo.ozlabs.ibm.com>
Date: Thu, 13 Jun 2002 09:42:16 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
In-Reply-To: <3D07D80F.9050306@embeddededge.com>
References: <20020531042153.GD16537@zax>
	<3CFC0D3F.9030901@embeddededge.com>
	<20020604035947.GH2762@zax>
	<3CFCFC20.80101@embeddededge.com>
	<15614.37065.549142.218906@argo.ozlabs.ibm.com>
	<3CFEE9A3.5060300@embeddededge.com>
	<15614.63160.272890.683586@argo.ozlabs.ibm.com>
	<3CFF1624.2070808@embeddededge.com>
	<20020612035203.GQ25800@zax>
	<3D06E702.4000709@embeddededge.com>
	<20020612064344.GT25800@zax>
	<3D07D80F.9050306@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> Long ago, modern operating systems abstracted much of the VM implementation
> away from the drivers.  The most useful example would be for us to use
> an I/O vector triplet {physaddr, offset, length} in a driver for any DMA
> or other physical address operation.  Drivers shouldn't care how memory
> mapping is implemented, they should be given information about a VM address
> range that is suitable for them to perform DMA.  This way, we don't have
> one implementation for low memory drivers, yet another thing for high
> memory bounce buffers, and who knows, maybe someday we will have a direct I/O
> capability or even DMA from user space (like other operating systems have
> for years) without having to hack up a driver yet again.  These concepts
> were working on production systems long before Linux was started, and your
> company has great examples of this.

This is an issue which is much wider than the question of what the PPC
port should do.  The linux-kernel@vger.kernel.org list is the
appropriate place to discuss this sort of thing.

One point to bear in mind is that Linux runs on a much wider range of
hardware than any of those research operating systems that you refer
to.  That does introduce a range of practical issues that those other
systems can just ignore.

> > 	1) Allocate some coherent memory specially (with
> > consistent_alloc() or pci_alloc_consistent()).  Once that's done it
> > can just be used, no further worries about consistency.
>
> This has nothing to do with consistency, it has to do with implementing
> the proper semantics for these functions.  Regardless of how the memory
> is allocated, there are pci mapping functions (pci_map_single(), pci_map_sg(),
> and so on) that are going to be handed an arbitrary virtual address and
> try to convert those into physical addresses for DMA.  In the case of
> non coherent processors, you can't simply subtract KERNELBASE from these
> addresses and get the proper physical address.

Then the driver is breaking the rules as laid down in DMA-mapping.txt.
You *don't* use pci_map_* on stuff you get from pci_alloc_consistent.
If you do you get to keep both pieces.  If you don't like the rules
then I suggest you take it up with Dave Miller.  The rules seem
perfectly sensible to me, they make an appropriate tradeoff between
functionality and complexity that works across a wide range of systems.

The PCI DMA API is designed so that drivers never need to translate
between virtual and physical addresses themselves.  Our API for local
peripherals on embedded chips should do the same.

> > Emphasis on the "sort of" here.  consistent_sync() does allocate the
> > memory specially, and returns the physical address to the caller.  I'm
> > talking about ordinary, everyday vmalloc()
>
> ...and if you call pci_map_sg() (or pci_map_single()) on this address,
> you won't get the right answer without using iopa().  Should drivers be

"Well don't do that then" :)  If you are calling pci_map_single on a
vmalloc'd address you are living dangerously even if virt_to_* does
use iopa, since vmalloc'd memory is not physically contiguous.

> doing this or are they doing it correctly?  I don't know, but I do know
> if they call these functions we better return the right answer.

Hitting a BUG() would be more appropriate in these cases.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
