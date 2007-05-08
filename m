Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D094DDDE4
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 07:17:40 +1000 (EST)
Subject: Re: [PATCH 5/5] powerpc: Don't use SLAB/SLUB for PTE pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
In-Reply-To: <Pine.LNX.4.64.0705082035430.17227@blonde.wat.veritas.com>
References: <20070508062750.A5CBBDDE42@ozlabs.org>
	<Pine.LNX.4.64.0705082035430.17227@blonde.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 09 May 2007 07:17:30 +1000
Message-Id: <1178659050.14928.78.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-08 at 20:50 +0100, Hugh Dickins wrote:
> On Tue, 8 May 2007, Benjamin Herrenschmidt wrote:
> > From: Hugh Dickins <hugh@veritas.com>
> > 
> > The SLUB allocator relies on struct page fields first_page and slab,
> > overwritten by ptl when SPLIT_PTLOCK: so the SLUB allocator cannot then
> > be used for the lowest level of pagetable pages.  This was obstructing
> > SLUB on PowerPC, which uses kmem_caches for its pagetables.  So convert
> > its pte level to use normal gfp pages (whereas pmd, pud and 64k-page pgd
> > want partpages, so continue to use kmem_caches for pmd, pud and pgd).
> > 
> > Signed-off-by: Hugh Dickins <hugh@veritas.com>
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> 
> Looks and runs fine for me (though would have seemed nicer to use
> __GFP_ZERO than clear_page - or does that subvert your fast zeroing?).

Nah, you are right, I'll respin. Forgot about __GFP_ZERO. It just called
clear_highpage on the returned pages right ? This is the same as calling
clear_page from my code.

> But you also need to undo the ARCH_USES_SLAB_PAGE_STRUCT from
> arch/powerpc/Kconfig now that's gone into Linus' tree: patch
> I added in testing below (either append to this one or add a 6/5).

I was thinking about adding a new patch.

> For some people that interim disablement was working, for other
> people it wasn't: mysterious, and the sooner it's got rid of the
> better.  I'm sorry to find that oldconfig doesn't actually offer
> the SLAB or SLUB menu (to me anyway) when moving from SLUB disabled
> to SLUB enabled: so again, the sooner we get rid of that interim
> disablement the better for SLUB exposure.

Ok. I'll post a new patch along with the final serie after I've done some
testing later today.

Cheers,
Ben.
