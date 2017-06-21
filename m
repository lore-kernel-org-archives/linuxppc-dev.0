Return-Path: <ruscur@russell.cc>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsx8Q1NnwzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 17:25:58 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: alistair@popple.id.au, benh@kernel.crashing.org,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH 2/2] powerpc/powernv/pci: Enable 64-bit devices to access >4GB
 DMA space
Date: Wed, 21 Jun 2017 17:18:04 +1000
Message-Id: <20170621071804.11660-2-ruscur@russell.cc>
In-Reply-To: <20170621071804.11660-1-ruscur@russell.cc>
References: <20170621071804.11660-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PHB3/POWER8 systems, devices can select between two different sections
of address space, TVE#0 and TVE#1.  TVE#0 is intended for 32bit devices
that aren't capable of addressing more than 4GB.  Selecting TVE#1 instead,
with the capability of addressing over 4GB, is performed by setting bit 59
of a PCI address.

However, some devices aren't capable of addressing at least 59 bits, but
still want more than 4GB of DMA space.  In order to enable this, reconfigure
TVE#0 to be suitable for 64-bit devices by allocating memory past the
initial 4GB that is inaccessible by 64-bit DMAs.

This bypass mode is only enabled if a device requests 4GB or more of DMA
address space, if the system has PHB3 (POWER8 systems), and if the device
does not share a PE with any devices from different vendors.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 93 ++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 13835ac30795..6adc548748d0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1743,6 +1743,75 @@ static bool pnv_pci_ioda_pe_single_vendor(struct pnv_ioda_pe *pe)
 	return true;
 }
 
+/*
+ * Reconfigure TVE#0 to be usable as 64-bit DMA space.
+ *
+ * The first 4GB of virtual memory for a PE is reserved for 32-bit accesses.
+ * Devices can only access more than that if bit 59 of the PCI address is set
+ * by hardware, which indicates TVE#1 should be used instead of TVE#0.
+ * Many PCI devices are not capable of addressing that many bits, and as a
+ * result are limited to the 4GB of virtual memory made available to 32-bit
+ * devices in TVE#0.
+ *
+ * In order to work around this, reconfigure TVE#0 to be suitable for 64-bit
+ * devices by configuring the virtual memory past the first 4GB inaccessible
+ * by 64-bit DMAs.  This should only be used by devices that want more than
+ * 4GB, and only on PEs that have no 32-bit devices.
+ *
+ * Currently this will only work on PHB3 (POWER8).
+ */
+static int pnv_pci_ioda_dma_64bit_bypass(struct pnv_ioda_pe *pe)
+{
+	u64 window_size, table_size, tce_count, addr;
+	struct page *table_pages;
+	u64 tce_order = 28; /* 256MB TCEs */
+	__be64 *tces;
+	s64 rc;
+
+	/*
+	 * Window size needs to be a power of two, but needs to account for
+	 * shifting memory by the 4GB offset required to skip 32bit space.
+	 */
+	window_size = roundup_pow_of_two(memory_hotplug_max() + (1ULL << 32));
+	tce_count = window_size >> tce_order;
+	table_size = tce_count << 3;
+
+	if (table_size < PAGE_SIZE)
+		table_size = PAGE_SIZE;
+
+	table_pages = alloc_pages_node(pe->phb->hose->node, GFP_KERNEL,
+				       get_order(table_size));
+	if (!table_pages)
+		goto err;
+
+	tces = page_address(table_pages);
+	if (!tces)
+		goto err;
+
+	memset(tces, 0, table_size);
+
+	for (addr = 0; addr < memory_hotplug_max(); addr += (1 << tce_order)) {
+		tces[(addr + (1ULL << 32)) >> tce_order] =
+			cpu_to_be64(addr | TCE_PCI_READ | TCE_PCI_WRITE);
+	}
+
+	rc = opal_pci_map_pe_dma_window(pe->phb->opal_id,
+					pe->pe_number,
+					/* reconfigure window 0 */
+					(pe->pe_number << 1) + 0,
+					1,
+					__pa(tces),
+					table_size,
+					1 << tce_order);
+	if (rc == OPAL_SUCCESS) {
+		pe_info(pe, "Using 64-bit DMA iommu bypass (through TVE#0)\n");
+		return 0;
+	}
+err:
+	pe_err(pe, "Error configuring 64-bit DMA bypass\n");
+	return -EIO;
+}
+
 static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
@@ -1751,6 +1820,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 	struct pnv_ioda_pe *pe;
 	uint64_t top;
 	bool bypass = false;
+	s64 rc;
 
 	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
 		return -ENODEV;;
@@ -1765,8 +1835,27 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 		dev_info(&pdev->dev, "Using 64-bit DMA iommu bypass\n");
 		set_dma_ops(&pdev->dev, &dma_direct_ops);
 	} else {
-		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
-		set_dma_ops(&pdev->dev, &dma_iommu_ops);
+		/*
+		 * If the device can't set the TCE bypass bit but still wants
+		 * to access 4GB or more, on PHB3 we can reconfigure TVE#0 to
+		 * bypass the 32-bit region and be usable for 64-bit DMAs.
+		 * The device needs to be able to address all of this space.
+		 */
+		if (dma_mask >> 32 &&
+		    dma_mask > (memory_hotplug_max() + (1ULL << 32)) &&
+		    pnv_pci_ioda_pe_single_vendor(pe) &&
+		    phb->model == PNV_PHB_MODEL_PHB3) {
+			/* Configure the bypass mode */
+			rc = pnv_pci_ioda_dma_64bit_bypass(pe);
+			if (rc)
+				return rc;
+			/* 4GB offset bypasses 32-bit space */
+			set_dma_offset(&pdev->dev, (1ULL << 32));
+			set_dma_ops(&pdev->dev, &dma_direct_ops);
+		} else {
+			dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
+			set_dma_ops(&pdev->dev, &dma_iommu_ops);
+		}
 	}
 	*pdev->dev.dma_mask = dma_mask;
 
-- 
2.13.1
