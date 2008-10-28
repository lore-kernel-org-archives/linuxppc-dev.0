Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Oct 2008 16:48:22 +1100
Subject: [PATCH 2/10] powerpc/pci: Cleanup debug printk's
In-Reply-To: <1225172895.217185.958686212130.qpush@grosgo>
Message-Id: <20081028054926.61E8FDDE1D@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This removes the various DBG() macro from the powerpc PCI code and
make it use the standard pr_debug instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |   77 +++++++++++++++------------------
 arch/powerpc/kernel/pci_32.c     |   12 +----
 arch/powerpc/kernel/pci_64.c     |   90 ++++++++++++++++++---------------------
 3 files changed, 82 insertions(+), 97 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-10-28 11:56:18.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-10-28 11:56:41.000000000 +1100
@@ -38,13 +38,6 @@
 #include <asm/ppc-pci.h>
 #include <asm/firmware.h>
 
-#ifdef DEBUG
-#include <asm/udbg.h>
-#define DBG(fmt...) printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 static DEFINE_SPINLOCK(hose_spinlock);
 
 /* XXX kill that some day ... */
@@ -214,8 +207,8 @@ void __devinit pcibios_setup_new_device(
 
 	sd->of_node = pci_device_to_OF_node(dev);
 
-	DBG("PCI: device %s OF node: %s\n", pci_name(dev),
-	    sd->of_node ? sd->of_node->full_name : "<none>");
+	pr_debug("PCI: device %s OF node: %s\n", pci_name(dev),
+		 sd->of_node ? sd->of_node->full_name : "<none>");
 
 	sd->dma_ops = pci_dma_ops;
 #ifdef CONFIG_PPC32
@@ -252,7 +245,7 @@ int pci_read_irq_line(struct pci_dev *pc
 		return -1;
 #endif
 
-	DBG("Try to map irq for %s...\n", pci_name(pci_dev));
+	pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
 
 #ifdef DEBUG
 	memset(&oirq, 0xff, sizeof(oirq));
@@ -276,26 +269,26 @@ int pci_read_irq_line(struct pci_dev *pc
 		    line == 0xff || line == 0) {
 			return -1;
 		}
-		DBG(" -> no map ! Using line %d (pin %d) from PCI config\n",
-		    line, pin);
+		pr_debug(" No map ! Using line %d (pin %d) from PCI config\n",
+			 line, pin);
 
 		virq = irq_create_mapping(NULL, line);
 		if (virq != NO_IRQ)
 			set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
 	} else {
-		DBG(" -> got one, spec %d cells (0x%08x 0x%08x...) on %s\n",
-		    oirq.size, oirq.specifier[0], oirq.specifier[1],
+		pr_debug(" Got one, spec %d cells (0x%08x 0x%08x...) on %s\n",
+			 oirq.size, oirq.specifier[0], oirq.specifier[1],
 		    oirq.controller->full_name);
 
 		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
 					     oirq.size);
 	}
 	if(virq == NO_IRQ) {
-		DBG(" -> failed to map !\n");
+		pr_debug(" Failed to map !\n");
 		return -1;
 	}
 
-	DBG(" -> mapped to linux irq %d\n", virq);
+	pr_debug(" Mapped to linux irq %d\n", virq);
 
 	pci_dev->irq = virq;
 
@@ -451,8 +444,8 @@ pgprot_t pci_phys_mem_access_prot(struct
 		pci_dev_put(pdev);
 	}
 
-	DBG("non-PCI map for %llx, prot: %lx\n",
-	    (unsigned long long)offset, prot);
+	pr_debug("PCI: Non-PCI map for %llx, prot: %lx\n",
+		 (unsigned long long)offset, prot);
 
 	return __pgprot(prot);
 }
@@ -1198,10 +1191,10 @@ static int __init reparent_resources(str
 	*pp = NULL;
 	for (p = res->child; p != NULL; p = p->sibling) {
 		p->parent = res;
-		DBG(KERN_INFO "PCI: reparented %s [%llx..%llx] under %s\n",
-		    p->name,
-		    (unsigned long long)p->start,
-		    (unsigned long long)p->end, res->name);
+		pr_debug("PCI: Reparented %s [%llx..%llx] under %s\n",
+			 p->name,
+			 (unsigned long long)p->start,
+			 (unsigned long long)p->end, res->name);
 	}
 	return 0;
 }
