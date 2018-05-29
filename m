Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wJ901x5RzDrCl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 01:50:43 +1000 (AEST)
Message-Id: <460641f4a6e977faa7b087f1ce0337931cd101d3.1527608397.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527608397.git.christophe.leroy@c-s.fr>
References: <cover.1527608397.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 12/14] powerpc/mm: Make pte_fragment_alloc() common to
 PPC32 and PPC64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 May 2018 15:50:38 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to allow the 8xx to handle pte_fragments, this patch
makes it common to PPC32 and PPC64 by moving the related code
to common files and by defining a new config item called
CONFIG_NEED_PTE_FRAG

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu_context.h | 53 ++++++++++++++++++++++++
 arch/powerpc/include/asm/page.h        |  2 +-
 arch/powerpc/mm/mmu_context_book3s64.c | 44 --------------------
 arch/powerpc/mm/pgtable-book3s64.c     | 72 ---------------------------------
 arch/powerpc/mm/pgtable.c              | 74 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype | 15 +++++++
 6 files changed, 143 insertions(+), 117 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 1835ca1505d6..aa098b640f74 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -262,5 +262,58 @@ static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
 
 #endif /* CONFIG_PPC_MEM_KEYS */
 
+#ifdef CONFIG_NEED_PTE_FRAG
+static inline void pte_frag_destroy(void *pte_frag)
+{
+	int count;
+	struct page *page;
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
+#endif
+
+#ifdef CONFIG_NEED_PMD_FRAG
+static inline void pmd_frag_destroy(void *pmd_frag)
+{
+	int count;
+	struct page *page;
+
+	page = virt_to_page(pmd_frag);
+	/* drop all the pending references */
+	count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
+	/* We allow PTE_FRAG_NR fragments from a PTE page */
+	if (page_ref_sub_and_test(page, PMD_FRAG_NR - count)) {
+		pgtable_pmd_page_dtor(page);
+		free_unref_page(page);
+	}
+}
+#endif
+
+static inline void destroy_pagetable_page(struct mm_struct *mm)
+{
+#ifdef CONFIG_NEED_PAGE_FRAG
+	void *frag;
+
+#ifdef CONFIG_NEED_PTE_FRAG
+	frag = mm->context.pte_frag;
+	if (frag)
+		pte_frag_destroy(frag);
+#endif
+
+#ifdef CONFIG_NEED_PMD_FRAG
+	frag = mm->context.pmd_frag;
+	if (frag)
+		pmd_frag_destroy(frag);
+#endif
+#endif
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index db7be0779d55..cd10564ff7df 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -344,7 +344,7 @@ struct vm_area_struct;
  */
 typedef pte_t *pgtable_t;
 #else
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC64)
+#if defined(CONFIG_NEED_PTE_FRAG)
 typedef pte_t *pgtable_t;
 #else
 typedef struct page *pgtable_t;
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index f3d4b4a0e561..98e6906dbc7a 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -191,50 +191,6 @@ static void destroy_contexts(mm_context_t *ctx)
 	spin_unlock(&mmu_context_lock);
 }
 
-static void pte_frag_destroy(void *pte_frag)
-{
-	int count;
-	struct page *page;
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
-static void pmd_frag_destroy(void *pmd_frag)
-{
-	int count;
-	struct page *page;
-
-	page = virt_to_page(pmd_frag);
-	/* drop all the pending references */
-	count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
-	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (page_ref_sub_and_test(page, PMD_FRAG_NR - count)) {
-		pgtable_pmd_page_dtor(page);
-		free_unref_page(page);
-	}
-}
-
-static void destroy_pagetable_page(struct mm_struct *mm)
-{
-	void *frag;
-
-	frag = mm->context.pte_frag;
-	if (frag)
-		pte_frag_destroy(frag);
-
-	frag = mm->context.pmd_frag;
-	if (frag)
-		pmd_frag_destroy(frag);
-	return;
-}
-
 void destroy_context(struct mm_struct *mm)
 {
 #ifdef CONFIG_SPAPR_TCE_IOMMU
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index abda2b92f1ba..6a0e0fb1f842 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -310,78 +310,6 @@ void pmd_fragment_free(unsigned long *pmd)
 	}
 }
 
-static pte_t *get_pte_from_cache(struct mm_struct *mm)
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
-static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
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
-
-	ret = page_address(page);
-	/*
-	 * if we support only one fragment just return the
-	 * allocated page.
-	 */
-	if (PTE_FRAG_NR == 1)
-		return ret;
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
-	pte = get_pte_from_cache(mm);
-	if (pte)
-		return pte;
-
-	return __alloc_for_ptecache(mm, kernel);
-}
-
 void pte_fragment_free(unsigned long *table, int kernel)
 {
 	struct page *page = virt_to_page(table);
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 9f361ae571e9..3b3e51e9e431 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -264,3 +264,77 @@ unsigned long vmalloc_to_phys(void *va)
 	return __pa(pfn_to_kaddr(pfn)) + offset_in_page(va);
 }
 EXPORT_SYMBOL_GPL(vmalloc_to_phys);
+
+#ifdef CONFIG_NEED_PTE_FRAG
+static pte_t *get_pte_from_cache(struct mm_struct *mm)
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
+static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
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
+
+	ret = page_address(page);
+	/*
+	 * if we support only one fragment just return the
+	 * allocated page.
+	 */
+	if (PTE_FRAG_NR == 1)
+		return ret;
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
+	pte = get_pte_from_cache(mm);
+	if (pte)
+		return pte;
+
+	return __alloc_for_ptecache(mm, kernel);
+}
+#endif
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 09ed04377a98..ddccae5ed192 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -341,6 +341,21 @@ config PPC_MM_SLICES
 	default y if PPC_8xx && HUGETLB_PAGE
 	default n
 
+config NEED_PAGE_FRAG
+	bool
+
+config NEED_PTE_FRAG
+	bool
+	default y if PPC_BOOK3S_64
+	default n
+	select NEED_PAGE_FRAG
+
+config NEED_PMD_FRAG
+	bool
+	default y if PPC_BOOK3S_64
+	default n
+	select NEED_PAGE_FRAG
+
 config PPC_HAVE_PMU_SUPPORT
        bool
 
-- 
2.13.3
