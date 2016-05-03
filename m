Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhhY2nhHzDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:23:57 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 23:23:56 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8D06A2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:23:54 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43DNkX54850032
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 23:23:54 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43DNLJR019436
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 23:23:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 06/22] powerpc/powernv: Create PEs in pcibios_setup_bridge()
Date: Tue,  3 May 2016 23:22:37 +1000
Message-Id: <1462281773-26438-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the PEs and their associated resources are assigned in
ppc_md.pcibios_fixup() except those used by SRIOV VFs. The function
is called for once after PCI probing and resources assignment is
completed. So it's obviously not hotplug friendly.

This creates PEs dynamically in pcibios_setup_bridge() that is
called for the event during system bootup and PCI hotplug: updating
PCI bridge's windows after resource assignment/reassignment are done.
In partial hotplug case, not all PCI devices included to one particular
PE are unplugged and plugged again, we just need unbinding/binding the
hot added PCI devices with the corresponding PE without creating new
one. The change is applied to IODA1 and IODA2 PHBs only. The behaviour
on NPU PHBs aren't changed. There are no PCI bridges on NPU PHBs,
meaning pcibios_setup_bridge() won't be invoked there. We have to use
old path (pnv_pci_ioda_fixup()) to setup PEs on NPU PHBs.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 181 +++++++++++-------------------
 1 file changed, 68 insertions(+), 113 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 679e279..f63902a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1026,6 +1026,15 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 				pci_name(dev));
 			continue;
 		}
+
+		/*
+		 * In partial hotplug case, the PCI device might be still
+		 * associated with the PE and needn't attach it to the PE
+		 * again.
+		 */
+		if (pdn->pe_number != IODA_INVALID_PE)
+			continue;
+
 		pdn->pcidev = dev;
 		pdn->pe_number = pe->pe_number;
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
@@ -1044,6 +1053,18 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
 	struct pnv_ioda_pe *pe = NULL;
+	unsigned int pe_num;
+
+	/*
+	 * In partial hotplug case, the PE instance might be still alive.
+	 * We should reuse it instead of allocating a new one.
+	 */
+	pe_num = phb->ioda.pe_rmap[bus->number << 8];
+	if (pe_num != IODA_INVALID_PE) {
+		pe = &phb->ioda.pe_array[pe_num];
+		pnv_ioda_setup_same_PE(bus, pe);
+		return NULL;
+	}
 
 	/* Check if PE is determined by M64 */
 	if (phb->pick_m64_pe)
@@ -1158,30 +1179,6 @@ static void pnv_ioda_setup_npu_PEs(struct pci_bus *bus)
 		pnv_ioda_setup_npu_PE(pdev);
 }
 
-static void pnv_ioda_setup_PEs(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	pnv_ioda_setup_bus_PE(bus, false);
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (dev->subordinate) {
-			if (pci_pcie_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE)
-				pnv_ioda_setup_bus_PE(dev->subordinate, true);
-			else
-				pnv_ioda_setup_PEs(dev->subordinate);
-		}
-	}
-}
-
-/*
- * Configure PEs so that the downstream PCI buses and devices
- * could have their associated PE#. Unfortunately, we didn't
- * figure out the way to identify the PLX bridge yet. So we
- * simply put the PCI bus and the subordinate behind the root
- * port to PE# here. The game rule here is expected to be changed
- * as soon as we can detected PLX bridge correctly.
- */
 static void pnv_pci_ioda_setup_PEs(void)
 {
 	struct pci_controller *hose, *tmp;
@@ -1189,22 +1186,11 @@ static void pnv_pci_ioda_setup_PEs(void)
 
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		phb = hose->private_data;
-
-		/* M64 layout might affect PE allocation */
-		if (phb->reserve_m64_pe)
-			phb->reserve_m64_pe(hose->bus, NULL, true);
-
-		/*
-		 * On NPU PHB, we expect separate PEs for individual PCI
-		 * functions. PCI bus dependent PEs are required for the
-		 * remaining types of PHBs.
-		 */
 		if (phb->type == PNV_PHB_NPU) {
 			/* PE#0 is needed for error reporting */
 			pnv_ioda_reserve_pe(phb, 0);
 			pnv_ioda_setup_npu_PEs(hose->bus);
-		} else
-			pnv_ioda_setup_PEs(hose->bus);
+		}
 	}
 }
 
@@ -2552,6 +2538,9 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 {
 	int64_t rc;
 
+	if (!pnv_pci_ioda_pe_dma_weight(pe))
+		return;
+
 	/* TVE #1 is selected by PCI address bit 59 */
 	pe->tce_bypass_base = 1ull << 59;
 
@@ -2583,47 +2572,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 }
 
