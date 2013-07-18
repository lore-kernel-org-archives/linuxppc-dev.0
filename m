Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 749E22C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2013 12:14:38 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 17 Jul 2013 22:14:35 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5E1C338C804A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 22:14:31 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6I2EWKU39845944
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 22:14:32 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6I2EVMG012978
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 23:14:32 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/10] powerpc/eeh: Keep PE during hotplug
Date: Thu, 18 Jul 2013 10:14:15 +0800
Message-Id: <1374113660-15347-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1374113660-15347-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1374113660-15347-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we do normal hotplug, the PE shouldn't be kept. However, we
need the PE if the hotplug caused by EEH errors. Since we remove
EEH device through the PCI hook pcibios_stop_dev(), the flag
"purge_pe" passed to various functions is meaningless. So the patch
removes the meaningless flag and introduce new flag "EEH_PE_KEEP"
to save the PE while doing hotplug during EEH error recovery.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h        |   11 +++++------
 arch/powerpc/include/asm/pci-bridge.h |    1 -
 arch/powerpc/kernel/eeh.c             |   28 ++--------------------------
 arch/powerpc/kernel/eeh_driver.c      |    7 +++++--
 arch/powerpc/kernel/eeh_pe.c          |    7 +++----
 arch/powerpc/kernel/pci-hotplug.c     |   26 +++++---------------------
 6 files changed, 20 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index d9d35c2..2ce22d7 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -55,6 +55,8 @@ struct device_node;
 #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
 #define EEH_PE_PHB_DEAD		(1 << 2)	/* Dead PHB		*/
 
+#define EEH_PE_KEEP		(1 << 8)	/* Keep PE on hotplug	*/
+
 struct eeh_pe {
 	int type;			/* PE type: PHB/Bus/Device	*/
 	int state;			/* PE EEH dependent mode	*/
@@ -193,7 +195,7 @@ int eeh_phb_pe_create(struct pci_controller *phb);
 struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
 struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
-int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe);
+int eeh_rmv_from_parent_pe(struct eeh_dev *edev);
 void eeh_pe_update_time_stamp(struct eeh_pe *pe);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
 		eeh_traverse_func fn, void *flag);
@@ -214,8 +216,7 @@ void eeh_add_device_tree_early(struct device_node *);
 void eeh_add_device_late(struct pci_dev *);
 void eeh_add_device_tree_late(struct pci_bus *);
 void eeh_add_sysfs_files(struct pci_bus *);
-void eeh_remove_device(struct pci_dev *, int);
-void eeh_remove_bus_device(struct pci_dev *, int);
+void eeh_remove_device(struct pci_dev *);
 
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
@@ -265,9 +266,7 @@ static inline void eeh_add_device_tree_late(struct pci_bus *bus) { }
 
 static inline void eeh_add_sysfs_files(struct pci_bus *bus) { }
 
-static inline void eeh_remove_device(struct pci_dev *dev, int purge_pe) { }
-
-static inline void eeh_remove_bus_device(struct pci_dev *dev, int purge_pe) { }
+static inline void eeh_remove_device(struct pci_dev *dev) { }
 
 #define EEH_POSSIBLE_ERROR(val, type) (0)
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 2c1d8cb..32d0d20 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -209,7 +209,6 @@ static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
 extern struct pci_bus *pcibios_find_pci_bus(struct device_node *dn);
 
 /** Remove all of the PCI devices under this bus */
-extern void __pcibios_remove_pci_devices(struct pci_bus *bus, int purge_pe);
 extern void pcibios_remove_pci_devices(struct pci_bus *bus);
 
 /** Discover new pci devices under this bus, and add them */
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 582ad1e..ce81477 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -964,7 +964,6 @@ EXPORT_SYMBOL_GPL(eeh_add_sysfs_files);
 /**
  * eeh_remove_device - Undo EEH setup for the indicated pci device
  * @dev: pci device to be removed
- * @purge_pe: remove the PE or not
  *
  * This routine should be called when a device is removed from
  * a running system (e.g. by hotplug or dlpar).  It unregisters
@@ -972,7 +971,7 @@ EXPORT_SYMBOL_GPL(eeh_add_sysfs_files);
  * this device will no longer be detected after this call; thus,
  * i/o errors affecting this slot may leave this device unusable.
  */
-void eeh_remove_device(struct pci_dev *dev, int purge_pe)
+void eeh_remove_device(struct pci_dev *dev)
 {
 	struct eeh_dev *edev;
 
@@ -990,34 +989,11 @@ void eeh_remove_device(struct pci_dev *dev, int purge_pe)
 	edev->pdev = NULL;
 	dev->dev.archdata.edev = NULL;
 
-	eeh_rmv_from_parent_pe(edev, purge_pe);
+	eeh_rmv_from_parent_pe(edev);
 	eeh_addr_cache_rmv_dev(dev);
 	eeh_sysfs_remove_device(dev);
 }
 
