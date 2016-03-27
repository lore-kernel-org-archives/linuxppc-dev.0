Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqrF6rgLzDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:26:21 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 04:26:19 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CD98F6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:13:06 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8QGg524051906
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:26:16 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8QGcL020954
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:26:16 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 50/65] powerpc/mm: make 4k and 64k use pte_t for pgtable_t
Date: Sun, 27 Mar 2016 13:53:58 +0530
Message-Id: <1459067053-10835-50-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

pgtable_page_dtor for nohash is now moved to pte_fragment_free_mm()

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 147 +++++++--------------------
 arch/powerpc/include/asm/nohash/64/pgalloc.h |  38 +------
 arch/powerpc/include/asm/page.h              |  10 +-
 arch/powerpc/mm/pgtable_64.c                 |   2 +-
 4 files changed, 52 insertions(+), 145 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 37283e3d8e56..faad1319ba26 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -41,6 +41,15 @@ extern struct kmem_cache *pgtable_cache[];
 			pgtable_cache[(shift) - 1];	\
 		})
 
+#define PGALLOC_GFP GFP_KERNEL | __GFP_NOTRACK | __GFP_REPEAT | __GFP_ZERO
+
+extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
+extern void pte_fragment_free(unsigned long *, int);
+extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
+#ifdef CONFIG_SMP
+extern void __tlb_remove_table(void *_table);
+#endif
+
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE), GFP_KERNEL);
@@ -72,29 +81,47 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 	pud_set(pud, __pgtable_ptr_val(pmd));
 }
 
+static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
+                                  unsigned long address)
+{
+        pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE);
+}
+
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
+				GFP_KERNEL|__GFP_REPEAT);
+}
+
+static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+{
+	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
+}
+
+static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
+                                  unsigned long address)
+{
+        return pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX);
+}
+
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 				       pte_t *pte)
 {
 	pmd_set(pmd, __pgtable_ptr_val(pte));
 }
-/*
- * FIXME!!
- * Between 4K and 64K pages, we differ in what is stored in pmd. ie.
- * typedef pte_t *pgtable_t; -> 64K
- * typedef struct page *pgtable_t; -> 4k
- */
-#ifdef CONFIG_PPC_4K_PAGES
+
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 				pgtable_t pte_page)
 {
-	pmd_set(pmd, __pgtable_ptr_val(page_address(pte_page)));
+	pmd_set(pmd, __pgtable_ptr_val(pte_page));
 }
 
 static inline pgtable_t pmd_pgtable(pmd_t pmd)
 {
-	return pmd_page(pmd);
+	return (pgtable_t)pmd_page_vaddr(pmd);
 }
 
+#ifdef CONFIG_PPC_4K_PAGES
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
@@ -115,83 +142,10 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 		__free_page(page);
 		return NULL;
 	}
-	return page;
-}
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long)pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
-{
-	pgtable_page_dtor(ptepage);
-	__free_page(ptepage);
-}
-
-static inline void pgtable_free(void *table, unsigned index_size)
-{
-	if (!index_size)
-		free_page((unsigned long)table);
-	else {
-		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
-		kmem_cache_free(PGT_CACHE(index_size), table);
-	}
-}
-
-#ifdef CONFIG_SMP
-static inline void pgtable_free_tlb(struct mmu_gather *tlb,
-				    void *table, int shift)
-{
-	unsigned long pgf = (unsigned long)table;
-	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
-	pgf |= shift;
-	tlb_remove_table(tlb, (void *)pgf);
-}
-
-static inline void __tlb_remove_table(void *_table)
-{
-	void *table = (void *)((unsigned long)_table & ~MAX_PGTABLE_INDEX_SIZE);
-	unsigned shift = (unsigned long)_table & MAX_PGTABLE_INDEX_SIZE;
-
-	pgtable_free(table, shift);
-}
-#else /* !CONFIG_SMP */
-static inline void pgtable_free_tlb(struct mmu_gather *tlb,
-				    void *table, int shift)
-{
-	pgtable_free(table, shift);
-}
-#endif /* CONFIG_SMP */
-
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
-				  unsigned long address)
-{
-	tlb_flush_pgtable(tlb, address);
-	pgtable_page_dtor(table);
-	pgtable_free_tlb(tlb, page_address(table), 0);
+	return pte;
 }
