Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfC6v06GdzDt1x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 18:13:11 +1000 (AEST)
Message-Id: <69b1226ce134761fd7ab81a498bdb85cd737280f.1474441302.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1474441301.git.christophe.leroy@c-s.fr>
References: <cover.1474441301.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 2/3] powerpc: get hugetlbpage handling more generic
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 21 Sep 2016 10:11:54 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today there are two implementations of hugetlbpages which are managed
by exclusive #ifdefs:
* FSL_BOOKE: several directory entries points to the same single hugepage
* BOOK3S: one upper level directory entry points to a table of hugepages

In preparation of implementation of hugepage support on the 8xx, we
need a mix of the two above solutions, because the 8xx needs both cases
depending on the size of pages:
* In 4k page size mode, each PGD entry covers a 4M bytes area. It means
that 2 PGD entries will be necessary to cover an 8M hugepage while a
single PGD entry will cover 8x 512k hugepages.
* In 16 page size mode, each PGD entry covers a 64M bytes area. It means
that 8x 8M hugepages will be covered by one PGD entry and 64x 512k
hugepages will be covers by one PGD entry.

This patch:
* removes #ifdefs in favor of if/else based on the range sizes
* merges the two huge_pte_alloc() functions as they are pretty similar
* merges the two hugetlbpage_init() functions as they are pretty similar

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: This part is new and results from a split of last patch of v1 serie in
two parts

v3:
- Only allocate hugepte_cache on FSL_BOOKE. Not needed on BOOK3S_64
- Removed the BUG in the unused hugepd_free(), made it
static inline {} instead.

 arch/powerpc/mm/hugetlbpage.c | 188 +++++++++++++++++-------------------------
 1 file changed, 76 insertions(+), 112 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index a5d3ecd..a0d049a 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -64,14 +64,16 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 {
 	struct kmem_cache *cachep;
 	pte_t *new;
-
-#ifdef CONFIG_PPC_FSL_BOOK3E
 	int i;
-	int num_hugepd = 1 << (pshift - pdshift);
-	cachep = hugepte_cache;
-#else
-	cachep = PGT_CACHE(pdshift - pshift);
-#endif
+	int num_hugepd;
+
+	if (pshift >= pdshift) {
+		cachep = hugepte_cache;
+		num_hugepd = 1 << (pshift - pdshift);
+	} else {
+		cachep = PGT_CACHE(pdshift - pshift);
+		num_hugepd = 1;
+	}
 
 	new = kmem_cache_zalloc(cachep, GFP_KERNEL);
 
@@ -89,7 +91,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	smp_wmb();
 
 	spin_lock(&mm->page_table_lock);
-#ifdef CONFIG_PPC_FSL_BOOK3E
+
 	/*
 	 * We have multiple higher-level entries that point to the same
 	 * actual pte location.  Fill in each as we go and backtrack on error.
@@ -100,8 +102,13 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 		if (unlikely(!hugepd_none(*hpdp)))
 			break;
 		else
+#ifdef CONFIG_PPC_BOOK3S_64
+			hpdp->pd = __pa(new) |
+				   (shift_to_mmu_psize(pshift) << 2);
+#else
 			/* We use the old format for PPC_FSL_BOOK3E */
 			hpdp->pd = ((unsigned long)new & ~PD_HUGE) | pshift;
+#endif
 	}
 	/* If we bailed from the for loop early, an error occurred, clean up */
 	if (i < num_hugepd) {
@@ -109,17 +116,6 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 			hpdp->pd = 0;
 		kmem_cache_free(cachep, new);
 	}
-#else
-	if (!hugepd_none(*hpdp))
-		kmem_cache_free(cachep, new);
-	else {
-#ifdef CONFIG_PPC_BOOK3S_64
-		hpdp->pd = __pa(new) | (shift_to_mmu_psize(pshift) << 2);
-#else
-		hpdp->pd = ((unsigned long)new & ~PD_HUGE) | pshift;
-#endif
-	}
-#endif
 	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
@@ -136,7 +132,6 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 #define HUGEPD_PUD_SHIFT PMD_SHIFT
 #endif
 
-#ifdef CONFIG_PPC_BOOK3S_64
 /*
  * At this point we do the placement change only for BOOK3S 64. This would
  * possibly work on other subarchs.
@@ -153,6 +148,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 	addr &= ~(sz-1);
 	pg = pgd_offset(mm, addr);
 
+#ifdef CONFIG_PPC_BOOK3S_64
 	if (pshift == PGDIR_SHIFT)
 		/* 16GB huge page */
 		return (pte_t *) pg;
@@ -178,32 +174,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 				hpdp = (hugepd_t *)pm;
 		}
 	}
-	if (!hpdp)
-		return NULL;
-
-	BUG_ON(!hugepd_none(*hpdp) && !hugepd_ok(*hpdp));
-
-	if (hugepd_none(*hpdp) && __hugepte_alloc(mm, hpdp, addr, pdshift, pshift))
-		return NULL;
-
-	return hugepte_offset(*hpdp, addr, pdshift);
-}
-
 #else
