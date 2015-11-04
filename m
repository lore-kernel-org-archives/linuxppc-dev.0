Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 243351A0942
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 01:30:51 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 20:00:49 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C526A3940062
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 20:00:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DRmsA57933900
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 20:00:47 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDIvo031977
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:20 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 26/50] powerpc/powernv: Create PEs at PCI hot plugging time
Date: Thu,  5 Nov 2015 00:12:26 +1100
Message-Id: <1446642770-4681-27-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the PEs and their associated resources are assigned
in ppc_md.pcibios_fixup() except those used by SRIOV VFs. The
function is called for once after PCI probing and resources
assignment is completed. So it isn't hotplug friendly.

This creates PEs dynamically by ppc_md.pcibios_setup_bridge(), which
is called on the event during system bootup and PCI hotplug: updating
PCI bridge's windows after resource assignment/reassignment are done.
For partial hotplug case, where not all PCI devices belonging to the
PE are unplugged and plugged again, we just need unbinding/binding
the affected PCI devices with the corresponding PE without creating
new one.

As there is no upstream bridge for root bus that needs to be covered
by PE, we have to create PE for root bus in ppc_md.pcibios_setup_bridge()
before any other PEs can be created, as PE for root bus is the ancestor
to anyone else.

On the other hand, the windows of root port or the upstream port
of PCIe switch behind root port are extended to be PHB's aperatuses
to accommodate the additonal resources needed by newly plugged devices
based on the fact: hotpluggable slot is behind root port or downstream
port of the PCIe switch behind root port. The extension for those
PCI brdiges' windows is done in ppc_md.pcibios_setup_bridge() as
well.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 240 +++++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci.h      |   1 +
 2 files changed, 138 insertions(+), 103 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5e6745f..0bb0056 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -975,6 +975,15 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 				pci_name(dev));
 			continue;
 		}
+
+		/*
+		 * In partial hotplug case, the PCI device might be still
+		 * associated with the PE and needn't be attached to the
+		 * PE again.
+		 */
+		if (pdn->pe_number != IODA_INVALID_PE)
+			continue;
+
 		pdn->pe_number = pe->pe_number;
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
 			pnv_ioda_setup_same_PE(dev->subordinate, pe);
@@ -992,9 +1001,26 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
 	struct pnv_ioda_pe *pe = NULL;
+	int pe_num;
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
+
+	/* PE number for root bus should have been reserved */
+	if (pci_is_root_bus(bus) &&
+	    phb->ioda.root_pe_idx != IODA_INVALID_PE)
+		pe = &phb->ioda.pe_array[phb->ioda.root_pe_idx];
 
 	/* Check if PE is determined by M64 */
-	if (phb->pick_m64_pe)
+	if (!pe && phb->pick_m64_pe)
 		pe = phb->pick_m64_pe(bus, all);
 
 	/* The PE number isn't pinned by M64 */
@@ -1036,46 +1062,6 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 	return pe;
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
-static void pnv_pci_ioda_setup_PEs(void)
-{
-	struct pci_controller *hose, *tmp;
-	struct pnv_phb *phb;
-
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		phb = hose->private_data;
-
-		/* M64 layout might affect PE allocation */
-		if (phb->reserve_m64_pe)
-			phb->reserve_m64_pe(hose->bus, NULL, true);
-
-		pnv_ioda_setup_PEs(hose->bus);
-	}
-}
-
 #ifdef CONFIG_PCI_IOV
 static int pnv_pci_vf_release_m64(struct pci_dev *pdev, u16 num_vfs)
 {
@@ -2391,8 +2377,13 @@ static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				       struct pnv_ioda_pe *pe)
 {
+	unsigned int weight;
 	int64_t rc;
 
+	weight = pnv_pci_ioda_pe_dma_weight(pe);
+	if (!weight)
+		return;
+
 	/* TVE #1 is selected by PCI address bit 59 */
 	pe->tce_bypass_base = 1ull << 59;
 
@@ -2424,33 +2415,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 }
 
