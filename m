Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 263771A10A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 16:04:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 May 2015 16:04:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8C9F23578048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 16:04:31 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4164NH532702662
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 16:04:31 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4163vYE000777
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 16:03:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 06/21] powerpc/powernv: Create PEs dynamically
Date: Fri,  1 May 2015 16:02:53 +1000
Message-Id: <1430460188-31343-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the PEs and their associated resources are assigned
in ppc_md.pcibios_fixup(). The function is called for once after
PCI probing and resources assignment are finished. Obviously, it's
not hotplug friendly. The patch creates PEs dynamically by
ppc_md.pcibios_setup_bridge(), which is called on the event during
system bootup and PCI hotplug: updating PCI bridge's windows after
resource assignment/reassignment are finished. For partial hotplug
case, where not all PCI devices belonging to the PE are unplugged
and plugged again, we just need unbinding/binding the affected
PCI devices with the corresponding PE without creating new one.

Besides, it might require addtional resources (e.g. M32) to the
windows of the PCI bridge when unplugging current adapter, and
insert a different adapter if there is one PCI slot, which is
assumed behind root port, or the downstream bridge of the PCIE
switch behind root port. The parent bridge of the newly plugged
adapter would reject the request to add more resources, leading
to hotplug failure. For the issue, the patch extends the windows
of root port, or the upstream port of the PCIe switch behind root
port to PHB's windows when ppc_md.pcibios_setup_bridge() is called.

There is no upstream bridge for root bus, so we have to reserve
PE#, which is next to the reserved PE# in advance and fixing the
PE for root bus in ppc_md.pcibios_setup_bridge().

The patch also changes the rule assigning PE#: PE# reserved for
prefetchable 64-bits memory resource and SRIOV VFs starts from
zero while PE# for dynamic allocations starts from ioda.total_pe
reversely. It's because PE# for prefetchable 64-bits memory resource,
which is ually allocated begining with the PHB's aperatus and PE#
and the resource have fixed mapping. The PE# for dynamic allocation
is quite flexible and has no limitation.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |   1 +
 arch/powerpc/kernel/pci-common.c          |  10 +
 arch/powerpc/platforms/powernv/pci-ioda.c | 307 ++++++++++++++++++++----------
 arch/powerpc/platforms/powernv/pci.h      |   4 +-
 4 files changed, 220 insertions(+), 102 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 1811c44..5367eb3 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -29,6 +29,7 @@ struct pci_controller_ops {
 
 	/* Called during PCI resource reassignment */
 	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
+	void		(*setup_bridge)(struct pci_bus *, unsigned long);
 	void		(*reset_secondary_bus)(struct pci_dev *dev);
 };
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0d05406..01d2a84 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -134,6 +134,16 @@ void pcibios_reset_secondary_bus(struct pci_dev *dev)
 	pci_reset_secondary_bus(dev);
 }
 
+void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+
+	if (hose->controller_ops.setup_bridge)
+		hose->controller_ops.setup_bridge(bus, type);
+	else
+		pci_setup_bridge_resources(bus, type);
+}
+
 #ifdef CONFIG_PCI_IOV
 resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev, int resno)
 {
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9ef745e..910fb67 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -143,18 +143,23 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 
 static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
-	unsigned long pe;
+	unsigned long pe_no;
+	unsigned long limit = phb->ioda.total_pe - 1;
 
 	do {
-		pe = find_next_zero_bit(phb->ioda.pe_alloc,
-					phb->ioda.total_pe, 0);
-		if (pe >= phb->ioda.total_pe)
+		pe_no = find_next_zero_bit(phb->ioda.pe_alloc,
+					   phb->ioda.total_pe, limit);
+		if (pe_no < phb->ioda.total_pe &&
+		    !test_and_set_bit(pe_no, phb->ioda.pe_alloc))
+			break;
+
+		if (--limit >= phb->ioda.total_pe)
 			return IODA_INVALID_PE;
-	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
+	} while(1);
 
-	phb->ioda.pe_array[pe].phb = phb;
-	phb->ioda.pe_array[pe].pe_number = pe;
-	return pe;
+	phb->ioda.pe_array[pe_no].phb = phb;
+	phb->ioda.pe_array[pe_no].pe_number = pe_no;
+	return pe_no;
 }
 
 static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
@@ -214,6 +219,13 @@ static int pnv_ioda1_init_m64(struct pnv_phb *phb)
 		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
 			phb->ioda.reserved_pe);
 
+	/* Strip of the segment used by PE for PCI root bus,
+	 * which is last supported PE#, or one next to the
+	 * reserved PE#
+	 */
+	if (phb->ioda.root_pe_no != IODA_INVALID_PE)
+		r->end -= phb->ioda.m64_segsize;
+
 	return 0;
 
 fail:
@@ -264,13 +276,24 @@ static int pnv_ioda2_init_m64(struct pnv_phb *phb)
 	 */
 	r = &phb->hose->mem_resources[1];
 	if (phb->ioda.reserved_pe == 0)
