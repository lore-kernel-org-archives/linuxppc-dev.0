Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 525EBB7CCC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 15:30:29 +1000 (EST)
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.224])
	by ozlabs.org (Postfix) with ESMTP id 82434DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 15:30:28 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id b25so161085rvf.9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 22:30:28 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/3] powerpc/pci: Merge ppc32 and ppc64 versions of phb_scan()
To: benh@kernel.crashing.org, galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Date: Thu, 20 Aug 2009 23:30:25 -0600
Message-ID: <20090821053022.2289.98634.stgit@localhost.localdomain>
In-Reply-To: <20090821052714.2289.41279.stgit@localhost.localdomain>
References: <20090821052714.2289.41279.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The two versions are doing almost exactly the same thing.  No need to
maintain them as separate files.  This patch also has the side effect
of making the PCI device tree scanning code available to 32 bit powerpc
machines, but no board ports actually make use of this feature at this
point.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/include/asm/pci.h   |    2 ++
 arch/powerpc/kernel/pci-common.c |   48 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c     |   25 ++------------------
 arch/powerpc/kernel/pci_64.c     |   46 +++++-------------------------------
 4 files changed, 58 insertions(+), 63 deletions(-)


diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 9ae2e3e..feebfed 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -233,6 +233,8 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 
 extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
+extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
+extern void pcibios_scan_phb(struct pci_controller *hose, void *data);
 
 #endif	/* __KERNEL__ */
 #endif /* __ASM_POWERPC_PCI_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 3762525..7d5bf1b 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1956,3 +1956,51 @@ void __devinit of_rescan_bus(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(of_rescan_bus);
 
+/**
+ * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
+ * @hose: Pointer to the PCI host controller instance structure
+ * @data: value to use for sysdata pointer.  ppc32 and ppc64 differ here
+ *
+ * Note: the 'data' pointer is a temporary measure.  As 32 and 64 bit
+ * pci code gets merged, this parameter should become unnecessary because
+ * both will use the same value.
+ */
+void __devinit pcibios_scan_phb(struct pci_controller *hose, void *data)
+{
+	struct pci_bus *bus;
+	struct device_node *node = hose->dn;
+	int mode;
+
+	pr_debug("PCI: Scanning PHB %s\n",
+		 node ? node->full_name : "<NO NAME>");
+
+	/* Create an empty bus for the toplevel */
+	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, data);
+	if (bus == NULL) {
+		pr_err("Failed to create bus for PCI domain %04x\n",
+			hose->global_number);
+		return;
+	}
+	bus->secondary = hose->first_busno;
+	hose->bus = bus;
+
+	/* Get some IO space for the new PHB */
+	pcibios_setup_phb_io_space(hose);
+
+	/* Wire up PHB bus resources */
+	pcibios_setup_phb_resources(hose);
+
+	/* Get probe mode and perform scan */
+	mode = PCI_PROBE_NORMAL;
+	if (node && ppc_md.pci_probe_mode)
+		mode = ppc_md.pci_probe_mode(bus);
+	pr_debug("    probe mode: %d\n", mode);
+	if (mode == PCI_PROBE_DEVTREE) {
+		bus->subordinate = hose->last_busno;
+		of_scan_bus(node, bus);
+	}
+
+	if (mode == PCI_PROBE_NORMAL)
+		hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
+}
+
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 1e807fe..4e415e1 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -354,36 +354,15 @@ pci_create_OF_bus_map(void)
 	}
 }
 
-static void __devinit pcibios_scan_phb(struct pci_controller *hose)
+void __devinit pcibios_setup_phb_io_space(struct pci_controller *hose)
 {
-	struct pci_bus *bus;
-	struct device_node *node = hose->dn;
 	unsigned long io_offset;
 	struct resource *res = &hose->io_resource;
 
-	pr_debug("PCI: Scanning PHB %s\n",
-		 node ? node->full_name : "<NO NAME>");
-
-	/* Create an empty bus for the toplevel */
-	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, hose);
-	if (bus == NULL) {
-		printk(KERN_ERR "Failed to create bus for PCI domain %04x\n",
-		       hose->global_number);
-		return;
-	}
-	bus->secondary = hose->first_busno;
-	hose->bus = bus;
-
 	/* Fixup IO space offset */
 	io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
 	res->start = (res->start + io_offset) & 0xffffffffu;
 	res->end = (res->end + io_offset) & 0xffffffffu;
-
-	/* Wire up PHB bus resources */
-	pcibios_setup_phb_resources(hose);
-
-	/* Scan children */
-	hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
 }
 
 static int __init pcibios_init(void)
@@ -401,7 +380,7 @@ static int __init pcibios_init(void)
 		if (pci_assign_all_buses)
 			hose->first_busno = next_busno;
 		hose->last_busno = 0xff;
-		pcibios_scan_phb(hose);
+		pcibios_scan_phb(hose, hose);
 		pci_bus_add_devices(hose->bus);
 		if (pci_assign_all_buses || next_busno <= hose->last_busno)
 			next_busno = hose->last_busno + pcibios_assign_bus_offset;
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 4d5b4ce..ba949a2 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -43,45 +43,6 @@ unsigned long pci_probe_only = 1;
 unsigned long pci_io_base = ISA_IO_BASE;
 EXPORT_SYMBOL(pci_io_base);
 
-void __devinit scan_phb(struct pci_controller *hose)
-{
-	struct pci_bus *bus;
-	struct device_node *node = hose->dn;
-	int mode;
-
-	pr_debug("PCI: Scanning PHB %s\n",
-		 node ? node->full_name : "<NO NAME>");
-
-	/* Create an empty bus for the toplevel */
-	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, node);
-	if (bus == NULL) {
-		printk(KERN_ERR "Failed to create bus for PCI domain %04x\n",
-		       hose->global_number);
-		return;
-	}
-	bus->secondary = hose->first_busno;
-	hose->bus = bus;
-
-	/* Get some IO space for the new PHB */
-	pcibios_map_io_space(bus);
-
-	/* Wire up PHB bus resources */
-	pcibios_setup_phb_resources(hose);
-
-	/* Get probe mode and perform scan */
-	mode = PCI_PROBE_NORMAL;
-	if (node && ppc_md.pci_probe_mode)
-		mode = ppc_md.pci_probe_mode(bus);
-	pr_debug("    probe mode: %d\n", mode);
-	if (mode == PCI_PROBE_DEVTREE) {
-		bus->subordinate = hose->last_busno;
-		of_scan_bus(node, bus);
-	}
-
-	if (mode == PCI_PROBE_NORMAL)
-		hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
-}
-
 static int __init pcibios_init(void)
 {
 	struct pci_controller *hose, *tmp;
@@ -103,7 +64,7 @@ static int __init pcibios_init(void)
 
 	/* Scan all of the recorded PCI controllers.  */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		scan_phb(hose);
+		pcibios_scan_phb(hose, hose->dn);
 		pci_bus_add_devices(hose->bus);
 	}
 
@@ -237,6 +198,11 @@ int __devinit pcibios_map_io_space(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_map_io_space);
 
+void __devinit pcibios_setup_phb_io_space(struct pci_controller *hose)
+{
+	pcibios_map_io_space(hose->bus);
+}
+
 #define IOBASE_BRIDGE_NUMBER	0
 #define IOBASE_MEMORY		1
 #define IOBASE_IO		2
