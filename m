Return-Path: <bgill@blarg.am.freescale.net>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3A14EDDDD4
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 05:10:04 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m88J9vYo010692
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 12:09:57 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	m88J9u2t009900
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 14:09:57 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] POWERPC: Move iommu dma ops from dma.c to dma-iommu.c
Date: Mon,  8 Sep 2008 14:09:53 -0500
Message-Id: <1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
In-Reply-To: <1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

32-bit platforms are about to start using dma.c; move the iommu
dma ops into their own file to make this a bit cleaner.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/kernel/Makefile    |    2 +-
 arch/powerpc/kernel/dma-iommu.c |  103 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/dma.c       |   98 +------------------------------------
 3 files changed, 105 insertions(+), 98 deletions(-)
 create mode 100644 arch/powerpc/kernel/dma-iommu.c

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index a8a6724..45570fe 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -71,7 +71,7 @@ obj-y				+= time.o prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o \
 				   misc_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
-obj-$(CONFIG_PPC64)		+= dma.o iommu.o
+obj-$(CONFIG_PPC64)		+= dma.o dma-iommu.o iommu.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
new file mode 100644
index 0000000..01091f1
--- /dev/null
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -0,0 +1,103 @@
+/*
+ * Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corporation
+ *
+ * Provide default implementations of the DMA mapping callbacks for
+ * busses using the iommu infrastructure
+ */
+
+#include <asm/iommu.h>
+
+/*
+ * Generic iommu implementation
+ */
+
+/* Allocates a contiguous real buffer and creates mappings over it.
+ * Returns the virtual address of the buffer and sets dma_handle
+ * to the dma address (mapping) of the first page.
+ */
+static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
+				      dma_addr_t *dma_handle, gfp_t flag)
+{
+	return iommu_alloc_coherent(dev, dev->archdata.dma_data, size,
+				    dma_handle, device_to_mask(dev), flag,
+				    dev->archdata.numa_node);
+}
+
+static void dma_iommu_free_coherent(struct device *dev, size_t size,
+				    void *vaddr, dma_addr_t dma_handle)
+{
+	iommu_free_coherent(dev->archdata.dma_data, size, vaddr, dma_handle);
+}
+
+/* Creates TCEs for a user provided buffer.  The user buffer must be
+ * contiguous real kernel storage (not vmalloc).  The address of the buffer
+ * passed here is the kernel (virtual) address of the buffer.  The buffer
+ * need not be page aligned, the dma_addr_t returned will point to the same
+ * byte within the page as vaddr.
+ */
+static dma_addr_t dma_iommu_map_single(struct device *dev, void *vaddr,
+				       size_t size,
+				       enum dma_data_direction direction,
+				       struct dma_attrs *attrs)
+{
+	return iommu_map_single(dev, dev->archdata.dma_data, vaddr, size,
+				device_to_mask(dev), direction, attrs);
+}
+
+
+static void dma_iommu_unmap_single(struct device *dev, dma_addr_t dma_handle,
+				   size_t size,
+				   enum dma_data_direction direction,
+				   struct dma_attrs *attrs)
+{
+	iommu_unmap_single(dev->archdata.dma_data, dma_handle, size, direction,
+			   attrs);
+}
+
+
+static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
+			    int nelems, enum dma_data_direction direction,
+			    struct dma_attrs *attrs)
+{
+	return iommu_map_sg(dev, dev->archdata.dma_data, sglist, nelems,
+			    device_to_mask(dev), direction, attrs);
+}
+
+static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
+		int nelems, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
+{
+	iommu_unmap_sg(dev->archdata.dma_data, sglist, nelems, direction,
+		       attrs);
+}
+
+/* We support DMA to/from any memory page via the iommu */
+static int dma_iommu_dma_supported(struct device *dev, u64 mask)
+{
+	struct iommu_table *tbl = dev->archdata.dma_data;
+
+	if (!tbl || tbl->it_offset > mask) {
+		printk(KERN_INFO
+		       "Warning: IOMMU offset too big for device mask\n");
+		if (tbl)
+			printk(KERN_INFO
+			       "mask: 0x%08lx, table offset: 0x%08lx\n",
+				mask, tbl->it_offset);
+		else
+			printk(KERN_INFO "mask: 0x%08lx, table unavailable\n",
+				mask);
+		return 0;
+	} else
+		return 1;
+}
+
+struct dma_mapping_ops dma_iommu_ops = {
+	.alloc_coherent	= dma_iommu_alloc_coherent,
+	.free_coherent	= dma_iommu_free_coherent,
+	.map_single	= dma_iommu_map_single,
+	.unmap_single	= dma_iommu_unmap_single,
+	.map_sg		= dma_iommu_map_sg,
+	.unmap_sg	= dma_iommu_unmap_sg,
+	.dma_supported	= dma_iommu_dma_supported,
+};
+EXPORT_SYMBOL(dma_iommu_ops);
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index ae5708e..44e3486 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -2,111 +2,15 @@
  * Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corporation
  *
  * Provide default implementations of the DMA mapping callbacks for
