Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wswNc0NRqzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 16:51:27 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5L6n4Ir131682
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 02:51:25 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b7kukg275-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 02:51:25 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 16:51:22 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5L6p9Hk7012694
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 16:51:17 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5L6oiHU026477
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 16:50:45 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com
Subject: Re: [RFC v2 02/12] powerpc: Free up four 64K PTE bits in 64K backed
 hpte pages.
In-Reply-To: <1497671564-20030-3-git-send-email-linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-3-git-send-email-linuxram@us.ibm.com>
Date: Wed, 21 Jun 2017 12:20:18 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zid1al79.fsf@skywalker.in.ibm.com>
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
> in the 64K backed hpte pages. This along with the earlier
> patch will entirely free up the four bits from 64K PTE.
>
> This patch does the following change to 64K PTE that is
> backed by 64K hpte.
>
> H_PAGE_F_SECOND which occupied bit 4 moves to the second part
>         of the pte.
> H_PAGE_F_GIX which  occupied bit 5, 6 and 7 also moves to the
>         second part of the pte.
>
> since bit 7 is now freed up, we move H_PAGE_BUSY from bit 9
> to bit 7. Trying to minimize gaps so that contiguous bits
> can be allocated if needed in the future.
>
> The second part of the PTE will hold
> (H_PAGE_F_SECOND|H_PAGE_F_GIX) at bit 60,61,62,63.


This patch will be really simple, if you don't use the get_hidx_gslot() helper
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 26 ++++++++------------------
>  arch/powerpc/mm/hash64_64k.c                  | 16 +++++++---------
>  arch/powerpc/mm/hugetlbpage-hash64.c          | 16 ++++++----------
>  3 files changed, 21 insertions(+), 37 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 0eb3c89..2fa5c60 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -12,12 +12,8 @@
>   */
>  #define H_PAGE_COMBO   _RPAGE_RPN0 /* this is a combo 4k page */
>  #define H_PAGE_4K_PFN  _RPAGE_RPN1 /* PFN is for a single 4k page */
> -#define H_PAGE_F_SECOND	_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
> -#define H_PAGE_F_GIX	(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
> -#define H_PAGE_F_GIX_SHIFT	56
>
> -
> -#define H_PAGE_BUSY	_RPAGE_RPN42     /* software: PTE & hash are busy */
> +#define H_PAGE_BUSY	_RPAGE_RPN44     /* software: PTE & hash are busy */
>  #define H_PAGE_HASHPTE	_RPAGE_RPN43    /* PTE has associated HPTE */
>
>  /*
> @@ -56,24 +52,18 @@ static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
>  	unsigned long *hidxp;
>
>  	rpte.pte = pte;
> -	rpte.hidx = 0;
> -	if (pte_val(pte) & H_PAGE_COMBO) {
> -		/*
> -		 * Make sure we order the hidx load against the H_PAGE_COMBO
> -		 * check. The store side ordering is done in __hash_page_4K
> -		 */
> -		smp_rmb();
> -		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> -		rpte.hidx = *hidxp;
> -	}
> +	/*
> +	 * The store side ordering is done in __hash_page_4K
> +	 */


This is not just __hash_page_4k related now and you need to explain the
stoer side ordering more. Are we doing this correctly now ?

> +	smp_rmb();
> +	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> +	rpte.hidx = *hidxp;
>  	return rpte;
>  }
>
>  static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
>  {
> -	if ((pte_val(rpte.pte) & H_PAGE_COMBO))
> -		return (rpte.hidx >> (index<<2)) & 0xf;
> -	return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
> +	return ((rpte.hidx >> (index<<2)) & 0xfUL);
>  }
>
>  static inline unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> index 3702a3c..1c25ec2 100644
> --- a/arch/powerpc/mm/hash64_64k.c
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -211,6 +211,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>  		    unsigned long vsid, pte_t *ptep, unsigned long trap,
>  		    unsigned long flags, int ssize)
>  {
> +	real_pte_t rpte;
>  	unsigned long hpte_group;
>  	unsigned long rflags, pa;
>  	unsigned long old_pte, new_pte;
> @@ -247,6 +248,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>  	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
>
>  	rflags = htab_convert_pte_flags(new_pte);
> +	rpte = __real_pte(__pte(old_pte), ptep);
>
>  	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
>  	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> @@ -254,16 +256,13 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>
>  	vpn  = hpt_vpn(ea, vsid, ssize);
>  	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
> +		unsigned long gslot;
> +
>  		/*
>  		 * There MIGHT be an HPTE for this pte
>  		 */
> -		hash = hpt_hash(vpn, shift, ssize);
> -		if (old_pte & H_PAGE_F_SECOND)
> -			hash = ~hash;
> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> -		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
> -
> -		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
> +		gslot = get_hidx_gslot(vpn, shift, ssize, rpte, 0);
> +		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, MMU_PAGE_64K,
>  					       MMU_PAGE_64K, ssize,
>  					       flags) == -1)
>  			old_pte &= ~_PAGE_HPTEFLAGS;
> @@ -313,8 +312,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>  			return -1;
>  		}
>
> -		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
> -				(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> +		set_hidx_slot(ptep, rpte, 0, slot);
>  		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
>  	}
>  	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> index a84bb44..239ca86 100644
> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> @@ -22,6 +22,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  		     pte_t *ptep, unsigned long trap, unsigned long flags,
>  		     int ssize, unsigned int shift, unsigned int mmu_psize)
>  {
> +	real_pte_t rpte;
>  	unsigned long vpn;
>  	unsigned long old_pte, new_pte;
>  	unsigned long rflags, pa, sz;
> @@ -61,6 +62,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  	} while(!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
>
>  	rflags = htab_convert_pte_flags(new_pte);
> +	rpte = __real_pte(__pte(old_pte), ptep);
>
>  	sz = ((1UL) << shift);
>  	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> @@ -71,15 +73,10 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  	/* Check if pte already has an hpte (case 2) */
>  	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
>  		/* There MIGHT be an HPTE for this pte */
> -		unsigned long hash, slot;
> +		unsigned long gslot;
>
> -		hash = hpt_hash(vpn, shift, ssize);
> -		if (old_pte & H_PAGE_F_SECOND)
> -			hash = ~hash;
> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> -		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
> -
> -		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, mmu_psize,
> +		gslot = get_hidx_gslot(vpn, shift, ssize, rpte, 0);
> +		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, mmu_psize,
>  					       mmu_psize, ssize, flags) == -1)
>  			old_pte &= ~_PAGE_HPTEFLAGS;
>  	}
> @@ -106,8 +103,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  			return -1;
>  		}
>
> -		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
> -			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
> +		new_pte |= set_hidx_slot(ptep, rpte, 0, slot);
>  	}
>
>  	/*
> -- 
> 1.8.3.1
