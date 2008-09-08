Return-Path: <bgill@blarg.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5670FDDF4C
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 05:10:05 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m88J9u25002770
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 12:09:59 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	m88J9u8V020115
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 14:09:57 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] POWERPC: Drop archdata numa_node
Date: Mon,  8 Sep 2008 14:09:54 -0500
Message-Id: <1220900995-11928-4-git-send-email-becky.bruce@freescale.com>
In-Reply-To: <1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use the struct device's numa_node instead; use accessor functions
to get/set numa_node.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
64-bit folks: Please test when you get a moment.  I've build-tested this,
but I do not have the ability to actually boot it on anything.  Yes, I know
this fundamentally doesn't have much relation to the dma merge, except that
doing this saves me some ifdeffing in the code in a later patch.  Also,
since I've renamed dma_64.c to dma.c, I wanted to do this after the rename
so it's easier to see the history in git.

Thanks!
-Becky

 arch/powerpc/include/asm/device.h       |    3 ---
 arch/powerpc/kernel/dma-iommu.c         |    2 +-
 arch/powerpc/kernel/dma.c               |    2 +-
 arch/powerpc/kernel/of_device.c         |    2 +-
 arch/powerpc/kernel/pci_64.c            |    7 ++-----
 arch/powerpc/kernel/vio.c               |    2 +-
 arch/powerpc/platforms/cell/iommu.c     |    6 +++---
 arch/powerpc/platforms/ps3/system-bus.c |    2 +-
 8 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 228ab2a..dfd504c 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -16,9 +16,6 @@ struct dev_archdata {
 	/* DMA operations on that device */
 	struct dma_mapping_ops	*dma_ops;
 	void			*dma_data;
-
-	/* NUMA node if applicable */
-	int			numa_node;
 };
 
 #endif /* _ASM_POWERPC_DEVICE_H */
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 01091f1..49248f8 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -20,7 +20,7 @@ static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
 {
 	return iommu_alloc_coherent(dev, dev->archdata.dma_data, size,
 				    dma_handle, device_to_mask(dev), flag,
-				    dev->archdata.numa_node);
+				    dev_to_node(dev));
 }
 
 static void dma_iommu_free_coherent(struct device *dev, size_t size,
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 44e3486..124f867 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -29,7 +29,7 @@ static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 {
 	struct page *page;
 	void *ret;
-	int node = dev->archdata.numa_node;
+	int node = dev_to_node(dev);
 
 	page = alloc_pages_node(node, flag, get_order(size));
 	if (page == NULL)
diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index e9be908..93ae5b1 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -78,7 +78,7 @@ struct of_device *of_device_alloc(struct device_node *np,
 	dev->dev.parent = parent;
 	dev->dev.release = of_release_dev;
 	dev->dev.archdata.of_node = np;
-	dev->dev.archdata.numa_node = of_node_to_nid(np);
+	set_dev_node(&dev->dev, of_node_to_nid(np));
 
 	if (bus_id)
 		strlcpy(dev->dev.bus_id, bus_id, BUS_ID_SIZE);
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 30eedfc..1f75bf0 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -558,11 +558,8 @@ void __devinit pcibios_setup_new_device(struct pci_dev *dev)
 	    sd->of_node ? sd->of_node->full_name : "<none>");
 
 	sd->dma_ops = pci_dma_ops;
-#ifdef CONFIG_NUMA
-	sd->numa_node = pcibus_to_node(dev->bus);
-#else
-	sd->numa_node = -1;
-#endif
+	set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
+
 	if (ppc_md.pci_dma_dev_setup)
 		ppc_md.pci_dma_dev_setup(dev);
 }
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 2750fba..434c92a 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1232,7 +1232,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	else
 		viodev->dev.archdata.dma_ops = &dma_iommu_ops;
 	viodev->dev.archdata.dma_data = vio_build_iommu_table(viodev);
-	viodev->dev.archdata.numa_node = of_node_to_nid(of_node);
+	set_dev_node(&viodev->dev, of_node_to_nid(of_node));
 
 	/* init generic 'struct device' fields: */
 	viodev->dev.parent = &vio_bus_device.dev;
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index e06420a..ef92e71 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -556,11 +556,11 @@ static struct iommu_table *cell_get_iommu_table(struct device *dev)
 	 * node's iommu. We -might- do something smarter later though it may
 	 * never be necessary
 	 */
-	iommu = cell_iommu_for_node(archdata->numa_node);
+	iommu = cell_iommu_for_node(dev_to_node(dev));
 	if (iommu == NULL || list_empty(&iommu->windows)) {
 		printk(KERN_ERR "iommu: missing iommu for %s (node %d)\n",
 		       archdata->of_node ? archdata->of_node->full_name : "?",
-		       archdata->numa_node);
+		       dev_to_node(dev));
 		return NULL;
 	}
 	window = list_entry(iommu->windows.next, struct iommu_window, list);
@@ -577,7 +577,7 @@ static void *dma_fixed_alloc_coherent(struct device *dev, size_t size,
 		return iommu_alloc_coherent(dev, cell_get_iommu_table(dev),
 					    size, dma_handle,
 					    device_to_mask(dev), flag,
-					    dev->archdata.numa_node);
+					    dev_to_node(dev));
 	else
 		return dma_direct_ops.alloc_coherent(dev, size, dma_handle,
 						     flag);
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 280ee88..a789bf5 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -762,7 +762,7 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
 	};
 
 	dev->core.archdata.of_node = NULL;
-	dev->core.archdata.numa_node = 0;
+	set_dev_node(&dev->core, 0);
 
 	pr_debug("%s:%d add %s\n", __func__, __LINE__, dev->core.bus_id);
 
-- 
1.5.5.1
