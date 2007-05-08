Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 08 May 2007 16:27:30 +1000
Subject: [PATCH 5/5] powerpc: Don't use SLAB/SLUB for PTE pages
In-Reply-To: <1178605646.637780.625211974455.qpush@grosgo>
Message-Id: <20070508062750.A5CBBDDE42@ozlabs.org>
Cc: Hugh Dickins <hugh@veritas.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Hugh Dickins <hugh@veritas.com>

The SLUB allocator relies on struct page fields first_page and slab,
overwritten by ptl when SPLIT_PTLOCK: so the SLUB allocator cannot then
be used for the lowest level of pagetable pages.  This was obstructing
SLUB on PowerPC, which uses kmem_caches for its pagetables.  So convert
its pte level to use normal gfp pages (whereas pmd, pud and 64k-page pgd
want partpages, so continue to use kmem_caches for pmd, pud and pgd).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/mm/init_64.c     |   17 ++++++-----------
 include/asm-powerpc/pgalloc.h |   34 ++++++++++++++++------------------
 2 files changed, 22 insertions(+), 29 deletions(-)

Index: linux-cell/arch/powerpc/mm/init_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/init_64.c	2007-05-08 11:46:50.000000000 +1000
+++ linux-cell/arch/powerpc/mm/init_64.c	2007-05-08 15:45:46.000000000 +1000
@@ -146,21 +146,16 @@ static void zero_ctor(void *addr, struct
 	memset(addr, 0, kmem_cache_size(cache));
 }
 
-#ifdef CONFIG_PPC_64K_PAGES
-static const unsigned int pgtable_cache_size[3] = {
-	PTE_TABLE_SIZE, PMD_TABLE_SIZE, PGD_TABLE_SIZE
-};
-static const char *pgtable_cache_name[ARRAY_SIZE(pgtable_cache_size)] = {
-	"pte_pmd_cache", "pmd_cache", "pgd_cache",
-};
-#else
 static const unsigned int pgtable_cache_size[2] = {
-	PTE_TABLE_SIZE, PMD_TABLE_SIZE
+	PGD_TABLE_SIZE, PMD_TABLE_SIZE
 };
 static const char *pgtable_cache_name[ARRAY_SIZE(pgtable_cache_size)] = {
-	"pgd_pte_cache", "pud_pmd_cache",
-};
+#ifdef CONFIG_PPC_64K_PAGES
+	"pgd_cache", "pmd_cache",
+#else
+	"pgd_cache", "pud_pmd_cache",
 #endif /* CONFIG_PPC_64K_PAGES */
+};
 
 #ifdef CONFIG_HUGETLB_PAGE
 /* Hugepages need one extra cache, initialized in hugetlbpage.c.  We
Index: linux-cell/include/asm-powerpc/pgalloc.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/pgalloc.h	2007-04-27 14:13:24.000000000 +1000
+++ linux-cell/include/asm-powerpc/pgalloc.h	2007-05-08 16:01:00.000000000 +1000
@@ -13,18 +13,11 @@
 
 extern struct kmem_cache *pgtable_cache[];
 
-#ifdef CONFIG_PPC_64K_PAGES
-#define PTE_CACHE_NUM	0
-#define PMD_CACHE_NUM	1
-#define PGD_CACHE_NUM	2
-#define HUGEPTE_CACHE_NUM 3
-#else
-#define PTE_CACHE_NUM	0
-#define PMD_CACHE_NUM	1
-#define PUD_CACHE_NUM	1
-#define PGD_CACHE_NUM	0
-#define HUGEPTE_CACHE_NUM 2
-#endif
+#define PGD_CACHE_NUM		0
+#define PUD_CACHE_NUM		1
+#define PMD_CACHE_NUM		1
+#define HUGEPTE_CACHE_NUM	2
+#define PTE_NONCACHE_NUM	3  /* from GFP rather than kmem_cache */
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -97,8 +90,10 @@ static inline void pmd_free(pmd_t *pmd)
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
-	return kmem_cache_alloc(pgtable_cache[PTE_CACHE_NUM],
-				GFP_KERNEL|__GFP_REPEAT);
+	pte_t *ptepage = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_REPEAT);
+	if (ptepage)
+		clear_page(ptepage);
+	return ptepage;
 }
 
 static inline struct page *pte_alloc_one(struct mm_struct *mm,
@@ -109,12 +104,12 @@ static inline struct page *pte_alloc_one
 		
 static inline void pte_free_kernel(pte_t *pte)
 {
-	kmem_cache_free(pgtable_cache[PTE_CACHE_NUM], pte);
+	free_page((unsigned long)pte);
 }
 
 static inline void pte_free(struct page *ptepage)
 {
-	pte_free_kernel(page_address(ptepage));
+	__free_page(ptepage);
 }
 
 #define PGF_CACHENUM_MASK	0x3
@@ -136,14 +131,17 @@ static inline void pgtable_free(pgtable_
 	void *p = (void *)(pgf.val & ~PGF_CACHENUM_MASK);
 	int cachenum = pgf.val & PGF_CACHENUM_MASK;
 
-	kmem_cache_free(pgtable_cache[cachenum], p);
+	if (cachenum == PTE_NONCACHE_NUM)
+		free_page((unsigned long)p);
+	else
+		kmem_cache_free(pgtable_cache[cachenum], p);
 }
 
 extern void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf);
 
 #define __pte_free_tlb(tlb, ptepage)	\
 	pgtable_free_tlb(tlb, pgtable_free_cache(page_address(ptepage), \
-		PTE_CACHE_NUM, PTE_TABLE_SIZE-1))
+		PTE_NONCACHE_NUM, PTE_TABLE_SIZE-1))
 #define __pmd_free_tlb(tlb, pmd) 	\
 	pgtable_free_tlb(tlb, pgtable_free_cache(pmd, \
 		PMD_CACHE_NUM, PMD_TABLE_SIZE-1))
