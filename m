Return-Path: <markn@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 65273DDFAF
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:33 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m4Q4JPJn015542
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:25 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4Q4JHd74403312
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:17 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4Q4JV3a024950
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:31 +1000
Message-Id: <20080526041943.144815580@au1.ibm.com>
References: <20080526041430.324464061@au1.ibm.com>
Date: Mon, 26 May 2008 14:14:33 +1000
From: markn@au1.ibm.com
To: linuxppc-dev@ozlabs.org
Subject: [patch 3/6] dma: use the struct dma_attrs in iommu code
Cc: Mark Nelson <markn@au1.ibm.com>, arnd@arndb.de
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
---
 arch/powerpc/kernel/iommu.c            |   13 ++++++++-----
 arch/powerpc/platforms/cell/iommu.c    |    5 +++--
 arch/powerpc/platforms/iseries/iommu.c |    3 ++-
 arch/powerpc/platforms/pasemi/iommu.c  |    3 ++-
 arch/powerpc/platforms/pseries/iommu.c |   13 ++++++++-----
 arch/powerpc/sysdev/dart_iommu.c       |    3 ++-
 include/asm-powerpc/machdep.h          |    3 ++-
 7 files changed, 27 insertions(+), 16 deletions(-)

Index: upstream/arch/powerpc/kernel/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/kernel/iommu.c
+++ upstream/arch/powerpc/kernel/iommu.c
@@ -186,7 +186,8 @@ static unsigned long iommu_range_alloc(s
 static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 			      void *page, unsigned int npages,
 			      enum dma_data_direction direction,
-			      unsigned long mask, unsigned int align_order)
+			      unsigned long mask, unsigned int align_order,
+			      struct dma_attrs *attrs)
 {
 	unsigned long entry, flags;
 	dma_addr_t ret = DMA_ERROR_CODE;
@@ -205,7 +206,7 @@ static dma_addr_t iommu_alloc(struct dev
 
 	/* Put the TCEs in the HW table */
 	ppc_md.tce_build(tbl, entry, npages, (unsigned long)page & IOMMU_PAGE_MASK,
-			 direction);
+			 direction, attrs);
 
 
 	/* Flush/invalidate TLB caches if necessary */
@@ -336,7 +337,8 @@ int iommu_map_sg(struct device *dev, str
 			    npages, entry, dma_addr);
 
 		/* Insert into HW table */
-		ppc_md.tce_build(tbl, entry, npages, vaddr & IOMMU_PAGE_MASK, direction);
+		ppc_md.tce_build(tbl, entry, npages, vaddr & IOMMU_PAGE_MASK,
+				 direction, attrs);
 
 		/* If we are in an open segment, try merging */
 		if (segstart != s) {
@@ -573,7 +575,8 @@ dma_addr_t iommu_map_single(struct devic
 			align = PAGE_SHIFT - IOMMU_PAGE_SHIFT;
 
 		dma_handle = iommu_alloc(dev, tbl, vaddr, npages, direction,
-					 mask >> IOMMU_PAGE_SHIFT, align);
+					 mask >> IOMMU_PAGE_SHIFT, align,
+					 attrs);
 		if (dma_handle == DMA_ERROR_CODE) {
 			if (printk_ratelimit())  {
 				printk(KERN_INFO "iommu_alloc failed, "
@@ -642,7 +645,7 @@ void *iommu_alloc_coherent(struct device
 	nio_pages = size >> IOMMU_PAGE_SHIFT;
 	io_order = get_iommu_order(size);
 	mapping = iommu_alloc(dev, tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
-			      mask >> IOMMU_PAGE_SHIFT, io_order);
+			      mask >> IOMMU_PAGE_SHIFT, io_order, NULL);
 	if (mapping == DMA_ERROR_CODE) {
 		free_pages((unsigned long)ret, order);
 		return NULL;
Index: upstream/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/cell/iommu.c
+++ upstream/arch/powerpc/platforms/cell/iommu.c
@@ -173,7 +173,8 @@ static void invalidate_tce_cache(struct 
 }
 
 static void tce_build_cell(struct iommu_table *tbl, long index, long npages,
-		unsigned long uaddr, enum dma_data_direction direction)
+		unsigned long uaddr, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
 	int i;
 	unsigned long *io_pte, base_pte;
@@ -519,7 +520,7 @@ cell_iommu_setup_window(struct cbe_iommu
 
 	__set_bit(0, window->table.it_map);
 	tce_build_cell(&window->table, window->table.it_offset, 1,
-		       (unsigned long)iommu->pad_page, DMA_TO_DEVICE);
+		       (unsigned long)iommu->pad_page, DMA_TO_DEVICE, NULL);
 	window->table.it_hint = window->table.it_blocksize;
 
 	return window;
Index: upstream/arch/powerpc/platforms/iseries/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/iseries/iommu.c
+++ upstream/arch/powerpc/platforms/iseries/iommu.c
@@ -42,7 +42,8 @@
 #include <asm/iseries/iommu.h>
 
 static void tce_build_iSeries(struct iommu_table *tbl, long index, long npages,
-		unsigned long uaddr, enum dma_data_direction direction)
+		unsigned long uaddr, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
 	u64 rc;
 	u64 tce, rpn;
Index: upstream/arch/powerpc/platforms/pasemi/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/pasemi/iommu.c
+++ upstream/arch/powerpc/platforms/pasemi/iommu.c
@@ -85,7 +85,8 @@ static int iommu_table_iobmap_inited;
 
 static void iobmap_build(struct iommu_table *tbl, long index,
 			 long npages, unsigned long uaddr,
-			 enum dma_data_direction direction)
+			 enum dma_data_direction direction,
+			 struct dma_attrs *attrs)
 {
 	u32 *ip;
 	u32 rpn;
Index: upstream/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/pseries/iommu.c
+++ upstream/arch/powerpc/platforms/pseries/iommu.c
@@ -50,7 +50,8 @@
 
 static void tce_build_pSeries(struct iommu_table *tbl, long index,
 			      long npages, unsigned long uaddr,
-			      enum dma_data_direction direction)
+			      enum dma_data_direction direction,
+			      struct dma_attrs *attrs)
 {
 	u64 proto_tce;
 	u64 *tcep;
@@ -95,7 +96,8 @@ static unsigned long tce_get_pseries(str
 
 static void tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				long npages, unsigned long uaddr,
-				enum dma_data_direction direction)
+				enum dma_data_direction direction,
+				struct dma_attrs *attrs)
 {
 	u64 rc;
 	u64 proto_tce, tce;
@@ -127,7 +129,8 @@ static DEFINE_PER_CPU(u64 *, tce_page) =
 
 static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
-				     enum dma_data_direction direction)
+				     enum dma_data_direction direction,
+				     struct dma_attrs *attrs)
 {
 	u64 rc;
 	u64 proto_tce;
@@ -137,7 +140,7 @@ static void tce_buildmulti_pSeriesLP(str
 
 	if (npages == 1)
 		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
-					   direction);
+					   direction, attrs);
 
 	tcep = __get_cpu_var(tce_page);
 
@@ -149,7 +152,7 @@ static void tce_buildmulti_pSeriesLP(str
 		/* If allocation fails, fall back to the loop implementation */
 		if (!tcep)
 			return tce_build_pSeriesLP(tbl, tcenum, npages,
-						   uaddr, direction);
+						   uaddr, direction, attrs);
 		__get_cpu_var(tce_page) = tcep;
 	}
 
Index: upstream/arch/powerpc/sysdev/dart_iommu.c
===================================================================
--- upstream.orig/arch/powerpc/sysdev/dart_iommu.c
+++ upstream/arch/powerpc/sysdev/dart_iommu.c
@@ -149,7 +149,8 @@ static void dart_flush(struct iommu_tabl
 
 static void dart_build(struct iommu_table *tbl, long index,
 		       long npages, unsigned long uaddr,
-		       enum dma_data_direction direction)
+		       enum dma_data_direction direction,
+		       struct dma_attrs *attrs)
 {
 	unsigned int *dp;
 	unsigned int rpn;
Index: upstream/include/asm-powerpc/machdep.h
===================================================================
--- upstream.orig/include/asm-powerpc/machdep.h
+++ upstream/include/asm-powerpc/machdep.h
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
