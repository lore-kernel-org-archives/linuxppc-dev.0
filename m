Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E1CEDEA47
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 04:41:32 +1100 (EST)
Subject: Re: [PATCH 1/3] powerpc: dma code cleanup
From: Remi Machet <rmachet@slac.stanford.edu>
To: benh@kernel.crashing.org
In-Reply-To: <1223414534.8157.63.camel@pasglop>
References: <1223413504.17585.28.camel@pcds-ts102.slac.stanford.edu>
	<1223414534.8157.63.camel@pasglop>
Content-Type: text/plain
Date: Thu, 09 Oct 2008 10:41:06 -0700
Message-Id: <1223574067.22565.24.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-08 at 08:22 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2008-10-07 at 14:05 -0700, Remi Machet wrote:
> > +       /*
> > +        * Mark the pages as Reserved: this memory is used by a DMA
> > engine,
> > +        * it cannot be swapped.
> > +        * Also mark each page as un-cached. We ass ume here that a
> > PTE
> > +        * already exist (valid assumption for the DMA Zone)
> > +        */
> > +       for (addr = kaddr, p = page; addr < kaddr+size;
> > +                       addr += PAGE_SIZE, p++) {
> > +               pte_t *pte;
> > +               spinlock_t *ptl;
> > +
> > +               SetPageReserved(p);
> > +               pte = get_locked_pte(&init_mm, addr, &ptl);
> > +               set_pte_at(&init_mm, addr,
> > +                       pte, mk_pte(p,
> > pgprot_noncached(PAGE_KERNEL)));
> > +               pte_unmap_unlock(pte, ptl);
> > +       }
> > +       flush_tlb_kernel_range(kaddr, kaddr+size-1);
> > +
> 
> There are a few problems with the above approach:
> 
>  - Avoid SetPageReserved. It's not useful. Kernel memory doesn't
> get swapped, and if you happen to map it into userspace, it's up
> to that mapping to have the right attributes to prevent that.
> 
>  - Setting the PTE to non-cached will not work for a whole bunch of
> things. The kernel linear mapping is often mapped using large bolted TLB
> entries. For example, on 44x, if you page is in the bottom 768M, it will
> be mapped using a bolted 256M cacheable TLB entry and you may not even
> have a PTE for it. kmap will not help
Do you know of any powerpc architecture where the DMA engine accessible
address space is limited?

The old dma-noncoherent code had some convoluted code to decide whether
or not it should add GFP_DMA to the list of flags in dma_alloc_coherent:

	u64 mask = 0x00ffffff, limit; /* ISA default */
	...
	limit = (mask + 1) & ~mask;
	if ((limit && size >= limit) || size >= (CONSISTENT_END - CONSISTENT_BASE)) {
		printk(KERN_WARNING "coherent allocation too big (requested %#x mask %#Lx)\n",
		       size, mask);
		return NULL;
	}
	...
	if (mask != 0xffffffff)
		gfp |= GFP_DMA;


Since mask is forced to 0x00ffffff, GFP_DMA is always added ... should I
just add it too or leave that to the caller of dma_alloc_coherent? (I
would personally rather leave that to the caller but it may break some
driver).

Remi