@@ -1271,14 +1264,14 @@ void pcibios_allocate_bus_resources(stru
 			}
 		}
 
-		DBG("PCI: %s (bus %d) bridge rsrc %d: %016llx-%016llx "
-		    "[0x%x], parent %p (%s)\n",
-		    bus->self ? pci_name(bus->self) : "PHB",
-		    bus->number, i,
-		    (unsigned long long)res->start,
-		    (unsigned long long)res->end,
-		    (unsigned int)res->flags,
-		    pr, (pr && pr->name) ? pr->name : "nil");
+		pr_debug("PCI: %s (bus %d) bridge rsrc %d: %016llx-%016llx "
+			 "[0x%x], parent %p (%s)\n",
+			 bus->self ? pci_name(bus->self) : "PHB",
+			 bus->number, i,
+			 (unsigned long long)res->start,
+			 (unsigned long long)res->end,
+			 (unsigned int)res->flags,
+			 pr, (pr && pr->name) ? pr->name : "nil");
 
 		if (pr && !(pr->flags & IORESOURCE_UNSET)) {
 			if (request_resource(pr, res) == 0)
@@ -1305,11 +1298,11 @@ static inline void __devinit alloc_resou
 {
 	struct resource *pr, *r = &dev->resource[idx];
 
-	DBG("PCI: Allocating %s: Resource %d: %016llx..%016llx [%x]\n",
-	    pci_name(dev), idx,
-	    (unsigned long long)r->start,
-	    (unsigned long long)r->end,
-	    (unsigned int)r->flags);
+	pr_debug("PCI: Allocating %s: Resource %d: %016llx..%016llx [%x]\n",
+		 pci_name(dev), idx,
+		 (unsigned long long)r->start,
+		 (unsigned long long)r->end,
+		 (unsigned int)r->flags);
 
 	pr = pci_find_parent_resource(dev, r);
 	if (!pr || (pr->flags & IORESOURCE_UNSET) ||
@@ -1317,10 +1310,11 @@ static inline void __devinit alloc_resou
 		printk(KERN_WARNING "PCI: Cannot allocate resource region %d"
 		       " of device %s, will remap\n", idx, pci_name(dev));
 		if (pr)
-			DBG("PCI:  parent is %p: %016llx-%016llx [%x]\n", pr,
-			    (unsigned long long)pr->start,
-			    (unsigned long long)pr->end,
-			    (unsigned int)pr->flags);
+			pr_debug("PCI:  parent is %p: %016llx-%016llx [%x]\n",
+				 pr,
+				 (unsigned long long)pr->start,
+				 (unsigned long long)pr->end,
+				 (unsigned int)pr->flags);
 		/* We'll assign a new address later */
 		r->flags |= IORESOURCE_UNSET;
 		r->end -= r->start;
@@ -1358,7 +1352,8 @@ static void __init pcibios_allocate_reso
 			 * but keep it unregistered.
 			 */
 			u32 reg;
-			DBG("PCI: Switching off ROM of %s\n", pci_name(dev));
+			pr_debug("PCI: Switching off ROM of %s\n",
+				 pci_name(dev));
 			r->flags &= ~IORESOURCE_ROM_ENABLE;
 			pci_read_config_dword(dev, dev->rom_base_reg, &reg);
 			pci_write_config_dword(dev, dev->rom_base_reg,
@@ -1383,7 +1378,7 @@ void __init pcibios_resource_survey(void
 	}
 
 	if (!(ppc_pci_flags & PPC_PCI_PROBE_ONLY)) {
-		DBG("PCI: Assigning unassigned resouces...\n");
+		pr_debug("PCI: Assigning unassigned resouces...\n");
 		pci_assign_unassigned_resources();
 	}
 
Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2008-10-28 11:56:09.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2008-10-28 11:56:25.000000000 +1100
@@ -26,12 +26,6 @@
 
 #undef DEBUG
 
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 unsigned long isa_io_base     = 0;
 unsigned long pci_dram_offset = 0;
 int pcibios_assign_bus_offset = 1;
@@ -275,14 +269,14 @@ pci_busdev_to_OF_node(struct pci_bus *bu
 	if (!have_of)
 		return NULL;
 
-	DBG("pci_busdev_to_OF_node(%d,0x%x)\n", bus->number, devfn);
+	pr_debug("pci_busdev_to_OF_node(%d,0x%x)\n", bus->number, devfn);
 	parent = scan_OF_for_pci_bus(bus);
 	if (parent == NULL)
 		return NULL;
-	DBG(" parent is %s\n", parent ? parent->full_name : "<NULL>");
+	pr_debug(" parent is %s\n", parent ? parent->full_name : "<NULL>");
 	np = scan_OF_for_pci_dev(parent, devfn);
 	of_node_put(parent);
-	DBG(" result is %s\n", np ? np->full_name : "<NULL>");
+	pr_debug(" result is %s\n", np ? np->full_name : "<NULL>");
 
 	/* XXX most callers don't release the returned node
 	 * mostly because ppc64 doesn't increase the refcount,
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2008-10-28 11:56:09.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_64.c	2008-10-28 11:56:25.000000000 +1100
@@ -32,13 +32,6 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 
-#ifdef DEBUG
-#include <asm/udbg.h>
-#define DBG(fmt...) printk(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 unsigned long pci_probe_only = 1;
 
 /* pci_io_base -- the base address from which io bars are offsets.
@@ -102,7 +95,7 @@ static void pci_parse_of_addrs(struct de
 	addrs = of_get_property(node, "assigned-addresses", &proplen);
 	if (!addrs)
 		return;
-	DBG("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
+	pr_debug("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
 	for (; proplen >= 20; proplen -= 20, addrs += 5) {
 		flags = pci_parse_of_flags(addrs[0]);
 		if (!flags)
@@ -112,8 +105,9 @@ static void pci_parse_of_addrs(struct de
 		if (!size)
 			continue;
 		i = addrs[0] & 0xff;
-		DBG("  base: %llx, size: %llx, i: %x\n",
-		    (unsigned long long)base, (unsigned long long)size, i);
+		pr_debug("  base: %llx, size: %llx, i: %x\n",
+			 (unsigned long long)base,
+			 (unsigned long long)size, i);
 
 		if (PCI_BASE_ADDRESS_0 <= i && i <= PCI_BASE_ADDRESS_5) {
 			res = &dev->resource[(i - PCI_BASE_ADDRESS_0) >> 2];
@@ -144,7 +138,7 @@ struct pci_dev *of_create_pci_dev(struct
 	if (type == NULL)
 		type = "";
 
-	DBG("    create device, devfn: %x, type: %s\n", devfn, type);
+	pr_debug("    create device, devfn: %x, type: %s\n", devfn, type);
 
 	dev->bus = bus;
 	dev->sysdata = node;
@@ -165,8 +159,8 @@ struct pci_dev *of_create_pci_dev(struct
 	dev->class = get_int_prop(node, "class-code", 0);
 	dev->revision = get_int_prop(node, "revision-id", 0);
 
-	DBG("    class: 0x%x\n", dev->class);
-	DBG("    revision: 0x%x\n", dev->revision);
+	pr_debug("    class: 0x%x\n", dev->class);
+	pr_debug("    revision: 0x%x\n", dev->revision);
 
 	dev->current_state = 4;		/* unknown power state */
 	dev->error_state = pci_channel_io_normal;
@@ -187,7 +181,7 @@ struct pci_dev *of_create_pci_dev(struct
 
 	pci_parse_of_addrs(node, dev);
 
-	DBG("    adding to system ...\n");
+	pr_debug("    adding to system ...\n");
 
 	pci_device_add(dev, bus);
 
@@ -203,11 +197,12 @@ void __devinit of_scan_bus(struct device
 	int reglen, devfn;
 	struct pci_dev *dev;
 
-	DBG("of_scan_bus(%s) bus no %d... \n", node->full_name, bus->number);
+	pr_debug("of_scan_bus(%s) bus no %d... \n",
+		 node->full_name, bus->number);
 
 	/* Scan direct children */
 	for_each_child_of_node(node, child) {
-		DBG("  * %s\n", child->full_name);
+		pr_debug("  * %s\n", child->full_name);
 		reg = of_get_property(child, "reg", &reglen);
 		if (reg == NULL || reglen < 20)
 			continue;
@@ -217,7 +212,7 @@ void __devinit of_scan_bus(struct device
 		dev = of_create_pci_dev(child, bus, devfn);
 		if (!dev)
 			continue;
-		DBG("    dev header type: %x\n", dev->hdr_type);
+		pr_debug("    dev header type: %x\n", dev->hdr_type);
 	}
 
 	/* Ally all fixups */
@@ -245,7 +240,7 @@ void __devinit of_scan_pci_bridge(struct
 	unsigned int flags;
 	u64 size;
 
-	DBG("of_scan_pci_bridge(%s)\n", node->full_name);
+	pr_debug("of_scan_pci_bridge(%s)\n", node->full_name);
 
 	/* parse bus-range property */
 	busrange = of_get_property(node, "bus-range", &len);
@@ -309,12 +304,12 @@ void __devinit of_scan_pci_bridge(struct
 	}
 	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
 		bus->number);
-	DBG("    bus name: %s\n", bus->name);
+	pr_debug("    bus name: %s\n", bus->name);
 
 	mode = PCI_PROBE_NORMAL;
 	if (ppc_md.pci_probe_mode)
 		mode = ppc_md.pci_probe_mode(bus);
-	DBG("    probe mode: %d\n", mode);
+	pr_debug("    probe mode: %d\n", mode);
 
 	if (mode == PCI_PROBE_DEVTREE)
 		of_scan_bus(node, bus);
@@ -329,7 +324,8 @@ void __devinit scan_phb(struct pci_contr
 	struct device_node *node = hose->dn;
 	int i, mode;
 
-	DBG("PCI: Scanning PHB %s\n", node ? node->full_name : "<NO NAME>");
+	pr_debug("PCI: Scanning PHB %s\n",
+		 node ? node->full_name : "<NO NAME>");
 
 	/* Create an empty bus for the toplevel */
 	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, node);
@@ -345,26 +341,26 @@ void __devinit scan_phb(struct pci_contr
 	pcibios_map_io_space(bus);
 
 	/* Wire up PHB bus resources */
-	DBG("PCI: PHB IO resource    = %016lx-%016lx [%lx]\n",
-	    hose->io_resource.start, hose->io_resource.end,
-	    hose->io_resource.flags);
+	pr_debug("PCI: PHB IO resource    = %016lx-%016lx [%lx]\n",
+		 hose->io_resource.start, hose->io_resource.end,
+		 hose->io_resource.flags);
 	bus->resource[0] = &hose->io_resource;
 	for (i = 0; i < 3; ++i) {
-		DBG("PCI: PHB MEM resource %d = %016lx-%016lx [%lx]\n", i,
-		    hose->mem_resources[i].start,
-		    hose->mem_resources[i].end,
-		    hose->mem_resources[i].flags);
+		pr_debug("PCI: PHB MEM resource %d = %016lx-%016lx [%lx]\n", i,
+			 hose->mem_resources[i].start,
+			 hose->mem_resources[i].end,
+			 hose->mem_resources[i].flags);
 		bus->resource[i+1] = &hose->mem_resources[i];
 	}
-	DBG("PCI: PHB MEM offset     = %016lx\n", hose->pci_mem_offset);
-	DBG("PCI: PHB IO  offset     = %08lx\n",
+	pr_debug("PCI: PHB MEM offset     = %016lx\n", hose->pci_mem_offset);
+	pr_debug("PCI: PHB IO  offset     = %08lx\n",
 	    (unsigned long)hose->io_base_virt - _IO_BASE);
 
 	/* Get probe mode and perform scan */
 	mode = PCI_PROBE_NORMAL;
 	if (node && ppc_md.pci_probe_mode)
 		mode = ppc_md.pci_probe_mode(bus);
-	DBG("    probe mode: %d\n", mode);
+	pr_debug("    probe mode: %d\n", mode);
 	if (mode == PCI_PROBE_DEVTREE) {
 		bus->subordinate = hose->last_busno;
 		of_scan_bus(node, bus);
@@ -422,8 +418,8 @@ int pcibios_unmap_io_space(struct pci_bu
 	if (bus->self) {
 		struct resource *res = bus->resource[0];
 
-		DBG("IO unmapping for PCI-PCI bridge %s\n",
-		    pci_name(bus->self));
+		pr_debug("IO unmapping for PCI-PCI bridge %s\n",
+			 pci_name(bus->self));
 
 		__flush_hash_table_range(&init_mm, res->start + _IO_BASE,
 					 res->end - res->start + 1);
@@ -437,8 +433,8 @@ int pcibios_unmap_io_space(struct pci_bu
 	if (hose->io_base_alloc == 0)
 		return 0;
 
-	DBG("IO unmapping for PHB %s\n", hose->dn->full_name);
-	DBG("  alloc=0x%p\n", hose->io_base_alloc);
+	pr_debug("IO unmapping for PHB %s\n", hose->dn->full_name);
+	pr_debug("  alloc=0x%p\n", hose->io_base_alloc);
 
 	/* This is a PHB, we fully unmap the IO area */
 	vunmap(hose->io_base_alloc);
@@ -463,11 +459,11 @@ int __devinit pcibios_map_io_space(struc
 	 * thus HPTEs will be faulted in when needed
 	 */
 	if (bus->self) {
-		DBG("IO mapping for PCI-PCI bridge %s\n",
-		    pci_name(bus->self));
-		DBG("  virt=0x%016lx...0x%016lx\n",
-		    bus->resource[0]->start + _IO_BASE,
-		    bus->resource[0]->end + _IO_BASE);
+		pr_debug("IO mapping for PCI-PCI bridge %s\n",
+			 pci_name(bus->self));
+		pr_debug("  virt=0x%016lx...0x%016lx\n",
+			 bus->resource[0]->start + _IO_BASE,
+			 bus->resource[0]->end + _IO_BASE);
 		return 0;
 	}
 
@@ -496,11 +492,11 @@ int __devinit pcibios_map_io_space(struc
 	hose->io_base_virt = (void __iomem *)(area->addr +
 					      hose->io_base_phys - phys_page);
 
-	DBG("IO mapping for PHB %s\n", hose->dn->full_name);
-	DBG("  phys=0x%016lx, virt=0x%p (alloc=0x%p)\n",
-	    hose->io_base_phys, hose->io_base_virt, hose->io_base_alloc);
-	DBG("  size=0x%016lx (alloc=0x%016lx)\n",
-	    hose->pci_io_size, size_page);
+	pr_debug("IO mapping for PHB %s\n", hose->dn->full_name);
+	pr_debug("  phys=0x%016lx, virt=0x%p (alloc=0x%p)\n",
+		 hose->io_base_phys, hose->io_base_virt, hose->io_base_alloc);
+	pr_debug("  size=0x%016lx (alloc=0x%016lx)\n",
+		 hose->pci_io_size, size_page);
 
 	/* Establish the mapping */
 	if (__ioremap_at(phys_page, area->addr, size_page,
@@ -512,8 +508,8 @@ int __devinit pcibios_map_io_space(struc
 	hose->io_resource.start += io_virt_offset;
 	hose->io_resource.end += io_virt_offset;
 
-	DBG("  hose->io_resource=0x%016lx...0x%016lx\n",
-	    hose->io_resource.start, hose->io_resource.end);
+	pr_debug("  hose->io_resource=0x%016lx...0x%016lx\n",
+		 hose->io_resource.start, hose->io_resource.end);
 
 	return 0;
 }
