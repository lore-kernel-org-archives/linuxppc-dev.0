Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8ED621A1040
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 15:00:53 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sat, 15 Aug 2015 15:00:51 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C58542BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 15:00:46 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7F50d6o57606144
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 15:00:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7F50DT8006484
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 15:00:14 +1000
Date: Sat, 15 Aug 2015 14:59:48 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com
Subject: Re: [PATCH v6 20/42] powerpc/powernv: Create PEs dynamically
Message-ID: <20150815045948.GA27636@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-21-git-send-email-gwshan@linux.vnet.ibm.com>
 <55CDF2AC.2090908@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55CDF2AC.2090908@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 14, 2015 at 11:52:44PM +1000, Alexey Kardashevskiy wrote:
>On 08/06/2015 02:11 PM, Gavin Shan wrote:
>>Currently, the PEs and their associated resources are assigned
>>in ppc_md.pcibios_fixup() except those consumed by SRIOV VFs.
>>The function is called for once after PCI probing and resources
>>assignment is finished which isn't hotplug friendly.
>>
>>The patch creates PEs dynamically by ppc_md.pcibios_setup_bridge(),
>>which is called on the event during system bootup and PCI hotplug:
>>updating PCI bridge's windows after resource assignment/reassignment
>>are finished. For partial hotplug case, where not all PCI devices
>>belonging to the PE are unplugged and plugged again, we just need
>>unbinding/binding the affected PCI devices with the corresponding
>>PE without creating new one.
>>
>>Besides, it might require additional resources (e.g. M32) to the
>>windows of the PCI bridge when unplugging current adapter, and
>>insert a different adapter if there is one PCI slot, which is
>>assumed behind root port, or the downstream bridge of the PCIE
>>switch behind root port. The parent bridge of the newly plugged
>>adapter would reject the request to add more resources, leading
>>to hotplug failure. For the issue, the patch extends the windows
>>of root port, or the upstream port of the PCIe switch behind root
>>port to PHB's windows when ppc_md.pcibios_setup_bridge() is called.
>>
>>There is no upstream bridge for root bus, so we have to fix it up
>>before any PE is created because the root bus PE is the ancestor
>>to anyone else.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 226 ++++++++++++++++++------------
>>  arch/powerpc/platforms/powernv/pci.h      |   1 +
>>  2 files changed, 137 insertions(+), 90 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 8aa6ab8..37847a3 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -1083,6 +1083,13 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
>>  				pci_name(dev));
>>  			continue;
>>  		}
>>+
>>+		/* The PCI device might be not detached from the
>>+		 * PE in partial hotplug case.
>>+		 */
>>+		if (pdn->pe_number != IODA_INVALID_PE)
>>+			continue;
>>+
>>  		pdn->pe_number = pe->pe_number;
>>  		pe->dma32_weight += pnv_ioda_dma_weight(dev);
>>  		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
>>@@ -1101,9 +1108,27 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>>  	struct pci_controller *hose = pci_bus_to_host(bus);
>>  	struct pnv_phb *phb = hose->private_data;
>>  	struct pnv_ioda_pe *pe = NULL;
>>+	int pe_num;
>>+
>>+	/* For partial hotplug case, the PE instance hasn't been destroyed
>>+	 * yet. We shouldn't allocated a new one and assign resources to
>>+	 * it. The existing PE instance should be reused, but we should
>>+	 * associate the devices to the PE.
>>+	 */
>>+	pe_num = phb->ioda.pe_rmap[bus->number << 8];
>>+	if (pe_num != IODA_INVALID_PE) {
>>+		pe = &phb->ioda.pe_array[pe_num];
>>+		pnv_ioda_setup_same_PE(bus, pe);
>>+		return NULL;
>>+	}
>>+
>>+	/* PE number for root bus should have been reserved */
>>+	if (pci_is_root_bus(bus) &&
>>+	    phb->ioda.root_pe_idx != IODA_INVALID_PE)
>>+		pe = &phb->ioda.pe_array[phb->ioda.root_pe_idx];
>>
>>  	/* Check if PE is determined by M64 */
>>-	if (phb->pick_m64_pe)
>>+	if (!pe && phb->pick_m64_pe)
>
>
>else if (phb->pick_m64_pe)
>

No. When this function is called for the root of root bus, the PE
should have been reserved. So we still have to check @pe.

