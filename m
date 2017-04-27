Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD5DP0rqlzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 15:32:04 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3R5Sk2a134256
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 01:31:50 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a34vxjrs1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 01:31:50 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 27 Apr 2017 15:31:47 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3R5Vbmi62783708
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 15:31:45 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3R5VDei030410
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 15:31:13 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>, stable@vger.kernel.org
Subject: [PATCH-RESEND] cxl: Route eeh events to all drivers in
 cxl_pci_error_detected()
Date: Thu, 27 Apr 2017 10:58:22 +0530
Message-Id: <20170427052822.12666-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix a boundary condition where in some cases an eeh event that results
in card reset isn't passed on to a driver attached to the virtual PCI
device associated with a slice. This will happen in case when a slice
attached device driver returns a value other than
PCI_ERS_RESULT_NEED_RESET from the eeh error_detected() callback. This
would result in an early return from cxl_pci_error_detected() and
other drivers attached to other AFUs on the card wont be notified.

The patch fixes this by making sure that all slice attached
device-drivers are notified and the return values from
error_detected() callback are aggregated in a scheme where request for
'disconnect' trumps all and 'none' trumps 'need_reset'.

Cc: stable@vger.kernel.org
Fixes: 9e8df8a21963("cxl: EEH support")
Based-on: https://patchwork.ozlabs.org/patch/755799/
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

---
Change-log:

Resend
- Marked to stable tree and added acks.
---
 drivers/misc/cxl/pci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index dd9a128..f98d649 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1782,7 +1782,7 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 {
 	struct cxl *adapter = pci_get_drvdata(pdev);
 	struct cxl_afu *afu;
-	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
+	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET, afu_result;
 	int i;
 
 	/* At this point, we could still have an interrupt pending.
@@ -1886,15 +1886,18 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 	for (i = 0; i < adapter->slices; i++) {
 		afu = adapter->afu[i];
 
-		result = cxl_vphb_error_detected(afu, state);
-
-		/* Only continue if everyone agrees on NEED_RESET */
-		if (result != PCI_ERS_RESULT_NEED_RESET)
-			return result;
+		afu_result = cxl_vphb_error_detected(afu, state);
 
 		cxl_context_detach_all(afu);
 		cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
 		pci_deconfigure_afu(afu);
+
+		/* Disconnect trumps all, NONE trumps NEED_RESET */
+		if (afu_result == PCI_ERS_RESULT_DISCONNECT)
+			result = PCI_ERS_RESULT_DISCONNECT;
+		else if ((afu_result == PCI_ERS_RESULT_NONE) &&
+			 (result == PCI_ERS_RESULT_NEED_RESET))
+			result = PCI_ERS_RESULT_NONE;
 	}
 
 	/* should take the context lock here */
-- 
2.9.3
