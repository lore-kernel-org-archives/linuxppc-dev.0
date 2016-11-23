Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP0MB5CjjzDvjl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 22:23:18 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id x23so920601pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 03:23:18 -0800 (PST)
Subject: Re: [PATCH v5 1/7] powerpc/mm: update ptep_set_access_flag to not do
 full mm tlb flush
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <fe12e986-0c81-a71c-29a2-a8ca4ea2600c@gmail.com>
Date: Wed, 23 Nov 2016 22:23:16 +1100
MIME-Version: 1.0
In-Reply-To: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/11/16 22:09, Aneesh Kumar K.V wrote:
> When we are updating pte, we just need to flush the tlb mapping for
> that pte. Right now we do a full mm flush because we don't track page
> size. Update the interface to track the page size and use that to
> do the right tlb flush.
> 

Could you also clarify the scope -- this seems to be _radix_ only.
The problem statement is not very clear and why doesn't the flush_tlb_page()
following ptep_set_access_flags() work? What else do we need to do?


> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  4 +++-
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++++--
>  arch/powerpc/include/asm/book3s/64/radix.h   | 14 +++++++-------
>  arch/powerpc/include/asm/nohash/32/pgtable.h |  4 +++-
>  arch/powerpc/include/asm/nohash/64/pgtable.h |  4 +++-
>  arch/powerpc/mm/pgtable-book3s64.c           |  3 ++-
>  arch/powerpc/mm/pgtable-radix.c              | 16 ++++++++++++++++
>  arch/powerpc/mm/pgtable.c                    | 10 ++++++++--
>  arch/powerpc/mm/tlb-radix.c                  | 15 ---------------
>  9 files changed, 47 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index 6b8b2d57fdc8..cd835e74e633 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -224,7 +224,9 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  
>  
>  static inline void __ptep_set_access_flags(struct mm_struct *mm,
> -					   pte_t *ptep, pte_t entry)
> +					   pte_t *ptep, pte_t entry,
> +					   unsigned long address,
> +					   unsigned long page_size)
>  {
>  	unsigned long set = pte_val(entry) &
>  		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 86870c11917b..761622ec7f2a 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -580,10 +580,13 @@ static inline bool check_pte_access(unsigned long access, unsigned long ptev)
>   */
>  
>  static inline void __ptep_set_access_flags(struct mm_struct *mm,
> -					   pte_t *ptep, pte_t entry)
> +					   pte_t *ptep, pte_t entry,
> +					   unsigned long address,
> +					   unsigned long page_size)
>  {
>  	if (radix_enabled())
> -		return radix__ptep_set_access_flags(mm, ptep, entry);
> +		return radix__ptep_set_access_flags(mm, ptep, entry,
> +						    address, page_size);
>  	return hash__ptep_set_access_flags(ptep, entry);
>  }
>  
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
> index 2a46dea8e1b1..e104004bf2b1 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -110,6 +110,7 @@
>  #define RADIX_PUD_TABLE_SIZE	(sizeof(pud_t) << RADIX_PUD_INDEX_SIZE)
>  #define RADIX_PGD_TABLE_SIZE	(sizeof(pgd_t) << RADIX_PGD_INDEX_SIZE)
>  
> +extern int radix_get_mmu_psize(unsigned long page_size);
>  static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
>  					       unsigned long set)
>  {
> @@ -167,7 +168,9 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
>   * function doesn't need to invalidate tlb.
>   */
>  static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
> -						pte_t *ptep, pte_t entry)
> +						pte_t *ptep, pte_t entry,
> +						unsigned long address,
> +						unsigned long page_size)
>  {
>  
>  	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
> @@ -175,6 +178,7 @@ static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
>  
>  	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
>  
> +		int psize;
>  		unsigned long old_pte, new_pte;
>  
>  		old_pte = __radix_pte_update(ptep, ~0, 0);
> @@ -183,12 +187,8 @@ static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
>  		 * new value of pte
>  		 */
>  		new_pte = old_pte | set;
> -
> -		/*
> -		 * For now let's do heavy pid flush
> -		 * radix__flush_tlb_page_psize(mm, addr, mmu_virtual_psize);
> -		 */
> -		radix__flush_tlb_mm(mm);
> +		psize = radix_get_mmu_psize(page_size);
> +		radix__flush_tlb_page_psize(mm, address, psize);
>  
>  		__radix_pte_update(ptep, 0, new_pte);
>  	} else
> diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
> index c219ef7be53b..4153b8e591a4 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
> @@ -268,7 +268,9 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  
>  
>  static inline void __ptep_set_access_flags(struct mm_struct *mm,
> -					   pte_t *ptep, pte_t entry)
> +					   pte_t *ptep, pte_t entry,
> +					   unsigned long address,
> +					   unsigned long page_size)
>  {
>  	unsigned long set = pte_val(entry) &
>  		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> index 653a1838469d..7e42b8195e85 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -301,7 +301,9 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
>   * function doesn't need to flush the hash entry
>   */
>  static inline void __ptep_set_access_flags(struct mm_struct *mm,
> -					   pte_t *ptep, pte_t entry)
> +					   pte_t *ptep, pte_t entry,
> +					   unsigned long address,
> +					   unsigned long page_size)
>  {
>  	unsigned long bits = pte_val(entry) &
>  		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index f4f437cbabf1..5c7c501b7cae 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -35,7 +35,8 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>  #endif
>  	changed = !pmd_same(*(pmdp), entry);
>  	if (changed) {
> -		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp), pmd_pte(entry));
> +		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp), pmd_pte(entry),
> +					address, HPAGE_PMD_SIZE);
>  		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>  	}
>  	return changed;
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 688b54517655..416918005395 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -222,6 +222,22 @@ static int __init get_idx_from_shift(unsigned int shift)
>  	return idx;
>  }
>  
> +int radix_get_mmu_psize(unsigned long page_size)
> +{
> +	int psize;
> +
> +	if (page_size == (1UL << mmu_psize_defs[mmu_virtual_psize].shift))
> +		psize = mmu_virtual_psize;
> +	else if (page_size == (1UL << mmu_psize_defs[MMU_PAGE_2M].shift))
> +		psize = MMU_PAGE_2M;
> +	else if (page_size == (1UL << mmu_psize_defs[MMU_PAGE_1G].shift))
> +		psize = MMU_PAGE_1G;
> +	else
> +		return -1;
> +	return psize;
> +}
> +
> +
>  static int __init radix_dt_scan_page_sizes(unsigned long node,
>  					   const char *uname, int depth,
>  					   void *data)
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index 911fdfb63ec1..503ae9bd3efe 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -219,12 +219,18 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>  			  pte_t *ptep, pte_t entry, int dirty)
>  {
>  	int changed;
> +	unsigned long page_size;
> +
>  	entry = set_access_flags_filter(entry, vma, dirty);
>  	changed = !pte_same(*(ptep), entry);
>  	if (changed) {
> -		if (!is_vm_hugetlb_page(vma))
> +		if (!is_vm_hugetlb_page(vma)) {
> +			page_size = PAGE_SIZE;
>  			assert_pte_locked(vma->vm_mm, address);
> -		__ptep_set_access_flags(vma->vm_mm, ptep, entry);
> +		} else
> +			page_size = huge_page_size(hstate_vma(vma));
> +		__ptep_set_access_flags(vma->vm_mm, ptep, entry,
> +					address, page_size);
>  		flush_tlb_page(vma, address);

Can't we use this flush_tlb_page() or a modification inside it to do the job?

Thanks,
Balbir
