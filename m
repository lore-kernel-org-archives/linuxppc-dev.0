Return-Path: <beckyb@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 83FE7B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 02:17:20 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 552C0DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2009 02:17:19 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n7OGHEQp031369
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Aug 2009 11:17:15 -0500
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Change archdata dma_data type to dma_addr_t
Date: Mon, 24 Aug 2009 11:17:14 -0500
Message-Id: <1251130634-15093-1-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously, this was specified as a void *, but that's not
large enough on 32-bit systems with 36-bit physical
addressing support.  Change the type to dma_addr_t so it
will scale based on the size of a dma address.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/device.h        |    2 +-
 arch/powerpc/include/asm/dma-mapping.h   |    2 +-
 arch/powerpc/kernel/dma-iommu.c          |   21 +++++++++++++--------
 arch/powerpc/kernel/dma.c                |    6 +++---
 arch/powerpc/kernel/pci-common.c         |    2 +-
 arch/powerpc/kernel/vio.c                |    3 ++-
 arch/powerpc/platforms/cell/beat_iommu.c |    2 +-
 arch/powerpc/platforms/cell/iommu.c      |    6 +++---
 arch/powerpc/platforms/iseries/iommu.c   |    2 +-
 arch/powerpc/platforms/pasemi/iommu.c    |    2 +-
 arch/powerpc/platforms/pseries/iommu.c   |   11 +++++++----
 arch/powerpc/sysdev/dart_iommu.c         |    2 +-
 12 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 67fcd7f..07818ae 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -15,7 +15,7 @@ struct dev_archdata {
 
 	/* DMA operations on that device */
 	struct dma_map_ops	*dma_ops;
-	void			*dma_data;
+	dma_addr_t		dma_data;
 #ifdef CONFIG_SWIOTLB
 	dma_addr_t		max_direct_dma_addr;
 #endif
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index cb2ca41..cf65ebb 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -26,7 +26,7 @@ extern void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 extern void dma_direct_free_coherent(struct device *dev, size_t size,
 				     void *vaddr, dma_addr_t dma_handle);
 
-extern unsigned long get_dma_direct_offset(struct device *dev);
+extern dma_addr_t get_dma_direct_offset(struct device *dev);
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
 /*
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 87ddb3f..13eef19 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -11,6 +11,11 @@
  * Generic iommu implementation
  */
 
+static inline struct iommu_table *get_iommu_table_base(struct device *dev)
+{
+	return (struct iommu_table *)dev->archdata.dma_data;
+}
+
 /* Allocates a contiguous real buffer and creates mappings over it.
  * Returns the virtual address of the buffer and sets dma_handle
  * to the dma address (mapping) of the first page.
@@ -18,7 +23,7 @@
 static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
 				      dma_addr_t *dma_handle, gfp_t flag)
 {
-	return iommu_alloc_coherent(dev, dev->archdata.dma_data, size,
+	return iommu_alloc_coherent(dev, get_iommu_table_base(dev), size,
 				    dma_handle, device_to_mask(dev), flag,
 				    dev_to_node(dev));
 }
@@ -26,7 +31,7 @@ static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
 static void dma_iommu_free_coherent(struct device *dev, size_t size,
 				    void *vaddr, dma_addr_t dma_handle)
 {
-	iommu_free_coherent(dev->archdata.dma_data, size, vaddr, dma_handle);
+	iommu_free_coherent(get_iommu_table_base(dev), size, vaddr, dma_handle);
 }
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be
@@ -39,8 +44,8 @@ static dma_addr_t dma_iommu_map_page(struct device *dev, struct page *page,
 				     enum dma_data_direction direction,
 				     struct dma_attrs *attrs)
 {
-	return iommu_map_page(dev, dev->archdata.dma_data, page, offset, size,
-			      device_to_mask(dev), direction, attrs);
+	return iommu_map_page(dev, get_iommu_table_base(dev), page, offset,
+			      size, device_to_mask(dev), direction, attrs);
 }
 
 
@@ -48,7 +53,7 @@ static void dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
 				 size_t size, enum dma_data_direction direction,
 				 struct dma_attrs *attrs)
 {
-	iommu_unmap_page(dev->archdata.dma_data, dma_handle, size, direction,
+	iommu_unmap_page(get_iommu_table_base(dev), dma_handle, size, direction,
 			 attrs);
 }
 
@@ -57,7 +62,7 @@ static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
 			    struct dma_attrs *attrs)
 {
-	return iommu_map_sg(dev, dev->archdata.dma_data, sglist, nelems,
+	return iommu_map_sg(dev, get_iommu_table_base(dev), sglist, nelems,
 			    device_to_mask(dev), direction, attrs);
 }
 
@@ -65,14 +70,14 @@ static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		int nelems, enum dma_data_direction direction,
 		struct dma_attrs *attrs)
 {
-	iommu_unmap_sg(dev->archdata.dma_data, sglist, nelems, direction,
+	iommu_unmap_sg(get_iommu_table_base(dev), sglist, nelems, direction,
 		       attrs);
 }
 
 /* We support DMA to/from any memory page via the iommu */
 static int dma_iommu_dma_supported(struct device *dev, u64 mask)
 {
-	struct iommu_table *tbl = dev->archdata.dma_data;
+	struct iommu_table *tbl = get_iommu_table_base(dev);
 
 	if (!tbl || tbl->it_offset > mask) {
 		printk(KERN_INFO
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 21b784d..f69825f 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -17,14 +17,14 @@
  *
  * This implementation supports a per-device offset that can be applied if
  * the address at which memory is visible to devices is not 0. Platform code
- * can set archdata.dma_data to an unsigned long holding the offset. By
+ * can set archdata.dma_data to a dma_addr_t holding the offset. By
  * default the offset is PCI_DRAM_OFFSET.
  */
 
-unsigned long get_dma_direct_offset(struct device *dev)
+dma_addr_t get_dma_direct_offset(struct device *dev)
 {
 	if (dev)
-		return (unsigned long)dev->archdata.dma_data;
+		return dev->archdata.dma_data;
 
 	return PCI_DRAM_OFFSET;
 }
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7585f1f..ecbfc5d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1125,7 +1125,7 @@ void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
 
 		/* Hook up default DMA ops */
 		sd->dma_ops = pci_dma_ops;
-		sd->dma_data = (void *)PCI_DRAM_OFFSET;
+		sd->dma_data = PCI_DRAM_OFFSET;
 
 		/* Additional platform DMA/iommu setup */
 		if (ppc_md.pci_dma_dev_setup)
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index bc7b41e..24d8d38 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1233,7 +1233,8 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 		vio_cmo_set_dma_ops(viodev);
 	else
 		viodev->dev.archdata.dma_ops = &dma_iommu_ops;
-	viodev->dev.archdata.dma_data = vio_build_iommu_table(viodev);
+	viodev->dev.archdata.dma_data =
+		(dma_addr_t)vio_build_iommu_table(viodev);
 	set_dev_node(&viodev->dev, of_node_to_nid(of_node));
 
 	/* init generic 'struct device' fields: */
diff --git a/arch/powerpc/platforms/cell/beat_iommu.c b/arch/powerpc/platforms/cell/beat_iommu.c
index 93b0efd..6276171 100644
--- a/arch/powerpc/platforms/cell/beat_iommu.c
+++ b/arch/powerpc/platforms/cell/beat_iommu.c
@@ -77,7 +77,7 @@ static void __init celleb_init_direct_mapping(void)
 static void celleb_dma_dev_setup(struct device *dev)
 {
 	dev->archdata.dma_ops = get_pci_dma_ops();
-	dev->archdata.dma_data = (void *)celleb_dma_direct_offset;
+	dev->archdata.dma_data = celleb_dma_direct_offset;
 }
 
 static void celleb_pci_dma_dev_setup(struct pci_dev *pdev)
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 416db17..26f94a6 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -663,9 +663,9 @@ static void cell_dma_dev_setup(struct device *dev)
 	if (get_dma_ops(dev) == &dma_iommu_fixed_ops)
 		cell_dma_dev_setup_fixed(dev);
 	else if (get_pci_dma_ops() == &dma_iommu_ops)
-		archdata->dma_data = cell_get_iommu_table(dev);
+		archdata->dma_data = (dma_addr_t)cell_get_iommu_table(dev);
 	else if (get_pci_dma_ops() == &dma_direct_ops)
-		archdata->dma_data = (void *)cell_dma_direct_offset;
+		archdata->dma_data = cell_dma_direct_offset;
 	else
 		BUG();
 }
@@ -977,7 +977,7 @@ static void cell_dma_dev_setup_fixed(struct device *dev)
 	u64 addr;
 
 	addr = cell_iommu_get_fixed_address(dev) + dma_iommu_fixed_base;
-	archdata->dma_data = (void *)addr;
+	archdata->dma_data = addr;
 
 	dev_dbg(dev, "iommu: fixed addr = %llx\n", addr);
 }
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index 6c1e101..122c2ef 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -193,7 +193,7 @@ static void pci_dma_dev_setup_iseries(struct pci_dev *pdev)
 		pdn->iommu_table = iommu_init_table(tbl, -1);
 	else
 		kfree(tbl);
-	pdev->dev.archdata.dma_data = pdn->iommu_table;
+	pdev->dev.archdata.dma_data = (dma_addr_t)pdn->iommu_table;
 }
 #else
 #define pci_dma_dev_setup_iseries	NULL
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index a0ff03a..91f77b3 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -189,7 +189,7 @@ static void pci_dma_dev_setup_pasemi(struct pci_dev *dev)
 	}
 #endif
 
