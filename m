Return-Path: <markn@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1D532DDED5
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:49:55 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m3U7nBwP028046
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:49:11 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3U7rlpM087478
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:53:47 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3U7nlbW028217
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:49:47 +1000
Message-Id: <20080430074953.238773415@au1.ibm.com>
References: <20080430074621.104662132@au1.ibm.com>
Date: Wed, 30 Apr 2008 17:46:22 +1000
From: markn@au1.ibm.com
To: olof@lixom.net
Subject: [RFC] [PATCH 1/5] [POWERPC] dma: implement new dma_*map*_attrs()
	interfaces
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update powerpc to use the new dma_*map*_attrs() interfaces. In doing so
update struct dma_mapping_ops to accept a struct dma_attrs and propagate
these changes through to all users of the code (generic IOMMU and the
64bit DMA code, and the iseries and ps3 platform code).

The old dma_*map_*() interfaces are reimplemented as calls to the
corresponding new interfaces.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/Kconfig                    |    1 
 arch/powerpc/kernel/dma_64.c            |   34 ++++++---
 arch/powerpc/kernel/ibmebus.c           |   12 ++-
 arch/powerpc/kernel/iommu.c             |   11 +--
 arch/powerpc/platforms/iseries/iommu.c  |    4 -
 arch/powerpc/platforms/ps3/system-bus.c |   17 ++--
 include/asm-powerpc/dma-mapping.h       |  116 +++++++++++++++++++++++---------
 include/asm-powerpc/iommu.h             |   12 ++-
 8 files changed, 144 insertions(+), 63 deletions(-)

Index: upstream/arch/powerpc/Kconfig
===================================================================
--- upstream.orig/arch/powerpc/Kconfig
+++ upstream/arch/powerpc/Kconfig
@@ -110,6 +110,7 @@ config PPC
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_LMB
+	select HAVE_DMA_ATTRS
 
 config EARLY_PRINTK
 	bool
Index: upstream/arch/powerpc/kernel/dma_64.c
===================================================================
--- upstream.orig/arch/powerpc/kernel/dma_64.c
+++ upstream/arch/powerpc/kernel/dma_64.c
@@ -50,32 +50,38 @@ static void dma_iommu_free_coherent(stru
  */
 static dma_addr_t dma_iommu_map_single(struct device *dev, void *vaddr,
 				       size_t size,
-				       enum dma_data_direction direction)
+				       enum dma_data_direction direction,
+				       struct dma_attrs *attrs)
 {
 	return iommu_map_single(dev, dev->archdata.dma_data, vaddr, size,
-			        device_to_mask(dev), direction);
+				device_to_mask(dev), direction, attrs);
 }
 
 
 static void dma_iommu_unmap_single(struct device *dev, dma_addr_t dma_handle,
 				   size_t size,
-				   enum dma_data_direction direction)
+				   enum dma_data_direction direction,
+				   struct dma_attrs *attrs)
 {
-	iommu_unmap_single(dev->archdata.dma_data, dma_handle, size, direction);
+	iommu_unmap_single(dev->archdata.dma_data, dma_handle, size, direction,
+			   attrs);
 }
 
 
 static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
-			    int nelems, enum dma_data_direction direction)
+			    int nelems, enum dma_data_direction direction,
+			    struct dma_attrs *attrs)
 {
 	return iommu_map_sg(dev, dev->archdata.dma_data, sglist, nelems,
-			    device_to_mask(dev), direction);
+			    device_to_mask(dev), direction, attrs);
 }
 
 static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction)
+		int nelems, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
-	iommu_unmap_sg(dev->archdata.dma_data, sglist, nelems, direction);
+	iommu_unmap_sg(dev->archdata.dma_data, sglist, nelems, direction,
+		       attrs);
 }
 
 /* We support DMA to/from any memory page via the iommu */
@@ -148,19 +154,22 @@ static void dma_direct_free_coherent(str
 
 static dma_addr_t dma_direct_map_single(struct device *dev, void *ptr,
 					size_t size,
-					enum dma_data_direction direction)
+					enum dma_data_direction direction,
+					struct dma_attrs *attrs)
 {
 	return virt_to_abs(ptr) + get_dma_direct_offset(dev);
 }
 
 static void dma_direct_unmap_single(struct device *dev, dma_addr_t dma_addr,
 				    size_t size,
-				    enum dma_data_direction direction)
+				    enum dma_data_direction direction,
+				    struct dma_attrs *attrs)
 {
 }
 
 static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
