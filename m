Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4240DB6EF3
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 03:36:04 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 11:36:01 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 0902EC93B65
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:02:38 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG2cGX192960
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:02:38 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG2AY1024876
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:11 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 18/21] ppc/eeh: handle EEH error based on PE
Date: Thu, 28 Jun 2012 00:01:48 +0800
Message-Id: <1340812911-6793-19-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch reworks the current implementation so that the eeh errors
will be handled basing on PE instead of eeh device.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h              |    1 +
 arch/powerpc/include/asm/eeh_event.h        |    2 +-
 arch/powerpc/platforms/pseries/eeh_driver.c |  229 +++++++++++----------------
 arch/powerpc/platforms/pseries/eeh_event.c  |    2 +-
 arch/powerpc/platforms/pseries/eeh_pe.c     |   27 ++++
 5 files changed, 124 insertions(+), 137 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 9a9fe28..e07ece1 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -174,6 +174,7 @@ int eeh_pe_remove(struct eeh_dev *edev);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
 		eeh_traverse_func fn, void *flag);
 void eeh_pe_restore_bars(struct eeh_pe *pe);
+struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
 void * __devinit eeh_dev_init(struct device_node *dn, void *data);
 void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb);
diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
index dc722b5..de67d83 100644
--- a/arch/powerpc/include/asm/eeh_event.h
+++ b/arch/powerpc/include/asm/eeh_event.h
@@ -32,7 +32,7 @@ struct eeh_event {
 };
 
 int eeh_send_failure_event(struct eeh_pe *pe);
-struct eeh_dev *handle_eeh_events(struct eeh_event *);
+void eeh_handle_event(struct eeh_pe *pe);
 
 #endif /* __KERNEL__ */
 #endif /* ASM_POWERPC_EEH_EVENT_H */
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index baf92cd..343c807 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -116,28 +116,35 @@ static void eeh_enable_irq(struct pci_dev *dev)
 
 /**
  * eeh_report_error - Report pci error to each device driver
- * @dev: PCI device
+ * @data: eeh device
  * @userdata: return value
  * 
  * Report an EEH error to each device driver, collect up and 
  * merge the device driver responses. Cumulative response 
  * passed back in "userdata".
  */
-static int eeh_report_error(struct pci_dev *dev, void *userdata)
+static void *eeh_report_error(void *data, void *userdata)
 {
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver = dev->driver;
 
+	/* We might not have the associated PCI device,
+	 * then we should continue for next one.
+	 */
+	if (!dev) return NULL;
+
 	dev->error_state = pci_channel_io_frozen;
 
 	if (!driver)
-		return 0;
+		return NULL;
 
 	eeh_disable_irq(dev);
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->error_detected)
-		return 0;
+		return NULL;
 
 	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
 
@@ -145,27 +152,31 @@ static int eeh_report_error(struct pci_dev *dev, void *userdata)
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
-	return 0;
+	return NULL;
 }
 
 /**
  * eeh_report_mmio_enabled - Tell drivers that MMIO has been enabled
- * @dev: PCI device
+ * @data: eeh device
  * @userdata: return value
  *
  * Tells each device driver that IO ports, MMIO and config space I/O
  * are now enabled. Collects up and merges the device driver responses.
  * Cumulative response passed back in "userdata".
  */