-	dev->dev.archdata.dma_data = &iommu_table_iobmap;
+	dev->dev.archdata.dma_data = (dma_addr_t)&iommu_table_iobmap;
 }
 
 static void pci_dma_bus_setup_null(struct pci_bus *b) { }
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 661c8e0..ac8e5c8 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -482,7 +482,8 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 				   phb->node);
 		iommu_table_setparms(phb, dn, tbl);
 		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
-		dev->dev.archdata.dma_data = PCI_DN(dn)->iommu_table;
+		dev->dev.archdata.dma_data =
+			(dma_addr_t)PCI_DN(dn)->iommu_table;
 		return;
 	}
 
@@ -494,7 +495,8 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		dn = dn->parent;
 
 	if (dn && PCI_DN(dn))
-		dev->dev.archdata.dma_data = PCI_DN(dn)->iommu_table;
+		dev->dev.archdata.dma_data =
+			(dma_addr_t)PCI_DN(dn)->iommu_table;
 	else
 		printk(KERN_WARNING "iommu: Device %s has no iommu table\n",
 		       pci_name(dev));
@@ -538,7 +540,8 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	 */
 	if (dma_window == NULL || pdn->parent == NULL) {
 		pr_debug("  no dma window for device, linking to parent\n");
-		dev->dev.archdata.dma_data = PCI_DN(pdn)->iommu_table;
+		dev->dev.archdata.dma_data =
+			(dma_addr_t)PCI_DN(pdn)->iommu_table;
 		return;
 	}
 
@@ -554,7 +557,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 		pr_debug("  found DMA window, table: %p\n", pci->iommu_table);
 	}
 
-	dev->dev.archdata.dma_data = pci->iommu_table;
+	dev->dev.archdata.dma_data = (dma_addr_t)pci->iommu_table;
 }
 #else  /* CONFIG_PCI */
 #define pci_dma_bus_setup_pSeries	NULL
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 89639ec..da74d27 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -297,7 +297,7 @@ static void pci_dma_dev_setup_dart(struct pci_dev *dev)
 	/* We only have one iommu table on the mac for now, which makes
 	 * things simple. Setup all PCI devices to point to this table
 	 */
-	dev->dev.archdata.dma_data = &iommu_table_dart;
+	dev->dev.archdata.dma_data = (dma_addr_t)&iommu_table_dart;
 }
 
 static void pci_dma_bus_setup_dart(struct pci_bus *bus)
-- 
1.6.0.6
