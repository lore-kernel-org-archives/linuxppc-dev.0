Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqq20g2zzDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:17 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 04:25:15 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 21C7BC90027
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:25:08 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8PCHK28508204
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:25:12 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8PBMi018679
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:25:12 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 21/65] powerpc/mm: Make page table size a variable
Date: Sun, 27 Mar 2016 13:53:29 +0530
Message-Id: <1459067053-10835-21-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Radix and hash MMU models support different page table sizes. Make
the #defines a variable so that existing code can work with variable
sizes

Slice related code is only used by hash, so use hash constants there
We will replicate some of the boundary conditions with resepct to
TASK_SIZE using radix values too. Right now we do boundary condition
check using hash constants

Swapper pgdir size is initialized in asm code. We select the max pgd
size to keep it simpler. For now we select hash pgdir. When adding radix
we will switch that to radix pgdir which is 64K.

BUILD_BUG_ON check which is removed is already done in hugepage_init using
MAYBE_BUILD_BUG_ON()

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 45 ++++----------------
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 46 +++++---------------
 arch/powerpc/include/asm/book3s/64/hash.h     | 14 ++++---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  4 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 60 +++++++++++++++++++++++++++
 arch/powerpc/include/asm/page_64.h            |  2 +-
 arch/powerpc/kernel/asm-offsets.c             |  4 ++
 arch/powerpc/mm/hash_utils_64.c               | 12 ++++++
 arch/powerpc/mm/init_64.c                     |  4 +-
 arch/powerpc/mm/pgtable-book3e.c              |  1 +
 arch/powerpc/mm/pgtable-hash64.c              |  1 +
 arch/powerpc/mm/pgtable_64.c                  | 33 ++++++++++-----
 arch/powerpc/mm/slb_low.S                     |  2 +-
 arch/powerpc/mm/slice.c                       |  4 +-
 14 files changed, 135 insertions(+), 97 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 115427f61ef0..f121f8016d8b 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -5,48 +5,20 @@
  * for each page table entry.  The PMD and PGD level use a 32b record for
  * each entry by assuming that each entry is page aligned.
  */
-#define PTE_INDEX_SIZE  9
-#define PMD_INDEX_SIZE  7
-#define PUD_INDEX_SIZE  9
-#define PGD_INDEX_SIZE  9
+#define H_PTE_INDEX_SIZE  9
+#define H_PMD_INDEX_SIZE  7
+#define H_PUD_INDEX_SIZE  9
+#define H_PGD_INDEX_SIZE  9
 
 #ifndef __ASSEMBLY__
-#define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
-#define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
-#define PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
-#define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
-#endif	/* __ASSEMBLY__ */
-
-#define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
-#define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
-#define PTRS_PER_PUD	(1 << PUD_INDEX_SIZE)
-#define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
-
-/* PMD_SHIFT determines what a second-level page table entry can map */
-#define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
-#define PMD_SIZE	(1UL << PMD_SHIFT)
-#define PMD_MASK	(~(PMD_SIZE-1))
+#define H_PTE_TABLE_SIZE	(sizeof(pte_t) << H_PTE_INDEX_SIZE)
+#define H_PMD_TABLE_SIZE	(sizeof(pmd_t) << H_PMD_INDEX_SIZE)
+#define H_PUD_TABLE_SIZE	(sizeof(pud_t) << H_PUD_INDEX_SIZE)
+#define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << H_PGD_INDEX_SIZE)
 
 /* With 4k base page size, hugepage PTEs go at the PMD level */
 #define MIN_HUGEPTE_SHIFT	PMD_SHIFT
 
-/* PUD_SHIFT determines what a third-level page table entry can map */
-#define PUD_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
-#define PUD_SIZE	(1UL << PUD_SHIFT)
-#define PUD_MASK	(~(PUD_SIZE-1))
-
-/* PGDIR_SHIFT determines what a fourth-level page table entry can map */
-#define PGDIR_SHIFT	(PUD_SHIFT + PUD_INDEX_SIZE)
-#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
-#define PGDIR_MASK	(~(PGDIR_SIZE-1))
-
-/* Bits to mask out from a PMD to get to the PTE page */
-#define PMD_MASKED_BITS		0
-/* Bits to mask out from a PUD to get to the PMD page */
-#define PUD_MASKED_BITS		0
-/* Bits to mask out from a PGD to get to the PUD page */
-#define PGD_MASKED_BITS		0
-
 /* PTE flags to conserve for HPTE identification */
 #define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | \
 			 H_PAGE_F_SECOND | H_PAGE_F_GIX)
