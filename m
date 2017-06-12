Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmnQh0zWFzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 08:20:27 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5CMIWHN027020
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 18:20:25 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b23gr09ty-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 18:20:25 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 12 Jun 2017 16:20:24 -0600
Date: Mon, 12 Jun 2017 15:20:18 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877f0h3d7b.fsf@skywalker.in.ibm.com>
Message-Id: <20170612222018.GA5524@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 12, 2017 at 12:27:44PM +0530, Aneesh Kumar K.V wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > Rearrange  PTE   bits to  free  up  bits 3, 4, 5  and  6  for
> > memory keys. Bit 3, 4, 5, 6 and 57  shall  be used for memory
> > keys.
> >
> > The patch does the following change to the 64K PTE format
> >
> > H_PAGE_BUSY moves from bit 3 to bit 7
> > H_PAGE_F_SECOND which occupied bit 4 moves to the second part
> > 	of the pte.
> > H_PAGE_F_GIX which  occupied bit 5, 6 and 7 also moves to the
> > 	second part of the pte.
> >
> > The second part of the PTE will hold
> >    a (H_PAGE_F_SECOND|H_PAGE_F_GIX)  for  64K page backed pte,
> >    and sixteen (H_PAGE_F_SECOND|H_PAGE_F_GIX)  for 4k  backed
> > 	pte.
> >
> > the four  bits((H_PAGE_F_SECOND|H_PAGE_F_GIX) that represent a slot
> > is initialized to 0xF indicating a invalid slot. if a hashpage does
> > get  allocated  to  the  0xF  slot, it is released and not used. In
> > other words, even  though  0xF  is  a valid slot we discard it  and
> > consider it as invalid slot(HPTE_SOFT_INVALID). This  gives  us  an
> > opportunity to  not  depend on a bit in the primary PTE in order to
> > determine the validity of a slot.
> 
> Do we need to do this for 64K hptes ? H_PAGE_HASHPTE indicates whether a
> slot is valid or not. For 4K hptes, we do need this right ? ie, only
> when H_PAGE_COMBO is set we need to consider 0xf as an invalid slot

for 64k hptes; you are right, we do not use 0xF to
track the validity of a slot. We just depend on H_PAGE_HASHPTE flag.

for 4k hptes, we need to depend on both H_PAGE_HASHPTE as well as the
value of the slot.  H_PAGE_HASHPTE tells if there exists any valid
4k HPTEs, and the 4-bit values in the second-part-of-the-pte tells
us if they are valid values.

However in either case we do not need H_PAGE_COMBO. That flag is not
used for ptes.  But we continue to use that flag for pmd to track
hugepages, which is why I have not entirely divorced H_PAGE_COMBO from
the 64K pagesize case.

> 
> 
> >
> > When  we  release  a  0xF slot we also release a legitimate primary
> > slot  and  unmap  that  entry. This  is  to  ensure  that we do get
> > a legimate non-0xF slot the next time we retry for a slot.
> 
> Can you explain this more ? what is a primary slot here ?

I may not be using the right terminology here. But when I say slot, i
mean the four bits that tell the position of the hpte in the hash
buckets. Bit 0, indicates if it the primary or secondary hash bucket.
and bit 1,2,3 indicates the entry in the hash bucket.

So when i say primary slot, I mean a entry in the primary hash bucket.

The idea is, when hpte_insert returns a hpte which is cached in the 7slot
of the secondary bucket i.e 0xF, we discard it, and also release a
random entry from the primary bucket, so that on retry we can get that
entry.


> 
> >
> > Though treating 0xF slot as invalid reduces the number of available
> > slots and make have a effect on the performance, the probabilty
> > of hitting a 0xF is extermely low.
> >
> > Compared  to the current scheme, the above described scheme reduces
> > the number of false hash table updates  significantly  and  has the
> > added  advantage  of  releasing  four  valuable  PTE bits for other
> > purpose.
> >
> > This idea was jointly developed by Paul Mackerras, Aneesh, Michael
> > Ellermen and myself.
> >
> > 4K PTE format remain unchanged currently.
> >
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/book3s/64/hash-4k.h  | 12 +++++
> >  arch/powerpc/include/asm/book3s/64/hash-64k.h | 38 ++++++--------
> >  arch/powerpc/include/asm/book3s/64/hash.h     |  8 ++-
> >  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  5 ++
> >  arch/powerpc/mm/dump_linuxpagetables.c        |  3 +-
> >  arch/powerpc/mm/hash64_4k.c                   | 12 ++---
> >  arch/powerpc/mm/hash64_64k.c                  | 73 +++++++++------------------
> >  arch/powerpc/mm/hash_utils_64.c               | 38 +++++++++++++-
> >  arch/powerpc/mm/hugetlbpage-hash64.c          | 16 +++---
> >  9 files changed, 107 insertions(+), 98 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> > index b4b5e6b..223d318 100644
> > --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> > +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> > @@ -16,6 +16,18 @@
> >  #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << H_PUD_INDEX_SIZE)
> >  #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << H_PGD_INDEX_SIZE)
> >
> > +
> > +/*
> > + * Only supported by 4k linux page size
> 
> that comment is confusing, you can drop that, it is part of hash-4k.h
> which means these defines are local to 4k linux page size config.
> 
> > + */

right. ok.

> > +#define H_PAGE_F_SECOND        _RPAGE_RSV2     /* HPTE is in 2ndary HPTEG */
> > +#define H_PAGE_F_GIX           (_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
> > +#define H_PAGE_F_GIX_SHIFT     56
> > +
> > +#define H_PAGE_BUSY	_RPAGE_RSV1     /* software: PTE & hash are busy */
> > +#define H_PAGE_HASHPTE	_RPAGE_RPN43    /* PTE has associated HPTE */
> > +
> > +
> >  /* PTE flags to conserve for HPTE identification */
> >  #define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | \
> >  			 H_PAGE_F_SECOND | H_PAGE_F_GIX)
> > diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> > index 9732837..87ee22d 100644
> > --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> > +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> > @@ -10,23 +10,21 @@
> >   * 64k aligned address free up few of the lower bits of RPN for us
> >   * We steal that here. For more deatils look at pte_pfn/pfn_pte()
> >   */
> > -#define H_PAGE_COMBO	_RPAGE_RPN0 /* this is a combo 4k page */
> > -#define H_PAGE_4K_PFN	_RPAGE_RPN1 /* PFN is for a single 4k page */
> > +#define H_PAGE_COMBO   _RPAGE_RPN0 /* this is a combo 4k page */
> > +#define H_PAGE_4K_PFN  _RPAGE_RPN1 /* PFN is for a single 4k page */
> > +
> > +#define H_PAGE_BUSY	_RPAGE_RPN44     /* software: PTE & hash are busy */
> > +#define H_PAGE_HASHPTE	_RPAGE_RPN43    /* PTE has associated HPTE */
> > +
> >  /*
> >   * We need to differentiate between explicit huge page and THP huge
> >   * page, since THP huge page also need to track real subpage details
> >   */
> >  #define H_PAGE_THP_HUGE  H_PAGE_4K_PFN
> >
> > -/*
> > - * Used to track subpage group valid if H_PAGE_COMBO is set
> > - * This overloads H_PAGE_F_GIX and H_PAGE_F_SECOND
> > - */
> > -#define H_PAGE_COMBO_VALID	(H_PAGE_F_GIX | H_PAGE_F_SECOND)
> > -
> >  /* PTE flags to conserve for HPTE identification */
> > -#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_F_SECOND | \
> > -			 H_PAGE_F_GIX | H_PAGE_HASHPTE | H_PAGE_COMBO)
> > +#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE)
> > +
> 
> You drop H_PAGE_COMBO here. Is that intentional ?

