Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 5C3E9DE8FA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 23:19:50 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc: move hose_list and pci_address_to_pio to
	pci-common
From: Milton Miller <miltonm@bga.com>
Date: Thu, 08 Jan 2009 06:19:46 -0600
Message-ID: <1231417186_141719@mercury.realtime.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

move the definition of hose_list next to its hotplug spinlock.

create pcibios_io_size to encapsulate ifdef in existing pci-common
function pcibios_vaddr_is_ioport

move pci_address_to_pio to pci-common, using new pcibios_io_size, and
protect this GPL exported function against concurrent hotplug removal

Signed-off-by: Milton Miller <miltonm@bga.com>
---
I was looking at uses of hose_list when I ran across this almost common
function.  I haven't looked where the exported function might be used.

Index: work.git/arch/powerpc/kernel/pci-common.c
===================================================================
--- work.git.orig/arch/powerpc/kernel/pci-common.c	2009-01-08 03:23:42.000000000 -0600
+++ work.git/arch/powerpc/kernel/pci-common.c	2009-01-08 03:24:36.000000000 -0600
@@ -40,6 +40,7 @@
 #include <asm/eeh.h>
 
 static DEFINE_SPINLOCK(hose_spinlock);
+LIST_HEAD(hose_list);
 
 /* XXX kill that some day ... */
 static int global_phb_number;		/* Global phb counter */
@@ -115,19 +116,24 @@ void pcibios_free_controller(struct pci_
 		kfree(phb);
 }
 
+static resource_size_t pcibios_io_size(const struct pci_controller *hose)
+{
+#ifdef CONFIG_PPC64
+	return hose->pci_io_size;
+#else
+	return hose->io_resource.end - hose->io_resource.start + 1;
+#endif
+}
+
 int pcibios_vaddr_is_ioport(void __iomem *address)
 {
 	int ret = 0;
 	struct pci_controller *hose;
-	unsigned long size;
+	resource_size_t size;
 
 	spin_lock(&hose_spinlock);
 	list_for_each_entry(hose, &hose_list, list_node) {
-#ifdef CONFIG_PPC64
-		size = hose->pci_io_size;
-#else
-		size = hose->io_resource.end - hose->io_resource.start + 1;
-#endif
+		size = pcibios_io_size(hose);
 		if (address >= hose->io_base_virt &&
 		    address < (hose->io_base_virt + size)) {
 			ret = 1;
@@ -138,6 +144,29 @@ int pcibios_vaddr_is_ioport(void __iomem
 	return ret;
 }
 
+unsigned long pci_address_to_pio(phys_addr_t address)
+{
+	struct pci_controller *hose;
+	resource_size_t size;
+	unsigned long ret = ~0;
+
+	spin_lock(&hose_spinlock);
+	list_for_each_entry(hose, &hose_list, list_node) {
+		size = pcibios_io_size(hose);
+		if (address >= hose->io_base_phys &&
+		    address < (hose->io_base_phys + size)) {
+			unsigned long base =
+				(unsigned long)hose->io_base_virt - _IO_BASE;
+			ret = base + (address - hose->io_base_phys);
+			break;
+		}
+	}
+	spin_unlock(&hose_spinlock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_address_to_pio);
+
 /*
  * Return the domain number for this bus.
  */
Index: work.git/arch/powerpc/kernel/pci_32.c
===================================================================
--- work.git.orig/arch/powerpc/kernel/pci_32.c	2009-01-08 03:23:42.000000000 -0600
+++ work.git/arch/powerpc/kernel/pci_32.c	2009-01-08 03:23:46.000000000 -0600
@@ -20,6 +20,7 @@
 #include <asm/prom.h>
 #include <asm/sections.h>
 #include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
 #include <asm/byteorder.h>
 #include <asm/uaccess.h>
 #include <asm/machdep.h>
@@ -43,8 +44,6 @@ static u8* pci_to_OF_bus_map;
  */
 static int pci_assign_all_buses;
 
-LIST_HEAD(hose_list);
-
 static int pci_bus_count;
 
 /* This will remain NULL for now, until isa-bridge.c is made common
@@ -491,24 +490,6 @@ long sys_pciconfig_iobase(long which, un
 	return result;
 }
 
-unsigned long pci_address_to_pio(phys_addr_t address)
-{
-	struct pci_controller *hose, *tmp;
-
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		unsigned int size = hose->io_resource.end -
-			hose->io_resource.start + 1;
-		if (address >= hose->io_base_phys &&
-		    address < (hose->io_base_phys + size)) {
-			unsigned long base =
-				(unsigned long)hose->io_base_virt - _IO_BASE;
-			return base + (address - hose->io_base_phys);
-		}
-	}
-	return (unsigned int)-1;
-}
-EXPORT_SYMBOL(pci_address_to_pio);
-
 /*
  * Null PCI config access functions, for the case when we can't
  * find a hose.
Index: work.git/arch/powerpc/kernel/pci_64.c
===================================================================
--- work.git.orig/arch/powerpc/kernel/pci_64.c	2009-01-08 03:23:42.000000000 -0600
+++ work.git/arch/powerpc/kernel/pci_64.c	2009-01-08 03:23:46.000000000 -0600
@@ -43,8 +43,6 @@ unsigned long pci_probe_only = 1;
 unsigned long pci_io_base = ISA_IO_BASE;
 EXPORT_SYMBOL(pci_io_base);
 
-LIST_HEAD(hose_list);
-
 static void fixup_broken_pcnet32(struct pci_dev* dev)
 {
 	if ((dev->class>>8 == PCI_CLASS_NETWORK_ETHERNET)) {
@@ -524,23 +522,6 @@ int __devinit pcibios_map_io_space(struc
 }
 EXPORT_SYMBOL_GPL(pcibios_map_io_space);
 
-unsigned long pci_address_to_pio(phys_addr_t address)
-{
-	struct pci_controller *hose, *tmp;
-
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		if (address >= hose->io_base_phys &&
-		    address < (hose->io_base_phys + hose->pci_io_size)) {
-			unsigned long base =
-				(unsigned long)hose->io_base_virt - _IO_BASE;
-			return base + (address - hose->io_base_phys);
-		}
-	}
-	return (unsigned int)-1;
-}
-EXPORT_SYMBOL_GPL(pci_address_to_pio);
-
-
 #define IOBASE_BRIDGE_NUMBER	0
 #define IOBASE_MEMORY		1
 #define IOBASE_IO		2