-
-pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
-{
-	pgd_t *pg;
-	pud_t *pu;
-	pmd_t *pm;
-	hugepd_t *hpdp = NULL;
-	unsigned pshift = __ffs(sz);
-	unsigned pdshift = PGDIR_SHIFT;
-
-	addr &= ~(sz-1);
-
-	pg = pgd_offset(mm, addr);
-
 	if (pshift >= HUGEPD_PGD_SHIFT) {
 		hpdp = (hugepd_t *)pg;
 	} else {
@@ -217,7 +188,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 			hpdp = (hugepd_t *)pm;
 		}
 	}
-
+#endif
 	if (!hpdp)
 		return NULL;
 
@@ -228,7 +199,6 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 
 	return hugepte_offset(*hpdp, addr, pdshift);
 }
-#endif
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
 /* Build list of addresses of gigantic pages.  This function is used in early
@@ -310,7 +280,11 @@ static int __init do_gpage_early_setup(char *param, char *val,
 				npages = 0;
 			if (npages > MAX_NUMBER_GPAGES) {
 				pr_warn("MMU: %lu pages requested for page "
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
 					"size %llu KB, limiting to "
+#else
+					"size %u KB, limiting to "
+#endif
 					__stringify(MAX_NUMBER_GPAGES) "\n",
 					npages, size / 1024);
 				npages = MAX_NUMBER_GPAGES;
@@ -442,6 +416,8 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
 	}
 	put_cpu_var(hugepd_freelist_cur);
 }
+#else
+static inline void hugepd_free(struct mmu_gather *tlb, void *hugepte) {}
 #endif
 
 static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshift,
@@ -453,13 +429,11 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
 
 	unsigned long pdmask = ~((1UL << pdshift) - 1);
 	unsigned int num_hugepd = 1;
+	unsigned int shift = hugepd_shift(*hpdp);
 
-#ifdef CONFIG_PPC_FSL_BOOK3E
 	/* Note: On fsl the hpdp may be the first of several */
-	num_hugepd = (1 << (hugepd_shift(*hpdp) - pdshift));
-#else
-	unsigned int shift = hugepd_shift(*hpdp);
-#endif
+	if (shift > pdshift)
+		num_hugepd = 1 << (shift - pdshift);
 
 	start &= pdmask;
 	if (start < floor)
@@ -475,11 +449,10 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
 	for (i = 0; i < num_hugepd; i++, hpdp++)
 		hpdp->pd = 0;
 
-#ifdef CONFIG_PPC_FSL_BOOK3E
-	hugepd_free(tlb, hugepte);
-#else
-	pgtable_free_tlb(tlb, hugepte, pdshift - shift);
-#endif
+	if (shift >= pdshift)
+		hugepd_free(tlb, hugepte);
+	else
+		pgtable_free_tlb(tlb, hugepte, pdshift - shift);
 }
 
 static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
@@ -492,6 +465,8 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 
 	start = addr;
 	do {
+		unsigned long more;
+
 		pmd = pmd_offset(pud, addr);
 		next = pmd_addr_end(addr, end);
 		if (!is_hugepd(__hugepd(pmd_val(*pmd)))) {
@@ -502,15 +477,16 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 			WARN_ON(!pmd_none_or_clear_bad(pmd));
 			continue;
 		}
-#ifdef CONFIG_PPC_FSL_BOOK3E
 		/*
 		 * Increment next by the size of the huge mapping since
 		 * there may be more than one entry at this level for a
 		 * single hugepage, but all of them point to
 		 * the same kmem cache that holds the hugepte.
 		 */
-		next = addr + (1 << hugepd_shift(*(hugepd_t *)pmd));
-#endif
+		more = addr + (1 << hugepd_shift(*(hugepd_t *)pmd));
+		if (more > next)
+			next = more;
+
 		free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
 				  addr, next, floor, ceiling);
 	} while (addr = next, addr != end);
@@ -550,15 +526,17 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 			hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
 					       ceiling);
 		} else {
-#ifdef CONFIG_PPC_FSL_BOOK3E
+			unsigned long more;
 			/*
 			 * Increment next by the size of the huge mapping since
 			 * there may be more than one entry at this level for a
 			 * single hugepage, but all of them point to
 			 * the same kmem cache that holds the hugepte.
 			 */
-			next = addr + (1 << hugepd_shift(*(hugepd_t *)pud));
-#endif
+			more = addr + (1 << hugepd_shift(*(hugepd_t *)pud));
+			if (more > next)
+				next = more;
+
 			free_hugepd_range(tlb, (hugepd_t *)pud, PUD_SHIFT,
 					  addr, next, floor, ceiling);
 		}
