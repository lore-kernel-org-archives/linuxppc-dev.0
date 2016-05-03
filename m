Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhgm65f3zDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:23:16 +1000 (AEST)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 18:53:14 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 89359125805C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:55:15 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43DNCVq24313886
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:12 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43DNDAF031665
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:16 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 08/22] powerpc/powernv: Extend PCI bridge resources
Date: Tue,  3 May 2016 23:22:39 +1000
Message-Id: <1462281773-26438-9-git-send-email-gwshan@linux.vnet.ibm.com>
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

The PCI slots are associated with root port or downstream ports
of the PCIe switch connected to root port. When adapter is hot
added to the PCI slot, it usually requests more IO or memory
resource from the directly connected parent bridge (port) and
update the bridge's windows accordingly. The resource windows
of upstream bridges can't be updated automatically. It possibly
leads to unbalanced resource across the bridges: The window of
downstream bridge is overruning that of upstream bridge. The
IO or MMIO path won't work.

This resolves the above issue by extending bridge windows of
root port and upstream port of the PCIe switch connected to
the root port to PHB's windows.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index de3f292..b518364 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3146,6 +3146,49 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
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
+	/* Fixup the resources */
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
 static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
@@ -3154,6 +3197,9 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 	struct pnv_ioda_pe *pe;
 	bool all = (pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE);
 
+	/* Extend bridge's windows if necessary */
+	pnv_pci_fixup_bridge_resources(bus, type);
+
 	/* The PE for root bus should be realized before any one else */
 	if (!phb->ioda.root_pe_populated) {
 		pe = pnv_ioda_setup_bus_PE(phb->hose->bus, false);
-- 
2.1.0
