Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 05 Dec 2007 11:53:01 +1100
Subject: [RFC/PATCH 2/6] powerpc: pci32: use generic
	pci_assign_unassign_resources
In-Reply-To: <1196815980.72143.899704305870.qpush@grosgo>
Message-Id: <20071205005410.C80A7DE08E@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes the 32 bits PowerPC PCI code use the generic code to assign
resources to devices that had unassigned or conflicting resources.

This allow to remove the local implementation that was incomplete and
could not assign for example a PCI<->PCI bridge from scratch, which is
needed on various embedded platforms.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci_32.c |  191 +++----------------------------------------
 1 file changed, 17 insertions(+), 174 deletions(-)

Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2007-12-04 17:02:12.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2007-12-04 17:02:13.000000000 +1100
@@ -37,10 +37,6 @@ int pcibios_assign_bus_offset = 1;
 
 void pcibios_make_OF_bus_map(void);
 
-static int pci_relocate_bridge_resource(struct pci_bus *bus, int i);
-static int probe_resource(struct pci_bus *parent, struct resource *pr,
-			  struct resource *res, struct resource **conflict);
-static void update_bridge_base(struct pci_bus *bus, int i);
 static void pcibios_fixup_resources(struct pci_dev* dev);
 static void fixup_broken_pcnet32(struct pci_dev* dev);
 static int reparent_resources(struct resource *parent, struct resource *res);
