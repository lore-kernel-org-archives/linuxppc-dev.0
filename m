Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bT8c1rpJzF2S2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:37:04 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w426YkV1005099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 02:37:02 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hq6syb027-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 02:37:01 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 2 May 2018 07:37:00 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w426axsP64094328
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 06:36:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 725D9A404D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:28:48 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA453A405B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:28:47 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:28:47 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 3C221A01B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:36:57 +1000 (AEST)
Date: Wed, 2 May 2018 16:36:56 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/13] powerpc/eeh: Refactor report functions
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1525242772.git.sbobroff@linux.ibm.com>
Message-Id: <313ced0e1c4f5140566846bb41f1c42c26c96a0b.1525242772.git.sbobroff@linux.ibm.com>
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
 arch/powerpc/kernel/eeh_driver.c | 289 +++++++++++++++++++--------------------
 1 file changed, 138 insertions(+), 151 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index eb4feee81ff4..1c4336dcf9f5 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -54,6 +54,25 @@ static int eeh_result_priority(enum pci_ers_result result)
 	}
 };
 
+const char *pci_ers_result_name(enum pci_ers_result r)
+{
+	switch (r) {
+	case PCI_ERS_RESULT_NONE: return "none";
+	case PCI_ERS_RESULT_CAN_RECOVER: return "can recover";
+	case PCI_ERS_RESULT_NEED_RESET: return "need reset";
+	case PCI_ERS_RESULT_DISCONNECT: return "disconnect";
+	case PCI_ERS_RESULT_RECOVERED: return "recovered";
+	case PCI_ERS_RESULT_NO_AER_DRIVER: return "no AER driver";
+	default:
+		WARN_ONCE(1, "Unknown result type");
+		return "unknown";
+	}
+};
+
+#define eeh_infoline(EDEV, FMT, ...) \
+pr_info("EEH: PE#%x (PCI %s): " pr_fmt(FMT) "\n", EDEV->pe_config_addr, \
+((EDEV->pdev) ? dev_name(&EDEV->pdev->dev) : "NONE"), ##__VA_ARGS__)
+
 static enum pci_ers_result merge_result(enum pci_ers_result old,
 					enum pci_ers_result new)
 {
@@ -223,123 +242,118 @@ static void eeh_set_irq_state(struct eeh_pe *root, bool enable)
 				}
 }
 
+static void eeh_pe_report(const char *name, struct eeh_pe *root,
+			  enum pci_ers_result (*fn)(struct eeh_dev *,
+						    struct pci_driver *),
+			  enum pci_ers_result *result)
+{
+	struct eeh_pe *pe;
+	struct eeh_dev *edev, *tmp;
+	enum pci_ers_result new_result;
+
+	pr_info("EEH: Beginning: '%s'\n", name);
+	eeh_for_each_pe(root, pe) {
+		eeh_pe_for_each_dev(pe, edev, tmp) {
+			device_lock(&edev->pdev->dev);
+			if (eeh_edev_actionable(edev)) {
+				struct pci_driver *driver;
+
+				driver = eeh_pcid_get(edev->pdev);
+
+				if (!driver)
+					eeh_infoline(edev, "no driver");
+				else if (!driver->err_handler)
+					eeh_infoline(edev,
+						     "driver not EEH aware");
+				else if (edev->mode & EEH_DEV_NO_HANDLER)
+					eeh_infoline(edev,
+						     "driver bound too late");
+				else {
+					new_result = fn(edev, driver);
+					eeh_infoline(edev,
+						"%s driver reports: '%s'",
+						driver->name,
+						pci_ers_result_name(new_result));
+					if (result)
+						*result = merge_result(*result,
+								       new_result);
+				}
+				if (driver)
+					eeh_pcid_put(edev->pdev);
+			} else {
+				eeh_infoline(edev, "not actionable (%d,%d,%d)",
+					     !!edev->pdev,
+					     !eeh_dev_removed(edev),
+					     !eeh_pe_passed(edev->pe));
+			}
+			device_unlock(&edev->pdev->dev);
+		}
+	}
+	if (result)
+		pr_info("EEH: Finished:'%s' with aggregate recovery state:'%s'\n",
+			name, pci_ers_result_name(*result));
+	else
+		pr_info("EEH: Finished:'%s'", name);
+}
+
 /**
  * eeh_report_error - Report pci error to each device driver
- * @data: eeh device
- * @userdata: return value
+ * @edev: eeh device
+ * @driver: device's PCI driver
  *
- * Report an EEH error to each device driver, collect up and
- * merge the device driver responses. Cumulative response
- * passed back in "userdata".
+ * Report an EEH error to each device driver.
  */
