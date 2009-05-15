Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87B96DE0AA
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 22:47:39 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/pci: clean up direct access to sysdata by iseries
	platform
Date: Fri, 15 May 2009 07:47:20 -0500
Message-Id: <1242391640-18826-1-git-send-email-galak@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We shouldn't directly access sysdata to get the device node.  We should
be calling pci_device_to_OF_node().

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* Updated based on sfr's iseries pci fix patch

 arch/powerpc/platforms/iseries/iommu.c |    2 +-
 arch/powerpc/platforms/iseries/pci.c   |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index 4021982..224913a 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -177,7 +177,7 @@ static struct iommu_table *iommu_table_find(struct iommu_table * tbl)
 static void pci_dma_dev_setup_iseries(struct pci_dev *pdev)
 {
 	struct iommu_table *tbl;
-	struct device_node *dn = pdev->sysdata;
+	struct device_node *dn = pci_device_to_OF_node(dev);
 	struct pci_dn *pdn = PCI_DN(dn);
 	const u32 *lsn = of_get_property(dn, "linux,logical-slot-number", NULL);
 
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 21cddc3..175aac8 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -318,6 +318,7 @@ static void __init iomm_table_allocate_entry(struct pci_dev *dev, int bar_num)
 {
 	struct resource *bar_res = &dev->resource[bar_num];
 	long bar_size = pci_resource_len(dev, bar_num);
+	struct device_node *dn = pci_device_to_OF_node(dev);
 
 	/*
 	 * No space to allocate, quick exit, skip Allocation.
@@ -335,9 +336,9 @@ static void __init iomm_table_allocate_entry(struct pci_dev *dev, int bar_num)
 	 * Allocate the number of table entries needed for BAR.
 	 */
 	while (bar_size > 0 ) {
-		iomm_table[current_iomm_table_entry] = dev->sysdata;
+		iomm_table[current_iomm_table_entry] = dn;
 		ds_addr_table[current_iomm_table_entry] =
-			iseries_ds_addr(dev->sysdata) | (bar_num << 24);
+			iseries_ds_addr(dn) | (bar_num << 24);
 		bar_size -= IOMM_TABLE_ENTRY_SIZE;
 		++current_iomm_table_entry;
 	}
@@ -410,7 +411,7 @@ void __init iSeries_pcibios_fixup_resources(struct pci_dev *pdev)
 	struct device_node *node;
 	int i;
 
-	node = find_device_node(bus, pdev->devfn);
+	node = pci_device_to_OF_node(pdev);
 	pr_debug("PCI: iSeries %s, pdev %p, node %p\n",
 		 pci_name(pdev), pdev, node);
 	if (!node) {
@@ -441,7 +442,6 @@ void __init iSeries_pcibios_fixup_resources(struct pci_dev *pdev)
 		}
 	}
 
-	pdev->sysdata = node;
 	allocate_device_bars(pdev);
 	iseries_device_information(pdev, bus, *sub_bus);
 }
-- 
1.6.0.6
