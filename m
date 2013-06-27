Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AD902C01FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 15:47:01 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 23:46:58 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 033293E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:36 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5R5ktKP137946
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:55 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5R5ktKW026190
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:55 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/8] powerpc/eeh: Refactor the output message
Date: Thu, 27 Jun 2013 13:46:46 +0800
Message-Id: <1372312009-13710-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We needn't the the whole backtrace other than one-line message in
the error reporting interrupt handler. For errors triggered by
access PCI config space or MMIO, we replace "WARN(1, ...)" with
pr_err() and dump_stack(). The patch also adds more output messages
to indicate what EEH core is doing. Besides, some printk() are
replaced with pr_warning().

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c                 |    9 +++++++--
 arch/powerpc/kernel/eeh_driver.c          |   23 ++++++++++++++++++-----
 arch/powerpc/platforms/powernv/eeh-ioda.c |   25 ++++++++++++++++---------
 3 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 2dd0bd1..f7f2775 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -324,7 +324,9 @@ static int eeh_phb_check_failure(struct eeh_pe *pe)
 	eeh_serialize_unlock(flags);
 	eeh_send_failure_event(phb_pe);
 
-	WARN(1, "EEH: PHB failure detected\n");
+	pr_err("EEH: PHB#%x failure detected\n",
+		phb_pe->phb->global_number);
+	dump_stack();
 
 	return 1;
 out:
@@ -453,7 +455,10 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out.
 	 */
-	WARN(1, "EEH: failure detected\n");
+	pr_err("EEH: Frozen PE#%x detected on PHB#%x\n",
+		pe->addr, pe->phb->global_number);
+	dump_stack();
+
 	return 1;
 
 dn_unlock:
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 0974e13..2b1ce17 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -425,6 +425,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	 * status ... if any child can't handle the reset, then the entire
 	 * slot is dlpar removed and added.
 	 */
+	pr_info("EEH: Notify device drivers to shutdown\n");
 	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
 
 	/* Get the current PCI slot state. This can take a long time,
@@ -432,7 +433,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	 */
 	rc = eeh_ops->wait_state(pe, MAX_WAIT_FOR_RECOVERY*1000);
 	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
-		printk(KERN_WARNING "EEH: Permanent failure\n");
+		pr_warning("EEH: Permanent failure\n");
 		goto hard_fail;
 	}
 
@@ -440,6 +441,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	 * don't post the error log until after all dev drivers
 	 * have been informed.
 	 */
+	pr_info("EEH: Collect temporary log\n");
 	eeh_slot_error_detail(pe, EEH_LOG_TEMP);
 
 	/* If all device drivers were EEH-unaware, then shut
@@ -447,15 +449,18 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	 * go down willingly, without panicing the system.
 	 */
 	if (result == PCI_ERS_RESULT_NONE) {
+		pr_info("EEH: Reset with hotplug activity\n");
 		rc = eeh_reset_device(pe, frozen_bus);
 		if (rc) {
-			printk(KERN_WARNING "EEH: Unable to reset, rc=%d\n", rc);
+			pr_warning("%s: Unable to reset, err=%d\n",
+				   __func__, rc);
 			goto hard_fail;
 		}
 	}
 
 	/* If all devices reported they can proceed, then re-enable MMIO */
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
+		pr_info("EEH: Enable I/O for affected devices\n");
 		rc = eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
 
 		if (rc < 0)
@@ -463,6 +468,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 		if (rc) {
 			result = PCI_ERS_RESULT_NEED_RESET;
 		} else {
+			pr_info("EEH: Notify device drivers to resume I/O\n");
 			result = PCI_ERS_RESULT_NONE;
 			eeh_pe_dev_traverse(pe, eeh_report_mmio_enabled, &result);
 		}
