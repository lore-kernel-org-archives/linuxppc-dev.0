Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 14:54:53 +1100
Subject: [PATCH 9/19] [POWERPC] Merge PCI resource allocation & assignment
In-Reply-To: <1198122881.874131.56762399546.qpush@grosgo>
Message-Id: <20071220035456.B1D77DDDFB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 32 bits PCI code now uses the generic code for assigning unassigned
resources and an algorithm similar to x86 for claiming existing ones.

This works far better than the 64 bits code which basically can only
claim existing ones (pci_probe_only=1) or would fall appart completely.

This merges them so that the new 32 bits implementation is used for both.

64 bits now gets the new PCI flags for controlling the behaviour, though
the old pci_probe_only global is still there for now to be cleared if you
want to.

I kept a pcibios_claim_one_bus() function mostly based on the old 64
bits code for use by the DLPAR hotplug. This will have to be cleaned
up, thought I hope it will work in the meantime.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c      |  292 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c          |  246 ----------------------------
 arch/powerpc/kernel/pci_64.c          |  118 +------------
 arch/powerpc/platforms/powermac/pci.c |    3 
 include/asm-powerpc/pci.h             |    8 
 5 files changed, 311 insertions(+), 356 deletions(-)

--- linux-merge.orig/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:31.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:32.000000000 +1100
@@ -53,6 +53,8 @@ static int global_phb_number;		/* Global
 /* ISA Memory physical address */
 resource_size_t isa_mem_base;
 
