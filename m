Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f190.google.com (mail-px0-f190.google.com
	[209.85.216.190])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 0C218B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 04:58:21 +1000 (EST)
Received: by pxi28 with SMTP id 28so2535622pxi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 11:58:20 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH V3] powerpc/pci: Merge ppc32 and ppc64 versions of phb_scan()
To: benh@kernel.crashing.org, galak@kernel.crashing.org, sfr@canb.auug.org.au,
	linuxppc-dev@lists.ozlabs.org
Date: Fri, 28 Aug 2009 12:58:16 -0600
Message-ID: <20090828185628.14427.80061.stgit@localhost.localdomain>
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
Acked-by: Kumar Gala <galak@kernel.crashing.org>
---

Changes in v3: Fixed up calls to scan_phb() in of_platform.c and
               pc_dlpar.c
Changes in v2: renamed pcibios_scan_phb 'data' argument to 'sysdata'

 arch/powerpc/include/asm/pci.h             |    2 +
 arch/powerpc/include/asm/ppc-pci.h         |    1 -
 arch/powerpc/kernel/of_platform.c          |    2 +
 arch/powerpc/kernel/pci-common.c           |   49 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c               |   25 +-------------
 arch/powerpc/kernel/pci_64.c               |   46 +++-----------------------
 arch/powerpc/platforms/pseries/pci_dlpar.c |    2 +
 7 files changed, 61 insertions(+), 66 deletions(-)


diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 9ae2e3e..6205a24 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -233,6 +233,8 @@ extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
 
 extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
+extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
+extern void pcibios_scan_phb(struct pci_controller *hose, void *sysdata);
 
 #endif	/* __KERNEL__ */
 #endif /* __ASM_POWERPC_PCI_H */
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 854ab71..2828f9d 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -39,7 +39,6 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
 
 extern void pci_devs_phb_init(void);
 extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
-extern void scan_phb(struct pci_controller *hose);
 
 /* From rtas_pci.h */
 extern void init_pci_config_tokens (void);
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index 87df428..1a4fc0d 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -276,7 +276,7 @@ static int __devinit of_pci_phb_probe(struct of_device *dev,
 #endif /* CONFIG_EEH */
 
 	/* Scan the bus */
-	scan_phb(phb);
+	pcibios_scan_phb(phb, dev->node);
 	if (phb->bus == NULL)
 		return -ENXIO;
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 44497a8..6e02df4 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1617,3 +1617,52 @@ void __devinit pcibios_setup_phb_resources(struct pci_controller *hose)
 		 (unsigned long)hose->io_base_virt - _IO_BASE);
 
 }
+
+/**
+ * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
+ * @hose: Pointer to the PCI host controller instance structure
+ * @sysdata: value to use for sysdata pointer.  ppc32 and ppc64 differ here
+ *
+ * Note: the 'data' pointer is a temporary measure.  As 32 and 64 bit
+ * pci code gets merged, this parameter should become unnecessary because
+ * both will use the same value.
+ */
+void __devinit pcibios_scan_phb(struct pci_controller *hose, void *sysdata)
+{
+	struct pci_bus *bus;
+	struct device_node *node = hose->dn;
+	int mode;
+
+	pr_debug("PCI: Scanning PHB %s\n",
+		 node ? node->full_name : "<NO NAME>");
+
+	/* Create an empty bus for the toplevel */
+	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops,
+			     sysdata);
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
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index ad152a0..b6fa3e4 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -151,7 +151,7 @@ struct pci_controller * __devinit init_phb_dynamic(struct device_node *dn)
 	if (dn->child)
 		eeh_add_device_tree_early(dn);
 
-	scan_phb(phb);
+	pcibios_scan_phb(phb, dn);
 	pcibios_finish_adding_to_bus(phb->bus);
 
 	return phb;
