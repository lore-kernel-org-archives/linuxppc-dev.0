Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Oct 2008 16:48:52 +1100
Subject: [PATCH 9/10] powerpc/pci: Fix various pseries PCI Hotplug issues
In-Reply-To: <1225172895.217185.958686212130.qpush@grosgo>
Message-Id: <20081028054953.3DD34DE124@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The pseries PCI Hotplug code has a number of issues, ranging from
incorrect resource setup to crashes, depending on what is added,
when, whether it contains a bridge, etc etc....

This patch fixes a whole bunch of these, while actually simplifying
the code a bit, using more generic code in the process and factoring
out common code between adding of a PHB, a slot or a device.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/pci-bridge.h      |    3 
 arch/powerpc/include/asm/pci.h             |    7 -
 arch/powerpc/kernel/pci-common.c           |   41 ++++++-
 arch/powerpc/kernel/rtas_pci.c             |   48 --------
 arch/powerpc/platforms/pseries/pci_dlpar.c |  164 ++++++++++++++---------------
 drivers/pci/hotplug/rpadlpar_core.c        |   69 +++++-------
 6 files changed, 150 insertions(+), 182 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/pci-bridge.h	2008-10-28 14:56:52.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pci-bridge.h	2008-10-28 14:58:54.000000000 +1100
@@ -241,9 +241,6 @@ extern void pcibios_remove_pci_devices(s
 
 /** Discover new pci devices under this bus, and add them */
 extern void pcibios_add_pci_devices(struct pci_bus *bus);
-extern void pcibios_fixup_new_pci_devices(struct pci_bus *bus);
-
-extern int pcibios_remove_root_bus(struct pci_controller *phb);
 
 static inline struct pci_controller *pci_bus_to_host(const struct pci_bus *bus)
 {
Index: linux-work/arch/powerpc/include/asm/pci.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pci.h	2008-10-28 14:56:52.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pci.h	2008-10-28 14:58:54.000000000 +1100
@@ -204,15 +204,12 @@ static inline struct resource *pcibios_s
 	return root;
 }
 
-extern void pcibios_setup_new_device(struct pci_dev *dev);
-
-extern void pcibios_claim_one_bus(struct pci_bus *b);
-
-extern void pcibios_allocate_bus_resources(struct pci_bus *bus);
+extern void pcibios_finish_adding_to_bus(struct pci_bus *bus);
 
 extern void pcibios_resource_survey(void);
 
 extern struct pci_controller *init_phb_dynamic(struct device_node *dn);
+extern int remove_phb_dynamic(struct pci_controller *phb);
 
 extern struct pci_dev *of_create_pci_dev(struct device_node *node,
 					struct pci_bus *bus, int devfn);
Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-10-28 14:58:48.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-10-28 14:59:16.000000000 +1100
@@ -202,7 +202,7 @@ char __devinit *pcibios_setup(char *str)
 	return str;
 }
 
-void __devinit pcibios_setup_new_device(struct pci_dev *dev)
+static void __devinit pcibios_setup_new_device(struct pci_dev *dev)
 {
 	struct dev_archdata *sd = &dev->dev.archdata;
 
@@ -220,7 +220,6 @@ void __devinit pcibios_setup_new_device(
 	if (ppc_md.pci_dma_dev_setup)
 		ppc_md.pci_dma_dev_setup(dev);
 }
-EXPORT_SYMBOL(pcibios_setup_new_device);
 
 /*
  * Reads the interrupt pin to determine if interrupt is use by card.
@@ -1399,9 +1398,10 @@ void __init pcibios_resource_survey(void
 
 #ifdef CONFIG_HOTPLUG
 
-/* This is used by the pSeries hotplug driver to allocate resource
+/* This is used by the PCI hotplug driver to allocate resource
  * of newly plugged busses. We can try to consolidate with the
- * rest of the code later, for now, keep it as-is
+ * rest of the code later, for now, keep it as-is as our main
+ * resource allocation function doesn't deal with sub-trees yet.
  */
 static void __devinit pcibios_claim_one_bus(struct pci_bus *bus)
 {
@@ -1416,6 +1416,14 @@ static void __devinit pcibios_claim_one_
 
 			if (r->parent || !r->start || !r->flags)
 				continue;
+
+			pr_debug("PCI: Claiming %s: "
+				 "Resource %d: %016llx..%016llx [%x]\n",
+				 pci_name(dev), i,
+				 (unsigned long long)r->start,
+				 (unsigned long long)r->end,
+				 (unsigned int)r->flags);
+
 			pci_claim_resource(dev, i);
 		}
 	}
