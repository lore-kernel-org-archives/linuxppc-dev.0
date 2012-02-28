Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 09F7EB7004
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:33 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 05:59:18 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S64PHo929996
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:25 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S64Oli019089
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:25 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/21] Cleanup on comments of EEH aux components
Date: Tue, 28 Feb 2012 14:04:02 +0800
Message-Id: <1330409051-8941-13-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There're several EEH aux components and the patch does some cleanup
for them so that they look more clean.

        * Duplicated comments have been removed from the header file.
        * Comments have been reorganized so that it looks more clean.
        * The leading comments of functions are adjusted for a little
          bit so that the result of "make pdfdocs" would be more
          unified.
        * Function calls "xxx ()" has been replaced by "xxx()".

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh_event.h        |   34 ++-----
 arch/powerpc/platforms/pseries/eeh_cache.c  |    9 +-
 arch/powerpc/platforms/pseries/eeh_driver.c |  136 ++++++++++++++++-----------
 arch/powerpc/platforms/pseries/eeh_event.c  |   23 ++---
 arch/powerpc/platforms/pseries/eeh_sysfs.c  |    2 +-
 5 files changed, 107 insertions(+), 97 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
index cc3cb04..25ebf6a 100644
--- a/arch/powerpc/include/asm/eeh_event.h
+++ b/arch/powerpc/include/asm/eeh_event.h
@@ -1,6 +1,4 @@
 /*
- *	eeh_event.h
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -22,32 +20,20 @@
 #define ASM_POWERPC_EEH_EVENT_H
 #ifdef __KERNEL__
 
-/** EEH event -- structure holding pci controller data that describes
- *  a change in the isolation status of a PCI slot.  A pointer
- *  to this struct is passed as the data pointer in a notify callback.
+/*
+ * structure holding pci controller data that describes a
+ * change in the isolation status of a PCI slot.  A pointer
+ * to this struct is passed as the data pointer in a notify
+ * callback.
  */
 struct eeh_event {
-	struct list_head     list;
-	struct device_node 	*dn;   /* struct device node */
-	struct pci_dev       *dev;  /* affected device */
+	struct list_head	list;	/* to form event queue	*/
+	struct device_node	*dn;	/* struct device node	*/
+	struct pci_dev		*dev;	/* affected device	*/
 };
 
-/**
- * eeh_send_failure_event - generate a PCI error event
- * @dev pci device
- *
- * This routine builds a PCI error event which will be delivered
- * to all listeners on the eeh_notifier_chain.
- *
- * This routine can be called within an interrupt context;
- * the actual event will be delivered in a normal context
- * (from a workqueue).
- */
-int eeh_send_failure_event (struct device_node *dn,
-                            struct pci_dev *dev);
-
-/* Main recovery function */
-struct pci_dn * handle_eeh_events (struct eeh_event *);
+int eeh_send_failure_event(struct device_node *dn, struct pci_dev *dev);
+struct pci_dn *handle_eeh_events(struct eeh_event *);
 
 #endif /* __KERNEL__ */
 #endif /* ASM_POWERPC_EEH_EVENT_H */
diff --git a/arch/powerpc/platforms/pseries/eeh_cache.c b/arch/powerpc/platforms/pseries/eeh_cache.c
index fc5ae76..850c00c 100644
--- a/arch/powerpc/platforms/pseries/eeh_cache.c
+++ b/arch/powerpc/platforms/pseries/eeh_cache.c
@@ -1,5 +1,4 @@
 /*
- * eeh_cache.c
  * PCI address cache; allows the lookup of PCI devices based on I/O address
  *
  * Copyright IBM Corporation 2004
@@ -47,8 +46,7 @@
  * than any hash algo I could think of for this problem, even
  * with the penalty of slow pointer chases for d-cache misses).
  */
