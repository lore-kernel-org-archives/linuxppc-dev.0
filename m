Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2990567CEE
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 08:26:20 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id kA3LQFjd025424
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 15:26:16 -0600
Subject: [PATCH/RFC] powerpc: PCI busses can have a parent
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 08:26:15 +1100
Message-Id: <1162589176.10630.121.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a parent field to the pci_controller structure so that
a PCI bus can be rooted under a specified parent in sysfs


Add a "parent" struct device to our PCI host bridge data structure so that
PCI can be rooted of another device. (Note that arch/ppc doesn't use it,
only arch/powerpc)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org> 

Index: linux-cell/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_32.c	2006-10-23 14:41:37.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/pci_32.c	2006-10-25 14:33:07.000000000 +1000
@@ -1268,7 +1268,10 @@ pcibios_init(void)
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
--- linux-cell.orig/arch/powerpc/kernel/pci_64.c	2006-10-25 14:32:08.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/pci_64.c	2006-10-25 14:33:07.000000000 +1000
@@ -519,7 +519,7 @@ void __devinit scan_phb(struct pci_contr
 
 	DBG("Scanning PHB %s\n", node ? node->full_name : "<NO NAME>");
 
-	bus = pci_create_bus(NULL, hose->first_busno, hose->ops, node);
+	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, node);
 	if (bus == NULL) {
 		printk(KERN_ERR "Failed to create bus for PCI domain %04x\n",
 		       hose->global_number);
Index: linux-cell/include/asm-powerpc/pci-bridge.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/pci-bridge.h	2006-10-25 14:23:57.000000000 +1000
+++ linux-cell/include/asm-powerpc/pci-bridge.h	2006-10-25 14:33:07.000000000 +1000
@@ -25,6 +25,7 @@ struct pci_controller {
 	int node;
 	void *arch_data;
 	struct list_head list_node;
+	struct device *parent;
 
 	int first_busno;
 	int last_busno;
Index: linux-cell/include/asm-ppc/pci-bridge.h
===================================================================
--- linux-cell.orig/include/asm-ppc/pci-bridge.h	2006-01-14 14:43:33.000000000 +1100
+++ linux-cell/include/asm-ppc/pci-bridge.h	2006-10-25 14:33:07.000000000 +1000
@@ -43,6 +43,7 @@ struct pci_controller {
 	struct pci_controller *next;
         struct pci_bus *bus;
 	void *arch_data;
+	struct device *parent;
 
 	int first_busno;
 	int last_busno;
