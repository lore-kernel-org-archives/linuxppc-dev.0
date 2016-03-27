Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqrD0XvtzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:26:19 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 04:26:18 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D40BA6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:13:04 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8QEgV22741026
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:26:14 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8QEch020871
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:26:14 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 49/65] powerpc/mm: Rename function to indicate we are
 allocating fragments
Date: Sun, 27 Mar 2016 13:53:57 +0530
Message-Id: <1459067053-10835-49-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only code cleanup. No functionality change.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
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
index af6a83a6c90b..2304b9cac59e 100644
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