-			     int nents, enum dma_data_direction direction)
+			     int nents, enum dma_data_direction direction,
+			     struct dma_attrs *attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -174,7 +183,8 @@ static int dma_direct_map_sg(struct devi
 }
 
 static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction direction)
+				int nents, enum dma_data_direction direction,
+				struct dma_attrs *attrs)
 {
 }
 
Index: upstream/arch/powerpc/kernel/ibmebus.c
===================================================================
--- upstream.orig/arch/powerpc/kernel/ibmebus.c
+++ upstream/arch/powerpc/kernel/ibmebus.c
@@ -82,7 +82,8 @@ static void ibmebus_free_coherent(struct
 static dma_addr_t ibmebus_map_single(struct device *dev,
 				     void *ptr,
 				     size_t size,
-				     enum dma_data_direction direction)
+				     enum dma_data_direction direction,
+				     struct dma_attrs *attrs)
 {
 	return (dma_addr_t)(ptr);
 }
@@ -90,14 +91,16 @@ static dma_addr_t ibmebus_map_single(str
 static void ibmebus_unmap_single(struct device *dev,
 				 dma_addr_t dma_addr,
 				 size_t size,
-				 enum dma_data_direction direction)
+				 enum dma_data_direction direction,
+				 struct dma_attrs *attrs)
 {
 	return;
 }
 
 static int ibmebus_map_sg(struct device *dev,
 			  struct scatterlist *sgl,
-			  int nents, enum dma_data_direction direction)
+			  int nents, enum dma_data_direction direction,
+			  struct dma_attrs *attrs)
 {
 	struct scatterlist *sg;
 	int i;
@@ -112,7 +115,8 @@ static int ibmebus_map_sg(struct device 
 
 static void ibmebus_unmap_sg(struct device *dev,
 			     struct scatterlist *sg,
-			     int nents, enum dma_data_direction direction)
+			     int nents, enum dma_data_direction direction,
+			     struct dma_attrs *attrs)
 {
 	return;
 }
Index: upstream/arch/powerpc/kernel/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/kernel/iommu.c
+++ upstream/arch/powerpc/kernel/iommu.c
@@ -269,7 +269,8 @@ static void iommu_free(struct iommu_tabl
 
 int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		 struct scatterlist *sglist, int nelems,
-		 unsigned long mask, enum dma_data_direction direction)
+		 unsigned long mask, enum dma_data_direction direction,
+		 struct dma_attrs *attrs)
 {
 	dma_addr_t dma_next = 0, dma_addr;
 	unsigned long flags;
@@ -411,7 +412,8 @@ int iommu_map_sg(struct device *dev, str
 
 
 void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction)
+		int nelems, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
 	struct scatterlist *sg;
 	unsigned long flags;
@@ -553,7 +555,7 @@ void iommu_free_table(struct iommu_table
  */
 dma_addr_t iommu_map_single(struct device *dev, struct iommu_table *tbl,
 			    void *vaddr, size_t size, unsigned long mask,
-			    enum dma_data_direction direction)
+		enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	dma_addr_t dma_handle = DMA_ERROR_CODE;
 	unsigned long uaddr;
@@ -586,7 +588,8 @@ dma_addr_t iommu_map_single(struct devic
 }
 
 void iommu_unmap_single(struct iommu_table *tbl, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction direction)
+		size_t size, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
 	unsigned int npages;
 
Index: upstream/arch/powerpc/platforms/iseries/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/iseries/iommu.c
+++ upstream/arch/powerpc/platforms/iseries/iommu.c
@@ -214,13 +214,13 @@ dma_addr_t iseries_hv_map(void *vaddr, s
 			enum dma_data_direction direction)
 {
 	return iommu_map_single(NULL, &vio_iommu_table, vaddr, size,
-				DMA_32BIT_MASK, direction);
+				DMA_32BIT_MASK, direction, NULL);
 }
 
 void iseries_hv_unmap(dma_addr_t dma_handle, size_t size,
 			enum dma_data_direction direction)
 {
-	iommu_unmap_single(&vio_iommu_table, dma_handle, size, direction);
+	iommu_unmap_single(&vio_iommu_table, dma_handle, size, direction, NULL);
 }
 
 void __init iommu_vio_init(void)
Index: upstream/arch/powerpc/platforms/ps3/system-bus.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/ps3/system-bus.c
+++ upstream/arch/powerpc/platforms/ps3/system-bus.c
@@ -550,7 +550,7 @@ static void ps3_free_coherent(struct dev
  */
 
 static dma_addr_t ps3_sb_map_single(struct device *_dev, void *ptr, size_t size,
-	enum dma_data_direction direction)
+	enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
@@ -570,7 +570,8 @@ static dma_addr_t ps3_sb_map_single(stru
 
 static dma_addr_t ps3_ioc0_map_single(struct device *_dev, void *ptr,
 				      size_t size,
-				      enum dma_data_direction direction)
+				      enum dma_data_direction direction,
+				      struct dma_attrs *attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
@@ -603,7 +604,7 @@ static dma_addr_t ps3_ioc0_map_single(st
 }
 
 static void ps3_unmap_single(struct device *_dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction)
+	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
@@ -617,7 +618,7 @@ static void ps3_unmap_single(struct devi
 }
 
 static int ps3_sb_map_sg(struct device *_dev, struct scatterlist *sgl,
-	int nents, enum dma_data_direction direction)
+	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 #if defined(CONFIG_PS3_DYNAMIC_DMA)
 	BUG_ON("do");
@@ -646,14 +647,15 @@ static int ps3_sb_map_sg(struct device *
 
 static int ps3_ioc0_map_sg(struct device *_dev, struct scatterlist *sg,
 			   int nents,
-			   enum dma_data_direction direction)
+			   enum dma_data_direction direction,
+			   struct dma_attrs *attrs)
 {
 	BUG();
 	return 0;
 }
 
 static void ps3_sb_unmap_sg(struct device *_dev, struct scatterlist *sg,
-	int nents, enum dma_data_direction direction)
+	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 #if defined(CONFIG_PS3_DYNAMIC_DMA)
 	BUG_ON("do");
@@ -661,7 +663,8 @@ static void ps3_sb_unmap_sg(struct devic
 }
 
 static void ps3_ioc0_unmap_sg(struct device *_dev, struct scatterlist *sg,
-			    int nents, enum dma_data_direction direction)
+			    int nents, enum dma_data_direction direction,
+			    struct dma_attrs *attrs)
 {
 	BUG();
 }
Index: upstream/include/asm-powerpc/dma-mapping.h
===================================================================
--- upstream.orig/include/asm-powerpc/dma-mapping.h
+++ upstream/include/asm-powerpc/dma-mapping.h
@@ -13,6 +13,7 @@
 /* need struct page definitions */
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
+#include <linux/dma-attrs.h>
 #include <asm/io.h>
 
 #define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
@@ -53,13 +54,17 @@ struct dma_mapping_ops {
 	void		(*free_coherent)(struct device *dev, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
 	dma_addr_t	(*map_single)(struct device *dev, void *ptr,
-				size_t size, enum dma_data_direction direction);
+				size_t size, enum dma_data_direction direction,
+				struct dma_attrs *attrs);
 	void		(*unmap_single)(struct device *dev, dma_addr_t dma_addr,
-				size_t size, enum dma_data_direction direction);
+				size_t size, enum dma_data_direction direction,
+				struct dma_attrs *attrs);
 	int		(*map_sg)(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction direction);
+				int nents, enum dma_data_direction direction,
+				struct dma_attrs *attrs);
 	void		(*unmap_sg)(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction direction);
+				int nents, enum dma_data_direction direction,
+				struct dma_attrs *attrs);
 	int		(*dma_supported)(struct device *dev, u64 mask);
 	int		(*set_dma_mask)(struct device *dev, u64 dma_mask);
 };
