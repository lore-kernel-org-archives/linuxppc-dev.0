Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e3.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C43C72C0092
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 15:16:34 +1000 (EST)
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 12 Sep 2012 01:16:31 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 306ECC9003E
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 01:16:27 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8C5GQQ134013324
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 01:16:27 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8C5GPVn014687
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 01:16:26 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] ppc/eeh: remove EEH PE for normal PCI hotplug
Date: Wed, 12 Sep 2012 13:16:17 +0800
Message-Id: <1347426978-6194-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1347426978-6194-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1347426978-6194-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function eeh_rmv_from_parent_pe() could be called by the path of
either normal PCI hotplug, or EEH recovery. For the former case,
we need purge the corresponding PE on removal of the associated
PE bus.

The patch tries to cover that by passing more information to function
pcibios_remove_pci_devices() so that we know if the corresponding PE
needs to be purged or be marked as "invalid".

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h              |    6 ++--
 arch/powerpc/include/asm/pci-bridge.h       |    1 +
 arch/powerpc/platforms/pseries/eeh.c        |   12 +++++----
 arch/powerpc/platforms/pseries/eeh_driver.c |    8 +++++-
 arch/powerpc/platforms/pseries/eeh_pe.c     |   35 +++++++++++++++++---------
 arch/powerpc/platforms/pseries/pci_dlpar.c  |   32 ++++++++++++++++++------
 6 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index afeb400..b0ef738 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -185,7 +185,7 @@ static inline void eeh_unlock(void)
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
 int __devinit eeh_phb_pe_create(struct pci_controller *phb);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
-int eeh_rmv_from_parent_pe(struct eeh_dev *edev);
+int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
 		eeh_traverse_func fn, void *flag);
 void eeh_pe_restore_bars(struct eeh_pe *pe);
@@ -201,7 +201,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev);
 void __init eeh_addr_cache_build(void);
 void eeh_add_device_tree_early(struct device_node *);
 void eeh_add_device_tree_late(struct pci_bus *);
-void eeh_remove_bus_device(struct pci_dev *);
+void eeh_remove_bus_device(struct pci_dev *, int);
 
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
@@ -240,7 +240,7 @@ static inline void eeh_add_device_tree_early(struct device_node *dn) { }
 
 static inline void eeh_add_device_tree_late(struct pci_bus *bus) { }
 
-static inline void eeh_remove_bus_device(struct pci_dev *dev) { }
+static inline void eeh_remove_bus_device(struct pci_dev *dev, int purge_pe) { }
 
 static inline void eeh_lock(void) { }
 static inline void eeh_unlock(void) { }
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 973df4d..a059cb9 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -192,6 +192,7 @@ static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
 extern struct pci_bus *pcibios_find_pci_bus(struct device_node *dn);
 
 /** Remove all of the PCI devices under this bus */
+extern void __pcibios_remove_pci_devices(struct pci_bus *bus, int purge_pe);
 extern void pcibios_remove_pci_devices(struct pci_bus *bus);
 
 /** Discover new pci devices under this bus, and add them */
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 18c168b..43f6ed4 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -817,6 +817,7 @@ EXPORT_SYMBOL_GPL(eeh_add_device_tree_late);
 /**
  * eeh_remove_device - Undo EEH setup for the indicated pci device
  * @dev: pci device to be removed
+ * @purge_pe: remove the PE or not
  *
  * This routine should be called when a device is removed from
  * a running system (e.g. by hotplug or dlpar).  It unregisters
@@ -824,7 +825,7 @@ EXPORT_SYMBOL_GPL(eeh_add_device_tree_late);
  * this device will no longer be detected after this call; thus,
  * i/o errors affecting this slot may leave this device unusable.
  */
-static void eeh_remove_device(struct pci_dev *dev)
+static void eeh_remove_device(struct pci_dev *dev, int purge_pe)
 {
 	struct eeh_dev *edev;
 
@@ -843,7 +844,7 @@ static void eeh_remove_device(struct pci_dev *dev)
 	dev->dev.archdata.edev = NULL;
 	pci_dev_put(dev);
 
-	eeh_rmv_from_parent_pe(edev);
+	eeh_rmv_from_parent_pe(edev, purge_pe);
 	eeh_addr_cache_rmv_dev(dev);
 	eeh_sysfs_remove_device(dev);
 }
@@ -851,21 +852,22 @@ static void eeh_remove_device(struct pci_dev *dev)
 /**
  * eeh_remove_bus_device - Undo EEH setup for the indicated PCI device
  * @dev: PCI device
+ * @purge_pe: remove the corresponding PE or not
  *
  * This routine must be called when a device is removed from the
  * running system through hotplug or dlpar. The corresponding
  * PCI address cache will be removed.
  */
