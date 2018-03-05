Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwH2S4HcvzF1D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 10:59:44 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w25NxYnO132910
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 18:59:42 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ghft4gd17-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 18:59:41 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Mon, 5 Mar 2018 23:59:40 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w25NxaDs57475280
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 23:59:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0460411C04C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:52:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DD7211C04A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:52:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:52:23 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 9B68BA01E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 10:59:34 +1100 (AEDT)
Date: Tue, 6 Mar 2018 10:59:33 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/9] powerpc/eeh: Clarify arguments to eeh_reset_device()
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
Message-Id: <c9191611543d221d5f003fad4a68dd5f86839404.1520294174.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is currently difficult to understand the behaviour of
eeh_reset_device() due to the way it's parameters are used. In
particular, when 'bus' is NULL, it's value is still necessary so the
same value is looked up again locally under a different name
('frozen_bus') but behaviour is changed.

To clarify this, add a new parameter 'eeh_aware_driver', and have the
caller set it when it would have passed NULL for 'bus' and always pass
a value for 'bus'. Then change any test that was on 'bus' to one on
'!eeh_aware_driver' and replace uses of 'frozen_bus' with 'bus'.

Also update the function's comment.

This should not change behaviour.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index cb584d72b0a5..6c3577133223 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -619,17 +619,19 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
 
 /**
  * eeh_reset_device - Perform actual reset of a pci slot
+ * @eeh_aware_driver: Does the device's driver provide EEH support?
  * @pe: EEH PE
  * @bus: PCI bus corresponding to the isolcated slot
+ * @rmv_data: Optional, list to record removed devices
  *
  * This routine must be called to do reset on the indicated PE.
  * During the reset, udev might be invoked because those affected
  * PCI devices will be removed and then added.
  */
-static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
-				struct eeh_rmv_data *rmv_data)
+static int eeh_reset_device(bool eeh_aware_driver,
+			    struct eeh_pe *pe, struct pci_bus *bus,
+			    struct eeh_rmv_data *rmv_data)
 {
-	struct pci_bus *frozen_bus = eeh_pe_bus_get(pe);
 	time64_t tstamp;
 	int cnt, rc;
 	struct eeh_dev *edev;
@@ -645,7 +647,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	 * into pci_hp_add_devices().
 	 */
 	eeh_pe_state_mark(pe, EEH_PE_KEEP);
-	if (bus) {
+	if (!eeh_aware_driver) {
 		if (pe->type & EEH_PE_VF) {
 			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
 		} else {
@@ -653,7 +655,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 			pci_hp_remove_devices(bus);
 			pci_unlock_rescan_remove();
 		}
-	} else if (frozen_bus) {
+	} else if (bus) {
 		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
 	}
 
@@ -689,7 +691,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	 * the device up before the scripts have taken it down,
 	 * potentially weird things happen.
 	 */
-	if (bus) {
+	if (!eeh_aware_driver) {
 		pr_info("EEH: Sleep 5s ahead of complete hotplug\n");
 		ssleep(5);
 
@@ -706,7 +708,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 			pci_hp_add_devices(bus);
 		}
-	} else if (frozen_bus && rmv_data->removed) {
+	} else if (bus && rmv_data->removed) {
 		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
 		ssleep(5);
 
@@ -715,7 +717,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 		if (pe->type & EEH_PE_VF)
 			eeh_add_virt_device(edev, NULL);
 		else
-			pci_hp_add_devices(frozen_bus);
+			pci_hp_add_devices(bus);
 	}
 	eeh_pe_state_clear(pe, EEH_PE_KEEP);
 
@@ -820,7 +822,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	 */
 	if (result == PCI_ERS_RESULT_NONE) {
 		pr_info("EEH: Reset with hotplug activity\n");
-		rc = eeh_reset_device(pe, bus, NULL);
+		rc = eeh_reset_device(false, pe, bus, NULL);
 		if (rc) {
 			pr_warn("%s: Unable to reset, err=%d\n",
 				__func__, rc);
@@ -872,7 +874,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	/* If any device called out for a reset, then reset the slot */
 	if (result == PCI_ERS_RESULT_NEED_RESET) {
 		pr_info("EEH: Reset without hotplug activity\n");
-		rc = eeh_reset_device(pe, NULL, &rmv_data);
+		rc = eeh_reset_device(true, pe, bus, &rmv_data);
 		if (rc) {
 			pr_warn("%s: Cannot reset, err=%d\n",
 				__func__, rc);
-- 
2.16.1.74.g9b0b1f47b