@@ -109,6 +114,77 @@ static inline int dma_set_mask(struct de
 	return 0;
 }
 
+static inline dma_addr_t dma_map_single_attrs(struct device *dev,
+					      void *cpu_addr,
+					      size_t size,
+					      enum dma_data_direction direction,
+					      struct dma_attrs *attrs)
+{
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	BUG_ON(!dma_ops);
+	return dma_ops->map_single(dev, cpu_addr, size, direction, attrs);
+}
+
+static inline void dma_unmap_single_attrs(struct device *dev,
+					  dma_addr_t dma_addr,
+					  size_t size,
+					  enum dma_data_direction direction,
+					  struct dma_attrs *attrs)
+{
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	BUG_ON(!dma_ops);
+	dma_ops->unmap_single(dev, dma_addr, size, direction, attrs);
+}
+
+static inline dma_addr_t dma_map_page_attrs(struct device *dev,
+					    struct page *page,
+					    unsigned long offset, size_t size,
+					    enum dma_data_direction direction,
+					    struct dma_attrs *attrs)
+{
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	BUG_ON(!dma_ops);
+	return dma_ops->map_single(dev, page_address(page) + offset, size,
+			direction, attrs);
+}
+
+static inline void dma_unmap_page_attrs(struct device *dev,
+					dma_addr_t dma_address,
+					size_t size,
+					enum dma_data_direction direction,
+					struct dma_attrs *attrs)
+{
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	BUG_ON(!dma_ops);
+	dma_ops->unmap_single(dev, dma_address, size, direction, attrs);
+}
+
+static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
+				   int nents, enum dma_data_direction direction,
+				   struct dma_attrs *attrs)
+{
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	BUG_ON(!dma_ops);
+	return dma_ops->map_sg(dev, sg, nents, direction, attrs);
+}
+
+static inline void dma_unmap_sg_attrs(struct device *dev,
+				      struct scatterlist *sg,
+				      int nhwentries,
+				      enum dma_data_direction direction,
+				      struct dma_attrs *attrs)
+{
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	BUG_ON(!dma_ops);
+	dma_ops->unmap_sg(dev, sg, nhwentries, direction, attrs);
+}
+
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag)
 {
@@ -131,63 +207,43 @@ static inline dma_addr_t dma_map_single(
 					size_t size,
 					enum dma_data_direction direction)
 {
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	BUG_ON(!dma_ops);
-	return dma_ops->map_single(dev, cpu_addr, size, direction);
+	return dma_map_single_attrs(dev, cpu_addr, size, direction, NULL);
 }
 
 static inline void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
 				    size_t size,
 				    enum dma_data_direction direction)
 {
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	BUG_ON(!dma_ops);
-	dma_ops->unmap_single(dev, dma_addr, size, direction);
+	dma_unmap_single_attrs(dev, dma_addr, size, direction, NULL);
 }
 
 static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 				      unsigned long offset, size_t size,
 				      enum dma_data_direction direction)
 {
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	BUG_ON(!dma_ops);
-	return dma_ops->map_single(dev, page_address(page) + offset, size,
-			direction);
+	return dma_map_page_attrs(dev, page, offset, size, direction, NULL);
 }
 
 static inline void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
 				  size_t size,
 				  enum dma_data_direction direction)
 {
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	BUG_ON(!dma_ops);
-	dma_ops->unmap_single(dev, dma_address, size, direction);
+	dma_unmap_page_attrs(dev, dma_address, size, direction, NULL);
 }
 
 static inline int dma_map_sg(struct device *dev, struct scatterlist *sg,
 			     int nents, enum dma_data_direction direction)
 {
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	BUG_ON(!dma_ops);
-	return dma_ops->map_sg(dev, sg, nents, direction);
+	return dma_map_sg_attrs(dev, sg, nents, direction, NULL);
 }
 
 static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 				int nhwentries,
 				enum dma_data_direction direction)
 {
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	BUG_ON(!dma_ops);
-	dma_ops->unmap_sg(dev, sg, nhwentries, direction);
+	dma_unmap_sg_attrs(dev, sg, nhwentries, direction, NULL);
 }
 
