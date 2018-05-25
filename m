Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sWWC6bmrzF1S9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:51 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P34FJb015553
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:49 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j65e01p0r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:49 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 25 May 2018 04:11:47 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w4P3BifA5833006
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:11:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 137AC11C04C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:02:48 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2576B11C050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:02:47 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:02:47 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 77A5AA03B4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:40 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 13/13] powerpc/eeh: Refactor report functions
Date: Fri, 25 May 2018 13:11:40 +1000
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
Message-Id: <bcf1d3b57fb80564423e12b9d5e5ccf08f7fafdc.1527217866.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The EEH report functions now share a fair bit of code around the start
and end of each function.

So factor out as much as possible, and move the traversal into a
custom function. This also allows accurate debug to be generated more
easily.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
====== v1 -> v2: ======
* Better name for eeh_infoline() and implement using a function.
* Move the core of eeh_pe_report() into a new function to improve readability.
* pci_ers_result_name(): match parameter name to eeh_result_priority(), correct and improve warning message.

 arch/powerpc/kernel/eeh_driver.c | 310 ++++++++++++++++++++-------------------
 1 file changed, 159 insertions(+), 151 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 42fe80ed6f59..7cab58abbec9 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -54,6 +54,40 @@ static int eeh_result_priority(enum pci_ers_result result)
 	}
 };
 
+const char *pci_ers_result_name(enum pci_ers_result result)
+{
+	switch (result) {
+	case PCI_ERS_RESULT_NONE: return "none";
+	case PCI_ERS_RESULT_CAN_RECOVER: return "can recover";
+	case PCI_ERS_RESULT_NEED_RESET: return "need reset";
+	case PCI_ERS_RESULT_DISCONNECT: return "disconnect";
+	case PCI_ERS_RESULT_RECOVERED: return "recovered";
+	case PCI_ERS_RESULT_NO_AER_DRIVER: return "no AER driver";
+	default:
+		WARN_ONCE(1, "Unknown result type: %d\n", (int)result);
+		return "unknown";
+	}
+};
+
+static __printf(2, 3)
+void eeh_edev_info(const struct eeh_dev *edev, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	printk(KERN_INFO "EEH: PE#%x (PCI %s): %pV\n",
+			edev->pe_config_addr,
+			edev->pdev ? dev_name(&edev->pdev->dev) : "none",
+			&vaf);
+
+	va_end(args);
+}
+
 static enum pci_ers_result pci_ers_merge_result(enum pci_ers_result old,
 						enum pci_ers_result new)
 {
@@ -229,123 +263,124 @@ static void eeh_set_irq_state(struct eeh_pe *root, bool enable)
 	}
 }
 
-/**
- * eeh_report_error - Report pci error to each device driver
- * @data: eeh device
- * @userdata: return value
- *
- * Report an EEH error to each device driver, collect up and
- * merge the device driver responses. Cumulative response
- * passed back in "userdata".
- */
-static void *eeh_report_error(struct eeh_dev *edev, void *userdata)
+typedef enum pci_ers_result (*eeh_report_fn)(struct eeh_dev *,
+					     struct pci_driver *);
+static void eeh_pe_report_edev(struct eeh_dev *edev,
+					      eeh_report_fn fn,
+					      enum pci_ers_result *result)
 {
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
+	enum pci_ers_result new_result;
+
+	device_lock(&edev->pdev->dev);
+	if (eeh_edev_actionable(edev)) {
+		driver = eeh_pcid_get(edev->pdev);
+
+		if (!driver)
+			eeh_edev_info(edev, "no driver");
+		else if (!driver->err_handler)
+			eeh_edev_info(edev,
+				     "driver not EEH aware");
+		else if (edev->mode & EEH_DEV_NO_HANDLER)
+			eeh_edev_info(edev,
+				     "driver bound too late");
+		else {
+			new_result = fn(edev, driver);
+			eeh_edev_info(edev,
+				"%s driver reports: '%s'",
+				driver->name,
+				pci_ers_result_name(new_result));
+			if (result)
+				*result = pci_ers_merge_result(*result,
+							       new_result);
+		}
+		if (driver)
+			eeh_pcid_put(edev->pdev);
+	} else {
+		eeh_edev_info(edev, "not actionable (%d,%d,%d)",
+			     !!edev->pdev,
+			     !eeh_dev_removed(edev),
+			     !eeh_pe_passed(edev->pe));
+	}
+	device_unlock(&edev->pdev->dev);
+}
 