-static int eeh_report_mmio_enabled(struct pci_dev *dev, void *userdata)
+static void *eeh_report_mmio_enabled(void *data, void *userdata)
 {
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	enum pci_ers_result rc, *res = userdata;
-	struct pci_driver *driver = dev->driver;
+	struct pci_driver *driver;
 
-	if (!driver ||
+	if (!dev) return NULL;
+
+	if (!(driver = dev->driver) ||
 	    !driver->err_handler ||
 	    !driver->err_handler->mmio_enabled)
-		return 0;
+		return NULL;
 
 	rc = driver->err_handler->mmio_enabled(dev);
 
@@ -173,12 +184,12 @@ static int eeh_report_mmio_enabled(struct pci_dev *dev, void *userdata)
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
-	return 0;
+	return NULL;
 }
 
 /**
  * eeh_report_reset - Tell device that slot has been reset
- * @dev: PCI device
+ * @data: eeh device
  * @userdata: return value
  *
  * This routine must be called while EEH tries to reset particular
@@ -186,13 +197,15 @@ static int eeh_report_mmio_enabled(struct pci_dev *dev, void *userdata)
  * some actions, usually to save data the driver needs so that the
  * driver can work again while the device is recovered.
  */
-static int eeh_report_reset(struct pci_dev *dev, void *userdata)
+static void *eeh_report_reset(void *data, void *userdata)
 {
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	enum pci_ers_result rc, *res = userdata;
-	struct pci_driver *driver = dev->driver;
+	struct pci_driver *driver;
 
-	if (!driver)
-		return 0;
+	if (!dev || !(driver = dev->driver))
+		return NULL;
 
 	dev->error_state = pci_channel_io_normal;
 
@@ -200,7 +213,7 @@ static int eeh_report_reset(struct pci_dev *dev, void *userdata)
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->slot_reset)
-		return 0;
+		return NULL;
 
 	rc = driver->err_handler->slot_reset(dev);
 	if ((*res == PCI_ERS_RESULT_NONE) ||
@@ -208,82 +221,89 @@ static int eeh_report_reset(struct pci_dev *dev, void *userdata)
 	if (*res == PCI_ERS_RESULT_DISCONNECT &&
 	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 
-	return 0;
+	return NULL;
 }
 
 /**
  * eeh_report_resume - Tell device to resume normal operations
- * @dev: PCI device
+ * @data: eeh device
  * @userdata: return value
  *
  * This routine must be called to notify the device driver that it
  * could resume so that the device driver can do some initialization
  * to make the recovered device work again.
  */
-static int eeh_report_resume(struct pci_dev *dev, void *userdata)
+static void *eeh_report_resume(void *data, void *userdata)
 {
-	struct pci_driver *driver = dev->driver;
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	struct pci_driver *driver;
+
+	if (!dev) return NULL;
 
 	dev->error_state = pci_channel_io_normal;
 
-	if (!driver)
-		return 0;
+	if (!(driver = dev->driver))
+		return NULL;
 
 	eeh_enable_irq(dev);
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->resume)
-		return 0;
+		return NULL;
 
 	driver->err_handler->resume(dev);
 
-	return 0;
+	return NULL;
 }
 
 /**
  * eeh_report_failure - Tell device driver that device is dead.
- * @dev: PCI device
+ * @data: eeh device
  * @userdata: return value
  *
  * This informs the device driver that the device is permanently
  * dead, and that no further recovery attempts will be made on it.
  */
-static int eeh_report_failure(struct pci_dev *dev, void *userdata)
+static void *eeh_report_failure(void *data, void *userdata)
 {
-	struct pci_driver *driver = dev->driver;
+	struct eeh_dev *edev = (struct eeh_dev *)data;
+	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
+	struct pci_driver *driver;
+
+	if (!dev) return NULL;
 
 	dev->error_state = pci_channel_io_perm_failure;
 
-	if (!driver)
-		return 0;
+	if (!(driver = dev->driver))
+		return NULL;
 
 	eeh_disable_irq(dev);
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->error_detected)
-		return 0;
+		return NULL;
 
 	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
 
-	return 0;
+	return NULL;
 }
 
 /**
  * eeh_reset_device - Perform actual reset of a pci slot
- * @edev: PE associated EEH device
+ * @pe: EEH PE
  * @bus: PCI bus corresponding to the isolcated slot
  *
  * This routine must be called to do reset on the indicated PE.
  * During the reset, udev might be invoked because those affected
  * PCI devices will be removed and then added.
  */
