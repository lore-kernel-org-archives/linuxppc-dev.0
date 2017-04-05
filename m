Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vykLx2gYgzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 21:36:25 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v35BY3tD004407
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 07:36:16 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29mytgg37m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 07:36:15 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 5 Apr 2017 17:06:11 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v35Ba9EH18940036
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 17:06:09 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v35Ba7Ux010814
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 17:06:08 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v4] cxl: Force context lock during EEH flow
Date: Wed,  5 Apr 2017 17:05:53 +0530
Message-Id: <20170405113553.7354-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During an eeh event when the cxl card is fenced and card sysfs attr
perst_reloads_same_image is set following warning message is seen in the
kernel logs:

 [   60.622727] Adapter context unlocked with 0 active contexts
 [   60.622762] ------------[ cut here ]------------
 [   60.622771] WARNING: CPU: 12 PID: 627 at
 ../drivers/misc/cxl/main.c:325 cxl_adapter_context_unlock+0x60/0x80 [cxl]

Even though this warning is harmless, it clutters the kernel log
during an eeh event. This warning is triggered as the EEH callback
cxl_pci_error_detected doesn't obtain a context-lock before forcibly
detaching all active context and when context-lock is released during
call to cxl_configure_adapter from cxl_pci_slot_reset, a warning in
cxl_adapter_context_unlock is triggered.

To fix this warning, we acquire the adapter context-lock via
cxl_adapter_context_lock() in the eeh callback
cxl_pci_error_detected() once all the virtual AFU PHBs are notified
and their contexts detached. The context-lock is released in
cxl_pci_slot_reset() after the adapter is successfully reconfigured
and before we call slot_reset callback on slice attached device-drivers.

Cc: stable@vger.kernel.org
Fixes: 70b565bbdb91("cxl: Prevent adapter reset if an active context exists")
Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
Change-Log:

v3..v4
- Moved the call to context-unlock from cxl_pci_resume to
cxl_pci_slot_reset to let cxlflash module activate its master context
during slot reset. (Fred)

v2..v3
- As discussed with Fred removed function
cxl_adapter_context_force_lock() which may potentially expose the code
to deadlock in the future.
-  Other details of changes in cxl_pci_error_detected() to fix an
earlier issue of eeh callbacks not being passed on to all slices, is
being reworked as a separate patch.

v2..v1
- Moved the call to cxl_adapter_context_force_lock() from
cxl_pci_error_detected() to cxl_remove. (Fred)
---
 drivers/misc/cxl/pci.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index b27ea98..dd9a128 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1496,8 +1496,6 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
 	if ((rc = cxl_native_register_psl_err_irq(adapter)))
 		goto err;
 
-	/* Release the context lock as adapter is configured */
-	cxl_adapter_context_unlock(adapter);
 	return 0;
 
 err:
@@ -1596,6 +1594,9 @@ static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
 	if ((rc = cxl_sysfs_adapter_add(adapter)))
 		goto err_put1;
 
+	/* Release the context lock as adapter is configured */
+	cxl_adapter_context_unlock(adapter);
+
 	return adapter;
 
 err_put1:
@@ -1895,6 +1896,13 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 		cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
 		pci_deconfigure_afu(afu);
 	}
+
+	/* should take the context lock here */
+	if (cxl_adapter_context_lock(adapter) != 0)
+		dev_warn(&adapter->dev,
+			 "Couldn't take context lock with %d active-contexts\n",
+			 atomic_read(&adapter->contexts_num));
+
 	cxl_deconfigure_adapter(adapter);
 
 	return result;
@@ -1913,6 +1921,13 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
 	if (cxl_configure_adapter(adapter, pdev))
 		goto err;
 
+	/*
+	 * Unlock context activation for the adapter. Ideally this should be
+	 * done in cxl_pci_resume but cxlflash module tries to activate the
+	 * master context as part of slot_reset callback.
+	 */
+	cxl_adapter_context_unlock(adapter);
+
 	for (i = 0; i < adapter->slices; i++) {
 		afu = adapter->afu[i];
 
-- 
2.9.3