-struct pci_io_addr_range
-{
+struct pci_io_addr_range {
 	struct rb_node rb_node;
 	unsigned long addr_lo;
 	unsigned long addr_hi;
@@ -56,8 +54,7 @@ struct pci_io_addr_range
 	unsigned int flags;
 };
 
-static struct pci_io_addr_cache
-{
+static struct pci_io_addr_cache {
 	struct rb_root rb_root;
 	spinlock_t piar_lock;
 } pci_io_addr_cache_root;
@@ -166,7 +163,7 @@ pci_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
 
 #ifdef DEBUG
 	printk(KERN_DEBUG "PIAR: insert range=[%lx:%lx] dev=%s\n",
-	                  alo, ahi, pci_name (dev));
+	                  alo, ahi, pci_name(dev));
 #endif
 
 	rb_link_node(&piar->rb_node, parent, p);
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 61450e1..3f25fab 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -33,8 +33,14 @@
 #include <asm/prom.h>
 #include <asm/rtas.h>
 
-
-static inline const char * pcid_name (struct pci_dev *pdev)
+/**
+ * eeh_pcid_name - Retrieve name of PCI device driver
+ * @pdev: PCI device
+ *
+ * This routine is used to retrieve the name of PCI device driver
+ * if that's valid.
+ */
+static inline const char *pcid_name(struct pci_dev *pdev)
 {
 	if (pdev && pdev->dev.driver)
 		return pdev->dev.driver->name;
@@ -64,7 +70,14 @@ static void print_device_node_tree(struct pci_dn *pdn, int dent)
 #endif
 
 /**
- * eeh_disable_irq - disable interrupt for the recovering device
+ * eeh_disable_irq - Disable interrupt for the recovering device
+ * @dev: PCI device
+ *
+ * This routine must be called when reporting temporary or permanent
+ * error to the particular PCI device to disable interrupt of that
+ * device. If the device has enabled MSI or MSI-X interrupt, we needn't
+ * do real work because EEH should freeze DMA transfers for those PCI
+ * devices encountering EEH errors, which includes MSI or MSI-X.
  */
 static void eeh_disable_irq(struct pci_dev *dev)
 {
@@ -73,7 +86,7 @@ static void eeh_disable_irq(struct pci_dev *dev)
 	/* Don't disable MSI and MSI-X interrupts. They are
 	 * effectively disabled by the DMA Stopped state
 	 * when an EEH error occurs.
-	*/
+	 */
 	if (dev->msi_enabled || dev->msix_enabled)
 		return;
 
@@ -85,7 +98,11 @@ static void eeh_disable_irq(struct pci_dev *dev)
 }
 
 /**
- * eeh_enable_irq - enable interrupt for the recovering device
+ * eeh_enable_irq - Enable interrupt for the recovering device
+ * @dev: PCI device
+ *
+ * This routine must be called to enable interrupt while failed
+ * device could be resumed.
  */
 static void eeh_enable_irq(struct pci_dev *dev)
 {
@@ -97,15 +114,15 @@ static void eeh_enable_irq(struct pci_dev *dev)
 	}
 }
 
-/* ------------------------------------------------------- */
 /**
- * eeh_report_error - report pci error to each device driver
+ * eeh_report_error - Report pci error to each device driver
+ * @dev: PCI device
+ * @userdata: return value
  * 
  * Report an EEH error to each device driver, collect up and 
  * merge the device driver responses. Cumulative response 
  * passed back in "userdata".
  */
-
 static int eeh_report_error(struct pci_dev *dev, void *userdata)
 {
 	enum pci_ers_result rc, *res = userdata;
@@ -122,7 +139,7 @@ static int eeh_report_error(struct pci_dev *dev, void *userdata)
 	    !driver->err_handler->error_detected)
 		return 0;
 
-	rc = driver->err_handler->error_detected (dev, pci_channel_io_frozen);
+	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
 
 	/* A driver that needs a reset trumps all others */
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
@@ -132,13 +149,14 @@ static int eeh_report_error(struct pci_dev *dev, void *userdata)
 }
 
 /**
- * eeh_report_mmio_enabled - tell drivers that MMIO has been enabled
+ * eeh_report_mmio_enabled - Tell drivers that MMIO has been enabled
+ * @dev: PCI device
+ * @userdata: return value
  *
  * Tells each device driver that IO ports, MMIO and config space I/O
  * are now enabled. Collects up and merges the device driver responses.
  * Cumulative response passed back in "userdata".
  */
