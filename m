Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <00fc3c7fa11fee891d280a0e8b66ac8b89d7cef6.1204270367.git.michael@ellerman.id.au>
In-Reply-To: <fdd3edc0f2f3d2d6cade5cd695b8080d0da95a7f.1204270367.git.michael@ellerman.id.au>
References: <fdd3edc0f2f3d2d6cade5cd695b8080d0da95a7f.1204270367.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/8] Split setup of IOMMU stab and ptab,
	allocate dynamic/fixed ptabs separately
Date: Fri, 29 Feb 2008 18:33:25 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently the cell IOMMU code allocates the entire IOMMU page table in a
contiguous chunk. This is nice and tidy, but for machines with larger
amounts of RAM the page table allocation can fail due to it simply being
too large.

So split the segment table and page table setup routine, and arrange to
have the dynamic and fixed page tables allocated separately.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |   69 ++++++++++++++++++++++-------------
 1 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 8e57e1a..187a723 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -306,50 +306,54 @@ static int cell_iommu_find_ioc(int nid, unsigned long *base)
 	return -ENODEV;
 }
 
-static void cell_iommu_setup_page_tables(struct cbe_iommu *iommu,
+static void cell_iommu_setup_stab(struct cbe_iommu *iommu,
 				unsigned long dbase, unsigned long dsize,
 				unsigned long fbase, unsigned long fsize)
 {
 	struct page *page;
-	int i;
-	unsigned long reg, segments, pages_per_segment, ptab_size, stab_size,
-		      n_pte_pages, base;
-
-	base = dbase;
-	if (fsize != 0)
-		base = min(fbase, dbase);
+	unsigned long segments, stab_size;
 
 	segments = max(dbase + dsize, fbase + fsize) >> IO_SEGMENT_SHIFT;
-	pages_per_segment = 1ull << IO_PAGENO_BITS;
 
-	pr_debug("%s: iommu[%d]: segments: %lu, pages per segment: %lu\n",
-			__FUNCTION__, iommu->nid, segments, pages_per_segment);
+	pr_debug("%s: iommu[%d]: segments: %lu\n",
+			__FUNCTION__, iommu->nid, segments);
 
 	/* set up the segment table */
 	stab_size = segments * sizeof(unsigned long);
 	page = alloc_pages_node(iommu->nid, GFP_KERNEL, get_order(stab_size));
 	BUG_ON(!page);
 	iommu->stab = page_address(page);
-	clear_page(iommu->stab);
+	memset(iommu->stab, 0, stab_size);
+}
+
+static unsigned long *cell_iommu_alloc_ptab(struct cbe_iommu *iommu,
+		unsigned long base, unsigned long size, unsigned long gap_base,
+		unsigned long gap_size)
+{
+	struct page *page;
+	int i;
+	unsigned long reg, segments, pages_per_segment, ptab_size,
+		      n_pte_pages, start_seg, *ptab;
+
+	start_seg = base >> IO_SEGMENT_SHIFT;
+	segments  = size >> IO_SEGMENT_SHIFT;
+	pages_per_segment = 1ull << IO_PAGENO_BITS;
 
-	/* ... and the page tables. Since these are contiguous, we can treat
-	 * the page tables as one array of ptes, like pSeries does.
-	 */
 	ptab_size = segments * pages_per_segment * sizeof(unsigned long);
 	pr_debug("%s: iommu[%d]: ptab_size: %lu, order: %d\n", __FUNCTION__,
 			iommu->nid, ptab_size, get_order(ptab_size));
 	page = alloc_pages_node(iommu->nid, GFP_KERNEL, get_order(ptab_size));
 	BUG_ON(!page);
 
-	iommu->ptab = page_address(page);
-	memset(iommu->ptab, 0, ptab_size);
+	ptab = page_address(page);
+	memset(ptab, 0, ptab_size);
 
 	/* number of pages needed for a page table */
 	n_pte_pages = (pages_per_segment *
 		       sizeof(unsigned long)) >> IOMMU_PAGE_SHIFT;
 
 	pr_debug("%s: iommu[%d]: stab at %p, ptab at %p, n_pte_pages: %lu\n",
-			__FUNCTION__, iommu->nid, iommu->stab, iommu->ptab,
+			__FUNCTION__, iommu->nid, iommu->stab, ptab,
 			n_pte_pages);
 
 	/* initialise the STEs */
@@ -364,12 +368,21 @@ static void cell_iommu_setup_page_tables(struct cbe_iommu *iommu,
 		__unknown_page_size_error();
 	}
 
+	gap_base = gap_base >> IO_SEGMENT_SHIFT;
+	gap_size = gap_size >> IO_SEGMENT_SHIFT;
+
 	pr_debug("Setting up IOMMU stab:\n");
-	for (i = base >> IO_SEGMENT_SHIFT; i < segments; i++) {
-		iommu->stab[i] = reg |
-			(__pa(iommu->ptab) + n_pte_pages * IOMMU_PAGE_SIZE * i);
+	for (i = start_seg; i < (start_seg + segments); i++) {
+		if (i >= gap_base && i < (gap_base + gap_size)) {
+			pr_debug("\toverlap at %d, skipping\n", i);
+			continue;
+		}
+		iommu->stab[i] = reg | (__pa(ptab) + n_pte_pages *
+					IOMMU_PAGE_SIZE * (i - start_seg));
 		pr_debug("\t[%d] 0x%016lx\n", i, iommu->stab[i]);
 	}
+
+	return ptab;
 }
 
 static void cell_iommu_enable_hardware(struct cbe_iommu *iommu)
@@ -416,7 +429,8 @@ static void cell_iommu_enable_hardware(struct cbe_iommu *iommu)
 static void cell_iommu_setup_hardware(struct cbe_iommu *iommu,
 	unsigned long base, unsigned long size)
 {
-	cell_iommu_setup_page_tables(iommu, base, size, 0, 0);
+	cell_iommu_setup_stab(iommu, base, size, 0, 0);
+	iommu->ptab = cell_iommu_alloc_ptab(iommu, base, size, 0, 0);
 	cell_iommu_enable_hardware(iommu);
 }
 
@@ -870,8 +884,10 @@ static void cell_iommu_setup_fixed_ptab(struct cbe_iommu *iommu,
 	struct device_node *np, unsigned long dbase, unsigned long dsize,
 	unsigned long fbase, unsigned long fsize)
 {
-	unsigned long base_pte, uaddr, *io_pte;
 	int i;
+	unsigned long base_pte, uaddr, *io_pte, *ptab;
+
+	ptab = cell_iommu_alloc_ptab(iommu, fbase, fsize, dbase, dsize);
 
 	dma_iommu_fixed_base = fbase;
 
@@ -883,7 +899,7 @@ static void cell_iommu_setup_fixed_ptab(struct cbe_iommu *iommu,
 
 	pr_debug("iommu: mapping 0x%lx pages from 0x%lx\n", fsize, fbase);
 
-	io_pte = iommu->ptab;
+	io_pte = ptab;
 	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M | IOPTE_SO_RW
 		    | (cell_iommu_get_ioid(np) & IOPTE_IOID_Mask);
 
@@ -894,7 +910,7 @@ static void cell_iommu_setup_fixed_ptab(struct cbe_iommu *iommu,
 			pr_debug("iommu: fixed/dynamic overlap, skipping\n");
 			continue;
 		}
-		io_pte[i] = base_pte | (__pa(uaddr) & IOPTE_RPN_Mask);
+		io_pte[i - fbase] = base_pte | (__pa(uaddr) & IOPTE_RPN_Mask);
 	}
 
 	mb();
@@ -992,7 +1008,8 @@ static int __init cell_iommu_fixed_mapping_init(void)
 			"fixed window 0x%lx-0x%lx\n", iommu->nid, dbase,
 			 dbase + dsize, fbase, fbase + fsize);
 
-		cell_iommu_setup_page_tables(iommu, dbase, dsize, fbase, fsize);
+		cell_iommu_setup_stab(iommu, dbase, dsize, fbase, fsize);
+		iommu->ptab = cell_iommu_alloc_ptab(iommu, dbase, dsize, 0, 0);
 		cell_iommu_setup_fixed_ptab(iommu, np, dbase, dsize,
 					     fbase, fsize);
 		cell_iommu_enable_hardware(iommu);
-- 
1.5.2.rc1.1884.g59b20
