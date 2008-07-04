Return-Path: <arnd@arndb.de>
Message-Id: <20080704190806.565636992@arndb.de>
References: <20080704190535.316377278@arndb.de>
Date: Fri, 04 Jul 2008 21:05:43 +0200
From: arnd@arndb.de
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 08/11] powerpc/dma: use the struct dma_attrs in iommu code
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update iommu_alloc() to take the struct dma_attrs and pass them on to
tce_build(). This change propagates down to the tce_build functions of
all the platforms.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/iommu.c            |   13 ++++++++-----
 arch/powerpc/platforms/cell/iommu.c    |    5 +++--
 arch/powerpc/platforms/iseries/iommu.c |    3 ++-
 arch/powerpc/platforms/pasemi/iommu.c  |    3 ++-
 arch/powerpc/platforms/pseries/iommu.c |   14 +++++++++-----
 arch/powerpc/sysdev/dart_iommu.c       |    3 ++-
 include/asm-powerpc/machdep.h          |    3 ++-
 7 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 8c68ee9..2385f68 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -186,7 +186,8 @@ static unsigned long iommu_range_alloc(struct device *dev,
 static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 			      void *page, unsigned int npages,
 			      enum dma_data_direction direction,
-			      unsigned long mask, unsigned int align_order)
+			      unsigned long mask, unsigned int align_order,
+			      struct dma_attrs *attrs)
 {
 	unsigned long entry, flags;
 	dma_addr_t ret = DMA_ERROR_CODE;
@@ -205,7 +206,7 @@ static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 
 	/* Put the TCEs in the HW table */
 	ppc_md.tce_build(tbl, entry, npages, (unsigned long)page & IOMMU_PAGE_MASK,
-			 direction);
+			 direction, attrs);
 
 
 	/* Flush/invalidate TLB caches if necessary */
@@ -336,7 +337,8 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 			    npages, entry, dma_addr);
 
 		/* Insert into HW table */
-		ppc_md.tce_build(tbl, entry, npages, vaddr & IOMMU_PAGE_MASK, direction);
+		ppc_md.tce_build(tbl, entry, npages, vaddr & IOMMU_PAGE_MASK,
+				 direction, attrs);
 
 		/* If we are in an open segment, try merging */
 		if (segstart != s) {
@@ -573,7 +575,8 @@ dma_addr_t iommu_map_single(struct device *dev, struct iommu_table *tbl,
 			align = PAGE_SHIFT - IOMMU_PAGE_SHIFT;
 
 		dma_handle = iommu_alloc(dev, tbl, vaddr, npages, direction,
-					 mask >> IOMMU_PAGE_SHIFT, align);
+					 mask >> IOMMU_PAGE_SHIFT, align,
+					 attrs);
 		if (dma_handle == DMA_ERROR_CODE) {
 			if (printk_ratelimit())  {
 				printk(KERN_INFO "iommu_alloc failed, "
@@ -642,7 +645,7 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 	nio_pages = size >> IOMMU_PAGE_SHIFT;
 	io_order = get_iommu_order(size);
 	mapping = iommu_alloc(dev, tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
-			      mask >> IOMMU_PAGE_SHIFT, io_order);
+			      mask >> IOMMU_PAGE_SHIFT, io_order, NULL);
 	if (mapping == DMA_ERROR_CODE) {
 		free_pages((unsigned long)ret, order);
 		return NULL;
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 45646b2..b4fe598 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -173,7 +173,8 @@ static void invalidate_tce_cache(struct cbe_iommu *iommu, unsigned long *pte,
 }
 
 static void tce_build_cell(struct iommu_table *tbl, long index, long npages,
-		unsigned long uaddr, enum dma_data_direction direction)
+		unsigned long uaddr, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
 	int i;
 	unsigned long *io_pte, base_pte;
@@ -519,7 +520,7 @@ cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
 
 	__set_bit(0, window->table.it_map);
 	tce_build_cell(&window->table, window->table.it_offset, 1,
-		       (unsigned long)iommu->pad_page, DMA_TO_DEVICE);
+		       (unsigned long)iommu->pad_page, DMA_TO_DEVICE, NULL);
 	window->table.it_hint = window->table.it_blocksize;
 
 	return window;
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index ab5d868..bc818e4 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -42,7 +42,8 @@
 #include <asm/iseries/iommu.h>
 
 static void tce_build_iSeries(struct iommu_table *tbl, long index, long npages,
-		unsigned long uaddr, enum dma_data_direction direction)
+		unsigned long uaddr, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
 	u64 rc;
 	u64 tce, rpn;
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 86967bd..70541b7 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -85,7 +85,8 @@ static int iommu_table_iobmap_inited;
 
 static void iobmap_build(struct iommu_table *tbl, long index,
 			 long npages, unsigned long uaddr,
-			 enum dma_data_direction direction)
+			 enum dma_data_direction direction,
+			 struct dma_attrs *attrs)
 {
 	u32 *ip;
 	u32 rpn;
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 9a12908..5377dd4 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -50,7 +50,8 @@
 
 static void tce_build_pSeries(struct iommu_table *tbl, long index,
 			      long npages, unsigned long uaddr,
-			      enum dma_data_direction direction)
+			      enum dma_data_direction direction,
+			      struct dma_attrs *attrs)
 {
 	u64 proto_tce;
 	u64 *tcep;
@@ -95,7 +96,8 @@ static unsigned long tce_get_pseries(struct iommu_table *tbl, long index)
 
 static void tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				long npages, unsigned long uaddr,
-				enum dma_data_direction direction)
+				enum dma_data_direction direction,
+				struct dma_attrs *attrs)
 {
 	u64 rc;
 	u64 proto_tce, tce;
@@ -127,7 +129,8 @@ static DEFINE_PER_CPU(u64 *, tce_page) = NULL;
 
 static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
-				     enum dma_data_direction direction)
+				     enum dma_data_direction direction,
+				     struct dma_attrs *attrs)
 {
 	u64 rc;
 	u64 proto_tce;
@@ -136,7 +139,8 @@ static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	long l, limit;
 
 	if (npages == 1) {
-		tce_build_pSeriesLP(tbl, tcenum, npages, uaddr, direction);
+		tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
+				    direction, attrs);
 		return;
 	}
 
@@ -150,7 +154,7 @@ static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		/* If allocation fails, fall back to the loop implementation */
 		if (!tcep) {
 			tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
-					    direction);
+					    direction, attrs);
 			return;
 		}
 		__get_cpu_var(tce_page) = tcep;
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 005c2ec..de8c8b5 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -149,7 +149,8 @@ static void dart_flush(struct iommu_table *tbl)
 
 static void dart_build(struct iommu_table *tbl, long index,
 		       long npages, unsigned long uaddr,
-		       enum dma_data_direction direction)
+		       enum dma_data_direction direction,
+		       struct dma_attrs *attrs)
 {
 	unsigned int *dp;
 	unsigned int rpn;
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 9899226..1233d73 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -80,7 +80,8 @@ struct machdep_calls {
 				     long index,
 				     long npages,
 				     unsigned long uaddr,
-				     enum dma_data_direction direction);
+				     enum dma_data_direction direction,
+				     struct dma_attrs *attrs);
 	void		(*tce_free)(struct iommu_table *tbl,
 				    long index,
 				    long npages);
-- 
1.5.4.3

-- 
