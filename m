Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3F12DDEF4
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 08:22:21 +1100 (EST)
Subject: Re: [PATCH 1/3] powerpc: dma code cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Remi Machet <rmachet@slac.stanford.edu>
In-Reply-To: <1223413504.17585.28.camel@pcds-ts102.slac.stanford.edu>
References: <1223413504.17585.28.camel@pcds-ts102.slac.stanford.edu>
Content-Type: text/plain
Date: Wed, 08 Oct 2008 08:22:14 +1100
Message-Id: <1223414534.8157.63.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-07 at 14:05 -0700, Remi Machet wrote:
> +       /*
> +        * Mark the pages as Reserved: this memory is used by a DMA
> engine,
> +        * it cannot be swapped.
> +        * Also mark each page as un-cached. We ass ume here that a
> PTE
> +        * already exist (valid assumption for the DMA Zone)
> +        */
> +       for (addr = kaddr, p = page; addr < kaddr+size;
> +                       addr += PAGE_SIZE, p++) {
> +               pte_t *pte;
> +               spinlock_t *ptl;
> +
> +               SetPageReserved(p);
> +               pte = get_locked_pte(&init_mm, addr, &ptl);
> +               set_pte_at(&init_mm, addr,
> +                       pte, mk_pte(p,
> pgprot_noncached(PAGE_KERNEL)));
> +               pte_unmap_unlock(pte, ptl);
> +       }
> +       flush_tlb_kernel_range(kaddr, kaddr+size-1);
> +

There are a few problems with the above approach:

 - Avoid SetPageReserved. It's not useful. Kernel memory doesn't
get swapped, and if you happen to map it into userspace, it's up
to that mapping to have the right attributes to prevent that.

 - Setting the PTE to non-cached will not work for a whole bunch of
things. The kernel linear mapping is often mapped using large bolted TLB
entries. For example, on 44x, if you page is in the bottom 768M, it will
be mapped using a bolted 256M cacheable TLB entry and you may not even
have a PTE for it. kmap will not help

 - You are potentially creating a lot of permanently kmap'ed memory. But
the kmap pool might get exhausted... bad.

I would suggest instead:

 - Keep using a separate virtual mapping

 - But instead of using your own allocator, just use the vmalloc/ioremap
one. You can either continue using a specific virtual address range, or
just use the main "pool" of ioremap / vmalloc, I don't see why you
couldn't do the later in fact.

That doesn't solve the potential issue of having the double mapping of
some memory both cacheable and non cacheable, but that's life. We deal
with it on 440 by having guarded, essentially preventing any prefetch
from getting in the way.

Cheers,
Ben.
