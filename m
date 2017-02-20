Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRRxQ3PkDzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 13:13:14 +1100 (AEDT)
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vRRxP5LZtz9ryT
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 13:13:13 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 1so3656136pgz.2
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2017 18:13:13 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 1/2] powerpc/mm: Refactor page table allocation
Date: Mon, 20 Feb 2017 13:12:56 +1100
Message-Id: <20170220021257.26959-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce a helper pgtable_get_gfp_flags() which
just returns the current gfp flags. In a future
patch, we can enable __GFP_ACCOUNT based on the
calling context.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 22 ++++++++++++++++------
 arch/powerpc/mm/pgtable_64.c                 |  3 ++-
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index cd5e7aa..d0a9ca6 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -50,13 +50,19 @@ extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
 extern void __tlb_remove_table(void *_table);
 #endif
 
+static inline gfp_t pgtable_get_gfp_flags(struct mm_struct *mm, gfp_t gfp)
+{
+	return gfp;
+}
+
 static inline pgd_t *radix__pgd_alloc(struct mm_struct *mm)
 {
 #ifdef CONFIG_PPC_64K_PAGES
-	return (pgd_t *)__get_free_page(PGALLOC_GFP);
+	return (pgd_t *)__get_free_page(pgtable_get_gfp_flags(mm, PGALLOC_GFP));
 #else
 	struct page *page;
-	page = alloc_pages(PGALLOC_GFP | __GFP_REPEAT, 4);
+	page = alloc_pages(pgtable_get_gfp_flags(mm,
+				PGALLOC_GFP | __GFP_REPEAT), 4);
 	if (!page)
 		return NULL;
 	return (pgd_t *) page_address(page);
@@ -76,7 +82,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	if (radix_enabled())
 		return radix__pgd_alloc(mm);
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE), GFP_KERNEL);
+	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+		pgtable_get_gfp_flags(mm, GFP_KERNEL));
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
@@ -93,7 +100,8 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE), GFP_KERNEL);
+	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE),
+		pgtable_get_gfp_flags(mm, GFP_KERNEL));
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
@@ -119,7 +127,8 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX), GFP_KERNEL);
+	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
+		pgtable_get_gfp_flags(mm, GFP_KERNEL));
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
@@ -159,7 +168,8 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	return (pte_t *)__get_free_page(
+		pgtable_get_gfp_flags(mm, PGALLOC_GFP));
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 8bca7f5..9f416ee 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -350,7 +350,8 @@ static pte_t *get_from_cache(struct mm_struct *mm)
 static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
 {
 	void *ret = NULL;
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
+	struct page *page = alloc_page(pgtable_get_gfp_flags(mm,
+				GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO));
 	if (!page)
 		return NULL;
 	if (!kernel && !pgtable_page_ctor(page)) {
-- 
2.9.3