@@ -55,7 +27,6 @@
  */
 #define H_PAGE_4K_PFN	0x0
 #define H_PAGE_THP_HUGE 0x0
-#ifndef __ASSEMBLY__
 /*
  * On all 4K setups, remap_4k_pfn() equates to remap_pfn_range()
  */
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 93bef8162d66..d60c431c96cb 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -1,34 +1,14 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_HASH_64K_H
 #define _ASM_POWERPC_BOOK3S_64_HASH_64K_H
 
-#define PTE_INDEX_SIZE  8
-#define PMD_INDEX_SIZE  5
-#define PUD_INDEX_SIZE	5
-#define PGD_INDEX_SIZE  12
-
-#define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
-#define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
-#define PTRS_PER_PUD	(1 << PUD_INDEX_SIZE)
-#define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
+#define H_PTE_INDEX_SIZE  8
+#define H_PMD_INDEX_SIZE  5
+#define H_PUD_INDEX_SIZE  5
+#define H_PGD_INDEX_SIZE  12
 
 /* With 4k base page size, hugepage PTEs go at the PMD level */
 #define MIN_HUGEPTE_SHIFT	PAGE_SHIFT
 
-/* PMD_SHIFT determines what a second-level page table entry can map */
-#define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
-#define PMD_SIZE	(1UL << PMD_SHIFT)
-#define PMD_MASK	(~(PMD_SIZE-1))
-
-/* PUD_SHIFT determines what a third-level page table entry can map */
-#define PUD_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
-#define PUD_SIZE	(1UL << PUD_SHIFT)
-#define PUD_MASK	(~(PUD_SIZE-1))
-
-/* PGDIR_SHIFT determines what a fourth-level page table entry can map */
-#define PGDIR_SHIFT	(PUD_SHIFT + PUD_INDEX_SIZE)
-#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
-#define PGDIR_MASK	(~(PGDIR_SIZE-1))
-
 #define H_PAGE_COMBO	0x00001000 /* this is a combo 4k page */
 #define H_PAGE_4K_PFN	0x00002000 /* PFN is for a single 4k page */
 /*
@@ -57,13 +37,6 @@
 #define PTE_FRAG_SIZE_SHIFT  12
 #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
 
-/* Bits to mask out from a PMD to get to the PTE page */
-#define PMD_MASKED_BITS		0xc0000000000000ffUL
-/* Bits to mask out from a PUD to get to the PMD page */
-#define PUD_MASKED_BITS		0xc0000000000000ffUL
-/* Bits to mask out from a PGD to get to the PUD page */
-#define PGD_MASKED_BITS		0xc0000000000000ffUL
-
 #ifndef __ASSEMBLY__
 #include <asm/errno.h>
 
@@ -135,14 +108,15 @@ static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
 			       __pgprot(pgprot_val(prot) | H_PAGE_4K_PFN));
 }
 
-#define PTE_TABLE_SIZE	PTE_FRAG_SIZE
+#define H_PTE_TABLE_SIZE	PTE_FRAG_SIZE
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define PMD_TABLE_SIZE	((sizeof(pmd_t) << PMD_INDEX_SIZE) + (sizeof(unsigned long) << PMD_INDEX_SIZE))
+#define H_PMD_TABLE_SIZE	((sizeof(pmd_t) << PMD_INDEX_SIZE) + \
+				 (sizeof(unsigned long) << PMD_INDEX_SIZE))
 #else
-#define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
+#define H_PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
 #endif
-#define PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
-#define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
+#define H_PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
+#define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
 
 #ifdef CONFIG_HUGETLB_PAGE
 /*
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index a9bc8ca0df7b..9485797f4468 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -29,14 +29,18 @@
 /*
  * Size of EA range mapped by our pagetables.
  */
