Return-Path: <nfont@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 411EDDDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 15:08:43 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9O47k8K002089
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 22:07:46 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9O48Z6f126372
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 22:08:37 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9O48YBY006129
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 22:08:34 -0600
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m9O48Yaj006124
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 22:08:34 -0600
Received: from [9.65.67.19] (sig-9-65-67-19.mts.ibm.com [9.65.67.19])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m9O48XJA058516
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 23:08:33 -0500
Message-ID: <49014A41.6040700@austin.ibm.com>
Date: Thu, 23 Oct 2008 23:08:33 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Allocate resources for PHB DLPAR add
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Resources for PHB's that are DLPAR added to a system are not acquired.
Not having these resources allocated causes an oops during DLPAR
remove of the PHB when we try to release non-existant resources.

The patch appears a bit messy, this is mainly due to moving everything
one tab to the left in the pcibios_allocate_bus_resources routine.  The
big functionality change in this routine is only that the 
list_for_each_entry() loop is pulled out and moved to the necessary
calling routine.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
 
---
Index: linux-2.6/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/pci-common.c	2008-10-21 21:26:18.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/pci-common.c	2008-10-21 22:16:54.000000000 -0500
@@ -986,69 +986,66 @@
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
@@ -1119,10 +1116,13 @@
 
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
Index: linux-2.6/arch/powerpc/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/pci.h	2008-10-21 21:26:18.000000000 -0500
+++ linux-2.6/arch/powerpc/include/asm/pci.h	2008-10-21 22:15:03.000000000 -0500
@@ -196,6 +196,8 @@
 
 extern void pcibios_claim_one_bus(struct pci_bus *b);
 
+extern void pcibios_allocate_bus_resources(struct pci_bus *bus);
+
 extern void pcibios_resource_survey(void);
 
 extern struct pci_controller *init_phb_dynamic(struct device_node *dn);
Index: linux-2.6/arch/powerpc/platforms/pseries/pci_dlpar.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/pci_dlpar.c	2008-10-21 21:26:18.000000000 -0500
+++ linux-2.6/arch/powerpc/platforms/pseries/pci_dlpar.c	2008-10-21 22:16:37.000000000 -0500
@@ -189,6 +189,7 @@
 {
 	struct pci_controller *phb;
 	int primary;
+	struct pci_bus *b;
 
 	primary = list_empty(&hose_list);
 	phb = pcibios_alloc_controller(dn);
@@ -203,6 +204,7 @@
 		eeh_add_device_tree_early(dn);
 
 	scan_phb(phb);
+	pcibios_allocate_bus_resources(phb->bus);
 	pcibios_fixup_new_pci_devices(phb->bus);
 	pci_bus_add_devices(phb->bus);
 	eeh_add_device_tree_late(phb->bus);
