Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdFGG51LPzDsd9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 04:46:14 +1000 (AEST)
Subject: Re: [PATCH v2 1/3] powerpc: port 64 bits pgtable_cache to 32 bits
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
References: <cover.1474009019.git.christophe.leroy@c-s.fr>
 <82db857d48d3e2017267e67404d4b6748b66729c.1474009019.git.christophe.leroy@c-s.fr>
 <87shswxy3q.fsf@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <9c2baeaa-17f6-b00c-0870-062c3ee4a5d6@c-s.fr>
Date: Mon, 19 Sep 2016 20:46:08 +0200
MIME-Version: 1.0
In-Reply-To: <87shswxy3q.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/09/2016 à 07:22, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> Today powerpc64 uses a set of pgtable_caches while powerpc32 uses
>> standard pages when using 4k pages and a single pgtable_cache
>> if using other size pages.
>>
>> In preparation of implementing huge pages on the 8xx, this patch
>> replaces the specific powerpc32 handling by the 64 bits approach.
>>
>> This is done by:
>> * moving 64 bits pgtable_cache_add() and pgtable_cache_init()
>> in a new file called init-common.c
>> * modifying pgtable_cache_init() to also handle the case
>> without PMD
>> * removing the 32 bits version of pgtable_cache_add() and
>> pgtable_cache_init()
>> * copying related header contents from 64 bits into both the
>> book3s/32 and nohash/32 header files
>>
>> On the 8xx, the following cache sizes will be used:
>> * 4k pages mode:
>> - PGT_CACHE(10) for PGD
>> - PGT_CACHE(3) for 512k hugepage tables
>> * 16k pages mode:
>> - PGT_CACHE(6) for PGD
>> - PGT_CACHE(7) for 512k hugepage tables
>> - PGT_CACHE(3) for 8M hugepage tables
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> v2: in v1, hugepte_cache was wrongly replaced by PGT_CACHE(1).
>> This modification has been removed from v2.
>>
>>  arch/powerpc/include/asm/book3s/32/pgalloc.h |  44 ++++++--
>>  arch/powerpc/include/asm/book3s/32/pgtable.h |  43 ++++----
>>  arch/powerpc/include/asm/book3s/64/pgtable.h |   3 -
>>  arch/powerpc/include/asm/nohash/32/pgalloc.h |  44 ++++++--
>>  arch/powerpc/include/asm/nohash/32/pgtable.h |  45 ++++----
>>  arch/powerpc/include/asm/nohash/64/pgtable.h |   2 -
>>  arch/powerpc/include/asm/pgtable.h           |   2 +
>>  arch/powerpc/mm/Makefile                     |   3 +-
>>  arch/powerpc/mm/init-common.c                | 147 +++++++++++++++++++++++++++
>>  arch/powerpc/mm/init_64.c                    |  77 --------------
>>  arch/powerpc/mm/pgtable_32.c                 |  37 -------
>>  11 files changed, 273 insertions(+), 174 deletions(-)
>>  create mode 100644 arch/powerpc/mm/init-common.c
>>
>> diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
>> index 8e21bb4..d310546 100644
>> --- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
>> +++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
>> @@ -2,14 +2,42 @@
>>  #define _ASM_POWERPC_BOOK3S_32_PGALLOC_H
>>
>>  #include <linux/threads.h>
>> +#include <linux/slab.h>
>>
>> -/* For 32-bit, all levels of page tables are just drawn from get_free_page() */
>> -#define MAX_PGTABLE_INDEX_SIZE	0
>> +/*
>> + * Functions that deal with pagetables that could be at any level of
>> + * the table need to be passed an "index_size" so they know how to
>> + * handle allocation.  For PTE pages (which are linked to a struct
>> + * page for now, and drawn from the main get_free_pages() pool), the
>> + * allocation size will be (2^index_size * sizeof(pointer)) and
>> + * allocations are drawn from the kmem_cache in PGT_CACHE(index_size).
>> + *
>> + * The maximum index size needs to be big enough to allow any
>> + * pagetable sizes we need, but small enough to fit in the low bits of
>> + * any page table pointer.  In other words all pagetables, even tiny
>> + * ones, must be aligned to allow at least enough low 0 bits to
>> + * contain this value.  This value is also used as a mask, so it must
>> + * be one less than a power of two.
>> + */
>> +#define MAX_PGTABLE_INDEX_SIZE	0xf
>>
>>  extern void __bad_pte(pmd_t *pmd);
>>
>> -extern pgd_t *pgd_alloc(struct mm_struct *mm);
>> -extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
>> +extern struct kmem_cache *pgtable_cache[];
>> +#define PGT_CACHE(shift) ({				\
>> +			BUG_ON(!(shift));		\
>> +			pgtable_cache[(shift) - 1];	\
>> +		})
>> +
>> +static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>> +{
>> +	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE), GFP_KERNEL);
>> +}
>> +
>> +static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>> +{
>> +	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
>> +}
>>
>>  /*
>>   * We don't have any real pmd's, and this code never triggers because
>> @@ -68,8 +96,12 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
>>
>>  static inline void pgtable_free(void *table, unsigned index_size)
>>  {
>> -	BUG_ON(index_size); /* 32-bit doesn't use this */
>> -	free_page((unsigned long)table);
>> +	if (!index_size) {
>> +		free_page((unsigned long)table);
>> +	} else {
>> +		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
>> +		kmem_cache_free(PGT_CACHE(index_size), table);
>> +	}
>>  }
>>
>>  #define check_pgt_cache()	do { } while (0)
>> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
>> index 6b8b2d5..f887499 100644
>> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
>> @@ -8,6 +8,26 @@
>>  /* And here we include common definitions */
>>  #include <asm/pte-common.h>
>>
>> +#define PTE_INDEX_SIZE	PTE_SHIFT
>> +#define PMD_INDEX_SIZE	0
>> +#define PUD_INDEX_SIZE	0
>> +#define PGD_INDEX_SIZE	(32 - PGDIR_SHIFT)
>> +
>> +#define PMD_CACHE_INDEX	PMD_INDEX_SIZE
>> +
>> +#ifndef __ASSEMBLY__
>> +#define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
>> +#define PMD_TABLE_SIZE	(sizeof(pmd_t) << PTE_INDEX_SIZE)
>> +#define PUD_TABLE_SIZE	(sizeof(pud_t) << PTE_INDEX_SIZE)
>> +#define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
>> +#endif	/* __ASSEMBLY__ */
>
> Are these table size correct ? IIUC, We will have only PGD and PTE
> tables right ?

