Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnNkk3WCHzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 07:51:26 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5DLmT46072545
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 17:51:24 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b2pdcvmpw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 17:51:24 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 13 Jun 2017 15:51:23 -0600
Date: Tue, 13 Jun 2017 14:51:16 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com
Subject: Re: [RFC PATCH 1/7 v1]powerpc: Free up four PTE bits to accommodate
 memory keys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
 <1496711109-4968-2-git-send-email-linuxram@us.ibm.com>
 <877f0h3d7b.fsf@skywalker.in.ibm.com>
 <20170612222018.GA5524@ram.oc3035372033.ibm.com>
 <87zidc1w7j.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zidc1w7j.fsf@skywalker.in.ibm.com>
Message-Id: <20170613215116.GA5595@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 13, 2017 at 07:32:24AM +0530, Aneesh Kumar K.V wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > On Mon, Jun 12, 2017 at 12:27:44PM +0530, Aneesh Kumar K.V wrote:
> >> Ram Pai <linuxram@us.ibm.com> writes:
> >> 
> >> > Rearrange  PTE   bits to  free  up  bits 3, 4, 5  and  6  for
> >> > memory keys. Bit 3, 4, 5, 6 and 57  shall  be used for memory
> >> > keys.
> >> >
> >> > The patch does the following change to the 64K PTE format
> >> >
> >> > H_PAGE_BUSY moves from bit 3 to bit 7
> >> > H_PAGE_F_SECOND which occupied bit 4 moves to the second part
> >> > 	of the pte.
> >> > H_PAGE_F_GIX which  occupied bit 5, 6 and 7 also moves to the
> >> > 	second part of the pte.
> >> >
> >> > The second part of the PTE will hold
> >> >    a (H_PAGE_F_SECOND|H_PAGE_F_GIX)  for  64K page backed pte,
> >> >    and sixteen (H_PAGE_F_SECOND|H_PAGE_F_GIX)  for 4k  backed
> >> > 	pte.
> >> >
> >> > the four  bits((H_PAGE_F_SECOND|H_PAGE_F_GIX) that represent a slot
> >> > is initialized to 0xF indicating a invalid slot. if a hashpage does
> >> > get  allocated  to  the  0xF  slot, it is released and not used. In
> >> > other words, even  though  0xF  is  a valid slot we discard it  and
> >> > consider it as invalid slot(HPTE_SOFT_INVALID). This  gives  us  an
> >> > opportunity to  not  depend on a bit in the primary PTE in order to
> >> > determine the validity of a slot.
> >> 
> >> Do we need to do this for 64K hptes ? H_PAGE_HASHPTE indicates whether a
> >> slot is valid or not. For 4K hptes, we do need this right ? ie, only
> >> when H_PAGE_COMBO is set we need to consider 0xf as an invalid slot
> >
> > for 64k hptes; you are right, we do not use 0xF to
> > track the validity of a slot. We just depend on H_PAGE_HASHPTE flag.
> >
> > for 4k hptes, we need to depend on both H_PAGE_HASHPTE as well as the
> > value of the slot.  H_PAGE_HASHPTE tells if there exists any valid
> > 4k HPTEs, and the 4-bit values in the second-part-of-the-pte tells
> > us if they are valid values.
> >
> > However in either case we do not need H_PAGE_COMBO. That flag is not
> > used for ptes.  But we continue to use that flag for pmd to track
> > hugepages, which is why I have not entirely divorced H_PAGE_COMBO from
> > the 64K pagesize case.
> 
> 
> Really ? May be i am missing that in the patch. H_PAGE_COMBO indicate
> whether a 64K linux page is mapped via 4k hash page table enries. I
> don't see you changing that in __hash_page_4k()
> 
> we still continue to do.
> 
> 		new_pte = old_pte | H_PAGE_BUSY | _PAGE_ACCESSED | H_PAGE_COMBO;
> 
> 	/*
> 	 * Check if the pte was already inserted into the hash table
> 	 * as a 64k HW page, and invalidate the 64k HPTE if so.
> 	 */
> 	if (!(old_pte & H_PAGE_COMBO)) {
> 		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
> 

ok. my memory blanked.  In this patch We continue to depend on COMBO
flag to distinguish between pte's backed by 4k hpte and 64k hpte. So
H_PAGE_COMBO flag cannot go for now in this patch.  Which means
_PAGE_HPTEFLAGS must continue to have the H_PAGE_COMBO flag too.

I had a patch to get rid of the COMBO bit too, which was dropped.  Will
regenerate a separate patch to rid the COMBO bit in __hash_page_4k().
That will divorse the COMBO bit entirely from 64K pte.

> 
> 
> >
> >> 
> >> 
> >> >
> >> > When  we  release  a  0xF slot we also release a legitimate primary
> >> > slot  and  unmap  that  entry. This  is  to  ensure  that we do get
> >> > a legimate non-0xF slot the next time we retry for a slot.
> >> 
> >> Can you explain this more ? what is a primary slot here ?
> >
> > I may not be using the right terminology here. But when I say slot, i
> > mean the four bits that tell the position of the hpte in the hash
> > buckets. Bit 0, indicates if it the primary or secondary hash bucket.
> > and bit 1,2,3 indicates the entry in the hash bucket.
> >
> > So when i say primary slot, I mean a entry in the primary hash bucket.
> >
> > The idea is, when hpte_insert returns a hpte which is cached in the 7slot
> > of the secondary bucket i.e 0xF, we discard it, and also release a
> > random entry from the primary bucket, so that on retry we can get that
> > entry.
> >
> >
> >> 
> >> >
> >> > Though treating 0xF slot as invalid reduces the number of available
> >> > slots and make have a effect on the performance, the probabilty
> >> > of hitting a 0xF is extermely low.
> >> >
> >> > Compared  to the current scheme, the above described scheme reduces
> >> > the number of false hash table updates  significantly  and  has the
> >> > added  advantage  of  releasing  four  valuable  PTE bits for other
> >> > purpose.
> >> >
> >> > This idea was jointly developed by Paul Mackerras, Aneesh, Michael
> >> > Ellermen and myself.
> >> >
> >> > 4K PTE format remain unchanged currently.
> >> >
> >> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> >> > ---
> >> >  arch/powerpc/include/asm/book3s/64/hash-4k.h  | 12 +++++
> >> >  arch/powerpc/include/asm/book3s/64/hash-64k.h | 38 ++++++--------
> >> >  arch/powerpc/include/asm/book3s/64/hash.h     |  8 ++-
> >> >  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  5 ++
> >> >  arch/powerpc/mm/dump_linuxpagetables.c        |  3 +-
> >> >  arch/powerpc/mm/hash64_4k.c                   | 12 ++---
> >> >  arch/powerpc/mm/hash64_64k.c                  | 73 +++++++++------------------
> >> >  arch/powerpc/mm/hash_utils_64.c               | 38 +++++++++++++-
> >> >  arch/powerpc/mm/hugetlbpage-hash64.c          | 16 +++---
> >> >  9 files changed, 107 insertions(+), 98 deletions(-)
> >> >
> >> > diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> >> > index b4b5e6b..223d318 100644
> >> > --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> >> > +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> >> > @@ -16,6 +16,18 @@
> >> >  #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << H_PUD_INDEX_SIZE)
> >> >  #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << H_PGD_INDEX_SIZE)
> >> >
> >> > +
> >> > +/*
> >> > + * Only supported by 4k linux page size
> >> 
> >> that comment is confusing, you can drop that, it is part of hash-4k.h
> >> which means these defines are local to 4k linux page size config.
> >> 
> >> > + */
> >
> > right. ok.
> >
> >> > +#define H_PAGE_F_SECOND        _RPAGE_RSV2     /* HPTE is in 2ndary HPTEG */
> >> > +#define H_PAGE_F_GIX           (_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
> >> > +#define H_PAGE_F_GIX_SHIFT     56
> >> > +
> >> > +#define H_PAGE_BUSY	_RPAGE_RSV1     /* software: PTE & hash are busy */
> >> > +#define H_PAGE_HASHPTE	_RPAGE_RPN43    /* PTE has associated HPTE */
> >> > +
> >> > +
> >> >  /* PTE flags to conserve for HPTE identification */
> >> >  #define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | \
> >> >  			 H_PAGE_F_SECOND | H_PAGE_F_GIX)
> >> > diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> >> > index 9732837..87ee22d 100644
> >> > --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> >> > +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> >> > @@ -10,23 +10,21 @@
> >> >   * 64k aligned address free up few of the lower bits of RPN for us
> >> >   * We steal that here. For more deatils look at pte_pfn/pfn_pte()
> >> >   */
> >> > -#define H_PAGE_COMBO	_RPAGE_RPN0 /* this is a combo 4k page */
> >> > -#define H_PAGE_4K_PFN	_RPAGE_RPN1 /* PFN is for a single 4k page */
> >> > +#define H_PAGE_COMBO   _RPAGE_RPN0 /* this is a combo 4k page */
> >> > +#define H_PAGE_4K_PFN  _RPAGE_RPN1 /* PFN is for a single 4k page */
> >> > +
> >> > +#define H_PAGE_BUSY	_RPAGE_RPN44     /* software: PTE & hash are busy */
> >> > +#define H_PAGE_HASHPTE	_RPAGE_RPN43    /* PTE has associated HPTE */
> >> > +
> >> >  /*
> >> >   * We need to differentiate between explicit huge page and THP huge
> >> >   * page, since THP huge page also need to track real subpage details
> >> >   */
> >> >  #define H_PAGE_THP_HUGE  H_PAGE_4K_PFN
> >> >
> >> > -/*
> >> > - * Used to track subpage group valid if H_PAGE_COMBO is set
> >> > - * This overloads H_PAGE_F_GIX and H_PAGE_F_SECOND
> >> > - */
> >> > -#define H_PAGE_COMBO_VALID	(H_PAGE_F_GIX | H_PAGE_F_SECOND)
> >> > -
> >> >  /* PTE flags to conserve for HPTE identification */
> >> > -#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_F_SECOND | \
> >> > -			 H_PAGE_F_GIX | H_PAGE_HASHPTE | H_PAGE_COMBO)
> >> > +#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE)
> >> > +
> >> 
> >> You drop H_PAGE_COMBO here. Is that intentional ?
> >
> > Yes. that is intentional. See a downside?  We dont depend on
> > H_PAGE_COMBO for 64K pagesize PTE anymore.
> >
> >> 
> >> We have code which does
> >> 
> >> 		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
> >> 					       MMU_PAGE_64K, ssize,
> >> 					       flags) == -1)
> >> 			old_pte &= ~_PAGE_HPTEFLAGS;
> >> 	
> >> 
> >> I guess they expect slot details to be cleared. With the above
> >> _PAGE_HPTEFLAGS that is not true.
> >
> > since we dont depend on COMBO flag, it should be fine. Let me know if
> > you see a downside.
> >
> >> 
> >> 
> >> >  /*
> >> >   * we support 16 fragments per PTE page of 64K size.
> >> >   */
> >> > @@ -54,24 +52,18 @@ static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
> >> >  	unsigned long *hidxp;
> >> >
> >> >  	rpte.pte = pte;
> >> > -	rpte.hidx = 0;
> >> > -	if (pte_val(pte) & H_PAGE_COMBO) {
> >> > -		/*
> >> > -		 * Make sure we order the hidx load against the H_PAGE_COMBO
> >> > -		 * check. The store side ordering is done in __hash_page_4K
> >> > -		 */
> >> > -		smp_rmb();
> >> > -		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> >> > -		rpte.hidx = *hidxp;
> >> > -	}
> >> > +	/*
> >> > +	 * The store side ordering is done in __hash_page_4K
> >> > +	 */
> >> > +	smp_rmb();
> >> > +	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> >> > +	rpte.hidx = *hidxp;
> >> >  	return rpte;
> >> >  }
> >> >
> >> >  static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
> >> >  {
> >> > -	if ((pte_val(rpte.pte) & H_PAGE_COMBO))
> >> > -		return (rpte.hidx >> (index<<2)) & 0xf;
> >> > -	return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
> >> > +	return ((rpte.hidx >> (index<<2)) & 0xfUL);
> >> >  }
> >> >
> >> >  #define __rpte_to_pte(r)	((r).pte)
> >> > diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> >> > index 4e957b0..7742782 100644
> >> > --- a/arch/powerpc/include/asm/book3s/64/hash.h
> >> > +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> >> > @@ -8,11 +8,9 @@
> >> >   *
> >> >   */
> >> >  #define H_PTE_NONE_MASK		_PAGE_HPTEFLAGS
> >> > -#define H_PAGE_F_GIX_SHIFT	56
> >> > -#define H_PAGE_BUSY		_RPAGE_RSV1 /* software: PTE & hash are busy */
> >> > -#define H_PAGE_F_SECOND		_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
> >> > -#define H_PAGE_F_GIX		(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
> >> > -#define H_PAGE_HASHPTE		_RPAGE_RPN43	/* PTE has associated HPTE */
> >> > +
> >> > +#define INIT_HIDX (~0x0UL)
> >> 
> >> But then you use it like
> >> 
> >> 	rpte.hidx = INIT_HIDX;
> >> 
> >> A better would be INIT_HIDX = 0xF ?. Also may be INIT is the wrong name
> >> there ?
> >
> > No. We are initializing all the entries in the second-part-of-the-pte to
> > 0xF. which essentially boils down to ~0x0UL.
> 
> that you unsigned long casting is what i was suggesting to remove. We
> may want to treat it as a 4 bits every where  ?
> 
> 
> >
> >> 
> >> > +#define HPTE_SOFT_INVALID(slot) ((slot & 0xfUL) == 0xfUL)
> >> 
> >> Can you do that as a static inline ?
> >
> > ok.
> >
> >> 
> >> >
> >> >  #ifdef CONFIG_PPC_64K_PAGES
> >> >  #include <asm/book3s/64/hash-64k.h>
> >> > diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> >> > index 6981a52..cfb8169 100644
> >> > --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> >> > +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> >> > @@ -435,6 +435,11 @@ extern int __hash_page_4K(unsigned long ea, unsigned long access,
> >> >  extern int __hash_page_64K(unsigned long ea, unsigned long access,
> >> >  			   unsigned long vsid, pte_t *ptep, unsigned long trap,
> >> >  			   unsigned long flags, int ssize);
> >> > +extern unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
> >> > +			unsigned int subpg_index, unsigned long slot);
> >> > +extern unsigned long get_hidx_slot(unsigned long vpn, unsigned long shift,
> >> > +			int ssize, real_pte_t rpte, unsigned int subpg_index);
> >> > +
> >> >  struct mm_struct;
> >> >  unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap);
> >> >  extern int hash_page_mm(struct mm_struct *mm, unsigned long ea,
> >> > diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
> >> > index 44fe483..b832ed3 100644
> >> > --- a/arch/powerpc/mm/dump_linuxpagetables.c
> >> > +++ b/arch/powerpc/mm/dump_linuxpagetables.c
> >> > @@ -213,7 +213,7 @@ struct flag_info {
> >> >  		.val	= H_PAGE_4K_PFN,
> >> >  		.set	= "4K_pfn",
> >> >  	}, {
> >> > -#endif
> >> > +#else
> >> >  		.mask	= H_PAGE_F_GIX,
> >> >  		.val	= H_PAGE_F_GIX,
> >> >  		.set	= "f_gix",
> >> > @@ -224,6 +224,7 @@ struct flag_info {
> >> >  		.val	= H_PAGE_F_SECOND,
> >> >  		.set	= "f_second",
> >> >  	}, {
> >> > +#endif /* CONFIG_PPC_64K_PAGES */
> >> >  #endif
> >> >  		.mask	= _PAGE_SPECIAL,
> >> >  		.val	= _PAGE_SPECIAL,
> >> > diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
> >> > index 6fa450c..5b16416 100644
> >> > --- a/arch/powerpc/mm/hash64_4k.c
> >> > +++ b/arch/powerpc/mm/hash64_4k.c
> >> > @@ -20,6 +20,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >> >  		   pte_t *ptep, unsigned long trap, unsigned long flags,
> >> >  		   int ssize, int subpg_prot)
> >> >  {
> >> > +	real_pte_t rpte;
> >> >  	unsigned long hpte_group;
> >> >  	unsigned long rflags, pa;
> >> >  	unsigned long old_pte, new_pte;
> >> > @@ -54,6 +55,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >> >  	 * need to add in 0x1 if it's a read-only user page
> >> >  	 */
> >> >  	rflags = htab_convert_pte_flags(new_pte);
> >> > +	rpte = __real_pte(__pte(old_pte), ptep);
> >> >
> >> >  	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
> >> >  	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> >> > @@ -64,12 +66,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >> >  		/*
> >> >  		 * There MIGHT be an HPTE for this pte
> >> >  		 */
> >> > -		hash = hpt_hash(vpn, shift, ssize);
> >> > -		if (old_pte & H_PAGE_F_SECOND)
> >> > -			hash = ~hash;
> >> > -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> >> > -		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
> >> > -
> >> > +		slot = get_hidx_slot(vpn, shift, ssize, rpte, 0);
> >> 
> >> 
> >> This confused me, the rest of the code assume slot as the 4 bit value.
> >> But get_hidx_slot is not exactly returning that.
> >
> > get_hidx_slot() is returning a 4bit value. no?
> 
> It is not
> unsigned long get_hidx_slot(unsigned long vpn, unsigned long shift,
> 			int ssize, real_pte_t rpte, unsigned int subpg_index)
> {
> 	unsigned long hash, slot, hidx;
> 
> 	hash = hpt_hash(vpn, shift, ssize);
> 	hidx = __rpte_to_hidx(rpte, subpg_index);
> 	if (hidx & _PTEIDX_SECONDARY)
> 		hash = ~hash;
> 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> 	slot += hidx & _PTEIDX_GROUP_IX;
> 	return slot;
> }

Actually the piece of redundant code has been captured into a function
and called from multiple places.  there is  no logic changes. It just
re-arrangement of code. I think your confusion is derived from the
naming of the function. Will rename it to  get_hidx_slot_offset(),
better?


Thanks for your comments, will be sending out a new v2 version soon.

RP
> 
> -aneesh
