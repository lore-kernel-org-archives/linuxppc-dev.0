Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B254BB6FF5
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:05:03 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 11:34:58 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S64TaT4018276
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 11:34:29 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S64SRT005831
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 11:34:28 +0530
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 18/21] Replace pci_dn with eeh_dev for EEH aux components
Date: Tue, 28 Feb 2012 14:04:08 +0800
Message-Id: <1330409051-8941-19-git-send-email-shangw@linux.vnet.ibm.com>
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

The original EEH implementation is heavily depending on struct pci_dn.
We have to put EEH related information to pci_dn. Actually, we could
split struct pci_dn so that the EEH sensitive information to form an
individual struct, then EEH looks more independent.

The patch replaces pci_dn with eeh_dev for EEH aux components like
event and driver. Also, the eeh_event struct has been adjusted for
a little bit since eeh_dev has linked the associated FDT (Flat Device
Tree) node and PCI device. It's not necessary for eeh_event struct to
trace FDT node and PCI device. We can just simply to trace eeh_dev in
eeh_event.

The patch also renames function pcid_name() to eeh_pcid_name(), which
should be missed in the previous patch where the EEH aux components
have been cleaned up.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh_event.h        |    7 +-
 arch/powerpc/platforms/pseries/eeh.c        |    2 +-
 arch/powerpc/platforms/pseries/eeh_driver.c |   81 +++++++++++++--------------
 arch/powerpc/platforms/pseries/eeh_event.c  |   36 ++++++------
 4 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
index 25ebf6a..c68b012 100644
--- a/arch/powerpc/include/asm/eeh_event.h
+++ b/arch/powerpc/include/asm/eeh_event.h
@@ -28,12 +28,11 @@
  */
 struct eeh_event {
 	struct list_head	list;	/* to form event queue	*/
-	struct device_node	*dn;	/* struct device node	*/
-	struct pci_dev		*dev;	/* affected device	*/
+	struct eeh_dev		*edev;	/* EEH device		*/
 };
 
-int eeh_send_failure_event(struct device_node *dn, struct pci_dev *dev);
-struct pci_dn *handle_eeh_events(struct eeh_event *);
+int eeh_send_failure_event(struct eeh_dev *edev);
+struct eeh_dev *handle_eeh_events(struct eeh_event *);
 
 #endif /* __KERNEL__ */
 #endif /* ASM_POWERPC_EEH_EVENT_H */
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index aec10f6..9b1fd0c 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -475,7 +475,7 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	eeh_mark_slot(dn, EEH_MODE_ISOLATED);
 	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
 
-	eeh_send_failure_event(edev->dn, edev->pdev);
+	eeh_send_failure_event(edev);
 
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 3f25fab..baf92cd 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -40,7 +40,7 @@
  * This routine is used to retrieve the name of PCI device driver
  * if that's valid.
  */