-#define PGTABLE_EADDR_SIZE	(PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
-				 PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
-#define PGTABLE_RANGE		(ASM_CONST(1) << PGTABLE_EADDR_SIZE)
+#define H_PGTABLE_EADDR_SIZE	(H_PTE_INDEX_SIZE + H_PMD_INDEX_SIZE + \
+				 H_PUD_INDEX_SIZE + H_PGD_INDEX_SIZE + PAGE_SHIFT)
+#define H_PGTABLE_RANGE		(ASM_CONST(1) << H_PGTABLE_EADDR_SIZE)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define PMD_CACHE_INDEX	(PMD_INDEX_SIZE + 1)
+/*
+ * only with hash we need to use the second half of pmd page table
+ * to store pointer to deposited pgtable_t
+ */
+#define H_PMD_CACHE_INDEX	(H_PMD_INDEX_SIZE + 1)
 #else
-#define PMD_CACHE_INDEX	PMD_INDEX_SIZE
+#define H_PMD_CACHE_INDEX	H_PMD_INDEX_SIZE
 #endif
 /*
  * Define the address range of the kernel non-linear virtual area
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 843b5d839904..7da61b85406b 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -462,7 +462,7 @@ extern void slb_set_size(u16 size);
 	add	rt,rt,rx
 
 /* 4 bits per slice and we have one slice per 1TB */
-#define SLICE_ARRAY_SIZE  (PGTABLE_RANGE >> 41)
+#define SLICE_ARRAY_SIZE  (H_PGTABLE_RANGE >> 41)
 
 #ifndef __ASSEMBLY__
 
@@ -533,7 +533,7 @@ static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
 	/*
 	 * Bad address. We return VSID 0 for that
 	 */
-	if ((ea & ~REGION_MASK) >= PGTABLE_RANGE)
+	if ((ea & ~REGION_MASK) >= H_PGTABLE_RANGE)
 		return 0;
 
 	if (ssize == MMU_SEGSIZE_256M)
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index e2c2af34d71b..ef080bd5fce7 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -144,6 +144,66 @@
 #define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
 #define PAGE_AGP		(PAGE_KERNEL_NC)
 
+#ifndef __ASSEMBLY__
+/*
+ * page table defines
+ */
+extern unsigned long __pte_index_size;
+extern unsigned long __pmd_index_size;
+extern unsigned long __pud_index_size;
+extern unsigned long __pgd_index_size;
+extern unsigned long __pmd_cache_index;
+#define PTE_INDEX_SIZE  __pte_index_size
+#define PMD_INDEX_SIZE  __pmd_index_size
+#define PUD_INDEX_SIZE  __pud_index_size
+#define PGD_INDEX_SIZE  __pgd_index_size
+#define PMD_CACHE_INDEX __pmd_cache_index
+/*
+ * Because of use of pte fragments and THP, size of page table
+ * are not always derived out of index size above.
+ */
+extern unsigned long __pte_table_size;
+extern unsigned long __pmd_table_size;
+extern unsigned long __pud_table_size;
+extern unsigned long __pgd_table_size;
+#define PTE_TABLE_SIZE	__pte_table_size
+#define PMD_TABLE_SIZE	__pmd_table_size
+#define PUD_TABLE_SIZE	__pud_table_size
+#define PGD_TABLE_SIZE	__pgd_table_size
+/*
+ * Pgtable size used by swapper, init in asm code
+ * We will switch this later to radix PGD
+ */
+#define MAX_PGD_TABLE_SIZE (sizeof(pgd_t) << H_PGD_INDEX_SIZE)
+
+#define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
+#define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
+#define PTRS_PER_PUD	(1 << PUD_INDEX_SIZE)
+#define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
+
+/* PMD_SHIFT determines what a second-level page table entry can map */
+#define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
+#define PMD_SIZE	(1UL << PMD_SHIFT)
+#define PMD_MASK	(~(PMD_SIZE-1))
+
+/* PUD_SHIFT determines what a third-level page table entry can map */
+#define PUD_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
+#define PUD_SIZE	(1UL << PUD_SHIFT)
+#define PUD_MASK	(~(PUD_SIZE-1))
+
+/* PGDIR_SHIFT determines what a fourth-level page table entry can map */
+#define PGDIR_SHIFT	(PUD_SHIFT + PUD_INDEX_SIZE)
+#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK	(~(PGDIR_SIZE-1))
+
+/* Bits to mask out from a PMD to get to the PTE page */
+#define PMD_MASKED_BITS		0xc0000000000000ffUL
+/* Bits to mask out from a PUD to get to the PMD page */
+#define PUD_MASKED_BITS		0xc0000000000000ffUL
+/* Bits to mask out from a PGD to get to the PUD page */
+#define PGD_MASKED_BITS		0xc0000000000000ffUL
+#endif /* __ASSEMBLY__ */
+
 #include <asm/book3s/64/hash.h>
 #include <asm/barrier.h>
 
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index d908a46d05c0..77488857c26d 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -93,7 +93,7 @@ extern u64 ppc64_pft_size;
 
 #define SLICE_LOW_TOP		(0x100000000ul)
 #define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
