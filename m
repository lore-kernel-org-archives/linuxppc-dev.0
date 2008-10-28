Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Oct 2008 16:48:29 +1100
Subject: [PATCH 3/10] powerpc/pci: Use commont PHB resource hookup
In-Reply-To: <1225172895.217185.958686212130.qpush@grosgo>
Message-Id: <20081028054930.9D2E6DDEEC@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 32-bit and 64-bit powerpc PCI code used to setup the resource
pointers of the root bus of a given PHB in completely different
places.

This unifies this in large part, but making 32-bit use a routine very
similar to what 64-bit does when initially scanning the PCI busses.

The actual setup of the PHB resources itself is then moved to a
common function in pci-common.c

This should cause no functional change on 64-bit. On 32-bit, the effect
is that the PHB resources are going to be setup a bit earlier, instead
of being setup from pcibios_fixup_bus().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This is a pre-requisite to be able to remove pcibios_do_bus_setup()
in order to make the pcibios_fixup_bus() codepath common.

 arch/powerpc/include/asm/pci-bridge.h |    1 
 arch/powerpc/kernel/pci-common.c      |   58 +++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c          |   78 ++++++++++++++--------------------
 arch/powerpc/kernel/pci_64.c          |   19 +-------
 4 files changed, 96 insertions(+), 60 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/pci-bridge.h	2008-10-28 15:35:56.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pci-bridge.h	2008-10-28 15:37:23.000000000 +1100
@@ -290,6 +290,7 @@ extern void pci_process_bridge_OF_ranges
 /* Allocate & free a PCI host bridge structure */
 extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
+extern void pcibios_setup_phb_resources(struct pci_controller *hose);
 
 #ifdef CONFIG_PCI
 extern unsigned long pci_address_to_pio(phys_addr_t address);
Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-10-28 15:35:56.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-10-28 15:37:23.000000000 +1100
@@ -1423,3 +1423,61 @@ int pcibios_enable_device(struct pci_dev
 
 	return pci_enable_resources(dev, mask);
 }
+
+void __devinit pcibios_setup_phb_resources(struct pci_controller *hose)
+{
+	struct pci_bus *bus = hose->bus;
+	struct resource *res;
+	int i;
+
+	/* Hookup PHB IO resource */
+	bus->resource[0] = res = &hose->io_resource;
+
+	if (!res->flags) {
+		printk(KERN_WARNING "PCI: I/O resource not set for host"
+		       " bridge %s (domain %d)\n",
+		       hose->dn->full_name, hose->global_number);
+#ifdef CONFIG_PPC32
+		/* Workaround for lack of IO resource only on 32-bit */
+		res->start = (unsigned long)hose->io_base_virt - isa_io_base;
+		res->end = res->start + IO_SPACE_LIMIT;
+		res->flags = IORESOURCE_IO;
+#endif /* CONFIG_PPC32 */
+	}
+
+	pr_debug("PCI: PHB IO resource    = %016llx-%016llx [%lx]\n",
+		 (unsigned long long)res->start,
+		 (unsigned long long)res->end,
+		 (unsigned long)res->flags);
+
+	/* Hookup PHB Memory resources */
+	for (i = 0; i < 3; ++i) {
+		res = &hose->mem_resources[i];
+		if (!res->flags) {
+			if (i > 0)
+				continue;
+			printk(KERN_ERR "PCI: Memory resource 0 not set for "
+			       "host bridge %s (domain %d)\n",
+			       hose->dn->full_name, hose->global_number);
+#ifdef CONFIG_PPC32
+			/* Workaround for lack of MEM resource only on 32-bit */
+			res->start = hose->pci_mem_offset;
+			res->end = (resource_size_t)-1LL;
+			res->flags = IORESOURCE_MEM;
+#endif /* CONFIG_PPC32 */
+		}
+		bus->resource[i+1] = res;
+
+		pr_debug("PCI: PHB MEM resource %d = %016llx-%016llx [%lx]\n", i,
+			 (unsigned long long)res->start,
+			 (unsigned long long)res->end,
+			 (unsigned long)res->flags);
+	}
+
+	pr_debug("PCI: PHB MEM offset     = %016llx\n",
+		 (unsigned long long)hose->pci_mem_offset);
+	pr_debug("PCI: PHB IO  offset     = %08lx\n",
+		 (unsigned long)hose->io_base_virt - _IO_BASE);
+
+}
+
Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2008-10-28 15:35:56.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2008-10-28 15:42:13.000000000 +1100
@@ -373,10 +373,41 @@ void pcibios_make_OF_bus_map(void)
 }
 #endif /* CONFIG_PPC_OF */
 