-static inline const char *pcid_name(struct pci_dev *pdev)
+static inline const char *eeh_pcid_name(struct pci_dev *pdev)
 {
 	if (pdev && pdev->dev.driver)
 		return pdev->dev.driver->name;
@@ -81,7 +81,7 @@ static void print_device_node_tree(struct pci_dn *pdn, int dent)
  */
 static void eeh_disable_irq(struct pci_dev *dev)
 {
-	struct device_node *dn = pci_device_to_OF_node(dev);
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
 
 	/* Don't disable MSI and MSI-X interrupts. They are
 	 * effectively disabled by the DMA Stopped state
@@ -93,7 +93,7 @@ static void eeh_disable_irq(struct pci_dev *dev)
 	if (!irq_has_action(dev->irq))
 		return;
 
-	PCI_DN(dn)->eeh_mode |= EEH_MODE_IRQ_DISABLED;
+	edev->mode |= EEH_MODE_IRQ_DISABLED;
 	disable_irq_nosync(dev->irq);
 }
 
@@ -106,10 +106,10 @@ static void eeh_disable_irq(struct pci_dev *dev)
  */
 static void eeh_enable_irq(struct pci_dev *dev)
 {
-	struct device_node *dn = pci_device_to_OF_node(dev);
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
 
-	if ((PCI_DN(dn)->eeh_mode) & EEH_MODE_IRQ_DISABLED) {
-		PCI_DN(dn)->eeh_mode &= ~EEH_MODE_IRQ_DISABLED;
+	if ((edev->mode) & EEH_MODE_IRQ_DISABLED) {
+		edev->mode &= ~EEH_MODE_IRQ_DISABLED;
 		enable_irq(dev->irq);
 	}
 }
@@ -270,20 +270,20 @@ static int eeh_report_failure(struct pci_dev *dev, void *userdata)
 
 /**
  * eeh_reset_device - Perform actual reset of a pci slot
- * @pe_dn: PE associated device node
+ * @edev: PE associated EEH device
  * @bus: PCI bus corresponding to the isolcated slot
  *
  * This routine must be called to do reset on the indicated PE.
  * During the reset, udev might be invoked because those affected
  * PCI devices will be removed and then added.
  */
-static int eeh_reset_device(struct pci_dn *pe_dn, struct pci_bus *bus)
+static int eeh_reset_device(struct eeh_dev *edev, struct pci_bus *bus)
 {
 	struct device_node *dn;
 	int cnt, rc;
 
 	/* pcibios will clear the counter; save the value */
-	cnt = pe_dn->eeh_freeze_count;
+	cnt = edev->freeze_count;
 
 	if (bus)
 		pcibios_remove_pci_devices(bus);
@@ -292,21 +292,22 @@ static int eeh_reset_device(struct pci_dn *pe_dn, struct pci_bus *bus)
 	 * Reconfigure bridges and devices. Don't try to bring the system
 	 * up if the reset failed for some reason.
 	 */
-	rc = eeh_reset_pe(pe_dn);
+	rc = eeh_reset_pe(edev);
 	if (rc)
 		return rc;
 
 	/* Walk over all functions on this device. */
-	dn = pe_dn->node;
-	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
+	dn = eeh_dev_to_of_node(edev);
+	if (!pcibios_find_pci_bus(dn) && of_node_to_eeh_dev(dn->parent))
 		dn = dn->parent->child;
 
 	while (dn) {
-		struct pci_dn *ppe = PCI_DN(dn);
+		struct eeh_dev *pedev = of_node_to_eeh_dev(dn);
+
 		/* On Power4, always true because eeh_pe_config_addr=0 */
-		if (pe_dn->eeh_pe_config_addr == ppe->eeh_pe_config_addr) {
+		if (edev->pe_config_addr == pedev->pe_config_addr) {
 			eeh_ops->configure_bridge(dn);
-			eeh_restore_bars(ppe);
+			eeh_restore_bars(pedev);
  		}
 		dn = dn->sibling;
 	}
@@ -321,7 +322,7 @@ static int eeh_reset_device(struct pci_dn *pe_dn, struct pci_bus *bus)
 		ssleep(5);
 		pcibios_add_pci_devices(bus);
 	}
-	pe_dn->eeh_freeze_count = cnt;
+	edev->freeze_count = cnt;
 
 	return 0;
 }
@@ -348,23 +349,22 @@ static int eeh_reset_device(struct pci_dn *pe_dn, struct pci_bus *bus)
  * drivers (which cause a second set of hotplug events to go out to
  * userspace).
  */
-struct pci_dn *handle_eeh_events(struct eeh_event *event)
+struct eeh_dev *handle_eeh_events(struct eeh_event *event)
 {
 	struct device_node *frozen_dn;
-	struct pci_dn *frozen_pdn;
+	struct eeh_dev *frozen_edev;
 	struct pci_bus *frozen_bus;
 	int rc = 0;
 	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
 	const char *location, *pci_str, *drv_str, *bus_pci_str, *bus_drv_str;
 
-	frozen_dn = eeh_find_device_pe(event->dn);
+	frozen_dn = eeh_find_device_pe(eeh_dev_to_of_node(event->edev));
 	if (!frozen_dn) {
-
-		location = of_get_property(event->dn, "ibm,loc-code", NULL);
+		location = of_get_property(eeh_dev_to_of_node(event->edev), "ibm,loc-code", NULL);
 		location = location ? location : "unknown";
 		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint "
 		                "for location=%s pci addr=%s\n",
-		        location, eeh_pci_name(event->dev));
+			location, eeh_pci_name(eeh_dev_to_pci_dev(event->edev)));
 		return NULL;
 	}
 
@@ -389,22 +389,21 @@ struct pci_dn *handle_eeh_events(struct eeh_event *event)
 		return NULL;
 	}
 
-	frozen_pdn = PCI_DN(frozen_dn);
-	frozen_pdn->eeh_freeze_count++;
+	frozen_edev = of_node_to_eeh_dev(frozen_dn);
+	frozen_edev->freeze_count++;
+	pci_str = eeh_pci_name(eeh_dev_to_pci_dev(event->edev));
+	drv_str = eeh_pcid_name(eeh_dev_to_pci_dev(event->edev));
 
-	pci_str = eeh_pci_name(event->dev);
-	drv_str = pcid_name(event->dev);
-	
-	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
+	if (frozen_edev->freeze_count > EEH_MAX_ALLOWED_FREEZES)
 		goto excess_failures;
 
 	printk(KERN_WARNING
 	   "EEH: This PCI device has failed %d times in the last hour:\n",
-		frozen_pdn->eeh_freeze_count);
+		frozen_edev->freeze_count);
 
