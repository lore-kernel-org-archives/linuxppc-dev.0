Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qv7JQ6sQdzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 13:05:42 +1000 (AEST)
Received: by mail-pf0-x235.google.com with SMTP id 206so1069879pfu.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 20:05:42 -0700 (PDT)
Subject: Re: [PATCH V2 53/68] powerpc/mm: Add radix pgalloc details
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-54-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <571EDAFF.8080407@gmail.com>
Date: Tue, 26 Apr 2016 13:05:35 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-54-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgalloc.h | 34 ++++++++++++++++++++++++----
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 ++++++--
>  arch/powerpc/mm/hash_utils_64.c              |  7 ++++++
>  arch/powerpc/mm/pgtable-radix.c              |  5 +++-
>  arch/powerpc/mm/pgtable_64.c                 |  6 +++++
>  5 files changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> index faad1319ba26..a282674b2378 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -50,19 +50,45 @@ extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
>  extern void __tlb_remove_table(void *_table);
>  #endif
>  
> +static inline pgd_t *rpgd_alloc(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_PPC_64K_PAGES
> +	return (pgd_t *)__get_free_page(PGALLOC_GFP);
> +#else
> +	struct page *page;
> +	page = alloc_pages(PGALLOC_GFP, 4);

We need a 2^4*4k = 64k page for PGD even for 4k pages? Why? One concern is that PGALLOC_GFP does not use CMA if I read the PGALLOC_GFP flags correct

> +	if (!page)
> +		return NULL;
> +	return (pgd_t *) page_address(page);
> +#endif
> +}
> +
> +static inline void rpgd_free(struct mm_struct *mm, pgd_t *pgd)
> +{
> +#ifdef CONFIG_PPC_64K_PAGES
> +	free_page((unsigned long)pgd);
> +#else
> +	free_pages((unsigned long)pgd, 4);
> +#endif
> +}
> +
>  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
> +	if (radix_enabled())
> +		return rpgd_alloc(mm);
>  	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE), GFP_KERNEL);
>  }
>  
>  static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>  {
> +	if (radix_enabled())
> +		return rpgd_free(mm, pgd);
>  	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
>  }
>  
>  static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
>  {
> -	pgd_set(pgd, __pgtable_ptr_val(pud));
> +	pgd_set(pgd, __pgtable_ptr_val(pud) | PGD_VAL_BITS);
>  }
>  
>  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
> @@ -78,7 +104,7 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>  
>  static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
>  {
> -	pud_set(pud, __pgtable_ptr_val(pmd));
> +	pud_set(pud, __pgtable_ptr_val(pmd) | PUD_VAL_BITS);
>  }
>  
>  static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
> @@ -107,13 +133,13 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
>  static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
>  				       pte_t *pte)
>  {
> -	pmd_set(pmd, __pgtable_ptr_val(pte));
> +	pmd_set(pmd, __pgtable_ptr_val(pte) | PMD_VAL_BITS);
>  }
>  
>  static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
>  				pgtable_t pte_page)
>  {
> -	pmd_set(pmd, __pgtable_ptr_val(pte_page));
> +	pmd_set(pmd, __pgtable_ptr_val(pte_page) | PMD_VAL_BITS);
>  }
>  
>  static inline pgtable_t pmd_pgtable(pmd_t pmd)
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index c16037116625..b8ee70458bae 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -170,11 +170,17 @@ extern unsigned long __pgd_table_size;
>  #define PMD_TABLE_SIZE	__pmd_table_size
>  #define PUD_TABLE_SIZE	__pud_table_size
>  #define PGD_TABLE_SIZE	__pgd_table_size
> +
> +extern unsigned long __pmd_val_bits;
> +extern unsigned long __pud_val_bits;
> +extern unsigned long __pgd_val_bits;
> +#define PMD_VAL_BITS	__pmd_val_bits
> +#define PUD_VAL_BITS	__pud_val_bits
> +#define PGD_VAL_BITS	__pgd_val_bits
>  /*
>   * Pgtable size used by swapper, init in asm code
> - * We will switch this later to radix PGD
>   */
> -#define MAX_PGD_TABLE_SIZE (sizeof(pgd_t) << H_PGD_INDEX_SIZE)
> +#define MAX_PGD_TABLE_SIZE (sizeof(pgd_t) << R_PGD_INDEX_SIZE)
>  
>  #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
>  #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index be5d123b3f61..aef691b75784 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -878,6 +878,13 @@ void __init hlearly_init_mmu(void)
>  	__pmd_table_size = H_PMD_TABLE_SIZE;
>  	__pud_table_size = H_PUD_TABLE_SIZE;
>  	__pgd_table_size = H_PGD_TABLE_SIZE;
> +	/*
> +	 * 4k use hugepd format, so for hash set then to
						^ them
> +	 * zero
> +	 */

The comment is not very clear

> +	__pmd_val_bits = 0;
> +	__pud_val_bits = 0;
> +	__pgd_val_bits = 0;
>  	/* Initialize the MMU Hash table and create the linear mapping
>  	 * of memory. Has to be done before SLB initialization as this is
>  	 * currently where the page size encoding is obtained.
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 52ed820a386a..5a0400fb5d71 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -318,8 +318,11 @@ void __init rearly_init_mmu(void)
>  	__pud_table_size = R_PUD_TABLE_SIZE;
>  	__pgd_table_size = R_PGD_TABLE_SIZE;
>  
> -	radix_init_page_sizes();
> +	__pmd_val_bits = R_PMD_VAL_BITS;
> +	__pud_val_bits = R_PUD_VAL_BITS;
> +	__pgd_val_bits = R_PGD_VAL_BITS;
>  
> +	radix_init_page_sizes();
>  	if (!firmware_has_feature(FW_FEATURE_LPAR))
>  		radix_init_partition_table();
>  
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index 78910035cbca..a58259793198 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -91,6 +91,12 @@ unsigned long __pud_table_size;
>  EXPORT_SYMBOL(__pud_table_size);
>  unsigned long __pgd_table_size;
>  EXPORT_SYMBOL(__pgd_table_size);
> +unsigned long __pmd_val_bits;
> +EXPORT_SYMBOL(__pmd_val_bits);
> +unsigned long __pud_val_bits;
> +EXPORT_SYMBOL(__pud_val_bits);
> +unsigned long __pgd_val_bits;
> +EXPORT_SYMBOL(__pgd_val_bits);
>  
>  #endif
>  unsigned long ioremap_bot = IOREMAP_BASE;
> 