@@ -470,6 +476,7 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 
 	/* If all devices reported they can proceed, then re-enable DMA */
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
+		pr_info("EEH: Enabled DMA for affected devices\n");
 		rc = eeh_pci_enable(pe, EEH_OPT_THAW_DMA);
 
 		if (rc < 0)
@@ -482,17 +489,22 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 
 	/* If any device has a hard failure, then shut off everything. */
 	if (result == PCI_ERS_RESULT_DISCONNECT) {
-		printk(KERN_WARNING "EEH: Device driver gave up\n");
+		pr_warning("EEH: Device driver gave up\n");
 		goto hard_fail;
 	}
 
 	/* If any device called out for a reset, then reset the slot */
 	if (result == PCI_ERS_RESULT_NEED_RESET) {
+		pr_info("EEH: Reset without hotplug activity\n");
 		rc = eeh_reset_device(pe, NULL);
 		if (rc) {
-			printk(KERN_WARNING "EEH: Cannot reset, rc=%d\n", rc);
+			pr_warning("%s: Cannot reset, err=%d\n",
+				   __func__, rc);
 			goto hard_fail;
 		}
+
+		pr_info("EEH: Notify device drivers "
+			"the completion of reset\n");
 		result = PCI_ERS_RESULT_NONE;
 		eeh_pe_dev_traverse(pe, eeh_report_reset, &result);
 	}
@@ -500,11 +512,12 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
 	/* All devices should claim they have recovered by now. */
 	if ((result != PCI_ERS_RESULT_RECOVERED) &&
 	    (result != PCI_ERS_RESULT_NONE)) {
-		printk(KERN_WARNING "EEH: Not recovered\n");
+		pr_warning("EEH: Not recovered\n");
 		goto hard_fail;
 	}
 
 	/* Tell all device drivers that they can resume operations */
+	pr_info("EEH: Notify device driver to resume\n");
 	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
 
 	return;
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 85025d7..0cd1c4a 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -853,11 +853,14 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 					phb->eeh_state |= PNV_EEH_STATE_REMOVED;
 				}
 
-				WARN(1, "EEH: dead IOC detected\n");
+				pr_err("EEH: dead IOC detected\n");
 				ret = 4;
 				goto out;
-			} else if (severity == OPAL_EEH_SEV_INF)
+			} else if (severity == OPAL_EEH_SEV_INF) {
+				pr_info("EEH: IOC informative error "
+					"detected\n");
 				ioda_eeh_hub_diag(hose);
+			}
 
 			break;
 		case OPAL_EEH_PHB_ERROR:
@@ -865,8 +868,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				if (ioda_eeh_get_phb_pe(hose, pe))
 					break;
 
-				WARN(1, "EEH: dead PHB#%x detected\n",
-				     hose->global_number);
+				pr_err("EEH: dead PHB#%x detected\n",
+					hose->global_number);
 				phb->eeh_state |= PNV_EEH_STATE_REMOVED;
 				ret = 3;
 				goto out;
@@ -874,20 +877,24 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				if (ioda_eeh_get_phb_pe(hose, pe))
 					break;
 
-				WARN(1, "EEH: fenced PHB#%x detected\n",
-				     hose->global_number);
+				pr_err("EEH: fenced PHB#%x detected\n",
+					hose->global_number);
 				ret = 2;
 				goto out;
-			} else if (severity == OPAL_EEH_SEV_INF)
+			} else if (severity == OPAL_EEH_SEV_INF) {
+				pr_info("EEH: PHB#%x informative error "
+					"detected\n",
+					hose->global_number);
 				ioda_eeh_phb_diag(hose);
+			}
 
 			break;
 		case OPAL_EEH_PE_ERROR:
 			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe))
 				break;
 
-			WARN(1, "EEH: Frozen PE#%x on PHB#%x detected\n",
-			     (*pe)->addr, (*pe)->phb->global_number);
+			pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
+				(*pe)->addr, (*pe)->phb->global_number);
 			ret = 1;
 			goto out;
 		}
-- 
1.7.5.4