Oops, copy/paste error.
We won't have those tables, they won't be created as PMD_INDEX_SIZE and 
PUD_INDEX_SIZE are 0. But they need to be defined to avoid compilation 
errors of pmd_ctor() and pud_ctor()
Then what should I do ? Define them as 0, or just keep the standard 
definition which follows ?
#define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
#define PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)

>
>
>> +
>> +#define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
>> +#define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
>> +
>> +/* With 4k base page size, hugepage PTEs go at the PMD level */
>> +#define MIN_HUGEPTE_SHIFT	PMD_SHIFT
>> +
>
> What does that comment mean ? I guess that came from copy-paste from
> other headers. I am not sure what it means there either other than the
> 64k hash config, where we place hugepage PTE at the PMD level. (ie, no hugepd).

Well, I'll remove the comment from here.

>
>
>>  /*
>>   * The normal case is that PTEs are 32-bits and we have a 1-page
>>   * 1024-entry pgdir pointing to 1-page 1024-entry PTE pages.  -- paulus
>> @@ -19,14 +39,10 @@
>>   * -Matt
>>   */
>>  /* PGDIR_SHIFT determines what a top-level page table entry can map */
>> -#define PGDIR_SHIFT	(PAGE_SHIFT + PTE_SHIFT)
>> +#define PGDIR_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
>>  #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
>>  #define PGDIR_MASK	(~(PGDIR_SIZE-1))
>>
>> -#define PTRS_PER_PTE	(1 << PTE_SHIFT)
>> -#define PTRS_PER_PMD	1
>> -#define PTRS_PER_PGD	(1 << (32 - PGDIR_SHIFT))
>> -
>>  #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
>>  /*
>>   * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
>> @@ -82,12 +98,8 @@
>>
>>  extern unsigned long ioremap_bot;
>>
>> -/*
>> - * entries per page directory level: our page-table tree is two-level, so
>> - * we don't really have any PMD directory.
>> - */
>> -#define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_SHIFT)
>> -#define PGD_TABLE_SIZE	(sizeof(pgd_t) << (32 - PGDIR_SHIFT))
>> +/* Bits to mask out from a PGD to get to the PUD page */
>> +#define PGD_MASKED_BITS		0
>>
>>  #define pte_ERROR(e) \
>>  	pr_err("%s:%d: bad pte %llx.\n", __FILE__, __LINE__, \
>> @@ -283,15 +295,6 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
>>  #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
>>  #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
>>
>> -#ifndef CONFIG_PPC_4K_PAGES
>> -void pgtable_cache_init(void);
>> -#else
>> -/*
>> - * No page table caches to initialise
>> - */
>> -#define pgtable_cache_init()	do { } while (0)
>> -#endif
>> -
>>  extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep,
>>  		      pmd_t **pmdp);
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index 9fd77f8..0a46a5f 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -789,9 +789,6 @@ extern struct page *pgd_page(pgd_t pgd);
>>  #define pgd_ERROR(e) \
>>  	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
>>
>> -void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
>> -void pgtable_cache_init(void);
>> -
>>  static inline int map_kernel_page(unsigned long ea, unsigned long pa,
>>  				  unsigned long flags)
>>  {
>> diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
>> index 76d6b9e..6331392 100644
>> --- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
>> +++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
>> @@ -2,14 +2,42 @@
>>  #define _ASM_POWERPC_PGALLOC_32_H
>>
>>  #include <linux/threads.h>
>> +#include <linux/slab.h>
>>
>> -/* For 32-bit, all levels of page tables are just drawn from get_free_page() */
>> -#define MAX_PGTABLE_INDEX_SIZE	0
>> +/*
>> + * Functions that deal with pagetables that could be at any level of
>> + * the table need to be passed an "index_size" so they know how to
>> + * handle allocation.  For PTE pages (which are linked to a struct
>> + * page for now, and drawn from the main get_free_pages() pool), the
>> + * allocation size will be (2^index_size * sizeof(pointer)) and
>> + * allocations are drawn from the kmem_cache in PGT_CACHE(index_size).
>> + *
>> + * The maximum index size needs to be big enough to allow any
>> + * pagetable sizes we need, but small enough to fit in the low bits of
>> + * any page table pointer.  In other words all pagetables, even tiny
>> + * ones, must be aligned to allow at least enough low 0 bits to
>> + * contain this value.  This value is also used as a mask, so it must
>> + * be one less than a power of two.
>> + */
>> +#define MAX_PGTABLE_INDEX_SIZE	0xf
>>
>>  extern void __bad_pte(pmd_t *pmd);
>>
>> -extern pgd_t *pgd_alloc(struct mm_struct *mm);
>> -extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
>> +extern struct kmem_cache *pgtable_cache[];
>> +#define PGT_CACHE(shift) ({				\
>> +			BUG_ON(!(shift));		\
>> +			pgtable_cache[(shift) - 1];	\
>> +		})
>> +
>> +static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>> +{
>> +	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE), GFP_KERNEL);
>> +}
>> +
>> +static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>> +{
>> +	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
>> +}
>>
>>  /*
>>   * We don't have any real pmd's, and this code never triggers because
>> @@ -68,8 +96,12 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
>>
>>  static inline void pgtable_free(void *table, unsigned index_size)
>>  {
>> -	BUG_ON(index_size); /* 32-bit doesn't use this */
>> -	free_page((unsigned long)table);
>> +	if (!index_size) {
>> +		free_page((unsigned long)table);
>> +	} else {
>> +		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
>> +		kmem_cache_free(PGT_CACHE(index_size), table);
>> +	}
>>  }
>>
>>  #define check_pgt_cache()	do { } while (0)
>> diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
>> index c219ef7..8cbe222 100644
>> --- a/arch/powerpc/include/asm/nohash/32/pgtable.h
>> +++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
>> @@ -16,6 +16,26 @@ extern int icache_44x_need_flush;
>>
>>  #endif /* __ASSEMBLY__ */
>>
>> +#define PTE_INDEX_SIZE	PTE_SHIFT
>> +#define PMD_INDEX_SIZE	0
>> +#define PUD_INDEX_SIZE	0
>> +#define PGD_INDEX_SIZE	(32 - PGDIR_SHIFT)
>> +
>> +#define PMD_CACHE_INDEX	PMD_INDEX_SIZE
>> +
>> +#ifndef __ASSEMBLY__
>> +#define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
>> +#define PMD_TABLE_SIZE	(sizeof(pmd_t) << PTE_INDEX_SIZE)
>> +#define PUD_TABLE_SIZE	(sizeof(pud_t) << PTE_INDEX_SIZE)
>> +#define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
>> +#endif	/* __ASSEMBLY__ */
>> +
>
> Same, please comment on why those TABLE sizes ?
>

