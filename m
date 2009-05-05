Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4AA71DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 22:05:09 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pci: clean up direct access to sysdata by iseries
	platform
Date: Tue,  5 May 2009 07:04:55 -0500
Message-Id: <1241525095-18041-1-git-send-email-galak@kernel.crashing.org>
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
 arch/powerpc/platforms/iseries/pci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 02a634f..18343c3 100644
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
 	iommu_devnode_init_iSeries(pdev, node);
-- 
1.6.0.6