@@ -615,15 +593,17 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 				continue;
 			hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
 		} else {
-#ifdef CONFIG_PPC_FSL_BOOK3E
+			unsigned long more;
 			/*
 			 * Increment next by the size of the huge mapping since
 			 * there may be more than one entry at the pgd level
 			 * for a single hugepage, but all of them point to the
 			 * same kmem cache that holds the hugepte.
 			 */
-			next = addr + (1 << hugepd_shift(*(hugepd_t *)pgd));
-#endif
+			more = addr + (1 << hugepd_shift(*(hugepd_t *)pgd));
+			if (more > next)
+				next = more;
+
 			free_hugepd_range(tlb, (hugepd_t *)pgd, PGDIR_SHIFT,
 					  addr, next, floor, ceiling);
 		}
@@ -753,12 +733,13 @@ static int __init add_huge_page_size(unsigned long long size)
 
 	/* Check that it is a page size supported by the hardware and
 	 * that it fits within pagetable and slice limits. */
+	if (size <= PAGE_SIZE)
+		return -EINVAL;
 #ifdef CONFIG_PPC_FSL_BOOK3E
-	if ((size < PAGE_SIZE) || !is_power_of_4(size))
+	if (!is_power_of_4(size))
 		return -EINVAL;
 #else
-	if (!is_power_of_2(size)
-	    || (shift > SLICE_HIGH_SHIFT) || (shift <= PAGE_SHIFT))
+	if (!is_power_of_2(size) || (shift > SLICE_HIGH_SHIFT))
 		return -EINVAL;
 #endif
 
@@ -791,53 +772,15 @@ static int __init hugepage_setup_sz(char *str)
 }
 __setup("hugepagesz=", hugepage_setup_sz);
 
-#ifdef CONFIG_PPC_FSL_BOOK3E
 struct kmem_cache *hugepte_cache;
 static int __init hugetlbpage_init(void)
 {
 	int psize;
 
-	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
-		unsigned shift;
-
-		if (!mmu_psize_defs[psize].shift)
-			continue;
-
-		shift = mmu_psize_to_shift(psize);
-
-		/* Don't treat normal page sizes as huge... */
-		if (shift != PAGE_SHIFT)
-			if (add_huge_page_size(1ULL << shift) < 0)
-				continue;
-	}
-
-	/*
-	 * Create a kmem cache for hugeptes.  The bottom bits in the pte have
-	 * size information encoded in them, so align them to allow this
-	 */
-	hugepte_cache =  kmem_cache_create("hugepte-cache", sizeof(pte_t),
-					   HUGEPD_SHIFT_MASK + 1, 0, NULL);
-	if (hugepte_cache == NULL)
-		panic("%s: Unable to create kmem cache for hugeptes\n",
-		      __func__);
-
-	/* Default hpage size = 4M */
-	if (mmu_psize_defs[MMU_PAGE_4M].shift)
-		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_4M].shift;
-	else
-		panic("%s: Unable to set default huge page size\n", __func__);
-
-
-	return 0;
-}
-#else
-static int __init hugetlbpage_init(void)
-{
-	int psize;
-
+#if !defined(CONFIG_PPC_FSL_BOOK3E)
 	if (!radix_enabled() && !mmu_has_feature(MMU_FTR_16M_PAGE))
 		return -ENODEV;
-
+#endif
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 		unsigned shift;
 		unsigned pdshift;
@@ -860,16 +803,34 @@ static int __init hugetlbpage_init(void)
 		 * if we have pdshift and shift value same, we don't
 		 * use pgt cache for hugepd.
 		 */
-		if (pdshift != shift) {
+		if (pdshift > shift) {
 			pgtable_cache_add(pdshift - shift, NULL);
 			if (!PGT_CACHE(pdshift - shift))
 				panic("hugetlbpage_init(): could not create "
 				      "pgtable cache for %d bit pagesize\n", shift);
 		}
+#ifdef CONFIG_PPC_FSL_BOOK3E
+		else if (!hugepte_cache) {
+			/*
+			 * Create a kmem cache for hugeptes.  The bottom bits in
+			 * the pte have size information encoded in them, so
+			 * align them to allow this
+			 */
+			hugepte_cache = kmem_cache_create("hugepte-cache",
+							  sizeof(pte_t),
+							  HUGEPD_SHIFT_MASK + 1,
+							  0, NULL);
+			if (hugepte_cache == NULL)
+				panic("%s: Unable to create kmem cache "
+				      "for hugeptes\n", __func__);
+
+		}
+#endif
 	}
 
 	/* Set default large page size. Currently, we pick 16M or 1M
 	 * depending on what is available
+	 * We select 4M on other ones.
 	 */
 	if (mmu_psize_defs[MMU_PAGE_16M].shift)
 		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_16M].shift;
@@ -877,11 +838,14 @@ static int __init hugetlbpage_init(void)
 		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_1M].shift;
 	else if (mmu_psize_defs[MMU_PAGE_2M].shift)
 		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_2M].shift;
-
+	else if (mmu_psize_defs[MMU_PAGE_4M].shift)
+		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_4M].shift;
+	else
+		panic("%s: Unable to set default huge page size\n", __func__);
 
 	return 0;
 }
-#endif
+
 arch_initcall(hugetlbpage_init);
 
 void flush_dcache_icache_hugepage(struct page *page)
-- 
2.1.0
