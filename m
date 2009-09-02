Return-Path: <beckyb@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 66EA2B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 08:23:26 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7106EDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Sep 2009 08:23:25 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n82MNLJL004265
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Sep 2009 17:23:22 -0500
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Change archdata dma_data to a union
Date: Wed,  2 Sep 2009 17:23:20 -0500
Message-Id: <1251930200-4796-2-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1251930200-4796-1-git-send-email-beckyb@kernel.crashing.org>
References: <1251930200-4796-1-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sometimes this is used to hold a simple offset, and sometimes
it is used to hold a pointer.  This patch changes it to a union containing
void * and dma_addr_t.  get/set accessors are also provided, because it was
getting a bit ugly to get to the actual data.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/device.h        |   11 ++++++++++-
 arch/powerpc/include/asm/dma-mapping.h   |   10 ++++++++--
 arch/powerpc/include/asm/iommu.h         |   10 ++++++++++
 arch/powerpc/kernel/dma-iommu.c          |   16 ++++++++--------
 arch/powerpc/kernel/pci-common.c         |    2 +-
 arch/powerpc/kernel/vio.c                |    2 +-
 arch/powerpc/platforms/cell/beat_iommu.c |    2 +-
 arch/powerpc/platforms/cell/iommu.c      |    9 +++------
 arch/powerpc/platforms/iseries/iommu.c   |    2 +-
 arch/powerpc/platforms/pasemi/iommu.c    |    2 +-
 arch/powerpc/platforms/pseries/iommu.c   |    8 ++++----
 arch/powerpc/sysdev/dart_iommu.c         |    2 +-
 12 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 67fcd7f..07ca8b5 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -15,7 +15,16 @@ struct dev_archdata {
 
 	/* DMA operations on that device */
 	struct dma_map_ops	*dma_ops;
-	void			*dma_data;
+
+	/*
+	 * When an iommu is in use, dma_data is used as a ptr to the base of the
+	 * iommu_table.  Otherwise, it is a simple numerical offset.
+	 */
+	union {
+		dma_addr_t	dma_offset;
+		void		*iommu_table_base;
+	} dma_data;
+
 #ifdef CONFIG_SWIOTLB
 	dma_addr_t		max_direct_dma_addr;
 #endif
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index eef4db1..e9f4fe9 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -89,14 +89,20 @@ static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
 	dev->archdata.dma_ops = ops;
 }
 
-static inline unsigned long get_dma_offset(struct device *dev)
+static inline dma_addr_t get_dma_offset(struct device *dev)
 {
 	if (dev)
-		return (unsigned long)dev->archdata.dma_data;
+		return dev->archdata.dma_data.dma_offset;
 
 	return PCI_DRAM_OFFSET;
 }
 
