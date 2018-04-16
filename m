Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PmMw2b7wzF1sj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 21:28:12 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3GBPwei099644
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:09 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hcstx36y0-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:09 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 16 Apr 2018 07:28:08 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V1 07/11] powerpc/mm/book3s64/4k: Switch 4k pagesize config to
 use pagetable fragment
Date: Mon, 16 Apr 2018 16:57:20 +0530
In-Reply-To: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180416112724.9677-9-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

4K config use one full page at level 4 of the pagetable. Add support for single
fragment allocation in pagetable fragment code and and use that for 4K config.
This makes both 4k and 64k use the same code path. Later we will switch pmd to
use the page table fragment code. This is done only for 64bit platforms which
is using page table fragment support.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h |  6 ++++--
 arch/powerpc/include/asm/book3s/64/mmu.h     |  6 +++---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 26 --------------------------
 arch/powerpc/mm/mmu_context_book3s64.c       | 10 ----------
 arch/powerpc/mm/pgtable-book3s64.c           | 11 ++++++++---
 5 files changed, 15 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 4b5423030d4b..00c4db2a7682 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -38,8 +38,10 @@
 #define H_PAGE_4K_PFN	0x0
 #define H_PAGE_THP_HUGE 0x0
 #define H_PAGE_COMBO	0x0
-#define H_PTE_FRAG_NR	0
-#define H_PTE_FRAG_SIZE_SHIFT  0
+
+/* 8 bytes per each pte entry */
+#define H_PTE_FRAG_SIZE_SHIFT  (H_PTE_INDEX_SIZE + 3)
+#define H_PTE_FRAG_NR	(PAGE_SIZE >> H_PTE_FRAG_SIZE_SHIFT)
 
 /* memory key bits, only 8 keys supported */
 #define H_PTE_PKEY_BIT0	0
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 5094696eecd6..fde7803a2261 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -134,10 +134,10 @@ typedef struct {
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
index 558a159600ad..826171568192 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -173,31 +173,6 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
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
@@ -209,7 +184,6 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 {
 	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
 }
-#endif
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index b75194dff64c..87ee78973a35 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -159,9 +159,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 
 	mm->context.id = index;
 
-#ifdef CONFIG_PPC_64K_PAGES
 	mm->context.pte_frag = NULL;
-#endif
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	mm_iommu_init(mm);
 #endif
@@ -192,7 +190,6 @@ static void destroy_contexts(mm_context_t *ctx)
 	spin_unlock(&mmu_context_lock);
 }
 
-#ifdef CONFIG_PPC_64K_PAGES
 static void destroy_pagetable_page(struct mm_struct *mm)
 {
 	int count;
@@ -213,13 +210,6 @@ static void destroy_pagetable_page(struct mm_struct *mm)
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
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index e4e1b2d4ca27..fc42cccb96c7 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -225,7 +225,7 @@ void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
 	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
 }
 EXPORT_SYMBOL_GPL(mmu_partition_table_set_entry);
-#ifdef CONFIG_PPC_64K_PAGES
+
 static pte_t *get_pte_from_cache(struct mm_struct *mm)
 {
 	void *pte_frag, *ret;
@@ -264,7 +264,14 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
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
@@ -291,8 +298,6 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel
 	return __alloc_for_ptecache(mm, kernel);
 }
 
-#endif /* CONFIG_PPC_64K_PAGES */
-
 void pte_fragment_free(unsigned long *table, int kernel)
 {
 	struct page *page = virt_to_page(table);
-- 
2.14.3