Yes same error, will fix it the same way.

>
>> +#define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
>> +#define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
>> +
>> +/* With 4k base page size, hugepage PTEs go at the PMD level */
>> +#define MIN_HUGEPTE_SHIFT	PMD_SHIFT
>> +
>>  /*
>>   * The normal case is that PTEs are 32-bits and we have a 1-page
>>   * 1024-entry pgdir pointing to 1-page 1024-entry PTE pages.  -- paulus
>> @@ -27,22 +47,12 @@ extern int icache_44x_need_flush;
>>   * -Matt
>>   */
>>  /* PGDIR_SHIFT determines what a top-level page table entry can map */
>> -#define PGDIR_SHIFT	(PAGE_SHIFT + PTE_SHIFT)
>> +#define PGDIR_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
>>  #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
>>  #define PGDIR_MASK	(~(PGDIR_SIZE-1))
>>
>> -/*
>> - * entries per page directory level: our page-table tree is two-level, so
>> - * we don't really have any PMD directory.
>> - */
>> -#ifndef __ASSEMBLY__
>> -#define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_SHIFT)
>> -#define PGD_TABLE_SIZE	(sizeof(pgd_t) << (32 - PGDIR_SHIFT))
>> -#endif	/* __ASSEMBLY__ */
>> -
>> -#define PTRS_PER_PTE	(1 << PTE_SHIFT)
>> -#define PTRS_PER_PMD	1
>> -#define PTRS_PER_PGD	(1 << (32 - PGDIR_SHIFT))
>> +/* Bits to mask out from a PGD to get to the PUD page */
>> +#define PGD_MASKED_BITS		0
>>
>>  #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
>>  #define FIRST_USER_ADDRESS	0UL
>> @@ -328,15 +338,6 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
>>  #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
>>  #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
>>
>> -#ifndef CONFIG_PPC_4K_PAGES
>> -void pgtable_cache_init(void);
>> -#else
>> -/*
>> - * No page table caches to initialise
>> - */
>> -#define pgtable_cache_init()	do { } while (0)
>> -#endif
>> -
>>  extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep,
>>  		      pmd_t **pmdp);
>>
>> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
>> index 653a183..619018a 100644
>> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
>> @@ -358,8 +358,6 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
>>  #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
>>  #define __swp_entry_to_pte(x)		__pte((x).val)
>>
>> -void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
>> -void pgtable_cache_init(void);
>>  extern int map_kernel_page(unsigned long ea, unsigned long pa,
>>  			   unsigned long flags);
>>  extern int __meminit vmemmap_create_mapping(unsigned long start,
>> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
>> index 9bd87f2..dd01212 100644
>> --- a/arch/powerpc/include/asm/pgtable.h
>> +++ b/arch/powerpc/include/asm/pgtable.h
>> @@ -78,6 +78,8 @@ static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
>>
>>  unsigned long vmalloc_to_phys(void *vmalloc_addr);
>>
>> +void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
>> +void pgtable_cache_init(void);
>>  #endif /* __ASSEMBLY__ */
>>
>>  #endif /* _ASM_POWERPC_PGTABLE_H */
>> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
>> index 1a4e570..e8a86d2 100644
>> --- a/arch/powerpc/mm/Makefile
>> +++ b/arch/powerpc/mm/Makefile
>> @@ -7,7 +7,8 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>>  ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
>>
>>  obj-y				:= fault.o mem.o pgtable.o mmap.o \
>> -				   init_$(BITS).o pgtable_$(BITS).o
>> +				   init_$(BITS).o pgtable_$(BITS).o \
>> +				   init-common.o
>>  obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
>>  				   tlb_nohash_low.o
>>  obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
>> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
>> new file mode 100644
>> index 0000000..ab2b947
>> --- /dev/null
>> +++ b/arch/powerpc/mm/init-common.c
>> @@ -0,0 +1,147 @@
>> +/*
>> + *  PowerPC version
>> + *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
>> + *
>> + *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
>> + *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
>> + *    Copyright (C) 1996 Paul Mackerras
>> + *
>> + *  Derived from "arch/i386/mm/init.c"
>> + *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
>> + *
>> + *  Dave Engebretsen <engebret@us.ibm.com>
>> + *      Rework for PPC64 port.
>> + *
>> + *  This program is free software; you can redistribute it and/or
>> + *  modify it under the terms of the GNU General Public License
>> + *  as published by the Free Software Foundation; either version
>> + *  2 of the License, or (at your option) any later version.
>> + *
>> + */
>> +
>> +#undef DEBUG
>> +
>> +#include <linux/signal.h>
>> +#include <linux/sched.h>
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/string.h>
>> +#include <linux/types.h>
>> +#include <linux/mman.h>
>> +#include <linux/mm.h>
>> +#include <linux/swap.h>
>> +#include <linux/stddef.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/init.h>
>> +#include <linux/delay.h>
>> +#include <linux/highmem.h>
>> +#include <linux/idr.h>
>> +#include <linux/nodemask.h>
>> +#include <linux/module.h>
>> +#include <linux/poison.h>
>> +#include <linux/memblock.h>
>> +#include <linux/hugetlb.h>
>> +#include <linux/slab.h>
>> +
>> +#include <asm/pgalloc.h>
>> +#include <asm/page.h>
>> +#include <asm/prom.h>
>> +#include <asm/rtas.h>
>> +#include <asm/io.h>
>> +#include <asm/mmu_context.h>
>> +#include <asm/pgtable.h>
>> +#include <asm/mmu.h>
>> +#include <asm/uaccess.h>
>> +#include <asm/smp.h>
>> +#include <asm/machdep.h>
>> +#include <asm/tlb.h>
>> +#include <asm/eeh.h>
>> +#include <asm/processor.h>
>> +#include <asm/mmzone.h>
>> +#include <asm/cputable.h>
>> +#include <asm/sections.h>
>> +#include <asm/iommu.h>
>> +#include <asm/vdso.h>
>> +
>> +#include "mmu_decl.h"
>
>
> Do you need all these headers to get it compiled ?
>

Probably not, I just copied the ones from init_64.c
Will clean it up.

>
>> +
>> +static void pgd_ctor(void *addr)
>> +{
>> +	memset(addr, 0, PGD_TABLE_SIZE);
>> +}
>> +
>> +static void pud_ctor(void *addr)
>> +{
>> +	memset(addr, 0, PUD_TABLE_SIZE);
>> +}
>> +
>> +static void pmd_ctor(void *addr)
>> +{
>> +	memset(addr, 0, PMD_TABLE_SIZE);
>> +}
>> +
>> +struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
>> +
>> +/*
>> + * Create a kmem_cache() for pagetables.  This is not used for PTE
>> + * pages - they're linked to struct page, come from the normal free
>> + * pages pool and have a different entry size (see real_pte_t) to
>> + * everything else.  Caches created by this function are used for all
>> + * the higher level pagetables, and for hugepage pagetables.
>> + */
>> +void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
>> +{
>> +	char *name;
>> +	unsigned long table_size = sizeof(void *) << shift;
>> +	unsigned long align = table_size;
>> +
>> +	/* When batching pgtable pointers for RCU freeing, we store
>> +	 * the index size in the low bits.  Table alignment must be
>> +	 * big enough to fit it.
>> +	 *
>> +	 * Likewise, hugeapge pagetable pointers contain a (different)
>> +	 * shift value in the low bits.  All tables must be aligned so
>> +	 * as to leave enough 0 bits in the address to contain it. */
>> +	unsigned long minalign = max(MAX_PGTABLE_INDEX_SIZE + 1,
>> +				     HUGEPD_SHIFT_MASK + 1);
>> +	struct kmem_cache *new;
>> +
>> +	/* It would be nice if this was a BUILD_BUG_ON(), but at the
>> +	 * moment, gcc doesn't seem to recognize is_power_of_2 as a
>> +	 * constant expression, so so much for that. */
>> +	BUG_ON(!is_power_of_2(minalign));
>> +	BUG_ON((shift < 1) || (shift > MAX_PGTABLE_INDEX_SIZE));
>> +
>> +	if (PGT_CACHE(shift))
>> +		return; /* Already have a cache of this size */
>> +
>> +	align = max_t(unsigned long, align, minalign);
>> +	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
>> +	new = kmem_cache_create(name, table_size, align, 0, ctor);
>> +	kfree(name);
>> +	pgtable_cache[shift - 1] = new;
>> +	pr_debug("Allocated pgtable cache for order %d\n", shift);
>> +}
>> +
>> +
>> +void pgtable_cache_init(void)
>> +{
>> +	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
>> +
>> +	if (PMD_INDEX_SIZE && !PGT_CACHE(PMD_INDEX_SIZE))
>> +		pgtable_cache_add(PMD_CACHE_INDEX, pmd_ctor);
>> +	/*
>> +	 * In all current configs, when the PUD index exists it's the
>> +	 * same size as either the pgd or pmd index except with THP enabled
>> +	 * on book3s 64
>> +	 */
>> +	if (PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE))
>> +		pgtable_cache_add(PUD_INDEX_SIZE, pud_ctor);
>> +
>> +	if (!PGT_CACHE(PGD_INDEX_SIZE))
>> +		panic("Couldn't allocate pgd cache");
>> +	if (PMD_INDEX_SIZE && !PGT_CACHE(PMD_INDEX_SIZE))
>> +		panic("Couldn't allocate pmd pgtable caches");
>> +	if (PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE))
>> +		panic("Couldn't allocate pud pgtable caches");
>> +}
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index 16ada1e..a000c35 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -80,83 +80,6 @@ EXPORT_SYMBOL_GPL(memstart_addr);
>>  phys_addr_t kernstart_addr;
>>  EXPORT_SYMBOL_GPL(kernstart_addr);
>>
>> -static void pgd_ctor(void *addr)
>> -{
>> -	memset(addr, 0, PGD_TABLE_SIZE);
>> -}
>> -
>> -static void pud_ctor(void *addr)
>> -{
>> -	memset(addr, 0, PUD_TABLE_SIZE);
>> -}
>> -
>> -static void pmd_ctor(void *addr)
>> -{
>> -	memset(addr, 0, PMD_TABLE_SIZE);
>> -}
>> -
>> -struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
>> -
>> -/*
>> - * Create a kmem_cache() for pagetables.  This is not used for PTE
>> - * pages - they're linked to struct page, come from the normal free
>> - * pages pool and have a different entry size (see real_pte_t) to
>> - * everything else.  Caches created by this function are used for all
>> - * the higher level pagetables, and for hugepage pagetables.
>> - */
>> -void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
>> -{
>> -	char *name;
>> -	unsigned long table_size = sizeof(void *) << shift;
>> -	unsigned long align = table_size;
>> -
>> -	/* When batching pgtable pointers for RCU freeing, we store
>> -	 * the index size in the low bits.  Table alignment must be
>> -	 * big enough to fit it.
>> -	 *
>> -	 * Likewise, hugeapge pagetable pointers contain a (different)
>> -	 * shift value in the low bits.  All tables must be aligned so
>> -	 * as to leave enough 0 bits in the address to contain it. */
>> -	unsigned long minalign = max(MAX_PGTABLE_INDEX_SIZE + 1,
>> -				     HUGEPD_SHIFT_MASK + 1);
>> -	struct kmem_cache *new;
>> -
>> -	/* It would be nice if this was a BUILD_BUG_ON(), but at the
>> -	 * moment, gcc doesn't seem to recognize is_power_of_2 as a
>> -	 * constant expression, so so much for that. */
>> -	BUG_ON(!is_power_of_2(minalign));
>> -	BUG_ON((shift < 1) || (shift > MAX_PGTABLE_INDEX_SIZE));
>> -
>> -	if (PGT_CACHE(shift))
>> -		return; /* Already have a cache of this size */
>> -
>> -	align = max_t(unsigned long, align, minalign);
>> -	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
>> -	new = kmem_cache_create(name, table_size, align, 0, ctor);
>> -	kfree(name);
>> -	pgtable_cache[shift - 1] = new;
>> -	pr_debug("Allocated pgtable cache for order %d\n", shift);
>> -}
>> -
>> -
>> -void pgtable_cache_init(void)
>> -{
>> -	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
>> -	pgtable_cache_add(PMD_CACHE_INDEX, pmd_ctor);
>> -	/*
>> -	 * In all current configs, when the PUD index exists it's the
>> -	 * same size as either the pgd or pmd index except with THP enabled
>> -	 * on book3s 64
>> -	 */
>> -	if (PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE))
>> -		pgtable_cache_add(PUD_INDEX_SIZE, pud_ctor);
>> -
>> -	if (!PGT_CACHE(PGD_INDEX_SIZE) || !PGT_CACHE(PMD_CACHE_INDEX))
>> -		panic("Couldn't allocate pgtable caches");
>> -	if (PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE))
>> -		panic("Couldn't allocate pud pgtable caches");
>> -}
>> -
>>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>>  /*
>>   * Given an address within the vmemmap, determine the pfn of the page that
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index 0ae0572..a65c0b4 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -42,43 +42,6 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
>>
>>  extern char etext[], _stext[], _sinittext[], _einittext[];
>>
>> -#define PGDIR_ORDER	(32 + PGD_T_LOG2 - PGDIR_SHIFT)
>> -
>> -#ifndef CONFIG_PPC_4K_PAGES
>> -static struct kmem_cache *pgtable_cache;
>> -
>> -void pgtable_cache_init(void)
>> -{
>> -	pgtable_cache = kmem_cache_create("PGDIR cache", 1 << PGDIR_ORDER,
>> -					  1 << PGDIR_ORDER, 0, NULL);
>> -	if (pgtable_cache == NULL)
>> -		panic("Couldn't allocate pgtable caches");
>> -}
>> -#endif
>> -
>> -pgd_t *pgd_alloc(struct mm_struct *mm)
>> -{
>> -	pgd_t *ret;
>> -
>> -	/* pgdir take page or two with 4K pages and a page fraction otherwise */
>> -#ifndef CONFIG_PPC_4K_PAGES
>> -	ret = kmem_cache_alloc(pgtable_cache, GFP_KERNEL | __GFP_ZERO);
>> -#else
>> -	ret = (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO,
>> -			PGDIR_ORDER - PAGE_SHIFT);
>> -#endif
>> -	return ret;
>> -}
>> -
>> -void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>> -{
>> -#ifndef CONFIG_PPC_4K_PAGES
>> -	kmem_cache_free(pgtable_cache, (void *)pgd);
>> -#else
>> -	free_pages((unsigned long)pgd, PGDIR_ORDER - PAGE_SHIFT);
>> -#endif
>> -}
>> -
>>  __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
>>  {
>>  	pte_t *pte;
>> --
>> 2.1.0

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
