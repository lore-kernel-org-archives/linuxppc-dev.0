Date: Wed, 12 Jun 2002 16:43:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
Message-ID: <20020612064344.GT25800@zax>
References: <20020531042153.GD16537@zax> <3CFC0D3F.9030901@embeddededge.com> <20020604035947.GH2762@zax> <3CFCFC20.80101@embeddededge.com> <15614.37065.549142.218906@argo.ozlabs.ibm.com> <3CFEE9A3.5060300@embeddededge.com> <15614.63160.272890.683586@argo.ozlabs.ibm.com> <3CFF1624.2070808@embeddededge.com> <20020612035203.GQ25800@zax> <3D06E702.4000709@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D06E702.4000709@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 12, 2002 at 02:15:30AM -0400, Dan Malek wrote:
> David Gibson wrote:
>
> >So what happened to the idea?
>
> Never got implemented, I guess.  Lots of things are discussed that
> people just don't have time to do.

Heh, so instead we got a half-assed re-implementation (with a whole
bunch of extraneous pointless crap) in the form of the OCP layer.

> >That isn't of itself an argument.  I haven't yet seen a case where
> >extending virt_to_phys() to non-lowmem addresses is useful.  In any
> >case I've so far thought of there are other considerations which make
> >the benefits of having a common interface illusory.
>
> Let's just say it's nice to have designs that have common functional
> interfaces.  The Linux VM is one old hack on top of another, and inserting
> something like iopa() under virt_to_* is just the same.  As systems and
> memory sizes grew, the functions to support them didn't for a variety of
> reasons.  These problems have all been nicely solved long ago, and some
> of us were around back then to appreciate the nice solutions :-)

So you keep saying, but I haven't seen you give a real example yet.

> >Not only is that wrong, it's bloody obviously wrong.  How could we
> >create a new virtual mapping without knowing the physical addresses
> >first.
>
> Oh, cool down and just think about this for a moment.  All of this was
> done to support noncoherent caches where we allocate some VM space to
> remap pages with different cache attributes.  Everything that does
> DMA expects to use virt_to_* functions to find the physical address.
> Of course we know the physical address, but functions using the standard
> pci_consistent_* don't know them.  To support PCI on noncoherent cache
> processors you have to be able to find the physical address from the
> virtual one, and just an arithmetic operation on the virtual address
> won't work on these processors.  It's just the way these functions are
> designed to work in Linux.  It's obviously the only way to make it work
> with the way the higher level functions are designed.

No.

I think confusion is coming from the fact that there are two
approaches to handling DMA on non-cache-coherent processors (each
appropriate for different circumstances).
	1) Allocate some coherent memory specially (with
consistent_alloc() or pci_alloc_consistent()).  Once that's done it
can just be used, no further worries about consistency.
	2) Get "ordinary" (but cacheline aligned) memory (say from
some other part of the kernel, like an skb) and frob it as appropriate
- i.e. flush and/or invalidate the cache and possibly mess with an
IOMMU - before/after we initiate the transfer (with consistent_sync()
or pci_map_single()).

For any given chunk of memory only one of these approaches will be in
use - consistent_sync() should never be called on memory allocated
with consistent_alloc(), there would be no point.  Likewise if we use
pci_alloc_consistent() there will be no need to call pci_map_single().

Now, in case (1) we have to find out the physical address in order to
allocate the buffer and create the uncache mapping in any case, so we
can (and do) stash away the physical address at the time of
allocation.  No iopa() needed.

In case (2) the memory will probably be coming from kmalloc() or
(rarely) a static buffer.  I can't see any useful case where it won't
be in the kernel's normal mapping of system RAM (since memory from
vmalloc() wouldn't be any good anyway).  So, again, no iopa() is
necessary.

> >..... We
> >can't use vmalloc()ed memory anyway, because it wouldn't be physically
> >contiguous.
>
> Ummmm....we do use vmalloc()'ed (sort of) memory anyway.  We grab a set
> of physical pages and then map them to a new vm_area.  Just what vmalloc()
> does, except we do it so it is contiguous.

Emphasis on the "sort of" here.  consistent_sync() does allocate the
memory specially, and returns the physical address to the caller.  I'm
talking about ordinary, everyday vmalloc().

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
