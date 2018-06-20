Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419lSZ532JzF0l6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 23:05:50 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5KD4OEk122056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 09:05:47 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jqmn9qg12-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 09:05:47 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 20 Jun 2018 14:05:44 +0100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org
Subject: [PATCH V3] powerpc/mm: Initialize kernel pagetable memory for PTE
 fragments
Date: Wed, 20 Jun 2018 18:35:39 +0530
Message-Id: <20180620130539.379-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kernel pagetable pages for PTE fragments never go through the standard init
sequence which can cause inaccuracies in utilization statistics reported at
places like /proc and /sysfs interfaces etc. Also the allocated page misses
out on pagetable lock and page flag init as well. Fix it by making sure all
pages allocated for either user process or kernel PTE fragments go through
same initialization.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changes in V3:

- Replaced 'kernel' argument with direct check on init_mm as per Aneesh

Changes in V2:

- Call the destructor function during free for all cases

 arch/powerpc/include/asm/book3s/64/pgalloc.h | 12 ++++-----
 arch/powerpc/mm/pgtable-book3s64.c           | 37 +++++++++++++---------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 01ee40f..ccb351c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -41,9 +41,9 @@ struct vmemmap_backing {
 			pgtable_cache[(shift) - 1];	\
 		})
 
-extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
+extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long);
 extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
-extern void pte_fragment_free(unsigned long *, int);
+extern void pte_fragment_free(unsigned long *);
 extern void pmd_fragment_free(unsigned long *);
 extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
 #ifdef CONFIG_SMP
@@ -176,23 +176,23 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
-	return (pte_t *)pte_fragment_alloc(mm, address, 1);
+	return (pte_t *)pte_fragment_alloc(mm, address);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 				      unsigned long address)
 {
-	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
+	return (pgtable_t)pte_fragment_alloc(mm, address);
 }
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	pte_fragment_free((unsigned long *)pte, 1);
+	pte_fragment_free((unsigned long *)pte);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 {
-	pte_fragment_free((unsigned long *)ptepage, 0);
+	pte_fragment_free((unsigned long *)ptepage);
 }
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index c1f4ca4..b792f8a 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -333,25 +333,23 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
 	return (pte_t *)ret;
 }
 
-static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
+static pte_t *__alloc_for_ptecache(struct mm_struct *mm)
 {
+	gfp_t gfp_mask = PGALLOC_GFP;
 	void *ret = NULL;
 	struct page *page;
 
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
+	if (mm != &init_mm)
+		gfp_mask |= __GFP_ACCOUNT;
 
+	page = alloc_page(gfp_mask);
+	if (!page)
+		return NULL;
+
+	if (!pgtable_page_ctor(page)) {
+		__free_page(page);
+		return NULL;
+	}
 
 	ret = page_address(page);
 	/*
@@ -375,7 +373,7 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 	return (pte_t *)ret;
 }
 
-pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
+pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr)
 {
 	pte_t *pte;
 
@@ -383,16 +381,15 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel
 	if (pte)
 		return pte;
 
-	return __alloc_for_ptecache(mm, kernel);
+	return __alloc_for_ptecache(mm);
 }
 
-void pte_fragment_free(unsigned long *table, int kernel)
+void pte_fragment_free(unsigned long *table)
 {
 	struct page *page = virt_to_page(table);
 
 	if (put_page_testzero(page)) {
-		if (!kernel)
-			pgtable_page_dtor(page);
+		pgtable_page_dtor(page);
 		free_unref_page(page);
 	}
 }
@@ -401,7 +398,7 @@ static inline void pgtable_free(void *table, int index)
 {
 	switch (index) {
 	case PTE_INDEX:
-		pte_fragment_free(table, 0);
+		pte_fragment_free(table);
 		break;
 	case PMD_INDEX:
 		pmd_fragment_free(table);
-- 
1.8.3.1
