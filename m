Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wX2VL6rGCzDqZn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 14:24:26 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4N4OH15142233
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 00:24:22 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2am9ae9cwf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 00:24:21 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 23 May 2017 14:24:19 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4N4O89I44892314
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 14:24:16 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4N4NhjJ025269
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 14:23:44 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [PATCH 4/6] powerpc/mm: Add devmap support for ppc64
In-Reply-To: <20170523040524.13717-4-oohall@gmail.com>
References: <20170523040524.13717-1-oohall@gmail.com>
 <20170523040524.13717-4-oohall@gmail.com>
Date: Tue, 23 May 2017 09:53:19 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efvgqk08.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:

> Add support for the devmap bit on PTEs and PMDs for PPC64 Book3S.  This
> is used to differentiate device backed memory from transparent huge
> pages since they are handled in more or less the same manner by the core
> mm code.
>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> v1 -> v2: Properly differentiate THP and PMD Devmap entries. The
> mm core assumes that pmd_trans_huge() and pmd_devmap() are mutually
> exclusive and v1 had pmd_trans_huge() being true on a devmap pmd.
>
> Aneesh, this has been fleshed out substantially since v1. Can you
> re-review it? Also no explicit gup support is required in this patch
> since devmap support was added generic GUP as a part of making x86 use
> the generic version.
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |  2 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h  | 37 ++++++++++++++++++++++++++-
>  arch/powerpc/include/asm/book3s/64/radix.h    |  2 +-
>  arch/powerpc/mm/hugetlbpage.c                 |  2 +-
>  arch/powerpc/mm/pgtable-book3s64.c            |  4 +--
>  arch/powerpc/mm/pgtable-hash64.c              |  4 ++-
>  arch/powerpc/mm/pgtable-radix.c               |  3 ++-
>  arch/powerpc/mm/pgtable_64.c                  |  2 +-
>  8 files changed, 47 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 9732837aaae8..eaaf613c5347 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -180,7 +180,7 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
>   */
>  static inline int hash__pmd_trans_huge(pmd_t pmd)
>  {
> -	return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE)) ==
> +	return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE | _PAGE_DEVMAP)) ==
>  		  (_PAGE_PTE | H_PAGE_THP_HUGE));
>  }


_PAGE_DEVMAP is not really needed here. We will set H_PAGE_THP_HUGE only
for thp hugepage w.r.t hash. But putting it here also makes it clear
that devmap entries are not considered trans huge.

>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 85bc9875c3be..24634e92dd0b 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -79,6 +79,9 @@
>
>  #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
>  #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
> +#define _PAGE_DEVMAP		_RPAGE_SW1
> +#define __HAVE_ARCH_PTE_DEVMAP
> +
>  /*
>   * Drivers request for cache inhibited pte mapping using _PAGE_NO_CACHE
>   * Instead of fixing all of them, add an alternate define which
> @@ -599,6 +602,16 @@ static inline pte_t pte_mkhuge(pte_t pte)
>  	return pte;
>  }
>
> +static inline pte_t pte_mkdevmap(pte_t pte)
> +{
> +	return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
> +}
> +
> +static inline int pte_devmap(pte_t pte)
> +{
> +	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DEVMAP));
> +}
> +
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  {
>  	/* FIXME!! check whether this need to be a conditional */
> @@ -963,6 +976,9 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
>  #define pmd_mk_savedwrite(pmd)	pte_pmd(pte_mk_savedwrite(pmd_pte(pmd)))
>  #define pmd_clear_savedwrite(pmd)	pte_pmd(pte_clear_savedwrite(pmd_pte(pmd)))
>
> +#define pud_pfn(...) (0)
> +#define pgd_pfn(...) (0)
> +
>  #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
>  #define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
>  #define pmd_mksoft_dirty(pmd)  pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)))
> @@ -1137,7 +1153,6 @@ static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
>  	return true;
>  }
>
> -
>  #define arch_needs_pgtable_deposit arch_needs_pgtable_deposit
>  static inline bool arch_needs_pgtable_deposit(void)
>  {
> @@ -1146,6 +1161,26 @@ static inline bool arch_needs_pgtable_deposit(void)
>  	return true;
>  }
>
> +static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> +{
> +	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
> +}


We avoided setting _PAGE_SPECIAL on pmd entries. This will set that, we
may want to check if it is ok.  IIRC, we overloaded _PAGE_SPECIAL at
some point to indicate thp splitting. But good to double check. 

