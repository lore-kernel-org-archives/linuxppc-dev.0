Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <c3435d0c90ee6aa876593e29661b03eff7f36632.1204270367.git.michael@ellerman.id.au>
In-Reply-To: <fdd3edc0f2f3d2d6cade5cd695b8080d0da95a7f.1204270367.git.michael@ellerman.id.au>
References: <fdd3edc0f2f3d2d6cade5cd695b8080d0da95a7f.1204270367.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 7/8] Allow for different IOMMU page sizes in cell IOMMU code
Date: Fri, 29 Feb 2008 18:33:27 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make some preliminary changes to cell_iommu_alloc_ptab() to allow it to
take the page size as a parameter rather than assuming IOMMU_PAGE_SIZE.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 7a861cb..b0e347e 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -113,7 +113,7 @@
 
 /* IOMMU sizing */
 #define IO_SEGMENT_SHIFT	28
-#define IO_PAGENO_BITS		(IO_SEGMENT_SHIFT - IOMMU_PAGE_SHIFT)
+#define IO_PAGENO_BITS(shift)	(IO_SEGMENT_SHIFT - (shift))
 
 /* The high bit needs to be set on every DMA address */
 #define SPIDER_DMA_OFFSET	0x80000000ul
@@ -328,7 +328,7 @@ static void cell_iommu_setup_stab(struct cbe_iommu *iommu,
 
 static unsigned long *cell_iommu_alloc_ptab(struct cbe_iommu *iommu,
 		unsigned long base, unsigned long size, unsigned long gap_base,
-		unsigned long gap_size)
+		unsigned long gap_size, unsigned long page_shift)
 {
 	struct page *page;
 	int i;
@@ -337,7 +337,10 @@ static unsigned long *cell_iommu_alloc_ptab(struct cbe_iommu *iommu,
 
 	start_seg = base >> IO_SEGMENT_SHIFT;
 	segments  = size >> IO_SEGMENT_SHIFT;
-	pages_per_segment = 1ull << IO_PAGENO_BITS;
+	pages_per_segment = 1ull << IO_PAGENO_BITS(page_shift);
+	/* PTEs for each segment must start on a 4K bounday */
+	pages_per_segment = max(pages_per_segment,
+				(1 << 12) / sizeof(unsigned long));
 
 	ptab_size = segments * pages_per_segment * sizeof(unsigned long);
 	pr_debug("%s: iommu[%d]: ptab_size: %lu, order: %d\n", __FUNCTION__,
@@ -358,13 +361,12 @@ static unsigned long *cell_iommu_alloc_ptab(struct cbe_iommu *iommu,
 	/* initialise the STEs */
 	reg = IOSTE_V | ((n_pte_pages - 1) << 5);
 
-	if (IOMMU_PAGE_SIZE == 0x1000)
-		reg |= IOSTE_PS_4K;
-	else if (IOMMU_PAGE_SIZE == 0x10000)
-		reg |= IOSTE_PS_64K;
-	else {
-		extern void __unknown_page_size_error(void);
-		__unknown_page_size_error();
+	switch (page_shift) {
+	case 12: reg |= IOSTE_PS_4K;  break;
+	case 16: reg |= IOSTE_PS_64K; break;
+	case 20: reg |= IOSTE_PS_1M;  break;
+	case 24: reg |= IOSTE_PS_16M; break;
+	default: BUG();
 	}
 
 	gap_base = gap_base >> IO_SEGMENT_SHIFT;
@@ -429,7 +431,8 @@ static void cell_iommu_setup_hardware(struct cbe_iommu *iommu,
 	unsigned long base, unsigned long size)
 {
 	cell_iommu_setup_stab(iommu, base, size, 0, 0);
-	iommu->ptab = cell_iommu_alloc_ptab(iommu, base, size, 0, 0);
+	iommu->ptab = cell_iommu_alloc_ptab(iommu, base, size, 0, 0,
+					    IOMMU_PAGE_SHIFT);
 	cell_iommu_enable_hardware(iommu);
 }
 
@@ -886,7 +889,8 @@ static void cell_iommu_setup_fixed_ptab(struct cbe_iommu *iommu,
 	int i;
 	unsigned long base_pte, uaddr, *io_pte, *ptab;
 
-	ptab = cell_iommu_alloc_ptab(iommu, fbase, fsize, dbase, dsize);
+	ptab = cell_iommu_alloc_ptab(iommu, fbase, fsize, dbase, dsize,
+				     IOMMU_PAGE_SHIFT);
 
 	dma_iommu_fixed_base = fbase;
 
@@ -1008,7 +1012,8 @@ static int __init cell_iommu_fixed_mapping_init(void)
 			 dbase + dsize, fbase, fbase + fsize);
 
 		cell_iommu_setup_stab(iommu, dbase, dsize, fbase, fsize);
-		iommu->ptab = cell_iommu_alloc_ptab(iommu, dbase, dsize, 0, 0);
+		iommu->ptab = cell_iommu_alloc_ptab(iommu, dbase, dsize, 0, 0,
+						    IOMMU_PAGE_SHIFT);
 		cell_iommu_setup_fixed_ptab(iommu, np, dbase, dsize,
 					     fbase, fsize);
 		cell_iommu_enable_hardware(iommu);
-- 
1.5.2.rc1.1884.g59b20