-
 static int eeh_report_mmio_enabled(struct pci_dev *dev, void *userdata)
 {
 	enum pci_ers_result rc, *res = userdata;
@@ -149,7 +167,7 @@ static int eeh_report_mmio_enabled(struct pci_dev *dev, void *userdata)
 	    !driver->err_handler->mmio_enabled)
 		return 0;
 
-	rc = driver->err_handler->mmio_enabled (dev);
+	rc = driver->err_handler->mmio_enabled(dev);
 
 	/* A driver that needs a reset trumps all others */
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
@@ -159,9 +177,15 @@ static int eeh_report_mmio_enabled(struct pci_dev *dev, void *userdata)
 }
 
 /**
- * eeh_report_reset - tell device that slot has been reset
+ * eeh_report_reset - Tell device that slot has been reset
+ * @dev: PCI device
+ * @userdata: return value
+ *
+ * This routine must be called while EEH tries to reset particular
+ * PCI device so that the associated PCI device driver could take
+ * some actions, usually to save data the driver needs so that the
+ * driver can work again while the device is recovered.
  */
-
 static int eeh_report_reset(struct pci_dev *dev, void *userdata)
 {
 	enum pci_ers_result rc, *res = userdata;
@@ -188,9 +212,14 @@ static int eeh_report_reset(struct pci_dev *dev, void *userdata)
 }
 
 /**
- * eeh_report_resume - tell device to resume normal operations
+ * eeh_report_resume - Tell device to resume normal operations
+ * @dev: PCI device
+ * @userdata: return value
+ *
+ * This routine must be called to notify the device driver that it
+ * could resume so that the device driver can do some initialization
+ * to make the recovered device work again.
  */
-
 static int eeh_report_resume(struct pci_dev *dev, void *userdata)
 {
 	struct pci_driver *driver = dev->driver;
@@ -212,12 +241,13 @@ static int eeh_report_resume(struct pci_dev *dev, void *userdata)
 }
 
 /**
- * eeh_report_failure - tell device driver that device is dead.
+ * eeh_report_failure - Tell device driver that device is dead.
+ * @dev: PCI device
+ * @userdata: return value
  *
  * This informs the device driver that the device is permanently
  * dead, and that no further recovery attempts will be made on it.
  */
-
 static int eeh_report_failure(struct pci_dev *dev, void *userdata)
 {
 	struct pci_driver *driver = dev->driver;
@@ -238,37 +268,16 @@ static int eeh_report_failure(struct pci_dev *dev, void *userdata)
 	return 0;
 }
 
-/* ------------------------------------------------------- */
 /**
- * handle_eeh_events -- reset a PCI device after hard lockup.
- *
- * pSeries systems will isolate a PCI slot if the PCI-Host
- * bridge detects address or data parity errors, DMA's
- * occurring to wild addresses (which usually happen due to
- * bugs in device drivers or in PCI adapter firmware).
- * Slot isolations also occur if #SERR, #PERR or other misc
- * PCI-related errors are detected.
+ * eeh_reset_device - Perform actual reset of a pci slot
+ * @pe_dn: PE associated device node
+ * @bus: PCI bus corresponding to the isolcated slot
  *
- * Recovery process consists of unplugging the device driver
- * (which generated hotplug events to userspace), then issuing
- * a PCI #RST to the device, then reconfiguring the PCI config
- * space for all bridges & devices under this slot, and then
- * finally restarting the device drivers (which cause a second
- * set of hotplug events to go out to userspace).
+ * This routine must be called to do reset on the indicated PE.
+ * During the reset, udev might be invoked because those affected
+ * PCI devices will be removed and then added.
  */
