Return-Path: <gud@eth.net>
Received: from MTVMIME01.enterprise.veritas.com (bay-bridge.veritas.com
	[143.127.3.10]) by ozlabs.org (Postfix) with ESMTP id AFFCC67A72
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Mar 2005 22:27:21 +1000 (EST)
To: greg@kroah.com
From: Amit Gud <gud@eth.net>
Date: Tue, 29 Mar 2005 17:52:44 +0530
Message-ID: <ITPXCHFE1Uo1RZEpFid0000206a@itpxchfe1.enterprise.veritas.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, gud@eth.net
Subject: [PATCH 4/91] get rid of pci_find_{device,subsys} arch/ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Replace pci_find_{device,subsys} with pci_get_{device,subsys}.



Signed-off-by: Amit Gud <gud@eth.net>

---
diff -upr orig-2.6.12-rc1/arch/ppc/kernel/pci.c work-2.6.12-rc1/arch/ppc/kernel/pci.c
--- orig-2.6.12-rc1/arch/ppc/kernel/pci.c	2005-03-22 12:53:17.000000000 +0530
+++ work-2.6.12-rc1/arch/ppc/kernel/pci.c	2005-03-24 15:39:21.107111456 +0530
@@ -503,7 +503,7 @@ pcibios_allocate_resources(int pass)
 	u16 command;
 	struct resource *r;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		pci_read_config_word(dev, PCI_COMMAND, &command);
 		for (idx = 0; idx < 6; idx++) {
 			r = &dev->resource[idx];
@@ -519,7 +519,7 @@ pcibios_allocate_resources(int pass)
 				alloc_resource(dev, idx);
 		}
 		if (pass)
-			continue;
+			goto dev_put;
 		r = &dev->resource[PCI_ROM_RESOURCE];
 		if (r->flags & PCI_ROM_ADDRESS_ENABLE) {
 			/* Turn the ROM off, leave the resource region, but keep it unregistered. */
@@ -530,6 +530,8 @@ pcibios_allocate_resources(int pass)
 			pci_write_config_dword(dev, dev->rom_base_reg,
 					       reg & ~PCI_ROM_ADDRESS_ENABLE);
 		}
+		dev_put:
+		  pci_dev_put(dev);
 	}
 }
 
@@ -540,12 +542,12 @@ pcibios_assign_resources(void)
 	int idx;
 	struct resource *r;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		int class = dev->class >> 8;
 
 		/* Don't touch classless devices and host bridges */
 		if (!class || class == PCI_CLASS_BRIDGE_HOST)
-			continue;
+			goto dev_put;
 
 		for (idx = 0; idx < 6; idx++) {
 			r = &dev->resource[idx];
@@ -571,6 +573,8 @@ pcibios_assign_resources(void)
 		if (r->end)
 			pci_assign_resource(dev, PCI_ROM_RESOURCE);
 #endif
+		dev_put:
+		  pci_dev_put(dev);
 	}
 }
 
@@ -866,13 +870,18 @@ pci_device_from_OF_node(struct device_no
 	 */
 	if (!pci_to_OF_bus_map)
 		return 0;
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		if (pci_to_OF_bus_map[dev->bus->number] != *bus)
-			continue;
+			goto dev_put;
 		if (dev->devfn != *devfn)
-			continue;
+			goto dev_put;
+
 		*bus = dev->bus->number;
+		pci_dev_put(dev);
 		return 0;
+
+		dev_put:
+		  pci_dev_put(dev);
 	}
 	return -ENODEV;
 }
