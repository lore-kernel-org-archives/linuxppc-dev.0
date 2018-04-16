Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PmN44bxtzF1vy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 21:28:20 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3GBQRAn052863
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hcqq1se5p-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:18 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 16 Apr 2018 07:28:17 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V1 09/11] powerpc/mm: Implement helpers for pagetable fragment
 support at PMD level
Date: Mon, 16 Apr 2018 16:57:22 +0530
In-Reply-To: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180416112724.9677-11-aneesh.kumar@linux.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/hash-4k.h   |  2 +
 arch/powerpc/include/asm/book3s/64/hash-64k.h  |  7 +++
 arch/powerpc/include/asm/book3s/64/mmu.h       |  1 +
 arch/powerpc/include/asm/book3s/64/pgalloc.h   |  2 +
 arch/powerpc/include/asm/book3s/64/pgtable.h   |  6 ++
 arch/powerpc/include/asm/book3s/64/radix-4k.h  |  3 +
 arch/powerpc/include/asm/book3s/64/radix-64k.h |  4 ++
 arch/powerpc/mm/hash_utils_64.c                |  2 +
 arch/powerpc/mm/mmu_context_book3s64.c         | 37 ++++++++++--
 arch/powerpc/mm/pgtable-book3s64.c             | 84 ++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable-radix.c                |  2 +
 11 files changed, 144 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 00c4db2a7682..9a3798660cef 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -42,6 +42,8 @@
 /* 8 bytes per each pte entry */
 #define H_PTE_FRAG_SIZE_SHIFT  (H_PTE_INDEX_SIZE + 3)
 #define H_PTE_FRAG_NR	(PAGE_SIZE >> H_PTE_FRAG_SIZE_SHIFT)
+#define H_PMD_FRAG_SIZE_SHIFT  (H_PMD_INDEX_SIZE + 3)
+#define H_PMD_FRAG_NR	(PAGE_SIZE >> H_PMD_FRAG_SIZE_SHIFT)
 
 /* memory key bits, only 8 keys supported */
 #define H_PTE_PKEY_BIT0	0
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index cc82745355b3..c81793d47af9 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -46,6 +46,13 @@
 #define H_PTE_FRAG_SIZE_SHIFT  (H_PTE_INDEX_SIZE + 3 + 1)
 #define H_PTE_FRAG_NR	(PAGE_SIZE >> H_PTE_FRAG_SIZE_SHIFT)
 
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE)
+#define H_PMD_FRAG_SIZE_SHIFT  (H_PMD_INDEX_SIZE + 3 + 1)
+#else
+#define H_PMD_FRAG_SIZE_SHIFT  (H_PMD_INDEX_SIZE + 3)
+#endif
+#define H_PMD_FRAG_NR	(PAGE_SIZE >> H_PMD_FRAG_SIZE_SHIFT)
+
 #ifndef __ASSEMBLY__
 #include <asm/errno.h>
 
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index fde7803a2261..9c8c669a6b6a 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -138,6 +138,7 @@ typedef struct {
 	 * pagetable fragment support
 	 */
 	void *pte_frag;
+	void *pmd_frag;
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	struct list_head iommu_group_mem_list;
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index ed313b8d3fac..005f400cbf30 100644
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
index 9462bc18806c..c9db19512b3c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -246,6 +246,12 @@ extern unsigned long __pte_frag_size_shift;
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
index ca366ec86310..863c3e8286fb 100644
--- a/arch/powerpc/include/asm/book3s/64/radix-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/radix-4k.h
@@ -15,4 +15,7 @@
 #define RADIX_PTE_FRAG_SIZE_SHIFT  (RADIX_PTE_INDEX_SIZE + 3)
 #define RADIX_PTE_FRAG_NR	(PAGE_SIZE >> RADIX_PTE_FRAG_SIZE_SHIFT)
 
+#define RADIX_PMD_FRAG_SIZE_SHIFT  (RADIX_PMD_INDEX_SIZE + 3)
+#define RADIX_PMD_FRAG_NR	(PAGE_SIZE >> RADIX_PMD_FRAG_SIZE_SHIFT)
+
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
index 0bd3790d35df..63b1c1882e22 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1010,6 +1010,8 @@ void __init hash__early_init_mmu(void)
 	 */
 	__pte_frag_nr = H_PTE_FRAG_NR;
 	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
+	__pmd_frag_nr = H_PMD_FRAG_NR;
+	__pmd_frag_size_shift = H_PMD_FRAG_SIZE_SHIFT;
 
 	__pte_index_size = H_PTE_INDEX_SIZE;
 	__pmd_index_size = H_PMD_INDEX_SIZE;
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 87ee78973a35..f3d4b4a0e561 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -160,6 +160,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	mm->context.id = index;
 
 	mm->context.pte_frag = NULL;
+	mm->context.pmd_frag = NULL;
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	mm_iommu_init(mm);
 #endif
@@ -190,16 +191,11 @@ static void destroy_contexts(mm_context_t *ctx)
 	spin_unlock(&mmu_context_lock);
 }
 
-static void destroy_pagetable_page(struct mm_struct *mm)
+static void pte_frag_destroy(void *pte_frag)
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
@@ -210,6 +206,35 @@ static void destroy_pagetable_page(struct mm_struct *mm)
 	}
 }
 
+static void pmd_frag_destroy(void *pmd_frag)
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
+		pte_frag_destroy(frag);
+
+	frag = mm->context.pmd_frag;
+	if (frag)
+		pmd_frag_destroy(frag);
+	return;
+}
+
 void destroy_context(struct mm_struct *mm)
 {
 #ifdef CONFIG_SPAPR_TCE_IOMMU
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 0a05e99b54a1..47323ed8d7b5 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -20,6 +20,11 @@
 #include "mmu_decl.h"
 #include <trace/events/thp.h>
 
+unsigned long __pmd_frag_nr;
+EXPORT_SYMBOL(__pmd_frag_nr);
+unsigned long __pmd_frag_size_shift;
+EXPORT_SYMBOL(__pmd_frag_size_shift);
+
 int (*register_process_table)(unsigned long base, unsigned long page_size,
 			      unsigned long tbl_size);
 
@@ -226,6 +231,85 @@ void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
 }
 EXPORT_SYMBOL_GPL(mmu_partition_table_set_entry);
 
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
 static pte_t *get_pte_from_cache(struct mm_struct *mm)
 {
 	void *pte_frag, *ret;
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 473415750cbf..32e58024e7cb 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -640,6 +640,8 @@ void __init radix__early_init_mmu(void)
 #endif
 	__pte_frag_nr = RADIX_PTE_FRAG_NR;
 	__pte_frag_size_shift = RADIX_PTE_FRAG_SIZE_SHIFT;
+	__pmd_frag_nr = RADIX_PMD_FRAG_NR;
+	__pmd_frag_size_shift = RADIX_PMD_FRAG_SIZE_SHIFT;
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		radix_init_native();
-- 
2.14.3