-		r->start += phb->ioda.m64_segsize;
+		r->start += (phb->ioda.root_pe_no != IODA_INVALID_PE ?
+			     phb->ioda.m64_segsize * 2 :
+			     phb->ioda.m64_segsize);
 	else if (phb->ioda.reserved_pe == (phb->ioda.total_pe - 1))
-		r->end -= phb->ioda.m64_segsize;
+		r->end -= (phb->ioda.root_pe_no != IODA_INVALID_PE ?
+			   phb->ioda.m64_segsize * 2 :
+			   phb->ioda.m64_segsize);
 	else
 		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
 			phb->ioda.reserved_pe);
 
+	/* Strip of the segment used by PE for PCI root bus,
+	 * which is last supported PE#, or one next to the
+	 * reserved PE#
+	 */
+	if (phb->ioda.root_pe_no != IODA_INVALID_PE)
+		r->end -= phb->ioda.m64_segsize;
+
 	return 0;
 
 fail:
@@ -837,7 +860,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 
 	/* Clear the reverse map */
 	for (rid = pe->rid; rid < rid_end; rid++)
-		phb->ioda.pe_rmap[rid] = 0;
+		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
 
 	/* Release from all parents PELT-V */
 	while (parent) {
@@ -1172,11 +1195,18 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_dn *pdn = pci_get_pdn(dev);
 
-		if (pdn == NULL) {
-			pr_warn("%s: No device node associated with device !\n",
-				pci_name(dev));
+		if (!pdn) {
+			dev_warn(&dev->dev, "%s: No associated PCI data\n",
+				 __func__);
 			continue;
 		}
+
+		/* The PCI device might have been associated with the PE in
+		 * case of partial hotplug.
+		 */
+		if (pdn->pe_number != IODA_INVALID_PE)
+			continue;
+
 		pdn->pe_number = pe->pe_number;
 		pe->dma_weight += pnv_ioda_dev_dma_weight(dev);
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
@@ -1190,15 +1220,31 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
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
+		pe_num = phb->ioda.root_pe_no;
+
 	/* Check if PE is determined by M64 */
-	if (phb->pick_m64_pe)
+	if (pe_num == IODA_INVALID_PE && phb->pick_m64_pe)
 		pe_num = phb->pick_m64_pe(phb, bus, all);
 
 	/* The PE number isn't pinned by M64 */
@@ -1208,7 +1254,7 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 	if (pe_num == IODA_INVALID_PE) {
 		pr_warning("%s: Not enough PE# available for PCI bus %04x:%02x\n",
 			__func__, pci_domain_nr(bus), bus->number);
-		return;
+		return NULL;
 	}
 
 	pe = &phb->ioda.pe_array[pe_num];
@@ -1220,18 +1266,18 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 	pe->dma_weight = 0;
 
 	if (all)
-		pe_info(pe, "Secondary bus %d..%d associated with PE#%d\n",
-			bus->busn_res.start, bus->busn_res.end, pe_num);
+		pe_info(pe, "Secondary bus %d..%d associated\n",
+			bus->busn_res.start, bus->busn_res.end);
 	else
-		pe_info(pe, "Secondary bus %d associated with PE#%d\n",
-			bus->busn_res.start, pe_num);
+		pe_info(pe, "Secondary bus %d associated\n",
+			bus->busn_res.start);
 
 	if (pnv_ioda_configure_pe(phb, pe)) {
 		/* XXX What do we do here ? */
 		if (pe_num)
 			pnv_ioda_free_pe(phb, pe_num);
 		pe->pbus = NULL;
-		return;
+		return NULL;
 	}
 
 	pe->tce32_table = kzalloc_node(sizeof(struct iommu_table),
@@ -1246,46 +1292,8 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 
 	/* Link the PE */
 	pnv_ioda_link_pe_by_weight(phb, pe);
-}
-
-static void pnv_ioda_setup_PEs(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	pnv_ioda_setup_bus_PE(bus, 0);
 
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
-
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
@@ -2200,14 +2208,6 @@ void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		pnv_pci_ioda2_setup_dma_pe(phb, pe);
 }
 
-static void pnv_ioda_setup_dma(struct pnv_phb *phb)
-{
-	struct pnv_ioda_pe *pe;
-
-	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link)
-		pnv_pci_ioda_setup_dma_pe(phb, pe);
-}
-
 #ifdef CONFIG_PCI_MSI
 static void pnv_ioda2_msi_eoi(struct irq_data *d)
 {
@@ -2649,34 +2649,6 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
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
@@ -2698,9 +2670,14 @@ static void pnv_pci_ioda_create_dbgfs(void)
 
 static void pnv_pci_ioda_fixup(void)
 {
-	pnv_pci_ioda_setup_PEs();
-	pnv_pci_ioda_setup_seg();
-	pnv_pci_ioda_setup_DMA();
+	struct pci_controller *tmp, *hose;
+	struct pnv_phb *phb;
+
+	/* Notify initialization of PHB done */
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		phb = hose->private_data;
+		phb->initialized = 1;
+	}
 
 	pnv_pci_ioda_create_dbgfs();
 
@@ -2751,6 +2728,115 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 	return phb->ioda.io_segsize;
 }
 
+/*
+ * We are updating root port or the upstream bridge behind the root
+ * port with PHB's various windows in order to accomodate the changes
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
+	/* Check if we need apply fixup to the bridge's resources */
+	if (!pci_is_root_bus(bridge->bus) &&
+	    !pci_is_root_bus(bridge->bus->self->bus)) {
+		pci_setup_bridge_resources(bus, type);
+		return;
+	}
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
+
+	/* Update the resources */
+	pci_setup_bridge_resources(bus, type);
+}
+
+static void pnv_pci_setup_bridge(struct pci_bus *bus,
+				 unsigned long type)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_dev *bridge = bus->self;
+	struct pci_dev *parent;
+	struct pnv_ioda_pe *pe;
+
+	/* The PCI bus might be behind a PCIE-to-PCI bridge. For that
+	 * case, the PCI bus should have been included to one PE. So
+	 * we needn't assign PE for it again.
+	 */
+	parent = bridge->bus ? bridge->bus->self : NULL;
+	while (parent) {
+		if (pci_pcie_type(parent) == PCI_EXP_TYPE_PCI_BRIDGE)
+			return;
+
+		parent = parent->bus ? parent->bus->self : NULL;
+	}
+
+	/* Assign PE to root bus, which would be the parent PE and
+	 * should be populated prior to any other PEs.
+	 */
+	if (!phb->ioda.root_pe_populated) {
+		pe = pnv_ioda_setup_bus_PE(phb->hose->bus, 0);
+		if (pe && phb->ioda.root_pe_no == IODA_INVALID_PE)
+			phb->ioda.root_pe_no = pe->pe_number;
+		phb->ioda.root_pe_populated = 1;
+	}
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
+	pnv_pci_ioda_setup_dma_pe(phb, pe);
+}
+
 #ifdef CONFIG_PCI_IOV
 static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 						      int resno)