-
 /*
  * Available generic sets of operations
  */
Index: upstream/include/asm-powerpc/iommu.h
===================================================================
--- upstream.orig/include/asm-powerpc/iommu.h
+++ upstream/include/asm-powerpc/iommu.h
@@ -81,9 +81,11 @@ extern struct iommu_table *iommu_init_ta
 
 extern int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 			struct scatterlist *sglist, int nelems,
-			unsigned long mask, enum dma_data_direction direction);
+			unsigned long mask, enum dma_data_direction direction,
+			struct dma_attrs *attrs);
 extern void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
-			   int nelems, enum dma_data_direction direction);
+			   int nelems, enum dma_data_direction direction,
+			   struct dma_attrs *attrs);
 
 extern void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 				  size_t size, dma_addr_t *dma_handle,
@@ -92,9 +94,11 @@ extern void iommu_free_coherent(struct i
 				void *vaddr, dma_addr_t dma_handle);
 extern dma_addr_t iommu_map_single(struct device *dev, struct iommu_table *tbl,
 				   void *vaddr, size_t size, unsigned long mask,
-				   enum dma_data_direction direction);
+				   enum dma_data_direction direction,
+				   struct dma_attrs *attrs);
 extern void iommu_unmap_single(struct iommu_table *tbl, dma_addr_t dma_handle,
-			       size_t size, enum dma_data_direction direction);
+			       size_t size, enum dma_data_direction direction,
+			       struct dma_attrs *attrs);
 
 extern void iommu_init_early_pSeries(void);
 extern void iommu_init_early_iSeries(void);

-- 
