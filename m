Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhLQK2XK7zF1FS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 00:50:33 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1EDnB5k017561
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 08:50:31 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g4mgpn3xs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 08:50:30 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 14 Feb 2018 08:50:28 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/6] powerpc/mm/4k: Switch 4k pagesize config to use
 pagetable fragment
Date: Wed, 14 Feb 2018 19:20:05 +0530
In-Reply-To: <20180214135009.32748-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180214135009.32748-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180214135009.32748-3-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

4K config use one full page at level 4 of the table. Add support single fragment
and use that for 4K config. This makes both 4k and 64k use the same code path.
Later we will switch pmd to use the page table fragment code

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  6 ++++--
 arch/powerpc/include/asm/book3s/64/mmu.h      |  6 +++---
 arch/powerpc/include/asm/book3s/64/pgalloc.h  | 26 --------------------------
 arch/powerpc/include/asm/book3s/64/radix-4k.h |  6 ++++++
 arch/powerpc/mm/mmu_context_book3s64.c        | 10 ----------
 arch/powerpc/mm/pgtable_64.c                  | 10 +++++++---
 6 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 67c5475311ee..62098daa3af8 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -32,8 +32,10 @@
 #define H_PAGE_4K_PFN	0x0
 #define H_PAGE_THP_HUGE 0x0
 #define H_PAGE_COMBO	0x0
-#define H_PTE_FRAG_NR	0
-#define H_PTE_FRAG_SIZE_SHIFT  0
+
+/* 8 bytes per each pte entry */
+#define H_PTE_FRAG_SIZE_SHIFT  (H_PTE_INDEX_SIZE + 3)
+#define H_PTE_FRAG_NR	(PAGE_SIZE >> H_PTE_FRAG_SIZE_SHIFT)
 /*
  * On all 4K setups, remap_4k_pfn() equates to remap_pfn_range()
  */
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 0abeb0e2d616..00a961bc76a9 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -101,10 +101,10 @@ typedef struct {
 #ifdef CONFIG_PPC_SUBPAGE_PROT
 	struct subpage_prot_table spt;
 #endif /* CONFIG_PPC_SUBPAGE_PROT */
-#ifdef CONFIG_PPC_64K_PAGES
-	/* for 4K PTE fragment support */
+	/*
+	 * pagetable fragment support
+	 */
 	void *pte_frag;
-#endif
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	struct list_head iommu_group_mem_list;
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index d6ee7563b09d..8de75c2ae7c9 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -167,31 +167,6 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
 	return (pgtable_t)pmd_page_vaddr(pmd);
 }
 
-#ifdef CONFIG_PPC_4K_PAGES
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
-					  unsigned long address)
-{
-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-}
-
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
-				      unsigned long address)
-{
-	struct page *page;
-	pte_t *pte;
-
-	pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT);
-	if (!pte)
-		return NULL;
-	page = virt_to_page(pte);
-	if (!pgtable_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
-	}
-	return pte;
-}
-#else /* if CONFIG_PPC_64K_PAGES */
-
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
@@ -203,7 +178,6 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 {
 	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
 }
-#endif
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/radix-4k.h b/arch/powerpc/include/asm/book3s/64/radix-4k.h
index a61aa9cd63ec..14717cfe15e2 100644
--- a/arch/powerpc/include/asm/book3s/64/radix-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/radix-4k.h
@@ -9,5 +9,11 @@
 #define RADIX_PMD_INDEX_SIZE  9  /* 1G huge page */
 #define RADIX_PUD_INDEX_SIZE	 9
 #define RADIX_PGD_INDEX_SIZE  13
+/*
+ * One fragment per per page
+ */
+#define RADIX_PTE_FRAG_SIZE_SHIFT  (RADIX_PTE_INDEX_SIZE + 3)
+#define RADIX_PTE_FRAG_NR	(PAGE_SIZE >> RADIX_PTE_FRAG_SIZE_SHIFT)
+
 
 #endif /* _ASM_POWERPC_PGTABLE_RADIX_4K_H */
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 929d9ef7083f..b4d795b5162a 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -166,9 +166,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 
 	mm->context.id = index;
 
-#ifdef CONFIG_PPC_64K_PAGES
 	mm->context.pte_frag = NULL;
-#endif
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	mm_iommu_init(mm);
 #endif
@@ -185,7 +183,6 @@ void __destroy_context(int context_id)
 }
 EXPORT_SYMBOL_GPL(__destroy_context);
 
-#ifdef CONFIG_PPC_64K_PAGES
 static void destroy_pagetable_page(struct mm_struct *mm)
 {
 	int count;
@@ -206,13 +203,6 @@ static void destroy_pagetable_page(struct mm_struct *mm)
 	}
 }
 
-#else
-static inline void destroy_pagetable_page(struct mm_struct *mm)
-{
-	return;
-}
-#endif
-
 void destroy_context(struct mm_struct *mm)
 {
 #ifdef CONFIG_SPAPR_TCE_IOMMU
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 330ef1d1daf5..ff4973565abb 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -321,7 +321,6 @@ struct page *pmd_page(pmd_t pmd)
 	return virt_to_page(pmd_page_vaddr(pmd));
 }
 
-#ifdef CONFIG_PPC_64K_PAGES
 static pte_t *get_pte_from_cache(struct mm_struct *mm)
 {
 	void *pte_frag, *ret;
@@ -360,7 +359,14 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 			return NULL;
 	}
 
+
 	ret = page_address(page);
+	/*
+	 * if we support only one fragment just return the
+	 * allocated page.
+	 */
+	if (PTE_FRAG_NR == 1)
+		return ret;
 	spin_lock(&mm->page_table_lock);
 	/*
 	 * If we find pgtable_page set, we return
@@ -387,8 +393,6 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel
 	return __alloc_for_ptecache(mm, kernel);
 }
 
-#endif /* CONFIG_PPC_64K_PAGES */
-
 void pte_fragment_free(unsigned long *table, int kernel)
 {
 	struct page *page = virt_to_page(table);
-- 
2.14.3