>
>
>>  		pe = phb->pick_m64_pe(bus, all);
>>
>>  	/* The PE number isn't pinned by M64 */
>>@@ -1150,46 +1175,6 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>>  	return pe;
>>  }
>>
>>-static void pnv_ioda_setup_PEs(struct pci_bus *bus)
>>-{
>>-	struct pci_dev *dev;
>>-
>>-	pnv_ioda_setup_bus_PE(bus, false);
>>-
>>-	list_for_each_entry(dev, &bus->devices, bus_list) {
>>-		if (dev->subordinate) {
>>-			if (pci_pcie_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE)
>>-				pnv_ioda_setup_bus_PE(dev->subordinate, true);
>>-			else
>>-				pnv_ioda_setup_PEs(dev->subordinate);
>>-		}
>>-	}
>>-}
>>-
>>-/*
>>- * Configure PEs so that the downstream PCI buses and devices
>>- * could have their associated PE#. Unfortunately, we didn't
>>- * figure out the way to identify the PLX bridge yet. So we
>>- * simply put the PCI bus and the subordinate behind the root
>>- * port to PE# here. The game rule here is expected to be changed
>>- * as soon as we can detected PLX bridge correctly.
>>- */
>>-static void pnv_pci_ioda_setup_PEs(void)
>>-{
>>-	struct pci_controller *hose, *tmp;
>>-	struct pnv_phb *phb;
>>-
>>-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>>-		phb = hose->private_data;
>>-
>>-		/* M64 layout might affect PE allocation */
>>-		if (phb->reserve_m64_pe)
>>-			phb->reserve_m64_pe(hose->bus, NULL, true);
>>-
>>-		pnv_ioda_setup_PEs(hose->bus);
>>-	}
>>-}
>>-
>>  #ifdef CONFIG_PCI_IOV
>>  static int pnv_pci_vf_release_m64(struct pci_dev *pdev)
>>  {
>>@@ -2962,52 +2947,6 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>  	}
>>  }
>>
>>-static void pnv_pci_ioda_setup_seg(void)
>>-{
>>-	struct pci_controller *tmp, *hose;
>>-	struct pnv_phb *phb;
>>-	struct pnv_ioda_pe *pe;
>>-
>>-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>>-		phb = hose->private_data;
>>-		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>>-			pnv_ioda_setup_pe_seg(hose, pe);
>>-		}
>>-	}
>>-}
>>-
>>-static void pnv_pci_ioda_setup_DMA(void)
>>-{
>>-	struct pci_controller *hose, *tmp;
>>-	struct pnv_phb *phb;
>>-	struct pnv_ioda_pe *pe;
>>-
>>-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>>-		phb = hose->private_data;
>>-		pnv_pci_ioda_setup_opal_tce_kill(phb);
>>-
>>-		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
>>-			if (!pe->dma32_weight)
>>-				continue;
>>-
>>-			switch (phb->type) {
>>-			case PNV_PHB_IODA1:
>>-				pnv_ioda1_setup_dma(phb, pe);
>>-				break;
>>-			case PNV_PHB_IODA2:
>>-				pnv_pci_ioda2_setup_dma_pe(phb, pe);
>>-				break;
>>-			default:
>>-				pr_warn("%s: No DMA for PHB type %d\n",
>>-					__func__, phb->type);
>>-			}
>>-		}
>>-
>>-		/* Mark the PHB initialization done */
>>-		phb->initialized = 1;
>>-	}
>>-}
>>-
>>  static void pnv_pci_ioda_create_dbgfs(void)
>>  {
>>  #ifdef CONFIG_DEBUG_FS
>>@@ -3029,9 +2968,8 @@ static void pnv_pci_ioda_create_dbgfs(void)
>>
>>  static void pnv_pci_ioda_fixup(void)
>>  {
>>-	pnv_pci_ioda_setup_PEs();
>>-	pnv_pci_ioda_setup_seg();
>>-	pnv_pci_ioda_setup_DMA();
>>+	struct pci_controller *hose, *tmp;
>>+	struct pnv_phb *phb;
>>
>>  	pnv_pci_ioda_create_dbgfs();
>>
>>@@ -3039,6 +2977,12 @@ static void pnv_pci_ioda_fixup(void)
>>  	eeh_init();
>>  	eeh_addr_cache_build();
>>  #endif
>>+
>>+	/* Notify initialization of PHB done */
>>+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>>+		phb = hose->private_data;
>>+		phb->initialized = 1;
>>+	}
>>  }
>>
>>  /*
>>@@ -3082,6 +3026,105 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
>>  	return phb->ioda.io_segsize;
>>  }
>>
>>+/*
>>+ * We are updating root port or the upstream bridge behind the
>>+ * root port with PHB's windows in order to accommodate the
>>+ * changes on required resources during PCI (slot) hotplug,
>>+ * which is connected to either root port or the downstream
>>+ * ports of PCIe switch behind the root port.
>>+ */
>>+static void pnv_pci_fixup_bridge_resources(struct pci_bus *bus,
>>+					   unsigned long type)
>>+{
>>+	struct pci_controller *hose = pci_bus_to_host(bus);
>>+	struct pnv_phb *phb = hose->private_data;
>>+	struct pci_dev *bridge = bus->self;
>>+	struct resource *r, *w;
>>+	int i;
>>+
>>+	/* Check if we need apply fixup to the bridge's windows */
>>+	if (!pci_is_root_bus(bridge->bus) &&
>>+	    !pci_is_root_bus(bridge->bus->self->bus))
>>+		return;
>>+
>>+	/* Fixup the resoureces */
>>+	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
>>+		r = &bridge->resource[PCI_BRIDGE_RESOURCES + i];
>>+		if (!r->flags || !r->parent)
>>+			continue;
>>+
>>+		w = NULL;
>>+		if (r->flags & type & IORESOURCE_IO)
>>+			w = &hose->io_resource;
>>+		else if (pnv_pci_is_mem_pref_64(r->flags) &&
>>+			 (type & IORESOURCE_PREFETCH) &&
>>+			 phb->ioda.m64_segsize)
>>+			w = &hose->mem_resources[1];
>>+		else if (r->flags & type & IORESOURCE_MEM)
>>+			w = &hose->mem_resources[0];
>>+
>>+		r->start = w->start;
>>+		r->end = w->end;
>>+	}
>>+}
>>+
>>+static void pnv_pci_setup_bridge(struct pci_bus *bus,
>>+				 unsigned long type)
>>+{
>>+	struct pci_controller *hose = pci_bus_to_host(bus);
>>+	struct pnv_phb *phb = hose->private_data;
>>+	struct pci_dev *bridge = bus->self;
>>+	struct pnv_ioda_pe *pe;
>>+	bool all = (pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE);
>>+
>>+	/* The root bus (ancestor PE) should be finalized
>>+	 * before anyone else
>>+	 */
>>+	if (!phb->ioda.root_pe_is_populated) {
>>+		pe = pnv_ioda_setup_bus_PE(phb->hose->bus, false);
>>+		if (pe && phb->ioda.root_pe_idx == IODA_INVALID_PE)
>>+			phb->ioda.root_pe_idx = pe->pe_number;
>>+			phb->ioda.root_pe_is_populated = true;
>>+		}
>
>
>This "}" should be 1 tab left. Of you lost one "{" after if() and its
>counterpart.
>

Good catch! 

>>+
>>+	/* Extend bridge's windows if necessary */
>>+	pnv_pci_fixup_bridge_resources(bus, type);
>>+
>>+	/* Don't assign PE to bus which doesn't have any
>>+	 * subordinate PCI devices.
>>+	 */
>>+	if (list_empty(&bus->devices))
>>+		return;
>>+
>>+	/* Reserve PEs for M64 resource */
>>+	if (phb->reserve_m64_pe)
>>+		phb->reserve_m64_pe(bus, NULL, all);
>>+
>>+	/* Assign PE. We might run here because of partial hotplug.
>>+	 * For the case, we just pick up the existing PE and should
>>+	 * not allocate resources again.
>>+	 */
>>+	pe = pnv_ioda_setup_bus_PE(bus, all);
>>+	if (!pe)
>>+		return;
>>+
>>+	/* Setup MMIO mapping */
>>+	pnv_ioda_setup_pe_seg(hose, pe);
>>+
>>+	/* Setup DMA */
>>+	switch (phb->type) {
>>+	case PNV_PHB_IODA1:
>>+		pnv_ioda1_setup_dma(phb, pe);
>>+		break;
>>+	case PNV_PHB_IODA2:
>>+		pnv_pci_ioda2_setup_dma_pe(phb, pe);
>>+		break;
>>+	default:
>>+		pr_warn("%s: No DMA for PHB type %d\n",
>>+			__func__, phb->type);
>>+	}
>>+}
>>+
>>  #ifdef CONFIG_PCI_IOV
>>  static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>>  						      int resno)
>>@@ -3147,6 +3190,7 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
>>  #endif
>>         .enable_device_hook = pnv_pci_enable_device_hook,
>>         .window_alignment = pnv_pci_window_alignment,
>>+	.setup_bridge = pnv_pci_setup_bridge,
>>         .reset_secondary_bus = pnv_pci_reset_secondary_bus,
>>         .dma_set_mask = pnv_pci_ioda_dma_set_mask,
>>         .shutdown = pnv_pci_ioda_shutdown,
>>@@ -3218,6 +3262,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	if (phb->regs == NULL)
>>  		pr_err("  Failed to map registers !\n");
>>
>>+	pnv_pci_ioda_setup_opal_tce_kill(phb);
>>+
>>  	/* Initialize more IODA stuff */
>>  	phb->ioda.total_pe_num = 1;
>>  	prop32 = of_get_property(np, "ibm,opal-num-pes", NULL);
>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>index e93a489..a160491 100644
>>--- a/arch/powerpc/platforms/powernv/pci.h
>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>@@ -136,6 +136,7 @@ struct pnv_phb {
>>  			/* Global bridge info */
>>  			unsigned int		total_pe_num;
>>  			unsigned int		root_pe_idx;
>>+			bool			root_pe_is_populated;
>>  			unsigned int		reserved_pe_idx;
>>
>>  			/* 32-bit MMIO window */
>>

Thanks,
Gavin
