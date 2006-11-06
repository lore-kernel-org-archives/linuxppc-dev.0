Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 06 Nov 2006 18:05:52 +1100
Subject: [PATCH 19/27] powerpc: Add "parent" struct device for PCI host bridges
In-Reply-To: <1162796738.274582.277491064706.qpush@grosgo>
Message-Id: <20061106070708.974EB67D64@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a "parent" struct device to our PCI host bridge data structure so that
PCI can be rooted off another device in sysfs.

Note that arch/ppc doesn't use it, only arch/powerpc, though it's available
for both 32 and 64 bits.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org> 

 arch/powerpc/kernel/pci_32.c     |    5 ++++-
 arch/powerpc/kernel/pci_64.c     |    2 +-
 include/asm-powerpc/pci-bridge.h |    1 +
 include/asm-ppc/pci-bridge.h     |    1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

Index: linux-cell/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_32.c	2006-11-06 15:18:38.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/pci_32.c	2006-11-06 15:19:51.000000000 +1100
@@ -1269,7 +1269,10 @@ pcibios_init(void)
 		if (pci_assign_all_buses)
 			hose->first_busno = next_busno;
 		hose->last_busno = 0xff;
-		bus = pci_scan_bus(hose->first_busno, hose->ops, hose);
+		bus = pci_scan_bus_parented(hose->parent, hose->first_busno,
+					    hose->ops, hose);
+		if (bus)
+			pci_bus_add_devices(bus);
 		hose->last_busno = bus->subordinate;
 		if (pci_assign_all_buses || next_busno <= hose->last_busno)
 			next_busno = hose->last_busno + pcibios_assign_bus_offset;
Index: linux-cell/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_64.c	2006-11-06 15:19:45.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/pci_64.c	2006-11-06 15:19:56.000000000 +1100
@@ -519,7 +519,7 @@ void __devinit scan_phb(struct pci_contr
 
 	DBG("Scanning PHB %s\n", node ? node->full_name : "<NO NAME>");
 
-	bus = pci_create_bus(NULL, hose->first_busno, hose->ops, node);
+	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, node);
 	if (bus == NULL) {
 		printk(KERN_ERR "Failed to create bus for PCI domain %04x\n",
 		       hose->global_number);
Index: linux-cell/include/asm-powerpc/pci-bridge.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/pci-bridge.h	2006-11-06 15:19:38.000000000 +1100
+++ linux-cell/include/asm-powerpc/pci-bridge.h	2006-11-06 15:19:51.000000000 +1100
@@ -25,6 +25,7 @@ struct pci_controller {
 	int node;
 	void *arch_data;
 	struct list_head list_node;
+	struct device *parent;
 
 	int first_busno;
 	int last_busno;
Index: linux-cell/include/asm-ppc/pci-bridge.h
===================================================================
--- linux-cell.orig/include/asm-ppc/pci-bridge.h	2006-11-06 15:18:38.000000000 +1100
+++ linux-cell/include/asm-ppc/pci-bridge.h	2006-11-06 15:19:51.000000000 +1100
@@ -43,6 +43,7 @@ struct pci_controller {
 	struct pci_controller *next;
         struct pci_bus *bus;
 	void *arch_data;
+	struct device *parent;
 
 	int first_busno;
 	int last_busno;
