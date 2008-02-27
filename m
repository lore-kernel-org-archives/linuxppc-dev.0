Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <eb9d93b1a5e9031dd0e8a436f05a18251e6f57c0.1204097262.git.michael@ellerman.id.au>
In-Reply-To: <4108415683edeb799fd4880a8dba3e9f27a34415.1204097262.git.michael@ellerman.id.au>
References: <4108415683edeb799fd4880a8dba3e9f27a34415.1204097262.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 7/8] Allow for different IOMMU page sizes in cell IOMMU code
Date: Wed, 27 Feb 2008 18:28:19 +1100 (EST)
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
 arch/powerpc/platforms/cell/iommu.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index a7bbc0a..12db681 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -113,7 +113,7 @@
 
 /* IOMMU sizing */
 #define IO_SEGMENT_SHIFT	28
-#define IO_PAGENO_BITS		(IO_SEGMENT_SHIFT - IOMMU_PAGE_SHIFT)
+#define IO_PAGENO_BITS(shift)	(IO_SEGMENT_SHIFT - (shift))
 
 /* The high bit needs to be set on every DMA address */
 #define SPIDER_DMA_OFFSET	0x80000000ul
@@ -327,7 +327,8 @@ static void cell_iommu_setup_stab(struct cbe_iommu *iommu,
 }
 
 static unsigned long *cell_iommu_alloc_ptab(struct cbe_iommu *iommu,
-				  unsigned long base, unsigned long size)
+				  unsigned long base, unsigned long size,
+				  unsigned long page_shift)
 {
 	struct page *page;
 	int i;
@@ -336,7 +337,10 @@ static unsigned long *cell_iommu_alloc_ptab(struct cbe_iommu *iommu,
 
 	start_seg = base >> IO_SEGMENT_SHIFT;
 	segments  = size >> IO_SEGMENT_SHIFT;
-	pages_per_segment = 1ull << IO_PAGENO_BITS;
+	pages_per_segment = 1ull << IO_PAGENO_BITS(page_shift);
+	/* PTEs for each segment must start on a 4K bounday */
+	pages_per_segment = max(pages_per_segment,
+				(1 << 12) / sizeof(unsigned long));
 
 	ptab_size = segments * pages_per_segment * sizeof(unsigned long);
 	pr_debug("%s: iommu[%d]: ptab_size: %lu, order: %d\n", __FUNCTION__,
@@ -357,13 +361,12 @@ static unsigned long *cell_iommu_alloc_ptab(struct cbe_iommu *iommu,
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
 
 	pr_debug("Setting up IOMMU stab:\n");
@@ -421,7 +424,8 @@ static void cell_iommu_setup_hardware(struct cbe_iommu *iommu,
 	unsigned long base, unsigned long size)
 {
 	cell_iommu_setup_stab(iommu, base, size, 0, 0);
-	iommu->ptab = cell_iommu_alloc_ptab(iommu, base, size);
+	iommu->ptab = cell_iommu_alloc_ptab(iommu, base, size,
+					    IOMMU_PAGE_SHIFT);
 	cell_iommu_enable_hardware(iommu);
 }
 
@@ -878,7 +882,7 @@ static void cell_iommu_setup_fixed_ptab(struct cbe_iommu *iommu,
 	int i;
 	unsigned long base_pte, uaddr, *io_pte, *ptab;
 
-	ptab = cell_iommu_alloc_ptab(iommu, fbase, fsize);
+	ptab = cell_iommu_alloc_ptab(iommu, fbase, fsize, IOMMU_PAGE_SHIFT);
 
 	dma_iommu_fixed_base = fbase;
 
-- 
1.5.2.rc1.1884.g59b20
