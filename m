Message-ID: <3D07D80F.9050306@embeddededge.com>
Date: Wed, 12 Jun 2002 19:23:59 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
References: <20020531042153.GD16537@zax> <3CFC0D3F.9030901@embeddededge.com> <20020604035947.GH2762@zax> <3CFCFC20.80101@embeddededge.com> <15614.37065.549142.218906@argo.ozlabs.ibm.com> <3CFEE9A3.5060300@embeddededge.com> <15614.63160.272890.683586@argo.ozlabs.ibm.com> <3CFF1624.2070808@embeddededge.com> <20020612035203.GQ25800@zax> <3D06E702.4000709@embeddededge.com> <20020612064344.GT25800@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:


> Heh, so instead we got a half-assed re-implementation (with a whole
> bunch of extraneous pointless crap) in the form of the OCP layer.

Not exactly.  The OCP implementation was an attempt to provide a
software model that matched the way Blue Logic peripherals were
integrated into packages.  Sort of a "better" approach to the way
I implemented the 8xx drivers.  The resource trees are just a
representation of reasonable configuration information that is useful
to any driver implementation.  We couldn't decide what "reasonable"
information would be :-)

> So you keep saying, but I haven't seen you give a real example yet.

You are fortunate to work for one of the companies that have successfully
deployed commercial operating systems and have a variety of research
operating systems that implement and demonstrate some very nice
resource management methods.  I would suggest you spend some time learning
about these, and then maybe you would have some clue about what I'm
trying to describe.

Long ago, modern operating systems abstracted much of the VM implementation
away from the drivers.  The most useful example would be for us to use
an I/O vector triplet {physaddr, offset, length} in a driver for any DMA
or other physical address operation.  Drivers shouldn't care how memory
mapping is implemented, they should be given information about a VM address
range that is suitable for them to perform DMA.  This way, we don't have
one implementation for low memory drivers, yet another thing for high
memory bounce buffers, and who knows, maybe someday we will have a direct I/O
capability or even DMA from user space (like other operating systems have
for years) without having to hack up a driver yet again.  These concepts
were working on production systems long before Linux was started, and your
company has great examples of this.


> I think confusion is coming from the fact that there are two
> approaches to handling DMA on non-cache-coherent processors (each
> appropriate for different circumstances).

You are the only person confused and I don't know why you want to
keep arguing with me.

> 	1) Allocate some coherent memory specially (with
> consistent_alloc() or pci_alloc_consistent()).  Once that's done it
> can just be used, no further worries about consistency.

This has nothing to do with consistency, it has to do with implementing
the proper semantics for these functions.  Regardless of how the memory
is allocated, there are pci mapping functions (pci_map_single(), pci_map_sg(),
and so on) that are going to be handed an arbitrary virtual address and
try to convert those into physical addresses for DMA.  In the case of
non coherent processors, you can't simply subtract KERNELBASE from these
addresses and get the proper physical address.


> Emphasis on the "sort of" here.  consistent_sync() does allocate the
> memory specially, and returns the physical address to the caller.  I'm
> talking about ordinary, everyday vmalloc()

...and if you call pci_map_sg() (or pci_map_single()) on this address,
you won't get the right answer without using iopa().  Should drivers be
doing this or are they doing it correctly?  I don't know, but I do know
if they call these functions we better return the right answer.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
