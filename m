Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 14 Oct 2008 10:56:31 +1100
Subject: [PATCH] powerpc/pci: Improve detection of unassigned bridge resources
Message-Id: <20081013235707.02261DDF36@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When the powerpc PCI layer is not configured to re-assign everything,
it currently fails to detect that a PCI to PCI bridge has been left
unassigned by the firmware and tries to allocate resource for the
default window values in the bridge (0...X) (with the notable exception
of a hack we have in there that detects some Apple firmware unassigned
bridge resources). 

This results in resource allocation failures, which are generally
fixed up later on but it causes scary warnings in the logs and we
have seen the fixup code fall over in some circumstances (a different
issue to fix as well).

This code improves that by providing a more complete & useful function
to intuit that a bridge was left unassigned by the firmware, and thus
force a full re-allocation by the PCI code without trying to allocate
the existing useless resources first.

The algorithm we use basically considers unassigned a window that
starts at 0 (PCI address) if the corresponding address space enable
bit is not set. In addition, for memory space, it considers such a
resource unassigned also if the host bridge isn't configured to
forward cycles to address 0 (ie, the resource basically overlaps
main memory).

This fixes a range of problems with things like Bare-Metal support
on pSeries machines, or attempt to use partial firmware PCI setup.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |  163 +++++++++++++++++++++++++++------------
 1 file changed, 116 insertions(+), 47 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-10-13 14:34:26.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-10-13 15:32:27.000000000 +1100
@@ -914,11 +914,6 @@ static void __devinit fixup_resource(str
 
 	res->start = (res->start + offset) & mask;
 	res->end = (res->end + offset) & mask;
-
-	pr_debug("PCI:%s            %016llx-%016llx\n",
-		 pci_name(dev),
-		 (unsigned long long)res->start,
-		 (unsigned long long)res->end);
 }
 
 
@@ -964,6 +959,11 @@ static void __devinit pcibios_fixup_reso
 			 (unsigned int)res->flags);
 
 		fixup_resource(res, dev);
+
+		pr_debug("PCI:%s            %016llx-%016llx\n",
+			 pci_name(dev),
+			 (unsigned long long)res->start,
+			 (unsigned long long)res->end);
 	}
 
 	/* Call machine specific resource fixup */
@@ -972,58 +972,127 @@ static void __devinit pcibios_fixup_reso
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resources);
 
-static void __devinit __pcibios_fixup_bus(struct pci_bus *bus)
+/* This function tries to figure out if a bridge resource has been initialized
+ * by the firmware or not. It doesn't have to be absolutely bullet proof, but
+ * things go more smoothly when it gets it right. It should covers cases such
+ * as Apple "closed" bridge resources and bare-metal pSeries unassigned bridges
+ */
+static int __devinit pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
+							   struct resource *res)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pci_dev *dev = bus->self;
+	resource_size_t offset;
+	u16 command;
+	int i;
 
