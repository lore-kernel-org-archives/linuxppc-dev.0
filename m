Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wH8g95DcWzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 15:17:25 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id o68so11507813pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 May 2017 22:17:25 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: vdavydov.dev@gmail.com,
	mpe@ellerman.id.au,
	oss@buserror.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v3 1/3] powerpc/mm/book(e)(3s)/64: Add page table accounting
Date: Tue,  2 May 2017 15:17:04 +1000
Message-Id: <20170502051706.19043-2-bsingharora@gmail.com>
In-Reply-To: <20170502051706.19043-1-bsingharora@gmail.com>
References: <20170502051706.19043-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce a helper pgtable_gfp_flags() which
just returns the current gfp flags and adds
__GFP_ACCOUNT to account for page table allocation.
The generic helper is added to include/asm/pgalloc.h
and has two variants - WARNING ugly bits ahead

1. If the header is included from a module, no check
for mm == &init_mm is done, since init_mm is not
exported
2. For kernel includes, the check is done and required
see (3e79ec7 arch: x86: charge page tables to kmemcg)

The fundamental assumption is that no module should be
doing pgd/pud/pmd and pte alloc's on behalf of init_mm
directly.

NOTE: This adds an overhead to pmd/pud/pgd allocations
similar to x86.  The other alternative was to implement
pmd_alloc_kernel/pud_alloc_kernel and pgd_alloc_kernel
with their offset variants.

For 4k page size, pte_alloc_one no longer calls
pte_alloc_one_kernel.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h |  3 ++-
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 16 ++++++++++------
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 11 +++++++----
 arch/powerpc/include/asm/pgalloc.h           | 14 ++++++++++++++
 arch/powerpc/mm/pgtable_64.c                 | 20 ++++++++++++++------
 5 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index d310546..a120e7f 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -31,7 +31,8 @@ extern struct kmem_cache *pgtable_cache[];
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE), GFP_KERNEL);
+	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+			pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index cd5e7aa..20b1485 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -53,10 +53,11 @@ extern void __tlb_remove_table(void *_table);
 static inline pgd_t *radix__pgd_alloc(struct mm_struct *mm)
 {
 #ifdef CONFIG_PPC_64K_PAGES
-	return (pgd_t *)__get_free_page(PGALLOC_GFP);
+	return (pgd_t *)__get_free_page(pgtable_gfp_flags(mm, PGALLOC_GFP));
 #else
 	struct page *page;
-	page = alloc_pages(PGALLOC_GFP | __GFP_REPEAT, 4);
+	page = alloc_pages(pgtable_gfp_flags(mm, PGALLOC_GFP | __GFP_REPEAT),
+				4);
 	if (!page)
 		return NULL;
 	return (pgd_t *) page_address(page);
@@ -76,7 +77,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	if (radix_enabled())
 		return radix__pgd_alloc(mm);
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE), GFP_KERNEL);
+	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+		pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
@@ -93,7 +95,8 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE), GFP_KERNEL);
+	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE),
+		pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
@@ -119,7 +122,8 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX), GFP_KERNEL);
+	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
+		pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
@@ -168,7 +172,7 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 	struct page *page;
 	pte_t *pte;
 
-	pte = pte_alloc_one_kernel(mm, address);
+	pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT);
 	if (!pte)
 		return NULL;
 	page = virt_to_page(pte);
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 897d2e1..9721c78 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -43,7 +43,8 @@ extern struct kmem_cache *pgtable_cache[];
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE), GFP_KERNEL);
+	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+			pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
@@ -57,7 +58,8 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE), GFP_KERNEL);
+	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE),
+			pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
@@ -96,7 +98,7 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 	struct page *page;
 	pte_t *pte;
 
-	pte = pte_alloc_one_kernel(mm, address);
+	pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT);
 	if (!pte)
 		return NULL;
 	page = virt_to_page(pte);
@@ -189,7 +191,8 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX), GFP_KERNEL);
+	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
+			pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index 0413457..d795c5d 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -3,6 +3,20 @@
 
 #include <linux/mm.h>
 
+#ifndef MODULE
+static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm, gfp_t gfp)
+{
+	if (unlikely(mm == &init_mm))
+		return gfp;
+	return gfp | __GFP_ACCOUNT;
+}
+#else /* !MODULE */
+static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm, gfp_t gfp)
+{
+	return gfp | __GFP_ACCOUNT;
+}
+#endif /* MODULE */
+
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/book3s/pgalloc.h>
 #else
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index db93cf7..8d2d674 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -351,12 +351,20 @@ static pte_t *get_from_cache(struct mm_struct *mm)
 static pte_t *__alloc_for_cache(struct mm_struct *mm, int kernel)
 {
 	void *ret = NULL;
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
-	if (!page)
-		return NULL;
-	if (!kernel && !pgtable_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
+	struct page *page;
+
+	if (!kernel) {
+		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
+		if (!page)
+			return NULL;
+		if (!pgtable_page_ctor(page)) {
+			__free_page(page);
+			return NULL;
+		}
+	} else {
+		page = alloc_page(PGALLOC_GFP);
+		if (!page)
+			return NULL;
 	}
 
 	ret = page_address(page);
-- 
2.9.3
