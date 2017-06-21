Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsw9V1PYvzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 16:41:50 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5L6dWfd057420
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 02:41:48 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7jxg9thn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 02:41:47 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 16:41:45 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5L6fguU65732730
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 16:41:42 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5L6ffsg015914
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 16:41:42 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com
Subject: Re: [RFC v2 01/12] powerpc: Free up four 64K PTE bits in 4K backed
 hpte pages.
In-Reply-To: <1497671564-20030-2-git-send-email-linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-2-git-send-email-linuxram@us.ibm.com>
Date: Wed, 21 Jun 2017 12:11:32 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737atc06b.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> Rearrange 64K PTE bits to  free  up  bits 3, 4, 5  and  6
> in the 4K backed hpte pages. These bits continue to be used
> for 64K backed hpte pages in this patch, but will be freed
> up in the next patch.
>
> The patch does the following change to the 64K PTE format
>
> H_PAGE_BUSY moves from bit 3 to bit 9
> H_PAGE_F_SECOND which occupied bit 4 moves to the second part
> 	of the pte.
> H_PAGE_F_GIX which  occupied bit 5, 6 and 7 also moves to the
> 	second part of the pte.
>
> the four  bits((H_PAGE_F_SECOND|H_PAGE_F_GIX) that represent a slot
> is  initialized  to  0xF  indicating  an invalid  slot.  If  a hpte
> gets cached in a 0xF  slot(i.e  7th  slot  of  secondary),  it   is
> released immediately. In  other  words, even  though   0xF   is   a
> valid slot we discard  and consider it as an invalid
> slot;i.e hpte_soft_invalid(). This  gives  us  an opportunity to not
> depend on a bit in the primary PTE in order to determine the
> validity of a slot.
>
> When  we  release  a    hpte   in the 0xF   slot we also   release a
> legitimate primary   slot  and    unmap    that  entry. This  is  to
> ensure  that we do get a   legimate   non-0xF  slot the next time we
> retry for a slot.
>
> Though treating 0xF slot as invalid reduces the number of available
> slots  and  may  have an effect  on the performance, the probabilty
> of hitting a 0xF is extermely low.
>
> Compared  to the current scheme, the above described scheme reduces
> the number of false hash table updates  significantly  and  has the
> added  advantage  of  releasing  four  valuable  PTE bits for other
> purpose.
>
> This idea was jointly developed by Paul Mackerras, Aneesh, Michael
> Ellermen and myself.
>
> 4K PTE format remain unchanged currently.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  | 20 +++++++
>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 32 +++++++----
>  arch/powerpc/include/asm/book3s/64/hash.h     | 15 +++--
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  5 ++
>  arch/powerpc/mm/dump_linuxpagetables.c        |  3 +-
>  arch/powerpc/mm/hash64_4k.c                   | 14 ++---
>  arch/powerpc/mm/hash64_64k.c                  | 81 ++++++++++++---------------
>  arch/powerpc/mm/hash_utils_64.c               | 30 +++++++---
>  8 files changed, 122 insertions(+), 78 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> index b4b5e6b..5ef1d81 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -16,6 +16,18 @@
>  #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << H_PUD_INDEX_SIZE)
>  #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << H_PGD_INDEX_SIZE)
>
> +
> +/*
> + * Only supported by 4k linux page size
> + */
> +#define H_PAGE_F_SECOND        _RPAGE_RSV2     /* HPTE is in 2ndary HPTEG */
> +#define H_PAGE_F_GIX           (_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
> +#define H_PAGE_F_GIX_SHIFT     56
> +
> +#define H_PAGE_BUSY	_RPAGE_RSV1     /* software: PTE & hash are busy */
> +#define H_PAGE_HASHPTE	_RPAGE_RPN43    /* PTE has associated HPTE */
> +
> +
>  /* PTE flags to conserve for HPTE identification */
>  #define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | \
>  			 H_PAGE_F_SECOND | H_PAGE_F_GIX)
> @@ -48,6 +60,14 @@ static inline int hash__hugepd_ok(hugepd_t hpd)
>  }
>  #endif
>
> +static inline unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
> +			unsigned int subpg_index, unsigned long slot)
> +{
> +	return (slot << H_PAGE_F_GIX_SHIFT) &
> +		(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> +}
> +
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>
>  static inline char *get_hpte_slot_array(pmd_t *pmdp)
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 9732837..0eb3c89 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -10,23 +10,25 @@
>   * 64k aligned address free up few of the lower bits of RPN for us
>   * We steal that here. For more deatils look at pte_pfn/pfn_pte()
>   */
> -#define H_PAGE_COMBO	_RPAGE_RPN0 /* this is a combo 4k page */
> -#define H_PAGE_4K_PFN	_RPAGE_RPN1 /* PFN is for a single 4k page */
> +#define H_PAGE_COMBO   _RPAGE_RPN0 /* this is a combo 4k page */
> +#define H_PAGE_4K_PFN  _RPAGE_RPN1 /* PFN is for a single 4k page */
> +#define H_PAGE_F_SECOND	_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
> +#define H_PAGE_F_GIX	(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
> +#define H_PAGE_F_GIX_SHIFT	56
> +
> +
> +#define H_PAGE_BUSY	_RPAGE_RPN42     /* software: PTE & hash are busy */
> +#define H_PAGE_HASHPTE	_RPAGE_RPN43    /* PTE has associated HPTE */
> +
>  /*
>   * We need to differentiate between explicit huge page and THP huge
>   * page, since THP huge page also need to track real subpage details
>   */
>  #define H_PAGE_THP_HUGE  H_PAGE_4K_PFN
>
> -/*
> - * Used to track subpage group valid if H_PAGE_COMBO is set
> - * This overloads H_PAGE_F_GIX and H_PAGE_F_SECOND
> - */
> -#define H_PAGE_COMBO_VALID	(H_PAGE_F_GIX | H_PAGE_F_SECOND)
> -
>  /* PTE flags to conserve for HPTE identification */
> -#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_F_SECOND | \
> -			 H_PAGE_F_GIX | H_PAGE_HASHPTE | H_PAGE_COMBO)
> +#define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | H_PAGE_COMBO)