-
 #else /* if CONFIG_PPC_64K_PAGES */
 
-extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
-extern void pte_fragment_free(unsigned long *, int);
-extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
-#ifdef CONFIG_SMP
-extern void __tlb_remove_table(void *_table);
-#endif
-
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-				pgtable_t pte_page)
-{
-	pmd_set(pmd, __pgtable_ptr_val(pte_page));
-}
-
-static inline pgtable_t pmd_pgtable(pmd_t pmd)
-{
-	return (pgtable_t)pmd_page_vaddr(pmd);
-}
-
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
@@ -199,10 +153,11 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
-					unsigned long address)
+				      unsigned long address)
 {
 	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
 }
+#endif
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
@@ -220,30 +175,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 	tlb_flush_pgtable(tlb, address);
 	pgtable_free_tlb(tlb, table, 0);
 }
-#endif /* CONFIG_PPC_4K_PAGES */
-
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
-				GFP_KERNEL|__GFP_REPEAT);
-}
-
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-{
-	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
-}
-
-static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
-                                  unsigned long address)
-{
-        return pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX);
-}
-
-static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
-                                  unsigned long address)
-{
-        pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE);
-}
 
 #define check_pgt_cache()	do { } while (0)
 
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index be0cce7f7d4e..0c12a3bfe2ab 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -119,46 +119,14 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 	__free_page(ptepage);
 }
 
-static inline void pgtable_free(void *table, unsigned index_size)
-{
-	if (!index_size)
-		free_page((unsigned long)table);
-	else {
-		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
-		kmem_cache_free(PGT_CACHE(index_size), table);
-	}
-}
-
+extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
 #ifdef CONFIG_SMP
-static inline void pgtable_free_tlb(struct mmu_gather *tlb,
-				    void *table, int shift)
-{
-	unsigned long pgf = (unsigned long)table;
-	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
-	pgf |= shift;
-	tlb_remove_table(tlb, (void *)pgf);
-}
-
-static inline void __tlb_remove_table(void *_table)
-{
-	void *table = (void *)((unsigned long)_table & ~MAX_PGTABLE_INDEX_SIZE);
-	unsigned shift = (unsigned long)_table & MAX_PGTABLE_INDEX_SIZE;
-
-	pgtable_free(table, shift);
-}
-#else /* !CONFIG_SMP */
-static inline void pgtable_free_tlb(struct mmu_gather *tlb,
-				    void *table, int shift)
-{
-	pgtable_free(table, shift);
-}
-#endif /* CONFIG_SMP */
-
+extern void __tlb_remove_table(void *_table);
+#endif
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
 	tlb_flush_pgtable(tlb, address);
-	pgtable_page_dtor(table);
 	pgtable_free_tlb(tlb, page_address(table), 0);
 }
 
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 158574d2acf4..51db3a37bced 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -316,12 +316,20 @@ void arch_free_page(struct page *page, int order);
 #endif
 
 struct vm_area_struct;
-
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * For BOOK3s 64 with 4k and 64K linux page size
+ * we want to use pointers, because the page table
+ * actually store pfn
+ */
+typedef pte_t *pgtable_t;
+#else
 #if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC64)
 typedef pte_t *pgtable_t;
 #else
 typedef struct page *pgtable_t;
 #endif
+#endif
 
 #include <asm-generic/memory_model.h>
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 2304b9cac59e..78910035cbca 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -367,6 +367,7 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel
 
 	return __alloc_for_cache(mm, kernel);
 }
+#endif /* CONFIG_PPC_64K_PAGES */
 
 void pte_fragment_free(unsigned long *table, int kernel)
 {
@@ -413,7 +414,6 @@ void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 	}
 }
 #endif
-#endif /* CONFIG_PPC_64K_PAGES */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
-- 
2.5.0