+/* Default PCI flags is 0 */
+unsigned int ppc_pci_flags;
 
 struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 {
@@ -821,3 +823,293 @@ void __devinit pcibios_fixup_of_probed_b
 {
 	__pcibios_fixup_bus(bus);
 }
+
+static int skip_isa_ioresource_align(struct pci_dev *dev)
+{
+	if ((ppc_pci_flags & PPC_PCI_CAN_SKIP_ISA_ALIGN) &&
+	    !(dev->bus->bridge_ctl & PCI_BRIDGE_CTL_ISA))
+		return 1;
+	return 0;
+}
+
+/*
+ * We need to avoid collisions with `mirrored' VGA ports
+ * and other strange ISA hardware, so we always want the
+ * addresses to be allocated in the 0x000-0x0ff region
+ * modulo 0x400.
+ *
+ * Why? Because some silly external IO cards only decode
+ * the low 10 bits of the IO address. The 0x00-0xff region
+ * is reserved for motherboard devices that decode all 16
+ * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
+ * but we want to try to avoid allocating at 0x2900-0x2bff
+ * which might have be mirrored at 0x0100-0x03ff..
+ */
+void pcibios_align_resource(void *data, struct resource *res,
+				resource_size_t size, resource_size_t align)
+{
+	struct pci_dev *dev = data;
+
+	if (res->flags & IORESOURCE_IO) {
+		resource_size_t start = res->start;
+
+		if (skip_isa_ioresource_align(dev))
+			return;
+		if (start & 0x300) {
+			start = (start + 0x3ff) & ~0x3ff;
+			res->start = start;
+		}
+	}
+}
+EXPORT_SYMBOL(pcibios_align_resource);
+
+/*
+ * Reparent resource children of pr that conflict with res
+ * under res, and make res replace those children.
+ */
+static int __init reparent_resources(struct resource *parent,
+				     struct resource *res)
+{
+	struct resource *p, **pp;
+	struct resource **firstpp = NULL;
+
+	for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
+		if (p->end < res->start)
+			continue;
+		if (res->end < p->start)
+			break;
+		if (p->start < res->start || p->end > res->end)
+			return -1;	/* not completely contained */
+		if (firstpp == NULL)
+			firstpp = pp;
+	}
+	if (firstpp == NULL)
+		return -1;	/* didn't find any conflicting entries? */
+	res->parent = parent;
+	res->child = *firstpp;
+	res->sibling = *pp;
+	*firstpp = res;
+	*pp = NULL;
+	for (p = res->child; p != NULL; p = p->sibling) {
+		p->parent = res;
+		DBG(KERN_INFO "PCI: reparented %s [%llx..%llx] under %s\n",
+		    p->name,
+		    (unsigned long long)p->start,
+		    (unsigned long long)p->end, res->name);
+	}
+	return 0;
+}
+
+/*
+ *  Handle resources of PCI devices.  If the world were perfect, we could
+ *  just allocate all the resource regions and do nothing more.  It isn't.
+ *  On the other hand, we cannot just re-allocate all devices, as it would
+ *  require us to know lots of host bridge internals.  So we attempt to
+ *  keep as much of the original configuration as possible, but tweak it
+ *  when it's found to be wrong.
+ *
+ *  Known BIOS problems we have to work around:
+ *	- I/O or memory regions not configured
+ *	- regions configured, but not enabled in the command register
+ *	- bogus I/O addresses above 64K used
+ *	- expansion ROMs left enabled (this may sound harmless, but given
+ *	  the fact the PCI specs explicitly allow address decoders to be
+ *	  shared between expansion ROMs and other resource regions, it's
+ *	  at least dangerous)
+ *
+ *  Our solution:
+ *	(1) Allocate resources for all buses behind PCI-to-PCI bridges.
+ *	    This gives us fixed barriers on where we can allocate.
+ *	(2) Allocate resources for all enabled devices.  If there is
+ *	    a collision, just mark the resource as unallocated. Also
+ *	    disable expansion ROMs during this step.
+ *	(3) Try to allocate resources for disabled devices.  If the
+ *	    resources were assigned correctly, everything goes well,
+ *	    if they weren't, they won't disturb allocation of other
+ *	    resources.
+ *	(4) Assign new addresses to resources which were either
+ *	    not configured at all or misconfigured.  If explicitly
+ *	    requested by the user, configure expansion ROM address
+ *	    as well.
+ */
+
+static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
+{
+	struct pci_bus *bus;
+	int i;
+	struct resource *res, *pr;
+
+	/* Depth-First Search on bus tree */
+	list_for_each_entry(bus, bus_list, node) {
+		for (i = 0; i < PCI_BUS_NUM_RESOURCES; ++i) {
+			if ((res = bus->resource[i]) == NULL || !res->flags
+			    || res->start > res->end)
+				continue;
+			if (bus->parent == NULL)
+				pr = (res->flags & IORESOURCE_IO)?
+					&ioport_resource : &iomem_resource;
+			else {
+				/* Don't bother with non-root busses when
+				 * re-assigning all resources. We clear the
+				 * resource flags as if they were colliding
+				 * and as such ensure proper re-allocation
+				 * later.
+				 */
+				if (ppc_pci_flags & PPC_PCI_REASSIGN_ALL_RSRC)
+					goto clear_resource;
+				pr = pci_find_parent_resource(bus->self, res);
+				if (pr == res) {
+					/* this happens when the generic PCI
+					 * code (wrongly) decides that this
+					 * bridge is transparent  -- paulus
+					 */
+					continue;
+				}
+			}
+
+			DBG("PCI: %s (bus %d) bridge rsrc %d: %016llx-%016llx "
+			    "[0x%x], parent %p (%s)\n",
+			    bus->self ? pci_name(bus->self) : "PHB",
+			    bus->number, i,
+			    (unsigned long long)res->start,
+			    (unsigned long long)res->end,
+			    (unsigned int)res->flags,
+			    pr, (pr && pr->name) ? pr->name : "nil");
+
+			if (pr && !(pr->flags & IORESOURCE_UNSET)) {
+				if (request_resource(pr, res) == 0)
+					continue;
+				/*
+				 * Must be a conflict with an existing entry.
+				 * Move that entry (or entries) under the
+				 * bridge resource and try again.
+				 */
+				if (reparent_resources(pr, res) == 0)
+					continue;
+			}
+			printk(KERN_WARNING
+			       "PCI: Cannot allocate resource region "
+			       "%d of PCI bridge %d, will remap\n",
+			       i, bus->number);
+clear_resource:
+			res->flags = 0;
+		}
+		pcibios_allocate_bus_resources(&bus->children);
+	}
+}
+
+static inline void __devinit alloc_resource(struct pci_dev *dev, int idx)
+{
+	struct resource *pr, *r = &dev->resource[idx];
+
+	DBG("PCI: Allocating %s: Resource %d: %016llx..%016llx [%x]\n",
+	    pci_name(dev), idx,
+	    (unsigned long long)r->start,
+	    (unsigned long long)r->end,
+	    (unsigned int)r->flags);
+
+	pr = pci_find_parent_resource(dev, r);
+	if (!pr || (pr->flags & IORESOURCE_UNSET) ||
+	    request_resource(pr, r) < 0) {
+		printk(KERN_WARNING "PCI: Cannot allocate resource region %d"
+		       " of device %s, will remap\n", idx, pci_name(dev));
+		if (pr)
+			DBG("PCI:  parent is %p: %016llx-%016llx [%x]\n", pr,
+			    (unsigned long long)pr->start,
+			    (unsigned long long)pr->end,
+			    (unsigned int)pr->flags);
+		/* We'll assign a new address later */
+		r->flags |= IORESOURCE_UNSET;
+		r->end -= r->start;
+		r->start = 0;
+	}
+}
+
+static void __init pcibios_allocate_resources(int pass)
+{
+	struct pci_dev *dev = NULL;
+	int idx, disabled;
+	u16 command;
+	struct resource *r;
+
+	for_each_pci_dev(dev) {
+		pci_read_config_word(dev, PCI_COMMAND, &command);
+		for (idx = 0; idx < 6; idx++) {
+			r = &dev->resource[idx];
+			if (r->parent)		/* Already allocated */
+				continue;
+			if (!r->flags || (r->flags & IORESOURCE_UNSET))
+				continue;	/* Not assigned at all */
+			if (r->flags & IORESOURCE_IO)
+				disabled = !(command & PCI_COMMAND_IO);
+			else
+				disabled = !(command & PCI_COMMAND_MEMORY);
+			if (pass == disabled)
+				alloc_resource(dev, idx);
+		}
+		if (pass)
+			continue;
+		r = &dev->resource[PCI_ROM_RESOURCE];
+		if (r->flags & IORESOURCE_ROM_ENABLE) {
+			/* Turn the ROM off, leave the resource region,
+			 * but keep it unregistered.
+			 */
+			u32 reg;
+			DBG("PCI: Switching off ROM of %s\n", pci_name(dev));
+			r->flags &= ~IORESOURCE_ROM_ENABLE;
+			pci_read_config_dword(dev, dev->rom_base_reg, &reg);
+			pci_write_config_dword(dev, dev->rom_base_reg,
+					       reg & ~PCI_ROM_ADDRESS_ENABLE);
+		}
+	}
+}
+
+void __init pcibios_resource_survey(void)
+{
+	/* Allocate and assign resources. If we re-assign everything, then
+	 * we skip the allocate phase
+	 */
+	pcibios_allocate_bus_resources(&pci_root_buses);
+
+	if (!(ppc_pci_flags & PPC_PCI_REASSIGN_ALL_RSRC)) {
+		pcibios_allocate_resources(0);
+		pcibios_allocate_resources(1);
+	}
+
+	if (!(ppc_pci_flags & PPC_PCI_PROBE_ONLY)) {
+		DBG("PCI: Assigning unassigned resouces...\n");
+		pci_assign_unassigned_resources();
+	}
+
+	/* Call machine dependent fixup */
+	if (ppc_md.pcibios_fixup)
+		ppc_md.pcibios_fixup();
+}
+
+#ifdef CONFIG_HOTPLUG
+/* This is used by the pSeries hotplug driver to allocate resource
+ * of newly plugged busses. We can try to consolidate with the
+ * rest of the code later, for now, keep it as-is
+ */
+void __devinit pcibios_claim_one_bus(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	struct pci_bus *child_bus;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		int i;
+
+		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+			struct resource *r = &dev->resource[i];
+
+			if (r->parent || !r->start || !r->flags)
+				continue;
+			pci_claim_resource(dev, i);
+		}
+	}
+
+	list_for_each_entry(child_bus, &bus->children, node)
+		pcibios_claim_one_bus(child_bus);
+}
+EXPORT_SYMBOL_GPL(pcibios_claim_one_bus);
+#endif /* CONFIG_HOTPLUG */
Index: linux-merge/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:31.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:32.000000000 +1100
@@ -35,13 +35,9 @@ unsigned long isa_io_base     = 0;
 unsigned long pci_dram_offset = 0;
 int pcibios_assign_bus_offset = 1;
 