@@ -1423,6 +1431,31 @@ static void __devinit pcibios_claim_one_
 	list_for_each_entry(child_bus, &bus->children, node)
 		pcibios_claim_one_bus(child_bus);
 }
+
+
+/* pcibios_finish_adding_to_bus
+ *
+ * This is to be called by the hotplug code after devices have been
+ * added to a bus, this include calling it for a PHB that is just
+ * being added
+ */
+void pcibios_finish_adding_to_bus(struct pci_bus *bus)
+{
+	pr_debug("PCI: Finishing adding to hotplug bus %04x:%02x\n",
+		 pci_domain_nr(bus), bus->number);
+
+	/* Allocate bus and devices resources */
+	pcibios_allocate_bus_resources(bus);
+	pcibios_claim_one_bus(bus);
+
+	/* Add new devices to global lists.  Register in proc, sysfs. */
+	pci_bus_add_devices(bus);
+
+	/* Fixup EEH */
+	eeh_add_device_tree_late(bus);
+}
+EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
+
 #endif /* CONFIG_HOTPLUG */
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
Index: linux-work/arch/powerpc/kernel/rtas_pci.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/rtas_pci.c	2008-10-28 14:56:52.000000000 +1100
+++ linux-work/arch/powerpc/kernel/rtas_pci.c	2008-10-28 14:58:54.000000000 +1100
@@ -301,51 +301,3 @@ void __init find_and_init_phbs(void)
 #endif /* CONFIG_PPC32 */
 	}
 }
-
-/* RPA-specific bits for removing PHBs */
-int pcibios_remove_root_bus(struct pci_controller *phb)
-{
-	struct pci_bus *b = phb->bus;
-	struct resource *res;
-	int rc, i;
-
-	res = b->resource[0];
-	if (!res->flags) {
-		printk(KERN_ERR "%s: no IO resource for PHB %s\n", __func__,
-				b->name);
-		return 1;
-	}
-
-	rc = pcibios_unmap_io_space(b);
-	if (rc) {
-		printk(KERN_ERR "%s: failed to unmap IO on bus %s\n",
-			__func__, b->name);
-		return 1;
-	}
-
-	if (release_resource(res)) {
-		printk(KERN_ERR "%s: failed to release IO on bus %s\n",
-				__func__, b->name);
-		return 1;
-	}
-
-	for (i = 1; i < 3; ++i) {
-		res = b->resource[i];
-		if (!res->flags && i == 0) {
-			printk(KERN_ERR "%s: no MEM resource for PHB %s\n",
-				__func__, b->name);
-			return 1;
-		}
-		if (res->flags && release_resource(res)) {
-			printk(KERN_ERR
-			       "%s: failed to release IO %d on bus %s\n",
-				__func__, i, b->name);
-			return 1;
-		}
-	}
-
-	pcibios_free_controller(phb);
-
-	return 0;
-}
-EXPORT_SYMBOL(pcibios_remove_root_bus);
Index: linux-work/arch/powerpc/platforms/pseries/pci_dlpar.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/pci_dlpar.c	2008-10-28 14:56:52.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/pci_dlpar.c	2008-10-28 14:58:54.000000000 +1100
@@ -25,6 +25,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#undef DEBUG
+
 #include <linux/pci.h>
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
@@ -69,74 +71,25 @@ EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
  * Remove all of the PCI devices under this bus both from the
  * linux pci device tree, and from the powerpc EEH address cache.
  */
