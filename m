Date: Thu, 12 Sep 2002 13:26:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: consistent_free re-revisited
Message-ID: <20020912032640.GA32156@zax>
References: <3D7FB97B.9060301@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D7FB97B.9060301@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 11, 2002 at 02:45:31PM -0700, Todd Poynor wrote:
> The APIs for consistent_free have diverged between PPC and ARM.  It has,
> at least in the past, been a goal to keep the APIs in sync.

That's the least of our worries - the current consistent_alloc() is
badly broken.  It breaks the DMA-mapping.txt rules, because it can't
safely be called from interrupt context.  I think we need generic
changes (gfp masks to various functions) to fix this sanely.

It would be nice to have the same interface as ARM, though - on the
other hand the consistent_*() interface as such may be obsoleted by
unified device model interfaces: I believe per-bus consistent memory
interfaces are supposed to be in there.

> Revisiting this is prompted by a couple of new platforms recently added
> (Xilinx Virtex II Pro and IBM 405LP/Beech) that use consistent_alloc for
> framebuffers mmap'ed to X servers.  It would be nice (but is hardly a
> critical need) if consistent_alloc/free would set/clear the reserved bit
> on the struct page's allocated, such that the returned memory can be
> mmap'ed to userspace without the driver explicitly setting these bits, a
> la ARM.

I've thought about this before, but on the whole I don't think it's a
good idea.  I think setting VM_IO on the vma when it is mapped into
userspace is a better idea.

In PCI space, the assumption appears to be that PageReserved is *not*
set by pci_alloc_consistent() - a couple of the sound drivers assume
this, because they explicitly set and clear the Reserved bit when they
remap various DMA buffers.

Incidentally I think there are also cases where consistent_alloc()
(both ours and ARM's, IIRC) could leak memory if failures occur at
just the right point.

> On PPC this is complicated by the fact that consistent_free does not
> take a size parameter, describing the size of the allocated area, nor a
> dma_handle parameter, which ARM uses to derive struct page's.

Yes, on the other hand having a single "handle" on the memory in order
to free it is nice.

> Furthermore, consistent_alloc does not fill out vm_struct fields for the
> VM area that map it to the struct pages, so consistent_free can't use
> those to derive the physical pages.  And neither can vfree(), which is
> what consistent_free() calls to do its work.  And so consistent_free()
> does not free the physical pages allocated by consistent_alloc(), which
> is a potentially more serious matter (although I suppose consistent_free
> isn't normally in heavy use, but hi-res framebuffers can get large).

Erm... vfree() walks the page tables to find the pages to free, which
should work fine.

> Setting/clearing reserved bits and init'ing the vm_struct fields such
> that physical pages are reclaimed by vfree() can be accomplished without
> API changes, at the expense of intruding into private VM data structures
> and inefficiency of allocating an array of struct page pointers to
> describe a contiguous chunk of memory.  So it seems preferable to add
> the size and dma_handle params to consistent_free and do the physical
> page freeing there (and update the drivers that call it).  Comments?
> Thanks,
>
>

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