+static inline void set_dma_offset(struct device *dev, dma_addr_t off)
+{
+	if (dev)
+		dev->archdata.dma_data.dma_offset = off;
+}
+
 /* this will be removed soon */
 #define flush_write_buffers()
 
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 7464c0d..edfc980 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -70,6 +70,16 @@ struct iommu_table {
 
 struct scatterlist;
 
+static inline void set_iommu_table_base(struct device *dev, void *base)
+{
+	dev->archdata.dma_data.iommu_table_base = base;
+}
+
+static inline void *get_iommu_table_base(struct device *dev)
+{
+	return dev->archdata.dma_data.iommu_table_base;
+}
+
 /* Frees table for an individual device node */
 extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
 
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 87ddb3f..37771a5 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -18,7 +18,7 @@
 static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
 				      dma_addr_t *dma_handle, gfp_t flag)
 {
-	return iommu_alloc_coherent(dev, dev->archdata.dma_data, size,
+	return iommu_alloc_coherent(dev, get_iommu_table_base(dev), size,
 				    dma_handle, device_to_mask(dev), flag,
 				    dev_to_node(dev));
 }
@@ -26,7 +26,7 @@ static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
 static void dma_iommu_free_coherent(struct device *dev, size_t size,
 				    void *vaddr, dma_addr_t dma_handle)
 {
-	iommu_free_coherent(dev->archdata.dma_data, size, vaddr, dma_handle);
+	iommu_free_coherent(get_iommu_table_base(dev), size, vaddr, dma_handle);
 }
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be
@@ -39,8 +39,8 @@ static dma_addr_t dma_iommu_map_page(struct device *dev, struct page *page,
 				     enum dma_data_direction direction,
 				     struct dma_attrs *attrs)
 {
-	return iommu_map_page(dev, dev->archdata.dma_data, page, offset, size,
-			      device_to_mask(dev), direction, attrs);
+	return iommu_map_page(dev, get_iommu_table_base(dev), page, offset,
+			      size, device_to_mask(dev), direction, attrs);
 }
 
 
@@ -48,7 +48,7 @@ static void dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
 				 size_t size, enum dma_data_direction direction,
 				 struct dma_attrs *attrs)
 {
-	iommu_unmap_page(dev->archdata.dma_data, dma_handle, size, direction,
+	iommu_unmap_page(get_iommu_table_base(dev), dma_handle, size, direction,
 			 attrs);
 }
 
@@ -57,7 +57,7 @@ static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
 			    struct dma_attrs *attrs)
 {
-	return iommu_map_sg(dev, dev->archdata.dma_data, sglist, nelems,
+	return iommu_map_sg(dev, get_iommu_table_base(dev), sglist, nelems,
 			    device_to_mask(dev), direction, attrs);
 }
 
@@ -65,14 +65,14 @@ static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
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
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index e9f4840..bb8209e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1117,7 +1117,7 @@ void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
 
 		/* Hook up default DMA ops */
 		sd->dma_ops = pci_dma_ops;
-		sd->dma_data = (void *)PCI_DRAM_OFFSET;
+		set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
 
 		/* Additional platform DMA/iommu setup */
 		if (ppc_md.pci_dma_dev_setup)
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index bc7b41e..8d9275f 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1233,7 +1233,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 		vio_cmo_set_dma_ops(viodev);
 	else
 		viodev->dev.archdata.dma_ops = &dma_iommu_ops;
-	viodev->dev.archdata.dma_data = vio_build_iommu_table(viodev);
+	set_iommu_table_base(&viodev->dev, vio_build_iommu_table(viodev));
 	set_dev_node(&viodev->dev, of_node_to_nid(of_node));
 
 	/* init generic 'struct device' fields: */
diff --git a/arch/powerpc/platforms/cell/beat_iommu.c b/arch/powerpc/platforms/cell/beat_iommu.c
index 93b0efd..39d361c 100644
--- a/arch/powerpc/platforms/cell/beat_iommu.c
+++ b/arch/powerpc/platforms/cell/beat_iommu.c
@@ -77,7 +77,7 @@ static void __init celleb_init_direct_mapping(void)
 static void celleb_dma_dev_setup(struct device *dev)
 {
 	dev->archdata.dma_ops = get_pci_dma_ops();
-	dev->archdata.dma_data = (void *)celleb_dma_direct_offset;
+	set_dma_offset(dev, celleb_dma_direct_offset);
 }
 
 static void celleb_pci_dma_dev_setup(struct pci_dev *pdev)
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 416db17..ca5bfdf 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -657,15 +657,13 @@ static void cell_dma_dev_setup_fixed(struct device *dev);
 
 static void cell_dma_dev_setup(struct device *dev)
 {
-	struct dev_archdata *archdata = &dev->archdata;
-
 	/* Order is important here, these are not mutually exclusive */
 	if (get_dma_ops(dev) == &dma_iommu_fixed_ops)
 		cell_dma_dev_setup_fixed(dev);
 	else if (get_pci_dma_ops() == &dma_iommu_ops)
-		archdata->dma_data = cell_get_iommu_table(dev);
+		set_iommu_table_base(dev, cell_get_iommu_table(dev));
 	else if (get_pci_dma_ops() == &dma_direct_ops)
-		archdata->dma_data = (void *)cell_dma_direct_offset;
+		set_dma_offset(dev, cell_dma_direct_offset);
 	else
 		BUG();
 }
@@ -973,11 +971,10 @@ static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
 
 static void cell_dma_dev_setup_fixed(struct device *dev)
 {
-	struct dev_archdata *archdata = &dev->archdata;
 	u64 addr;
 
 	addr = cell_iommu_get_fixed_address(dev) + dma_iommu_fixed_base;
-	archdata->dma_data = (void *)addr;
+	set_dma_offset(dev, addr);
 
 	dev_dbg(dev, "iommu: fixed addr = %llx\n", addr);
 }
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index 6c1e101..9d53cb4 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -193,7 +193,7 @@ static void pci_dma_dev_setup_iseries(struct pci_dev *pdev)
 		pdn->iommu_table = iommu_init_table(tbl, -1);
 	else
 		kfree(tbl);
-	pdev->dev.archdata.dma_data = pdn->iommu_table;
+	set_iommu_table_base(&pdev->dev, pdn->iommu_table);
 }
 #else
 #define pci_dma_dev_setup_iseries	NULL
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index a0ff03a..7b1d608 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -189,7 +189,7 @@ static void pci_dma_dev_setup_pasemi(struct pci_dev *dev)
 	}
 #endif
 