-static int eeh_reset_device(struct eeh_dev *edev, struct pci_bus *bus)
+static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 {
-	struct device_node *dn;
 	int cnt, rc;
 
 	/* pcibios will clear the counter; save the value */
-	cnt = edev->freeze_count;
+	cnt = pe->freeze_count;
 
 	if (bus)
 		pcibios_remove_pci_devices(bus);
@@ -292,25 +312,13 @@ static int eeh_reset_device(struct eeh_dev *edev, struct pci_bus *bus)
 	 * Reconfigure bridges and devices. Don't try to bring the system
 	 * up if the reset failed for some reason.
 	 */
-	rc = eeh_reset_pe(edev);
+	rc = eeh_reset_pe(pe);
 	if (rc)
 		return rc;
 
-	/* Walk over all functions on this device. */
-	dn = eeh_dev_to_of_node(edev);
-	if (!pcibios_find_pci_bus(dn) && of_node_to_eeh_dev(dn->parent))
-		dn = dn->parent->child;
-
-	while (dn) {
-		struct eeh_dev *pedev = of_node_to_eeh_dev(dn);
-
-		/* On Power4, always true because eeh_pe_config_addr=0 */
-		if (edev->pe_config_addr == pedev->pe_config_addr) {
-			eeh_ops->configure_bridge(dn);
-			eeh_restore_bars(pedev);
- 		}
-		dn = dn->sibling;
-	}
+	/* Restore PE */
+	eeh_ops->configure_bridge(pe);
+	eeh_pe_restore_bars(pe);
 
 	/* Give the system 5 seconds to finish running the user-space
 	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes, 
@@ -322,7 +330,7 @@ static int eeh_reset_device(struct eeh_dev *edev, struct pci_bus *bus)
 		ssleep(5);
 		pcibios_add_pci_devices(bus);
 	}
-	edev->freeze_count = cnt;
+	pe->freeze_count = cnt;
 
 	return 0;
 }
@@ -334,7 +342,7 @@ static int eeh_reset_device(struct eeh_dev *edev, struct pci_bus *bus)
 
 /**
  * eeh_handle_event - Reset a PCI device after hard lockup.
- * @event: EEH event
+ * @pe: EEH PE
  *
  * While PHB detects address or data parity errors on particular PCI
  * slot, the associated PE will be frozen. Besides, DMA's occurring
@@ -349,69 +357,24 @@ static int eeh_reset_device(struct eeh_dev *edev, struct pci_bus *bus)
  * drivers (which cause a second set of hotplug events to go out to
  * userspace).
  */
-struct eeh_dev *handle_eeh_events(struct eeh_event *event)
+void eeh_handle_event(struct eeh_pe *pe)
 {
-	struct device_node *frozen_dn;
-	struct eeh_dev *frozen_edev;
 	struct pci_bus *frozen_bus;
 	int rc = 0;
 	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
-	const char *location, *pci_str, *drv_str, *bus_pci_str, *bus_drv_str;
-
-	frozen_dn = eeh_find_device_pe(eeh_dev_to_of_node(event->edev));
-	if (!frozen_dn) {
-		location = of_get_property(eeh_dev_to_of_node(event->edev), "ibm,loc-code", NULL);
-		location = location ? location : "unknown";
-		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint "
-		                "for location=%s pci addr=%s\n",
-			location, eeh_pci_name(eeh_dev_to_pci_dev(event->edev)));
-		return NULL;
-	}
-
-	frozen_bus = pcibios_find_pci_bus(frozen_dn);
-	location = of_get_property(frozen_dn, "ibm,loc-code", NULL);
-	location = location ? location : "unknown";
-
-	/* There are two different styles for coming up with the PE.
-	 * In the old style, it was the highest EEH-capable device
-	 * which was always an EADS pci bridge.  In the new style,
-	 * there might not be any EADS bridges, and even when there are,
-	 * the firmware marks them as "EEH incapable". So another
-	 * two-step is needed to find the pci bus..
-	 */
-	if (!frozen_bus)
-		frozen_bus = pcibios_find_pci_bus(frozen_dn->parent);
 
+	frozen_bus = eeh_pe_bus_get(pe);
 	if (!frozen_bus) {
-		printk(KERN_ERR "EEH: Cannot find PCI bus "
-		        "for location=%s dn=%s\n",
-		        location, frozen_dn->full_name);
-		return NULL;
+		pr_err("%s: Cannot find PCI bus for PHB#%d-PE#%x\n",
+			__func__, pe->phb->global_number, pe->addr);
+		return;
 	}
 
-	frozen_edev = of_node_to_eeh_dev(frozen_dn);
-	frozen_edev->freeze_count++;
-	pci_str = eeh_pci_name(eeh_dev_to_pci_dev(event->edev));
-	drv_str = eeh_pcid_name(eeh_dev_to_pci_dev(event->edev));
-
-	if (frozen_edev->freeze_count > EEH_MAX_ALLOWED_FREEZES)
+	pe->freeze_count++;
+	if (pe->freeze_count > EEH_MAX_ALLOWED_FREEZES)
 		goto excess_failures;
-
-	printk(KERN_WARNING
-	   "EEH: This PCI device has failed %d times in the last hour:\n",
-		frozen_edev->freeze_count);
-
-	if (frozen_edev->pdev) {
-		bus_pci_str = pci_name(frozen_edev->pdev);
-		bus_drv_str = eeh_pcid_name(frozen_edev->pdev);
-		printk(KERN_WARNING
-			"EEH: Bus location=%s driver=%s pci addr=%s\n",
-			location, bus_drv_str, bus_pci_str);
-	}
-
-	printk(KERN_WARNING
-		"EEH: Device location=%s driver=%s pci addr=%s\n",
-		location, drv_str, pci_str);
+	pr_warning("EEH: This PCI device has failed %d times in the last hour\n",
+		pe->freeze_count);
 
 	/* Walk the various device drivers attached to this slot through
 	 * a reset sequence, giving each an opportunity to do what it needs
@@ -419,12 +382,12 @@ struct eeh_dev *handle_eeh_events(struct eeh_event *event)
 	 * status ... if any child can't handle the reset, then the entire
 	 * slot is dlpar removed and added.
 	 */
-	pci_walk_bus(frozen_bus, eeh_report_error, &result);
+	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
 
 	/* Get the current PCI slot state. This can take a long time,
 	 * sometimes over 3 seconds for certain systems.
 	 */
-	rc = eeh_ops->wait_state(eeh_dev_to_of_node(frozen_edev), MAX_WAIT_FOR_RECOVERY*1000);
+	rc = eeh_ops->wait_state(pe, MAX_WAIT_FOR_RECOVERY*1000);
 	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
 		printk(KERN_WARNING "EEH: Permanent failure\n");
 		goto hard_fail;
@@ -434,14 +397,14 @@ struct eeh_dev *handle_eeh_events(struct eeh_event *event)
 	 * don't post the error log until after all dev drivers
 	 * have been informed.
 	 */
-	eeh_slot_error_detail(frozen_edev, EEH_LOG_TEMP);
+	eeh_slot_error_detail(pe, EEH_LOG_TEMP);
 
 	/* If all device drivers were EEH-unaware, then shut
 	 * down all of the device drivers, and hope they
 	 * go down willingly, without panicing the system.
 	 */
 	if (result == PCI_ERS_RESULT_NONE) {
-		rc = eeh_reset_device(frozen_edev, frozen_bus);
+		rc = eeh_reset_device(pe, frozen_bus);
 		if (rc) {
 			printk(KERN_WARNING "EEH: Unable to reset, rc=%d\n", rc);
 			goto hard_fail;
@@ -450,7 +413,7 @@ struct eeh_dev *handle_eeh_events(struct eeh_event *event)
 
 	/* If all devices reported they can proceed, then re-enable MMIO */
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
-		rc = eeh_pci_enable(frozen_edev, EEH_OPT_THAW_MMIO);
+		rc = eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
 
 		if (rc < 0)
 			goto hard_fail;
@@ -458,13 +421,13 @@ struct eeh_dev *handle_eeh_events(struct eeh_event *event)
 			result = PCI_ERS_RESULT_NEED_RESET;
 		} else {
 			result = PCI_ERS_RESULT_NONE;
-			pci_walk_bus(frozen_bus, eeh_report_mmio_enabled, &result);
+			eeh_pe_dev_traverse(pe, eeh_report_mmio_enabled, &result);
 		}
 	}
 
 	/* If all devices reported they can proceed, then re-enable DMA */
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
-		rc = eeh_pci_enable(frozen_edev, EEH_OPT_THAW_DMA);
+		rc = eeh_pci_enable(pe, EEH_OPT_THAW_DMA);
 
 		if (rc < 0)
 			goto hard_fail;
@@ -482,13 +445,13 @@ struct eeh_dev *handle_eeh_events(struct eeh_event *event)
 
 	/* If any device called out for a reset, then reset the slot */
 	if (result == PCI_ERS_RESULT_NEED_RESET) {
-		rc = eeh_reset_device(frozen_edev, NULL);
+		rc = eeh_reset_device(pe, NULL);
 		if (rc) {
 			printk(KERN_WARNING "EEH: Cannot reset, rc=%d\n", rc);
 			goto hard_fail;
 		}
 		result = PCI_ERS_RESULT_NONE;
-		pci_walk_bus(frozen_bus, eeh_report_reset, &result);
+		eeh_pe_dev_traverse(pe, eeh_report_reset, &result);
 	}
 
 	/* All devices should claim they have recovered by now. */
@@ -499,9 +462,9 @@ struct eeh_dev *handle_eeh_events(struct eeh_event *event)
 	}
 
 	/* Tell all device drivers that they can resume operations */
