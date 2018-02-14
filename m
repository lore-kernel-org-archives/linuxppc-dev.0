Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhLQS1M8gzF1GL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 00:50:39 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1EDmonH103771
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 08:50:37 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g4m8te3rj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 08:50:37 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 14 Feb 2018 08:50:36 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 4/6] powerpc/mm: Simplify the rcu callback for page table
 free
Date: Wed, 14 Feb 2018 19:20:07 +0530
In-Reply-To: <20180214135009.32748-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180214135009.32748-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180214135009.32748-5-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h |  2 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h |  6 ++--
 arch/powerpc/include/asm/pgalloc.h           |  9 ++++++
 arch/powerpc/mm/pgtable_64.c                 | 44 ++++++++++++++++++----------
 4 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 9f5c411bce1b..f102920fade4 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -137,7 +137,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
 	pgtable_page_dtor(table);
-	pgtable_free_tlb(tlb, page_address(table), 0);
+	pgtable_free_tlb(tlb, page_address(table), PTE_INDEX);
 }
 
 static inline void pgd_ctor(void *addr)
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index f3838ad0dc6c..e5d104caae26 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -123,7 +123,7 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 	 * ahead and flush the page walk cache
 	 */
 	flush_tlb_pgtable(tlb, address);
-        pgtable_free_tlb(tlb, pud, PUD_CACHE_INDEX);
+        pgtable_free_tlb(tlb, pud, PUD_INDEX);
 }
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
@@ -149,7 +149,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 	 * ahead and flush the page walk cache
 	 */
 	flush_tlb_pgtable(tlb, address);
-        return pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX);
+        return pgtable_free_tlb(tlb, pmd, PMD_INDEX);
 }
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
@@ -199,7 +199,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 	 * ahead and flush the page walk cache
 	 */
 	flush_tlb_pgtable(tlb, address);
-	pgtable_free_tlb(tlb, table, 0);
+	pgtable_free_tlb(tlb, table, PTE_INDEX);
 }
 
 #define check_pgt_cache()	do { } while (0)
diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index e11f03007b57..8949e73a028e 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -19,6 +19,15 @@ static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm, gfp_t gfp)
 #endif /* MODULE */
 
 #define PGALLOC_GFP (GFP_KERNEL | __GFP_ZERO)
+/*
+ * Used as an indicator for rcu callback functions
+ */
+enum pgtable_index {
+	PTE_INDEX = 0,
+	PMD_INDEX,
+	PUD_INDEX,
+	PGD_INDEX,
+};
 
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/book3s/pgalloc.h>
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 0a6859e6ef76..db3ee7ab8418 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -487,39 +487,51 @@ void pmd_fragment_free(unsigned long *pmd)
 	}
 }
 
-
 #ifdef CONFIG_SMP
-void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
+void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
 {
 	unsigned long pgf = (unsigned long)table;
 
-	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
-	pgf |= shift;
+	BUG_ON(index > MAX_PGTABLE_INDEX_SIZE);
+	pgf |= index;
 	tlb_remove_table(tlb, (void *)pgf);
 }
 
 void __tlb_remove_table(void *_table)
 {
 	void *table = (void *)((unsigned long)_table & ~MAX_PGTABLE_INDEX_SIZE);
-	unsigned shift = (unsigned long)_table & MAX_PGTABLE_INDEX_SIZE;
+	unsigned index = (unsigned long)_table & MAX_PGTABLE_INDEX_SIZE;
 
-	if (!shift)
-		/* PTE page needs special handling */
+	switch (index) {
+	case PTE_INDEX:
 		pte_fragment_free(table, 0);
-	else {
-		BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
-		kmem_cache_free(PGT_CACHE(shift), table);
+		break;
+	case PMD_INDEX:
+		pmd_fragment_free(table);
+		break;
+	case PUD_INDEX:
+		kmem_cache_free(PGT_CACHE(PUD_CACHE_INDEX), table);
+		break;
+	default:
+		BUG();
 	}
 }
 #else
-void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
+void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
 {
-	if (!shift) {
-		/* PTE page needs special handling */
+	switch (index) {
+	case PTE_INDEX:
 		pte_fragment_free(table, 0);
-	} else {
-		BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
-		kmem_cache_free(PGT_CACHE(shift), table);
+		break;
+	case PMD_INDEX:
+		kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), table);
+		break;
+	case PUD_INDEX:
+		kmem_cache_free(PGT_CACHE(PUD_CACHE_INDEX), table);
+		break;
+	/* We don't free pgd table via RCU callback */
+	default:
+		BUG();
 	}
 }
 #endif
-- 
2.14.3