Why in this patch ? This is related to 64K pte


> +
>  /*
>   * we support 16 fragments per PTE page of 64K size.
>   */
> @@ -74,6 +76,16 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
>  	return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
>  }
>
> +static inline unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
> +		unsigned int subpg_index, unsigned long slot)
> +{
> +	unsigned long *hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> +
> +	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
> +	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
> +	return 0x0UL;
> +}
> +
>  #define __rpte_to_pte(r)	((r).pte)
>  extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
>  /*
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index 4e957b0..e7cf03a 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -8,11 +8,8 @@
>   *
>   */
>  #define H_PTE_NONE_MASK		_PAGE_HPTEFLAGS
> -#define H_PAGE_F_GIX_SHIFT	56
> -#define H_PAGE_BUSY		_RPAGE_RSV1 /* software: PTE & hash are busy */
> -#define H_PAGE_F_SECOND		_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
> -#define H_PAGE_F_GIX		(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
> -#define H_PAGE_HASHPTE		_RPAGE_RPN43	/* PTE has associated HPTE */
> +
> +#define INIT_HIDX (~0x0UL)
>
>  #ifdef CONFIG_PPC_64K_PAGES
>  #include <asm/book3s/64/hash-64k.h>
> @@ -160,6 +157,14 @@ static inline int hash__pte_none(pte_t pte)
>  	return (pte_val(pte) & ~H_PTE_NONE_MASK) == 0;
>  }
>
> +static inline bool hpte_soft_invalid(unsigned long slot)
> +{
> +	return ((slot & 0xfUL) == 0xfUL);
> +}
> +
> +unsigned long get_hidx_gslot(unsigned long vpn, unsigned long shift,
> +		int ssize, real_pte_t rpte, unsigned int subpg_index);
> +
>  /* This low level function performs the actual PTE insertion
>   * Setting the PTE depends on the MMU type and other factors. It's
>   * an horrible mess that I'm not going to try to clean up now but
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index 6981a52..cfb8169 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -435,6 +435,11 @@ extern int __hash_page_4K(unsigned long ea, unsigned long access,
>  extern int __hash_page_64K(unsigned long ea, unsigned long access,
>  			   unsigned long vsid, pte_t *ptep, unsigned long trap,
>  			   unsigned long flags, int ssize);
> +extern unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
> +			unsigned int subpg_index, unsigned long slot);
> +extern unsigned long get_hidx_slot(unsigned long vpn, unsigned long shift,
> +			int ssize, real_pte_t rpte, unsigned int subpg_index);
> +
>  struct mm_struct;
>  unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap);
>  extern int hash_page_mm(struct mm_struct *mm, unsigned long ea,
> diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
> index 44fe483..b832ed3 100644
> --- a/arch/powerpc/mm/dump_linuxpagetables.c
> +++ b/arch/powerpc/mm/dump_linuxpagetables.c
> @@ -213,7 +213,7 @@ struct flag_info {
>  		.val	= H_PAGE_4K_PFN,
>  		.set	= "4K_pfn",
>  	}, {
> -#endif
> +#else
>  		.mask	= H_PAGE_F_GIX,
>  		.val	= H_PAGE_F_GIX,
>  		.set	= "f_gix",
> @@ -224,6 +224,7 @@ struct flag_info {
>  		.val	= H_PAGE_F_SECOND,
>  		.set	= "f_second",
>  	}, {
> +#endif /* CONFIG_PPC_64K_PAGES */
>  #endif
>  		.mask	= _PAGE_SPECIAL,
>  		.val	= _PAGE_SPECIAL,
> diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
> index 6fa450c..c673829 100644
> --- a/arch/powerpc/mm/hash64_4k.c
> +++ b/arch/powerpc/mm/hash64_4k.c
> @@ -20,6 +20,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  		   pte_t *ptep, unsigned long trap, unsigned long flags,
>  		   int ssize, int subpg_prot)
>  {
> +	real_pte_t rpte;
>  	unsigned long hpte_group;
>  	unsigned long rflags, pa;
>  	unsigned long old_pte, new_pte;
> @@ -54,6 +55,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  	 * need to add in 0x1 if it's a read-only user page
>  	 */
>  	rflags = htab_convert_pte_flags(new_pte);
> +	rpte = __real_pte(__pte(old_pte), ptep);
>
>  	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
>  	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> @@ -64,13 +66,10 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  		/*
>  		 * There MIGHT be an HPTE for this pte
>  		 */
> -		hash = hpt_hash(vpn, shift, ssize);
> -		if (old_pte & H_PAGE_F_SECOND)
> -			hash = ~hash;
> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> -		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
> +		unsigned long gslot = get_hidx_gslot(vpn, shift,
> +						ssize, rpte, 0);
>
> -		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_4K,
> +		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, MMU_PAGE_4K,
>  					       MMU_PAGE_4K, ssize, flags) == -1)
>  			old_pte &= ~_PAGE_HPTEFLAGS;
>  	}
> @@ -118,8 +117,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  			return -1;
>  		}
>  		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
> -		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
> -			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> +		new_pte |= set_hidx_slot(ptep, rpte, 0, slot);
>  	}
>  	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
>  	return 0;



