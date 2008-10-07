Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57B26DDF13
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 09:11:32 +1100 (EST)
Subject: Re: [PATCH 1/3] powerpc: dma code cleanup
From: Remi Machet <rmachet@slac.stanford.edu>
To: benh@kernel.crashing.org
In-Reply-To: <1223414534.8157.63.camel@pasglop>
References: <1223413504.17585.28.camel@pcds-ts102.slac.stanford.edu>
	<1223414534.8157.63.camel@pasglop>
Content-Type: text/plain
Date: Tue, 07 Oct 2008 15:11:27 -0700
Message-Id: <1223417488.17585.46.camel@pcds-ts102.slac.stanford.edu>
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
Yes I see the problem. I will try to rewrite that part using the vmalloc
pool.

> 
>  - You are potentially creating a lot of permanently kmap'ed memory. But
> the kmap pool might get exhausted... bad.
This will disappear since I am going to use the vmalloc pool but out of
curiosity: calling kmap should not result in any virtual memory from the
kmap pool being used unless the allocated page is in high memory. Do you
expect many driver to call dma_alloc with GFP_HIGHMEM?

Thanks!

Remi