- * directly mapped busses and busses using the iommu infrastructure
+ * directly mapped busses.
  */
 
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <asm/bug.h>
-#include <asm/iommu.h>
 #include <asm/abs_addr.h>
 
 /*
- * Generic iommu implementation
- */
-
-/* Allocates a contiguous real buffer and creates mappings over it.
- * Returns the virtual address of the buffer and sets dma_handle
- * to the dma address (mapping) of the first page.
- */
-static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
-				      dma_addr_t *dma_handle, gfp_t flag)
-{
-	return iommu_alloc_coherent(dev, dev->archdata.dma_data, size,
-				    dma_handle, device_to_mask(dev), flag,
-				    dev->archdata.numa_node);
-}
-
-static void dma_iommu_free_coherent(struct device *dev, size_t size,
-				    void *vaddr, dma_addr_t dma_handle)
-{
-	iommu_free_coherent(dev->archdata.dma_data, size, vaddr, dma_handle);
-}
-
-/* Creates TCEs for a user provided buffer.  The user buffer must be
- * contiguous real kernel storage (not vmalloc).  The address of the buffer
- * passed here is the kernel (virtual) address of the buffer.  The buffer
- * need not be page aligned, the dma_addr_t returned will point to the same
- * byte within the page as vaddr.
- */
-static dma_addr_t dma_iommu_map_single(struct device *dev, void *vaddr,
-				       size_t size,
-				       enum dma_data_direction direction,
-				       struct dma_attrs *attrs)
-{
-	return iommu_map_single(dev, dev->archdata.dma_data, vaddr, size,
-				device_to_mask(dev), direction, attrs);
-}
-
-
-static void dma_iommu_unmap_single(struct device *dev, dma_addr_t dma_handle,
-				   size_t size,
-				   enum dma_data_direction direction,
-				   struct dma_attrs *attrs)
-{
-	iommu_unmap_single(dev->archdata.dma_data, dma_handle, size, direction,
-			   attrs);
-}
-
-
-static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
-			    int nelems, enum dma_data_direction direction,
-			    struct dma_attrs *attrs)
-{
-	return iommu_map_sg(dev, dev->archdata.dma_data, sglist, nelems,
-			    device_to_mask(dev), direction, attrs);
-}
-
-static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
-{
-	iommu_unmap_sg(dev->archdata.dma_data, sglist, nelems, direction,
-		       attrs);
-}
-
-/* We support DMA to/from any memory page via the iommu */
-static int dma_iommu_dma_supported(struct device *dev, u64 mask)
-{
-	struct iommu_table *tbl = dev->archdata.dma_data;
-
-	if (!tbl || tbl->it_offset > mask) {
-		printk(KERN_INFO
-		       "Warning: IOMMU offset too big for device mask\n");
-		if (tbl)
-			printk(KERN_INFO
-			       "mask: 0x%08lx, table offset: 0x%08lx\n",
-				mask, tbl->it_offset);
-		else
-			printk(KERN_INFO "mask: 0x%08lx, table unavailable\n",
-				mask);
-		return 0;
-	} else
-		return 1;
-}
-
-struct dma_mapping_ops dma_iommu_ops = {
-	.alloc_coherent	= dma_iommu_alloc_coherent,
-	.free_coherent	= dma_iommu_free_coherent,
-	.map_single	= dma_iommu_map_single,
-	.unmap_single	= dma_iommu_unmap_single,
-	.map_sg		= dma_iommu_map_sg,
-	.unmap_sg	= dma_iommu_unmap_sg,
-	.dma_supported	= dma_iommu_dma_supported,
-};
-EXPORT_SYMBOL(dma_iommu_ops);
-
-/*
  * Generic direct DMA implementation
  *
  * This implementation supports a per-device offset that can be applied if
-- 
1.5.5.1