-static void pnv_pci_ioda1_setup_dma(struct pnv_phb *phb)
-{
-	struct pnv_ioda_pe *pe;
-
-	pnv_pci_ioda_setup_opal_tce_kill(phb);
-
-	list_for_each_entry(pe, &phb->ioda.pe_list, list)
-		pnv_pci_ioda1_setup_dma_pe(phb, pe);
-}
-
-static void pnv_pci_ioda2_setup_dma(struct pnv_phb *phb)
-{
-	struct pnv_ioda_pe *pe;
-	unsigned int weight;
-
-	pnv_pci_ioda_setup_opal_tce_kill(phb);
-
-	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
-		weight = pnv_pci_ioda_pe_dma_weight(pe);
-		if (!weight)
-			continue;
-
-		pe_info(pe, "Assign DMA32 space\n");
-		pnv_pci_ioda2_setup_dma_pe(phb, pe);
-	}
-}
-
 #ifdef CONFIG_PCI_MSI
 static void pnv_ioda2_msi_eoi(struct irq_data *d)
 {
@@ -2914,37 +2878,6 @@ static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
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
-		phb = hose->private_data;
-		if (phb->type == PNV_PHB_IODA1)
-			pnv_pci_ioda1_setup_dma(phb);
-		else
-			pnv_pci_ioda2_setup_dma(phb);
-
-		/* Mark the PHB initialization done */
-		phb->initialized = 1;
-	}
-}
-
 static void pnv_pci_ioda_create_dbgfs(void)
 {
 #ifdef CONFIG_DEBUG_FS
@@ -2955,6 +2888,9 @@ static void pnv_pci_ioda_create_dbgfs(void)
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		phb = hose->private_data;
 
+		/* Notify initialization of PHB done */
+		phb->initialized = 1;
+
 		sprintf(name, "PCI%04x", hose->global_number);
 		phb->dbgfs = debugfs_create_dir(name, powerpc_debugfs_root);
 		if (!phb->dbgfs)
@@ -2966,10 +2902,6 @@ static void pnv_pci_ioda_create_dbgfs(void)
 
 static void pnv_pci_ioda_fixup(void)
 {
-	pnv_pci_ioda_setup_PEs();
-	pnv_pci_ioda_setup_seg();
-	pnv_pci_ioda_setup_DMA();
-
 	pnv_pci_ioda_create_dbgfs();
 
 #ifdef CONFIG_EEH
@@ -3019,6 +2951,104 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 	return phb->ioda.io_segsize;
 }
 
+/*
+ * We are updating root port or the upstream port of the
+ * bridge behind the root port with PHB's windows in order
+ * to accommodate the changes on required resources during
+ * PCI (slot) hotplug, which is connected to either root
+ * port or the downstream ports of PCIe switch behind the
+ * root port.
+ */
+static void pnv_pci_fixup_bridge_resources(struct pci_bus *bus,
+					   unsigned long type)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_dev *bridge = bus->self;
+	struct resource *r, *w;
+	int i;
+
+	/* Check if we need apply fixup to the bridge's windows */
+	if (!pci_is_root_bus(bridge->bus) &&
+	    !pci_is_root_bus(bridge->bus->self->bus))
+		return;
+
+	/* Fixup the resoureces */
+	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
+		r = &bridge->resource[PCI_BRIDGE_RESOURCES + i];
+		if (!r->flags || !r->parent)
+			continue;
+
+		w = NULL;
+		if (r->flags & type & IORESOURCE_IO)
+			w = &hose->io_resource;
+		else if (pnv_pci_is_mem_pref_64(r->flags) &&
+			 (type & IORESOURCE_PREFETCH) &&
+			 phb->ioda.m64_segsize)
+			w = &hose->mem_resources[1];
+		else if (r->flags & type & IORESOURCE_MEM)
+			w = &hose->mem_resources[0];
+
+		r->start = w->start;
+		r->end = w->end;
+	}
+}
+
+static void pnv_pci_setup_bridge(struct pci_bus *bus,
+				 unsigned long type)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_dev *bridge = bus->self;
+	struct pnv_ioda_pe *pe;
+	bool all = (pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE);
+
+	 /* The PE for root bus should be realized before any one else */
+	if (!phb->ioda.root_pe_populated) {
+		pe = pnv_ioda_setup_bus_PE(phb->hose->bus, false);
+		if (pe) {
+			phb->ioda.root_pe_idx = pe->pe_number;
+			phb->ioda.root_pe_populated = true;
+		}
+	}
+
+	/* Extend bridge's windows if necessary */
+	pnv_pci_fixup_bridge_resources(bus, type);
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
+	/* Setup MMIO mapping */
+	pnv_ioda_setup_pe_seg(pe);
+
+	/* Setup DMA */
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
@@ -3095,6 +3125,7 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 #endif
 	.enable_device_hook	= pnv_pci_enable_device_hook,
 	.window_alignment	= pnv_pci_window_alignment,
+	.setup_bridge		= pnv_pci_setup_bridge,
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
 	.dma_set_mask		= pnv_pci_ioda_dma_set_mask,
 	.dma_get_required_mask	= pnv_pci_ioda_dma_get_required_mask,
@@ -3168,6 +3199,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (phb->regs == NULL)
 		pr_err("  Failed to map registers !\n");
 
+	/* Initialize TCE kill register */
+	pnv_pci_ioda_setup_opal_tce_kill(phb);
+
 	/* Initialize more IODA stuff */
 	phb->ioda.total_pe_num = 1;
 	prop32 = of_get_property(np, "ibm,opal-num-pes", NULL);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index a8ba97f..ef5271a 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -121,6 +121,7 @@ struct pnv_phb {
 			unsigned int		total_pe_num;
 			unsigned int		reserved_pe_idx;
 			unsigned int		root_pe_idx;
+			bool			root_pe_populated;
 
 			/* 32-bit MMIO window */
 			unsigned int		m32_size;
-- 
2.1.0
