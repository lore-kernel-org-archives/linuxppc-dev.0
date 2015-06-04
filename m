Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6EFC1A0D08
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:44:02 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0348D357804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:00 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hpdr62193828
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:59 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546hP27014328
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:26 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 16/42] powerpc/powernv: Create PEs dynamically
Date: Thu,  4 Jun 2015 16:41:45 +1000
Message-Id: <1433400131-18429-17-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the PEs and their associated resources are assigned
in ppc_md.pcibios_fixup() except those consumed by SRIOV VFs.
The function is called for once after PCI probing and resources
assignment are finished. Obviously, it's not hotplug friendly.

The patch creates PEs dynamically by ppc_md.pcibios_setup_bridge(),
which is called on the event during system bootup and PCI hotplug:
updating PCI bridge's windows after resource assignment/reassignment
are finished. For partial hotplug case, where not all PCI devices
belonging to the PE are unplugged and plugged again, we just need
unbinding/binding the affected PCI devices with the corresponding
PE without creating new one.

Besides, it might require addtional resources (e.g. M32) to the
windows of the PCI bridge when unplugging current adapter, and
insert a different adapter if there is one PCI slot, which is
assumed behind root port, or the downstream bridge of the PCIE
switch behind root port. The parent bridge of the newly plugged
adapter would reject the request to add more resources, leading
to hotplug failure. For the issue, the patch extends the windows
of root port, or the upstream port of the PCIe switch behind root
port to PHB's windows when ppc_md.pcibios_setup_bridge() is called.

There is no upstream bridge for root bus, so we have to fix it up
before any PE is created because the root bus PE is the ancestor
to anyone else.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Derived from [PATCH v5 v4 06/21]
  * Correct "accommodate" reported by checkpatch.pl
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 203 +++++++++++++++++++-----------
 arch/powerpc/platforms/powernv/pci.h      |   1 +
 2 files changed, 128 insertions(+), 76 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2eb8baa..fd2f898 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1200,6 +1200,13 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 				pci_name(dev));
 			continue;
 		}
+
+		/* The PCI device might have been associated with the PE
+		 * in case of partial hotplug.
+		 */
+		if (pdn->pe_number != IODA_INVALID_PE)
+			continue;
+
 		pdn->pe_number = pe->pe_number;
 		pe->dma32_weight += pnv_ioda_dev_dma_weight(dev);
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
@@ -1213,15 +1220,31 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
  * subordinate PCI devices and buses. The second type of PE is normally
  * orgiriated by PCIe-to-PCI bridge or PLX switch downstream ports.
  */
-static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
+static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
 	struct pnv_ioda_pe *pe;
 	int pe_num = IODA_INVALID_PE;
 
+	/* For partial hotplug case, the PE instance hasn't been destroyed
+	 * yet. We shouldn't allocated a new one and assign resources to
+	 * it. The existing PE instance should be reused, but we should
+	 * associate the devices to the PE.
+	 */
+	pe_num = phb->ioda.pe_rmap[bus->number << 8];
+	if (pe_num != IODA_INVALID_PE) {
+		pe = &phb->ioda.pe_array[pe_num];
+		pnv_ioda_setup_same_PE(bus, pe);
+		return NULL;
+	}
+
+	/* PE number for root bus should have been reserved */
+	if (pci_is_root_bus(bus))
+		pe_num = phb->ioda.root_pe;
+
 	/* Check if PE is determined by M64 */
-	if (phb->pick_m64_pe)
+	if (pe_num == IODA_INVALID_PE && phb->pick_m64_pe)
 		pe_num = phb->pick_m64_pe(phb, bus, all);
 
 	/* The PE number isn't pinned by M64 */
@@ -1231,7 +1254,7 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 	if (pe_num == IODA_INVALID_PE) {
 		pr_warning("%s: Not enough PE# available for PCI bus %04x:%02x\n",
 			__func__, pci_domain_nr(bus), bus->number);
-		return;
+		return NULL;
 	}
 
 	pe = &phb->ioda.pe_array[pe_num];
@@ -1255,7 +1278,7 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 		if (pe_num)
 			pnv_ioda_free_pe(phb, pe_num);
 		pe->pbus = NULL;
-		return;
+		return NULL;
 	}
 
 	/* Associate it with all child devices */
@@ -1266,46 +1289,8 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 
 	/* Link the PE */
 	pnv_ioda_link_pe_by_weight(phb, pe);
-}
-
-static void pnv_ioda_setup_PEs(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	pnv_ioda_setup_bus_PE(bus, 0);
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (dev->subordinate) {
-			if (pci_pcie_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE)
-				pnv_ioda_setup_bus_PE(dev->subordinate, 1);
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
 
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		phb = hose->private_data;
-
-		/* M64 layout might affect PE allocation */
-		if (phb->reserve_m64_pe)
-			phb->reserve_m64_pe(phb, phb->hose->bus);
-
-		pnv_ioda_setup_PEs(hose->bus);
-	}
+	return pe;
 }
 
 #ifdef CONFIG_PCI_IOV