Yes. that is intentional. See a downside?  We dont depend on
H_PAGE_COMBO for 64K pagesize PTE anymore.

> 
> We have code which does
> 
> 		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
> 					       MMU_PAGE_64K, ssize,
> 					       flags) == -1)
> 			old_pte &= ~_PAGE_HPTEFLAGS;
> 	
> 
> I guess they expect slot details to be cleared. With the above
> _PAGE_HPTEFLAGS that is not true.

since we dont depend on COMBO flag, it should be fine. Let me know if
you see a downside.

> 
> 
> >  /*
> >   * we support 16 fragments per PTE page of 64K size.
> >   */
> > @@ -54,24 +52,18 @@ static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
> >  	unsigned long *hidxp;
> >
> >  	rpte.pte = pte;
> > -	rpte.hidx = 0;
> > -	if (pte_val(pte) & H_PAGE_COMBO) {
> > -		/*
> > -		 * Make sure we order the hidx load against the H_PAGE_COMBO
> > -		 * check. The store side ordering is done in __hash_page_4K
> > -		 */
> > -		smp_rmb();
> > -		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> > -		rpte.hidx = *hidxp;
> > -	}
> > +	/*
> > +	 * The store side ordering is done in __hash_page_4K
> > +	 */
> > +	smp_rmb();
> > +	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> > +	rpte.hidx = *hidxp;
> >  	return rpte;
> >  }
> >
> >  static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
> >  {
> > -	if ((pte_val(rpte.pte) & H_PAGE_COMBO))
> > -		return (rpte.hidx >> (index<<2)) & 0xf;
> > -	return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
> > +	return ((rpte.hidx >> (index<<2)) & 0xfUL);
> >  }
> >
> >  #define __rpte_to_pte(r)	((r).pte)
> > diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> > index 4e957b0..7742782 100644
> > --- a/arch/powerpc/include/asm/book3s/64/hash.h
> > +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> > @@ -8,11 +8,9 @@
> >   *
> >   */
> >  #define H_PTE_NONE_MASK		_PAGE_HPTEFLAGS
> > -#define H_PAGE_F_GIX_SHIFT	56
> > -#define H_PAGE_BUSY		_RPAGE_RSV1 /* software: PTE & hash are busy */
> > -#define H_PAGE_F_SECOND		_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
> > -#define H_PAGE_F_GIX		(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
> > -#define H_PAGE_HASHPTE		_RPAGE_RPN43	/* PTE has associated HPTE */
> > +
> > +#define INIT_HIDX (~0x0UL)
> 
> But then you use it like
> 
> 	rpte.hidx = INIT_HIDX;
> 
> A better would be INIT_HIDX = 0xF ?. Also may be INIT is the wrong name
> there ?