-static void pnv_ioda_setup_dma(struct pnv_phb *phb)
-{
-	struct pci_controller *hose = phb->hose;
-	struct pnv_ioda_pe *pe;
-	unsigned int weight;
-
-	/* If we have more PE# than segments available, hand out one
-	 * per PE until we run out and let the rest fail. If not,
-	 * then we assign at least one segment per PE, plus more based
-	 * on the amount of devices under that PE
-	 */
-	pr_info("PCI: Domain %04x has %d available 32-bit DMA segments\n",
-		hose->global_number, phb->ioda.dma32_count);
-
-	/* Walk our PE list and configure their DMA segments */
-	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
-		weight = pnv_pci_ioda_pe_dma_weight(pe);
-		if (!weight)
-			continue;
-
-		/*
-		 * For IODA2 compliant PHB3, we needn't care about the weight.
-		 * The all available 32-bits DMA space will be assigned to
-		 * the specific PE.
-		 */
-		if (phb->type == PNV_PHB_IODA1) {
-			pnv_pci_ioda1_setup_dma_pe(phb, pe);
-		} else if (phb->type == PNV_PHB_IODA2) {
-			pe_info(pe, "Assign DMA32 space\n");
-			pnv_pci_ioda2_setup_dma_pe(phb, pe);
-		} else if (phb->type == PNV_PHB_NPU) {
-			/*
-			 * We initialise the DMA space for an NPU PHB
-			 * after setup of the PHB is complete as we
-			 * point the NPU TVT to the the same location
-			 * as the PHB3 TVT.
-			 */
-		}
-	}
-}
-
 #ifdef CONFIG_PCI_MSI
 static void pnv_ioda2_msi_eoi(struct irq_data *d)
 {
@@ -3090,39 +3038,6 @@ static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
 	}
 }
 
-static void pnv_pci_ioda_setup_seg(void)
-{
-	struct pci_controller *tmp, *hose;
-	struct pnv_phb *phb;
-	struct pnv_ioda_pe *pe;
-
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		phb = hose->private_data;
-
-		/* NPU PHB does not support IO or MMIO segmentation */
-		if (phb->type == PNV_PHB_NPU)
-			continue;
-
-		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
-			pnv_ioda_setup_pe_seg(pe);
-		}
-	}
-}
-
-static void pnv_pci_ioda_setup_DMA(void)
-{
-	struct pci_controller *hose, *tmp;
-	struct pnv_phb *phb;
-
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		pnv_ioda_setup_dma(hose->private_data);
-
-		/* Mark the PHB initialization done */
-		phb = hose->private_data;
-		phb->initialized = 1;
-	}
-}
-
 static void pnv_pci_ioda_create_dbgfs(void)
 {
 #ifdef CONFIG_DEBUG_FS
@@ -3133,6 +3048,9 @@ static void pnv_pci_ioda_create_dbgfs(void)
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		phb = hose->private_data;
 
+		/* Notify initialization of PHB done */
+		phb->initialized = 1;
+
 		sprintf(name, "PCI%04x", hose->global_number);
 		phb->dbgfs = debugfs_create_dir(name, powerpc_debugfs_root);
 		if (!phb->dbgfs)
@@ -3171,9 +3089,6 @@ static void pnv_npu_ioda_fixup(void)
 static void pnv_pci_ioda_fixup(void)
 {
 	pnv_pci_ioda_setup_PEs();
-	pnv_pci_ioda_setup_seg();
-	pnv_pci_ioda_setup_DMA();
-
 	pnv_pci_ioda_create_dbgfs();
 
 #ifdef CONFIG_EEH
@@ -3226,6 +3141,45 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 	return phb->ioda.io_segsize;
 }
 
+static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_dev *bridge = bus->self;
+	struct pnv_ioda_pe *pe;
+	bool all = (pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE);
+
+	/* Don't assign PE to PCI bus, which doesn't have subordinate devices */
+	if (list_empty(&bus->devices))
+		return;
+
+	/* Reserve PEs according to used M64 resources */
+	if (phb->reserve_m64_pe)
+		phb->reserve_m64_pe(bus, NULL, all);
+
+	/*
+	 * Assign PE. We might run here because of partial hotplug.
+	 * For the case, we just pick up the existing PE and should
+	 * not allocate resources again.
+	 */
+	pe = pnv_ioda_setup_bus_PE(bus, all);
+	if (!pe)
+		return;
+
+	pnv_ioda_setup_pe_seg(pe);
+	switch (phb->type) {
+	case PNV_PHB_IODA1:
+		pnv_pci_ioda1_setup_dma_pe(phb, pe);
+		break;
+	case PNV_PHB_IODA2:
+		pnv_pci_ioda2_setup_dma_pe(phb, pe);
+		break;
+	default:
+		pr_warn("%s: No DMA for PHB#%d (type %d)\n",
+			__func__, phb->hose->global_number, phb->type);
+	}
+}
+
 #ifdef CONFIG_PCI_IOV
 static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 						      int resno)
@@ -3303,6 +3257,7 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 #endif
 	.enable_device_hook	= pnv_pci_enable_device_hook,
 	.window_alignment	= pnv_pci_window_alignment,
+	.setup_bridge		= pnv_pci_setup_bridge,
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
 	.dma_set_mask		= pnv_pci_ioda_dma_set_mask,
 	.dma_get_required_mask	= pnv_pci_ioda_dma_get_required_mask,
-- 
2.1.0