-/* Default PCI flags is 0 */
-unsigned int ppc_pci_flags;
-
 void pcibios_make_OF_bus_map(void);
 
 static void fixup_broken_pcnet32(struct pci_dev* dev);
-static int reparent_resources(struct resource *parent, struct resource *res);
 static void fixup_cpc710_pci64(struct pci_dev* dev);
 #ifdef CONFIG_PPC_OF
 static u8* pci_to_OF_bus_map;
@@ -97,170 +93,6 @@ fixup_cpc710_pci64(struct pci_dev* dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixup_cpc710_pci64);
 
-static int skip_isa_ioresource_align(struct pci_dev *dev)
-{
-	if ((ppc_pci_flags & PPC_PCI_CAN_SKIP_ISA_ALIGN) &&
-	    !(dev->bus->bridge_ctl & PCI_BRIDGE_CTL_ISA))
-		return 1;
-	return 0;
-}
-
-/*
- * We need to avoid collisions with `mirrored' VGA ports
- * and other strange ISA hardware, so we always want the
- * addresses to be allocated in the 0x000-0x0ff region
- * modulo 0x400.
- *
- * Why? Because some silly external IO cards only decode
- * the low 10 bits of the IO address. The 0x00-0xff region
- * is reserved for motherboard devices that decode all 16
- * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
- * but we want to try to avoid allocating at 0x2900-0x2bff
- * which might have be mirrored at 0x0100-0x03ff..
- */
-void pcibios_align_resource(void *data, struct resource *res,
-				resource_size_t size, resource_size_t align)
-{
-	struct pci_dev *dev = data;
-
-	if (res->flags & IORESOURCE_IO) {
-		resource_size_t start = res->start;
-
-		if (skip_isa_ioresource_align(dev))
-			return;
-		if (start & 0x300) {
-			start = (start + 0x3ff) & ~0x3ff;
-			res->start = start;
-		}
-	}
-}
-EXPORT_SYMBOL(pcibios_align_resource);
-
-/*
- *  Handle resources of PCI devices.  If the world were perfect, we could
- *  just allocate all the resource regions and do nothing more.  It isn't.
- *  On the other hand, we cannot just re-allocate all devices, as it would
- *  require us to know lots of host bridge internals.  So we attempt to
- *  keep as much of the original configuration as possible, but tweak it
- *  when it's found to be wrong.
- *
- *  Known BIOS problems we have to work around:
- *	- I/O or memory regions not configured
- *	- regions configured, but not enabled in the command register
- *	- bogus I/O addresses above 64K used
- *	- expansion ROMs left enabled (this may sound harmless, but given
- *	  the fact the PCI specs explicitly allow address decoders to be
- *	  shared between expansion ROMs and other resource regions, it's
- *	  at least dangerous)
- *
- *  Our solution:
- *	(1) Allocate resources for all buses behind PCI-to-PCI bridges.
- *	    This gives us fixed barriers on where we can allocate.
- *	(2) Allocate resources for all enabled devices.  If there is
- *	    a collision, just mark the resource as unallocated. Also
- *	    disable expansion ROMs during this step.
- *	(3) Try to allocate resources for disabled devices.  If the
- *	    resources were assigned correctly, everything goes well,
- *	    if they weren't, they won't disturb allocation of other
- *	    resources.
- *	(4) Assign new addresses to resources which were either
- *	    not configured at all or misconfigured.  If explicitly
- *	    requested by the user, configure expansion ROM address
- *	    as well.
- */
-
-static void __init
-pcibios_allocate_bus_resources(struct list_head *bus_list)
-{
-	struct pci_bus *bus;
-	int i;
-	struct resource *res, *pr;
-
-	/* Depth-First Search on bus tree */
-	list_for_each_entry(bus, bus_list, node) {
-		for (i = 0; i < 4; ++i) {
-			if ((res = bus->resource[i]) == NULL || !res->flags
-			    || res->start > res->end)
-				continue;
-			if (bus->parent == NULL)
-				pr = (res->flags & IORESOURCE_IO)?
-					&ioport_resource : &iomem_resource;
-			else {
-				/* Don't bother with non-root busses when
-				 * re-assigning all resources.
-				 */
-				if (ppc_pci_flags & PPC_PCI_REASSIGN_ALL_RSRC)
-					continue;
-				pr = pci_find_parent_resource(bus->self, res);
-				if (pr == res) {
-					/* this happens when the generic PCI
-					 * code (wrongly) decides that this
-					 * bridge is transparent  -- paulus
-					 */
-					continue;
-				}
-			}
-
-			DBG("PCI: dev %s (bus 0x%02x) bridge rsrc %d: %016llx..%016llx "
-			    "(f:0x%08lx), parent %p\n",
-			    bus->self ? pci_name(bus->self) : "PHB", bus->number, i,
-			    (u64)res->start, (u64)res->end, res->flags, pr);
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
-			res->flags |= IORESOURCE_UNSET;
-		}
-		pcibios_allocate_bus_resources(&bus->children);
-	}
-}
-
-/*
- * Reparent resource children of pr that conflict with res
- * under res, and make res replace those children.
- */
-static int __init
-reparent_resources(struct resource *parent, struct resource *res)
-{
-	struct resource *p, **pp;
-	struct resource **firstpp = NULL;
-
-	for (pp = &parent->child; (p = *pp) != NULL; pp = &p->sibling) {
-		if (p->end < res->start)
-			continue;
-		if (res->end < p->start)
-			break;
-		if (p->start < res->start || p->end > res->end)
-			return -1;	/* not completely contained */
-		if (firstpp == NULL)
-			firstpp = pp;
-	}
-	if (firstpp == NULL)
-		return -1;	/* didn't find any conflicting entries? */
-	res->parent = parent;
-	res->child = *firstpp;
-	res->sibling = *pp;
-	*firstpp = res;
-	*pp = NULL;
-	for (p = res->child; p != NULL; p = p->sibling) {
-		p->parent = res;
-		DBG(KERN_INFO "PCI: reparented %s [%llx..%llx] under %s\n",
-		    p->name, (u64)p->start, (u64)p->end, res->name);
-	}
-	return 0;
-}
 
 void __init
 update_bridge_resource(struct pci_dev *dev, struct resource *res)
