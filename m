Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwH2p3HFWzF1Dt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 11:00:02 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w25NxY4F092318
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 19:00:00 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ghe9fkh64-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 18:59:59 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Mon, 5 Mar 2018 23:59:58 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w25Nxud71769750
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 23:59:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7B984203F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:52:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55B6442041
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:52:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:52:20 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C46C7A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 10:59:54 +1100 (AEDT)
Date: Tue, 6 Mar 2018 10:59:53 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/9] powerpc/eeh: Factor out common code eeh_reset_device()
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
Message-Id: <fe5673642328c2e11fee269bfc7987095311f25c.1520294174.git.sam.bobroff@au1.ibm.com>
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
 arch/powerpc/kernel/eeh_driver.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 1272f2c8cbd2..39d560e9f071 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -647,16 +647,12 @@ static int eeh_reset_device(bool eeh_aware_driver,
 	 * into pci_hp_add_devices().
 	 */
 	eeh_pe_state_mark(pe, EEH_PE_KEEP);
-	if (!eeh_aware_driver) {
-		if (pe->type & EEH_PE_VF) {
-			eeh_pe_dev_traverse(pe, eeh_rmv_device, NULL);
-		} else {
-			pci_lock_rescan_remove();
-			pci_hp_remove_devices(bus);
-			pci_unlock_rescan_remove();
-		}
-	} else {
+	if (eeh_aware_driver || (pe->type & EEH_PE_VF)) {
 		eeh_pe_dev_traverse(pe, eeh_rmv_device, rmv_data);
+	} else {
+		pci_lock_rescan_remove();
+		pci_hp_remove_devices(bus);
+		pci_unlock_rescan_remove();
 	}
 
 	/*
@@ -691,8 +687,9 @@ static int eeh_reset_device(bool eeh_aware_driver,
 	 * the device up before the scripts have taken it down,
 	 * potentially weird things happen.
 	 */
-	if (!eeh_aware_driver) {
-		pr_info("EEH: Sleep 5s ahead of complete hotplug\n");
+	if (!eeh_aware_driver || rmv_data->removed) {
+		pr_info("EEH: Sleep 5s ahead of %s hotplug\n",
+			(eeh_aware_driver ? "partial" : "complete"));
 		ssleep(5);
 
 		/*
@@ -700,24 +697,15 @@ static int eeh_reset_device(bool eeh_aware_driver,
 		 * PE. We should disconnect it so the binding can be
 		 * rebuilt when adding PCI devices.
 		 */
-		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
-		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
-		if (pe->type & EEH_PE_VF) {
-			eeh_add_virt_device(edev, NULL);
-		} else {
-			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
-			pci_hp_add_devices(bus);
-		}
-	} else if (rmv_data->removed) {
-		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
-		ssleep(5);
-
 		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
 		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
 		if (pe->type & EEH_PE_VF)
 			eeh_add_virt_device(edev, NULL);
-		else
+		else {
+			if (!eeh_aware_driver)
+				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS);
 			pci_hp_add_devices(bus);
+		}
 	}
 	eeh_pe_state_clear(pe, EEH_PE_KEEP);
 
-- 
2.16.1.74.g9b0b1f47b
