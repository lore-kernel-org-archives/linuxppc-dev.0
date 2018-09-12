Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4293vj3CmrzF3FK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:45 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8C1MSst102344
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2meqxvt7e1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:43 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 12 Sep 2018 02:23:41 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8C1NbOB59834422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 01:23:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3577211C04A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:26 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FB0E11C052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:25 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:25 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B2C24A03AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:32 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/14] powerpc/eeh: Cleanup field names in eeh_rmv_data
Date: Wed, 12 Sep 2018 11:23:27 +1000
In-Reply-To: <cover.1536715396.git.sbobroff@linux.ibm.com>
References: <cover.1536715396.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <fd3beb5a120b1de7b639a23e343bb9f5995a82b7.1536715396.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change the name of the fields in eeh_rmv_data to clarify their usage.

Change "edev_list" to "removed_vf_list" because it does not contain
generic edevs, but rather only edevs that contain virtual functions
(which need to be removed during recovery).

Similarly, change "removed" to "removed_dev_count" because it is a
count of any removed devices, not just those in the above list.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7859af897058..ffe8293d1f06 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -35,8 +35,8 @@
 #include <asm/rtas.h>
 
 struct eeh_rmv_data {
-	struct list_head edev_list;
-	int removed;
+	struct list_head removed_vf_list;
+	int removed_dev_count;
 };
 
 static int eeh_result_priority(enum pci_ers_result result)
@@ -502,7 +502,6 @@ static void *eeh_rmv_device(struct eeh_dev *edev, void *userdata)
 	struct pci_driver *driver;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	struct eeh_rmv_data *rmv_data = (struct eeh_rmv_data *)userdata;
-	int *removed = rmv_data ? &rmv_data->removed : NULL;
 
 	/*
 	 * Actually, we should remove the PCI bridges as well.
@@ -524,7 +523,7 @@ static void *eeh_rmv_device(struct eeh_dev *edev, void *userdata)
 	if (eeh_dev_removed(edev))
 		return NULL;
 
-	if (removed) {
+	if (rmv_data) {
 		if (eeh_pe_passed(edev->pe))
 			return NULL;
 		driver = eeh_pcid_get(dev);
@@ -543,8 +542,8 @@ static void *eeh_rmv_device(struct eeh_dev *edev, void *userdata)
 	pr_debug("EEH: Removing %s without EEH sensitive driver\n",
 		 pci_name(dev));
 	edev->mode |= EEH_DEV_DISCONNECTED;
-	if (removed)
-		(*removed)++;
+	if (rmv_data)
+		rmv_data->removed_dev_count++;
 
 	if (edev->physfn) {
 #ifdef CONFIG_PCI_IOV
@@ -560,7 +559,7 @@ static void *eeh_rmv_device(struct eeh_dev *edev, void *userdata)
 		pdn->pe_number = IODA_INVALID_PE;
 #endif
 		if (rmv_data)
-			list_add(&edev->rmv_entry, &rmv_data->edev_list);
+			list_add(&edev->rmv_entry, &rmv_data->removed_vf_list);
 	} else {
 		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(dev);
@@ -729,7 +728,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	 * the device up before the scripts have taken it down,
 	 * potentially weird things happen.
 	 */
-	if (!driver_eeh_aware || rmv_data->removed) {
+	if (!driver_eeh_aware || rmv_data->removed_dev_count) {
 		pr_info("EEH: Sleep 5s ahead of %s hotplug\n",
 			(driver_eeh_aware ? "partial" : "complete"));
 		ssleep(5);
@@ -791,7 +790,8 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	struct eeh_pe *tmp_pe;
 	int rc = 0;
 	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
-	struct eeh_rmv_data rmv_data = {LIST_HEAD_INIT(rmv_data.edev_list), 0};
+	struct eeh_rmv_data rmv_data =
+		{LIST_HEAD_INIT(rmv_data.removed_vf_list), 0};
 
 	bus = eeh_pe_bus_get(pe);
 	if (!bus) {
@@ -934,7 +934,8 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	 * For those hot removed VFs, we should add back them after PF get
 	 * recovered properly.
 	 */
-	list_for_each_entry_safe(edev, tmp, &rmv_data.edev_list, rmv_entry) {
+	list_for_each_entry_safe(edev, tmp, &rmv_data.removed_vf_list,
+				 rmv_entry) {
 		eeh_add_virt_device(edev);
 		list_del(&edev->rmv_entry);
 	}
-- 
2.19.0.2.gcad72f5712
