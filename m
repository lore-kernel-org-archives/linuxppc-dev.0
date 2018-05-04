Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cs033hSnzDqlR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 22:34:27 +1000 (AEST)
Message-Id: <7806b2c341cb3acfedbada47ad0d828f8aca0758.1525435203.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 16/17] powerpc/mm: Make pte_fragment_alloc() common to PPC32
 and PPC64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  4 May 2018 14:34:22 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to allow the 8xx to handle pte_fragments, this patch
makes in common to PPC32 and PPC64

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu_context.h | 28 ++++++++++++++
 arch/powerpc/mm/mmu_context_book3s64.c | 28 --------------
 arch/powerpc/mm/pgtable.c              | 67 ++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable_64.c           | 67 ----------------------------------
 arch/powerpc/platforms/Kconfig.cputype |  5 +++
 5 files changed, 100 insertions(+), 95 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 1835ca1505d6..252988f7e219 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -262,5 +262,33 @@ static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
 
 #endif /* CONFIG_PPC_MEM_KEYS */
 
+#ifdef CONFIG_NEED_PTE_FRAG
+static inline void destroy_pagetable_page(struct mm_struct *mm)
+{
+	int count;
+	void *pte_frag;
+	struct page *page;
+
+	pte_frag = mm->context.pte_frag;
+	if (!pte_frag)
+		return;
+
+	page = virt_to_page(pte_frag);
+	/* drop all the pending references */
+	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
+	/* We allow PTE_FRAG_NR fragments from a PTE page */
+	if (page_ref_sub_and_test(page, PTE_FRAG_NR - count)) {
+		pgtable_page_dtor(page);
+		free_unref_page(page);
+	}
+}
+
+#else
+static inline void destroy_pagetable_page(struct mm_struct *mm)
+{
+	return;
+}
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index b75194dff64c..2f55a4e3c09a 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -192,34 +192,6 @@ static void destroy_contexts(mm_context_t *ctx)
 	spin_unlock(&mmu_context_lock);
 }
 
-#ifdef CONFIG_PPC_64K_PAGES
-static void destroy_pagetable_page(struct mm_struct *mm)
-{
-	int count;
-	void *pte_frag;
-	struct page *page;
-
-	pte_frag = mm->context.pte_frag;
-	if (!pte_frag)
-		return;
-
-	page = virt_to_page(pte_frag);
-	/* drop all the pending references */
-	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
-	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (page_ref_sub_and_test(page, PTE_FRAG_NR - count)) {
-		pgtable_page_dtor(page);
-		free_unref_page(page);
-	}
-}
-
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
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 9f361ae571e9..2d34755ed727 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -264,3 +264,70 @@ unsigned long vmalloc_to_phys(void *va)
 	return __pa(pfn_to_kaddr(pfn)) + offset_in_page(va);
 }
 EXPORT_SYMBOL_GPL(vmalloc_to_phys);
+
+#ifdef CONFIG_NEED_PTE_FRAG
+static pte_t *get_from_cache(struct mm_struct *mm)
+{
+	void *pte_frag, *ret;
+
+	spin_lock(&mm->page_table_lock);
+	ret = mm->context.pte_frag;
+	if (ret) {
+		pte_frag = ret + PTE_FRAG_SIZE;
+		/*
+		 * If we have taken up all the fragments mark PTE page NULL
+		 */
+		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
+			pte_frag = NULL;
+		mm->context.pte_frag = pte_frag;
+	}
+	spin_unlock(&mm->page_table_lock);
+	return (pte_t *)ret;
+}
+
+static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
+{
+	void *ret = NULL;
+	struct page *page;
+
+	if (!kernel) {
+		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
+		if (!page)
+			return NULL;
+		if (!pgtable_page_ctor(page)) {
+			__free_page(page);
+			return NULL;
+		}
+	} else {
+		page = alloc_page(PGALLOC_GFP);
+		if (!page)
+			return NULL;
+	}
+
+	ret = page_address(page);
+	spin_lock(&mm->page_table_lock);
+	/*
+	 * If we find pgtable_page set, we return
+	 * the allocated page with single fragement
+	 * count.
+	 */
+	if (likely(!mm->context.pte_frag)) {
+		set_page_count(page, PTE_FRAG_NR);
+		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
+	}
+	spin_unlock(&mm->page_table_lock);
+
+	return (pte_t *)ret;
+}
+
+pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
+{
+	pte_t *pte;
+
+	pte = get_from_cache(mm);
+	if (pte)
+		return pte;
+
+	return __alloc_for_cache(mm, kernel);
+}
+#endif
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index dd1102a246e4..1d8dc37d98a7 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -139,73 +139,6 @@ struct page *pmd_page(pmd_t pmd)
 	return virt_to_page(pmd_page_vaddr(pmd));
 }
 
-#ifdef CONFIG_PPC_64K_PAGES
-static pte_t *get_from_cache(struct mm_struct *mm)
-{
-	void *pte_frag, *ret;
-
-	spin_lock(&mm->page_table_lock);
-	ret = mm->context.pte_frag;
-	if (ret) {
-		pte_frag = ret + PTE_FRAG_SIZE;
-		/*
-		 * If we have taken up all the fragments mark PTE page NULL
-		 */
-		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
-			pte_frag = NULL;
-		mm->context.pte_frag = pte_frag;
-	}
-	spin_unlock(&mm->page_table_lock);
-	return (pte_t *)ret;
-}
-
-static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
-{
-	void *ret = NULL;
-	struct page *page;
-
-	if (!kernel) {
-		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
-		if (!page)
-			return NULL;
-		if (!pgtable_page_ctor(page)) {
-			__free_page(page);
-			return NULL;
-		}
-	} else {
-		page = alloc_page(PGALLOC_GFP);
-		if (!page)
-			return NULL;
-	}
-
-	ret = page_address(page);
-	spin_lock(&mm->page_table_lock);
-	/*
-	 * If we find pgtable_page set, we return
-	 * the allocated page with single fragement
-	 * count.
-	 */
-	if (likely(!mm->context.pte_frag)) {
-		set_page_count(page, PTE_FRAG_NR);
-		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
-	}
-	spin_unlock(&mm->page_table_lock);
-
-	return (pte_t *)ret;
-}
-
-pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
-{
-	pte_t *pte;
-
-	pte = get_from_cache(mm);
-	if (pte)
-		return pte;
-
-	return __alloc_for_cache(mm, kernel);
-}
-#endif /* CONFIG_PPC_64K_PAGES */
-
 void pte_fragment_free(unsigned long *table, int kernel)
 {
 	struct page *page = virt_to_page(table);
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f860f0326c78..7172b04c91b5 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -337,6 +337,11 @@ config PPC_MM_SLICES
 	default y if PPC_8xx && HUGETLB_PAGE
 	default n
 
+config NEED_PTE_FRAG
+	bool
+	default y if PPC_BOOK3S_64 && PPC_64K_PAGES
+	default n
+
 config PPC_HAVE_PMU_SUPPORT
        bool
 
-- 
2.13.3
