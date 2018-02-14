Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhLQN2CMpzF1GL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 00:50:36 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1EDnCDs044780
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 08:50:33 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g4nw6hckx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 08:50:33 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 14 Feb 2018 08:50:32 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 3/6] powerpc/mm: Implement helpers for pagetable fragment
 support at PMD level
Date: Wed, 14 Feb 2018 19:20:06 +0530
In-Reply-To: <20180214135009.32748-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180214135009.32748-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180214135009.32748-4-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/hash-4k.h   |  4 ++
 arch/powerpc/include/asm/book3s/64/hash-64k.h  |  4 ++
 arch/powerpc/include/asm/book3s/64/mmu.h       |  1 +
 arch/powerpc/include/asm/book3s/64/pgalloc.h   |  2 +
 arch/powerpc/include/asm/book3s/64/pgtable.h   |  6 ++
 arch/powerpc/include/asm/book3s/64/radix-4k.h  |  2 +
 arch/powerpc/include/asm/book3s/64/radix-64k.h |  4 ++
 arch/powerpc/mm/hash_utils_64.c                |  2 +
 arch/powerpc/mm/mmu_context_book3s64.c         | 37 +++++++++--
 arch/powerpc/mm/pgtable-radix.c                |  2 +
 arch/powerpc/mm/pgtable_64.c                   | 85 ++++++++++++++++++++++++++
 11 files changed, 143 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 62098daa3af8..fc3dc6a93939 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -36,6 +36,10 @@
 /* 8 bytes per each pte entry */
 #define H_PTE_FRAG_SIZE_SHIFT  (H_PTE_INDEX_SIZE + 3)
 #define H_PTE_FRAG_NR	(PAGE_SIZE >> H_PTE_FRAG_SIZE_SHIFT)
+
+#define H_PMD_FRAG_SIZE_SHIFT  (H_PMD_INDEX_SIZE + 3)
+#define H_PMD_FRAG_NR	(PAGE_SIZE >> H_PMD_FRAG_SIZE_SHIFT)
+
 /*
  * On all 4K setups, remap_4k_pfn() equates to remap_pfn_range()
  */
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 0aa4f755b3f6..b8ca64fd2bea 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -33,6 +33,10 @@
 #define H_PTE_FRAG_SIZE_SHIFT  (H_PTE_INDEX_SIZE + 3 + 1)
 #define H_PTE_FRAG_NR	(PAGE_SIZE >> H_PTE_FRAG_SIZE_SHIFT)
 
+/* +1 for THP and hugetlb */
+#define H_PMD_FRAG_SIZE_SHIFT  (H_PMD_INDEX_SIZE + 3 + 1)
+#define H_PMD_FRAG_NR	(PAGE_SIZE >> H_PMD_FRAG_SIZE_SHIFT)
+
 #ifndef __ASSEMBLY__
 #include <asm/errno.h>
 
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 00a961bc76a9..ad19651ea10e 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -105,6 +105,7 @@ typedef struct {
 	 * pagetable fragment support
 	 */
 	void *pte_frag;
+	void *pmd_frag;
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	struct list_head iommu_group_mem_list;
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 8de75c2ae7c9..f3838ad0dc6c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -42,7 +42,9 @@ extern struct kmem_cache *pgtable_cache[];
 		})
 
 extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
+extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
 extern void pte_fragment_free(unsigned long *, int);
+extern void pmd_fragment_free(unsigned long *);
 extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
 #ifdef CONFIG_SMP
 extern void __tlb_remove_table(void *_table);
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index a6b9f1d74600..88d10319adfe 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -265,6 +265,12 @@ extern unsigned long __pte_frag_size_shift;
 #define PTE_FRAG_SIZE_SHIFT __pte_frag_size_shift
 #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
 
