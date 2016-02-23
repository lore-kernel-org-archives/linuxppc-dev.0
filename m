Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2310C1A05C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 15:48:58 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 21:48:57 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9B00619D8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:36:50 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N4mrHw31785078
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:48:53 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N4mq46012858
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 21:48:52 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 10/18] powerpc/mm: Copy pgalloc (part 3)
Date: Tue, 23 Feb 2016 10:18:12 +0530
Message-Id: <1456202900-5454-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

64bit book3s now always have 4 level page table irrespective of linux
page size. Move the related code out of #ifdef

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 55 +++++++++-------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 54017260c8bf..c6ba334a38c1 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -51,7 +51,6 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
 }
 
-#ifndef CONFIG_PPC_64K_PAGES
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 {
 	pgd_set(pgd, __pgtable_ptr_val(pud));
@@ -79,6 +78,14 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 	pmd_set(pmd, __pgtable_ptr_val(pte));
 }
 
+/*
+ * FIXME!!
+ * Between 4K and 64K pages, we differ in what is stored in pmd. ie.
+ * typedef pte_t *pgtable_t; -> 64K
+ * typedef struct page *pgtable_t; -> 4k
+ */
+#ifndef CONFIG_PPC_64K_PAGES
+
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 				pgtable_t pte_page)
 {
@@ -176,36 +183,6 @@ extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
 extern void __tlb_remove_table(void *_table);
 #endif
 
-#ifndef __PAGETABLE_PUD_FOLDED
-/* book3s 64 is 4 level page table */
-static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
-{
-	pgd_set(pgd, __pgtable_ptr_val(pud));
-}
-
-static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE),
-				GFP_KERNEL|__GFP_REPEAT);
-}
-
-static inline void pud_free(struct mm_struct *mm, pud_t *pud)
-{
-	kmem_cache_free(PGT_CACHE(PUD_INDEX_SIZE), pud);
-}
-#endif
-
-static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
-{
-	pud_set(pud, __pgtable_ptr_val(pmd));
-}
-
-static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
-				       pte_t *pte)
-{
-	pmd_set(pmd, __pgtable_ptr_val(pte));
-}
-
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 				pgtable_t pte_page)
 {
@@ -258,13 +235,17 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
 }
 
-#define __pmd_free_tlb(tlb, pmd, addr)		      \
-	pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX)
-#ifndef __PAGETABLE_PUD_FOLDED
-#define __pud_free_tlb(tlb, pud, addr)		      \
-	pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE)
+static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
+                                  unsigned long address)
+{
+        return pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX);
+}
 
-#endif /* __PAGETABLE_PUD_FOLDED */
+static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
+                                  unsigned long address)
+{
+        pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE);
+}
 
 #define check_pgt_cache()	do { } while (0)
 
-- 
2.5.0
