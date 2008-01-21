Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 21 Jan 2008 11:32:50 +1100
Subject: [PATCH] [POWERPC] Always hookup PHB IO resource even when empty
Message-Id: <20080121003256.E1EBDDDDF0@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We must always hookup the pci_bus resource 0 to the PHB io_resource even
if the later is empty (the bus has no IO support). Otherwise, some other
code will end up hooking it up to something bogus and the resource tree
will end up being broken.

This fixes boot on QS20 Cell blades where the IDE driver failed to allocate
the IO resources due to breakage of the resource tree.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This is for 2.6.25, fixes a bug in my PCI rework.
 
 arch/powerpc/kernel/pci_64.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- linux-merge.orig/arch/powerpc/kernel/pci_64.c	2008-01-21 11:27:41.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_64.c	2008-01-21 11:28:07.000000000 +1100
@@ -357,7 +357,6 @@ void __devinit scan_phb(struct pci_contr
 	struct pci_bus *bus;
 	struct device_node *node = hose->dn;
 	int i, mode;
-	struct resource *res;
 
 	DBG("PCI: Scanning PHB %s\n", node ? node->full_name : "<NO NAME>");
 
@@ -375,12 +374,10 @@ void __devinit scan_phb(struct pci_contr
 	pcibios_map_io_space(bus);
 
 	/* Wire up PHB bus resources */
-	if (hose->io_resource.flags) {
-		DBG("PCI: PHB IO resource    = %016lx-%016lx [%lx]\n",
-		    hose->io_resource.start, hose->io_resource.end,
-		    hose->io_resource.flags);
-		bus->resource[0] = res = &hose->io_resource;
-	}
+	DBG("PCI: PHB IO resource    = %016lx-%016lx [%lx]\n",
+	    hose->io_resource.start, hose->io_resource.end,
+	    hose->io_resource.flags);
+	bus->resource[0] = &hose->io_resource;
 	for (i = 0; i < 3; ++i) {
 		DBG("PCI: PHB MEM resource %d = %016lx-%016lx [%lx]\n", i,
 		    hose->mem_resources[i].start,
