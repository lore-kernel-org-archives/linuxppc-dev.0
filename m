Return-Path: <arnd@arndb.de>
Message-Id: <20080704190806.430190454@arndb.de>
References: <20080704190535.316377278@arndb.de>
Date: Fri, 04 Jul 2008 21:05:42 +0200
From: arnd@arndb.de
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 07/11] powerpc/dma: implement new dma_*map*_attrs() interfaces
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

Update powerpc to use the new dma_*map*_attrs() interfaces. In doing so
update struct dma_mapping_ops to accept a struct dma_attrs and propagate
these changes through to all users of the code (generic IOMMU and the
64bit DMA code, and the iseries and ps3 platform code).

The old dma_*map_*() interfaces are reimplemented as calls to the
corresponding new interfaces.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/Kconfig                    |    1 +
 arch/powerpc/kernel/dma_64.c            |   34 ++++++---
 arch/powerpc/kernel/ibmebus.c           |   12 ++-
 arch/powerpc/kernel/iommu.c             |   11 ++-
 arch/powerpc/platforms/iseries/iommu.c  |    4 +-
 arch/powerpc/platforms/ps3/system-bus.c |   17 +++--
 include/asm-powerpc/dma-mapping.h       |  116 +++++++++++++++++++++++--------
 include/asm-powerpc/iommu.h             |   12 ++-
 8 files changed, 144 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f2a0f50..462c86a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -110,6 +110,7 @@ config PPC
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_LMB
+	select HAVE_DMA_ATTRS
 
 config EARLY_PRINTK
 	bool
diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
index 7397445..3ae0c35 100644
--- a/arch/powerpc/kernel/dma_64.c
+++ b/arch/powerpc/kernel/dma_64.c
@@ -50,32 +50,38 @@ static void dma_iommu_free_coherent(struct device *dev, size_t size,
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
@@ -148,19 +154,22 @@ static void dma_direct_free_coherent(struct device *dev, size_t size,
 
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
@@ -174,7 +183,8 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 }
 
 static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction direction)
+				int nents, enum dma_data_direction direction,
+				struct dma_attrs *attrs)
 {
 }
 
diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 9971159..e3b1fcd 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -82,7 +82,8 @@ static void ibmebus_free_coherent(struct device *dev,
 static dma_addr_t ibmebus_map_single(struct device *dev,
 				     void *ptr,
 				     size_t size,
-				     enum dma_data_direction direction)
+				     enum dma_data_direction direction,
+				     struct dma_attrs *attrs)
 {
 	return (dma_addr_t)(ptr);
 }
@@ -90,14 +91,16 @@ static dma_addr_t ibmebus_map_single(struct device *dev,
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
@@ -112,7 +115,8 @@ static int ibmebus_map_sg(struct device *dev,
 
 static void ibmebus_unmap_sg(struct device *dev,
 			     struct scatterlist *sg,
-			     int nents, enum dma_data_direction direction)
+			     int nents, enum dma_data_direction direction,
+			     struct dma_attrs *attrs)
 {
 	return;
 }
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index ccf00fe..8c68ee9 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -269,7 +269,8 @@ static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 
 int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		 struct scatterlist *sglist, int nelems,
-		 unsigned long mask, enum dma_data_direction direction)
+		 unsigned long mask, enum dma_data_direction direction,
+		 struct dma_attrs *attrs)
 {
 	dma_addr_t dma_next = 0, dma_addr;
 	unsigned long flags;
@@ -411,7 +412,8 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 
 
 void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction)
+		int nelems, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
 	struct scatterlist *sg;
 	unsigned long flags;
@@ -553,7 +555,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
  */
 dma_addr_t iommu_map_single(struct device *dev, struct iommu_table *tbl,
 			    void *vaddr, size_t size, unsigned long mask,
-			    enum dma_data_direction direction)
+		enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	dma_addr_t dma_handle = DMA_ERROR_CODE;
 	unsigned long uaddr;
@@ -586,7 +588,8 @@ dma_addr_t iommu_map_single(struct device *dev, struct iommu_table *tbl,
 }
 
 void iommu_unmap_single(struct iommu_table *tbl, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction direction)
+		size_t size, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
 	unsigned int npages;
 
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index 11fa3c7..ab5d868 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -214,13 +214,13 @@ dma_addr_t iseries_hv_map(void *vaddr, size_t size,
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
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 43c493f..526cf14 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -550,7 +550,7 @@ static void ps3_free_coherent(struct device *_dev, size_t size, void *vaddr,
  */
 
 static dma_addr_t ps3_sb_map_single(struct device *_dev, void *ptr, size_t size,
-	enum dma_data_direction direction)
+	enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
@@ -570,7 +570,8 @@ static dma_addr_t ps3_sb_map_single(struct device *_dev, void *ptr, size_t size,
 
 static dma_addr_t ps3_ioc0_map_single(struct device *_dev, void *ptr,
 				      size_t size,
-				      enum dma_data_direction direction)
+				      enum dma_data_direction direction,
+				      struct dma_attrs *attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
@@ -603,7 +604,7 @@ static dma_addr_t ps3_ioc0_map_single(struct device *_dev, void *ptr,
 }
 
 static void ps3_unmap_single(struct device *_dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction)
+	size_t size, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
@@ -617,7 +618,7 @@ static void ps3_unmap_single(struct device *_dev, dma_addr_t dma_addr,
 }
 
 static int ps3_sb_map_sg(struct device *_dev, struct scatterlist *sgl,
-	int nents, enum dma_data_direction direction)
+	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 #if defined(CONFIG_PS3_DYNAMIC_DMA)
 	BUG_ON("do");
@@ -646,14 +647,15 @@ static int ps3_sb_map_sg(struct device *_dev, struct scatterlist *sgl,
 
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
@@ -661,7 +663,8 @@ static void ps3_sb_unmap_sg(struct device *_dev, struct scatterlist *sg,
 }
 
 static void ps3_ioc0_unmap_sg(struct device *_dev, struct scatterlist *sg,
-			    int nents, enum dma_data_direction direction)
+			    int nents, enum dma_data_direction direction,
+			    struct dma_attrs *attrs)
 {
 	BUG();
 }
diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index bbefb69..de13950 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
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
@@ -109,6 +114,77 @@ static inline int dma_set_mask(struct device *dev, u64 dma_mask)
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
@@ -131,63 +207,43 @@ static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
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
diff --git a/include/asm-powerpc/iommu.h b/include/asm-powerpc/iommu.h
index 65f6682..51ecfef 100644
--- a/include/asm-powerpc/iommu.h
+++ b/include/asm-powerpc/iommu.h
@@ -81,9 +81,11 @@ extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 
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
@@ -92,9 +94,11 @@ extern void iommu_free_coherent(struct iommu_table *tbl, size_t size,
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
1.5.4.3

-- 
