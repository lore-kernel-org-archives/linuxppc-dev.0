Return-Path: <nfont@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2B1F8679E9
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 03:13:25 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2VGDLsU025720
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 11:13:21 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2VGA7ku250616
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 09:10:07 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2VGDKQ6007850
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 09:13:20 -0700
From: Nathan Fontenot <nfont@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pseries: EEH Cleanup
Date: Fri, 31 Mar 2006 10:13:21 -0600
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200603311013.22208.nfont@austin.ibm.com>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes unnecessary exports, marks functions as static when
possible, and simplifies some list-related code.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Index: nfont/kernel/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- nfont.orig/kernel/arch/powerpc/platforms/pseries/eeh.c      2006-03-27 
16:04:52.%N -0600
+++ nfont/kernel/arch/powerpc/platforms/pseries/eeh.c   2006-03-31 09:02:17.%N 
-0600
@@ -865,7 +865,7 @@ void __init eeh_init(void)
  * on the CEC architecture, type of the device, on earlier boot
  * command-line arguments & etc.
  */
-void eeh_add_device_early(struct device_node *dn)
+static void eeh_add_device_early(struct device_node *dn)
 {
        struct pci_controller *phb;
        struct eeh_early_enable_info info;
@@ -882,7 +882,6 @@ void eeh_add_device_early(struct device_
        info.buid_lo = BUID_LO(phb->buid);
        early_enable_eeh(dn, &info);
 }
-EXPORT_SYMBOL_GPL(eeh_add_device_early);

 void eeh_add_device_tree_early(struct device_node *dn)
 {
@@ -914,7 +913,7 @@ void eeh_add_device_tree_late(struct pci
  * This routine must be used to complete EEH initialization for PCI
  * devices that were added after system boot (e.g. hotplug, dlpar).
  */
-void eeh_add_device_late(struct pci_dev *dev)
+static void eeh_add_device_late(struct pci_dev *dev)
 {
        struct device_node *dn;
        struct pci_dn *pdn;
@@ -933,16 +932,18 @@ void eeh_add_device_late(struct pci_dev

        pci_addr_cache_insert_device (dev);
 }
-EXPORT_SYMBOL_GPL(eeh_add_device_late);

 /**
  * eeh_remove_device - undo EEH setup for the indicated pci device
  * @dev: pci device to be removed
  *
- * This routine should be when a device is removed from a running
- * system (e.g. by hotplug or dlpar).
+ * This routine should be called when a device is removed from
+ * a running system (e.g. by hotplug or dlpar).  It unregisters
+ * the PCI device from the EEH subsystem.  I/O errors affecting
+ * this device will no longer be detected after this call; thus,
+ * i/o errors affecting this slot may leave this device unusable.
  */
-void eeh_remove_device(struct pci_dev *dev)
+static void eeh_remove_device(struct pci_dev *dev)
 {
        struct device_node *dn;
        if (!dev || !eeh_subsystem_enabled)
@@ -958,22 +959,18 @@ void eeh_remove_device(struct pci_dev *d
        PCI_DN(dn)->pcidev = NULL;
        pci_dev_put (dev);
 }
-EXPORT_SYMBOL_GPL(eeh_remove_device);

 void eeh_remove_bus_device(struct pci_dev *dev)
 {
+       struct pci_bus *bus = dev->subordinate;
+       struct pci_dev *child, *tmp;
+
        eeh_remove_device(dev);
-       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-               struct pci_bus *bus = dev->subordinate;
-               struct list_head *ln;
-               if (!bus)
-                       return;
-               for (ln = bus->devices.next; ln != &bus->devices; ln = 
ln->next) {
-                       struct pci_dev *pdev = pci_dev_b(ln);
-                       if (pdev)
-                               eeh_remove_bus_device(pdev);
-               }
-       }
+
+       if (bus && dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+               list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
+                       eeh_remove_bus_device(child);
+       }
 }
 EXPORT_SYMBOL_GPL(eeh_remove_bus_device);

Index: nfont/kernel/include/asm-powerpc/eeh.h
===================================================================
--- nfont.orig/kernel/include/asm-powerpc/eeh.h 2006-03-27 16:05:00.%N -0600
+++ nfont/kernel/include/asm-powerpc/eeh.h      2006-03-29 15:26:57.%N -0600
@@ -60,24 +60,10 @@ void __init pci_addr_cache_build(void);
  * device (including config space i/o).  Call eeh_add_device_late
  * to finish the eeh setup for this device.
  */
-void eeh_add_device_early(struct device_node *);
-void eeh_add_device_late(struct pci_dev *dev);
 void eeh_add_device_tree_early(struct device_node *);
 void eeh_add_device_tree_late(struct pci_bus *);

 /**
- * eeh_remove_device - undo EEH setup for the indicated pci device
- * @dev: pci device to be removed
- *
- * This routine should be called when a device is removed from
- * a running system (e.g. by hotplug or dlpar).  It unregisters
- * the PCI device from the EEH subsystem.  I/O errors affecting
- * this device will no longer be detected after this call; thus,
- * i/o errors affecting this slot may leave this device unusable.
- */
-void eeh_remove_device(struct pci_dev *);
-
-/**
  * eeh_remove_device_recursive - undo EEH for device & children.
  * @dev: pci device to be removed
  *
@@ -116,12 +102,6 @@ static inline int eeh_dn_check_failure(s

 static inline void pci_addr_cache_build(void) { }

-static inline void eeh_add_device_early(struct device_node *dn) { }
-
-static inline void eeh_add_device_late(struct pci_dev *dev) { }
-
-static inline void eeh_remove_device(struct pci_dev *dev) { }
-
 static inline void eeh_add_device_tree_early(struct device_node *dn) { }

 static inline void eeh_add_device_tree_late(struct pci_bus *bus) { }