None of the above changes are needed. We are not changing anything w.r.t
4k linux page table yet. So we can drop this.


> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> index 1a68cb1..3702a3c 100644
> --- a/arch/powerpc/mm/hash64_64k.c
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -15,34 +15,13 @@
>  #include <linux/mm.h>
>  #include <asm/machdep.h>
>  #include <asm/mmu.h>
> +
>  /*
>   * index from 0 - 15
>   */
>  bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
>  {
> -	unsigned long g_idx;
> -	unsigned long ptev = pte_val(rpte.pte);
> -
> -	g_idx = (ptev & H_PAGE_COMBO_VALID) >> H_PAGE_F_GIX_SHIFT;
> -	index = index >> 2;
> -	if (g_idx & (0x1 << index))
> -		return true;
> -	else
> -		return false;
> -}
> -/*
> - * index from 0 - 15
> - */
> -static unsigned long mark_subptegroup_valid(unsigned long ptev, unsigned long index)
> -{
> -	unsigned long g_idx;
> -
> -	if (!(ptev & H_PAGE_COMBO))
> -		return ptev;
> -	index = index >> 2;
> -	g_idx = 0x1 << index;
> -
> -	return ptev | (g_idx << H_PAGE_F_GIX_SHIFT);
> +	return !(hpte_soft_invalid(rpte.hidx >> (index << 2)));
>  }
>
>  int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> @@ -50,10 +29,9 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  		   int ssize, int subpg_prot)
>  {
>  	real_pte_t rpte;
> -	unsigned long *hidxp;
>  	unsigned long hpte_group;
>  	unsigned int subpg_index;
> -	unsigned long rflags, pa, hidx;
> +	unsigned long rflags, pa;
>  	unsigned long old_pte, new_pte, subpg_pte;
>  	unsigned long vpn, hash, slot;
>  	unsigned long shift = mmu_psize_defs[MMU_PAGE_4K].shift;
> @@ -116,28 +94,23 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  		 * On hash insert failure we use old pte value and we don't
>  		 * want slot information there if we have a insert failure.
>  		 */
> -		old_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> -		new_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> +		old_pte &= ~(H_PAGE_HASHPTE);
> +		new_pte &= ~(H_PAGE_HASHPTE);
>  		goto htab_insert_hpte;
>  	}
>  	/*
>  	 * Check for sub page valid and update
>  	 */
>  	if (__rpte_sub_valid(rpte, subpg_index)) {
> -		int ret;
>
> -		hash = hpt_hash(vpn, shift, ssize);
> -		hidx = __rpte_to_hidx(rpte, subpg_index);
> -		if (hidx & _PTEIDX_SECONDARY)
> -			hash = ~hash;
> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> -		slot += hidx & _PTEIDX_GROUP_IX;
> +		unsigned long gslot = get_hidx_gslot(vpn, shift,
> +				ssize, rpte, subpg_index);


Converting that to helper is also not needed in this patch. Leave it as
it is. It is much easier to review.


>
> -		ret = mmu_hash_ops.hpte_updatepp(slot, rflags, vpn,
> +		int ret = mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn,
>  						 MMU_PAGE_4K, MMU_PAGE_4K,
>  						 ssize, flags);
>  		/*
> -		 *if we failed because typically the HPTE wasn't really here
> +		 * if we failed because typically the HPTE wasn't really here
>  		 * we try an insertion.
>  		 */
>  		if (ret == -1)
> @@ -148,6 +121,15 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  	}
>
>  htab_insert_hpte:
> +
> +	/*
> +	 * initialize all hidx entries to a invalid value,
> +	 * the first time the PTE is about to allocate
> +	 * a 4K hpte
> +	 */
> +	if (!(old_pte & H_PAGE_COMBO))
> +		rpte.hidx = INIT_HIDX;
> +
>  	/*
>  	 * handle H_PAGE_4K_PFN case
>  	 */
> @@ -177,10 +159,20 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  						rflags, HPTE_V_SECONDARY,
>  						MMU_PAGE_4K, MMU_PAGE_4K,
>  						ssize);
> -		if (slot == -1) {
> -			if (mftb() & 0x1)
> +
> +		if (unlikely(hpte_soft_invalid(slot))) {

Should we name that hpte_slot_invalid() ? ie. s/soft/slot/ ?


> +			slot = slot & _PTEIDX_GROUP_IX;
> +			mmu_hash_ops.hpte_invalidate(hpte_group+slot, vpn,
> +				MMU_PAGE_4K, MMU_PAGE_4K,
> +				ssize, flags);

What is the last arg flags here ? I guess we need to pass 0 there ?
We can't do a local = 1 invalidate, because we don't know whether
anybody did really access this address in between and has got the entry
in TLB.


> +		}
> +
> +		if (unlikely(slot == -1 || hpte_soft_invalid(slot))) {
> +

Can you add a comment around explaining invalid slot always result in
removing from primary ? Also do we want to store that invalid slot
details in a variable ? instead of doing that conditional again and
again ? This is hotpath.

> +			if (hpte_soft_invalid(slot) || (mftb() & 0x1))
>  				hpte_group = ((hash & htab_hash_mask) *
>  					      HPTES_PER_GROUP) & ~0x7UL;
> +
>  			mmu_hash_ops.hpte_remove(hpte_group);
>  			/*
>  			 * FIXME!! Should be try the group from which we removed ?
> @@ -204,11 +196,9 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  	 * Since we have H_PAGE_BUSY set on ptep, we can be sure
>  	 * nobody is undating hidx.
>  	 */
> -	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> -	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
> -	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
> -	new_pte = mark_subptegroup_valid(new_pte, subpg_index);
> -	new_pte |=  H_PAGE_HASHPTE;
> +	new_pte |= set_hidx_slot(ptep, rpte, subpg_index, slot);
> +	new_pte |= H_PAGE_HASHPTE;
> +
>  	/*
>  	 * check __real_pte for details on matching smp_rmb()
>  	 */
> @@ -322,9 +312,10 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>  					   MMU_PAGE_64K, MMU_PAGE_64K, old_pte);
>  			return -1;
>  		}
> -		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
> +
>  		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
> -			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> +				(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> +		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;

What is this change ? i guess we want this in second patch ?


>  	}
>  	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
>  	return 0;
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index f2095ce..c0f4b46 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -975,8 +975,9 @@ void __init hash__early_init_devtree(void)
>
>  void __init hash__early_init_mmu(void)
>  {
> +#ifndef CONFIG_PPC_64K_PAGES
>  	/*
> -	 * We have code in __hash_page_64K() and elsewhere, which assumes it can
> +	 * We have code in __hash_page_4K() and elsewhere, which assumes it can
>  	 * do the following:
>  	 *   new_pte |= (slot << H_PAGE_F_GIX_SHIFT) & (H_PAGE_F_SECOND | H_PAGE_F_GIX);
>  	 *
> @@ -987,6 +988,7 @@ void __init hash__early_init_mmu(void)
>  	 * with a BUILD_BUG_ON().
>  	 */
>  	BUILD_BUG_ON(H_PAGE_F_SECOND != (1ul  << (H_PAGE_F_GIX_SHIFT + 3)));
> +#endif /* CONFIG_PPC_64K_PAGES */
>
>  	htab_init_page_sizes();
>
> @@ -1589,29 +1591,39 @@ static inline void tm_flush_hash_page(int local)
>  }
>  #endif
>
> +unsigned long get_hidx_gslot(unsigned long vpn, unsigned long shift,
> +			int ssize, real_pte_t rpte, unsigned int subpg_index)
> +{
> +	unsigned long hash, slot, hidx;
> +
> +	hash = hpt_hash(vpn, shift, ssize);
> +	hidx = __rpte_to_hidx(rpte, subpg_index);
> +	if (hidx & _PTEIDX_SECONDARY)
> +		hash = ~hash;
> +	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> +	slot += hidx & _PTEIDX_GROUP_IX;
> +	return slot;
> +}


