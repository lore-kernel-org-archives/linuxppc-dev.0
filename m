Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PmN951yGzF1s3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 21:28:25 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3GBPAai077529
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:22 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hcs0mwwt6-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:22 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 16 Apr 2018 07:28:21 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V1 10/11] powerpc/mm: Use page fragments for allocation page
 table at PMD level
Date: Mon, 16 Apr 2018 16:57:23 +0530
In-Reply-To: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180416112724.9677-12-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 10 ----------
 arch/powerpc/include/asm/book3s/64/pgalloc.h |  8 +++-----
 arch/powerpc/include/asm/book3s/64/pgtable.h |  4 ++--
 arch/powerpc/mm/hash_utils_64.c              |  1 -
 arch/powerpc/mm/pgtable-book3s64.c           |  3 +--
 arch/powerpc/mm/pgtable-radix.c              |  1 -
 arch/powerpc/mm/pgtable_64.c                 |  2 --
 7 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index cc8cd656ccfe..0387b155f13d 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -23,16 +23,6 @@
 				 H_PUD_INDEX_SIZE + H_PGD_INDEX_SIZE + PAGE_SHIFT)
 #define H_PGTABLE_RANGE		(ASM_CONST(1) << H_PGTABLE_EADDR_SIZE)
 
-#if (defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE)) && \
-	defined(CONFIG_PPC_64K_PAGES)
-/*
- * only with hash 64k we need to use the second half of pmd page table
- * to store pointer to deposited pgtable_t
- */
-#define H_PMD_CACHE_INDEX	(H_PMD_INDEX_SIZE + 1)
-#else
-#define H_PMD_CACHE_INDEX	H_PMD_INDEX_SIZE
-#endif
 /*
  * We store the slot details in the second half of page table.
  * Increase the pud level table so that hugetlb ptes can be stored
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 005f400cbf30..01ee40f11f3a 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -90,8 +90,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	 * need to do this for 4k.
 	 */
 #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_PPC_64K_PAGES) && \
-	((H_PGD_INDEX_SIZE == H_PUD_CACHE_INDEX) ||		     \
-	 (H_PGD_INDEX_SIZE == H_PMD_CACHE_INDEX))
+	(H_PGD_INDEX_SIZE == H_PUD_CACHE_INDEX)
 	memset(pgd, 0, PGD_TABLE_SIZE);
 #endif
 	return pgd;
@@ -138,13 +137,12 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
-		pgtable_gfp_flags(mm, GFP_KERNEL));
+	return pmd_fragment_alloc(mm, addr);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
-	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
+	pmd_fragment_free((unsigned long *)pmd);
 }
 
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c9db19512b3c..c233915abb68 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -212,13 +212,13 @@ extern unsigned long __pte_index_size;
 extern unsigned long __pmd_index_size;
 extern unsigned long __pud_index_size;
 extern unsigned long __pgd_index_size;
-extern unsigned long __pmd_cache_index;
 extern unsigned long __pud_cache_index;
 #define PTE_INDEX_SIZE  __pte_index_size
 #define PMD_INDEX_SIZE  __pmd_index_size
 #define PUD_INDEX_SIZE  __pud_index_size
 #define PGD_INDEX_SIZE  __pgd_index_size
-#define PMD_CACHE_INDEX __pmd_cache_index
+/* pmd table use page table fragments */
+#define PMD_CACHE_INDEX  0
 #define PUD_CACHE_INDEX __pud_cache_index
 /*
  * Because of use of pte fragments and THP, size of page table
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 63b1c1882e22..e25a6b0cd01e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1018,7 +1018,6 @@ void __init hash__early_init_mmu(void)
 	__pud_index_size = H_PUD_INDEX_SIZE;
 	__pgd_index_size = H_PGD_INDEX_SIZE;
 	__pud_cache_index = H_PUD_CACHE_INDEX;
-	__pmd_cache_index = H_PMD_CACHE_INDEX;
 	__pte_table_size = H_PTE_TABLE_SIZE;
 	__pmd_table_size = H_PMD_TABLE_SIZE;
 	__pud_table_size = H_PUD_TABLE_SIZE;
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 47323ed8d7b5..abda2b92f1ba 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -400,7 +400,7 @@ static inline void pgtable_free(void *table, int index)
 		pte_fragment_free(table, 0);
 		break;
 	case PMD_INDEX:
-		kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), table);
+		pmd_fragment_free(table);
 		break;
 	case PUD_INDEX:
 		kmem_cache_free(PGT_CACHE(PUD_CACHE_INDEX), table);
@@ -431,7 +431,6 @@ void __tlb_remove_table(void *_table)
 #else
 void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
 {
-
 	return pgtable_free(table, index);
 }
 #endif
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 32e58024e7cb..ce24d72ea679 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -617,7 +617,6 @@ void __init radix__early_init_mmu(void)
 	__pud_index_size = RADIX_PUD_INDEX_SIZE;
 	__pgd_index_size = RADIX_PGD_INDEX_SIZE;
 	__pud_cache_index = RADIX_PUD_INDEX_SIZE;
-	__pmd_cache_index = RADIX_PMD_INDEX_SIZE;
 	__pte_table_size = RADIX_PTE_TABLE_SIZE;
 	__pmd_table_size = RADIX_PMD_TABLE_SIZE;
 	__pud_table_size = RADIX_PUD_TABLE_SIZE;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index f0208f8f9dbb..53e9eeecd5d4 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -72,8 +72,6 @@ unsigned long __pud_index_size;
 EXPORT_SYMBOL(__pud_index_size);
 unsigned long __pgd_index_size;
 EXPORT_SYMBOL(__pgd_index_size);
-unsigned long __pmd_cache_index;
-EXPORT_SYMBOL(__pmd_cache_index);
 unsigned long __pud_cache_index;
 EXPORT_SYMBOL(__pud_cache_index);
 unsigned long __pte_table_size;
-- 
2.14.3