@@ -3088,36 +3073,6 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
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
-			pnv_ioda_setup_pe_seg(hose, pe);
-		}
-	}
-}
-
-static void pnv_pci_ioda_setup_DMA(void)
-{
-	struct pci_controller *hose, *tmp;
-	struct pnv_phb *phb;
-	struct pnv_ioda_pe *pe;
-
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		phb = hose->private_data;
-		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link)
-			pnv_ioda_setup_dma(phb, pe);
-
-		/* Mark the PHB initialization done */
-		phb->initialized = 1;
-	}
-}
-
 static void pnv_pci_ioda_create_dbgfs(void)
 {
 #ifdef CONFIG_DEBUG_FS
@@ -3139,9 +3094,8 @@ static void pnv_pci_ioda_create_dbgfs(void)
 
 static void pnv_pci_ioda_fixup(void)
 {
-	pnv_pci_ioda_setup_PEs();
-	pnv_pci_ioda_setup_seg();
-	pnv_pci_ioda_setup_DMA();
+	struct pci_controller *tmp, *hose;
+	struct pnv_phb *phb;
 
 	pnv_pci_ioda_create_dbgfs();
 
@@ -3149,6 +3103,12 @@ static void pnv_pci_ioda_fixup(void)
 	eeh_init();
 	eeh_addr_cache_build();
 #endif
+
+	/* Notify initialization of PHB done */
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		phb = hose->private_data;
+		phb->initialized = 1;
+	}
 }
 
 /*
@@ -3192,6 +3152,96 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 	return phb->ioda.io_segsize;
 }
 
+/*
+ * We are updating root port or the upstream bridge behind the root
+ * port with PHB's various windows in order to accommodate the changes
+ * on required resources during PCI (slot) hotplug, which is connected
+ * to either root port, or the downstream ports of PCIe switch behind
+ * the root port.
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
+			(type & IORESOURCE_PREFETCH) &&
+			phb->ioda.m64_segsize)
+			w = &hose->mem_resources[1];
+		else if (r->flags & type & IORESOURCE_MEM)
+			w = &hose->mem_resources[0];
+
+		r->start = w->start;
+		r->end = w->end;
+	}
+
+}
+
+static void pnv_pci_setup_bridge(struct pci_bus *bus,
+				 unsigned long type)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_dev *bridge = bus->self;
+	struct pnv_ioda_pe *pe;
+
+	/* The root bus (ancestor PE) should be finalized before anyone else */
+	if (!phb->ioda.root_pe_populated) {
+		pe = pnv_ioda_setup_bus_PE(phb->hose->bus, 0);
+		if (pe && phb->ioda.root_pe == IODA_INVALID_PE)
+			phb->ioda.root_pe = pe->pe_number;
+			phb->ioda.root_pe_populated = 1;
+		}
+
+	/* Extend bridge's windows if necessary */
+	pnv_pci_fixup_bridge_resources(bus, type);
+
+	/* Don't assign PE to bus, which doesn't have any subordinate
+	 * PCI devices on it.
+	 */
+	if (list_empty(&bus->devices))
+		return;
+
+	/* Reserve PEs for M64 resource */
+	if (phb->reserve_m64_pe)
+		phb->reserve_m64_pe(phb, bus);
+
+	/* Assign PE. We might run here because of partial hotplug.
+	 * For the case, we just pick up the existing PE and should
+	 * not allocate resources again.
+	 */
+	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE)
+		pe = pnv_ioda_setup_bus_PE(bus, 1);
+	else
+		pe = pnv_ioda_setup_bus_PE(bus, 0);
+	if (!pe)
+		return;
+
+	/* Setup MMIO mapping */
+	pnv_ioda_setup_pe_seg(hose, pe);
+
+	/* Setup DMA */
+	pnv_ioda_setup_dma(phb, pe);
+}
+
 #ifdef CONFIG_PCI_IOV
 static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 						      int resno)
@@ -3418,6 +3468,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 	pnv_pci_controller_ops.enable_device_hook = pnv_pci_enable_device_hook;
 	pnv_pci_controller_ops.window_alignment = pnv_pci_window_alignment;
+	pnv_pci_controller_ops.setup_bridge = pnv_pci_setup_bridge;
 	pnv_pci_controller_ops.reset_secondary_bus = pnv_pci_reset_secondary_bus;
 	hose->controller_ops = pnv_pci_controller_ops;
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index e372b9f..45a6450 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -134,6 +134,7 @@ struct pnv_phb {
 			/* Global bridge info */
 			unsigned int		total_pe;
 			unsigned int		root_pe;
+			unsigned int		root_pe_populated;
 			unsigned int		reserved_pe;
 
 			/* 32-bit MMIO window */
-- 
2.1.0
