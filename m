Return-Path: <dgibson@ozlabs.org>
Date: Fri, 30 Oct 2009 16:29:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [4/6] Cleanup initialization of hugepages on powerpc
Message-ID: <20091030052932.GA4170@yookeroo.seuss>
References: <20091027052258.GD20694@yookeroo.seuss>
	<20091027052431.B9CF4B7C07@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091027052431.B9CF4B7C07@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch got apply-broken by the fixes to the earlier patch in the
series.  Here's the fixed version.

Cleanup initialization of hugepages on powerpc

This patch simplifies the logic used to initialize hugepages on
powerpc.  The somewhat oddly named set_huge_psize() is renamed to
add_huge_page_size() and now does all necessary verification of
whether it's given a valid hugepage sizes (instead of just some) and
instantiates the generic hstate structure (but no more).  

hugetlbpage_init() now steps through the available pagesizes, checks
if they're valid for hugepages by calling add_huge_page_size() and
initializes the kmem_caches for the hugepage pagetables.  This means
we can now eliminate the mmu_huge_psizes array, since we no longer
need to pass the sizing information for the pagetable caches from
set_huge_psize() into hugetlbpage_init()

Determination of the default huge page size is also moved from the
hash code into the general hugepage code.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2009-10-30 16:16:20.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2009-10-30 16:19:32.000000000 +1100
@@ -37,27 +37,17 @@
 static unsigned long gpage_freearray[MAX_NUMBER_GPAGES];
 static unsigned nr_gpages;
 
-/* Array of valid huge page sizes - non-zero value(hugepte_shift) is
- * stored for the huge page sizes that are valid.
- */
-static unsigned int mmu_huge_psizes[MMU_PAGE_COUNT] = { }; /* initialize all to 0 */
-
 /* Flag to mark huge PD pointers.  This means pmd_bad() and pud_bad()
  * will choke on pointers to hugepte tables, which is handy for
  * catching screwups early. */
 
 static inline int shift_to_mmu_psize(unsigned int shift)
 {
-	switch (shift) {
-#ifndef CONFIG_PPC_64K_PAGES
-	case PAGE_SHIFT_64K:
-	    return MMU_PAGE_64K;
-#endif
-	case PAGE_SHIFT_16M:
-	    return MMU_PAGE_16M;
-	case PAGE_SHIFT_16G:
-	    return MMU_PAGE_16G;
-	}
+	int psize;
+
+	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize)
+		if (mmu_psize_defs[psize].shift == shift)
+			return psize;
 	return -1;
 }
 
@@ -502,8 +492,6 @@ unsigned long hugetlb_get_unmapped_area(
 	struct hstate *hstate = hstate_file(file);
 	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));
 
-	if (!mmu_huge_psizes[mmu_psize])
-		return -EINVAL;
 	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1, 0);
 }
 
@@ -666,47 +654,46 @@ repeat:
 	return err;
 }
 
