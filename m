Return-Path: <markn@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D49A4DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 17:45:02 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id m9S6hXQo4169792
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 17:43:33 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9S6bQDV239394
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 17:37:27 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9S6bPt1029911
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 17:37:25 +1100
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: Update remaining dma_mapping_ops to use
	map/unmap_page
Date: Tue, 28 Oct 2008 17:38:08 +1100
MIME-Version: 1.0
Message-Id: <200810281738.08091.markn@au1.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

After the merge of the 32 and 64bit DMA code, dma_direct_ops lost their
map/unmap_single() functions but gained map/unmap_page(). This caused a
problem for Cell because Cell's dma_iommu_fixed_ops called the dma_direct_ops
if the fixed linear mapping was to be used or the iommu ops if the dynamic
window was to be used. So in order to fix this problem we need to update the
64bit DMA code to use map/unmap_page.

First, we update the generic IOMMU code so that iommu_map_single() becomes
iommu_map_page() and iommu_unmap_single() becomes iommu_unmap_page(). Then we
propagate these changes up through all the callers of these two functions and
in the process update all the dma_mapping_ops so that they have map/unmap_page
rahter than map/unmap_single. We can do this because on 64bit there is no
HIGHMEM memory so map/unmap_page ends up performing exactly the same function
as map/unmap_single, just taking different arguments.

This has no effect on drivers because the dma_map_single_attrs() just ends up
calling the map_page() function of the appropriate dma_mapping_ops and
similarly the dma_unmap_single_attrs() calls unmap_page().

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
Is it possible to get this in for 2.6.28 because currently Cell blades oops
on boot because they're calling dma_direct_ops.map_single (which is NULL)?

 arch/powerpc/include/asm/iommu.h        |   15 ++++++------
 arch/powerpc/kernel/dma-iommu.c         |   34 +++++++++++++----------------
 arch/powerpc/kernel/ibmebus.c           |   29 ++++++++++++-------------
 arch/powerpc/kernel/iommu.c             |   22 ++++++++++---------
 arch/powerpc/kernel/vio.c               |   25 +++++++++++----------
 arch/powerpc/platforms/cell/iommu.c     |   37 +++++++++++++++-----------------
 arch/powerpc/platforms/iseries/iommu.c  |    7 +++---
 arch/powerpc/platforms/ps3/system-bus.c |   36 ++++++++++++++++---------------
 8 files changed, 105 insertions(+), 100 deletions(-)

Index: upstream/arch/powerpc/include/asm/iommu.h
===================================================================
--- upstream.orig/arch/powerpc/include/asm/iommu.h
+++ upstream/arch/powerpc/include/asm/iommu.h
@@ -92,13 +92,14 @@ extern void *iommu_alloc_coherent(struct
 				  unsigned long mask, gfp_t flag, int node);
 extern void iommu_free_coherent(struct iommu_table *tbl, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
-extern dma_addr_t iommu_map_single(struct device *dev, struct iommu_table *tbl,
-				   void *vaddr, size_t size, unsigned long mask,
-				   enum dma_data_direction direction,
-				   struct dma_attrs *attrs);
-extern void iommu_unmap_single(struct iommu_table *tbl, dma_addr_t dma_handle,
-			       size_t size, enum dma_data_direction direction,
-			       struct dma_attrs *attrs);
+extern dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
+				 struct page *page, unsigned long offset,
+				 size_t size, unsigned long mask,
+				 enum dma_data_direction direction,
+				 struct dma_attrs *attrs);
+extern void iommu_unmap_page(struct iommu_table *tbl, dma_addr_t dma_handle,
+			     size_t size, enum dma_data_direction direction,
+			     struct dma_attrs *attrs);
 
 extern void iommu_init_early_pSeries(void);
 extern void iommu_init_early_iSeries(void);
