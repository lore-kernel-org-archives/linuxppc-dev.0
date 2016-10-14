Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swMxR2J5yzDt2s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 20:39:05 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9E9d0s8134745
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 05:39:03 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0b-001b2d01.pphosted.com with ESMTP id 262uqnkk9x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 05:39:02 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 14 Oct 2016 15:08:55 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7B789125805E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 15:09:25 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9E9crxI26149042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 15:08:53 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9E9cnDi030292
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 15:08:52 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 gkurz@linux.vnet.ibm.com, stable@vger.kernel.org
Subject: [RESEND] [PATCH v3] cxl: Prevent adapter reset if an active context
 exists
Date: Fri, 14 Oct 2016 15:08:36 +0530
Message-Id: <1476437916-31010-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch prevents resetting the cxl adapter via sysfs in presence of
one or more active cxl_context on it. This protects against an
unrecoverable error caused by PSL owning a dirty cache line even after
reset and host tries to touch the same cache line. In case a force reset
of the card is required irrespective of any active contexts, the int
value -1 can be stored in the 'reset' sysfs attribute of the card.

The patch introduces a new atomic_t member named contexts_num inside
struct cxl that holds the number of active context attached to the card
, which is checked against '0' before proceeding with the reset. To
prevent against a race condition where a context is activated just after
reset check is performed, the contexts_num is atomically set to '-1'
after reset-check to indicate that no more contexts can be activated on
the card anymore.

Before activating a context we atomically test if contexts_num is
non-negative and if so, increment its value by one. In case the value of
contexts_num is negative then it indicates that the card is about to be
reset and context activation is error-ed out at that point.

Cc: stable@vger.kernel.org
Fixes: 62fa19d4 ("cxl: Add ability to reset the card")
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
Changelog:

RESEND v3	* Marked the patch for stable and added sign-offs & Fixes tag

v3..v1 ->       * Context-lock is now taken earlier in cxl_start_context to
                  prevent against leaking ctx->pid in error path as pointed
                  out by Frederic Barrat.
                * Fixed tabs that sneaked their way into sysfs-class-cxl
                  changes. Thanks Andrew Donnellan for catching that.

v2..v1 ->       * Addressed following review comments from Frederic Barrat:
                - Spell error changing 'Incase' to 'In case'.
                - Changed the comment description for context_num member
                  to use a slightly more universal notation for integers.
                - Added cleanup code for context irqs in case context lock
                  is taken.
                - Added a new function called cxl_adapter_context_unlock
                  that sets context_num to '0' (forcibly if needed).
                - cxl adapter struct when allocated is initialized with
                  context lock taken and released when the card config is
                  complete.
                - Simplified code flow in function reset_adapter_store.

---
 Documentation/ABI/testing/sysfs-class-cxl |  7 ++++--
 drivers/misc/cxl/api.c                    |  9 +++++++
 drivers/misc/cxl/context.c                |  3 +++
 drivers/misc/cxl/cxl.h                    | 24 ++++++++++++++++++
 drivers/misc/cxl/file.c                   | 11 ++++++++
 drivers/misc/cxl/guest.c                  |  3 +++
 drivers/misc/cxl/main.c                   | 42 ++++++++++++++++++++++++++++++-
 drivers/misc/cxl/pci.c                    |  2 ++
 drivers/misc/cxl/sysfs.c                  | 27 +++++++++++++++++---
 9 files changed, 121 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 4ba0a2a..640f65e 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -220,8 +220,11 @@ What:           /sys/class/cxl/<card>/reset
 Date:           October 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    write only
-                Writing 1 will issue a PERST to card which may cause the card
-                to reload the FPGA depending on load_image_on_perst.
+                Writing 1 will issue a PERST to card provided there are no
+                contexts active on any one of the card AFUs. This may cause
+                the card to reload the FPGA depending on load_image_on_perst.
+                Writing -1 will do a force PERST irrespective of any active
+                contexts on the card AFUs.
 Users:		https://github.com/ibm-capi/libcxl
 
 What:		/sys/class/cxl/<card>/perst_reloads_same_image (not in a guest)
diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index f3d34b9..af23d7d 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -229,6 +229,14 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 	if (ctx->status == STARTED)
 		goto out; /* already started */
 
+	/*
+	 * Increment the mapped context count for adapter. This also checks
+	 * if adapter_context_lock is taken.
+	 */
+	rc = cxl_adapter_context_get(ctx->afu->adapter);
+	if (rc)
+		goto out;
+
 	if (task) {
 		ctx->pid = get_task_pid(task, PIDTYPE_PID);
 		ctx->glpid = get_task_pid(task->group_leader, PIDTYPE_PID);
@@ -240,6 +248,7 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 
 	if ((rc = cxl_ops->attach_process(ctx, kernel, wed, 0))) {
 		put_pid(ctx->pid);
+		cxl_adapter_context_put(ctx->afu->adapter);
 		cxl_ctx_put();
 		goto out;
 	}
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index c466ee2..5e506c1 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -238,6 +238,9 @@ int __detach_context(struct cxl_context *ctx)
 	put_pid(ctx->glpid);
 
 	cxl_ctx_put();
+
+	/* Decrease the attached context count on the adapter */
+	cxl_adapter_context_put(ctx->afu->adapter);
 	return 0;
 }
 
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 01d372a..a144073 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -618,6 +618,14 @@ struct cxl {
 	bool perst_select_user;
 	bool perst_same_image;
 	bool psl_timebase_synced;
+
+	/*
+	 * number of contexts mapped on to this card. Possible values are:
+	 * >0: Number of contexts mapped and new one can be mapped.
+	 *  0: No active contexts and new ones can be mapped.
+	 * -1: No contexts mapped and new ones cannot be mapped.
+	 */
+	atomic_t contexts_num;
 };
 
 int cxl_pci_alloc_one_irq(struct cxl *adapter);
