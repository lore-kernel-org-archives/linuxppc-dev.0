Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vF75G4QNzzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 17:59:14 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v136rfep177368
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Feb 2017 01:59:12 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28c8yw0nck-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Feb 2017 01:59:11 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 3 Feb 2017 16:59:07 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ED2502CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 17:59:02 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v136wsI225821414
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Feb 2017 17:59:02 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v136wUp9005024
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Feb 2017 17:58:30 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, frederic.barrat@fr.ibm.com,
 Andrew Donnellan <andonnel@au1.ibm.com>, Ian Munsie <ianmunsi@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] cxl: Force context lock during EEH flow
Date: Fri,  3 Feb 2017 12:27:39 +0530
Message-Id: <20170203065739.3052-1-vaibhav@linux.vnet.ibm.com>
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

To fix this warning and also prevent activation of any context during
eeh the patch introduces a new function cxl_adapter_context_force_lock
that would forcefully acquire the context_lock and warn if any active
contexts exists when this happens. After the EEH flow concludes with
call to cxl_pci_resume the context-lock is released with a call to
cxl_adapter_context_unlock.

Cc: stable@vger.kernel.org
Fixes: 70b565bbdb91("cxl: Prevent adapter reset if an active context exists")
Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/cxl.h  |  3 +++
 drivers/misc/cxl/main.c | 10 ++++++++++
 drivers/misc/cxl/pci.c  | 18 ++++++++++++++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index b24d767..34d2ca0 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -970,4 +970,7 @@ int cxl_adapter_context_lock(struct cxl *adapter);
 /* Unlock the contexts-lock if taken. Warn and force unlock otherwise */
 void cxl_adapter_context_unlock(struct cxl *adapter);
 
+/* Force contexts-lock to be taken */
+void cxl_adapter_context_force_lock(struct cxl *adapter);
+
 #endif
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index 62e0dfb..1754a0c 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -301,6 +301,16 @@ void cxl_adapter_context_put(struct cxl *adapter)
 	atomic_dec_if_positive(&adapter->contexts_num);
 }
 
+void cxl_adapter_context_force_lock(struct cxl *adapter)
+{
+	int count = atomic_read(&adapter->contexts_num);
+
+	if (count > 0)
+		pr_warn("Forcing context lock with %d active contexts\n",
+			count);
+	atomic_set(&adapter->contexts_num, -1);
+}
+
 int cxl_adapter_context_lock(struct cxl *adapter)
 {
 	int rc;
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 80a87ab..d76fd4d 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1487,8 +1487,6 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
 	if ((rc = cxl_native_register_psl_err_irq(adapter)))
 		goto err;
 
-	/* Release the context lock as adapter is configured */
-	cxl_adapter_context_unlock(adapter);
 	return 0;
 
 err:
@@ -1587,6 +1585,9 @@ static struct cxl *cxl_pci_init_adapter(struct pci_dev *dev)
 	if ((rc = cxl_sysfs_adapter_add(adapter)))
 		goto err_put1;
 
+	/* Release the context lock as adapter is configured */
+	cxl_adapter_context_unlock(adapter);
+
 	return adapter;
 
 err_put1:
@@ -1607,6 +1608,9 @@ static void cxl_pci_remove_adapter(struct cxl *adapter)
 {
 	pr_devel("cxl_remove_adapter\n");
 
+	/* Forcibly take the adapter context lock */
+	cxl_adapter_context_force_lock(adapter);
+
 	cxl_sysfs_adapter_remove(adapter);
 	cxl_debugfs_adapter_remove(adapter);
 
@@ -1778,6 +1782,9 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 	 */
 	schedule();
 
+	/* forcibly take the context lock to prevent new context activation */
+	cxl_adapter_context_force_lock(adapter);
+
 	/* If we're permanently dead, give up. */
 	if (state == pci_channel_io_perm_failure) {
 		/* Tell the AFU drivers; but we don't care what they
@@ -1879,11 +1886,15 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 		/* Only continue if everyone agrees on NEED_RESET */
 		if (result != PCI_ERS_RESULT_NEED_RESET)
 			return result;
+	}
 
+	for (i = 0; i < adapter->slices; i++) {
+		afu = adapter->afu[i];
 		cxl_context_detach_all(afu);
 		cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
 		pci_deconfigure_afu(afu);
 	}
+
 	cxl_deconfigure_adapter(adapter);
 
 	return result;
@@ -1979,6 +1990,9 @@ static void cxl_pci_resume(struct pci_dev *pdev)
 				afu_dev->driver->err_handler->resume(afu_dev);
 		}
 	}
+
+	/* Unlock context activation for the adapter */
+	cxl_adapter_context_unlock(adapter);
 }
 
 static const struct pci_error_handlers cxl_err_handler = {
-- 
2.9.3
