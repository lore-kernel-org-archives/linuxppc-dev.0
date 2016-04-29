Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyT0xKtzDqBD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 53/70] powerpc/mm: Simplify the code dropping 4-level table
 #ifdef
Date: Fri, 29 Apr 2016 23:26:16 +1000
Message-Id: <1461936393-10131-53-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Simplify the code by dropping 4-level page table #ifdef. We are always
4-level now.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 57 +++++++++-------------------
 1 file changed, 18 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 54017260c8bf..2a246245eca0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -51,7 +51,6 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
 }
 
-#ifndef CONFIG_PPC_64K_PAGES
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 {
 	pgd_set(pgd, __pgtable_ptr_val(pud));
@@ -78,7 +77,13 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 {
 	pmd_set(pmd, __pgtable_ptr_val(pte));
 }
-
+/*
+ * FIXME!!
+ * Between 4K and 64K pages, we differ in what is stored in pmd. ie.
+ * typedef pte_t *pgtable_t; -> 64K
+ * typedef struct page *pgtable_t; -> 4k
+ */
+#ifdef CONFIG_PPC_4K_PAGES
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 				pgtable_t pte_page)
 {
@@ -176,36 +181,6 @@ extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
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
@@ -245,7 +220,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 	tlb_flush_pgtable(tlb, address);
 	pgtable_free_tlb(tlb, table, 0);
 }
-#endif /* CONFIG_PPC_64K_PAGES */
+#endif /* CONFIG_PPC_4K_PAGES */
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
@@ -258,13 +233,17 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
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
