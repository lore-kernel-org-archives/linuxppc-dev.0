Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 281311A0C10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:56:05 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 13 Feb 2015 14:56:03 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F0F9F2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:55:59 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1D4tpKk22085836
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:55:59 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1D4tPq2013588
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:55:26 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 4/4] powerpc/powernv: Register PCI dev specific reset handlers
Date: Fri, 13 Feb 2015 15:54:59 +1100
Message-Id: <1423803299-22356-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
 cascardo@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, PCI VFIO infrastructure depends on pci_reset_function()
to ensure the PCI device in clean state when passing to guest, or
being returned back to host. However, the function doesn't work
(or well) on some PCI devices, which potentially brings pending
traffic over the boundary between host/guest and usually causes
memory corruption.

The patch registers PCI device specific reset handlers for those
PCI devices, pci_reset_function() doesn't work or not well, to
translate the request to EEH PE reset if possible.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index e69142f..c68d508 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -727,6 +727,64 @@ static void pnv_pci_dma_fallback_setup(struct pci_controller *hose,
 	set_iommu_table_base_and_group(&pdev->dev, pdn->iommu_table);
 }
 
+/*
+ * VFIO infrastructure depends on pci_reset_function() to do
+ * reset on the PCI devices when their owership is changed to
+ * ensure consistent clean state on those devices when someone
+ * grabs them. However, pci_reset_function() doesn't work for
+ * some deivces that require EEH PE reset.
+ */
+static int pnv_pci_dev_specific_reset(struct pci_dev *pdev, int probe)
+{
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
+	struct eeh_pe *pe = edev ? edev->pe : NULL;
+
+	if (!pe)
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	pci_set_pcie_reset_state(pdev, pcie_hot_reset);
+	pci_set_pcie_reset_state(pdev, pcie_deassert_reset);
+	return 0;
+}
+
+static int pnv_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	static bool pnv_pci_reset_registered = false;
+	int ret = 0;
+
+	if (pnv_pci_reset_registered)
+		return 0;
+
+	pnv_pci_reset_registered = true;
+	ret += pci_dev_add_specific_reset(PCI_VENDOR_ID_IBM,
+					  PCI_ANY_ID,
+					  pnv_pci_dev_specific_reset);
+	ret += pci_dev_add_specific_reset(PCI_VENDOR_ID_BROADCOM,
+					  PCI_DEVICE_ID_NX2_57800,
+					  pnv_pci_dev_specific_reset);
+	ret += pci_dev_add_specific_reset(PCI_VENDOR_ID_BROADCOM,
+					  PCI_DEVICE_ID_NX2_57840,
+					  pnv_pci_dev_specific_reset);
+	ret += pci_dev_add_specific_reset(PCI_VENDOR_ID_BROADCOM,
+					  PCI_DEVICE_ID_NX2_57810,
+					  pnv_pci_dev_specific_reset);
+	ret += pci_dev_add_specific_reset(PCI_VENDOR_ID_MELLANOX,
+					  PCI_ANY_ID,
+					  pnv_pci_dev_specific_reset);
+	ret += pci_dev_add_specific_reset(PCI_VENDOR_ID_TI,
+					  PCI_ANY_ID,
+					  pnv_pci_dev_specific_reset);
+	if (ret)
+		pr_warn("%s: Failure adding PCI specific reset handlers\n",
+			__func__);
+
+	/* Don't return error to keep PCI core going */
+	return 0;
+}
+
 static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
@@ -820,6 +878,9 @@ void __init pnv_pci_init(void)
 	/* Setup the linkage between OF nodes and PHBs */
 	pci_devs_phb_init();
 
+	/* Setup root bridge */
+	ppc_md.pcibios_root_bridge_prepare = pnv_pci_root_bridge_prepare;
+
 	/* Configure IOMMU DMA hooks */
 	ppc_md.pci_dma_dev_setup = pnv_pci_dma_dev_setup;
 	ppc_md.tce_build = pnv_tce_build_vm;
-- 
1.8.3.2