No. We are initializing all the entries in the second-part-of-the-pte to
0xF. which essentially boils down to ~0x0UL.

> 
> > +#define HPTE_SOFT_INVALID(slot) ((slot & 0xfUL) == 0xfUL)
> 
> Can you do that as a static inline ?

ok.

> 
> >
> >  #ifdef CONFIG_PPC_64K_PAGES
> >  #include <asm/book3s/64/hash-64k.h>
> > diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > index 6981a52..cfb8169 100644
> > --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> > @@ -435,6 +435,11 @@ extern int __hash_page_4K(unsigned long ea, unsigned long access,
> >  extern int __hash_page_64K(unsigned long ea, unsigned long access,
> >  			   unsigned long vsid, pte_t *ptep, unsigned long trap,
> >  			   unsigned long flags, int ssize);
> > +extern unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
> > +			unsigned int subpg_index, unsigned long slot);
> > +extern unsigned long get_hidx_slot(unsigned long vpn, unsigned long shift,
> > +			int ssize, real_pte_t rpte, unsigned int subpg_index);
> > +
> >  struct mm_struct;
> >  unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap);
> >  extern int hash_page_mm(struct mm_struct *mm, unsigned long ea,
> > diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
> > index 44fe483..b832ed3 100644
> > --- a/arch/powerpc/mm/dump_linuxpagetables.c
> > +++ b/arch/powerpc/mm/dump_linuxpagetables.c
> > @@ -213,7 +213,7 @@ struct flag_info {
> >  		.val	= H_PAGE_4K_PFN,
> >  		.set	= "4K_pfn",
> >  	}, {
> > -#endif
> > +#else
> >  		.mask	= H_PAGE_F_GIX,
> >  		.val	= H_PAGE_F_GIX,
> >  		.set	= "f_gix",
> > @@ -224,6 +224,7 @@ struct flag_info {
> >  		.val	= H_PAGE_F_SECOND,
> >  		.set	= "f_second",
> >  	}, {
> > +#endif /* CONFIG_PPC_64K_PAGES */
> >  #endif
> >  		.mask	= _PAGE_SPECIAL,
> >  		.val	= _PAGE_SPECIAL,
> > diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
> > index 6fa450c..5b16416 100644
> > --- a/arch/powerpc/mm/hash64_4k.c
> > +++ b/arch/powerpc/mm/hash64_4k.c
> > @@ -20,6 +20,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >  		   pte_t *ptep, unsigned long trap, unsigned long flags,
> >  		   int ssize, int subpg_prot)
> >  {
> > +	real_pte_t rpte;
> >  	unsigned long hpte_group;
> >  	unsigned long rflags, pa;
> >  	unsigned long old_pte, new_pte;
> > @@ -54,6 +55,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >  	 * need to add in 0x1 if it's a read-only user page
> >  	 */
> >  	rflags = htab_convert_pte_flags(new_pte);
> > +	rpte = __real_pte(__pte(old_pte), ptep);
> >
> >  	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
> >  	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> > @@ -64,12 +66,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >  		/*
> >  		 * There MIGHT be an HPTE for this pte
> >  		 */
> > -		hash = hpt_hash(vpn, shift, ssize);
> > -		if (old_pte & H_PAGE_F_SECOND)
> > -			hash = ~hash;
> > -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> > -		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
> > -
> > +		slot = get_hidx_slot(vpn, shift, ssize, rpte, 0);
> 
> 
> This confused me, the rest of the code assume slot as the 4 bit value.
> But get_hidx_slot is not exactly returning that.

get_hidx_slot() is returning a 4bit value. no?

> 
> 
> 
> >  		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_4K,
> >  					       MMU_PAGE_4K, ssize, flags) == -1)
> >  			old_pte &= ~_PAGE_HPTEFLAGS;
> > @@ -118,8 +115,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >  			return -1;
> >  		}
> >  		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
> > -		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
> > -			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> > +		new_pte |= set_hidx_slot(ptep, rpte, 0, slot);
> >  	}
> >  	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
> >  	return 0;
> > diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> > index 1a68cb1..feb90f1 100644
> > --- a/arch/powerpc/mm/hash64_64k.c
> > +++ b/arch/powerpc/mm/hash64_64k.c
> > @@ -15,34 +15,13 @@
> >  #include <linux/mm.h>
> >  #include <asm/machdep.h>
> >  #include <asm/mmu.h>
> > -/*
> > - * index from 0 - 15
> > - */
> > -bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
> > -{
> > -	unsigned long g_idx;
> > -	unsigned long ptev = pte_val(rpte.pte);
> >
> > -	g_idx = (ptev & H_PAGE_COMBO_VALID) >> H_PAGE_F_GIX_SHIFT;
> > -	index = index >> 2;
> > -	if (g_idx & (0x1 << index))
> > -		return true;
> > -	else
> > -		return false;
> > -}
> >  /*
> >   * index from 0 - 15
> >   */
> > -static unsigned long mark_subptegroup_valid(unsigned long ptev, unsigned long index)
> > +bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
> >  {
> > -	unsigned long g_idx;
> > -
> > -	if (!(ptev & H_PAGE_COMBO))
> > -		return ptev;
> > -	index = index >> 2;
> > -	g_idx = 0x1 << index;
> > -
> > -	return ptev | (g_idx << H_PAGE_F_GIX_SHIFT);
> > +	return !(HPTE_SOFT_INVALID(rpte.hidx >> (index << 2)));
> >  }
> >
> >  int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> > @@ -50,10 +29,9 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >  		   int ssize, int subpg_prot)
> >  {
> >  	real_pte_t rpte;
> > -	unsigned long *hidxp;
> >  	unsigned long hpte_group;
> >  	unsigned int subpg_index;
> > -	unsigned long rflags, pa, hidx;
> > +	unsigned long rflags, pa;
> >  	unsigned long old_pte, new_pte, subpg_pte;
> >  	unsigned long vpn, hash, slot;
> >  	unsigned long shift = mmu_psize_defs[MMU_PAGE_4K].shift;
> > @@ -116,8 +94,9 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >  		 * On hash insert failure we use old pte value and we don't
> >  		 * want slot information there if we have a insert failure.
> >  		 */
> > -		old_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> > -		new_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> > +		old_pte &= ~(H_PAGE_HASHPTE);
> > +		new_pte &= ~(H_PAGE_HASHPTE);
> > +		rpte.hidx = INIT_HIDX;
> >  		goto htab_insert_hpte;
> >  	}
> >  	/*
> > @@ -126,18 +105,12 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >  	if (__rpte_sub_valid(rpte, subpg_index)) {
> >  		int ret;
> >
> > -		hash = hpt_hash(vpn, shift, ssize);
> > -		hidx = __rpte_to_hidx(rpte, subpg_index);
> > -		if (hidx & _PTEIDX_SECONDARY)
> > -			hash = ~hash;
> > -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> > -		slot += hidx & _PTEIDX_GROUP_IX;
> > -
> > +		slot = get_hidx_slot(vpn, shift, ssize, rpte, subpg_index);
> >  		ret = mmu_hash_ops.hpte_updatepp(slot, rflags, vpn,
> >  						 MMU_PAGE_4K, MMU_PAGE_4K,
> >  						 ssize, flags);
> >  		/*
> > -		 *if we failed because typically the HPTE wasn't really here
> > +		 * if we failed because typically the HPTE wasn't really here
> >  		 * we try an insertion.
> >  		 */
> >  		if (ret == -1)
> > @@ -177,8 +150,14 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >  						rflags, HPTE_V_SECONDARY,
> >  						MMU_PAGE_4K, MMU_PAGE_4K,
> >  						ssize);
> > -		if (slot == -1) {
> > -			if (mftb() & 0x1)
> > +		if (unlikely(HPTE_SOFT_INVALID(slot)))
> > +			mmu_hash_ops.hpte_invalidate(slot, vpn,
> > +				MMU_PAGE_4K, MMU_PAGE_4K,
> > +				ssize, (flags & HPTE_LOCAL_UPDATE));
> 
> Did this work ?

Good catch. I have not been able to excercise this code. getting 0xf
value from mmu_hash_ops.hpte_insert() has been impossible. 

> invalidate first arg is the offset of hpte from the htab
> base. where as insert return 4 bit slot number within group. I guess we
> need to do a cleanup patch before to differentiate between slot number
> within a group and slot number in hash page table. May be name slot
> number within a group as gslot ?
> 
> 
> > +
> > +		if (unlikely(slot == -1 || HPTE_SOFT_INVALID(slot))) {
> > +			if (HPTE_SOFT_INVALID(slot) || (mftb() & 0x1))
> > +
> 
> So we always try to remove from primary if we got 0xf slot by insert ?


yes.

> 
> 
> >  				hpte_group = ((hash & htab_hash_mask) *
> >  					      HPTES_PER_GROUP) & ~0x7UL;
> >  			mmu_hash_ops.hpte_remove(hpte_group);
> > @@ -204,11 +183,9 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >  	 * Since we have H_PAGE_BUSY set on ptep, we can be sure
> >  	 * nobody is undating hidx.
> >  	 */
> > -	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> > -	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
> > -	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
> > -	new_pte = mark_subptegroup_valid(new_pte, subpg_index);
> > -	new_pte |=  H_PAGE_HASHPTE;
> > +	new_pte |= set_hidx_slot(ptep, rpte, subpg_index, slot);
> > +	new_pte |= H_PAGE_HASHPTE;
> > +
> >  	/*
> >  	 * check __real_pte for details on matching smp_rmb()
> >  	 */
> > @@ -221,6 +198,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
> >  		    unsigned long vsid, pte_t *ptep, unsigned long trap,
> >  		    unsigned long flags, int ssize)
> >  {
> > +	real_pte_t rpte;
> >  	unsigned long hpte_group;
> >  	unsigned long rflags, pa;
> >  	unsigned long old_pte, new_pte;
> > @@ -257,6 +235,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
> >  	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
> >
> >  	rflags = htab_convert_pte_flags(new_pte);
> > +	rpte = __real_pte(__pte(old_pte), ptep);
> >
> >  	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
> >  	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> > @@ -267,12 +246,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
> >  		/*
> >  		 * There MIGHT be an HPTE for this pte
> >  		 */
> > -		hash = hpt_hash(vpn, shift, ssize);
> > -		if (old_pte & H_PAGE_F_SECOND)
> > -			hash = ~hash;
> > -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> > -		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
> > -
> > +		slot = get_hidx_slot(vpn, shift, ssize, rpte, 0);
> >  		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
> >  					       MMU_PAGE_64K, ssize,
> >  					       flags) == -1)
> > @@ -322,9 +296,8 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
> >  					   MMU_PAGE_64K, MMU_PAGE_64K, old_pte);
> >  			return -1;
> >  		}
> > +		set_hidx_slot(ptep, rpte, 0, slot);
> >  		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
> > -		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
> > -			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> >  	}
> >  	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
> >  	return 0;
> > diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> > index f2095ce..b405657 100644
> > --- a/arch/powerpc/mm/hash_utils_64.c
> > +++ b/arch/powerpc/mm/hash_utils_64.c
> > @@ -975,8 +975,9 @@ void __init hash__early_init_devtree(void)
> >
> >  void __init hash__early_init_mmu(void)
> >  {
> > +#ifndef CONFIG_PPC_64K_PAGES
> >  	/*
> > -	 * We have code in __hash_page_64K() and elsewhere, which assumes it can
> > +	 * We have code in __hash_page_4K() and elsewhere, which assumes it can
> >  	 * do the following:
> >  	 *   new_pte |= (slot << H_PAGE_F_GIX_SHIFT) & (H_PAGE_F_SECOND | H_PAGE_F_GIX);
> >  	 *
> > @@ -987,6 +988,7 @@ void __init hash__early_init_mmu(void)
> >  	 * with a BUILD_BUG_ON().
> >  	 */
> >  	BUILD_BUG_ON(H_PAGE_F_SECOND != (1ul  << (H_PAGE_F_GIX_SHIFT + 3)));
> > +#endif /* CONFIG_PPC_64K_PAGES */
> >
> >  	htab_init_page_sizes();
> >
> > @@ -1589,6 +1591,40 @@ static inline void tm_flush_hash_page(int local)
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_PPC_64K_PAGES
> > +unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
> > +		unsigned int subpg_index, unsigned long slot)
> > +{
> > +	unsigned long *hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> > +
> > +	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
> > +	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
> > +	return 0x0UL;
> > +}
> > +#else /* CONFIG_PPC_64K_PAGES */
> > +unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
> > +		unsigned int subpg_index, unsigned long slot)
> > +{
> > +	return (slot << H_PAGE_F_GIX_SHIFT) &
> > +			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> > +}
> 
> Move them to header files so that we can avoid #ifdef here. Here slot is
> 4 bit value

