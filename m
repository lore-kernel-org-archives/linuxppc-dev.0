Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4293vk0lBczF3FK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:45 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8C1IXjS127904
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:43 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2meqxv2f10-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:43 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 12 Sep 2018 02:23:41 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8C1NcQG20119802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 01:23:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 569F752050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:27 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B238C5204F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:26 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BFD7DA03B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:32 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/14] powerpc/eeh: Cleanup control flow in
 eeh_handle_normal_event()
Date: Wed, 12 Sep 2018 11:23:33 +1000
In-Reply-To: <cover.1536715396.git.sbobroff@linux.ibm.com>
References: <cover.1536715396.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <e1cb21f2fa4c9c6fc467412f8cb281c8bf280770.1536715396.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rather than mixing "if (state)" blocks and gotos, convert entirely to
"if (state)" blocks to make the state machine behaviour clearer.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 196 +++++++++++++++----------------
 1 file changed, 94 insertions(+), 102 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index e7f757cd839b..9446248eb6b8 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -808,10 +808,8 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		pr_err("EEH: PHB#%x-PE#%x has failed %d times in the last hour and has been permanently disabled.\n",
 		       pe->phb->global_number, pe->addr,
 		       pe->freeze_count);
-		goto hard_fail;
+		result = PCI_ERS_RESULT_DISCONNECT;
 	}
-	pr_warn("EEH: This PCI device has failed %d times in the last hour and will be permanently disabled after %d failures.\n",
-		pe->freeze_count, eeh_max_freezes);
 
 	/* Walk the various device drivers attached to this slot through
 	 * a reset sequence, giving each an opportunity to do what it needs
@@ -823,31 +821,39 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	 * the error. Override the result if necessary to have partially
 	 * hotplug for this case.
 	 */
-	pr_info("EEH: Notify device drivers to shutdown\n");
-	eeh_set_channel_state(pe, pci_channel_io_frozen);
-	eeh_set_irq_state(pe, false);
-	eeh_pe_report("error_detected(IO frozen)", pe, eeh_report_error,
-		      &result);
-	if ((pe->type & EEH_PE_PHB) &&
-	    result != PCI_ERS_RESULT_NONE &&
-	    result != PCI_ERS_RESULT_NEED_RESET)
-		result = PCI_ERS_RESULT_NEED_RESET;
+	if (result != PCI_ERS_RESULT_DISCONNECT) {
+		pr_warn("EEH: This PCI device has failed %d times in the last hour and will be permanently disabled after %d failures.\n",
+			pe->freeze_count, eeh_max_freezes);
+		pr_info("EEH: Notify device drivers to shutdown\n");
+		eeh_set_channel_state(pe, pci_channel_io_frozen);
+		eeh_set_irq_state(pe, false);
+		eeh_pe_report("error_detected(IO frozen)", pe,
+			      eeh_report_error, &result);
+		if ((pe->type & EEH_PE_PHB) &&
+		    result != PCI_ERS_RESULT_NONE &&
+		    result != PCI_ERS_RESULT_NEED_RESET)
+			result = PCI_ERS_RESULT_NEED_RESET;
+	}
 
 	/* Get the current PCI slot state. This can take a long time,
 	 * sometimes over 300 seconds for certain systems.
 	 */
-	rc = eeh_wait_state(pe, MAX_WAIT_FOR_RECOVERY*1000);
-	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
-		pr_warn("EEH: Permanent failure\n");
-		goto hard_fail;
+	if (result != PCI_ERS_RESULT_DISCONNECT) {
+		rc = eeh_wait_state(pe, MAX_WAIT_FOR_RECOVERY*1000);
+		if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
+			pr_warn("EEH: Permanent failure\n");
+			result = PCI_ERS_RESULT_DISCONNECT;
+		}
 	}
 
 	/* Since rtas may enable MMIO when posting the error log,
 	 * don't post the error log until after all dev drivers
 	 * have been informed.
 	 */