-void
-pcibios_remove_pci_devices(struct pci_bus *bus)
+void pcibios_remove_pci_devices(struct pci_bus *bus)
 {
-	struct pci_dev *dev, *tmp;
+ 	struct pci_dev *dev, *tmp;
+	struct pci_bus *child_bus;
+
+	/* First go down child busses */
+	list_for_each_entry(child_bus, &bus->children, node)
+		pcibios_remove_pci_devices(child_bus);
 
+	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
+		 pci_domain_nr(bus),  bus->number);
 	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
+		pr_debug("     * Removing %s...\n", pci_name(dev));
 		eeh_remove_bus_device(dev);
-		pci_remove_bus_device(dev);
-	}
+ 		pci_remove_bus_device(dev);
+ 	}
 }
 EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
 
-/* Must be called before pci_bus_add_devices */
-void
-pcibios_fixup_new_pci_devices(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		/* Skip already-added devices */
-		if (!dev->is_added) {
-			int i;
-
-			/* Fill device archdata and setup iommu table */
-			pcibios_setup_new_device(dev);
-
-			pci_read_irq_line(dev);
-			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-				struct resource *r = &dev->resource[i];
-
-				if (r->parent || !r->start || !r->flags)
-					continue;
-				pci_claim_resource(dev, i);
-			}
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(pcibios_fixup_new_pci_devices);
-
-static int
-pcibios_pci_config_bridge(struct pci_dev *dev)
-{
-	u8 sec_busno;
-	struct pci_bus *child_bus;
-
-	/* Get busno of downstream bus */
-	pci_read_config_byte(dev, PCI_SECONDARY_BUS, &sec_busno);
-
-	/* Add to children of PCI bridge dev->bus */
-	child_bus = pci_add_new_bus(dev->bus, dev, sec_busno);
-	if (!child_bus) {
-		printk (KERN_ERR "%s: could not add second bus\n", __func__);
-		return -EIO;
-	}
-	sprintf(child_bus->name, "PCI Bus #%02x", child_bus->number);
-
-	pci_scan_child_bus(child_bus);
-
-	/* Fixup new pci devices */
-	pcibios_fixup_new_pci_devices(child_bus);
-
-	/* Make the discovered devices available */
-	pci_bus_add_devices(child_bus);
-
-	eeh_add_device_tree_late(child_bus);
-	return 0;
-}
-
 /**
  * pcibios_add_pci_devices - adds new pci devices to bus
  *
@@ -147,10 +100,9 @@ pcibios_pci_config_bridge(struct pci_dev
  * is how this routine differs from other, similar pcibios
  * routines.)
  */
-void
-pcibios_add_pci_devices(struct pci_bus * bus)
+void pcibios_add_pci_devices(struct pci_bus * bus)
 {
-	int slotno, num, mode;
+	int slotno, num, mode, pass, max;
 	struct pci_dev *dev;
 	struct device_node *dn = pci_bus_to_OF_node(bus);
 
@@ -162,26 +114,23 @@ pcibios_add_pci_devices(struct pci_bus *
 
 	if (mode == PCI_PROBE_DEVTREE) {
 		/* use ofdt-based probe */
-		of_scan_bus(dn, bus);
-		if (!list_empty(&bus->devices)) {
-			pcibios_fixup_new_pci_devices(bus);
-			pci_bus_add_devices(bus);
-			eeh_add_device_tree_late(bus);
-		}
+		of_rescan_bus(dn, bus);
 	} else if (mode == PCI_PROBE_NORMAL) {
 		/* use legacy probe */
 		slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
 		num = pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
-		if (num) {
-			pcibios_fixup_new_pci_devices(bus);
-			pci_bus_add_devices(bus);
-			eeh_add_device_tree_late(bus);
+		if (!num)
+			return;
+		pcibios_setup_bus_devices(bus);
+		max = bus->secondary;
+		for (pass=0; pass < 2; pass++)
+			list_for_each_entry(dev, &bus->devices, bus_list) {
+			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
+			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+				max = pci_scan_bridge(bus, dev, max, pass);
 		}
-
-		list_for_each_entry(dev, &bus->devices, bus_list)
-			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
-				pcibios_pci_config_bridge(dev);
 	}
+	pcibios_finish_adding_to_bus(bus);
 }
 EXPORT_SYMBOL_GPL(pcibios_add_pci_devices);
 
@@ -189,7 +138,8 @@ struct pci_controller * __devinit init_p
 {
 	struct pci_controller *phb;
 	int primary;
-	struct pci_bus *b;
+
+	pr_debug("PCI: Initializing new hotplug PHB %s\n", dn->full_name);
 
 	primary = list_empty(&hose_list);
 	phb = pcibios_alloc_controller(dn);
@@ -204,11 +154,59 @@ struct pci_controller * __devinit init_p
 		eeh_add_device_tree_early(dn);
 
 	scan_phb(phb);
-	pcibios_allocate_bus_resources(phb->bus);
-	pcibios_fixup_new_pci_devices(phb->bus);
-	pci_bus_add_devices(phb->bus);
-	eeh_add_device_tree_late(phb->bus);
+	pcibios_finish_adding_to_bus(phb->bus);
 
 	return phb;
 }
 EXPORT_SYMBOL_GPL(init_phb_dynamic);
+
+/* RPA-specific bits for removing PHBs */
+int remove_phb_dynamic(struct pci_controller *phb)
+{
+	struct pci_bus *b = phb->bus;
+	struct resource *res;
+	int rc, i;
+
+	pr_debug("PCI: Removing PHB %04x:%02x... \n",
+		 pci_domain_nr(b), b->number);
+
+	/* We cannot to remove a root bus that has children */
+	if (!(list_empty(&b->children) && list_empty(&b->devices)))
+		return -EBUSY;
+
+	/* We -know- there aren't any child devices anymore at this stage
+	 * and thus, we can safely unmap the IO space as it's not in use
+	 */
+	res = &phb->io_resource;
+	if (res->flags & IORESOURCE_IO) {
+		rc = pcibios_unmap_io_space(b);
+		if (rc) {
+			printk(KERN_ERR "%s: failed to unmap IO on bus %s\n",
+			       __func__, b->name);
+			return 1;
+		}
+	}
+
+	/* Unregister the bridge device from sysfs and remove the PCI bus */
+	device_unregister(b->bridge);
+	phb->bus = NULL;
+	pci_remove_bus(b);
+
+	/* Now release the IO resource */
+	if (res->flags & IORESOURCE_IO)
+		release_resource(res);
+
+	/* Release memory resources */
+	for (i = 0; i < 3; ++i) {
+		res = &phb->mem_resources[i];
+		if (!(res->flags & IORESOURCE_MEM))
+			continue;
+		release_resource(res);
+	}
+
+	/* Free pci_controller data structure */
+	pcibios_free_controller(phb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(remove_phb_dynamic);
Index: linux-work/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-work.orig/drivers/pci/hotplug/rpadlpar_core.c	2008-10-28 14:56:52.000000000 +1100
+++ linux-work/drivers/pci/hotplug/rpadlpar_core.c	2008-10-28 14:58:54.000000000 +1100
@@ -14,6 +14,9 @@
  *      as published by the Free Software Foundation; either version
  *      2 of the License, or (at your option) any later version.
  */
+
+#undef DEBUG
+
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/string.h>
@@ -151,20 +154,20 @@ static void dlpar_pci_add_bus(struct dev
 		return;
 	}
 
+	/* Scan below the new bridge */
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
 	    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		of_scan_pci_bridge(dn, dev);
 
-	pcibios_fixup_new_pci_devices(dev->subordinate);
-
-	/* Claim new bus resources */
-	pcibios_claim_one_bus(dev->bus);
-
 	/* Map IO space for child bus, which may or may not succeed */
 	pcibios_map_io_space(dev->subordinate);
 
-	/* Add new devices to global lists.  Register in proc, sysfs. */
-	pci_bus_add_devices(phb->bus);
+	/* Finish adding it : resource allocation, adding devices, etc...
+	 * Note that we need to perform the finish pass on the -parent-
+	 * bus of the EADS bridge so the bridge device itself gets
+	 * properly added
+	 */
+	pcibios_finish_adding_to_bus(phb->bus);
 }
 
 static int dlpar_add_pci_slot(char *drc_name, struct device_node *dn)
@@ -203,27 +206,6 @@ static int dlpar_add_pci_slot(char *drc_
 	return 0;
 }
 
-static int dlpar_remove_root_bus(struct pci_controller *phb)
-{
-	struct pci_bus *phb_bus;
-	int rc;
-
-	phb_bus = phb->bus;
-	if (!(list_empty(&phb_bus->children) &&
-	      list_empty(&phb_bus->devices))) {
-		return -EBUSY;
-	}
-
-	rc = pcibios_remove_root_bus(phb);
-	if (rc)
-		return -EIO;
-
-	device_unregister(phb_bus->bridge);
-	pci_remove_bus(phb_bus);
-
-	return 0;
-}
-
 static int dlpar_remove_phb(char *drc_name, struct device_node *dn)
 {
 	struct slot *slot;
@@ -235,18 +217,15 @@ static int dlpar_remove_phb(char *drc_na
 
 	/* If pci slot is hotplugable, use hotplug to remove it */
 	slot = find_php_slot(dn);
-	if (slot) {
-		if (rpaphp_deregister_slot(slot)) {
-			printk(KERN_ERR
-				"%s: unable to remove hotplug slot %s\n",
-				__func__, drc_name);
-			return -EIO;
-		}
+	if (slot && rpaphp_deregister_slot(slot)) {
+		printk(KERN_ERR "%s: unable to remove hotplug slot %s\n",
+		       __func__, drc_name);
+		return -EIO;
 	}
 
 	pdn = dn->data;
 	BUG_ON(!pdn || !pdn->phb);
-	rc = dlpar_remove_root_bus(pdn->phb);
+	rc = remove_phb_dynamic(pdn->phb);
 	if (rc < 0)
 		return rc;
 
@@ -378,26 +357,38 @@ int dlpar_remove_pci_slot(char *drc_name
 	if (!bus)
 		return -EINVAL;
 
-	/* If pci slot is hotplugable, use hotplug to remove it */
+	pr_debug("PCI: Removing PCI slot below EADS bridge %s\n",
+		 bus->self ? pci_name(bus->self) : "<!PHB!>");
+
 	slot = find_php_slot(dn);
 	if (slot) {
+		pr_debug("PCI: Removing hotplug slot for %04x:%02x...\n",
+			 pci_domain_nr(bus), bus->number);
+
 		if (rpaphp_deregister_slot(slot)) {
 			printk(KERN_ERR
 				"%s: unable to remove hotplug slot %s\n",
 				__func__, drc_name);
 			return -EIO;
 		}
-	} else
-		pcibios_remove_pci_devices(bus);
+	}
+
+	/* Remove all devices below slot */
+	pcibios_remove_pci_devices(bus);
 
+	/* Unmap PCI IO space */
 	if (pcibios_unmap_io_space(bus)) {
 		printk(KERN_ERR "%s: failed to unmap bus range\n",
 			__func__);
 		return -ERANGE;
 	}
 
+	/* Remove the EADS bridge device itself */
 	BUG_ON(!bus->self);
+	pr_debug("PCI: Now removing bridge device %s\n", pci_name(bus->self));
+	eeh_remove_bus_device(bus->self);
 	pci_remove_bus_device(bus->self);
+
 	return 0;
 }
 