+extern unsigned long __pmd_frag_nr;
+#define PMD_FRAG_NR __pmd_frag_nr
+extern unsigned long __pmd_frag_size_shift;
+#define PMD_FRAG_SIZE_SHIFT __pmd_frag_size_shift
+#define PMD_FRAG_SIZE (1UL << PMD_FRAG_SIZE_SHIFT)
+
 #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
 #define PTRS_PER_PUD	(1 << PUD_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/book3s/64/radix-4k.h b/arch/powerpc/include/asm/book3s/64/radix-4k.h
index 14717cfe15e2..863c3e8286fb 100644
--- a/arch/powerpc/include/asm/book3s/64/radix-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/radix-4k.h
@@ -15,5 +15,7 @@
 #define RADIX_PTE_FRAG_SIZE_SHIFT  (RADIX_PTE_INDEX_SIZE + 3)
 #define RADIX_PTE_FRAG_NR	(PAGE_SIZE >> RADIX_PTE_FRAG_SIZE_SHIFT)
 
+#define RADIX_PMD_FRAG_SIZE_SHIFT  (RADIX_PMD_INDEX_SIZE + 3)
+#define RADIX_PMD_FRAG_NR	(PAGE_SIZE >> RADIX_PMD_FRAG_SIZE_SHIFT)
 
 #endif /* _ASM_POWERPC_PGTABLE_RADIX_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/radix-64k.h b/arch/powerpc/include/asm/book3s/64/radix-64k.h
index 830082496876..ccb78ca9d0c5 100644
--- a/arch/powerpc/include/asm/book3s/64/radix-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/radix-64k.h
@@ -16,4 +16,8 @@
  */
 #define RADIX_PTE_FRAG_SIZE_SHIFT  (RADIX_PTE_INDEX_SIZE + 3)
 #define RADIX_PTE_FRAG_NR	(PAGE_SIZE >> RADIX_PTE_FRAG_SIZE_SHIFT)
+
+#define RADIX_PMD_FRAG_SIZE_SHIFT  (RADIX_PMD_INDEX_SIZE + 3)
+#define RADIX_PMD_FRAG_NR	(PAGE_SIZE >> RADIX_PMD_FRAG_SIZE_SHIFT)
+
 #endif /* _ASM_POWERPC_PGTABLE_RADIX_64K_H */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index cf290d415dcd..efdb49124b2a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1003,6 +1003,8 @@ void __init hash__early_init_mmu(void)
 	 */
 	__pte_frag_nr = H_PTE_FRAG_NR;
 	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
+	__pmd_frag_nr = H_PMD_FRAG_NR;
+	__pmd_frag_size_shift = H_PMD_FRAG_SIZE_SHIFT;
 
 	__pte_index_size = H_PTE_INDEX_SIZE;
 	__pmd_index_size = H_PMD_INDEX_SIZE;
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index b4d795b5162a..ee2b1fa0cbe3 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -167,6 +167,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	mm->context.id = index;
 
 	mm->context.pte_frag = NULL;
+	mm->context.pmd_frag = NULL;
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	mm_iommu_init(mm);
 #endif
@@ -183,16 +184,11 @@ void __destroy_context(int context_id)
 }
 EXPORT_SYMBOL_GPL(__destroy_context);
 
-static void destroy_pagetable_page(struct mm_struct *mm)
+static void pte_frag_destory(void *pte_frag)
 {
 	int count;
-	void *pte_frag;
 	struct page *page;
 
-	pte_frag = mm->context.pte_frag;
-	if (!pte_frag)
-		return;
-
 	page = virt_to_page(pte_frag);
 	/* drop all the pending references */
 	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
@@ -203,6 +199,35 @@ static void destroy_pagetable_page(struct mm_struct *mm)
 	}
 }
 