-	if (frozen_pdn->pcidev) {
-		bus_pci_str = pci_name(frozen_pdn->pcidev);
-		bus_drv_str = pcid_name(frozen_pdn->pcidev);
+	if (frozen_edev->pdev) {
+		bus_pci_str = pci_name(frozen_edev->pdev);
+		bus_drv_str = eeh_pcid_name(frozen_edev->pdev);
 		printk(KERN_WARNING
 			"EEH: Bus location=%s driver=%s pci addr=%s\n",
 			location, bus_drv_str, bus_pci_str);
@@ -425,7 +424,7 @@ struct pci_dn *handle_eeh_events(struct eeh_event *event)
 	/* Get the current PCI slot state. This can take a long time,
 	 * sometimes over 3 seconds for certain systems.
 	 */
-	rc = eeh_ops->wait_state(frozen_pdn->node, MAX_WAIT_FOR_RECOVERY*1000);
+	rc = eeh_ops->wait_state(eeh_dev_to_of_node(frozen_edev), MAX_WAIT_FOR_RECOVERY*1000);
 	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
 		printk(KERN_WARNING "EEH: Permanent failure\n");
 		goto hard_fail;
@@ -435,14 +434,14 @@ struct pci_dn *handle_eeh_events(struct eeh_event *event)
 	 * don't post the error log until after all dev drivers
 	 * have been informed.
 	 */
-	eeh_slot_error_detail(frozen_pdn, EEH_LOG_TEMP);
+	eeh_slot_error_detail(frozen_edev, EEH_LOG_TEMP);
 
 	/* If all device drivers were EEH-unaware, then shut
 	 * down all of the device drivers, and hope they
 	 * go down willingly, without panicing the system.
 	 */
 	if (result == PCI_ERS_RESULT_NONE) {
-		rc = eeh_reset_device(frozen_pdn, frozen_bus);
+		rc = eeh_reset_device(frozen_edev, frozen_bus);
 		if (rc) {
 			printk(KERN_WARNING "EEH: Unable to reset, rc=%d\n", rc);
 			goto hard_fail;
@@ -451,7 +450,7 @@ struct pci_dn *handle_eeh_events(struct eeh_event *event)
 
 	/* If all devices reported they can proceed, then re-enable MMIO */
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
-		rc = eeh_pci_enable(frozen_pdn, EEH_OPT_THAW_MMIO);
+		rc = eeh_pci_enable(frozen_edev, EEH_OPT_THAW_MMIO);
 
 		if (rc < 0)
 			goto hard_fail;
@@ -465,7 +464,7 @@ struct pci_dn *handle_eeh_events(struct eeh_event *event)
 
 	/* If all devices reported they can proceed, then re-enable DMA */
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
-		rc = eeh_pci_enable(frozen_pdn, EEH_OPT_THAW_DMA);
+		rc = eeh_pci_enable(frozen_edev, EEH_OPT_THAW_DMA);
 
 		if (rc < 0)
 			goto hard_fail;
@@ -483,7 +482,7 @@ struct pci_dn *handle_eeh_events(struct eeh_event *event)
 
 	/* If any device called out for a reset, then reset the slot */
 	if (result == PCI_ERS_RESULT_NEED_RESET) {
-		rc = eeh_reset_device(frozen_pdn, NULL);
+		rc = eeh_reset_device(frozen_edev, NULL);
 		if (rc) {
 			printk(KERN_WARNING "EEH: Cannot reset, rc=%d\n", rc);
 			goto hard_fail;
@@ -502,7 +501,7 @@ struct pci_dn *handle_eeh_events(struct eeh_event *event)
 	/* Tell all device drivers that they can resume operations */
 	pci_walk_bus(frozen_bus, eeh_report_resume, NULL);
 
-	return frozen_pdn;
+	return frozen_edev;
 	
 excess_failures:
 	/*
@@ -515,7 +514,7 @@ excess_failures:
 		"has failed %d times in the last hour "
 		"and has been permanently disabled.\n"
 		"Please try reseating this device or replacing it.\n",
-		location, drv_str, pci_str, frozen_pdn->eeh_freeze_count);
+		location, drv_str, pci_str, frozen_edev->freeze_count);
 	goto perm_error;
 
 hard_fail:
@@ -526,7 +525,7 @@ hard_fail:
 		location, drv_str, pci_str);
 
 perm_error:
-	eeh_slot_error_detail(frozen_pdn, EEH_LOG_PERM);
+	eeh_slot_error_detail(frozen_edev, EEH_LOG_PERM);
 
 	/* Notify all devices that they're about to go down. */
 	pci_walk_bus(frozen_bus, eeh_report_failure, NULL);
diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
index e98347c..4a47525 100644
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ b/arch/powerpc/platforms/pseries/eeh_event.c
@@ -56,8 +56,8 @@ DEFINE_MUTEX(eeh_event_mutex);
 static int eeh_event_handler(void * dummy)
 {
 	unsigned long flags;
-	struct eeh_event	*event;
-	struct pci_dn *pdn;
+	struct eeh_event *event;
+	struct eeh_dev *edev;
 
 	daemonize("eehd");
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -77,23 +77,26 @@ static int eeh_event_handler(void * dummy)
 
 	/* Serialize processing of EEH events */
 	mutex_lock(&eeh_event_mutex);
-	eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);
+	edev = event->edev;
+	eeh_mark_slot(eeh_dev_to_of_node(edev), EEH_MODE_RECOVERING);
 
 	printk(KERN_INFO "EEH: Detected PCI bus error on device %s\n",
-	       eeh_pci_name(event->dev));
+	       eeh_pci_name(edev->pdev));
+
+	edev = handle_eeh_events(event);
 
-	pdn = handle_eeh_events(event);
+	eeh_clear_slot(eeh_dev_to_of_node(edev), EEH_MODE_RECOVERING);
+	pci_dev_put(edev->pdev);
 
-	eeh_clear_slot(event->dn, EEH_MODE_RECOVERING);
-	pci_dev_put(event->dev);
 	kfree(event);
 	mutex_unlock(&eeh_event_mutex);
 
 	/* If there are no new errors after an hour, clear the counter. */
-	if (pdn && pdn->eeh_freeze_count>0) {
+	if (edev && edev->freeze_count>0) {
 		msleep_interruptible(3600*1000);
-		if (pdn->eeh_freeze_count>0)
-			pdn->eeh_freeze_count--;
+		if (edev->freeze_count>0)
+			edev->freeze_count--;
+
 	}
 
 	return 0;
@@ -114,17 +117,17 @@ static void eeh_thread_launcher(struct work_struct *dummy)
 
 /**
  * eeh_send_failure_event - Generate a PCI error event
- * @dev: pci device
+ * @edev: EEH device
  *
  * This routine can be called within an interrupt context;
  * the actual event will be delivered in a normal context
  * (from a workqueue).
  */
-int eeh_send_failure_event(struct device_node *dn,
-                            struct pci_dev *dev)
+int eeh_send_failure_event(struct eeh_dev *edev)
 {
 	unsigned long flags;
 	struct eeh_event *event;
+	struct device_node *dn = eeh_dev_to_of_node(edev);
 	const char *location;
 
 	if (!mem_init_done) {
@@ -140,11 +143,10 @@ int eeh_send_failure_event(struct device_node *dn,
 		return 1;
  	}
 
-	if (dev)
-		pci_dev_get(dev);
+	if (edev->pdev)
+		pci_dev_get(edev->pdev);
 
-	event->dn = dn;
-	event->dev = dev;
+	event->edev = edev;
 
 	/* We may or may not be called in an interrupt context */
 	spin_lock_irqsave(&eeh_eventlist_lock, flags);
-- 
1.7.5.4
