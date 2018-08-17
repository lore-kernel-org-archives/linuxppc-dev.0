Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sKNw33gNzDrHP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:36:00 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 06/15] powerpc/pci: fold pci_create_root_bus into
 pcibios_scan_phb
Date: Fri, 17 Aug 2018 12:26:36 +0200
Message-Id: <20180817102645.3839621-7-arnd@arndb.de>
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This slightly simplifies the pcibios_scan_phb() implementation, and
gives us an easier point to add further fields in the pci_host_bridge
structure.

I tried removing fields that are duplicated between pci_host_bridge
and pci_controller (which really serve the same purpose), but
ran into the problem that we can't call pci_alloc_host_bridge()
as early as pcibios_alloc_controller(). Some more refactoring
is needed for that, but it could noticably clean the powerpc code
up more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/pci-bridge.h |  3 ++
 arch/powerpc/kernel/pci-common.c      | 72 ++++++++++-----------------
 2 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 94d449031b18..42ae567084d9 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -51,8 +51,11 @@ struct pci_controller_ops {
 
 /*
  * Structure of a PCI controller (host bridge)
+ * Some members here are duplicated in struct pci_host_bridge
+ * and should be moved there.
  */
 struct pci_controller {
+	struct pci_host_bridge *bridge;
 	struct pci_bus *bus;
 	char is_dynamic;
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 57ca621a32f4..096011ec8670 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1587,81 +1587,63 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 	return of_node_get(hose->dn);
 }
 
-static struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
-{
-	int error;
-	struct pci_host_bridge *bridge;
-
-	bridge = pci_alloc_host_bridge(0);
-	if (!bridge)
-		return NULL;
-
-	bridge->dev.parent = parent;
-
-	list_splice_init(resources, &bridge->windows);
-	bridge->sysdata = sysdata;
-	bridge->busnr = bus;
-	bridge->ops = ops;
-
-	error = pci_register_host_bridge(bridge);
-	if (error < 0)
-		goto err_out;
-
-	return bridge->bus;
-
-err_out:
-	kfree(bridge);
-	return NULL;
-}
-
 /**
  * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
  * @hose: Pointer to the PCI host controller instance structure
  */
 void pcibios_scan_phb(struct pci_controller *hose)
 {
-	LIST_HEAD(resources);
-	struct pci_bus *bus;
 	struct device_node *node = hose->dn;
 	int mode;
+	struct pci_host_bridge *bridge;
+	int error;
 
 	pr_debug("PCI: Scanning PHB %pOF\n", node);
 
+	/* The allocation should ideally be done in pcibios_alloc_controller(),
+	 * but pci_alloc_host_bridge() requires slab to work first */
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return;
+
 	/* Get some IO space for the new PHB */
 	pcibios_setup_phb_io_space(hose);
 
 	/* Wire up PHB bus resources */
-	pcibios_setup_phb_resources(hose, &resources);
+	pcibios_setup_phb_resources(hose, &bridge->windows);
 
 	hose->busn.start = hose->first_busno;
 	hose->busn.end	 = hose->last_busno;
 	hose->busn.flags = IORESOURCE_BUS;
-	pci_add_resource(&resources, &hose->busn);
+	pci_add_resource(&bridge->windows, &hose->busn);
+
+	bridge->dev.parent = hose->parent;
+	bridge->sysdata = hose;
+	bridge->busnr = hose->first_busno;
+	bridge->ops = hose->ops;
 
-	/* Create an empty bus for the toplevel */
-	bus = pci_create_root_bus(hose->parent, hose->first_busno,
-				  hose->ops, hose, &resources);
-	if (bus == NULL) {
+	error = pci_register_host_bridge(bridge);
+	if (error < 0) {
 		pr_err("Failed to create bus for PCI domain %04x\n",
 			hose->global_number);
-		pci_free_resource_list(&resources);
+		pci_free_host_bridge(bridge);
 		return;
 	}
-	hose->bus = bus;
+	hose->bridge = bridge;
+	hose->bus = bridge->bus;
 
 	/* Get probe mode and perform scan */
 	mode = PCI_PROBE_NORMAL;
 	if (node && hose->controller_ops.probe_mode)
-		mode = hose->controller_ops.probe_mode(bus);
+		mode = hose->controller_ops.probe_mode(bridge->bus);
 	pr_debug("    probe mode: %d\n", mode);
 	if (mode == PCI_PROBE_DEVTREE)
-		of_scan_bus(node, bus);
+		of_scan_bus(node, bridge->bus);
 
 	if (mode == PCI_PROBE_NORMAL) {
-		pci_bus_update_busn_res_end(bus, 255);
-		hose->last_busno = pci_scan_child_bus(bus);
-		pci_bus_update_busn_res_end(bus, hose->last_busno);
+		pci_bus_update_busn_res_end(bridge->bus, 255);
+		hose->last_busno = pci_scan_child_bus(bridge->bus);
+		pci_bus_update_busn_res_end(bridge->bus, hose->last_busno);
 	}
 
 	/* Platform gets a chance to do some global fixups before
@@ -1671,9 +1653,9 @@ void pcibios_scan_phb(struct pci_controller *hose)
 		ppc_md.pcibios_fixup_phb(hose);
 
 	/* Configure PCI Express settings */
-	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
+	if (bridge->bus && !pci_has_flag(PCI_PROBE_ONLY)) {
 		struct pci_bus *child;
-		list_for_each_entry(child, &bus->children, node)
+		list_for_each_entry(child, &bridge->bus->children, node)
 			pcie_bus_configure_settings(child);
 	}
 }
-- 
2.18.0
