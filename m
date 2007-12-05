Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 05 Dec 2007 11:53:02 +1100
Subject: [RFC/PATCH 3/6] powerpc: pci32: Remove PowerMac P2P bridge IO hack
In-Reply-To: <1196815980.72143.899704305870.qpush@grosgo>
Message-Id: <20071205005411.CC6B6DE0E2@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 32 bits PowerPC PCI code has a hack for use by some PowerMacs
to try to re-open PCI<->PCI bridge IO resources that were closed
by the firmware. This is no longer necessary as the generic code
will now do that for us.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci_32.c |  215 -------------------------------------------
 1 file changed, 1 insertion(+), 214 deletions(-)

Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2007-12-04 17:02:13.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2007-12-04 17:02:31.000000000 +1100
@@ -711,217 +711,6 @@ void pcibios_make_OF_bus_map(void)
 }
 #endif /* CONFIG_PPC_OF */
 
-#ifdef CONFIG_PPC_PMAC
-/*
- * This set of routines checks for PCI<->PCI bridges that have closed
- * IO resources and have child devices. It tries to re-open an IO
- * window on them.
- *
- * This is a _temporary_ fix to workaround a problem with Apple's OF
- * closing IO windows on P2P bridges when the OF drivers of cards
- * below this bridge don't claim any IO range (typically ATI or
- * Adaptec).
- *
- * A more complete fix would be to use drivers/pci/setup-bus.c, which
- * involves a working pcibios_fixup_pbus_ranges(), some more care about
- * ordering when creating the host bus resources, and maybe a few more
- * minor tweaks
- */
-
-/* Initialize bridges with base/limit values we have collected */
-static void __init
-do_update_p2p_io_resource(struct pci_bus *bus, int enable_vga)
-{
-	struct pci_dev *bridge = bus->self;
-	struct pci_controller* hose = (struct pci_controller *)bridge->sysdata;
-	u32 l;
-	u16 w;
-	struct resource res;
-
-	if (bus->resource[0] == NULL)
-		return;
- 	res = *(bus->resource[0]);
-
-	DBG("Remapping Bus %d, bridge: %s\n", bus->number, pci_name(bridge));
-	res.start -= ((unsigned long) hose->io_base_virt - isa_io_base);
-	res.end -= ((unsigned long) hose->io_base_virt - isa_io_base);
-	DBG("  IO window: %016llx-%016llx\n", res.start, res.end);
-
-	/* Set up the top and bottom of the PCI I/O segment for this bus. */
-	pci_read_config_dword(bridge, PCI_IO_BASE, &l);
-	l &= 0xffff000f;
-	l |= (res.start >> 8) & 0x00f0;
-	l |= res.end & 0xf000;
-	pci_write_config_dword(bridge, PCI_IO_BASE, l);
-
-	if ((l & PCI_IO_RANGE_TYPE_MASK) == PCI_IO_RANGE_TYPE_32) {
-		l = (res.start >> 16) | (res.end & 0xffff0000);
-		pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, l);
-	}
-
-	pci_read_config_word(bridge, PCI_COMMAND, &w);
-	w |= PCI_COMMAND_IO;
-	pci_write_config_word(bridge, PCI_COMMAND, w);
-
-#if 0 /* Enabling this causes XFree 4.2.0 to hang during PCI probe */
-	if (enable_vga) {
-		pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &w);
-		w |= PCI_BRIDGE_CTL_VGA;
-		pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, w);
-	}
-#endif
-}
-
-/* This function is pretty basic and actually quite broken for the
- * general case, it's enough for us right now though. It's supposed
- * to tell us if we need to open an IO range at all or not and what
- * size.
- */
-static int __init
-check_for_io_childs(struct pci_bus *bus, struct resource* res, int *found_vga)
-{
-	struct pci_dev *dev;
-	int	i;
-	int	rc = 0;
-
-#define push_end(res, mask) do {		\
-	BUG_ON((mask+1) & mask);		\
-	res->end = (res->end + mask) | mask;	\
-} while (0)
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		u16 class = dev->class >> 8;
-
-		if (class == PCI_CLASS_DISPLAY_VGA ||
-		    class == PCI_CLASS_NOT_DEFINED_VGA)
-			*found_vga = 1;
-		if (class >> 8 == PCI_BASE_CLASS_BRIDGE && dev->subordinate)
-			rc |= check_for_io_childs(dev->subordinate, res, found_vga);
-		if (class == PCI_CLASS_BRIDGE_CARDBUS)
-			push_end(res, 0xfff);
-
-		for (i=0; i<PCI_NUM_RESOURCES; i++) {
-			struct resource *r;
-			unsigned long r_size;
-
-			if (dev->class >> 8 == PCI_CLASS_BRIDGE_PCI
-			    && i >= PCI_BRIDGE_RESOURCES)
-				continue;
-			r = &dev->resource[i];
-			r_size = r->end - r->start;
-			if (r_size < 0xfff)
-				r_size = 0xfff;
-			if (r->flags & IORESOURCE_IO && (r_size) != 0) {
-				rc = 1;
-				push_end(res, r_size);
-			}
-		}
-	}
-
-	return rc;
-}
-
-/* Here we scan all P2P bridges of a given level that have a closed
- * IO window. Note that the test for the presence of a VGA card should
- * be improved to take into account already configured P2P bridges,
- * currently, we don't see them and might end up configuring 2 bridges
- * with VGA pass through enabled
- */
-static void __init
-do_fixup_p2p_level(struct pci_bus *bus)
-{
-	struct pci_bus *b;
-	int i, parent_io;
-	int has_vga = 0;
-
-	for (parent_io=0; parent_io<4; parent_io++)
-		if (bus->resource[parent_io]
-		    && bus->resource[parent_io]->flags & IORESOURCE_IO)
-			break;
-	if (parent_io >= 4)
-		return;
-
-	list_for_each_entry(b, &bus->children, node) {
-		struct pci_dev *d = b->self;
-		struct pci_controller* hose = (struct pci_controller *)d->sysdata;
-		struct resource *res = b->resource[0];
-		struct resource tmp_res;
-		unsigned long max;
-		int found_vga = 0;
-
-		memset(&tmp_res, 0, sizeof(tmp_res));
-		tmp_res.start = bus->resource[parent_io]->start;
-
-		/* We don't let low addresses go through that closed P2P bridge, well,
-		 * that may not be necessary but I feel safer that way
-		 */
-		if (tmp_res.start == 0)
-			tmp_res.start = 0x1000;
-	
-		if (!list_empty(&b->devices) && res && res->flags == 0 &&
-		    res != bus->resource[parent_io] &&
-		    (d->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
-		    check_for_io_childs(b, &tmp_res, &found_vga)) {
-			u8 io_base_lo;
-
-			printk(KERN_INFO "Fixing up IO bus %s\n", b->name);
-
-			if (found_vga) {
-				if (has_vga) {
-					printk(KERN_WARNING "Skipping VGA, already active"
-					    " on bus segment\n");
-					found_vga = 0;
-				} else
-					has_vga = 1;
-			}
-			pci_read_config_byte(d, PCI_IO_BASE, &io_base_lo);
-
-			if ((io_base_lo & PCI_IO_RANGE_TYPE_MASK) == PCI_IO_RANGE_TYPE_32)
-				max = ((unsigned long) hose->io_base_virt
-					- isa_io_base) + 0xffffffff;
-			else
-				max = ((unsigned long) hose->io_base_virt
-					- isa_io_base) + 0xffff;
-
-			*res = tmp_res;
-			res->flags = IORESOURCE_IO;
-			res->name = b->name;
-		
-			/* Find a resource in the parent where we can allocate */
-			for (i = 0 ; i < 4; i++) {
-				struct resource *r = bus->resource[i];
-				if (!r)
-					continue;
-				if ((r->flags & IORESOURCE_IO) == 0)
-					continue;
-				DBG("Trying to allocate from %016llx, size %016llx from parent"
-				    " res %d: %016llx -> %016llx\n",
-					res->start, res->end, i, r->start, r->end);
-			
-				if (allocate_resource(r, res, res->end + 1, res->start, max,
-				    res->end + 1, NULL, NULL) < 0) {
-					DBG("Failed !\n");
-					continue;
-				}
-				do_update_p2p_io_resource(b, found_vga);
-				break;
-			}
-		}
-		do_fixup_p2p_level(b);
-	}
-}
-
-static void
-pcibios_fixup_p2p_bridges(void)
-{
-	struct pci_bus *b;
-
-	list_for_each_entry(b, &pci_root_buses, node)
-		do_fixup_p2p_level(b);
-}
-
-#endif /* CONFIG_PPC_PMAC */
-
 static int __init
 pcibios_init(void)
 {
@@ -961,9 +750,7 @@ pcibios_init(void)
 	pcibios_allocate_bus_resources(&pci_root_buses);
 	pcibios_allocate_resources(0);
 	pcibios_allocate_resources(1);
-#ifdef CONFIG_PPC_PMAC
-	pcibios_fixup_p2p_bridges();
-#endif /* CONFIG_PPC_PMAC */
+
 	DBG("PCI: Assigning unassigned resouces...\n");
 	pci_assign_unassigned_resources();
 
