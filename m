Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DB461A01F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 23:57:06 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 23 Sep 2015 23:57:04 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8DCD82BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 23:56:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8NDuf9k15794342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 23:56:49 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8NDuQbO030864
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 23:56:26 +1000
Message-ID: <5602AF78.501@linux.vnet.ibm.com>
Date: Wed, 23 Sep 2015 19:26:08 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 24/31] powerpc/mm: Convert __hash_page_64K to C
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-25-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1442817658-2588-25-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/21/2015 12:10 PM, Aneesh Kumar K.V wrote:
> Convert from asm to C
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |   3 +-
>  arch/powerpc/include/asm/book3s/64/hash.h     |   1 +
>  arch/powerpc/mm/hash64_64k.c                  | 134 +++++++++++-
>  arch/powerpc/mm/hash_low_64.S                 | 290 +-------------------------
>  arch/powerpc/mm/hash_utils_64.c               |  19 +-
>  5 files changed, 137 insertions(+), 310 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index b363d73ca225..f46fbd6cd837 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -35,7 +35,8 @@
>  #define _PAGE_4K_PFN	0x00040000 /* PFN is for a single 4k page */
>  
>  /* PTE flags to conserve for HPTE identification */
> -#define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | _PAGE_COMBO)
> +#define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_F_SECOND | \
> +			 _PAGE_F_GIX | _PAGE_HASHPTE | _PAGE_COMBO)
>  
>  /* Shift to put page number into pte.
>   *
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index f5b57d1c00dc..e84987ade89c 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -86,6 +86,7 @@
>  #define _PAGE_HASHPTE		0x00400 /* software: pte has an associated HPTE */
>  #define _PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
>  #define _PAGE_F_GIX		0x07000 /* full page: hidx bits */
> +#define _PAGE_F_GIX_SHIFT	12
>  #define _PAGE_F_SECOND		0x08000 /* Whether to use secondary hash or not */
>  #define _PAGE_SPECIAL		0x10000 /* software: special page */
>  
> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> index 7e1359e008b4..53d2c60bc07e 100644
> --- a/arch/powerpc/mm/hash64_64k.c
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -44,10 +44,10 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  	real_pte_t rpte;
>  	unsigned long hpte_group;
>  	unsigned int subpg_index;
> -	unsigned long shift = 12; /* 4K */
>  	unsigned long rflags, pa, hidx;
>  	unsigned long old_pte, new_pte, subpg_pte;
>  	unsigned long vpn, hash, slot;
> +	unsigned long shift = mmu_psize_defs[MMU_PAGE_4K].shift;
>  
>  	/*
>  	 * atomically mark the linux large page PTE busy and dirty
> @@ -214,7 +214,7 @@ repeat:
>  	 * nobody is undating hidx.
>  	 */
>  	rpte.hidx[subpg_index] = (unsigned char)(slot << 4 | 0x1 << 3);
> -	new_pte |= _PAGE_HASHPTE;
> +	new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE | _PAGE_COMBO;
>  	/*
>  	 * check __real_pte for details on matching smp_rmb()
>  	 */
> @@ -222,3 +222,133 @@ repeat:
>  	*ptep = __pte(new_pte & ~_PAGE_BUSY);
>  	return 0;
>  }
> +
> +int __hash_page_64K(unsigned long ea, unsigned long access,
> +		    unsigned long vsid, pte_t *ptep, unsigned long trap,
> +		    unsigned long flags, int ssize)
> +{
> +
> +	unsigned long hpte_group;
> +	unsigned long rflags, pa;
> +	unsigned long old_pte, new_pte;
> +	unsigned long vpn, hash, slot;
> +	unsigned long shift = mmu_psize_defs[MMU_PAGE_64K].shift;
> +
> +	/*
> +	 * atomically mark the linux large page PTE busy and dirty
> +	 */
> +	do {
> +		pte_t pte = READ_ONCE(*ptep);
> +
> +		old_pte = pte_val(pte);
> +		/* If PTE busy, retry the access */
> +		if (unlikely(old_pte & _PAGE_BUSY))
> +			return 0;
> +		/* If PTE permissions don't match, take page fault */
> +		if (unlikely(access & ~old_pte))
> +			return 1;
> +		/*
> +		 * Check if PTE has the cache-inhibit bit set
> +		 * If so, bail out and refault as a 4k page
> +		 */
> +		if (!mmu_has_feature(MMU_FTR_CI_LARGE_PAGE) &&
> +		    unlikely(old_pte & _PAGE_NO_CACHE))
> +			return 0;
> +		/*
> +		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
> +		 * a write access. Since this is 4K insert of 64K page size
> +		 * also add _PAGE_COMBO
> +		 */
> +		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
> +		if (access & _PAGE_RW)
> +			new_pte |= _PAGE_DIRTY;
> +	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
> +					  old_pte, new_pte));
> +	/*
> +	 * PP bits. _PAGE_USER is already PP bit 0x2, so we only
> +	 * need to add in 0x1 if it's a read-only user page
> +	 */
> +	rflags = new_pte & _PAGE_USER;
> +	if ((new_pte & _PAGE_USER) && !((new_pte & _PAGE_RW) &&
> +					(new_pte & _PAGE_DIRTY)))
> +		rflags |= 0x1;
> +	/*
> +	 * _PAGE_EXEC -> HW_NO_EXEC since it's inverted
> +	 */
> +	rflags |= ((new_pte & _PAGE_EXEC) ? 0 : HPTE_R_N);
> +	/*
> +	 * Always add C and Memory coherence bit
> +	 */
> +	rflags |= HPTE_R_C | HPTE_R_M;
> +	/*
> +	 * Add in WIMG bits
> +	 */
> +	rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
> +				_PAGE_COHERENT | _PAGE_GUARDED));
> +
> +	if (!cpu_has_feature(CPU_FTR_NOEXECUTE) &&
> +	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> +		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
> +
> +	vpn  = hpt_vpn(ea, vsid, ssize);
> +	if (unlikely(old_pte & _PAGE_HASHPTE)) {
> +		/*
> +		 * There MIGHT be an HPTE for this pte
> +		 */
> +		hash = hpt_hash(vpn, shift, ssize);
> +		if (old_pte & _PAGE_F_SECOND)
> +			hash = ~hash;
> +		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> +		slot += (old_pte & _PAGE_F_GIX) >> _PAGE_F_GIX_SHIFT;
> +
> +		if (ppc_md.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
> +					 MMU_PAGE_64K, ssize, flags) == -1)
> +			old_pte &= ~_PAGE_HPTEFLAGS;
> +	}
> +
> +	if (likely(!(old_pte & _PAGE_HASHPTE))) {
> +
> +		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
> +		hash = hpt_hash(vpn, shift, ssize);
> +
> +repeat:
> +		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
> +
> +		/* Insert into the hash table, primary slot */
> +		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
> +				  MMU_PAGE_64K, MMU_PAGE_64K, ssize);
> +		/*
> +		 * Primary is full, try the secondary
> +		 */
> +		if (unlikely(slot == -1)) {
> +			hpte_group = ((~hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
> +			slot = ppc_md.hpte_insert(hpte_group, vpn, pa,
> +						  rflags, HPTE_V_SECONDARY,
> +						  MMU_PAGE_64K, MMU_PAGE_64K, ssize);
> +			if (slot == -1) {
> +				if (mftb() & 0x1)
> +					hpte_group = ((hash & htab_hash_mask) *
> +						      HPTES_PER_GROUP) & ~0x7UL;
> +				ppc_md.hpte_remove(hpte_group);
> +				/*
> +				 * FIXME!! Should be try the group from which we removed ?
> +				 */
> +				goto repeat;
> +			}
> +		}
> +		/*
> +		 * Hypervisor failure. Restore old pmd and return -1
> +		 * similar to __hash_page_*
> +		 */
> +		if (unlikely(slot == -2)) {
> +			*ptep = __pte(old_pte);
> +			hash_failure_debug(ea, access, vsid, trap, ssize,
> +					   MMU_PAGE_64K, MMU_PAGE_64K, old_pte);
> +			return -1;
> +		}
> +		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
> +		new_pte |= (slot << _PAGE_F_GIX_SHIFT) & (_PAGE_F_SECOND | _PAGE_F_GIX);


I know this is already part of the function __hash_page_huge(), but its
just coincidence that _PAGE_F_SECOND is the left bit of _PAGE_F_GIX 3 bit
positions, so we dont check exclusively for the fourth bit on the returned
'slot' value from hpte_insert() function and explicitly set _PAGE_F_SECOND
flag for the pte. This hack does the work but makes it pretty confusing.