-	pr_debug("PCI: Fixup bus %d (%s)\n", bus->number, dev ? pci_name(dev) : "PHB");
+	/* We don't do anything if PCI_PROBE_ONLY is set */
+	if (ppc_pci_flags & PPC_PCI_PROBE_ONLY)
+		return 0;
+
+	/* Job is a bit different between memory and IO */
+	if (res->flags & IORESOURCE_MEM) {
+		/* If the BAR is non-0 (res != pci_mem_offset) then it's probably been
+		 * initialized by somebody
+		 */
+		if (res->start != hose->pci_mem_offset)
+			return 0;
 
-	/* Fixup PCI<->PCI bridges. Host bridges are handled separately, for
-	 * now differently between 32 and 64 bits.
-	 */
-	if (dev != NULL) {
-		struct resource *res;
-		int i;
+		/* The BAR is 0, let's check if memory decoding is enabled on
+		 * the bridge. If not, we consider it unassigned
+		 */
+		pci_read_config_word(dev, PCI_COMMAND, &command);
+		if ((command & PCI_COMMAND_MEMORY) == 0)
+			return 1;
 
-		for (i = 0; i < PCI_BUS_NUM_RESOURCES; ++i) {
-			if ((res = bus->resource[i]) == NULL)
-				continue;
-			if (!res->flags)
-				continue;
-			if (i >= 3 && bus->self->transparent)
-				continue;
-			/* On PowerMac, Apple leaves bridge windows open over
-			 * an inaccessible region of memory space (0...fffff)
-			 * which is somewhat bogus, but that's what they think
-			 * means disabled...
-			 *
-			 * We clear those to force them to be reallocated later
-			 *
-			 * We detect such regions by the fact that the base is
-			 * equal to the pci_mem_offset of the host bridge and
-			 * their size is smaller than 1M.
-			 */
-			if (res->flags & IORESOURCE_MEM &&
-			    res->start == hose->pci_mem_offset &&
-			    res->end < 0x100000) {
-				printk(KERN_INFO
-				       "PCI: Closing bogus Apple Firmware"
-				       " region %d on bus 0x%02x\n",
-				       i, bus->number);
-				res->flags = 0;
-				continue;
-			}
+		/* Memory decoding is enabled and the BAR is 0. If any of the bridge
+		 * resources covers that starting address (0 then it's good enough for
+		 * us for memory
+		 */
+		for (i = 0; i < 3; i++) {
+			if ((hose->mem_resources[i].flags & IORESOURCE_MEM) &&
+			    hose->mem_resources[i].start == hose->pci_mem_offset)
+				return 0;
+		}
 
-			pr_debug("PCI:%s Bus rsrc %d %016llx-%016llx [%x] fixup...\n",
-				 pci_name(dev), i,
-				 (unsigned long long)res->start,\
-				 (unsigned long long)res->end,
-				 (unsigned int)res->flags);
+		/* Well, it starts at 0 and we know it will collide so we may as
+		 * well consider it as unassigned. That covers the Apple case.
+		 */
+		return 1;
+	} else {
+		/* If the BAR is non-0, then we consider it assigned */
+		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+		if (((res->start - offset) & 0xfffffffful) != 0)
+			return 0;
+
+		/* Here, we are a bit different than memory as typically IO space
+		 * starting at low addresses -is- valid. What we do instead if that
+		 * we consider as unassigned anything that doesn't have IO enabled
+		 * in the PCI command register, and that's it.
+		 */
+		pci_read_config_word(dev, PCI_COMMAND, &command);
+		if (command & PCI_COMMAND_IO)
+			return 0;
 
-			fixup_resource(res, dev);
+		/* It's starting at 0 and IO is disabled in the bridge, consider
+		 * it unassigned
+		 */
+		return 1;
+	}
+}
+
+/* Fixup resources of a PCI<->PCI bridge */
+static void __devinit pcibios_fixup_bridge(struct pci_bus *bus)
+{
+	struct resource *res;
+	int i;
+
+	struct pci_dev *dev = bus->self;
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; ++i) {
+		if ((res = bus->resource[i]) == NULL)
+			continue;
+		if (!res->flags)
+			continue;
+		if (i >= 3 && bus->self->transparent)
+			continue;
+
+		pr_debug("PCI:%s Bus rsrc %d %016llx-%016llx [%x] fixup...\n",
+			 pci_name(dev), i,
+			 (unsigned long long)res->start,\
+			 (unsigned long long)res->end,
+			 (unsigned int)res->flags);
+
+		/* Perform fixup */
+		fixup_resource(res, dev);
+
+		/* Try to detect uninitialized P2P bridge resources,
+		 * and clear them out so they get re-assigned later
+		 */
+		if (pcibios_uninitialized_bridge_resource(bus, res)) {
+			res->flags = 0;
+			pr_debug("PCI:%s            (unassigned)\n", pci_name(dev));
+		} else {
+
+			pr_debug("PCI:%s            %016llx-%016llx\n",
+				 pci_name(dev),
+				 (unsigned long long)res->start,
+				 (unsigned long long)res->end);
 		}
 	}
+}
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
+	if (dev != NULL)
+		pcibios_fixup_bridge(bus);
 
 	/* Additional setup that is different between 32 and 64 bits for now */
 	pcibios_do_bus_setup(bus);
