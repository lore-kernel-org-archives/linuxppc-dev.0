Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PmMm63cwzF1RT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 21:28:04 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3GBQeap120328
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:02 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hcss2uag1-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:02 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 16 Apr 2018 07:28:00 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V1 05/11] powerpc/mm/book3e/64: Remove unsupported 64Kpage
 size from 64bit booke
Date: Mon, 16 Apr 2018 16:57:18 +0530
In-Reply-To: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180416112724.9677-7-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We have in Kconfig

config PPC_64K_PAGES
	bool "64k page size"
	depends on !PPC_FSL_BOOK3E && (44x || PPC_BOOK3S_64 || PPC_BOOK3E_64)
	select HAVE_ARCH_SOFT_DIRTY if PPC_BOOK3S_64

Only supported BOOK3E 64 bit platforms is FSL_BOOK3E. Remove the dead 64k page
support code from 64bit nohash.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-book3e.h            |  6 ---
 arch/powerpc/include/asm/nohash/64/pgalloc.h     | 60 ------------------------
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h | 57 ----------------------
 arch/powerpc/include/asm/nohash/64/pgtable.h     |  8 ++--
 4 files changed, 4 insertions(+), 127 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/nohash/64/pgtable-64k.h

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index cda94a0f5146..e20072972e35 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -230,10 +230,6 @@ typedef struct {
 	unsigned int	id;
 	unsigned int	active;
 	unsigned long	vdso_base;
-#ifdef CONFIG_PPC_64K_PAGES
-	/* for 4K PTE fragment support */
-	void *pte_frag;
-#endif
 } mm_context_t;
 
 /* Page size definitions, common between 32 and 64-bit
@@ -275,8 +271,6 @@ static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
  */
 #if defined(CONFIG_PPC_4K_PAGES)
 #define mmu_virtual_psize	MMU_PAGE_4K
-#elif defined(CONFIG_PPC_64K_PAGES)
-#define mmu_virtual_psize	MMU_PAGE_64K
 #else
 #error Unsupported page size
 #endif
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 9721c7867b9c..a6baf3c13bb5 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -52,8 +52,6 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
 }
 
-#ifndef CONFIG_PPC_64K_PAGES
-
 #define pgd_populate(MM, PGD, PUD)	pgd_set(PGD, (unsigned long)PUD)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -131,64 +129,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 	pgtable_free_tlb(tlb, page_address(table), 0);
 }
 
-#else /* if CONFIG_PPC_64K_PAGES */
-
-extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
-extern void pte_fragment_free(unsigned long *, int);
-extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
-#ifdef CONFIG_SMP
-extern void __tlb_remove_table(void *_table);
-#endif
-
-#define pud_populate(mm, pud, pmd)	pud_set(pud, (unsigned long)pmd)
-
-static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
-				       pte_t *pte)
-{
-	pmd_set(pmd, (unsigned long)pte);
-}
-
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-				pgtable_t pte_page)
-{
-	pmd_set(pmd, (unsigned long)pte_page);
-}
-
-static inline pgtable_t pmd_pgtable(pmd_t pmd)
-{
-	return (pgtable_t)(pmd_val(pmd) & ~PMD_MASKED_BITS);
-}
-
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
-					  unsigned long address)
-{
-	return (pte_t *)pte_fragment_alloc(mm, address, 1);
-}
-
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
-					unsigned long address)
-{
-	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
-}
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	pte_fragment_free((unsigned long *)pte, 1);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
-{
-	pte_fragment_free((unsigned long *)ptepage, 0);
-}
-
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
-				  unsigned long address)
-{
-	tlb_flush_pgtable(tlb, address);
-	pgtable_free_tlb(tlb, table, 0);
-}
-#endif /* CONFIG_PPC_64K_PAGES */
-
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
deleted file mode 100644
index 7210c2818e41..000000000000
--- a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_NOHASH_64_PGTABLE_64K_H
-#define _ASM_POWERPC_NOHASH_64_PGTABLE_64K_H
-
-#define __ARCH_USE_5LEVEL_HACK
-#include <asm-generic/pgtable-nopud.h>
-
-
-#define PTE_INDEX_SIZE  8
-#define PMD_INDEX_SIZE  10
-#define PUD_INDEX_SIZE	0
-#define PGD_INDEX_SIZE  12
-
-/*
- * we support 32 fragments per PTE page of 64K size
- */
-#define PTE_FRAG_NR	32
-/*
- * We use a 2K PTE page fragment and another 2K for storing
- * real_pte_t hash index
- */
-#define PTE_FRAG_SIZE_SHIFT  11
-#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
-
-#ifndef __ASSEMBLY__
-#define PTE_TABLE_SIZE	PTE_FRAG_SIZE
-#define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
-#define PUD_TABLE_SIZE	(0)
-#define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
-#endif	/* __ASSEMBLY__ */
-
-#define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
-#define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
-#define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
-
-/* PMD_SHIFT determines what a second-level page table entry can map */
-#define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
-#define PMD_SIZE	(1UL << PMD_SHIFT)
-#define PMD_MASK	(~(PMD_SIZE-1))
-
-/* PGDIR_SHIFT determines what a third-level page table entry can map */
-#define PGDIR_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
-#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
-#define PGDIR_MASK	(~(PGDIR_SIZE-1))
-
-/*
- * Bits to mask out from a PMD to get to the PTE page
- * PMDs point to PTE table fragments which are PTE_FRAG_SIZE aligned.
- */
-#define PMD_MASKED_BITS		(PTE_FRAG_SIZE - 1)
-/* Bits to mask out from a PGD/PUD to get to the PMD page */
-#define PUD_MASKED_BITS		0x1ff
-
-#define pgd_pte(pgd)	(pud_pte(((pud_t){ pgd })))
-#define pte_pgd(pte)	((pgd_t)pte_pud(pte))
-
-#endif /* _ASM_POWERPC_NOHASH_64_PGTABLE_64K_H */
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 5c5f75d005ad..404283d9ec6b 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -6,13 +6,13 @@
  * the ppc64 hashed page table.
  */
 
-#ifdef CONFIG_PPC_64K_PAGES
-#include <asm/nohash/64/pgtable-64k.h>
-#else
 #include <asm/nohash/64/pgtable-4k.h>
-#endif
 #include <asm/barrier.h>
 
+#ifdef CONFIG_PPC_64K_PAGES
+#error "Page size not supported"
+#endif
+
 #define FIRST_USER_ADDRESS	0UL
 
 /*
-- 
2.14.3