-static void *eeh_report_error(struct eeh_dev *edev, void *userdata)
+static enum pci_ers_result eeh_report_error(struct eeh_dev *edev,
+			      struct pci_driver *driver)
 {
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	enum pci_ers_result rc, *res = userdata;
-	struct pci_driver *driver;
+	enum pci_ers_result rc;
+	struct pci_dev *dev = edev->pdev;
 
-	if (!eeh_edev_actionable(edev))
-		return NULL;
-
-	device_lock(&dev->dev);
-
-	driver = eeh_pcid_get(dev);
-	if (!driver) goto out_no_dev;
-
-	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected)
-		goto out;
+	if (!driver->err_handler->error_detected)
+		return PCI_ERS_RESULT_NONE;
 
+	eeh_infoline(edev, "Invoking %s->error_detected(IO frozen)", driver->name);
 	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
 
-	*res = merge_result(*res, rc);
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
-	*res = merge_result(*res, rc);
-
-out:
-	eeh_pcid_put(dev);
-out_no_dev:
-	device_unlock(&dev->dev);
-	return NULL;
+	if (!driver->err_handler->mmio_enabled)
+		return PCI_ERS_RESULT_NONE;
+	eeh_infoline(edev, "Invoking %s->mmio_enabled()", driver->name);
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
-	*res = merge_result(*res, rc);
-
-out:
-	eeh_pcid_put(dev);
-out_no_dev:
-	device_unlock(&dev->dev);
-	return NULL;
+	if (!driver->err_handler->slot_reset || !edev->in_error)
+		return PCI_ERS_RESULT_NONE;
+	eeh_infoline(edev, "Invoking %s->slot_reset()", driver->name);
+	return driver->err_handler->slot_reset(edev->pdev);
 }
 
 static void *eeh_dev_restore_state(struct eeh_dev *edev, void *userdata)
@@ -372,84 +386,52 @@ static void *eeh_dev_restore_state(struct eeh_dev *edev, void *userdata)
 
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
-
-	if (!eeh_edev_actionable(edev))
-		return NULL;
+	if (!driver->err_handler->resume || !edev->in_error)
+		return PCI_ERS_RESULT_NONE;
 
-	device_lock(&dev->dev);
+	eeh_infoline(edev, "Invoking %s->resume()", driver->name);
+	driver->err_handler->resume(edev->pdev);
 
-	driver = eeh_pcid_get(dev);
-	if (!driver) goto out_no_dev;
-
-	was_in_error = edev->in_error;
-	edev->in_error = false;
-
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
+	enum pci_ers_result rc;
 
-	if (!eeh_edev_actionable(edev))
-		return NULL;
+	if (!driver->err_handler->error_detected)
+		return PCI_ERS_RESULT_NONE;
 
-	device_lock(&dev->dev);
-	dev->error_state = pci_channel_io_perm_failure;
+	eeh_infoline(edev, "Invoking %s->error_detected(permanent failure)",
+		     driver->name);
+	rc = driver->err_handler->error_detected(edev->pdev, pci_channel_io_perm_failure);
 
-	driver = eeh_pcid_get(dev);
-	if (!driver) goto out_no_dev;
-
-	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected)
-		goto out;
-
-	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
-
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
@@ -811,7 +793,8 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	pr_info("EEH: Notify device drivers to shutdown\n");
 	eeh_set_channel_state(pe, pci_channel_io_frozen);
 	eeh_set_irq_state(pe, false);
-	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
+	eeh_pe_report("error_detected(IO frozen)", pe,
+		      eeh_report_error, &result);
 	if ((pe->type & EEH_PE_PHB) &&
 	    result != PCI_ERS_RESULT_NONE &&
 	    result != PCI_ERS_RESULT_NEED_RESET)
@@ -858,7 +841,8 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 			result = PCI_ERS_RESULT_NEED_RESET;
 		} else {
 			pr_info("EEH: Notify device drivers to resume I/O\n");
-			eeh_pe_dev_traverse(pe, eeh_report_mmio_enabled, &result);
+			eeh_pe_report("mmio_enabled", pe,
+				      eeh_report_mmio_enabled, &result);
 		}
 	}
 
@@ -903,7 +887,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		result = PCI_ERS_RESULT_NONE;
 		eeh_set_channel_state(pe, pci_channel_io_normal);
 		eeh_set_irq_state(pe, true);
-		eeh_pe_dev_traverse(pe, eeh_report_reset, &result);
+		eeh_pe_report("slot_reset", pe, eeh_report_reset, &result);
 	}
 
 	/* All devices should claim they have recovered by now. */
@@ -926,11 +910,13 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
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
@@ -950,7 +936,8 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	/* Notify all devices that they're about to go down. */
 	eeh_set_channel_state(pe, pci_channel_io_perm_failure);
 	eeh_set_irq_state(pe, false);
-	eeh_pe_dev_traverse(pe, eeh_report_failure, NULL);
+	eeh_pe_report("error_detected(permanent failure)", pe,
+		      eeh_report_failure, NULL);
 
 	/* Mark the PE to be removed permanently */
 	eeh_pe_state_mark(pe, EEH_PE_REMOVED);
@@ -1060,8 +1047,8 @@ void eeh_handle_special_event(void)
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
