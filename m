Return-Path: <dgibson@ozlabs.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [4/5] Cleanup initialization of hugepages on powerpc
In-Reply-To: <20090928043902.GA6302@yookeroo.seuss>
Message-Id: <20090928044114.D6C28B7BEB@ozlabs.org>
Date: Mon, 28 Sep 2009 14:41:14 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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

Signed-off-by: David Gibson <dwg@au1.ibm.com>

---
 arch/powerpc/mm/hugetlbpage.c |  106 +++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 57 deletions(-)

Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2009-09-28 13:53:42.000000000 +1000
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2009-09-28 14:02:34.000000000 +1000
@@ -37,11 +37,6 @@
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
@@ -502,8 +497,6 @@ unsigned long hugetlb_get_unmapped_area(
 	struct hstate *hstate = hstate_file(file);
 	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));
 
-	if (!mmu_huge_psizes[mmu_psize])
-		return -EINVAL;
 	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1, 0);
 }
 
@@ -666,47 +659,46 @@ repeat:
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
@@ -720,31 +712,31 @@ static int __init hugetlbpage_init(void)
 	if (!cpu_has_feature(CPU_FTR_16M_PAGE))
 		return -ENODEV;
 
-	/* Add supported huge page sizes.  Need to change HUGE_MAX_HSTATE
-	 * and adjust PTE_NONCACHE_NUM if the number of supported huge page
-	 * sizes changes.
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
 
 	return 0;
 }
-
 module_init(hugetlbpage_init);