@@ -134,7 +130,7 @@ pcibios_fixup_resources(struct pci_dev *
 		if (offset != 0) {
 			res->start = (res->start + offset) & mask;
 			res->end = (res->end + offset) & mask;
-			DBG("Fixup res %d (%lx) of dev %s: %llx -> %llx\n",
+			DBG("PCI: Fixup res %d (0x%lx) of dev %s: %llx -> %llx\n",
 			    i, res->flags, pci_name(dev),
 			    (u64)res->start - offset, (u64)res->start);
 		}
@@ -267,9 +263,12 @@ pcibios_allocate_bus_resources(struct li
 				}
 			}
 
-			DBG("PCI: bridge rsrc %llx..%llx (%lx), parent %p\n",
+			DBG("PCI: dev %s (bus 0x%02x) bridge rsrc %d: %016llx..%016llx "
+			    "(f:0x%08lx), parent %p\n",
+			    bus->self ? pci_name(bus->self) : "PHB", bus->number, i,
 			    (u64)res->start, (u64)res->end, res->flags, pr);
-			if (pr) {
+
+			if (pr && !(pr->flags & IORESOURCE_UNSET)) {
 				if (request_resource(pr, res) == 0)
 					continue;
 				/*
@@ -280,10 +279,11 @@ pcibios_allocate_bus_resources(struct li
 				if (reparent_resources(pr, res) == 0)
 					continue;
 			}
-			printk(KERN_ERR "PCI: Cannot allocate resource region "
-			       "%d of PCI bridge %d\n", i, bus->number);
-			if (pci_relocate_bridge_resource(bus, i))
-				bus->resource[i] = NULL;
+			printk(KERN_WARNING
+			       "PCI: Cannot allocate resource region "
+			       "%d of PCI bridge %d, will remap\n",
+			       i, bus->number);
+			res->flags |= IORESOURCE_UNSET;
 		}
 		pcibios_allocate_bus_resources(&bus->children);
 	}
@@ -324,112 +324,6 @@ reparent_resources(struct resource *pare
 	return 0;
 }
 
-/*
- * A bridge has been allocated a range which is outside the range
- * of its parent bridge, so it needs to be moved.
- */
-static int __init
-pci_relocate_bridge_resource(struct pci_bus *bus, int i)
-{
-	struct resource *res, *pr, *conflict;
-	resource_size_t try, size;
-	struct pci_bus *parent = bus->parent;
-	int j;
-
-	if (parent == NULL) {
-		/* shouldn't ever happen */
-		printk(KERN_ERR "PCI: can't move host bridge resource\n");
-		return -1;
-	}
-	res = bus->resource[i];
-	if (res == NULL)
-		return -1;
-	pr = NULL;
-	for (j = 0; j < 4; j++) {
-		struct resource *r = parent->resource[j];
-		if (!r)
-			continue;
-		if ((res->flags ^ r->flags) & (IORESOURCE_IO | IORESOURCE_MEM))
-			continue;
-		if (!((res->flags ^ r->flags) & IORESOURCE_PREFETCH)) {
-			pr = r;
-			break;
-		}
-		if (res->flags & IORESOURCE_PREFETCH)
-			pr = r;
-	}
-	if (pr == NULL)
-		return -1;
-	size = res->end - res->start;
-	if (pr->start > pr->end || size > pr->end - pr->start)
-		return -1;
-	try = pr->end;
-	for (;;) {
-		res->start = try - size;
-		res->end = try;
-		if (probe_resource(bus->parent, pr, res, &conflict) == 0)
-			break;
-		if (conflict->start <= pr->start + size)
-			return -1;
-		try = conflict->start - 1;
-	}
-	if (request_resource(pr, res)) {
-		DBG(KERN_ERR "PCI: huh? couldn't move to %llx..%llx\n",
-		    (u64)res->start, (u64)res->end);
-		return -1;		/* "can't happen" */
-	}
-	update_bridge_base(bus, i);
-	printk(KERN_INFO "PCI: bridge %d resource %d moved to %llx..%llx\n",
-	       bus->number, i, (unsigned long long)res->start,
-	       (unsigned long long)res->end);
-	return 0;
-}
-
-static int __init
-probe_resource(struct pci_bus *parent, struct resource *pr,
-	       struct resource *res, struct resource **conflict)
-{
-	struct pci_bus *bus;
-	struct pci_dev *dev;
-	struct resource *r;
-	int i;
-
-	for (r = pr->child; r != NULL; r = r->sibling) {
-		if (r->end >= res->start && res->end >= r->start) {
-			*conflict = r;
-			return 1;
-		}
-	}
-	list_for_each_entry(bus, &parent->children, node) {
-		for (i = 0; i < 4; ++i) {
-			if ((r = bus->resource[i]) == NULL)
-				continue;
-			if (!r->flags || r->start > r->end || r == res)
-				continue;
-			if (pci_find_parent_resource(bus->self, r) != pr)
-				continue;
-			if (r->end >= res->start && res->end >= r->start) {
-				*conflict = r;
-				return 1;
-			}
-		}
-	}
-	list_for_each_entry(dev, &parent->devices, bus_list) {
-		for (i = 0; i < 6; ++i) {
-			r = &dev->resource[i];
-			if (!r->flags || (r->flags & IORESOURCE_UNSET))
-				continue;
-			if (pci_find_parent_resource(dev, r) != pr)
-				continue;
-			if (r->end >= res->start && res->end >= r->start) {
-				*conflict = r;
-				return 1;
-			}
-		}
-	}
-	return 0;
-}
-
 void __init
 update_bridge_resource(struct pci_dev *dev, struct resource *res)
 {
@@ -486,24 +380,16 @@ update_bridge_resource(struct pci_dev *d
 	pci_write_config_word(dev, PCI_COMMAND, cmd);
 }
 
-static void __init
-update_bridge_base(struct pci_bus *bus, int i)
-{
-	struct resource *res = bus->resource[i];
-	struct pci_dev *dev = bus->self;
-	update_bridge_resource(dev, res);
-}
-
 static inline void alloc_resource(struct pci_dev *dev, int idx)
 {
 	struct resource *pr, *r = &dev->resource[idx];
 
-	DBG("PCI:%s: Resource %d: %016llx-%016llx (f=%lx)\n",
+	DBG("PCI: Allocating %s: Resource %d: %016llx..%016llx (f=%lx)\n",
 	    pci_name(dev), idx, (u64)r->start, (u64)r->end, r->flags);
 	pr = pci_find_parent_resource(dev, r);
-	if (!pr || request_resource(pr, r) < 0) {
-		printk(KERN_WARNING "PCI: Remapping resource region %d"
-		       " of device %s\n", idx, pci_name(dev));
+	if (!pr || (pr->flags & IORESOURCE_UNSET) ||  request_resource(pr, r) < 0) {
+		printk(KERN_WARNING "PCI: Cannot allocate resource region %d"
+		       " of device %s, will remap\n", idx, pci_name(dev));
 		if (pr)
 			DBG("PCI:  parent is %p: %016llx-%016llx (f=%lx)\n",
 			    pr, (u64)pr->start, (u64)pr->end, pr->flags);
@@ -552,50 +438,6 @@ pcibios_allocate_resources(int pass)
 	}
 }
 
-static void __init
-pcibios_assign_resources(void)
-{
-	struct pci_dev *dev = NULL;
-	int idx;
-	struct resource *r;
-
-	for_each_pci_dev(dev) {
-		int class = dev->class >> 8;
-
-		/* Don't touch classless devices and host bridges */
-		if (!class || class == PCI_CLASS_BRIDGE_HOST)
-			continue;
-
-		for (idx = 0; idx < 6; idx++) {
-			r = &dev->resource[idx];
-
-			/*
-			 * We shall assign a new address to this resource,
-			 * either because the BIOS (sic) forgot to do so
-			 * or because we have decided the old address was
-			 * unusable for some reason.
-			 */
-			if ((r->flags & IORESOURCE_UNSET) && r->end &&
-			    (!ppc_md.pcibios_enable_device_hook ||
-			     !ppc_md.pcibios_enable_device_hook(dev, 1))) {
-				int rc;
-
-				r->flags &= ~IORESOURCE_UNSET;
-				rc = pci_assign_resource(dev, idx);
-				BUG_ON(rc);
-			}
-		}
-
-#if 0 /* don't assign ROMs */
-		r = &dev->resource[PCI_ROM_RESOURCE];
-		r->end -= r->start;
-		r->start = 0;
-		if (r->end)
-			pci_assign_resource(dev, PCI_ROM_RESOURCE);
-#endif
-	}
-}
-
 #ifdef CONFIG_PPC_OF
 /*
  * Functions below are used on OpenFirmware machines.
@@ -1122,7 +964,8 @@ pcibios_init(void)
 #ifdef CONFIG_PPC_PMAC
 	pcibios_fixup_p2p_bridges();
 #endif /* CONFIG_PPC_PMAC */
-	pcibios_assign_resources();
+	DBG("PCI: Assigning unassigned resouces...\n");
+	pci_assign_unassigned_resources();
 
 	/* Call machine dependent post-init code */
 	if (ppc_md.pcibios_after_init)
