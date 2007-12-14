Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 14 Dec 2007 15:56:08 +1100
Subject: [PATCH 8/15] [POWERPC] Merge PCI resource fixups
In-Reply-To: <1197608163.200976.87755569596.qpush@grosgo>
Message-Id: <20071214045615.C7AB9DE63B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PCI code in 32 and 64 bits fixes up resources differently.

32 bits uses a header quirk plus handles bridges in pcibios_fixup_bus()
while 64 bits does things in various places depending on whether you
are using OF probing, using PCI hotplug, etc...

This merges those by basically using the 32 bits approach for both,
with various tweaks to make 64 bits work with the new approach.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c           |  130 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c               |   83 ------------------
 arch/powerpc/kernel/pci_64.c               |  104 +++--------------------
 arch/powerpc/platforms/pseries/pci_dlpar.c |   14 +--
 drivers/pci/hotplug/rpadlpar_core.c        |    2 
 include/asm-powerpc/machdep.h              |   14 +--
 include/asm-powerpc/pci-bridge.h           |    2 
 include/asm-powerpc/pci.h                  |    6 -
 8 files changed, 167 insertions(+), 188 deletions(-)

--- linux-merge.orig/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:31.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:31.000000000 +1100
@@ -691,3 +691,133 @@ void pcibios_bus_to_resource(struct pci_
 	res->end = (region->end + offset) & mask;
 }
 EXPORT_SYMBOL(pcibios_bus_to_resource);
+
+/* Fixup a bus resource into a linux resource */
+static void __devinit fixup_resource(struct resource *res, struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	resource_size_t offset = 0, mask = (resource_size_t)-1;
+
+	if (res->flags & IORESOURCE_IO) {
+		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+		mask = 0xffffffffu;
+	} else if (res->flags & IORESOURCE_MEM)
+		offset = hose->pci_mem_offset;
+
+	res->start = (res->start + offset) & mask;
+	res->end = (res->end + offset) & mask;
+
+	pr_debug("PCI:%s            %016llx-%016llx\n",
+		 pci_name(dev),
+		 (unsigned long long)res->start,
+		 (unsigned long long)res->end);
+}
+
+
+/* This header fixup will do the resource fixup for all devices as they are
+ * probed, but not for bridge ranges
+ */
+static void __devinit pcibios_fixup_resources(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	int i;
+
+	if (!hose) {
+		printk(KERN_ERR "No host bridge for PCI dev %s !\n",
+		       pci_name(dev));
+		return;
+	}
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		struct resource *res = dev->resource + i;
+		if (!res->flags)
+			continue;
+		if (res->end == 0xffffffff) {
+			pr_debug("PCI:%s Resource %d %016llx-%016llx [%x] is unassigned\n",
+				 pci_name(dev), i,
+				 (unsigned long long)res->start,
+				 (unsigned long long)res->end,
+				 (unsigned int)res->flags);
+			res->end -= res->start;
+			res->start = 0;
+			res->flags |= IORESOURCE_UNSET;
+			continue;
+		}
+
+		pr_debug("PCI:%s Resource %d %016llx-%016llx [%x] fixup...\n",
+			 pci_name(dev), i,
+			 (unsigned long long)res->start,\
+			 (unsigned long long)res->end,
+			 (unsigned int)res->flags);
+
+		fixup_resource(res, dev);
+	}
+
+	/* Call machine specific resource fixup */
+	if (ppc_md.pcibios_fixup_resources)
+		ppc_md.pcibios_fixup_resources(dev);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resources);
+
+static void __devinit __pcibios_fixup_bus(struct pci_bus *bus)
+{
+	struct pci_dev *dev = bus->self;
+
+	pr_debug("PCI: Fixup bus %d (%s)\n", bus->number, dev ? pci_name(dev) : "PHB");
+
+	/* Fixup PCI<->PCI bridges. Host bridges are handled separately, for
+	 * now differently between 32 and 64 bits.
+	 */
+	if (dev != NULL) {
+		struct resource *res;
+		int i;
+
+		for (i = 0; i < PCI_BUS_NUM_RESOURCES; ++i) {
+			if ((res = bus->resource[i]) == NULL)
+				continue;
+			if (!res->flags || bus->self->transparent)
+				continue;
+
+			pr_debug("PCI:%s Bus rsrc %d %016llx-%016llx [%x] fixup...\n",
+				 pci_name(dev), i,
+				 (unsigned long long)res->start,\
+				 (unsigned long long)res->end,
+				 (unsigned int)res->flags);
+
+			fixup_resource(res, dev);
+		}
+	}
+
+	/* Additional setup that is different between 32 and 64 bits for now */
+	pcibios_do_bus_setup(bus);
+
+	/* Platform specific bus fixups */
+	if (ppc_md.pcibios_fixup_bus)
+		ppc_md.pcibios_fixup_bus(bus);
+
+	/* Read default IRQs and fixup if necessary */
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pci_read_irq_line(dev);
+		if (ppc_md.pci_irq_fixup)
+			ppc_md.pci_irq_fixup(dev);
+	}
+}
+
+void __devinit pcibios_fixup_bus(struct pci_bus *bus)
+{
+	/* When called from the generic PCI probe, read PCI<->PCI bridge
+	 * bases before proceeding
+	 */
+	if (bus->self != NULL)
+		pci_read_bridge_bases(bus);
+	__pcibios_fixup_bus(bus);
+}
+EXPORT_SYMBOL(pcibios_fixup_bus);
+
+/* When building a bus from the OF tree rather than probing, we need a
+ * slightly different version of the fixup which doesn't read the
+ * bridge bases using config space accesses
+ */
+void __devinit pcibios_fixup_of_probed_bus(struct pci_bus *bus)
+{
+	__pcibios_fixup_bus(bus);
+}
Index: linux-merge/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:31.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:31.000000000 +1100
@@ -40,7 +40,6 @@ unsigned int ppc_pci_flags;
 
 void pcibios_make_OF_bus_map(void);
 
