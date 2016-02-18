Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C6641A0509
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 03:51:39 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 18 Feb 2016 11:51:36 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 81504C90041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 11:51:31 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1IGpXCH29294706
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 16:51:34 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1IGlu0I003723
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 11:47:57 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 09/30] powerpc/mm: Copy pgalloc (part 3)
Date: Thu, 18 Feb 2016 22:20:33 +0530
Message-Id: <1455814254-10226-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 5bb6852fa771..f06ad7354d68 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -51,7 +51,6 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
 }
 
-#ifndef CONFIG_PPC_64K_PAGES
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 {
 	pgd_set(pgd, (unsigned long)pud);
@@ -79,6 +78,14 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 	pmd_set(pmd, (unsigned long)pte);
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
-	pgd_set(pgd, (unsigned long)pud);
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
-	pud_set(pud, (unsigned long)pmd);
-}
-
-static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
-				       pte_t *pte)
-{
-	pmd_set(pmd, (unsigned long)pte);
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