-/**
- * eeh_remove_bus_device - Undo EEH setup for the indicated PCI device
- * @dev: PCI device
- * @purge_pe: remove the corresponding PE or not
- *
- * This routine must be called when a device is removed from the
- * running system through hotplug or dlpar. The corresponding
- * PCI address cache will be removed.
- */
-void eeh_remove_bus_device(struct pci_dev *dev, int purge_pe)
-{
-	struct pci_bus *bus = dev->subordinate;
-	struct pci_dev *child, *tmp;
-
-	eeh_remove_device(dev, purge_pe);
-
-	if (bus && dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
-			 eeh_remove_bus_device(child, purge_pe);
-	}
-}
-EXPORT_SYMBOL_GPL(eeh_remove_bus_device);
-
 static int proc_eeh_show(struct seq_file *m, void *v)
 {
 	if (0 == eeh_subsystem_enabled) {
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 2b1ce17..9ef3bbb 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -362,8 +362,10 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	 * devices are expected to be attached soon when calling
 	 * into pcibios_add_pci_devices().
 	 */
-	if (bus)
-		__pcibios_remove_pci_devices(bus, 0);
+	if (bus) {
+		eeh_pe_state_mark(pe, EEH_PE_KEEP);
+		pcibios_remove_pci_devices(bus);
+	}
 
 	/* Reset the pci controller. (Asserts RST#; resets config space).
 	 * Reconfigure bridges and devices. Don't try to bring the system
@@ -386,6 +388,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	if (bus) {
 		ssleep(5);
 		pcibios_add_pci_devices(bus);
+		eeh_pe_state_clear(pe, EEH_PE_KEEP);
 	}
 
 	pe->tstamp = tstamp;
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 016588a..32ef409 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -333,7 +333,7 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 		while (parent) {
 			if (!(parent->type & EEH_PE_INVALID))
 				break;
-			parent->type &= ~EEH_PE_INVALID;
+			parent->type &= ~(EEH_PE_INVALID | EEH_PE_KEEP);
 			parent = parent->parent;
 		}
 		pr_debug("EEH: Add %s to Device PE#%x, Parent PE#%x\n",
@@ -397,14 +397,13 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 /**
  * eeh_rmv_from_parent_pe - Remove one EEH device from the associated PE
  * @edev: EEH device
- * @purge_pe: remove PE or not
  *
  * The PE hierarchy tree might be changed when doing PCI hotplug.
  * Also, the PCI devices or buses could be removed from the system
  * during EEH recovery. So we have to call the function remove the
  * corresponding PE accordingly if necessary.
  */
-int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe)
+int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
 {
 	struct eeh_pe *pe, *parent, *child;
 	int cnt;
@@ -431,7 +430,7 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe)
 		if (pe->type & EEH_PE_PHB)
 			break;
 
-		if (purge_pe) {
+		if (!(pe->state & EEH_PE_KEEP)) {
 			if (list_empty(&pe->edevs) &&
 			    list_empty(&pe->child_list)) {
 				list_del(&pe->child);
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 3dab2f2..fc0831d 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -29,49 +29,33 @@
  */
 void pcibios_release_device(struct pci_dev *dev)
 {
-	eeh_remove_device(dev, 1);
+	eeh_remove_device(dev);
 }
 
 /**
- * __pcibios_remove_pci_devices - remove all devices under this bus
+ * pcibios_remove_pci_devices - remove all devices under this bus
  * @bus: the indicated PCI bus
- * @purge_pe: destroy the PE on removal of PCI devices
  *
  * Remove all of the PCI devices under this bus both from the
  * linux pci device tree, and from the powerpc EEH address cache.
- * By default, the corresponding PE will be destroied during the
- * normal PCI hotplug path. For PCI hotplug during EEH recovery,
- * the corresponding PE won't be destroied and deallocated.
  */
-void __pcibios_remove_pci_devices(struct pci_bus *bus, int purge_pe)
+void pcibios_remove_pci_devices(struct pci_bus *bus)
 {
 	struct pci_dev *dev, *tmp;
 	struct pci_bus *child_bus;
 
 	/* First go down child busses */
 	list_for_each_entry(child_bus, &bus->children, node)
-		__pcibios_remove_pci_devices(child_bus, purge_pe);
+		pcibios_remove_pci_devices(child_bus);
 
 	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
 		 pci_domain_nr(bus),  bus->number);
 	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
-		pr_debug("     * Removing %s...\n", pci_name(dev));
-		eeh_remove_bus_device(dev, purge_pe);
+		pr_debug("   Removing %s...\n", pci_name(dev));
 		pci_stop_and_remove_bus_device(dev);
 	}
 }
 
-/**
- * pcibios_remove_pci_devices - remove all devices under this bus
- * @bus: the indicated PCI bus
- *
- * Remove all of the PCI devices under this bus both from the
- * linux pci device tree, and from the powerpc EEH address cache.
- */
-void pcibios_remove_pci_devices(struct pci_bus *bus)
-{
-	__pcibios_remove_pci_devices(bus, 1);
-}
 EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
 
 /**
-- 
1.7.5.4