-void eeh_remove_bus_device(struct pci_dev *dev)
+void eeh_remove_bus_device(struct pci_dev *dev, int purge_pe)
 {
 	struct pci_bus *bus = dev->subordinate;
 	struct pci_dev *child, *tmp;
 
-	eeh_remove_device(dev);
+	eeh_remove_device(dev, purge_pe);
 
 	if (bus && dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 		list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
-			 eeh_remove_bus_device(child);
+			 eeh_remove_bus_device(child, purge_pe);
 	}
 }
 EXPORT_SYMBOL_GPL(eeh_remove_bus_device);
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 8370ce7..37c2cf7 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -305,8 +305,14 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	/* pcibios will clear the counter; save the value */
 	cnt = pe->freeze_count;
 
+	/*
+	 * We don't remove the corresponding PE instances because
+	 * we need the information afterwords. The attached EEH
+	 * devices are expected to be attached soon when calling
+	 * into pcibios_add_pci_devices().
+	 */
 	if (bus)
-		pcibios_remove_pci_devices(bus);
+		__pcibios_remove_pci_devices(bus, 0);
 
 	/* Reset the pci controller. (Asserts RST#; resets config space).
 	 * Reconfigure bridges and devices. Don't try to bring the system
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 8f95ffd..a2646cf 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -395,13 +395,14 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 /**
  * eeh_rmv_from_parent_pe - Remove one EEH device from the associated PE
  * @edev: EEH device
+ * @purge_pe: remove PE or not
  *
  * The PE hierarchy tree might be changed when doing PCI hotplug.
  * Also, the PCI devices or buses could be removed from the system
  * during EEH recovery. So we have to call the function remove the
  * corresponding PE accordingly if necessary.
  */
-int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
+int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe)
 {
 	struct eeh_pe *pe, *parent, *child;
 	int cnt;
@@ -428,19 +429,29 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 		if (pe->type & EEH_PE_PHB)
 			break;
 
-		if (list_empty(&pe->edevs)) {
-			cnt = 0;
-			list_for_each_entry(child, &pe->child_list, child) {
-				if (!(pe->type & EEH_PE_INVALID)) {
-					cnt++;
-					break;
-				}
+		if (purge_pe) {
+			if (list_empty(&pe->edevs) &&
+			    list_empty(&pe->child_list)) {
+				list_del(&pe->child);
+				kfree(pe);
+			} else {
+				break;
 			}
+		} else {
+			if (list_empty(&pe->edevs)) {
+				cnt = 0;
+				list_for_each_entry(child, &pe->child_list, child) {
+					if (!(pe->type & EEH_PE_INVALID)) {
+						cnt++;
+						break;
+					}
+				}
 
-			if (!cnt)
-				pe->type |= EEH_PE_INVALID;
-			else
-				break;
+				if (!cnt)
+					pe->type |= EEH_PE_INVALID;
+				else
+					break;
+			}
 		}
 
 		pe = parent;
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 3ccebc8..261a577 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -65,27 +65,43 @@ pcibios_find_pci_bus(struct device_node *dn)
 EXPORT_SYMBOL_GPL(pcibios_find_pci_bus);
 
 /**
- * pcibios_remove_pci_devices - remove all devices under this bus
+ * __pcibios_remove_pci_devices - remove all devices under this bus
+ * @bus: the indicated PCI bus
+ * @purge_pe: destroy the PE on removal of PCI devices
  *
  * Remove all of the PCI devices under this bus both from the
  * linux pci device tree, and from the powerpc EEH address cache.
+ * By default, the corresponding PE will be destroied during the
+ * normal PCI hotplug path. For PCI hotplug during EEH recovery,
+ * the corresponding PE won't be destroied and deallocated.
  */
-void pcibios_remove_pci_devices(struct pci_bus *bus)
+void __pcibios_remove_pci_devices(struct pci_bus *bus, int purge_pe)
 {
- 	struct pci_dev *dev, *tmp;
+	struct pci_dev *dev, *tmp;
 	struct pci_bus *child_bus;
 
 	/* First go down child busses */
 	list_for_each_entry(child_bus, &bus->children, node)
-		pcibios_remove_pci_devices(child_bus);
+		__pcibios_remove_pci_devices(child_bus, purge_pe);
 
 	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
-		 pci_domain_nr(bus),  bus->number);
+		pci_domain_nr(bus),  bus->number);
 	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
 		pr_debug("     * Removing %s...\n", pci_name(dev));
-		eeh_remove_bus_device(dev);
- 		pci_stop_and_remove_bus_device(dev);
- 	}
+		eeh_remove_bus_device(dev, purge_pe);
+		pci_stop_and_remove_bus_device(dev);
+	}
+}
+
+/**
+ * pcibios_remove_pci_devices - remove all devices under this bus
+ *
+ * Remove all of the PCI devices under this bus both from the
+ * linux pci device tree, and from the powerpc EEH address cache.
+ */
+void pcibios_remove_pci_devices(struct pci_bus *bus)
+{
+	__pcibios_remove_pci_devices(bus, 1);
 }
 EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
 
-- 
1.7.5.4