@@ -944,4 +952,20 @@ bool cxl_pci_is_vphb_device(struct pci_dev *dev);
 
 /* decode AFU error bits in the PSL register PSL_SERR_An */
 void cxl_afu_decode_psl_serr(struct cxl_afu *afu, u64 serr);
+
+/*
+ * Increments the number of attached contexts on an adapter.
+ * In case an adapter_context_lock is taken the return -EBUSY.
+ */
+int cxl_adapter_context_get(struct cxl *adapter);
+
+/* Decrements the number of attached contexts on an adapter */
+void cxl_adapter_context_put(struct cxl *adapter);
+
+/* If no active contexts then prevents contexts from being attached */
+int cxl_adapter_context_lock(struct cxl *adapter);
+
+/* Unlock the contexts-lock if taken. Warn and force unlock otherwise */
+void cxl_adapter_context_unlock(struct cxl *adapter);
+
 #endif
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 5fb9894..d0b421f 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -205,11 +205,22 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	ctx->pid = get_task_pid(current, PIDTYPE_PID);
 	ctx->glpid = get_task_pid(current->group_leader, PIDTYPE_PID);
 
+	/*
+	 * Increment the mapped context count for adapter. This also checks
+	 * if adapter_context_lock is taken.
+	 */
+	rc = cxl_adapter_context_get(ctx->afu->adapter);
+	if (rc) {
+		afu_release_irqs(ctx, ctx);
+		goto out;
+	}
+
 	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
 
 	if ((rc = cxl_ops->attach_process(ctx, false, work.work_element_descriptor,
 							amr))) {
 		afu_release_irqs(ctx, ctx);
+		cxl_adapter_context_put(ctx->afu->adapter);
 		goto out;
 	}
 
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 9aa58a7..3e102cd 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -1152,6 +1152,9 @@ struct cxl *cxl_guest_init_adapter(struct device_node *np, struct platform_devic
 	if ((rc = cxl_sysfs_adapter_add(adapter)))
 		goto err_put1;
 
+	/* release the context lock as the adapter is configured */
+	cxl_adapter_context_unlock(adapter);
+
 	return adapter;
 
 err_put1:
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index d9be23b2..62e0dfb 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -243,8 +243,10 @@ struct cxl *cxl_alloc_adapter(void)
 	if (dev_set_name(&adapter->dev, "card%i", adapter->adapter_num))
 		goto err2;
 
-	return adapter;
+	/* start with context lock taken */
+	atomic_set(&adapter->contexts_num, -1);
 
+	return adapter;
 err2:
 	cxl_remove_adapter_nr(adapter);
 err1:
@@ -286,6 +288,44 @@ int cxl_afu_select_best_mode(struct cxl_afu *afu)
 	return 0;
 }
 
+int cxl_adapter_context_get(struct cxl *adapter)
+{
+	int rc;
+
+	rc = atomic_inc_unless_negative(&adapter->contexts_num);
+	return rc >= 0 ? 0 : -EBUSY;
+}
+
+void cxl_adapter_context_put(struct cxl *adapter)
+{
+	atomic_dec_if_positive(&adapter->contexts_num);
+}
+
+int cxl_adapter_context_lock(struct cxl *adapter)
+{
+	int rc;
+	/* no active contexts -> contexts_num == 0 */
+	rc = atomic_cmpxchg(&adapter->contexts_num, 0, -1);
+	return rc ? -EBUSY : 0;
+}
+
+void cxl_adapter_context_unlock(struct cxl *adapter)
+{
+	int val = atomic_cmpxchg(&adapter->contexts_num, -1, 0);
+
+	/*
+	 * contexts lock taken -> contexts_num == -1
+	 * If not true then show a warning and force reset the lock.
+	 * This will happen when context_unlock was requested without
+	 * doing a context_lock.
+	 */
+	if (val != -1) {
+		atomic_set(&adapter->contexts_num, 0);
+		WARN(1, "Adapter context unlocked with %d active contexts",
+		     val);
+	}
+}
+
 static int __init init_cxl(void)
 {
 	int rc = 0;
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 7afad84..e96be9c 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1487,6 +1487,8 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
 	if ((rc = cxl_native_register_psl_err_irq(adapter)))
 		goto err;
 
+	/* Release the context lock as adapter is configured */
+	cxl_adapter_context_unlock(adapter);
 	return 0;
 
 err:
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index b043c20..a8b6d6a 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -75,12 +75,31 @@ static ssize_t reset_adapter_store(struct device *device,
 	int val;
 
 	rc = sscanf(buf, "%i", &val);
-	if ((rc != 1) || (val != 1))
+	if ((rc != 1) || (val != 1 && val != -1))
 		return -EINVAL;
 
-	if ((rc = cxl_ops->adapter_reset(adapter)))
-		return rc;
-	return count;
+	/*
+	 * See if we can lock the context mapping that's only allowed
+	 * when there are no contexts attached to the adapter. Once
+	 * taken this will also prevent any context from getting activated.
+	 */
+	if (val == 1) {
+		rc =  cxl_adapter_context_lock(adapter);
+		if (rc)
+			goto out;
+
+		rc = cxl_ops->adapter_reset(adapter);
+		/* In case reset failed release context lock */
+		if (rc)
+			cxl_adapter_context_unlock(adapter);
+
+	} else if (val == -1) {
+		/* Perform a forced adapter reset */
+		rc = cxl_ops->adapter_reset(adapter);
+	}
+
+out:
+	return rc ? rc : count;
 }
 
 static ssize_t load_image_on_perst_show(struct device *device,
-- 
2.7.4
