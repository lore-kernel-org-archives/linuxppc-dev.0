Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcZMN70yWzF0yF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 21:34:55 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w18ATaGE013586
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Feb 2018 05:34:52 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g0m8222nw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 05:34:52 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 8 Feb 2018 05:34:51 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxram@us.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/mm: Fix crashes with PUD level hugetlb config
Date: Thu,  8 Feb 2018 16:04:41 +0530
Message-Id: <20180208103442.22045-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To support memory keys, we moved the hash pte slot information to the second
half of the page table. This was ok with PTE entries at level 4 and level 3.
We already allocate larger page table pages at those level to accomodate extra
details. For level 4 we already have the extra space which was used to track
4k hash page table entry details and at pmd level the extra space was allocated
to track the THP details.

With hugetlbfs PTE, we used this extra space at the PMD level to store the
slot details. But we also support hugetlbfs PTE at PUD leve and PUD level page
didn't allocate extra space. This resulted in memory corruption.

Fix this by allocating extra space at PUD level when HUGETLB is enabled. We
may need further changes to allocate larger space at PMD level when we enable
HUGETLB. That will be done in next patch.

Fixes:bf9a95f9a6481bc6e(" powerpc: Free up four 64K PTE bits in 64K backed HPTE pages")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
NOTE: In the long run we may want to look at my patch series to remove slot
tracking completely.

 arch/powerpc/include/asm/book3s/32/pgtable.h  |  1 +
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  5 +++++
 arch/powerpc/include/asm/book3s/64/hash.h     | 10 ++++++++++
 arch/powerpc/include/asm/book3s/64/pgalloc.h  |  6 +++---
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  2 ++
 arch/powerpc/include/asm/nohash/32/pgtable.h  |  1 +
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  1 +
 arch/powerpc/mm/hash_utils_64.c               |  1 +
 arch/powerpc/mm/init-common.c                 |  4 ++--
 arch/powerpc/mm/pgtable-radix.c               |  1 +
 arch/powerpc/mm/pgtable_64.c                  |  2 ++
 11 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 30a155c0a6b0..c615abdce119 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -16,6 +16,7 @@
 #define PGD_INDEX_SIZE	(32 - PGDIR_SHIFT)
 
 #define PMD_CACHE_INDEX	PMD_INDEX_SIZE
+#define PUD_CACHE_INDEX	PUD_INDEX_SIZE
 
 #ifndef __ASSEMBLY__
 #define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 338b7da468ce..c08b3b032ec0 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -146,7 +146,12 @@ static inline int hash__remap_4k_pfn(struct vm_area_struct *vma, unsigned long a
 #else
 #define H_PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
 #endif
+#ifdef CONFIG_HUGETLB_PAGE
+#define H_PUD_TABLE_SIZE	((sizeof(pud_t) << PUD_INDEX_SIZE) +	\
+				 (sizeof(unsigned long) << PUD_INDEX_SIZE))
+#else
 #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
+#endif
 #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 0920eff731b3..234f141fb151 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -32,6 +32,16 @@
 #else
 #define H_PMD_CACHE_INDEX	H_PMD_INDEX_SIZE
 #endif
+/*
+ * We not store the slot details in the second half of page table.
+ * Increase the pud level table so that hugetlb ptes can be stored
+ * at pud level.
+ */
+#if defined(CONFIG_HUGETLB_PAGE) &&  defined(CONFIG_PPC_64K_PAGES)
+#define H_PUD_CACHE_INDEX	(H_PUD_INDEX_SIZE + 1)
+#else
+#define H_PUD_CACHE_INDEX	(H_PUD_INDEX_SIZE)
+#endif
 /*
  * Define the address range of the kernel non-linear virtual area
  */
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 1fcfa425cefa..53df86d3cfce 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -93,13 +93,13 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE),
+	return kmem_cache_alloc(PGT_CACHE(PUD_CACHE_INDEX),
 		pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
-	kmem_cache_free(PGT_CACHE(PUD_INDEX_SIZE), pud);
+	kmem_cache_free(PGT_CACHE(PUD_CACHE_INDEX), pud);
 }
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
@@ -115,7 +115,7 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 	 * ahead and flush the page walk cache
 	 */
 	flush_tlb_pgtable(tlb, address);
