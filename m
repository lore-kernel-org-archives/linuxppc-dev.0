Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sWWC2Dm7zF1bQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:51 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P34LtW058436
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:49 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j641qn6qj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:49 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 25 May 2018 04:11:46 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w4P3BiuQ6947112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:11:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5542D42042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:02:23 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0E904203F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:02:22 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:02:22 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 73B2EA03B1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:40 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/13] powerpc/eeh: Introduce eeh_set_irq_state()
Date: Fri, 25 May 2018 13:11:38 +1000
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
Message-Id: <60c873d67450a1f213f6307ffdc98b28bdc2be0f.1527217866.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To ease future refactoring, extract calls to eeh_enable_irq() and
eeh_disable_irq() from the various report functions. This makes
the report functions initial sequences more similar, as well as making
the IRQ changes visible when reading eeh_handle_normal_event().

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
====== v1 -> v2: ======
* Reorganised eeh_set_irq_state() to reduce nesting depth.

 arch/powerpc/kernel/eeh_driver.c | 52 ++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 76951ca701b2..8dd2a33424a1 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -118,22 +118,20 @@ static inline void eeh_pcid_put(struct pci_dev *pdev)
  * do real work because EEH should freeze DMA transfers for those PCI
  * devices encountering EEH errors, which includes MSI or MSI-X.
  */
-static void eeh_disable_irq(struct pci_dev *dev)
+static void eeh_disable_irq(struct eeh_dev *edev)
 {
-	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
-
 	/* Don't disable MSI and MSI-X interrupts. They are
 	 * effectively disabled by the DMA Stopped state
 	 * when an EEH error occurs.
 	 */
-	if (dev->msi_enabled || dev->msix_enabled)
+	if (edev->pdev->msi_enabled || edev->pdev->msix_enabled)
 		return;
 
-	if (!irq_has_action(dev->irq))
+	if (!irq_has_action(edev->pdev->irq))
 		return;
 
 	edev->mode |= EEH_DEV_IRQ_DISABLED;
-	disable_irq_nosync(dev->irq);
+	disable_irq_nosync(edev->pdev->irq);
 }
 
 /**
@@ -143,10 +141,8 @@ static void eeh_disable_irq(struct pci_dev *dev)
  * This routine must be called to enable interrupt while failed
  * device could be resumed.
  */
-static void eeh_enable_irq(struct pci_dev *dev)
+static void eeh_enable_irq(struct eeh_dev *edev)
 {
-	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
-
 	if ((edev->mode) & EEH_DEV_IRQ_DISABLED) {
 		edev->mode &= ~EEH_DEV_IRQ_DISABLED;
 		/*
@@ -169,8 +165,8 @@ static void eeh_enable_irq(struct pci_dev *dev)
 		 *
 		 *	tglx
 		 */
-		if (irqd_irq_disabled(irq_get_irq_data(dev->irq)))
-			enable_irq(dev->irq);
+		if (irqd_irq_disabled(irq_get_irq_data(edev->pdev->irq)))
+			enable_irq(edev->pdev->irq);
 	}
 }
 
@@ -210,6 +206,29 @@ static void eeh_set_channel_state(struct eeh_pe *root, enum pci_channel_state s)
 				edev->pdev->error_state = s;
 }
 
+static void eeh_set_irq_state(struct eeh_pe *root, bool enable)
+{
+	struct eeh_pe *pe;
+	struct eeh_dev *edev, *tmp;
+
+	eeh_for_each_pe(root, pe) {
+		eeh_pe_for_each_dev(pe, edev, tmp) {
+			if (!eeh_edev_actionable(edev))
+				continue;
+
+			if (!eeh_pcid_get(edev->pdev))
+				continue;
+
+			if (enable)
+				eeh_enable_irq(edev);
+			else
+				eeh_disable_irq(edev);
+
+			eeh_pcid_put(edev->pdev);
+		}
+	}
+}
+
 /**
  * eeh_report_error - Report pci error to each device driver
  * @data: eeh device
@@ -233,8 +252,6 @@ static void *eeh_report_error(struct eeh_dev *edev, void *userdata)
 	driver = eeh_pcid_get(dev);
 	if (!driver) goto out_no_dev;
 
-	eeh_disable_irq(dev);
-
 	if (!driver->err_handler ||
 	    !driver->err_handler->error_detected)
 		goto out;
@@ -315,8 +332,6 @@ static void *eeh_report_reset(struct eeh_dev *edev, void *userdata)
 	driver = eeh_pcid_get(dev);
 	if (!driver) goto out_no_dev;
 
-	eeh_enable_irq(dev);
-
 	if (!driver->err_handler ||
 	    !driver->err_handler->slot_reset ||
 	    (edev->mode & EEH_DEV_NO_HANDLER) ||
@@ -386,7 +401,6 @@ static void *eeh_report_resume(struct eeh_dev *edev, void *userdata)
 
 	was_in_error = edev->in_error;
 	edev->in_error = false;
-	eeh_enable_irq(dev);
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->resume ||
@@ -431,8 +445,6 @@ static void *eeh_report_failure(struct eeh_dev *edev, void *userdata)
 	driver = eeh_pcid_get(dev);
 	if (!driver) goto out_no_dev;
 
-	eeh_disable_irq(dev);
-
 	if (!driver->err_handler ||
 	    !driver->err_handler->error_detected)
 		goto out;
@@ -804,6 +816,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	 */
 	pr_info("EEH: Notify device drivers to shutdown\n");
 	eeh_set_channel_state(pe, pci_channel_io_frozen);
+	eeh_set_irq_state(pe, false);
 	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
 	if ((pe->type & EEH_PE_PHB) &&
 	    result != PCI_ERS_RESULT_NONE &&
@@ -895,6 +908,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 			"the completion of reset\n");
 		result = PCI_ERS_RESULT_NONE;
 		eeh_set_channel_state(pe, pci_channel_io_normal);
+		eeh_set_irq_state(pe, true);
 		eeh_pe_dev_traverse(pe, eeh_report_reset, &result);
 	}
 
@@ -917,6 +931,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	/* Tell all device drivers that they can resume operations */
 	pr_info("EEH: Notify device driver to resume\n");
 	eeh_set_channel_state(pe, pci_channel_io_normal);
+	eeh_set_irq_state(pe, true);
 	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
 
 	pr_info("EEH: Recovery successful.\n");
@@ -936,6 +951,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 
 	/* Notify all devices that they're about to go down. */
 	eeh_set_channel_state(pe, pci_channel_io_perm_failure);
+	eeh_set_irq_state(pe, false);
 	eeh_pe_dev_traverse(pe, eeh_report_failure, NULL);
 
 	/* Mark the PE to be removed permanently */
-- 
2.16.1.74.g9b0b1f47b