-
-/**
- * eeh_reset_device() -- perform actual reset of a pci slot
- * @bus: pointer to the pci bus structure corresponding
- *            to the isolated slot. A non-null value will
- *            cause all devices under the bus to be removed
- *            and then re-added.
- * @pe_dn: pointer to a "Partionable Endpoint" device node.
- *            This is the top-level structure on which pci
- *            bus resets can be performed.
- */
-
-static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
+static int eeh_reset_device(struct pci_dn *pe_dn, struct pci_bus *bus)
 {
 	struct device_node *dn;
 	int cnt, rc;
@@ -281,12 +290,13 @@ static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
 
 	/* Reset the pci controller. (Asserts RST#; resets config space).
 	 * Reconfigure bridges and devices. Don't try to bring the system
-	 * up if the reset failed for some reason. */
+	 * up if the reset failed for some reason.
+	 */
 	rc = eeh_reset_pe(pe_dn);
 	if (rc)
 		return rc;
 
-	/* Walk over all functions on this device.  */
+	/* Walk over all functions on this device. */
 	dn = pe_dn->node;
 	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
 		dn = dn->parent->child;
@@ -308,7 +318,7 @@ static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
 	 * potentially weird things happen.
 	 */
 	if (bus) {
-		ssleep (5);
+		ssleep(5);
 		pcibios_add_pci_devices(bus);
 	}
 	pe_dn->eeh_freeze_count = cnt;
@@ -321,7 +331,24 @@ static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
  */
 #define MAX_WAIT_FOR_RECOVERY 150
 
-struct pci_dn * handle_eeh_events (struct eeh_event *event)
+/**
+ * eeh_handle_event - Reset a PCI device after hard lockup.
+ * @event: EEH event
+ *
+ * While PHB detects address or data parity errors on particular PCI
+ * slot, the associated PE will be frozen. Besides, DMA's occurring
+ * to wild addresses (which usually happen due to bugs in device
+ * drivers or in PCI adapter firmware) can cause EEH error. #SERR,
+ * #PERR or other misc PCI-related errors also can trigger EEH errors.
+ *
+ * Recovery process consists of unplugging the device driver (which
+ * generated hotplug events to userspace), then issuing a PCI #RST to
+ * the device, then reconfiguring the PCI config space for all bridges
+ * & devices under this slot, and then finally restarting the device
+ * drivers (which cause a second set of hotplug events to go out to
+ * userspace).
+ */
+struct pci_dn *handle_eeh_events(struct eeh_event *event)
 {
 	struct device_node *frozen_dn;
 	struct pci_dn *frozen_pdn;
@@ -350,9 +377,10 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 	 * which was always an EADS pci bridge.  In the new style,
 	 * there might not be any EADS bridges, and even when there are,
 	 * the firmware marks them as "EEH incapable". So another
-	 * two-step is needed to find the pci bus.. */
+	 * two-step is needed to find the pci bus..
+	 */
 	if (!frozen_bus)
-		frozen_bus = pcibios_find_pci_bus (frozen_dn->parent);
+		frozen_bus = pcibios_find_pci_bus(frozen_dn->parent);
 
 	if (!frozen_bus) {
 		printk(KERN_ERR "EEH: Cannot find PCI bus "
@@ -395,7 +423,8 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 	pci_walk_bus(frozen_bus, eeh_report_error, &result);
 
 	/* Get the current PCI slot state. This can take a long time,
-	 * sometimes over 3 seconds for certain systems. */
+	 * sometimes over 3 seconds for certain systems.
+	 */
 	rc = eeh_ops->wait_state(frozen_pdn->node, MAX_WAIT_FOR_RECOVERY*1000);
 	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
 		printk(KERN_WARNING "EEH: Permanent failure\n");
@@ -508,4 +537,3 @@ perm_error:
 	return NULL;
 }
 
-/* ---------- end of file ---------- */
diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
index d2383cf..e98347c 100644
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ b/arch/powerpc/platforms/pseries/eeh_event.c
@@ -1,6 +1,4 @@
 /*
- * eeh_event.c
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -46,7 +44,7 @@ DECLARE_WORK(eeh_event_wq, eeh_thread_launcher);
 DEFINE_MUTEX(eeh_event_mutex);
 
 /**
- * eeh_event_handler - dispatch EEH events.
+ * eeh_event_handler - Dispatch EEH events.
  * @dummy - unused
  *
  * The detection of a frozen slot can occur inside an interrupt,
@@ -61,7 +59,7 @@ static int eeh_event_handler(void * dummy)
 	struct eeh_event	*event;
 	struct pci_dn *pdn;
 
-	daemonize ("eehd");
+	daemonize("eehd");
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	spin_lock_irqsave(&eeh_eventlist_lock, flags);
@@ -93,7 +91,7 @@ static int eeh_event_handler(void * dummy)
 
 	/* If there are no new errors after an hour, clear the counter. */
 	if (pdn && pdn->eeh_freeze_count>0) {
-		msleep_interruptible (3600*1000);
+		msleep_interruptible(3600*1000);
 		if (pdn->eeh_freeze_count>0)
 			pdn->eeh_freeze_count--;
 	}
@@ -102,8 +100,11 @@ static int eeh_event_handler(void * dummy)
 }
 
 /**
- * eeh_thread_launcher
+ * eeh_thread_launcher - Start kernel thread to handle EEH events
  * @dummy - unused
+ *
+ * This routine is called to start the kernel thread for processing
+ * EEH event.
  */
 static void eeh_thread_launcher(struct work_struct *dummy)
 {
@@ -112,14 +113,14 @@ static void eeh_thread_launcher(struct work_struct *dummy)
 }
 
 /**
- * eeh_send_failure_event - generate a PCI error event
- * @dev pci device
+ * eeh_send_failure_event - Generate a PCI error event
+ * @dev: pci device
  *
  * This routine can be called within an interrupt context;
  * the actual event will be delivered in a normal context
  * (from a workqueue).
  */
-int eeh_send_failure_event (struct device_node *dn,
+int eeh_send_failure_event(struct device_node *dn,
                             struct pci_dev *dev)
 {
 	unsigned long flags;
@@ -135,7 +136,7 @@ int eeh_send_failure_event (struct device_node *dn,
 	}
 	event = kmalloc(sizeof(*event), GFP_ATOMIC);
 	if (event == NULL) {
-		printk (KERN_ERR "EEH: out of memory, event not handled\n");
+		printk(KERN_ERR "EEH: out of memory, event not handled\n");
 		return 1;
  	}
 
@@ -154,5 +155,3 @@ int eeh_send_failure_event (struct device_node *dn,
 
 	return 0;
 }
-
-/********************** END OF FILE ******************************/
diff --git a/arch/powerpc/platforms/pseries/eeh_sysfs.c b/arch/powerpc/platforms/pseries/eeh_sysfs.c
index eb744ee..5e4eab1 100644
--- a/arch/powerpc/platforms/pseries/eeh_sysfs.c
+++ b/arch/powerpc/platforms/pseries/eeh_sysfs.c
@@ -28,7 +28,7 @@
 #include <asm/pci-bridge.h>
 
 /**
- * EEH_SHOW_ATTR -- create sysfs entry for eeh statistic
+ * EEH_SHOW_ATTR -- Create sysfs entry for eeh statistic
  * @_name: name of file in sysfs directory
  * @_memb: name of member in struct pci_dn to access
  * @_format: printf format for display
-- 
1.7.5.4
