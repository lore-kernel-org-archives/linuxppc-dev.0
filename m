Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93D7EB7137
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 15:24:21 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o7V5OGUp002236
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2010 00:24:17 -0500
Subject: [PATCH 2/2] powerpc/dart_iommu: Support for 64-bit iommu bypass
	window on PCIe
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 Aug 2010 15:24:18 +1000
Message-ID: <1283232258.2151.13.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PCI-Express bus off the U4/CPC945 bridge supports direct DMA to
all of memory, bypassing the DART iommu, for 64-bit capable devices.

This adds support for it on Bimini and Apple Quad G5's in order to
improve DMA performances of cards using that slot (the x16 graphics
slot). Tested with an Intel ixgbe 10GE card.
---
 arch/powerpc/sysdev/dart_iommu.c |   74 ++++++++++++++++++++++++++++++++-----
 1 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 559db2b..17cf15e 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -70,6 +70,8 @@ static int iommu_table_dart_inited;
 static int dart_dirty;
 static int dart_is_u4;
 
+#define DART_U4_BYPASS_BASE	0x8000000000ull
+
 #define DBG(...)
 
 static inline void dart_tlb_invalidate_all(void)
@@ -292,12 +294,20 @@ static void iommu_table_dart_setup(void)
 	set_bit(iommu_table_dart.it_size - 1, iommu_table_dart.it_map);
 }
 
-static void pci_dma_dev_setup_dart(struct pci_dev *dev)
+static void dma_dev_setup_dart(struct device *dev)
 {
 	/* We only have one iommu table on the mac for now, which makes
 	 * things simple. Setup all PCI devices to point to this table
 	 */
-	set_iommu_table_base(&dev->dev, &iommu_table_dart);
+	if (get_dma_ops(dev) == &dma_direct_ops)
+		set_dma_offset(dev, DART_U4_BYPASS_BASE);
+	else
+		set_iommu_table_base(dev, &iommu_table_dart);
+}
+
+static void pci_dma_dev_setup_dart(struct pci_dev *dev)
+{
+	dma_dev_setup_dart(&dev->dev);
 }
 
 static void pci_dma_bus_setup_dart(struct pci_bus *bus)
@@ -315,6 +325,45 @@ static void pci_dma_bus_setup_dart(struct pci_bus *bus)
 		PCI_DN(dn)->iommu_table = &iommu_table_dart;
 }
 
+static bool dart_device_on_pcie(struct device *dev)
+{
+	struct device_node *np = of_node_get(dev->of_node);
+
+	while(np) {
+		if (of_device_is_compatible(np, "U4-pcie") ||
+		    of_device_is_compatible(np, "u4-pcie")) {
+			of_node_put(np);
+			return true;
+		}
+		np = of_get_next_parent(np);
+	}
+	return false;
+}
+
+static int dart_dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
+		return -EIO;
+
+	/* U4 supports a DART bypass, we use it for 64-bit capable
+	 * devices to improve performances. However, that only works
+	 * for devices connected to U4 own PCIe interface, not bridged
+	 * through hypertransport. We need the device to support at
+	 * least 40 bits of addresses.
+	 */
+	if (dart_device_on_pcie(dev) && dma_mask >= DMA_BIT_MASK(40)) {
+		dev_info(dev, "Using 64-bit DMA iommu bypass\n");
+		set_dma_ops(dev, &dma_direct_ops);
+	} else {
+		dev_info(dev, "Using 32-bit DMA via iommu\n");
+		set_dma_ops(dev, &dma_iommu_ops);
+	}
+	dma_dev_setup_dart(dev);
+
+	*dev->dma_mask = dma_mask;
+	return 0;
+}
+
 void __init iommu_init_early_dart(void)
 {
 	struct device_node *dn;
@@ -328,20 +377,25 @@ void __init iommu_init_early_dart(void)
 		dart_is_u4 = 1;
 	}
 
+	/* Initialize the DART HW */
+	if (dart_init(dn) != 0)
+		goto bail;
+
 	/* Setup low level TCE operations for the core IOMMU code */
 	ppc_md.tce_build = dart_build;
 	ppc_md.tce_free  = dart_free;
 	ppc_md.tce_flush = dart_flush;
 
-	/* Initialize the DART HW */
-	if (dart_init(dn) == 0) {
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_dart;
-		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_dart;
+	/* Setup bypass if supported */
+	if (dart_is_u4)
+		ppc_md.dma_set_mask = dart_dma_set_mask;
 
-		/* Setup pci_dma ops */
-		set_pci_dma_ops(&dma_iommu_ops);
-		return;
-	}
+	ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_dart;
+	ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_dart;
+
+	/* Setup pci_dma ops */
+	set_pci_dma_ops(&dma_iommu_ops);
+	return;
 
  bail:
 	/* If init failed, use direct iommu and null setup functions */