Index: upstream/arch/powerpc/kernel/dma-iommu.c
===================================================================
--- upstream.orig/arch/powerpc/kernel/dma-iommu.c
+++ upstream/arch/powerpc/kernel/dma-iommu.c
@@ -30,28 +30,26 @@ static void dma_iommu_free_coherent(stru
 }
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be
- * contiguous real kernel storage (not vmalloc).  The address of the buffer
- * passed here is the kernel (virtual) address of the buffer.  The buffer
- * need not be page aligned, the dma_addr_t returned will point to the same
- * byte within the page as vaddr.
+ * contiguous real kernel storage (not vmalloc).  The address passed here
+ * comprises a page address and offset into that page. The dma_addr_t
+ * returned will point to the same byte within the page as was passed in.
  */
-static dma_addr_t dma_iommu_map_single(struct device *dev, void *vaddr,
-				       size_t size,
-				       enum dma_data_direction direction,
-				       struct dma_attrs *attrs)
+static dma_addr_t dma_iommu_map_page(struct device *dev, struct page *page,
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction direction,
+				     struct dma_attrs *attrs)
 {
-	return iommu_map_single(dev, dev->archdata.dma_data, vaddr, size,
-				device_to_mask(dev), direction, attrs);
+	return iommu_map_page(dev, dev->archdata.dma_data, page, offset, size,
+			      device_to_mask(dev), direction, attrs);
 }
 
 
-static void dma_iommu_unmap_single(struct device *dev, dma_addr_t dma_handle,
-				   size_t size,
-				   enum dma_data_direction direction,
-				   struct dma_attrs *attrs)
+static void dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
+				 size_t size, enum dma_data_direction direction,
+				 struct dma_attrs *attrs)
 {
-	iommu_unmap_single(dev->archdata.dma_data, dma_handle, size, direction,
-			   attrs);
+	iommu_unmap_page(dev->archdata.dma_data, dma_handle, size, direction,
+			 attrs);
 }
 
 