-	pr_info("EEH: Collect temporary log\n");
-	eeh_slot_error_detail(pe, EEH_LOG_TEMP);
+	if (result != PCI_ERS_RESULT_DISCONNECT) {
+		pr_info("EEH: Collect temporary log\n");
+		eeh_slot_error_detail(pe, EEH_LOG_TEMP);
+	}
 
 	/* If all device drivers were EEH-unaware, then shut
 	 * down all of the device drivers, and hope they
@@ -859,7 +865,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		if (rc) {
 			pr_warn("%s: Unable to reset, err=%d\n",
 				__func__, rc);
-			goto hard_fail;
+			result = PCI_ERS_RESULT_DISCONNECT;
 		}
 	}
 
@@ -868,9 +874,9 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		pr_info("EEH: Enable I/O for affected devices\n");
 		rc = eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
 
-		if (rc < 0)
-			goto hard_fail;
-		if (rc) {
+		if (rc < 0) {
+			result = PCI_ERS_RESULT_DISCONNECT;
+		} else if (rc) {
 			result = PCI_ERS_RESULT_NEED_RESET;
 		} else {
 			pr_info("EEH: Notify device drivers to resume I/O\n");
@@ -884,9 +890,9 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		pr_info("EEH: Enabled DMA for affected devices\n");
 		rc = eeh_pci_enable(pe, EEH_OPT_THAW_DMA);
 
-		if (rc < 0)
-			goto hard_fail;
-		if (rc) {
+		if (rc < 0) {
+			result = PCI_ERS_RESULT_DISCONNECT;
+		} else if (rc) {
 			result = PCI_ERS_RESULT_NEED_RESET;
 		} else {
 			/*
@@ -899,12 +905,6 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		}
 	}
 
-	/* If any device has a hard failure, then shut off everything. */
-	if (result == PCI_ERS_RESULT_DISCONNECT) {
-		pr_warn("EEH: Device driver gave up\n");
-		goto hard_fail;
-	}
-
 	/* If any device called out for a reset, then reset the slot */
 	if (result == PCI_ERS_RESULT_NEED_RESET) {
 		pr_info("EEH: Reset without hotplug activity\n");
@@ -912,89 +912,81 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		if (rc) {
 			pr_warn("%s: Cannot reset, err=%d\n",
 				__func__, rc);
-			goto hard_fail;
+			result = PCI_ERS_RESULT_DISCONNECT;
+		} else {
+			result = PCI_ERS_RESULT_NONE;
+			eeh_set_channel_state(pe, pci_channel_io_normal);
+			eeh_set_irq_state(pe, true);
+			eeh_pe_report("slot_reset", pe, eeh_report_reset,
+				      &result);
 		}
-
-		pr_info("EEH: Notify device drivers "
-			"the completion of reset\n");
-		result = PCI_ERS_RESULT_NONE;
-		eeh_set_channel_state(pe, pci_channel_io_normal);
-		eeh_set_irq_state(pe, true);
-		eeh_pe_report("slot_reset", pe, eeh_report_reset, &result);
 	}
 
