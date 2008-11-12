Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Nov 2008 14:45:52 +1100
Subject: [RFC/PATCH] powerpc: Reserve legacy regions on PCI
Message-Id: <20081112034717.7C899DDDE3@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's a problem on some embedded platforms when we re-assign
everything on PCI, such as 44x. The generic code tries to avoid
assigning devices to addresses overlapping the low legacy
addresses such as VGA hard decoded areas using constants that
are unfortunately no good for us, as they don't take into account
the address translation we do to access PCI busses.

Thus we end up allocating things like IO BARs to 0, which is
technically legal, but will shadow hard decoded ports for use
by things like VGA cards.

This works around it by attempting to reserve legacy regions
before we try to assign addresses.

NOTE: This may have nasty side effects in cases I haven't tested
yet:

 - We try to use FW mappings (ie. powermac) and the FW has allocated
a conflicting address over those legacy regions. This will typically
happen. I would expect the new code to just fail with an informative
message without harm but I haven't had a chance to test that scenario
yet.

 - A device with fixed BARs overlapping those legacy addresses such
as an IDE controller in legacy mode is in the system. I don't know
for sure yet what will happen there, I have to test :-)

Ideally, we should change PCIBIOS_MIN_IO/MIN_MEM accross the board
to take a bus pointer so they can provide appropriate per-bus translated
values to the generic code but that's a more invasive patch.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |   71 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-11-12 10:12:58.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-11-12 10:14:36.000000000 +1100
@@ -16,7 +16,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -1364,6 +1364,63 @@ static void __init pcibios_allocate_reso
 	}
 }
 
+static void __init pcibios_reserve_legacy_regions(struct pci_bus *bus)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	resource_size_t	offset;
+	struct resource *res, *pres;
+	int i;
+
+	pr_debug("Reserving legacy ranges for domain %04x\n", pci_domain_nr(bus));
+
+	/* Check for IO */
+	if (!(hose->io_resource.flags & IORESOURCE_IO))
+		goto no_io;
+	offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+	BUG_ON(res == NULL);
+	res->name = "Legacy IO";
+	res->flags = IORESOURCE_IO;
+	res->start = offset;
+	res->end = (offset + 0xfff) & 0xfffffffful;
+	pr_debug("Candidate legacy IO: %pR\n", res);
+	if (request_resource(&hose->io_resource, res)) {
+		printk(KERN_DEBUG
+		       "PCI %04x:%02x Cannot reserve Legacy IO %pR\n",
+		       pci_domain_nr(bus), bus->number, res);
+		kfree(res);
+	}
+
+ no_io:
+	/* Check for memory */
+	offset = hose->pci_mem_offset;
+	pr_debug("hose mem offset: %016llx\n", (unsigned long long)offset);
+	for (i = 0; i < 3; i++) {
+		pres = &hose->mem_resources[i];
+		if (!(pres->flags & IORESOURCE_MEM))
+			continue;
+		pr_debug("hose mem res: %pR\n", pres);
+		if ((pres->start - offset) <= 0xa0000 &&
+		    (pres->end - offset) >= 0xbffff)
+			break;
+	}
+	if (i >= 3)
+		return;
+	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+	BUG_ON(res == NULL);
+	res->name = "Legacy VGA memory";
+	res->flags = IORESOURCE_MEM;
+	res->start = 0xa0000 + offset;
+	res->end = 0xbffff + offset;
+	pr_debug("Candidate VGA memory: %pR\n", res);
+	if (request_resource(pres, res)) {
+		printk(KERN_DEBUG
+		       "PCI %04x:%02x Cannot reserve VGA memory %pR\n",
+		       pci_domain_nr(bus), bus->number, res);
+		kfree(res);
+	}
+}
+
 void __init pcibios_resource_survey(void)
 {
 	struct pci_bus *b;
@@ -1379,6 +1436,18 @@ void __init pcibios_resource_survey(void
 		pcibios_allocate_resources(1);
 	}
 
+	/* Before we start assigning unassigned resource, we try to reserve
+	 * the low IO area and the VGA memory area if they intersect the
+	 * bus available resources to avoid allocating things on top of them
+	 */
+	if (!(ppc_pci_flags & PPC_PCI_PROBE_ONLY)) {
+		list_for_each_entry(b, &pci_root_buses, node)
+			pcibios_reserve_legacy_regions(b);
+	}
+
+	/* Now, if the platform didn't decide to blindly trust the firmware,
+	 * we proceed to assigning things that were left unassigned
+	 */
 	if (!(ppc_pci_flags & PPC_PCI_PROBE_ONLY)) {
 		pr_debug("PCI: Assigning unassigned resouces...\n");
 		pci_assign_unassigned_resources();