-	if (!eeh_edev_actionable(edev))
-		return NULL;
+static void eeh_pe_report(const char *name, struct eeh_pe *root,
+			  eeh_report_fn fn,
+			  enum pci_ers_result *result)
+{
+	struct eeh_pe *pe;
+	struct eeh_dev *edev, *tmp;
 
-	device_lock(&dev->dev);
+	pr_info("EEH: Beginning: '%s'\n", name);
+	eeh_for_each_pe(root, pe)
+		eeh_pe_for_each_dev(pe, edev, tmp)
+			eeh_pe_report_edev(edev, fn, result);
+	if (result)
+		pr_info("EEH: Finished:'%s' with aggregate recovery state:'%s'\n",
+			name, pci_ers_result_name(*result));
+	else
+		pr_info("EEH: Finished:'%s'", name);
+}
 
-	driver = eeh_pcid_get(dev);
-	if (!driver) goto out_no_dev;
+/**
+ * eeh_report_error - Report pci error to each device driver
+ * @edev: eeh device
+ * @driver: device's PCI driver
+ *
+ * Report an EEH error to each device driver.
+ */
+static enum pci_ers_result eeh_report_error(struct eeh_dev *edev,
+			      struct pci_driver *driver)
+{
+	enum pci_ers_result rc;
+	struct pci_dev *dev = edev->pdev;
 
-	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected)
-		goto out;
+	if (!driver->err_handler->error_detected)
+		return PCI_ERS_RESULT_NONE;
 
+	eeh_edev_info(edev, "Invoking %s->error_detected(IO frozen)", driver->name);
 	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
 
-	*res = pci_ers_merge_result(*res, rc);
-
 	edev->in_error = true;
 	pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
-
-out:
-	eeh_pcid_put(dev);
-out_no_dev:
-	device_unlock(&dev->dev);
-	return NULL;
+	return rc;
 }
 
 /**
  * eeh_report_mmio_enabled - Tell drivers that MMIO has been enabled
- * @data: eeh device
- * @userdata: return value
+ * @edev: eeh device
+ * @driver: device's PCI driver
  *
  * Tells each device driver that IO ports, MMIO and config space I/O
- * are now enabled. Collects up and merges the device driver responses.
- * Cumulative response passed back in "userdata".
+ * are now enabled.
  */
-static void *eeh_report_mmio_enabled(struct eeh_dev *edev, void *userdata)
+static enum pci_ers_result eeh_report_mmio_enabled(struct eeh_dev *edev,
+						   struct pci_driver *driver)
 {
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	enum pci_ers_result rc, *res = userdata;
-	struct pci_driver *driver;
-
-	if (!eeh_edev_actionable(edev))
-		return NULL;
-
-	device_lock(&dev->dev);
-	driver = eeh_pcid_get(dev);
-	if (!driver) goto out_no_dev;
-
-	if (!driver->err_handler ||
-	    !driver->err_handler->mmio_enabled ||
-	    (edev->mode & EEH_DEV_NO_HANDLER))
-		goto out;
-
-	rc = driver->err_handler->mmio_enabled(dev);
-
-	*res = pci_ers_merge_result(*res, rc);
-
-out:
-	eeh_pcid_put(dev);
-out_no_dev:
-	device_unlock(&dev->dev);
-	return NULL;
+	if (!driver->err_handler->mmio_enabled)
+		return PCI_ERS_RESULT_NONE;
+	eeh_edev_info(edev, "Invoking %s->mmio_enabled()", driver->name);
+	return driver->err_handler->mmio_enabled(edev->pdev);
 }
 
 /**
  * eeh_report_reset - Tell device that slot has been reset
- * @data: eeh device
- * @userdata: return value
+ * @edev: eeh device
+ * @driver: device's PCI driver
  *
  * This routine must be called while EEH tries to reset particular
  * PCI device so that the associated PCI device driver could take
  * some actions, usually to save data the driver needs so that the
  * driver can work again while the device is recovered.
  */