-static void pcibios_fixup_resources(struct pci_dev* dev);
 static void fixup_broken_pcnet32(struct pci_dev* dev);
 static int reparent_resources(struct resource *parent, struct resource *res);
 static void fixup_cpc710_pci64(struct pci_dev* dev);
@@ -98,53 +97,6 @@ fixup_cpc710_pci64(struct pci_dev* dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixup_cpc710_pci64);
 
-static void
-pcibios_fixup_resources(struct pci_dev *dev)
-{
-	struct pci_controller* hose = (struct pci_controller *)dev->sysdata;
-	int i;
-	resource_size_t offset, mask;
-
-	if (!hose) {
-		printk(KERN_ERR "No hose for PCI dev %s!\n", pci_name(dev));
-		return;
-	}
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		struct resource *res = dev->resource + i;
-		if (!res->flags)
-			continue;
-		if (res->end == 0xffffffff) {
-			DBG("PCI:%s Resource %d [%016llx-%016llx] is unassigned\n",
-			    pci_name(dev), i, (u64)res->start, (u64)res->end);
-			res->end -= res->start;
-			res->start = 0;
-			res->flags |= IORESOURCE_UNSET;
-			continue;
-		}
-		offset = 0;
-		mask = (resource_size_t)-1;
-		if (res->flags & IORESOURCE_MEM) {
-			offset = hose->pci_mem_offset;
-		} else if (res->flags & IORESOURCE_IO) {
-			offset = (unsigned long) hose->io_base_virt
-				- isa_io_base;
-			mask = 0xffffffffu;
-		}
-		if (offset != 0) {
-			res->start = (res->start + offset) & mask;
-			res->end = (res->end + offset) & mask;
-			DBG("PCI: Fixup res %d (0x%lx) of dev %s: %llx -> %llx\n",
-			    i, res->flags, pci_name(dev),
-			    (u64)res->start - offset, (u64)res->start);
-		}
-	}
-
-	/* Call machine specific resource fixup */
-	if (ppc_md.pcibios_fixup_resources)
-		ppc_md.pcibios_fixup_resources(dev);
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID,		PCI_ANY_ID,			pcibios_fixup_resources);
-
 static int skip_isa_ioresource_align(struct pci_dev *dev)
 {
 	if ((ppc_pci_flags & PPC_PCI_CAN_SKIP_ISA_ALIGN) &&
@@ -757,14 +709,14 @@ pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-void pcibios_fixup_bus(struct pci_bus *bus)
+void __devinit pcibios_do_bus_setup(struct pci_bus *bus)
 {
 	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
 	unsigned long io_offset;
 	struct resource *res;
-	struct pci_dev *dev;
 	int i;
 
+	/* Hookup PHB resources */
 	io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
 	if (bus->parent == NULL) {
 		/* This is a host bridge - fill in its resources */
@@ -795,37 +747,6 @@ void pcibios_fixup_bus(struct pci_bus *b
 			}
 			bus->resource[i+1] = res;
 		}
-	} else {
-		/* This is a subordinate bridge */
-		pci_read_bridge_bases(bus);
-
-		for (i = 0; i < 4; ++i) {
-			if ((res = bus->resource[i]) == NULL)
-				continue;
-			if (!res->flags || bus->self->transparent)
-				continue;
-			if (io_offset && (res->flags & IORESOURCE_IO)) {
-				res->start = (res->start + io_offset) &
-					0xffffffffu;
-				res->end = (res->end + io_offset) &
-					0xffffffffu;
-			} else if (hose->pci_mem_offset
-				   && (res->flags & IORESOURCE_MEM)) {
-				res->start += hose->pci_mem_offset;
-				res->end += hose->pci_mem_offset;
-			}
-		}
-	}
-
-	/* Platform specific bus fixups */
-	if (ppc_md.pcibios_fixup_bus)
-		ppc_md.pcibios_fixup_bus(bus);
-
-	/* Read default IRQs and fixup if necessary */
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_read_irq_line(dev);
-		if (ppc_md.pci_irq_fixup)
-			ppc_md.pci_irq_fixup(dev);
 	}
 }
 