> +
> +static inline int pmd_devmap(pmd_t pmd)
> +{
> +	return pte_devmap(pmd_pte(pmd));
> +}
> +
> +static inline int pud_devmap(pud_t pud)
> +{
> +	return 0;
> +}
> +
> +static inline int pgd_devmap(pgd_t pgd)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #endif /* __ASSEMBLY__ */
>  #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
> index ac16d1943022..ba43754e96d2 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -252,7 +252,7 @@ static inline int radix__pgd_bad(pgd_t pgd)
>
>  static inline int radix__pmd_trans_huge(pmd_t pmd)
>  {
> -	return !!(pmd_val(pmd) & _PAGE_PTE);
> +	return (pmd_val(pmd) & (_PAGE_PTE | _PAGE_DEVMAP)) == _PAGE_PTE;
>  }
>
>  static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index a4f33de4008e..d9958af5c98e 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -963,7 +963,7 @@ pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
>  			if (pmd_none(pmd))
>  				return NULL;
>
> -			if (pmd_trans_huge(pmd)) {
> +			if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
>  				if (is_thp)
>  					*is_thp = true;
>  				ret_pte = (pte_t *) pmdp;


Is that correct ? Do we want pmd_devmap to have is_thp set ? 


> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index 5fcb3dd74c13..31eed8fa8e99 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -32,7 +32,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>  {
>  	int changed;
>  #ifdef CONFIG_DEBUG_VM
> -	WARN_ON(!pmd_trans_huge(*pmdp));
> +	WARN_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
>  	assert_spin_locked(&vma->vm_mm->page_table_lock);
>  #endif
>  	changed = !pmd_same(*(pmdp), entry);
> @@ -59,7 +59,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>  #ifdef CONFIG_DEBUG_VM
>  	WARN_ON(pte_present(pmd_pte(*pmdp)) && !pte_protnone(pmd_pte(*pmdp)));
>  	assert_spin_locked(&mm->page_table_lock);
> -	WARN_ON(!pmd_trans_huge(pmd));
> +	WARN_ON(!(pmd_trans_huge(pmd) || pmd_devmap(pmd)));
>  #endif
>  	trace_hugepage_set_pmd(addr, pmd_val(pmd));
>  	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
> diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
> index 8b85a14b08ea..7456cde4dbce 100644
> --- a/arch/powerpc/mm/pgtable-hash64.c
> +++ b/arch/powerpc/mm/pgtable-hash64.c
> @@ -109,7 +109,7 @@ unsigned long hash__pmd_hugepage_update(struct mm_struct *mm, unsigned long addr
>  	unsigned long old;
>
>  #ifdef CONFIG_DEBUG_VM
> -	WARN_ON(!pmd_trans_huge(*pmdp));
> +	WARN_ON(!hash__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
>  	assert_spin_locked(&mm->page_table_lock);
>  #endif
>
> @@ -141,6 +141,7 @@ pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addres
>
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  	VM_BUG_ON(pmd_trans_huge(*pmdp));
> +	VM_BUG_ON(pmd_devmap(*pmdp));
>
>  	pmd = *pmdp;
>  	pmd_clear(pmdp);
> @@ -221,6 +222,7 @@ void hash__pmdp_huge_split_prepare(struct vm_area_struct *vma,
>  {
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  	VM_BUG_ON(REGION_ID(address) != USER_REGION_ID);
> +	VM_BUG_ON(pmd_devmap(*pmdp));
>
>  	/*
>  	 * We can't mark the pmd none here, because that will cause a race
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index c28165d8970b..69e28dda81f2 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -683,7 +683,7 @@ unsigned long radix__pmd_hugepage_update(struct mm_struct *mm, unsigned long add
>  	unsigned long old;
>
>  #ifdef CONFIG_DEBUG_VM
> -	WARN_ON(!radix__pmd_trans_huge(*pmdp));
> +	WARN_ON(!radix__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
>  	assert_spin_locked(&mm->page_table_lock);
>  #endif
>
> @@ -701,6 +701,7 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
>
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  	VM_BUG_ON(radix__pmd_trans_huge(*pmdp));
> +	VM_BUG_ON(pmd_devmap(*pmdp));
>  	/*
>  	 * khugepaged calls this for normal pmd
>  	 */
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index db93cf747a03..aefde9bd3110 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -323,7 +323,7 @@ struct page *pud_page(pud_t pud)
>   */
>  struct page *pmd_page(pmd_t pmd)
>  {
> -	if (pmd_trans_huge(pmd) || pmd_huge(pmd))
> +	if (pmd_trans_huge(pmd) || pmd_huge(pmd) || pmd_devmap(pmd))
>  		return pte_page(pmd_pte(pmd));
>  	return virt_to_page(pmd_page_vaddr(pmd));
>  }
> -- 
> 2.9.3