-	dev->dev.archdata.dma_data = &iommu_table_iobmap;
+	set_iommu_table_base(&dev->dev, &iommu_table_iobmap);
 }
 
 static void pci_dma_bus_setup_null(struct pci_bus *b) { }
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 661c8e0..1a0000a 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -482,7 +482,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 				   phb->node);
 		iommu_table_setparms(phb, dn, tbl);
 		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
-		dev->dev.archdata.dma_data = PCI_DN(dn)->iommu_table;
+		set_iommu_table_base(&dev->dev, PCI_DN(dn)->iommu_table);
 		return;
 	}
 
@@ -494,7 +494,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		dn = dn->parent;
 
 	if (dn && PCI_DN(dn))
-		dev->dev.archdata.dma_data = PCI_DN(dn)->iommu_table;
+		set_iommu_table_base(&dev->dev, PCI_DN(dn)->iommu_table);
 	else
 		printk(KERN_WARNING "iommu: Device %s has no iommu table\n",
 		       pci_name(dev));
@@ -538,7 +538,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	 */
 	if (dma_window == NULL || pdn->parent == NULL) {
 		pr_debug("  no dma window for device, linking to parent\n");
-		dev->dev.archdata.dma_data = PCI_DN(pdn)->iommu_table;
+		set_iommu_table_base(&dev->dev, PCI_DN(pdn)->iommu_table);
 		return;
 	}
 
@@ -554,7 +554,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 		pr_debug("  found DMA window, table: %p\n", pci->iommu_table);
 	}
 
-	dev->dev.archdata.dma_data = pci->iommu_table;
+	set_iommu_table_base(&dev->dev, pci->iommu_table);
 }
 #else  /* CONFIG_PCI */
 #define pci_dma_bus_setup_pSeries	NULL
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 89639ec..ae3c4db 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -297,7 +297,7 @@ static void pci_dma_dev_setup_dart(struct pci_dev *dev)
 	/* We only have one iommu table on the mac for now, which makes
 	 * things simple. Setup all PCI devices to point to this table
 	 */
-	dev->dev.archdata.dma_data = &iommu_table_dart;
+	set_iommu_table_base(&dev->dev, &iommu_table_dart);
 }
 
 static void pci_dma_bus_setup_dart(struct pci_bus *bus)
-- 
1.6.0.6