Index: linux-merge/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/pci_64.c	2007-12-14 15:49:31.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_64.c	2007-12-14 15:49:31.000000000 +1100
@@ -41,9 +41,6 @@
 
 unsigned long pci_probe_only = 1;
 
-static void fixup_resource(struct resource *res, struct pci_dev *dev);
-static void do_bus_setup(struct pci_bus *bus);
-
 /* pci_io_base -- the base address from which io bars are offsets.
  * This is the lowest I/O base address (so bar values are always positive),
  * and it *must* be the start of ISA space if an ISA bus exists because
@@ -223,7 +220,6 @@ static void pci_parse_of_addrs(struct de
 		res->end = base + size - 1;
 		res->flags = flags;
 		res->name = pci_name(dev);
-		fixup_resource(res, dev);
 	}
 }
 
@@ -292,7 +288,7 @@ struct pci_dev *of_create_pci_dev(struct
 EXPORT_SYMBOL(of_create_pci_dev);
 
 void __devinit of_scan_bus(struct device_node *node,
-				  struct pci_bus *bus)
+			   struct pci_bus *bus)
 {
 	struct device_node *child = NULL;
 	const u32 *reg;
@@ -301,6 +297,7 @@ void __devinit of_scan_bus(struct device
 
 	DBG("of_scan_bus(%s) bus no %d... \n", node->full_name, bus->number);
 
+	/* Scan direct children */
 	while ((child = of_get_next_child(node, child)) != NULL) {
 		DBG("  * %s\n", child->full_name);
 		reg = of_get_property(child, "reg", &reglen);
@@ -312,19 +309,26 @@ void __devinit of_scan_bus(struct device
 		dev = of_create_pci_dev(child, bus, devfn);
 		if (!dev)
 			continue;
-		DBG("dev header type: %x\n", dev->hdr_type);
+		DBG("    dev header type: %x\n", dev->hdr_type);
+	}
+
+	/* Ally all fixups */
+	pcibios_fixup_of_probed_bus(bus);
 
+	/* Now scan child busses */
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
-			of_scan_pci_bridge(child, dev);
+		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
+			struct device_node *child = pci_device_to_OF_node(dev);
+			if (dev)
+				of_scan_pci_bridge(child, dev);
+		}
 	}
-
-	do_bus_setup(bus);
 }
 EXPORT_SYMBOL(of_scan_bus);
 
 void __devinit of_scan_pci_bridge(struct device_node *node,
-			 	struct pci_dev *dev)
+				  struct pci_dev *dev)
 {
 	struct pci_bus *bus;
 	const u32 *busrange, *ranges;
@@ -394,7 +398,6 @@ void __devinit of_scan_pci_bridge(struct
 		res->start = of_read_number(&ranges[1], 2);
 		res->end = res->start + size - 1;
 		res->flags = flags;
-		fixup_resource(res, dev);
 	}
 	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
 		bus->number);
@@ -643,51 +646,13 @@ int __devinit pcibios_map_io_space(struc
 }
 EXPORT_SYMBOL_GPL(pcibios_map_io_space);
 