-	/* All devices should claim they have recovered by now. */
-	if ((result != PCI_ERS_RESULT_RECOVERED) &&
-	    (result != PCI_ERS_RESULT_NONE)) {
-		pr_warn("EEH: Not recovered\n");
-		goto hard_fail;
-	}
-
-	/*
-	 * For those hot removed VFs, we should add back them after PF get
-	 * recovered properly.
-	 */
-	list_for_each_entry_safe(edev, tmp, &rmv_data.removed_vf_list,
-				 rmv_entry) {
-		eeh_add_virt_device(edev);
-		list_del(&edev->rmv_entry);
-	}
-
-	/* Tell all device drivers that they can resume operations */
-	pr_info("EEH: Notify device driver to resume\n");
-	eeh_set_channel_state(pe, pci_channel_io_normal);
-	eeh_set_irq_state(pe, true);
-	eeh_pe_report("resume", pe, eeh_report_resume, NULL);
-	eeh_for_each_pe(pe, tmp_pe) {
-		eeh_pe_for_each_dev(tmp_pe, edev, tmp) {
-			edev->mode &= ~EEH_DEV_NO_HANDLER;
-			edev->in_error = false;
+	if ((result == PCI_ERS_RESULT_RECOVERED) ||
+	    (result == PCI_ERS_RESULT_NONE)) {
+		/*
+		 * For those hot removed VFs, we should add back them after PF
+		 * get recovered properly.
+		 */
+		list_for_each_entry_safe(edev, tmp, &rmv_data.removed_vf_list,
+					 rmv_entry) {
+			eeh_add_virt_device(edev);
+			list_del(&edev->rmv_entry);
 		}
-	}
 
-	pr_info("EEH: Recovery successful.\n");
-	goto final;
+		/* Tell all device drivers that they can resume operations */
+		pr_info("EEH: Notify device driver to resume\n");
+		eeh_set_channel_state(pe, pci_channel_io_normal);
+		eeh_set_irq_state(pe, true);
+		eeh_pe_report("resume", pe, eeh_report_resume, NULL);
+		eeh_for_each_pe(pe, tmp_pe) {
+			eeh_pe_for_each_dev(tmp_pe, edev, tmp) {
+				edev->mode &= ~EEH_DEV_NO_HANDLER;
+				edev->in_error = false;
+			}
+		}
 
-hard_fail:
-	/*
-	 * About 90% of all real-life EEH failures in the field
-	 * are due to poorly seated PCI cards. Only 10% or so are
-	 * due to actual, failed cards.
-	 */
-	pr_err("EEH: Unable to recover from failure from PHB#%x-PE#%x.\n"
-	       "Please try reseating or replacing it\n",
-		pe->phb->global_number, pe->addr);
+		pr_info("EEH: Recovery successful.\n");
+	} else  {
+		/*
+		 * About 90% of all real-life EEH failures in the field
+		 * are due to poorly seated PCI cards. Only 10% or so are
+		 * due to actual, failed cards.
+		 */
+		pr_err("EEH: Unable to recover from failure from PHB#%x-PE#%x.\n"
+		       "Please try reseating or replacing it\n",
+			pe->phb->global_number, pe->addr);
 
-	eeh_slot_error_detail(pe, EEH_LOG_PERM);
+		eeh_slot_error_detail(pe, EEH_LOG_PERM);
 
-	/* Notify all devices that they're about to go down. */
-	eeh_set_channel_state(pe, pci_channel_io_perm_failure);
-	eeh_set_irq_state(pe, false);
-	eeh_pe_report("error_detected(permanent failure)", pe,
-		      eeh_report_failure, NULL);
+		/* Notify all devices that they're about to go down. */
+		eeh_set_channel_state(pe, pci_channel_io_perm_failure);
+		eeh_set_irq_state(pe, false);
+		eeh_pe_report("error_detected(permanent failure)", pe,
+			      eeh_report_failure, NULL);
 
-	/* Mark the PE to be removed permanently */
-	eeh_pe_state_mark(pe, EEH_PE_REMOVED);
+		/* Mark the PE to be removed permanently */
+		eeh_pe_state_mark(pe, EEH_PE_REMOVED);
 
-	/*
-	 * Shut down the device drivers for good. We mark
-	 * all removed devices correctly to avoid access
-	 * the their PCI config any more.
-	 */
-	if (pe->type & EEH_PE_VF) {
-		eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
-		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
-	} else {
-		eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
-		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
+		/*
+		 * Shut down the device drivers for good. We mark
+		 * all removed devices correctly to avoid access
+		 * the their PCI config any more.
+		 */
+		if (pe->type & EEH_PE_VF) {
+			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
+			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
+		} else {
+			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
+			eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
 
-		pci_lock_rescan_remove();
-		pci_hp_remove_devices(bus);
-		pci_unlock_rescan_remove();
-		/* The passed PE should no longer be used */
-		return;
+			pci_lock_rescan_remove();
+			pci_hp_remove_devices(bus);
+			pci_unlock_rescan_remove();
+			/* The passed PE should no longer be used */
+			return;
+		}
 	}
-final:
 	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
 }
 
-- 
2.19.0.2.gcad72f5712