-	pci_walk_bus(frozen_bus, eeh_report_resume, NULL);
+	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
 
-	return frozen_edev;
+	return;
 	
 excess_failures:
 	/*
@@ -509,30 +472,26 @@ excess_failures:
 	 * are due to poorly seated PCI cards. Only 10% or so are
 	 * due to actual, failed cards.
 	 */
-	printk(KERN_ERR
-	   "EEH: PCI device at location=%s driver=%s pci addr=%s\n"
-		"has failed %d times in the last hour "
-		"and has been permanently disabled.\n"
-		"Please try reseating this device or replacing it.\n",
-		location, drv_str, pci_str, frozen_edev->freeze_count);
+	pr_err("EEH: PHB#%d-PE#%x has failed %d times in the\n"
+	       "last hour and has been permanently disabled.\n"
+	       "Please try reseating or replacing it.\n",
+		pe->phb->global_number, pe->addr,
+		pe->freeze_count);
 	goto perm_error;
 
 hard_fail:
-	printk(KERN_ERR
-	   "EEH: Unable to recover from failure of PCI device "
-	   "at location=%s driver=%s pci addr=%s\n"
-	   "Please try reseating this device or replacing it.\n",
-		location, drv_str, pci_str);
+	pr_err("EEH: Unable to recover from failure from PHB#%d-PE#%x.\n"
+	       "Please try reseating or replacing it\n",
+		pe->phb->global_number, pe->addr);
 
 perm_error:
-	eeh_slot_error_detail(frozen_edev, EEH_LOG_PERM);
+	eeh_slot_error_detail(pe, EEH_LOG_PERM);
 
 	/* Notify all devices that they're about to go down. */
-	pci_walk_bus(frozen_bus, eeh_report_failure, NULL);
+	eeh_pe_dev_traverse(pe, eeh_report_failure, NULL);
 
 	/* Shut down the device drivers for good. */
-	pcibios_remove_pci_devices(frozen_bus);
-
-	return NULL;
+	if (frozen_bus)
+		pcibios_remove_pci_devices(frozen_bus);
 }
 
diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
index 67c82c2..7d48feb 100644
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ b/arch/powerpc/platforms/pseries/eeh_event.c
@@ -81,7 +81,7 @@ static int eeh_event_handler(void * dummy)
 	pr_info("EEH: Detected PCI bus error on PHB#%d-PE#%x\n",
 		pe->phb->global_number, pe->addr);
 
-	handle_eeh_events(event);
+	eeh_handle_event(pe);
 
 	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 8bae0f6..d70a7e4 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -554,3 +554,30 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
 	eeh_pe_dev_traverse(pe, eeh_restore_one_device_bars, NULL);
 }
 
+/**
+ * eeh_pe_bus_get - Retrieve PCI bus according to the given PE
+ * @pe: EEH PE
+ *
+ * Retrieve the PCI bus according to the given PE. Basically,
+ * there're 3 types of PEs: PHB/Bus/Device. For PHB PE, the
+ * primary PCI bus will be retrieved. The parent bus will be
+ * returned for BUS PE. However, we don't have associated PCI
+ * bus for DEVICE PE.
+ */
+struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
+{
+	struct pci_bus *bus = NULL;
+	struct eeh_dev *edev;
+	struct pci_dev *pdev;
+
+	if (pe->type == EEH_PE_PHB) {
+		bus = pe->phb->bus;
+	} else if (pe->type == EEH_PE_BUS) {
+		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (pdev)
+			bus = pdev->bus;
+	}
+
+	return bus;
+}
-- 
1.7.9.5