ok.

> 
> 
> > +#endif /* CONFIG_PPC_64K_PAGES */
> > +
> > +unsigned long get_hidx_slot(unsigned long vpn, unsigned long shift,
> > +			int ssize, real_pte_t rpte, unsigned int subpg_index)
> > +{
> > +	unsigned long hash, slot, hidx;
> > +
> > +	hash = hpt_hash(vpn, shift, ssize);
> > +	hidx = __rpte_to_hidx(rpte, subpg_index);
> > +	if (hidx & _PTEIDX_SECONDARY)
> > +		hash = ~hash;
> > +	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> > +	slot += hidx & _PTEIDX_GROUP_IX;
> > +	return slot;
> 
> Here slot is not. Can you rename this function ?

rename to? I possibly am using the wrong terminology which is getting
reflected in the names of the function. Will have to get that right
to avoid confusion.


Thanks for your comments, 

RP

> 
> > +}
> > +
> > +
> >  /* WARNING: This is called from hash_low_64.S, if you change this prototype,
> >   *          do not forget to update the assembly call site !
> >   */
> > diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> > index a84bb44..25a50eb 100644
> > --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> > +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> > @@ -14,7 +14,7 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/machdep.h>
> >
> > -extern long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
> > +long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
> >  				  unsigned long pa, unsigned long rlags,
> >  				  unsigned long vflags, int psize, int ssize);
> >
> > @@ -22,6 +22,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> >  		     pte_t *ptep, unsigned long trap, unsigned long flags,
> >  		     int ssize, unsigned int shift, unsigned int mmu_psize)
> >  {
> > +	real_pte_t rpte;
> >  	unsigned long vpn;
> >  	unsigned long old_pte, new_pte;
> >  	unsigned long rflags, pa, sz;
> > @@ -61,6 +62,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> >  	} while(!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
> >
> >  	rflags = htab_convert_pte_flags(new_pte);
> > +	rpte = __real_pte(__pte(old_pte), ptep);
> >
> >  	sz = ((1UL) << shift);
> >  	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> > @@ -71,14 +73,9 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> >  	/* Check if pte already has an hpte (case 2) */
> >  	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
> >  		/* There MIGHT be an HPTE for this pte */
> > -		unsigned long hash, slot;
> > -
> > -		hash = hpt_hash(vpn, shift, ssize);
> > -		if (old_pte & H_PAGE_F_SECOND)
> > -			hash = ~hash;
> > -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> > -		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
> > +		unsigned long slot;
> >
> > +		slot = get_hidx_slot(vpn, shift, ssize, rpte, 0);
> >  		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, mmu_psize,
> >  					       mmu_psize, ssize, flags) == -1)
> >  			old_pte &= ~_PAGE_HPTEFLAGS;
> > @@ -106,8 +103,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> >  			return -1;
> >  		}
> >
> > -		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
> > -			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> > +		new_pte |= set_hidx_slot(ptep, rpte, 0, slot);
> >  	}
> >
> >  	/*
> > -- 
> > 1.8.3.1

-- 
Ram Pai
