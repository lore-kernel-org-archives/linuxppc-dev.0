Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9z0H3S3kzDqDH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:11 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 20 May 2016 16:43:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6658E357805C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:07 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4K6gxqc3932544
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:07 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4K6gYhA032197
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:35 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 alistair@popple.id.au, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v10 09/18] powerpc/powernv: Extend PCI bridge resources
Date: Fri, 20 May 2016 16:41:33 +1000
Message-Id: <1463726502-14679-10-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
index 3186a29..e97a5fa 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3221,6 +3221,49 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
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
@@ -3229,6 +3272,9 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
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
