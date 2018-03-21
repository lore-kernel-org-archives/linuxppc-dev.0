Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405Y8C3bbwzF1dp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 13:06:51 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2L24KNM065020
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 22:06:49 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gu98ysnam-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 22:06:48 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 21 Mar 2018 02:06:46 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w2L26hpU65208322
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 02:06:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF5F8A404D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 01:59:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D15FA4055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 01:59:26 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 01:59:26 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 7BB2DA0271
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 13:06:41 +1100 (AEDT)
Date: Wed, 21 Mar 2018 13:06:40 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 8/9] powerpc/eeh: Factor out common code eeh_reset_device()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <557d0231968935f1212c7b500f39363a47cb6acc.1521427331.git.sam.bobroff@au1.ibm.com>
Message-Id: <168a19fad005f7f3dffe700978db75e7e976b946.1521523452.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The caller will always pass NULL for 'rmv_data' when
'eeh_aware_driver' is true, so the first two calls to
eeh_pe_dev_traverse() can be combined without changing behaviour as
can the two arms of the final 'if' block.

This should not change behaviour.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
====== v2 -> v3: ======
Corrected two missed cases of eeh_aware_driver -> driver_eeh_aware.

 arch/powerpc/kernel/eeh_driver.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 93fc22e791fa..43ceb6263cd8 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -647,16 +647,12 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	 * into pci_hp_add_devices().
 	 */
 	eeh_pe_state_mark(pe, EEH_PE_KEEP);
-	if (!driver_eeh_aware) {
-		if (pe->type & EEH_PE_VF) {
-			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
-		} else {
-			pci_lock_rescan_remove();
-			pci_hp_remove_devices(bus);
-			pci_unlock_rescan_remove();
-		}
-	} else {
+	if (driver_eeh_aware || (pe->type & EEH_PE_VF)) {
 		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
+	} else {
+		pci_lock_rescan_remove();
+		pci_hp_remove_devices(bus);
+		pci_unlock_rescan_remove();
 	}
 
 	/*
@@ -691,8 +687,9 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 	 * the device up before the scripts have taken it down,
 	 * potentially weird things happen.
 	 */
-	if (!driver_eeh_aware) {
-		pr_info("EEH: Sleep 5s ahead of complete hotplug\n");
+	if (!driver_eeh_aware || rmv_data->removed) {
+		pr_info("EEH: Sleep 5s ahead of %s hotplug\n",
+			(driver_eeh_aware ? "partial" : "complete"));
 		ssleep(5);
 
 		/*
@@ -705,19 +702,10 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
 		if (pe->type & EEH_PE_VF) {
 			eeh_add_virt_device(edev, NULL);
 		} else {
-			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
+			if (!driver_eeh_aware)
+				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 			pci_hp_add_devices(bus);
 		}
-	} else if (rmv_data->removed) {
-		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
-		ssleep(5);
-
-		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
-		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
-		if (pe->type & EEH_PE_VF)
-			eeh_add_virt_device(edev, NULL);
-		else
-			pci_hp_add_devices(bus);
 	}
 	eeh_pe_state_clear(pe, EEH_PE_KEEP);
 
-- 
2.16.1.74.g9b0b1f47b