-static void *eeh_report_reset(struct eeh_dev *edev, void *userdata)
+static enum pci_ers_result eeh_report_reset(struct eeh_dev *edev,
+					    struct pci_driver *driver)
 {
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	enum pci_ers_result rc, *res = userdata;
-	struct pci_driver *driver;
-
-	if (!eeh_edev_actionable(edev))
-		return NULL;
-
-	device_lock(&dev->dev);
-
-	driver = eeh_pcid_get(dev);
-	if (!driver) goto out_no_dev;
-
-	if (!driver->err_handler ||
-	    !driver->err_handler->slot_reset ||
-	    (edev->mode & EEH_DEV_NO_HANDLER) ||
-	    (!edev->in_error))
-		goto out;
-
-	rc = driver->err_handler->slot_reset(dev);
-	*res = pci_ers_merge_result(*res, rc);
-
-out:
-	eeh_pcid_put(dev);
-out_no_dev:
-	device_unlock(&dev->dev);
-	return NULL;
+	if (!driver->err_handler->slot_reset || !edev->in_error)
+		return PCI_ERS_RESULT_NONE;
+	eeh_edev_info(edev, "Invoking %s->slot_reset()", driver->name);
+	return driver->err_handler->slot_reset(edev->pdev);
 }
 
 static void *eeh_dev_restore_state(struct eeh_dev *edev, void *userdata)
@@ -378,84 +413,52 @@ static void *eeh_dev_restore_state(struct eeh_dev *edev, void *userdata)
 
 /**
  * eeh_report_resume - Tell device to resume normal operations
- * @data: eeh device
- * @userdata: return value
+ * @edev: eeh device
+ * @driver: device's PCI driver
  *
  * This routine must be called to notify the device driver that it
  * could resume so that the device driver can do some initialization
  * to make the recovered device work again.
  */
-static void *eeh_report_resume(struct eeh_dev *edev, void *userdata)
+static enum pci_ers_result eeh_report_resume(struct eeh_dev *edev,
+					     struct pci_driver *driver)
 {
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	bool was_in_error;
-	struct pci_driver *driver;
+	if (!driver->err_handler->resume || !edev->in_error)
+		return PCI_ERS_RESULT_NONE;
 
-	if (!eeh_edev_actionable(edev))
-		return NULL;
-
-	device_lock(&dev->dev);
-
-	driver = eeh_pcid_get(dev);
-	if (!driver) goto out_no_dev;
-
-	was_in_error = edev->in_error;
-	edev->in_error = false;
+	eeh_edev_info(edev, "Invoking %s->resume()", driver->name);
+	driver->err_handler->resume(edev->pdev);
 
-	if (!driver->err_handler ||
-	    !driver->err_handler->resume ||
-	    (edev->mode & EEH_DEV_NO_HANDLER) || !was_in_error) {
-		goto out;
-	}
-
-	driver->err_handler->resume(dev);
-
-	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
-out:
-	eeh_pcid_put(dev);
+	pci_uevent_ers(edev->pdev, PCI_ERS_RESULT_RECOVERED);
 #ifdef CONFIG_PCI_IOV
 	if (eeh_ops->notify_resume && eeh_dev_to_pdn(edev))
 		eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
 #endif
-out_no_dev:
-	device_unlock(&dev->dev);
-	return NULL;
+	return PCI_ERS_RESULT_NONE;
 }
 
 /**
  * eeh_report_failure - Tell device driver that device is dead.
- * @data: eeh device
- * @userdata: return value
+ * @edev: eeh device
+ * @driver: device's PCI driver
  *
  * This informs the device driver that the device is permanently
  * dead, and that no further recovery attempts will be made on it.
  */
-static void *eeh_report_failure(struct eeh_dev *edev, void *userdata)
+static enum pci_ers_result eeh_report_failure(struct eeh_dev *edev,
+					      struct pci_driver *driver)
 {
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	struct pci_driver *driver;
-
-	if (!eeh_edev_actionable(edev))
-		return NULL;
-
-	device_lock(&dev->dev);
-	dev->error_state = pci_channel_io_perm_failure;
-
-	driver = eeh_pcid_get(dev);
-	if (!driver) goto out_no_dev;
+	enum pci_ers_result rc;
 
-	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected)
-		goto out;
+	if (!driver->err_handler->error_detected)
+		return PCI_ERS_RESULT_NONE;
 