@@ -318,63 +150,6 @@ update_bridge_resource(struct pci_dev *d
 	pci_write_config_word(dev, PCI_COMMAND, cmd);
 }
 
-static inline void alloc_resource(struct pci_dev *dev, int idx)
-{
-	struct resource *pr, *r = &dev->resource[idx];
-
-	DBG("PCI: Allocating %s: Resource %d: %016llx..%016llx (f=%lx)\n",
-	    pci_name(dev), idx, (u64)r->start, (u64)r->end, r->flags);
-	pr = pci_find_parent_resource(dev, r);
-	if (!pr || (pr->flags & IORESOURCE_UNSET) ||  request_resource(pr, r) < 0) {
-		printk(KERN_WARNING "PCI: Cannot allocate resource region %d"
-		       " of device %s, will remap\n", idx, pci_name(dev));
-		if (pr)
-			DBG("PCI:  parent is %p: %016llx-%016llx (f=%lx)\n",
-			    pr, (u64)pr->start, (u64)pr->end, pr->flags);
-		/* We'll assign a new address later */
-		r->flags |= IORESOURCE_UNSET;
-		r->end -= r->start;
-		r->start = 0;
-	}
-}
-
-static void __init
-pcibios_allocate_resources(int pass)
-{
-	struct pci_dev *dev = NULL;
-	int idx, disabled;
-	u16 command;
-	struct resource *r;
-
-	for_each_pci_dev(dev) {
-		pci_read_config_word(dev, PCI_COMMAND, &command);
-		for (idx = 0; idx < 6; idx++) {
-			r = &dev->resource[idx];
-			if (r->parent)		/* Already allocated */
-				continue;
-			if (!r->flags || (r->flags & IORESOURCE_UNSET))
-				continue;	/* Not assigned at all */
-			if (r->flags & IORESOURCE_IO)
-				disabled = !(command & PCI_COMMAND_IO);
-			else
-				disabled = !(command & PCI_COMMAND_MEMORY);
-			if (pass == disabled)
-				alloc_resource(dev, idx);
-		}
-		if (pass)
-			continue;
-		r = &dev->resource[PCI_ROM_RESOURCE];
-		if (r->flags & IORESOURCE_ROM_ENABLE) {
-			/* Turn the ROM off, leave the resource region, but keep it unregistered. */
-			u32 reg;
-			DBG("PCI: Switching off ROM of %s\n", pci_name(dev));
-			r->flags &= ~IORESOURCE_ROM_ENABLE;
-			pci_read_config_dword(dev, dev->rom_base_reg, &reg);
-			pci_write_config_dword(dev, dev->rom_base_reg,
-					       reg & ~PCI_ROM_ADDRESS_ENABLE);
-		}
-	}
-}
 
 #ifdef CONFIG_PPC_OF
 /*
@@ -649,8 +424,7 @@ void pcibios_make_OF_bus_map(void)
 }
 #endif /* CONFIG_PPC_OF */
 