We don't need this helper for this patch series ?

> +
> +
>  /* WARNING: This is called from hash_low_64.S, if you change this prototype,
>   *          do not forget to update the assembly call site !
>   */
>  void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
>  		     unsigned long flags)
>  {
> -	unsigned long hash, index, shift, hidx, slot;
> +	unsigned long hash, index, shift, hidx, gslot;
>  	int local = flags & HPTE_LOCAL_UPDATE;
>
>  	DBG_LOW("flush_hash_page(vpn=%016lx)\n", vpn);
>  	pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
> -		hash = hpt_hash(vpn, shift, ssize);
> -		hidx = __rpte_to_hidx(pte, index);
> -		if (hidx & _PTEIDX_SECONDARY)
> -			hash = ~hash;
> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> -		slot += hidx & _PTEIDX_GROUP_IX;
> +		gslot = get_hidx_gslot(vpn, shift, ssize, pte, index);
>  		DBG_LOW(" sub %ld: hash=%lx, hidx=%lx\n", index, slot, hidx);
>  		/*
>  		 * We use same base page size and actual psize, because we don't
>  		 * use these functions for hugepage
>  		 */
> -		mmu_hash_ops.hpte_invalidate(slot, vpn, psize, psize,
> +		mmu_hash_ops.hpte_invalidate(gslot, vpn, psize, psize,
>  					     ssize, local);
>  	} pte_iterate_hashed_end();
>
And if we avoid adding that helper, changes like this can be avoided in
the patch.


-aneesh