-	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
+	eeh_edev_info(edev, "Invoking %s->error_detected(permanent failure)",
+		     driver->name);
+	rc = driver->err_handler->error_detected(edev->pdev, pci_channel_io_perm_failure);
 
-	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
-out:
-	eeh_pcid_put(dev);
-out_no_dev:
-	device_unlock(&dev->dev);
-	return NULL;
+	pci_uevent_ers(edev->pdev, PCI_ERS_RESULT_DISCONNECT);
+	return rc;
 }
 
 static void *eeh_add_virt_device(void *data, void *userdata)
@@ -817,7 +820,8 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	pr_info("EEH: Notify device drivers to shutdown\n");
 	eeh_set_channel_state(pe, pci_channel_io_frozen);
 	eeh_set_irq_state(pe, false);
-	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
+	eeh_pe_report("error_detected(IO frozen)", pe,
+		      eeh_report_error, &result);
 	if ((pe->type & EEH_PE_PHB) &&
 	    result != PCI_ERS_RESULT_NONE &&
 	    result != PCI_ERS_RESULT_NEED_RESET)
@@ -864,7 +868,8 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 			result = PCI_ERS_RESULT_NEED_RESET;
 		} else {
 			pr_info("EEH: Notify device drivers to resume I/O\n");
-			eeh_pe_dev_traverse(pe, eeh_report_mmio_enabled, &result);
+			eeh_pe_report("mmio_enabled", pe,
+				      eeh_report_mmio_enabled, &result);
 		}
 	}
 
@@ -909,7 +914,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		result = PCI_ERS_RESULT_NONE;
 		eeh_set_channel_state(pe, pci_channel_io_normal);
 		eeh_set_irq_state(pe, true);
-		eeh_pe_dev_traverse(pe, eeh_report_reset, &result);
+		eeh_pe_report("slot_reset", pe, eeh_report_reset, &result);
 	}
 
 	/* All devices should claim they have recovered by now. */
@@ -932,11 +937,13 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	pr_info("EEH: Notify device driver to resume\n");
 	eeh_set_channel_state(pe, pci_channel_io_normal);
 	eeh_set_irq_state(pe, true);
-	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
-
-	eeh_for_each_pe(pe, tmp_pe)
-		eeh_pe_for_each_dev(tmp_pe, edev, tmp)
+	eeh_pe_report("resume", pe, eeh_report_resume, NULL);
+	eeh_for_each_pe(pe, tmp_pe) {
+		eeh_pe_for_each_dev(tmp_pe, edev, tmp) {
 			edev->mode &= ~EEH_DEV_NO_HANDLER;
+			edev->in_error = false;
+		}
+	}
 
 	pr_info("EEH: Recovery successful.\n");
 	goto final;
@@ -956,7 +963,8 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	/* Notify all devices that they're about to go down. */
 	eeh_set_channel_state(pe, pci_channel_io_perm_failure);
 	eeh_set_irq_state(pe, false);
-	eeh_pe_dev_traverse(pe, eeh_report_failure, NULL);
+	eeh_pe_report("error_detected(permanent failure)", pe,
+		      eeh_report_failure, NULL);
 
 	/* Mark the PE to be removed permanently */
 	eeh_pe_state_mark(pe, EEH_PE_REMOVED);
@@ -1066,8 +1074,8 @@ void eeh_handle_special_event(void)
 				/* Notify all devices to be down */
 				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 				eeh_set_channel_state(pe, pci_channel_io_perm_failure);
-				eeh_pe_dev_traverse(pe,
-					eeh_report_failure, NULL);
+				eeh_pe_report("error_detected(permanent failure)",
+					       pe, eeh_report_failure, NULL);
 				bus = eeh_pe_bus_get(phb_pe);
 				if (!bus) {
 					pr_err("%s: Cannot find PCI bus for "
-- 
2.16.1.74.g9b0b1f47b