-static void __init set_huge_psize(int psize)
+static int __init add_huge_page_size(unsigned long long size)
 {
-	unsigned pdshift;
+	int shift = __ffs(size);
+	int mmu_psize;
 
 	/* Check that it is a page size supported by the hardware and
-	 * that it fits within pagetable limits. */
-	if (mmu_psize_defs[psize].shift &&
-		mmu_psize_defs[psize].shift < SID_SHIFT_1T &&
-		(mmu_psize_defs[psize].shift > MIN_HUGEPTE_SHIFT ||
-		 mmu_psize_defs[psize].shift == PAGE_SHIFT_64K ||
-		 mmu_psize_defs[psize].shift == PAGE_SHIFT_16G)) {
-		/* Return if huge page size has already been setup or is the
-		 * same as the base page size. */
-		if (mmu_huge_psizes[psize] ||
-		   mmu_psize_defs[psize].shift == PAGE_SHIFT)
-			return;
-		hugetlb_add_hstate(mmu_psize_defs[psize].shift - PAGE_SHIFT);
+	 * that it fits within pagetable and slice limits. */
+	if (!is_power_of_2(size)
+	    || (shift > SLICE_HIGH_SHIFT) || (shift <= PAGE_SHIFT))
+		return -EINVAL;
 
-		if (mmu_psize_defs[psize].shift < PMD_SHIFT)
-			pdshift = PMD_SHIFT;
-		else if (mmu_psize_defs[psize].shift < PUD_SHIFT)
-			pdshift = PUD_SHIFT;
-		else
-			pdshift = PGDIR_SHIFT;
-		mmu_huge_psizes[psize] = pdshift - mmu_psize_defs[psize].shift;
-	}
+	if ((mmu_psize = shift_to_mmu_psize(shift)) < 0)
+		return -EINVAL;
+
+#ifdef CONFIG_SPU_FS_64K_LS
+	/* Disable support for 64K huge pages when 64K SPU local store
+	 * support is enabled as the current implementation conflicts.
+	 */
+	if (shift == PAGE_SHIFT_64K)
+		return -EINVAL;
+#endif /* CONFIG_SPU_FS_64K_LS */
+
+	BUG_ON(mmu_psize_defs[mmu_psize].shift != shift);
+
+	/* Return if huge page size has already been setup */
+	if (size_to_hstate(size))
+		return 0;
+
+	hugetlb_add_hstate(shift - PAGE_SHIFT);
+
+	return 0;
 }
 
 static int __init hugepage_setup_sz(char *str)
 {
 	unsigned long long size;
-	int mmu_psize;
-	int shift;
 
 	size = memparse(str, &str);
 
-	shift = __ffs(size);
-	mmu_psize = shift_to_mmu_psize(shift);
-	if (mmu_psize >= 0 && mmu_psize_defs[mmu_psize].shift)
-		set_huge_psize(mmu_psize);
-	else
+	if (add_huge_page_size(size) != 0)
 		printk(KERN_WARNING "Invalid huge page size specified(%llu)\n", size);
 
 	return 1;
@@ -720,30 +707,39 @@ static int __init hugetlbpage_init(void)
 	if (!cpu_has_feature(CPU_FTR_16M_PAGE))
 		return -ENODEV;
 
-	/* Add supported huge page sizes.  Need to change
-	 *  HUGE_MAX_HSTATE if the number of supported huge page sizes
-	 *  changes.
-	 */
-	set_huge_psize(MMU_PAGE_16M);
-	set_huge_psize(MMU_PAGE_16G);
+	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
+		unsigned shift;
+		unsigned pdshift;
 
-	/* Temporarily disable support for 64K huge pages when 64K SPU local
-	 * store support is enabled as the current implementation conflicts.
-	 */
-#ifndef CONFIG_SPU_FS_64K_LS
-	set_huge_psize(MMU_PAGE_64K);
-#endif
+		if (!mmu_psize_defs[psize].shift)
+			continue;
 
-	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
-		if (mmu_huge_psizes[psize]) {
-			pgtable_cache_add(mmu_huge_psizes[psize], NULL);
-			if (!PGT_CACHE(mmu_huge_psizes[psize]))
-				panic("hugetlbpage_init(): could not create "
-				      "pgtable cache for %d bit pagesize\n",
-				      mmu_psize_to_shift(psize));
-		}
+		shift = mmu_psize_to_shift(psize);
+
+		if (add_huge_page_size(1ULL << shift) < 0)
+			continue;
+
+		if (shift < PMD_SHIFT)
+			pdshift = PMD_SHIFT;
+		else if (shift < PUD_SHIFT)
+			pdshift = PUD_SHIFT;
+		else
+			pdshift = PGDIR_SHIFT;
+
+		pgtable_cache_add(pdshift - shift, NULL);
+		if (!PGT_CACHE(pdshift - shift))
+			panic("hugetlbpage_init(): could not create "
+			      "pgtable cache for %d bit pagesize\n", shift);
 	}
 
+	/* Set default large page size. Currently, we pick 16M or 1M
+	 * depending on what is available
+	 */
+	if (mmu_psize_defs[MMU_PAGE_16M].shift)
+		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_16M].shift;
+	else if (mmu_psize_defs[MMU_PAGE_1M].shift)
+		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_1M].shift;
+
 	return 0;
 }
 
Index: working-2.6/arch/powerpc/include/asm/page_64.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/page_64.h	2009-08-14 16:07:54.000000000 +1000
+++ working-2.6/arch/powerpc/include/asm/page_64.h	2009-10-30 16:16:30.000000000 +1100
@@ -90,7 +90,7 @@ extern unsigned int HPAGE_SHIFT;
 #define HPAGE_SIZE		((1UL) << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
-#define HUGE_MAX_HSTATE		3
+#define HUGE_MAX_HSTATE		(MMU_PAGE_COUNT-1)
 
 #endif /* __ASSEMBLY__ */
 
Index: working-2.6/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hash_utils_64.c	2009-10-30 16:16:20.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hash_utils_64.c	2009-10-30 16:16:30.000000000 +1100
@@ -481,16 +481,6 @@ static void __init htab_init_page_sizes(
 #ifdef CONFIG_HUGETLB_PAGE
 	/* Reserve 16G huge page memory sections for huge pages */
 	of_scan_flat_dt(htab_dt_scan_hugepage_blocks, NULL);
-
-/* Set default large page size. Currently, we pick 16M or 1M depending
-	 * on what is available
-	 */
-	if (mmu_psize_defs[MMU_PAGE_16M].shift)
-		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_16M].shift;
-	/* With 4k/4level pagetables, we can't (for now) cope with a
-	 * huge page size < PMD_SIZE */
-	else if (mmu_psize_defs[MMU_PAGE_1M].shift)
-		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_1M].shift;
 #endif /* CONFIG_HUGETLB_PAGE */
 }
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