-#define SLICE_NUM_HIGH		(PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
+#define SLICE_NUM_HIGH		(H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
 
 #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 10d5eab19458..236fd1b526ea 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -433,7 +433,11 @@ int main(void)
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
 #endif
 
+#ifdef MAX_PGD_TABLE_SIZE
+	DEFINE(PGD_TABLE_SIZE, MAX_PGD_TABLE_SIZE);
+#else
 	DEFINE(PGD_TABLE_SIZE, PGD_TABLE_SIZE);
+#endif
 	DEFINE(PTE_SIZE, sizeof(pte_t));
 
 #ifdef CONFIG_KVM
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index c2ffc97cf665..c4a5f13997b8 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -866,6 +866,18 @@ static void __init htab_initialize(void)
 
 void __init early_init_mmu(void)
 {
+	/*
+	 * initialize page table size
+	 */
+	__pte_index_size = H_PTE_INDEX_SIZE;
+	__pmd_index_size = H_PMD_INDEX_SIZE;
+	__pud_index_size = H_PUD_INDEX_SIZE;
+	__pgd_index_size = H_PGD_INDEX_SIZE;
+	__pmd_cache_index = H_PMD_CACHE_INDEX;
+	__pte_table_size = H_PTE_TABLE_SIZE;
+	__pmd_table_size = H_PMD_TABLE_SIZE;
+	__pud_table_size = H_PUD_TABLE_SIZE;
+	__pgd_table_size = H_PGD_TABLE_SIZE;
 	/* Initialize the MMU Hash table and create the linear mapping
 	 * of memory. Has to be done before SLB initialization as this is
 	 * currently where the page size encoding is obtained.
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 8d1daf7d9785..09ca65e55b58 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -66,11 +66,11 @@
 #include "mmu_decl.h"
 
 #ifdef CONFIG_PPC_STD_MMU_64
-#if PGTABLE_RANGE > USER_VSID_RANGE
+#if H_PGTABLE_RANGE > USER_VSID_RANGE
 #warning Limited user VSID range means pagetable space is wasted
 #endif
 
-#if (TASK_SIZE_USER64 < PGTABLE_RANGE) && (TASK_SIZE_USER64 < USER_VSID_RANGE)
+#if (TASK_SIZE_USER64 < H_PGTABLE_RANGE) && (TASK_SIZE_USER64 < USER_VSID_RANGE)
 #warning TASK_SIZE is smaller than it needs to be.
 #endif
 #endif /* CONFIG_PPC_STD_MMU_64 */
diff --git a/arch/powerpc/mm/pgtable-book3e.c b/arch/powerpc/mm/pgtable-book3e.c
index f75ba4142875..8a7f06531282 100644
--- a/arch/powerpc/mm/pgtable-book3e.c
+++ b/arch/powerpc/mm/pgtable-book3e.c
@@ -84,6 +84,7 @@ int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
 	pmd_t *pmdp;
 	pte_t *ptep;
 
+	BUILD_BUG_ON(TASK_SIZE_USER64 > PGTABLE_RANGE);
 	if (slab_is_available()) {
 		pgdp = pgd_offset_k(ea);
 		pudp = pud_alloc(&init_mm, pgdp, ea);
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 04d6fa12789e..183f80a528ba 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -67,6 +67,7 @@ int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
 	pmd_t *pmdp;
 	pte_t *ptep;
 
+	BUILD_BUG_ON(TASK_SIZE_USER64 > H_PGTABLE_RANGE);
 	if (slab_is_available()) {
 		pgdp = pgd_offset_k(ea);
 		pudp = pud_alloc(&init_mm, pgdp, ea);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index e43e0ea820e0..af6a83a6c90b 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -58,11 +58,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/thp.h>
 
-/* Some sanity checking */
-#if TASK_SIZE_USER64 > PGTABLE_RANGE
-#error TASK_SIZE_USER64 exceeds pagetable range
-#endif
-
 #ifdef CONFIG_PPC_STD_MMU_64
 #if TASK_SIZE_USER64 > (1UL << (ESID_BITS + SID_SHIFT))
 #error TASK_SIZE_USER64 exceeds user VSID range
@@ -75,6 +70,28 @@
  */
 struct prtb_entry *process_tb;
 struct patb_entry *partition_tb;
+/*
+ * page table size
+ */
+unsigned long __pte_index_size;
+EXPORT_SYMBOL(__pte_index_size);
+unsigned long __pmd_index_size;
+EXPORT_SYMBOL(__pmd_index_size);
+unsigned long __pud_index_size;
+EXPORT_SYMBOL(__pud_index_size);
+unsigned long __pgd_index_size;
+EXPORT_SYMBOL(__pgd_index_size);
+unsigned long __pmd_cache_index;
+EXPORT_SYMBOL(__pmd_cache_index);
+unsigned long __pte_table_size;
+EXPORT_SYMBOL(__pte_table_size);
+unsigned long __pmd_table_size;
+EXPORT_SYMBOL(__pmd_table_size);
+unsigned long __pud_table_size;
+EXPORT_SYMBOL(__pud_table_size);
+unsigned long __pgd_table_size;
+EXPORT_SYMBOL(__pgd_table_size);
+
 #endif
 unsigned long ioremap_bot = IOREMAP_BASE;
 
@@ -744,12 +761,6 @@ pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 int has_transparent_hugepage(void)
 {
 
-	BUILD_BUG_ON_MSG((PMD_SHIFT - PAGE_SHIFT) >= MAX_ORDER,
-		"hugepages can't be allocated by the buddy allocator");
-
-	BUILD_BUG_ON_MSG((PMD_SHIFT - PAGE_SHIFT) < 2,
-			 "We need more than 2 pages to do deferred thp split");
-
 	if (!mmu_has_feature(MMU_FTR_16M_PAGE))
 		return 0;
 	/*
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 736d18b3cefd..aade18f3f21f 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -35,7 +35,7 @@ _GLOBAL(slb_allocate_realmode)
 	 * check for bad kernel/user address
 	 * (ea & ~REGION_MASK) >= PGTABLE_RANGE
 	 */
-	rldicr. r9,r3,4,(63 - PGTABLE_EADDR_SIZE - 4)
+	rldicr. r9,r3,4,(63 - H_PGTABLE_EADDR_SIZE - 4)
 	bne-	8f
 
 	srdi	r9,r3,60		/* get region */
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 42954f0b47ac..ee21b8699cee 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -37,8 +37,8 @@
 #include <asm/hugetlb.h>
 
 /* some sanity checks */
-#if (PGTABLE_RANGE >> 43) > SLICE_MASK_SIZE
-#error PGTABLE_RANGE exceeds slice_mask high_slices size
+#if (H_PGTABLE_RANGE >> 43) > SLICE_MASK_SIZE
+#error H_PGTABLE_RANGE exceeds slice_mask high_slices size
 #endif
 
 static DEFINE_SPINLOCK(slice_convert_lock);
-- 
2.5.0