+static void __devinit pcibios_scan_phb(struct pci_controller *hose)
+{
+	struct pci_bus *bus;
+	struct device_node *node = hose->dn;
+	unsigned long io_offset;
+	struct resource *res = &hose->io_resource;
+
+	pr_debug("PCI: Scanning PHB %s\n",
+		 node ? node->full_name : "<NO NAME>");
+
+	/* Create an empty bus for the toplevel */
+	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, hose);
+	if (bus == NULL) {
+		printk(KERN_ERR "Failed to create bus for PCI domain %04x\n",
+		       hose->global_number);
+		return;
+	}
+	bus->secondary = hose->first_busno;
+	hose->bus = bus;
+
+	/* Fixup IO space offset */
+	io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
+	res->start = (res->start + io_offset) & 0xffffffffu;
+	res->end = (res->end + io_offset) & 0xffffffffu;
+
+	/* Wire up PHB bus resources */
+	pcibios_setup_phb_resources(hose);
+
+	/* Scan children */
+	hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
+}
+
 static int __init pcibios_init(void)
 {
 	struct pci_controller *hose, *tmp;
-	struct pci_bus *bus;
 	int next_busno = 0;
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
@@ -389,12 +420,8 @@ static int __init pcibios_init(void)
 		if (pci_assign_all_buses)
 			hose->first_busno = next_busno;
 		hose->last_busno = 0xff;
-		bus = pci_scan_bus_parented(hose->parent, hose->first_busno,
-					    hose->ops, hose);
-		if (bus) {
-			pci_bus_add_devices(bus);
-			hose->last_busno = bus->subordinate;
-		}
+		pcibios_scan_phb(hose);
+		pci_bus_add_devices(hose->bus);
 		if (pci_assign_all_buses || next_busno <= hose->last_busno)
 			next_busno = hose->last_busno + pcibios_assign_bus_offset;
 	}
@@ -421,45 +448,8 @@ subsys_initcall(pcibios_init);
 
 void __devinit pcibios_do_bus_setup(struct pci_bus *bus)
 {
-	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
-	unsigned long io_offset;
-	struct resource *res;
-	int i;
 	struct pci_dev *dev;
 
-	/* Hookup PHB resources */
-	io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
-	if (bus->parent == NULL) {
-		/* This is a host bridge - fill in its resources */
-		hose->bus = bus;
-
-		bus->resource[0] = res = &hose->io_resource;
-		if (!res->flags) {
-			if (io_offset)
-				printk(KERN_ERR "I/O resource not set for host"
-				       " bridge %d\n", hose->global_number);
-			res->start = 0;
-			res->end = IO_SPACE_LIMIT;
-			res->flags = IORESOURCE_IO;
-		}
-		res->start = (res->start + io_offset) & 0xffffffffu;
-		res->end = (res->end + io_offset) & 0xffffffffu;
-
-		for (i = 0; i < 3; ++i) {
-			res = &hose->mem_resources[i];
-			if (!res->flags) {
-				if (i > 0)
-					continue;
-				printk(KERN_ERR "Memory resource not set for "
-				       "host bridge %d\n", hose->global_number);
-				res->start = hose->pci_mem_offset;
-				res->end = ~0U;
-				res->flags = IORESOURCE_MEM;
-			}
-			bus->resource[i+1] = res;
-		}
-	}
-
 	if (ppc_md.pci_dma_bus_setup)
 		ppc_md.pci_dma_bus_setup(bus);
 
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2008-10-28 15:35:56.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_64.c	2008-10-28 15:37:23.000000000 +1100
@@ -322,7 +322,7 @@ void __devinit scan_phb(struct pci_contr
 {
 	struct pci_bus *bus;
 	struct device_node *node = hose->dn;
-	int i, mode;
+	int mode;
 
 	pr_debug("PCI: Scanning PHB %s\n",
 		 node ? node->full_name : "<NO NAME>");
@@ -341,20 +341,7 @@ void __devinit scan_phb(struct pci_contr
 	pcibios_map_io_space(bus);
 
 	/* Wire up PHB bus resources */
-	pr_debug("PCI: PHB IO resource    = %016lx-%016lx [%lx]\n",
-		 hose->io_resource.start, hose->io_resource.end,
-		 hose->io_resource.flags);
-	bus->resource[0] = &hose->io_resource;
-	for (i = 0; i < 3; ++i) {
-		pr_debug("PCI: PHB MEM resource %d = %016lx-%016lx [%lx]\n", i,
-			 hose->mem_resources[i].start,
-			 hose->mem_resources[i].end,
-			 hose->mem_resources[i].flags);
-		bus->resource[i+1] = &hose->mem_resources[i];
-	}
-	pr_debug("PCI: PHB MEM offset     = %016lx\n", hose->pci_mem_offset);
-	pr_debug("PCI: PHB IO  offset     = %08lx\n",
-	    (unsigned long)hose->io_base_virt - _IO_BASE);
+	pcibios_setup_phb_resources(hose);
 
 	/* Get probe mode and perform scan */
 	mode = PCI_PROBE_NORMAL;
@@ -376,7 +363,7 @@ static int __init pcibios_init(void)
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
-	/* For now, override phys_mem_access_prot. If we need it,
+	/* For now, override phys_mem_access_prot. If we need it,g
 	 * later, we may move that initialization to each ppc_md
 	 */
 	ppc_md.phys_mem_access_prot = pci_phys_mem_access_prot;