@@ -2901,7 +2987,22 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	aux = memblock_virt_alloc(size, 0);
 	phb->ioda.pe_alloc = aux;
 	phb->ioda.pe_array = aux + pemap_off;
-	set_bit(phb->ioda.reserved_pe, phb->ioda.pe_alloc);
+
+	/* Choose number of PE for root bus, which shouldn't consume
+	 * any M64 resource. So we avoid picking low-end PE#, which
+	 * is usually binding with 64-bits prefetchable memory resources
+	 * closely.
+	 */
+	pnv_ioda_reserve_pe(phb, phb->ioda.reserved_pe);
+	if (phb->ioda.reserved_pe == 0) {
+		phb->ioda.root_pe_no = phb->ioda.total_pe - 1;
+		pnv_ioda_reserve_pe(phb, phb->ioda.root_pe_no);
+	} else if (phb->ioda.reserved_pe == (phb->ioda.total_pe - 1)) {
+		phb->ioda.root_pe_no = phb->ioda.reserved_pe - 1;
+		pnv_ioda_reserve_pe(phb, phb->ioda.root_pe_no);
+	} else {
+		phb->ioda.root_pe_no = IODA_INVALID_PE;
+	}
 
 	INIT_LIST_HEAD(&phb->ioda.pe_dma_list);
 	INIT_LIST_HEAD(&phb->ioda.pe_list);
@@ -2910,6 +3011,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	/* Calculate how many 32-bit TCE segments we have */
 	phb->ioda.tce32_count = phb->ioda.m32_pci_base >> 28;
 
+	/* Invalidate RID to PE# mapping */
+	memset(phb->ioda.pe_rmap, 0xff, sizeof(phb->ioda.pe_rmap));
+
 #if 0 /* We should really do that ... */
 	rc = opal_pci_set_phb_mem_window(opal->phb_id,
 					 window_type,
@@ -2958,6 +3062,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 	pnv_pci_controller_ops.enable_device_hook = pnv_pci_enable_device_hook;
+	pnv_pci_controller_ops.setup_bridge = pnv_pci_setup_bridge;
 	pnv_pci_controller_ops.window_alignment = pnv_pci_window_alignment;
 	pnv_pci_controller_ops.reset_secondary_bus = pnv_pci_reset_secondary_bus;
 	hose->controller_ops = pnv_pci_controller_ops;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 2784951..1bea3a8 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -134,6 +134,8 @@ struct pnv_phb {
 			/* Global bridge info */
 			unsigned int		total_pe;
 			unsigned int		reserved_pe;
+			unsigned int		root_pe_no;
+			unsigned int		root_pe_populated;
 
 			/* 32-bit MMIO window */
 			unsigned int		m32_size;
@@ -176,7 +178,7 @@ struct pnv_phb {
 			 * we are to support more than 256 PEs, indexed
 			 * bus { bus, devfn }
 			 */
-			unsigned char		pe_rmap[0x10000];
+			unsigned int		pe_rmap[0x10000];
 
 			/* 32-bit TCE tables allocation */
 			unsigned int		dma_weight;
-- 
2.1.0