-        pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE);
+        pgtable_free_tlb(tlb, pud, PUD_CACHE_INDEX);
 }
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 51017726d495..3c14663d457d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -232,11 +232,13 @@ extern unsigned long __pmd_index_size;
 extern unsigned long __pud_index_size;
 extern unsigned long __pgd_index_size;
 extern unsigned long __pmd_cache_index;
+extern unsigned long __pud_cache_index;
 #define PTE_INDEX_SIZE  __pte_index_size
 #define PMD_INDEX_SIZE  __pmd_index_size
 #define PUD_INDEX_SIZE  __pud_index_size
 #define PGD_INDEX_SIZE  __pgd_index_size
 #define PMD_CACHE_INDEX __pmd_cache_index
+#define PUD_CACHE_INDEX __pmd_cache_index
 /*
  * Because of use of pte fragments and THP, size of page table
  * are not always derived out of index size above.
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 504a3c36ce5c..03bbd1149530 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -24,6 +24,7 @@ extern int icache_44x_need_flush;
 #define PGD_INDEX_SIZE	(32 - PGDIR_SHIFT)
 
 #define PMD_CACHE_INDEX	PMD_INDEX_SIZE
+#define PUD_CACHE_INDEX	PUD_INDEX_SIZE
 
 #ifndef __ASSEMBLY__
 #define PTE_TABLE_SIZE	(sizeof(pte_t) << PTE_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index abddf5830ad5..5c5f75d005ad 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -27,6 +27,7 @@
 #else
 #define PMD_CACHE_INDEX	PMD_INDEX_SIZE
 #endif
+#define PUD_CACHE_INDEX PUD_INDEX_SIZE
 
 /*
  * Define the address range of the kernel non-linear virtual area
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 7d07c7e17db6..cf290d415dcd 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1008,6 +1008,7 @@ void __init hash__early_init_mmu(void)
 	__pmd_index_size = H_PMD_INDEX_SIZE;
 	__pud_index_size = H_PUD_INDEX_SIZE;
 	__pgd_index_size = H_PGD_INDEX_SIZE;
+	__pud_cache_index = H_PUD_CACHE_INDEX;
 	__pmd_cache_index = H_PMD_CACHE_INDEX;
 	__pte_table_size = H_PTE_TABLE_SIZE;
 	__pmd_table_size = H_PMD_TABLE_SIZE;
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index eb8c6c8c4851..2b656e67f2ea 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -100,6 +100,6 @@ void pgtable_cache_init(void)
 	 * same size as either the pgd or pmd index except with THP enabled
 	 * on book3s 64
 	 */
-	if (PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE))
-		pgtable_cache_add(PUD_INDEX_SIZE, pud_ctor);
+	if (PUD_CACHE_INDEX && !PGT_CACHE(PUD_CACHE_INDEX))
+		pgtable_cache_add(PUD_CACHE_INDEX, pud_ctor);
 }
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 573a9a2ee455..27d096610369 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -535,6 +535,7 @@ void __init radix__early_init_mmu(void)
 	__pmd_index_size = RADIX_PMD_INDEX_SIZE;
 	__pud_index_size = RADIX_PUD_INDEX_SIZE;
 	__pgd_index_size = RADIX_PGD_INDEX_SIZE;
+	__pud_cache_index = RADIX_PUD_INDEX_SIZE;
 	__pmd_cache_index = RADIX_PMD_INDEX_SIZE;
 	__pte_table_size = RADIX_PTE_TABLE_SIZE;
 	__pmd_table_size = RADIX_PMD_TABLE_SIZE;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index c9a623c2d8a2..a0f8928c0b86 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -82,6 +82,8 @@ unsigned long __pgd_index_size;
 EXPORT_SYMBOL(__pgd_index_size);
 unsigned long __pmd_cache_index;
 EXPORT_SYMBOL(__pmd_cache_index);
+unsigned long __pud_cache_index;
+EXPORT_SYMBOL(__pud_cache_index);
 unsigned long __pte_table_size;
 EXPORT_SYMBOL(__pte_table_size);
 unsigned long __pmd_table_size;
-- 
2.14.3
