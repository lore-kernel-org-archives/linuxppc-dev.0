Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sWWB74hmzF1TN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:50 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P34HON031854
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:48 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j69k8hj0p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:48 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 25 May 2018 04:11:46 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w4P3BiuI6881776
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:11:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 169474C052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:03:22 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 726BA4C046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:03:21 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:03:21 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 71D7EA03B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:40 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 10/13] powerpc/eeh: Introduce eeh_set_channel_state()
Date: Fri, 25 May 2018 13:11:37 +1000
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
Message-Id: <2fe070522029f8e3f30d59813ceed4bc1be08eb9.1527217866.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To ease future refactoring, extract setting of the channel state
from the report functions out into their own functions. This increases
the amount of code that is identical across all of the report
functions.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 30898866418b..76951ca701b2 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -199,6 +199,17 @@ static void *eeh_dev_save_state(struct eeh_dev *edev, void *userdata)
 	return NULL;
 }
 
+static void eeh_set_channel_state(struct eeh_pe *root, enum pci_channel_state s)
+{
+	struct eeh_pe *pe;
+	struct eeh_dev *edev, *tmp;
+
+	eeh_for_each_pe(root, pe)
+		eeh_pe_for_each_dev(pe, edev, tmp)
+			if (eeh_edev_actionable(edev))
+				edev->pdev->error_state = s;
+}
+
 /**
  * eeh_report_error - Report pci error to each device driver
  * @data: eeh device
@@ -218,7 +229,6 @@ static void *eeh_report_error(struct eeh_dev *edev, void *userdata)
 		return NULL;
 
 	device_lock(&dev->dev);
-	dev->error_state = pci_channel_io_frozen;
 
 	driver = eeh_pcid_get(dev);
 	if (!driver) goto out_no_dev;
@@ -301,7 +311,6 @@ static void *eeh_report_reset(struct eeh_dev *edev, void *userdata)
 		return NULL;
 
 	device_lock(&dev->dev);
-	dev->error_state = pci_channel_io_normal;
 
 	driver = eeh_pcid_get(dev);
 	if (!driver) goto out_no_dev;
@@ -371,7 +380,6 @@ static void *eeh_report_resume(struct eeh_dev *edev, void *userdata)
 		return NULL;
 
 	device_lock(&dev->dev);
-	dev->error_state = pci_channel_io_normal;
 
 	driver = eeh_pcid_get(dev);
 	if (!driver) goto out_no_dev;
@@ -795,6 +803,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	 * hotplug for this case.
 	 */
 	pr_info("EEH: Notify device drivers to shutdown\n");
+	eeh_set_channel_state(pe, pci_channel_io_frozen);
 	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
 	if ((pe->type & EEH_PE_PHB) &&
 	    result != PCI_ERS_RESULT_NONE &&
@@ -885,6 +894,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 		pr_info("EEH: Notify device drivers "
 			"the completion of reset\n");
 		result = PCI_ERS_RESULT_NONE;
+		eeh_set_channel_state(pe, pci_channel_io_normal);
 		eeh_pe_dev_traverse(pe, eeh_report_reset, &result);
 	}
 
@@ -906,6 +916,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 
 	/* Tell all device drivers that they can resume operations */
 	pr_info("EEH: Notify device driver to resume\n");
+	eeh_set_channel_state(pe, pci_channel_io_normal);
 	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
 
 	pr_info("EEH: Recovery successful.\n");
@@ -924,6 +935,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	eeh_slot_error_detail(pe, EEH_LOG_PERM);
 
 	/* Notify all devices that they're about to go down. */
+	eeh_set_channel_state(pe, pci_channel_io_perm_failure);
 	eeh_pe_dev_traverse(pe, eeh_report_failure, NULL);
 
 	/* Mark the PE to be removed permanently */
@@ -1033,6 +1045,7 @@ void eeh_handle_special_event(void)
 
 				/* Notify all devices to be down */
 				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
+				eeh_set_channel_state(pe, pci_channel_io_perm_failure);
 				eeh_pe_dev_traverse(pe,
 					eeh_report_failure, NULL);
 				bus = eeh_pe_bus_get(phb_pe);
-- 
2.16.1.74.g9b0b1f47b
