Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B78E61A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 18:59:36 +1000 (AEST)
Message-ID: <1437814770.8513.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Fix pte_pagesize_index() crash on 4K w/64K
 hash
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 cyrilbur@gmail.com
Date: Sat, 25 Jul 2015 18:59:30 +1000
In-Reply-To: <87si8eyrxh.fsf@linux.vnet.ibm.com>
References: <1437715135-5131-1-git-send-email-mpe@ellerman.id.au>
 <87si8eyrxh.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-24 at 12:15 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > The powerpc kernel can be built to have either a 4K PAGE_SIZE or a 64K
> > PAGE_SIZE.
...
> > diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> > index 3bb7488bd24b..330ae1d81662 100644
> > --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> > +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> > @@ -135,7 +135,15 @@
> >  #define pte_iterate_hashed_end() } while(0)
> >  
> >  #ifdef CONFIG_PPC_HAS_HASH_64K
> > -#define pte_pagesize_index(mm, addr, pte)	get_slice_psize(mm, addr)
> > +#define pte_pagesize_index(mm, addr, pte)			\
> > +	({							\
> > +		unsigned int psize;				\
> > +		if (is_kernel_addr(addr))			\
> > +			psize = MMU_PAGE_4K;			\
> > +		else						\
> > +			psize = get_slice_psize(mm, addr);	\
> > +		psize;						\
> > +	})
> >  #else
> >  #define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
> >  #endif
> 
> That is confusing, because we enable PPC_HASH_HAS_64K for 64K page size
> too. 

We do, but in that case we get the definition in pte-hash64-64k.h which is:

  #define pte_pagesize_index(mm, addr, pte)	\
	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)

> why not
> psize = mmu_virtual_psize;


Maybe. Though I think actually mmu_io_psize would be correct. But none of the
other versions of the macro use the mmu_xx_psize variables they all use the
MMU_PAGE_xx #defines. So basically I just aped those.

Hopefully Ben can chime in, he wrote it originally.

> But that leave another question. What if kernel address used 16MB
> mapping ? Or are we going to get a call for pte_pagesize_index, only for
> vmalloc area of the kernel ?

Not sure. I can't see any guarantee of that. I guess we don't map/unmap the
linear mapping, so possibly we're just getting away with it? And looks like
DEBUG_PAGEALLOC doesn't hit it.

> In any case, this need more comment explaining the caller and possibly
> DEBUG_VM WARN_ON() to catch wrong users ?

My plan is actually to drop support for 64K hash with 4K PAGE_SIZE as soon as
we've fixed this. I just didn't want to remove the code in a known broken state
when we knew how to fix it.

When we drop that support we'll just end up with two versions for 64K and 4K
respectively:

 #define pte_pagesize_index(mm, addr, pte)	\
	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)

 #define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K


And given it's only used in one function I'd be inclined to just open code it,
or at the very least move the macro into tlb_hash64.c

cheers