+static void pmd_frag_destory(void *pmd_frag)
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
+
+static void destroy_pagetable_page(struct mm_struct *mm)
+{
+	void *frag;
+
+	frag = mm->context.pte_frag;
+	if (frag)
+		pte_frag_destory(frag);
+
+	frag = mm->context.pmd_frag;
+	if (frag)
+		pmd_frag_destory(frag);
+	return;
+}
+
 void destroy_context(struct mm_struct *mm)
 {
 #ifdef CONFIG_SPAPR_TCE_IOMMU
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index f8b3f4a99659..b2f89851d8eb 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -559,6 +559,8 @@ void __init radix__early_init_mmu(void)
 #endif
 	__pte_frag_nr = RADIX_PTE_FRAG_NR;
 	__pte_frag_size_shift = RADIX_PTE_FRAG_SIZE_SHIFT;
+	__pmd_frag_nr = RADIX_PMD_FRAG_NR;
+	__pmd_frag_size_shift = RADIX_PMD_FRAG_SIZE_SHIFT;
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		radix_init_native();
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index ff4973565abb..0a6859e6ef76 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -114,6 +114,11 @@ unsigned long __pte_frag_nr;
 EXPORT_SYMBOL(__pte_frag_nr);
 unsigned long __pte_frag_size_shift;
 EXPORT_SYMBOL(__pte_frag_size_shift);
+unsigned long __pmd_frag_nr;
+EXPORT_SYMBOL(__pmd_frag_nr);
+unsigned long __pmd_frag_size_shift;
+EXPORT_SYMBOL(__pmd_frag_size_shift);
+
 unsigned long ioremap_bot;
 #else /* !CONFIG_PPC_BOOK3S_64 */
 unsigned long ioremap_bot = IOREMAP_BASE;
@@ -393,6 +398,75 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel
 	return __alloc_for_ptecache(mm, kernel);
 }
 
+static pmd_t *get_pmd_from_cache(struct mm_struct *mm)
+{
+	void *pmd_frag, *ret;
+
+	spin_lock(&mm->page_table_lock);
+	ret = mm->context.pmd_frag;
+	if (ret) {
+		pmd_frag = ret + PMD_FRAG_SIZE;
+		/*
+		 * If we have taken up all the fragments mark PTE page NULL
+		 */
+		if (((unsigned long)pmd_frag & ~PAGE_MASK) == 0)
+			pmd_frag = NULL;
+		mm->context.pmd_frag = pmd_frag;
+	}
+	spin_unlock(&mm->page_table_lock);
+	return (pmd_t *)ret;
+}
+
+static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
+{
+	void *ret = NULL;
+	struct page *page;
+	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO;
+
+	if (mm == &init_mm)
+		gfp &= ~__GFP_ACCOUNT;
+	page = alloc_page(gfp);
+	if (!page)
+		return NULL;
+	if (!pgtable_pmd_page_ctor(page)) {
+		__free_pages(page, 0);
+		return NULL;
+	}
+
+	ret = page_address(page);
+	/*
+	 * if we support only one fragment just return the
+	 * allocated page.
+	 */
+	if (PMD_FRAG_NR == 1)
+		return ret;
+
+	spin_lock(&mm->page_table_lock);
+	/*
+	 * If we find pgtable_page set, we return
+	 * the allocated page with single fragement
+	 * count.
+	 */
+	if (likely(!mm->context.pmd_frag)) {
+		set_page_count(page, PMD_FRAG_NR);
+		mm->context.pmd_frag = ret + PMD_FRAG_SIZE;
+	}
+	spin_unlock(&mm->page_table_lock);
+
+	return (pmd_t *)ret;
+}
+
+pmd_t *pmd_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr)
+{
+	pmd_t *pmd;
+
+	pmd = get_pmd_from_cache(mm);
+	if (pmd)
+		return pmd;
+
+	return __alloc_for_pmdcache(mm);
+}
+
 void pte_fragment_free(unsigned long *table, int kernel)
 {
 	struct page *page = virt_to_page(table);
@@ -403,6 +477,17 @@ void pte_fragment_free(unsigned long *table, int kernel)
 	}
 }
 
+void pmd_fragment_free(unsigned long *pmd)
+{
+	struct page *page = virt_to_page(pmd);
+
+	if (put_page_testzero(page)) {
+		pgtable_pmd_page_dtor(page);
+		free_unref_page(page);
+	}
+}
+
+
 #ifdef CONFIG_SMP
 void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 {
-- 
2.14.3
