Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Oct 2008 16:48:17 +1100
Subject: [PATCH 1/10] powerpc/pci: Properly allocate bus resources for hotplug
	PHBs
In-Reply-To: <1225172895.217185.958686212130.qpush@grosgo>
Message-Id: <20081028054919.6B966DDF03@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Nathan Fontenot <nfont@austin.ibm.com>

Resources for PHB's that are dynamically added to a system are not
properly allocated in the resource tree.

Not having these resources allocated causes an oops when removing
the PHB when we try to release them.

The patch appears a bit messy, this is mainly due to moving everything
one tab to the left in the pcibios_allocate_bus_resources routine.  The
big functionality change in this routine is only that the 
list_for_each_entry() loop is pulled out and moved to the necessary
calling routine.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

 arch/powerpc/include/asm/pci.h             |    2 
 arch/powerpc/kernel/pci-common.c           |  110 ++++++++++++++---------------
 arch/powerpc/platforms/pseries/pci_dlpar.c |    2 
 3 files changed, 59 insertions(+), 55 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-10-28 15:02:27.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-10-28 15:02:50.000000000 +1100
@@ -1239,69 +1239,66 @@ static int __init reparent_resources(str
  *	    as well.
  */
 
-static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
+void pcibios_allocate_bus_resources(struct pci_bus *bus)
 {
-	struct pci_bus *bus;
+	struct pci_bus *b;
 	int i;
 	struct resource *res, *pr;
 
-	/* Depth-First Search on bus tree */
-	list_for_each_entry(bus, bus_list, node) {
-		for (i = 0; i < PCI_BUS_NUM_RESOURCES; ++i) {
-			if ((res = bus->resource[i]) == NULL || !res->flags
-			    || res->start > res->end)
-				continue;
-			if (bus->parent == NULL)
-				pr = (res->flags & IORESOURCE_IO) ?
-					&ioport_resource : &iomem_resource;
-			else {
-				/* Don't bother with non-root busses when
-				 * re-assigning all resources. We clear the
-				 * resource flags as if they were colliding
-				 * and as such ensure proper re-allocation
-				 * later.
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; ++i) {
+		if ((res = bus->resource[i]) == NULL || !res->flags
+		    || res->start > res->end)
+			continue;
+		if (bus->parent == NULL)
+			pr = (res->flags & IORESOURCE_IO) ?
+				&ioport_resource : &iomem_resource;
+		else {
+			/* Don't bother with non-root busses when
+			 * re-assigning all resources. We clear the
+			 * resource flags as if they were colliding
+			 * and as such ensure proper re-allocation
+			 * later.
+			 */
+			if (ppc_pci_flags & PPC_PCI_REASSIGN_ALL_RSRC)
+				goto clear_resource;
+			pr = pci_find_parent_resource(bus->self, res);
+			if (pr == res) {
+				/* this happens when the generic PCI
+				 * code (wrongly) decides that this
+				 * bridge is transparent  -- paulus
 				 */
-				if (ppc_pci_flags & PPC_PCI_REASSIGN_ALL_RSRC)
-					goto clear_resource;
-				pr = pci_find_parent_resource(bus->self, res);
-				if (pr == res) {
-					/* this happens when the generic PCI
-					 * code (wrongly) decides that this
-					 * bridge is transparent  -- paulus
-					 */
-					continue;
-				}
+				continue;
 			}
+		}
 
-			DBG("PCI: %s (bus %d) bridge rsrc %d: %016llx-%016llx "
-			    "[0x%x], parent %p (%s)\n",
-			    bus->self ? pci_name(bus->self) : "PHB",
-			    bus->number, i,
-			    (unsigned long long)res->start,
-			    (unsigned long long)res->end,
-			    (unsigned int)res->flags,
-			    pr, (pr && pr->name) ? pr->name : "nil");
-
-			if (pr && !(pr->flags & IORESOURCE_UNSET)) {
-				if (request_resource(pr, res) == 0)
-					continue;
-				/*
-				 * Must be a conflict with an existing entry.
-				 * Move that entry (or entries) under the
-				 * bridge resource and try again.
-				 */
-				if (reparent_resources(pr, res) == 0)
-					continue;
-			}
-			printk(KERN_WARNING
-			       "PCI: Cannot allocate resource region "
-			       "%d of PCI bridge %d, will remap\n",
-			       i, bus->number);
-clear_resource:
-			res->flags = 0;
+		DBG("PCI: %s (bus %d) bridge rsrc %d: %016llx-%016llx "
+		    "[0x%x], parent %p (%s)\n",
+		    bus->self ? pci_name(bus->self) : "PHB",
+		    bus->number, i,
+		    (unsigned long long)res->start,
+		    (unsigned long long)res->end,
+		    (unsigned int)res->flags,
+		    pr, (pr && pr->name) ? pr->name : "nil");
+
+		if (pr && !(pr->flags & IORESOURCE_UNSET)) {
+			if (request_resource(pr, res) == 0)
+				continue;
+			/*
+			 * Must be a conflict with an existing entry.
+			 * Move that entry (or entries) under the
+			 * bridge resource and try again.
+			 */
+			if (reparent_resources(pr, res) == 0)
+				continue;
 		}
-		pcibios_allocate_bus_resources(&bus->children);
+		printk(KERN_WARNING "PCI: Cannot allocate resource region "
+		       "%d of PCI bridge %d, will remap\n", i, bus->number);
+clear_resource:
+		res->flags = 0;
 	}
+
+	list_for_each_entry(b, &bus->children, node)
+		pcibios_allocate_bus_resources(b);
 }
 
 static inline void __devinit alloc_resource(struct pci_dev *dev, int idx)
@@ -1372,10 +1369,13 @@ static void __init pcibios_allocate_reso
 
 void __init pcibios_resource_survey(void)
 {
+	struct pci_bus *b;
+
 	/* Allocate and assign resources. If we re-assign everything, then
 	 * we skip the allocate phase
 	 */
-	pcibios_allocate_bus_resources(&pci_root_buses);
+	list_for_each_entry(b, &pci_root_buses, node)
+		pcibios_allocate_bus_resources(b);
 
 	if (!(ppc_pci_flags & PPC_PCI_REASSIGN_ALL_RSRC)) {
 		pcibios_allocate_resources(0);
Index: linux-work/arch/powerpc/include/asm/pci.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pci.h	2008-10-28 15:02:27.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pci.h	2008-10-28 15:02:50.000000000 +1100
@@ -208,6 +208,8 @@ extern void pcibios_setup_new_device(str
 
 extern void pcibios_claim_one_bus(struct pci_bus *b);
 
+extern void pcibios_allocate_bus_resources(struct pci_bus *bus);
+
 extern void pcibios_resource_survey(void);
 
 extern struct pci_controller *init_phb_dynamic(struct device_node *dn);
Index: linux-work/arch/powerpc/platforms/pseries/pci_dlpar.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/pci_dlpar.c	2008-10-28 15:02:27.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/pci_dlpar.c	2008-10-28 15:02:50.000000000 +1100
@@ -189,6 +189,7 @@ struct pci_controller * __devinit init_p
 {
 	struct pci_controller *phb;
 	int primary;
+	struct pci_bus *b;
 
 	primary = list_empty(&hose_list);
 	phb = pcibios_alloc_controller(dn);
@@ -203,6 +204,7 @@ struct pci_controller * __devinit init_p
 		eeh_add_device_tree_early(dn);
 
 	scan_phb(phb);
+	pcibios_allocate_bus_resources(phb->bus);
 	pcibios_fixup_new_pci_devices(phb->bus);
 	pci_bus_add_devices(phb->bus);
 	eeh_add_device_tree_late(phb->bus);