@@ -94,10 +92,10 @@ static int dma_iommu_dma_supported(struc
 struct dma_mapping_ops dma_iommu_ops = {
 	.alloc_coherent	= dma_iommu_alloc_coherent,
 	.free_coherent	= dma_iommu_free_coherent,
-	.map_single	= dma_iommu_map_single,
-	.unmap_single	= dma_iommu_unmap_single,
 	.map_sg		= dma_iommu_map_sg,
 	.unmap_sg	= dma_iommu_unmap_sg,
 	.dma_supported	= dma_iommu_dma_supported,
+	.map_page	= dma_iommu_map_page,
+	.unmap_page	= dma_iommu_unmap_page,
 };
 EXPORT_SYMBOL(dma_iommu_ops);
Index: upstream/arch/powerpc/kernel/ibmebus.c
===================================================================
--- upstream.orig/arch/powerpc/kernel/ibmebus.c
+++ upstream/arch/powerpc/kernel/ibmebus.c
@@ -79,20 +79,21 @@ static void ibmebus_free_coherent(struct
 	kfree(vaddr);
 }
 
-static dma_addr_t ibmebus_map_single(struct device *dev,
-				     void *ptr,
-				     size_t size,
-				     enum dma_data_direction direction,
-				     struct dma_attrs *attrs)
-{
-	return (dma_addr_t)(ptr);
+static dma_addr_t ibmebus_map_page(struct device *dev,
+				   struct page *page,
+				   unsigned long offset,
+				   size_t size,
+				   enum dma_data_direction direction,
+				   struct dma_attrs *attrs)
+{
+	return (dma_addr_t)(page_address(page) + offset);
 }
 
-static void ibmebus_unmap_single(struct device *dev,
-				 dma_addr_t dma_addr,
-				 size_t size,
-				 enum dma_data_direction direction,
-				 struct dma_attrs *attrs)
+static void ibmebus_unmap_page(struct device *dev,
+			       dma_addr_t dma_addr,
+			       size_t size,
+			       enum dma_data_direction direction,
+			       struct dma_attrs *attrs)
 {
 	return;
 }
@@ -129,11 +130,11 @@ static int ibmebus_dma_supported(struct 
 static struct dma_mapping_ops ibmebus_dma_ops = {
 	.alloc_coherent = ibmebus_alloc_coherent,
 	.free_coherent  = ibmebus_free_coherent,
-	.map_single     = ibmebus_map_single,
-	.unmap_single   = ibmebus_unmap_single,
 	.map_sg         = ibmebus_map_sg,
 	.unmap_sg       = ibmebus_unmap_sg,
 	.dma_supported  = ibmebus_dma_supported,
+	.map_page       = ibmebus_map_page,
+	.unmap_page     = ibmebus_unmap_page,
 };
 
 static int ibmebus_match_path(struct device *dev, void *data)
Index: upstream/arch/powerpc/kernel/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/kernel/iommu.c
+++ upstream/arch/powerpc/kernel/iommu.c
@@ -564,21 +564,23 @@ void iommu_free_table(struct iommu_table
 }
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be
- * contiguous real kernel storage (not vmalloc).  The address of the buffer
- * passed here is the kernel (virtual) address of the buffer.  The buffer
- * need not be page aligned, the dma_addr_t returned will point to the same
- * byte within the page as vaddr.
+ * contiguous real kernel storage (not vmalloc).  The address passed here
+ * comprises a page address and offset into that page. The dma_addr_t
+ * returned will point to the same byte within the page as was passed in.
  */
-dma_addr_t iommu_map_single(struct device *dev, struct iommu_table *tbl,
-			    void *vaddr, size_t size, unsigned long mask,
-		enum dma_data_direction direction, struct dma_attrs *attrs)
+dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
+			  struct page *page, unsigned long offset, size_t size,
+			  unsigned long mask, enum dma_data_direction direction,
+			  struct dma_attrs *attrs)
 {
 	dma_addr_t dma_handle = DMA_ERROR_CODE;
+	void *vaddr;
 	unsigned long uaddr;
 	unsigned int npages, align;
 
 	BUG_ON(direction == DMA_NONE);
 
+	vaddr = page_address(page) + offset;
 	uaddr = (unsigned long)vaddr;
 	npages = iommu_num_pages(uaddr, size, IOMMU_PAGE_SIZE);
 
@@ -604,9 +606,9 @@ dma_addr_t iommu_map_single(struct devic
 	return dma_handle;
 }
 
-void iommu_unmap_single(struct iommu_table *tbl, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+void iommu_unmap_page(struct iommu_table *tbl, dma_addr_t dma_handle,
+		      size_t size, enum dma_data_direction direction,
+		      struct dma_attrs *attrs)
 {
 	unsigned int npages;
 
Index: upstream/arch/powerpc/kernel/vio.c
===================================================================
--- upstream.orig/arch/powerpc/kernel/vio.c
+++ upstream/arch/powerpc/kernel/vio.c
@@ -516,10 +516,10 @@ static void vio_dma_iommu_free_coherent(
 	vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
 }
 
-static dma_addr_t vio_dma_iommu_map_single(struct device *dev, void *vaddr,
-                                           size_t size,
-                                           enum dma_data_direction direction,
-                                           struct dma_attrs *attrs)
+static dma_addr_t vio_dma_iommu_map_page(struct device *dev, struct page *page,
+                                         unsigned long offset, size_t size,
+                                         enum dma_data_direction direction,
+                                         struct dma_attrs *attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 	dma_addr_t ret = DMA_ERROR_CODE;
@@ -529,7 +529,7 @@ static dma_addr_t vio_dma_iommu_map_sing
 		return ret;
 	}
 
-	ret = dma_iommu_ops.map_single(dev, vaddr, size, direction, attrs);
+	ret = dma_iommu_ops.map_page(dev, page, offset, size, direction, attrs);
 	if (unlikely(dma_mapping_error(dev, ret))) {
 		vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
 		atomic_inc(&viodev->cmo.allocs_failed);
@@ -538,14 +538,14 @@ static dma_addr_t vio_dma_iommu_map_sing
 	return ret;
 }
 
-static void vio_dma_iommu_unmap_single(struct device *dev,
-		dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+static void vio_dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
+				     size_t size,
+				     enum dma_data_direction direction,
+				     struct dma_attrs *attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 
-	dma_iommu_ops.unmap_single(dev, dma_handle, size, direction, attrs);
+	dma_iommu_ops.unmap_page(dev, dma_handle, size, direction, attrs);
 
 	vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
 }
@@ -603,10 +603,11 @@ static void vio_dma_iommu_unmap_sg(struc
 struct dma_mapping_ops vio_dma_mapping_ops = {
 	.alloc_coherent = vio_dma_iommu_alloc_coherent,
 	.free_coherent  = vio_dma_iommu_free_coherent,
-	.map_single     = vio_dma_iommu_map_single,
-	.unmap_single   = vio_dma_iommu_unmap_single,
 	.map_sg         = vio_dma_iommu_map_sg,
 	.unmap_sg       = vio_dma_iommu_unmap_sg,
+	.map_page       = vio_dma_iommu_map_page,
+	.unmap_page     = vio_dma_iommu_unmap_page,
+
 };
 
 /**
Index: upstream/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/cell/iommu.c
+++ upstream/arch/powerpc/platforms/cell/iommu.c
@@ -593,31 +593,30 @@ static void dma_fixed_free_coherent(stru
 		dma_direct_ops.free_coherent(dev, size, vaddr, dma_handle);
 }
 
-static dma_addr_t dma_fixed_map_single(struct device *dev, void *ptr,
-				       size_t size,
-				       enum dma_data_direction direction,
-				       struct dma_attrs *attrs)
+static dma_addr_t dma_fixed_map_page(struct device *dev, struct page *page,
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction direction,
+				     struct dma_attrs *attrs)
 {
 	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
-		return dma_direct_ops.map_single(dev, ptr, size, direction,
-						 attrs);
+		return dma_direct_ops.map_page(dev, page, offset, size,
+					       direction, attrs);
 	else
-		return iommu_map_single(dev, cell_get_iommu_table(dev), ptr,
-					size, device_to_mask(dev), direction,
-					attrs);
+		return iommu_map_page(dev, cell_get_iommu_table(dev), page,
+				      offset, size, device_to_mask(dev),
+				      direction, attrs);
 }
 
-static void dma_fixed_unmap_single(struct device *dev, dma_addr_t dma_addr,
-				   size_t size,
-				   enum dma_data_direction direction,
-				   struct dma_attrs *attrs)
+static void dma_fixed_unmap_page(struct device *dev, dma_addr_t dma_addr,
+				 size_t size, enum dma_data_direction direction,
+				 struct dma_attrs *attrs)
 {
 	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
-		dma_direct_ops.unmap_single(dev, dma_addr, size, direction,
-					    attrs);
+		dma_direct_ops.unmap_page(dev, dma_addr, size, direction,
+					  attrs);
 	else
-		iommu_unmap_single(cell_get_iommu_table(dev), dma_addr, size,
-				   direction, attrs);
+		iommu_unmap_page(cell_get_iommu_table(dev), dma_addr, size,
+				 direction, attrs);
 }
 
 static int dma_fixed_map_sg(struct device *dev, struct scatterlist *sg,
@@ -652,12 +651,12 @@ static int dma_set_mask_and_switch(struc
 struct dma_mapping_ops dma_iommu_fixed_ops = {
 	.alloc_coherent = dma_fixed_alloc_coherent,
 	.free_coherent  = dma_fixed_free_coherent,
-	.map_single     = dma_fixed_map_single,
-	.unmap_single   = dma_fixed_unmap_single,
 	.map_sg         = dma_fixed_map_sg,
 	.unmap_sg       = dma_fixed_unmap_sg,
 	.dma_supported  = dma_fixed_dma_supported,
 	.set_dma_mask   = dma_set_mask_and_switch,
+	.map_page       = dma_fixed_map_page,
+	.unmap_page     = dma_fixed_unmap_page,
 };
 
 static void cell_dma_dev_setup_fixed(struct device *dev);
Index: upstream/arch/powerpc/platforms/iseries/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/iseries/iommu.c
+++ upstream/arch/powerpc/platforms/iseries/iommu.c
@@ -215,14 +215,15 @@ EXPORT_SYMBOL_GPL(iseries_hv_free);
 dma_addr_t iseries_hv_map(void *vaddr, size_t size,
 			enum dma_data_direction direction)
 {
-	return iommu_map_single(NULL, &vio_iommu_table, vaddr, size,
-				DMA_32BIT_MASK, direction, NULL);
+	return iommu_map_page(NULL, &vio_iommu_table, virt_to_page(vaddr),
+			      (unsigned long)vaddr % PAGE_SIZE, size,
+			      DMA_32BIT_MASK, direction, NULL);
 }
 
 void iseries_hv_unmap(dma_addr_t dma_handle, size_t size,
 			enum dma_data_direction direction)
 {
-	iommu_unmap_single(&vio_iommu_table, dma_handle, size, direction, NULL);
+	iommu_unmap_page(&vio_iommu_table, dma_handle, size, direction, NULL);
 }
 
 void __init iommu_vio_init(void)
Index: upstream/arch/powerpc/platforms/ps3/system-bus.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/ps3/system-bus.c
+++ upstream/arch/powerpc/platforms/ps3/system-bus.c
@@ -555,18 +555,19 @@ static void ps3_free_coherent(struct dev
 }
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be
- * contiguous real kernel storage (not vmalloc).  The address of the buffer
- * passed here is the kernel (virtual) address of the buffer.  The buffer
- * need not be page aligned, the dma_addr_t returned will point to the same
- * byte within the page as vaddr.
+ * contiguous real kernel storage (not vmalloc).  The address passed here
+ * comprises a page address and offset into that page. The dma_addr_t
+ * returned will point to the same byte within the page as was passed in.
  */
 
-static dma_addr_t ps3_sb_map_single(struct device *_dev, void *ptr, size_t size,
-	enum dma_data_direction direction, struct dma_attrs *attrs)
+static dma_addr_t ps3_sb_map_page(struct device *_dev, struct page *page,
+	unsigned long offset, size_t size, enum dma_data_direction direction,
+	struct dma_attrs *attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
 	unsigned long bus_addr;
+	void *ptr = page_address(page) + offset;
 
 	result = ps3_dma_map(dev->d_region, (unsigned long)ptr, size,
 			     &bus_addr,
@@ -580,15 +581,16 @@ static dma_addr_t ps3_sb_map_single(stru
 	return bus_addr;
 }
 
-static dma_addr_t ps3_ioc0_map_single(struct device *_dev, void *ptr,
-				      size_t size,
-				      enum dma_data_direction direction,
-				      struct dma_attrs *attrs)
+static dma_addr_t ps3_ioc0_map_page(struct device *_dev, struct page *page,
+				    unsigned long offset, size_t size,
+				    enum dma_data_direction direction,
+				    struct dma_attrs *attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
 	unsigned long bus_addr;
 	u64 iopte_flag;
+	void *ptr = page_address(page) + offset;
 
 	iopte_flag = IOPTE_M;
 	switch (direction) {
@@ -615,7 +617,7 @@ static dma_addr_t ps3_ioc0_map_single(st
 	return bus_addr;
 }
 
-static void ps3_unmap_single(struct device *_dev, dma_addr_t dma_addr,
+static void ps3_unmap_page(struct device *_dev, dma_addr_t dma_addr,
 	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
@@ -689,21 +691,21 @@ static int ps3_dma_supported(struct devi
 static struct dma_mapping_ops ps3_sb_dma_ops = {
 	.alloc_coherent = ps3_alloc_coherent,
 	.free_coherent = ps3_free_coherent,
-	.map_single = ps3_sb_map_single,
-	.unmap_single = ps3_unmap_single,
 	.map_sg = ps3_sb_map_sg,
 	.unmap_sg = ps3_sb_unmap_sg,
-	.dma_supported = ps3_dma_supported
+	.dma_supported = ps3_dma_supported,
+	.map_page = ps3_sb_map_page,
+	.unmap_page = ps3_unmap_page,
 };
 
 static struct dma_mapping_ops ps3_ioc0_dma_ops = {
 	.alloc_coherent = ps3_alloc_coherent,
 	.free_coherent = ps3_free_coherent,
-	.map_single = ps3_ioc0_map_single,
-	.unmap_single = ps3_unmap_single,
 	.map_sg = ps3_ioc0_map_sg,
 	.unmap_sg = ps3_ioc0_unmap_sg,
-	.dma_supported = ps3_dma_supported
+	.dma_supported = ps3_dma_supported,
+	.map_page = ps3_ioc0_map_page,
+	.unmap_page = ps3_unmap_page,
 };
 
 /**