-static void __devinit fixup_resource(struct resource *res, struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned long offset;
-
-	if (res->flags & IORESOURCE_IO) {
-		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-		res->start += offset;
-		res->end += offset;
-	} else if (res->flags & IORESOURCE_MEM) {
-		res->start += hose->pci_mem_offset;
-		res->end += hose->pci_mem_offset;
-	}
-}
-
-void __devinit pcibios_fixup_device_resources(struct pci_dev *dev,
-					      struct pci_bus *bus)
-{
-	/* Update device resources.  */
-	int i;
-
-	DBG("%s: Fixup resources:\n", pci_name(dev));
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
-		if (!res->flags)
-			continue;
-
-		DBG("  0x%02x < %08lx:0x%016lx...0x%016lx\n",
-		    i, res->flags, res->start, res->end);
-
-		fixup_resource(res, dev);
-
-		DBG("       > %08lx:0x%016lx...0x%016lx\n",
-		    res->flags, res->start, res->end);
-	}
-}
-EXPORT_SYMBOL(pcibios_fixup_device_resources);
-
 void __devinit pcibios_setup_new_device(struct pci_dev *dev)
 {
 	struct dev_archdata *sd = &dev->dev.archdata;
 
 	sd->of_node = pci_device_to_OF_node(dev);
 
-	DBG("PCI device %s OF node: %s\n", pci_name(dev),
+	DBG("PCI: device %s OF node: %s\n", pci_name(dev),
 	    sd->of_node ? sd->of_node->full_name : "<none>");
 
 	sd->dma_ops = pci_dma_ops;
@@ -701,7 +666,7 @@ void __devinit pcibios_setup_new_device(
 }
 EXPORT_SYMBOL(pcibios_setup_new_device);
 
-static void __devinit do_bus_setup(struct pci_bus *bus)
+void __devinit pcibios_do_bus_setup(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
@@ -710,42 +675,7 @@ static void __devinit do_bus_setup(struc
 
 	list_for_each_entry(dev, &bus->devices, bus_list)
 		pcibios_setup_new_device(dev);
-
-	/* Read default IRQs and fixup if necessary */
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_read_irq_line(dev);
-		if (ppc_md.pci_irq_fixup)
-			ppc_md.pci_irq_fixup(dev);
-	}
-}
-
-void __devinit pcibios_fixup_bus(struct pci_bus *bus)
-{
-	struct pci_dev *dev = bus->self;
-	struct device_node *np;
-
-	np = pci_bus_to_OF_node(bus);
-
-	DBG("pcibios_fixup_bus(%s)\n", np ? np->full_name : "<???>");
-
-	if (dev && pci_probe_only &&
-	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
-		/* This is a subordinate bridge */
-
-		pci_read_bridge_bases(bus);
-		pcibios_fixup_device_resources(dev, bus);
-	}
-
-	do_bus_setup(bus);
-
-	if (!pci_probe_only)
-		return;
-
-	list_for_each_entry(dev, &bus->devices, bus_list)
-		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
-			pcibios_fixup_device_resources(dev, bus);
 }
-EXPORT_SYMBOL(pcibios_fixup_bus);
 
 unsigned long pci_address_to_pio(phys_addr_t address)
 {
Index: linux-merge/arch/powerpc/platforms/pseries/pci_dlpar.c
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/pseries/pci_dlpar.c	2007-12-14 15:48:59.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/pseries/pci_dlpar.c	2007-12-14 15:49:31.000000000 +1100
@@ -83,7 +83,7 @@ EXPORT_SYMBOL_GPL(pcibios_remove_pci_dev
 
 /* Must be called before pci_bus_add_devices */
 void
-pcibios_fixup_new_pci_devices(struct pci_bus *bus, int fix_bus)
+pcibios_fixup_new_pci_devices(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
@@ -98,8 +98,6 @@ pcibios_fixup_new_pci_devices(struct pci
 			/* Fill device archdata and setup iommu table */
 			pcibios_setup_new_device(dev);
 
-			if(fix_bus)
-				pcibios_fixup_device_resources(dev, bus);
 			pci_read_irq_line(dev);
 			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 				struct resource *r = &dev->resource[i];
@@ -132,8 +130,8 @@ pcibios_pci_config_bridge(struct pci_dev
 
 	pci_scan_child_bus(child_bus);
 
-	/* Fixup new pci devices without touching bus struct */
-	pcibios_fixup_new_pci_devices(child_bus, 0);
+	/* Fixup new pci devices */
+	pcibios_fixup_new_pci_devices(child_bus);
 
 	/* Make the discovered devices available */
 	pci_bus_add_devices(child_bus);
@@ -169,7 +167,7 @@ pcibios_add_pci_devices(struct pci_bus *
 		/* use ofdt-based probe */
 		of_scan_bus(dn, bus);
 		if (!list_empty(&bus->devices)) {
-			pcibios_fixup_new_pci_devices(bus, 0);
+			pcibios_fixup_new_pci_devices(bus);
 			pci_bus_add_devices(bus);
 			eeh_add_device_tree_late(bus);
 		}
@@ -178,7 +176,7 @@ pcibios_add_pci_devices(struct pci_bus *
 		slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
 		num = pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
 		if (num) {
-			pcibios_fixup_new_pci_devices(bus, 1);
+			pcibios_fixup_new_pci_devices(bus);
 			pci_bus_add_devices(bus);
 			eeh_add_device_tree_late(bus);
 		}
@@ -208,7 +206,7 @@ struct pci_controller * __devinit init_p
 		eeh_add_device_tree_early(dn);
 
 	scan_phb(phb);
-	pcibios_fixup_new_pci_devices(phb->bus, 0);
+	pcibios_fixup_new_pci_devices(phb->bus);
 	pci_bus_add_devices(phb->bus);
 	eeh_add_device_tree_late(phb->bus);
 
Index: linux-merge/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-merge.orig/drivers/pci/hotplug/rpadlpar_core.c	2007-12-14 15:48:59.000000000 +1100
+++ linux-merge/drivers/pci/hotplug/rpadlpar_core.c	2007-12-14 15:49:31.000000000 +1100
@@ -155,7 +155,7 @@ static void dlpar_pci_add_bus(struct dev
 	    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		of_scan_pci_bridge(dn, dev);
 
-	pcibios_fixup_new_pci_devices(dev->subordinate,0);
+	pcibios_fixup_new_pci_devices(dev->subordinate);
 
 	/* Claim new bus resources */
 	pcibios_claim_one_bus(dev->bus);
Index: linux-merge/include/asm-powerpc/machdep.h
===================================================================
--- linux-merge.orig/include/asm-powerpc/machdep.h	2007-12-14 15:48:59.000000000 +1100
+++ linux-merge/include/asm-powerpc/machdep.h	2007-12-14 15:49:31.000000000 +1100
@@ -205,13 +205,6 @@ struct machdep_calls {
 	 * optional PCI "hooks"
 	 */
 
-	/* Called after PPC generic resource fixup to perform
-	   machine specific fixups */
-	void (*pcibios_fixup_resources)(struct pci_dev *);
-
-	/* Called for each PCI bus in the system when it's probed */
-	void (*pcibios_fixup_bus)(struct pci_bus *);
-
 	/* Called when pci_enable_device() is called (initial=0) or
 	 * when a device with no assigned resource is found (initial=1).
 	 * Returns 0 to allow assignment/enabling of the device. */
@@ -225,6 +218,13 @@ struct machdep_calls {
 
 #endif /* CONFIG_PPC32 */
 
+	/* Called after PPC generic resource fixup to perform
+	   machine specific fixups */
+	void (*pcibios_fixup_resources)(struct pci_dev *);
+
+	/* Called for each PCI bus in the system when it's probed */
+	void (*pcibios_fixup_bus)(struct pci_bus *);
+
 	/* Called to shutdown machine specific hardware not already controlled
 	 * by other drivers.
 	 */
Index: linux-merge/include/asm-powerpc/pci-bridge.h
===================================================================
--- linux-merge.orig/include/asm-powerpc/pci-bridge.h	2007-12-14 15:49:30.000000000 +1100
+++ linux-merge/include/asm-powerpc/pci-bridge.h	2007-12-14 15:49:31.000000000 +1100
@@ -235,7 +235,7 @@ extern void pcibios_remove_pci_devices(s
 
 /** Discover new pci devices under this bus, and add them */
 extern void pcibios_add_pci_devices(struct pci_bus *bus);
-extern void pcibios_fixup_new_pci_devices(struct pci_bus *bus, int fix_bus);
+extern void pcibios_fixup_new_pci_devices(struct pci_bus *bus);
 
 extern int pcibios_remove_root_bus(struct pci_controller *phb);
 
Index: linux-merge/include/asm-powerpc/pci.h
===================================================================
--- linux-merge.orig/include/asm-powerpc/pci.h	2007-12-14 15:49:30.000000000 +1100
+++ linux-merge/include/asm-powerpc/pci.h	2007-12-14 15:49:31.000000000 +1100
@@ -196,9 +196,6 @@ static inline struct resource *pcibios_s
 	return root;
 }
 
-extern void pcibios_fixup_device_resources(struct pci_dev *dev,
-			struct pci_bus *bus);
-
 extern void pcibios_setup_new_device(struct pci_dev *dev);
 
 extern void pcibios_claim_one_bus(struct pci_bus *b);
@@ -226,5 +223,8 @@ extern void pci_resource_to_user(const s
 				 const struct resource *rsrc,
 				 resource_size_t *start, resource_size_t *end);
 
+extern void pcibios_do_bus_setup(struct pci_bus *bus);
+extern void pcibios_fixup_of_probed_bus(struct pci_bus *bus);
+
 #endif	/* __KERNEL__ */
 #endif /* __ASM_POWERPC_PCI_H */