-static int __init
-pcibios_init(void)
+static int __init pcibios_init(void)
 {
 	struct pci_controller *hose, *tmp;
 	struct pci_bus *bus;
@@ -683,22 +457,8 @@ pcibios_init(void)
 	if (pci_assign_all_buses && have_of)
 		pcibios_make_OF_bus_map();
 
-	/* Call machine dependent fixup */
-	if (ppc_md.pcibios_fixup)
-		ppc_md.pcibios_fixup();
-
-	/* Allocate and assign resources. If we re-assign everything, then
-	 * we skip the allocate phase
-	 */
-	pcibios_allocate_bus_resources(&pci_root_buses);
-	if (!(ppc_pci_flags & PPC_PCI_REASSIGN_ALL_RSRC)) {
-		pcibios_allocate_resources(0);
-		pcibios_allocate_resources(1);
-	}
-	if (!(ppc_pci_flags & PPC_PCI_PROBE_ONLY)) {
-		DBG("PCI: Assigning unassigned resouces...\n");
-		pci_assign_unassigned_resources();
-	}
+	/* Call common code to handle resource allocation */
+	pcibios_resource_survey();
 
 	/* Call machine dependent post-init code */
 	if (ppc_md.pcibios_after_init)
Index: linux-merge/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/pci_64.c	2007-12-14 15:49:31.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_64.c	2007-12-14 15:49:32.000000000 +1100
@@ -75,85 +75,6 @@ static void fixup_broken_pcnet32(struct 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TRIDENT, PCI_ANY_ID, fixup_broken_pcnet32);
 
 
-/*
- * We need to avoid collisions with `mirrored' VGA ports
- * and other strange ISA hardware, so we always want the
- * addresses to be allocated in the 0x000-0x0ff region
- * modulo 0x400.
- *
- * Why? Because some silly external IO cards only decode
- * the low 10 bits of the IO address. The 0x00-0xff region
- * is reserved for motherboard devices that decode all 16
- * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
- * but we want to try to avoid allocating at 0x2900-0x2bff
- * which might have be mirrored at 0x0100-0x03ff..
- */
-void pcibios_align_resource(void *data, struct resource *res,
-			    resource_size_t size, resource_size_t align)
-{
-	struct pci_dev *dev = data;
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	resource_size_t start = res->start;
-	unsigned long alignto;
-
-	if (res->flags & IORESOURCE_IO) {
-	        unsigned long offset = (unsigned long)hose->io_base_virt -
-					_IO_BASE;
-		/* Make sure we start at our min on all hoses */
-		if (start - offset < PCIBIOS_MIN_IO)
-			start = PCIBIOS_MIN_IO + offset;
-
-		/*
-		 * Put everything into 0x00-0xff region modulo 0x400
-		 */
-		if (start & 0x300)
-			start = (start + 0x3ff) & ~0x3ff;
-
-	} else if (res->flags & IORESOURCE_MEM) {
-		/* Make sure we start at our min on all hoses */
-		if (start - hose->pci_mem_offset < PCIBIOS_MIN_MEM)
-			start = PCIBIOS_MIN_MEM + hose->pci_mem_offset;
-
-		/* Align to multiple of size of minimum base.  */
-		alignto = max(0x1000UL, align);
-		start = ALIGN(start, alignto);
-	}
-
-	res->start = start;
-}
-
-void __devinit pcibios_claim_one_bus(struct pci_bus *b)
-{
-	struct pci_dev *dev;
-	struct pci_bus *child_bus;
-
-	list_for_each_entry(dev, &b->devices, bus_list) {
-		int i;
-
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
-
-			if (r->parent || !r->start || !r->flags)
-				continue;
-			pci_claim_resource(dev, i);
-		}
-	}
-
-	list_for_each_entry(child_bus, &b->children, node)
-		pcibios_claim_one_bus(child_bus);
-}
-#ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL_GPL(pcibios_claim_one_bus);
-#endif
-
-static void __init pcibios_claim_of_setup(void)
-{
-	struct pci_bus *b;
-
-	list_for_each_entry(b, &pci_root_buses, node)
-		pcibios_claim_one_bus(b);
-}
-
 static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
 {
 	const u32 *prop;
@@ -424,6 +345,7 @@ void __devinit scan_phb(struct pci_contr
 
 	DBG("Scanning PHB %s\n", node ? node->full_name : "<NO NAME>");
 
+	/* Create an empty bus for the toplevel */
 	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, node);
 	if (bus == NULL) {
 		printk(KERN_ERR "Failed to create bus for PCI domain %04x\n",
@@ -433,26 +355,16 @@ void __devinit scan_phb(struct pci_contr
 	bus->secondary = hose->first_busno;
 	hose->bus = bus;
 
+	/* Get some IO space for the new PHB */
 	pcibios_map_io_space(bus);
 
+	/* Wire up PHB bus resources */
 	bus->resource[0] = res = &hose->io_resource;
-	if (res->flags && request_resource(&ioport_resource, res)) {
-		printk(KERN_ERR "Failed to request PCI IO region "
-		       "on PCI domain %04x\n", hose->global_number);
-		DBG("res->start = 0x%016lx, res->end = 0x%016lx\n",
-		    res->start, res->end);
-	}
-
-	for (i = 0; i < 3; ++i) {
-		res = &hose->mem_resources[i];
-		bus->resource[i+1] = res;
-		if (res->flags && request_resource(&iomem_resource, res))
-			printk(KERN_ERR "Failed to request PCI memory region "
-			       "on PCI domain %04x\n", hose->global_number);
-	}
+	for (i = 0; i < 3; ++i)
+		bus->resource[i+1] = &hose->mem_resources[i];
 
+	/* Get probe mode and perform scan */
 	mode = PCI_PROBE_NORMAL;
-
 	if (node && ppc_md.pci_probe_mode)
 		mode = ppc_md.pci_probe_mode(bus);
 	DBG("    probe mode: %d\n", mode);
@@ -469,12 +381,15 @@ static int __init pcibios_init(void)
 {
 	struct pci_controller *hose, *tmp;
 
+	printk(KERN_INFO "PCI: Probing PCI hardware\n");
+
 	/* For now, override phys_mem_access_prot. If we need it,
 	 * later, we may move that initialization to each ppc_md
 	 */
 	ppc_md.phys_mem_access_prot = pci_phys_mem_access_prot;
 
-	printk(KERN_DEBUG "PCI: Probing PCI hardware\n");
+	if (pci_probe_only)
+		ppc_pci_flags |= PPC_PCI_PROBE_ONLY;
 
 	/* Scan all of the recorded PCI controllers.  */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
@@ -482,17 +397,8 @@ static int __init pcibios_init(void)
 		pci_bus_add_devices(hose->bus);
 	}
 
-	if (pci_probe_only)
-		pcibios_claim_of_setup();
-	else
-		/* FIXME: `else' will be removed when
-		   pci_assign_unassigned_resources() is able to work
-		   correctly with [partially] allocated PCI tree. */
-		pci_assign_unassigned_resources();
-
-	/* Call machine dependent final fixup */
-	if (ppc_md.pcibios_fixup)
-		ppc_md.pcibios_fixup();
+	/* Call common code to handle resource allocation */
+	pcibios_resource_survey();
 
 	printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
 
Index: linux-merge/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/powermac/pci.c	2007-12-14 15:49:29.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/powermac/pci.c	2007-12-14 15:49:32.000000000 +1100
@@ -994,9 +994,8 @@ void __init pmac_pci_init(void)
 	struct device_node *np, *root;
 	struct device_node *ht = NULL;
 
-#ifdef CONFIG_PPC32
 	ppc_pci_flags = PPC_PCI_CAN_SKIP_ISA_ALIGN;
-#endif
+
 	root = of_find_node_by_path("/");
 	if (root == NULL) {
 		printk(KERN_CRIT "pmac_pci_init: can't find root "
Index: linux-merge/include/asm-powerpc/pci.h
===================================================================
--- linux-merge.orig/include/asm-powerpc/pci.h	2007-12-14 15:49:31.000000000 +1100
+++ linux-merge/include/asm-powerpc/pci.h	2007-12-14 15:49:32.000000000 +1100
@@ -36,14 +36,10 @@ struct pci_dev;
 
 /*
  * Set this to 1 if you want the kernel to re-assign all PCI
- * bus numbers
+ * bus numbers (don't do that on ppc64 yet !)
  */
-#ifdef CONFIG_PPC64
-#define pcibios_assign_all_busses()	0
-#else
 #define pcibios_assign_all_busses()    	(ppc_pci_flags & \
 					 PPC_PCI_REASSIGN_ALL_BUS)
-#endif
 #define pcibios_scan_all_fns(a, b)	0
 
 static inline void pcibios_set_master(struct pci_dev *dev)
@@ -200,6 +196,8 @@ extern void pcibios_setup_new_device(str
 
 extern void pcibios_claim_one_bus(struct pci_bus *b);
 
+extern void pcibios_resource_survey(void);
+
 extern struct pci_controller *init_phb_dynamic(struct device_node *dn);
 
 extern struct pci_dev *of_create_pci_dev(struct device_node *node,
