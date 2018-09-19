Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FQVY127VzF3Jq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 13:35:32 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8J3ZRrt024515
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 23:35:30 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mk95wanbq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 23:35:28 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 18 Sep 2018 23:35:15 -0400
Subject: Re: [PATCH v4 16/20] powerpc/mm: Extend pte_fragment functionality to
 nohash/32
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
 <a2f88be3bdaddc54a5836d6049c616b1739aef42.1537288312.git.christophe.leroy@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 19 Sep 2018 08:33:39 +0530
MIME-Version: 1.0
In-Reply-To: <a2f88be3bdaddc54a5836d6049c616b1739aef42.1537288312.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <89038b3e-f1cd-a4a0-481b-46cef2b5e388@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/18/18 10:27 PM, Christophe Leroy wrote:
> In order to allow the 8xx to handle pte_fragments, this patch
> extends the use of pte_fragments to nohash/32 platforms.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/mmu-40x.h           |  1 +
>   arch/powerpc/include/asm/mmu-44x.h           |  1 +
>   arch/powerpc/include/asm/mmu-8xx.h           |  1 +
>   arch/powerpc/include/asm/mmu-book3e.h        |  1 +
>   arch/powerpc/include/asm/mmu_context.h       |  2 +-
>   arch/powerpc/include/asm/nohash/32/pgalloc.h | 43 +++++++++++-----------------
>   arch/powerpc/include/asm/nohash/32/pgtable.h |  7 +++--
>   arch/powerpc/include/asm/page.h              |  6 +---
>   arch/powerpc/include/asm/pgtable.h           |  8 ++++++
>   arch/powerpc/mm/Makefile                     |  3 ++
>   arch/powerpc/mm/mmu_context_nohash.c         |  1 +
>   arch/powerpc/mm/pgtable-frag.c               |  6 ++++
>   arch/powerpc/mm/pgtable_32.c                 |  8 ++++--
>   13 files changed, 51 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu-40x.h b/arch/powerpc/include/asm/mmu-40x.h
> index 74f4edb5916e..7c77ceed71d6 100644
> --- a/arch/powerpc/include/asm/mmu-40x.h
> +++ b/arch/powerpc/include/asm/mmu-40x.h
> @@ -58,6 +58,7 @@ typedef struct {
>   	unsigned int	id;
>   	unsigned int	active;
>   	unsigned long	vdso_base;
> +	void *pte_frag;
>   } mm_context_t;
> 
>   #endif /* !__ASSEMBLY__ */
> diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
> index 295b3dbb2698..3d72e889ae7b 100644
> --- a/arch/powerpc/include/asm/mmu-44x.h
> +++ b/arch/powerpc/include/asm/mmu-44x.h
> @@ -109,6 +109,7 @@ typedef struct {
>   	unsigned int	id;
>   	unsigned int	active;
>   	unsigned long	vdso_base;
> +	void *pte_frag;
>   } mm_context_t;
> 
>   #endif /* !__ASSEMBLY__ */
> diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
> index fa05aa566ece..750cef6f65e3 100644
> --- a/arch/powerpc/include/asm/mmu-8xx.h
> +++ b/arch/powerpc/include/asm/mmu-8xx.h
> @@ -179,6 +179,7 @@ typedef struct {
>   	unsigned int id;
>   	unsigned int active;
>   	unsigned long vdso_base;
> +	void *pte_frag;
>   #ifdef CONFIG_PPC_MM_SLICES
>   	u16 user_psize;		/* page size index */
>   	unsigned char low_slices_psize[SLICE_ARRAY_SIZE];
> diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
> index e20072972e35..8e8aad5172ab 100644
> --- a/arch/powerpc/include/asm/mmu-book3e.h
> +++ b/arch/powerpc/include/asm/mmu-book3e.h
> @@ -230,6 +230,7 @@ typedef struct {
>   	unsigned int	id;
>   	unsigned int	active;
>   	unsigned long	vdso_base;
> +	void *pte_frag;
>   } mm_context_t;
> 
>   /* Page size definitions, common between 32 and 64-bit
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index b2f89b621b15..7f2c37a3f99d 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -222,7 +222,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
>   	return 0;
>   }
> 
> -#ifndef CONFIG_PPC_BOOK3S_64
> +#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_BOOK3S_32)
>   static inline void arch_exit_mmap(struct mm_struct *mm)
>   {
>   }
> diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
> index f3fec9052f31..e69423ad8e2e 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
> @@ -27,6 +27,9 @@ extern void __bad_pte(pmd_t *pmd);
>   extern struct kmem_cache *pgtable_cache[];
>   #define PGT_CACHE(shift) pgtable_cache[shift]
> 
> +pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel);
> +void pte_fragment_free(unsigned long *table, int kernel);
> +
>   static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>   {
>   	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
> @@ -58,11 +61,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
>   static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
>   				pgtable_t pte_page)
>   {
> -	*pmdp = __pmd((page_to_pfn(pte_page) << PAGE_SHIFT) | _PMD_USER |
> -		      _PMD_PRESENT);
> +	*pmdp = __pmd(__pa(pte_page) | _PMD_USER | _PMD_PRESENT);
>   }
> 
> -#define pmd_pgtable(pmd) pmd_page(pmd)
> +#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
>   #else
> 
>   static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
> @@ -74,49 +76,38 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
>   static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
>   				pgtable_t pte_page)
>   {
> -	*pmdp = __pmd((unsigned long)lowmem_page_address(pte_page) | _PMD_PRESENT);
> +	*pmdp = __pmd((unsigned long)pte_page | _PMD_PRESENT);
>   }
> 
> -#define pmd_pgtable(pmd) pmd_page(pmd)
> +#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
>   #endif
> 
> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> +					  unsigned long address)
>   {
> -	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	return (pte_t *)pte_fragment_alloc(mm, address, 1);
>   }
> 
> -static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
> +				      unsigned long address)
>   {
> -	struct page *ptepage;
> -
> -	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
> -
> -	ptepage = alloc_pages(flags, 0);
> -	if (!ptepage)
> -		return NULL;
> -	if (!pgtable_page_ctor(ptepage)) {
> -		__free_page(ptepage);
> -		return NULL;
> -	}
> -	return ptepage;
> +	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
>   }
> 
>   static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>   {
> -	free_page((unsigned long)pte);
> +	pte_fragment_free((unsigned long *)pte, 1);
>   }
> 
>   static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
>   {
> -	pgtable_page_dtor(ptepage);
> -	__free_page(ptepage);
> +	pte_fragment_free((unsigned long *)ptepage, 0);
>   }
> 
>   static inline void pgtable_free(void *table, unsigned index_size)
>   {
>   	if (!index_size) {
> -		pgtable_page_dtor(virt_to_page(table));
> -		free_page((unsigned long)table);
> +		pte_fragment_free((unsigned long *)table, 0);
>   	} else {
>   		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
>   		kmem_cache_free(PGT_CACHE(index_size), table);
> @@ -155,6 +146,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>   				  unsigned long address)
>   {
>   	tlb_flush_pgtable(tlb, address);
> -	pgtable_free_tlb(tlb, page_address(table), 0);
> +	pgtable_free_tlb(tlb, table, 0);
>   }
>   #endif /* _ASM_POWERPC_PGALLOC_32_H */
> diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
> index d2908a8038e8..73e2b1fbdb36 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
> @@ -336,12 +336,12 @@ static inline int pte_young(pte_t pte)
>    */
>   #ifndef CONFIG_BOOKE
>   #define pmd_page_vaddr(pmd)	\
> -	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
> +	((unsigned long)__va(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
>   #define pmd_page(pmd)		\
>   	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
>   #else
>   #define pmd_page_vaddr(pmd)	\
> -	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
> +	((unsigned long)(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
>   #define pmd_page(pmd)		\
>   	pfn_to_page((__pa(pmd_val(pmd)) >> PAGE_SHIFT))
>   #endif
> @@ -360,7 +360,8 @@ static inline int pte_young(pte_t pte)
>   	(pmd_bad(*(dir)) ? NULL : (pte_t *)pmd_page_vaddr(*(dir)) + \
>   				  pte_index(addr))
>   #define pte_offset_map(dir, addr)		\
> -	((pte_t *) kmap_atomic(pmd_page(*(dir))) + pte_index(addr))
> +	((pte_t *)(kmap_atomic(pmd_page(*(dir))) + \
> +		   (pmd_page_vaddr(*(dir)) & ~PAGE_MASK)) + pte_index(addr))
>   #define pte_unmap(pte)		kunmap_atomic(pte)
> 
>   /*
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index f6a1265face2..27d1c16601ee 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -335,7 +335,7 @@ void arch_free_page(struct page *page, int order);
>   #endif
> 
>   struct vm_area_struct;
> -#ifdef CONFIG_PPC_BOOK3S_64
> +#if !defined(CONFIG_PPC_BOOK3E_64) && !defined(CONFIG_PPC_BOOK3S_32)
>   /*
>    * For BOOK3s 64 with 4k and 64K linux page size
>    * we want to use pointers, because the page table
> @@ -343,12 +343,8 @@ struct vm_area_struct;
>    */
>   typedef pte_t *pgtable_t;
>   #else
> -#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC64)
> -typedef pte_t *pgtable_t;
> -#else
>   typedef struct page *pgtable_t;
>   #endif
> -#endif
> 


Now that is getting complicated. Is there a way to move that to platform 
header instead of that complicated #if?

>   #include <asm-generic/memory_model.h>
>   #endif /* __ASSEMBLY__ */
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 8b38f7730211..1865a3e4ab8c 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -94,12 +94,20 @@ unsigned long vmalloc_to_phys(void *vmalloc_addr);
>   void pgtable_cache_add(unsigned int shift);
>   void pgtable_cache_init(void);
> 
> +pte_t *early_alloc_pte(void);
> +
>   #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_PPC32)
>   void mark_initmem_nx(void);
>   #else
>   static inline void mark_initmem_nx(void) { }
>   #endif
> 
> +#ifndef PTE_FRAG_NR
> +#define PTE_FRAG_NR		1
> +#define PTE_FRAG_SIZE_SHIFT	PAGE_SHIFT
> +#define PTE_FRAG_SIZE		PAGE_SIZE
> +#endif
> +

IMHO we should avoid that. The #ifndef challenge is that we should 
always make sure the header inclusion is correct so that platform 
headers get included before. Why not move it to the platform that want 
to use pte fragmentation?


>   #endif /* __ASSEMBLY__ */
> 
>   #endif /* _ASM_POWERPC_PGTABLE_H */
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index bd43b3ee52cb..e1deb15fe85e 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -18,6 +18,9 @@ obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
>   obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o \
>   				   $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o \
>   				   pgtable-frag.o
> +ifndef CONFIG_PPC_BOOK3S_32
> +obj-$(CONFIG_PPC32)		+= pgtable-frag.o
> +endif
>   obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
>   obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
>   obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
> diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
> index 4d80239ef83c..98f0ef463dc8 100644
> --- a/arch/powerpc/mm/mmu_context_nohash.c
> +++ b/arch/powerpc/mm/mmu_context_nohash.c
> @@ -385,6 +385,7 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
>   #endif
>   	mm->context.id = MMU_NO_CONTEXT;
>   	mm->context.active = 0;
> +	mm->context.pte_frag = NULL;
>   	return 0;
>   }
> 
> diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> index ab4910e92aaf..d554a1cbc56d 100644
> --- a/arch/powerpc/mm/pgtable-frag.c
> +++ b/arch/powerpc/mm/pgtable-frag.c
> @@ -30,6 +30,7 @@ static void pte_frag_destroy(void *pte_frag)
>   	}
>   }
> 
> +#ifdef CONFIG_PPC_BOOK3S_64
>   static void pmd_frag_destroy(void *pmd_frag)
>   {
>   	int count;
> @@ -44,6 +45,7 @@ static void pmd_frag_destroy(void *pmd_frag)
>   		__free_page(page);
>   	}
>   }
> +#endif
> 
>   static void destroy_pagetable_cache(struct mm_struct *mm)
>   {
> @@ -53,15 +55,18 @@ static void destroy_pagetable_cache(struct mm_struct *mm)
>   	if (frag)
>   		pte_frag_destroy(frag);
> 
> +#ifdef CONFIG_PPC_BOOK3S_64
>   	frag = mm->context.pmd_frag;
>   	if (frag)
>   		pmd_frag_destroy(frag);
> +#endif
>   }
> 
>   void arch_exit_mmap(struct mm_struct *mm)
>   {
>   	destroy_pagetable_cache(mm);
> 
> +#ifdef CONFIG_PPC_BOOK3S_64
>   	if (radix_enabled()) {
>   		/*
>   		 * Radix doesn't have a valid bit in the process table
> @@ -79,6 +84,7 @@ void arch_exit_mmap(struct mm_struct *mm)
>   		 */
>   		process_tb[mm->context.id].prtb0 = 0;
>   	}
> +#endif
>   }
> 

is there a way to avoid all that #ifdef? May be redo the frag code such 
that we have few helpers that is platform independent?

>   static pte_t *get_pte_from_cache(struct mm_struct *mm)
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 7900b613e6e5..81e6b18d1955 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -195,12 +195,16 @@ EXPORT_SYMBOL(iounmap);
>   static __init pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va)
>   {
>   	if (!pmd_present(*pmdp)) {
> -		pte_t *ptep = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
> +		pte_t *ptep = __va(memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE));
> 
>   		if (!ptep)
>   			return NULL;
> 
> -		clear_page(ptep);
> +		if (PTE_FRAG_SIZE == PAGE_SIZE)
> +			clear_page(ptep);
> +		else
> +			memset(ptep, 0, PTE_FRAG_SIZE);
> +
>   		pmd_populate_kernel(&init_mm, pmdp, ptep);
>   	}
>   	return pte_offset_kernel(pmdp, va);
> 
