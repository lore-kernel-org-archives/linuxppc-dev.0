Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyV03k9zDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 54/70] powerpc/mm: Rename function to indicate we are
 allocating fragments
Date: Fri, 29 Apr 2016 23:26:17 +1000
Message-Id: <1461936393-10131-54-git-send-email-mpe@ellerman.id.au>
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

Only code cleanup. No functionality change.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 12 ++++++------
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 12 ++++++------
 arch/powerpc/mm/pgtable_64.c                 | 21 ++++-----------------
 3 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 2a246245eca0..37283e3d8e56 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -174,8 +174,8 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 
 #else /* if CONFIG_PPC_64K_PAGES */
 
-extern pte_t *page_table_alloc(struct mm_struct *, unsigned long, int);
-extern void page_table_free(struct mm_struct *, unsigned long *, int);
+extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
+extern void pte_fragment_free(unsigned long *, int);
 extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
 #ifdef CONFIG_SMP
 extern void __tlb_remove_table(void *_table);
@@ -195,23 +195,23 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
-	return (pte_t *)page_table_alloc(mm, address, 1);
+	return (pte_t *)pte_fragment_alloc(mm, address, 1);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 					unsigned long address)
 {
-	return (pgtable_t)page_table_alloc(mm, address, 0);
+	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
 }
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	page_table_free(mm, (unsigned long *)pte, 1);
+	pte_fragment_free((unsigned long *)pte, 1);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 {
-	page_table_free(mm, (unsigned long *)ptepage, 0);
+	pte_fragment_free((unsigned long *)ptepage, 0);
 }
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 69ef28a81733..be0cce7f7d4e 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -164,8 +164,8 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 
 #else /* if CONFIG_PPC_64K_PAGES */
 
-extern pte_t *page_table_alloc(struct mm_struct *, unsigned long, int);
-extern void page_table_free(struct mm_struct *, unsigned long *, int);
+extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
+extern void pte_fragment_free(unsigned long *, int);
 extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
 #ifdef CONFIG_SMP
 extern void __tlb_remove_table(void *_table);
@@ -193,23 +193,23 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
-	return (pte_t *)page_table_alloc(mm, address, 1);
+	return (pte_t *)pte_fragment_alloc(mm, address, 1);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 					unsigned long address)
 {
-	return (pgtable_t)page_table_alloc(mm, address, 0);
+	return (pgtable_t)pte_fragment_alloc(mm, address, 0);
 }
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	page_table_free(mm, (unsigned long *)pte, 1);
+	pte_fragment_fre((unsigned long *)pte, 1);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 {
-	page_table_free(mm, (unsigned long *)ptepage, 0);
+	pte_fragment_free((unsigned long *)ptepage, 0);
 }
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index dafcd9ff78df..a9a2238c5565 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -357,7 +357,7 @@ static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
 	return (pte_t *)ret;
 }
 
-pte_t *page_table_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
+pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
 {
 	pte_t *pte;
 
@@ -368,7 +368,7 @@ pte_t *page_table_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
 	return __alloc_for_cache(mm, kernel);
 }
 
-void page_table_free(struct mm_struct *mm, unsigned long *table, int kernel)
+void pte_fragment_free(unsigned long *table, int kernel)
 {
 	struct page *page = virt_to_page(table);
 	if (put_page_testzero(page)) {
@@ -379,15 +379,6 @@ void page_table_free(struct mm_struct *mm, unsigned long *table, int kernel)
 }
 
 #ifdef CONFIG_SMP
-static void page_table_free_rcu(void *table)
-{
-	struct page *page = virt_to_page(table);
-	if (put_page_testzero(page)) {
-		pgtable_page_dtor(page);
-		free_hot_cold_page(page, 0);
-	}
-}
-
 void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 {
 	unsigned long pgf = (unsigned long)table;
@@ -404,7 +395,7 @@ void __tlb_remove_table(void *_table)
 
 	if (!shift)
 		/* PTE page needs special handling */
-		page_table_free_rcu(table);
+		pte_fragment_free(table, 0);
 	else {
 		BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
 		kmem_cache_free(PGT_CACHE(shift), table);
@@ -415,11 +406,7 @@ void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 {
 	if (!shift) {
 		/* PTE page needs special handling */
-		struct page *page = virt_to_page(table);
-		if (put_page_testzero(page)) {
-			pgtable_page_dtor(page);
-			free_hot_cold_page(page, 0);
-		}
+		pte_fragment_free(table, 0);
 	} else {
 		BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
 		kmem_cache_free(PGT_CACHE(shift), table);
-- 
2.5.0
