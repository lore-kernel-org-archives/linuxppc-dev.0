Return-Path: <clombard@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpSzy5CsrzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 23:05:18 +1000 (AEST)
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 14:05:14 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1257617D80AB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 14:05:49 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3ID52XT49545290
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 13:05:02 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3ID51Ut000312
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 09:05:01 -0400
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: Add a kernel thread to check the coherent platform
 function's state
Date: Mon, 18 Apr 2016 15:05:01 +0200
Message-Id: <1460984701-21490-1-git-send-email-clombard@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the POWERVM environement, the PHYP CoherentAccel component manages
the state of the Coherant Accelerator Processor Interface adapter and
virtualizes CAPI resources, handles CAPP, PSL, PSL Slice errors - and
interrupts - and provides a new set of HCALLs for the OS APIs to utilize
AFUs.

During the course of operation, a coherent platform function can
encounter errors. Some possible reason for errors are:
• Hardware recoverable and unrecoverable errors
• Transient and over-threshold correctable errors

PHYP implements its own state model for the coherent platform function.
The current state of this Acclerator Fonction Unit (AFU) is available
through a hcall.

In case of low-level troubles (or error injection), The PHYP component
may reset the card and change the AFU state. The PHYP interface doesn't
provide any way to be notified when that happens.

The current implementation of the cxl driver, for the POWERVM
environment, follows the general error recovery procedures required to
reset operation of the coherent platform function. The platform firmware
resets and reconfigures hardware when an external action is required -
attach/detach a process, link ok, ....

The purpose of this patch is to interact with the external driver
(where the AFU is shown) even if no action is required. A kernel thread
is needed to check every x seconds the current state of the AFU to see
if we need to enter an error recovery path.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h   |  3 +-
 drivers/misc/cxl/guest.c | 81 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 38e21cf..a26c210 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/pci.h>
 #include <linux/fs.h>
+#include <linux/kthread.h>
 #include <asm/cputable.h>
 #include <asm/mmu.h>
 #include <asm/reg.h>
@@ -379,7 +380,7 @@ struct cxl_afu_guest {
 	phys_addr_t p2n_phys;
 	u64 p2n_size;
 	int max_ints;
-	struct mutex recovery_lock;
+	struct task_struct *kthread_tsk;
 	int previous_state;
 };
 
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 8213372..06dfe7f 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -19,6 +19,10 @@
 #define CXL_SLOT_RESET_EVENT		2
 #define CXL_RESUME_EVENT		3
 
+#define CXL_KTHREAD 			"cxl_kthread"
+
+void stop_state_thread(struct cxl_afu *afu);
+
 static void pci_error_handlers(struct cxl_afu *afu,
 				int bus_error_event,
 				pci_channel_state_t state)
@@ -178,6 +182,9 @@ static int afu_read_error_state(struct cxl_afu *afu, int *state_out)
 	u64 state;
 	int rc = 0;
 
+	if (!afu)
+		return -EIO;
+
 	rc = cxl_h_read_error_state(afu->guest->handle, &state);
 	if (!rc) {
 		WARN_ON(state != H_STATE_NORMAL &&
@@ -645,6 +652,8 @@ static void guest_release_afu(struct device *dev)
 
 	idr_destroy(&afu->contexts_idr);
 
+	stop_state_thread(afu);
+
 	kfree(afu->guest);
 	kfree(afu);
 }
@@ -818,7 +827,6 @@ static int afu_update_state(struct cxl_afu *afu)
 	switch (cur_state) {
 	case H_STATE_NORMAL:
 		afu->guest->previous_state = cur_state;
-		rc = 1;
 		break;
 
 	case H_STATE_DISABLE:
@@ -834,7 +842,6 @@ static int afu_update_state(struct cxl_afu *afu)
 			pci_error_handlers(afu, CXL_SLOT_RESET_EVENT,
 					pci_channel_io_normal);
 			pci_error_handlers(afu, CXL_RESUME_EVENT, 0);
-			rc = 1;
 		}
 		afu->guest->previous_state = 0;
 		break;
@@ -859,39 +866,61 @@ static int afu_update_state(struct cxl_afu *afu)
 	return rc;
 }
 
-static int afu_do_recovery(struct cxl_afu *afu)
+static int handle_state_thread(void *data)
 {
-	int rc;
+	struct cxl_afu *afu;
+	int rc = 0;
 
-	/* many threads can arrive here, in case of detach_all for example.
-	 * Only one needs to drive the recovery
-	 */
-	if (mutex_trylock(&afu->guest->recovery_lock)) {
-		rc = afu_update_state(afu);
-		mutex_unlock(&afu->guest->recovery_lock);
-		return rc;
+	pr_devel("in %s\n", __func__);
+
+	afu = (struct cxl_afu*)data;
+	do {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (afu) {
+			afu_update_state(afu);
+			if (afu->guest->previous_state == H_STATE_PERM_UNAVAILABLE)
+				goto out;
+		} else
+			return -ENODEV;
+		schedule_timeout(msecs_to_jiffies(3000));
+	} while(!kthread_should_stop());
+
+out:
+	afu->guest->kthread_tsk = NULL;
+	return rc;
+}
+
+void start_state_thread(struct cxl_afu *afu)
+{
+	if (afu->guest->kthread_tsk)
+		return;
+
+	/* start kernel thread to handle the state of the afu */
+	afu->guest->kthread_tsk = kthread_run(&handle_state_thread,
+				  (void *)afu, CXL_KTHREAD);
+	if (IS_ERR(afu->guest->kthread_tsk)) {
+		pr_devel("cannot start state kthread\n");
+		afu->guest->kthread_tsk = NULL;
 	}
-	return 0;
+}
+
+void stop_state_thread(struct cxl_afu *afu)
+{
+	if (afu->guest->kthread_tsk)
+		kthread_stop(afu->guest->kthread_tsk);
 }
 
 static bool guest_link_ok(struct cxl *cxl, struct cxl_afu *afu)
 {
 	int state;
 
-	if (afu) {
-		if (afu_read_error_state(afu, &state) ||
-			state != H_STATE_NORMAL) {
-			if (afu_do_recovery(afu) > 0) {
-				/* check again in case we've just fixed it */
-				if (!afu_read_error_state(afu, &state) &&
-					state == H_STATE_NORMAL)
-					return true;
-			}
-			return false;
-		}
+	if (afu && (!afu_read_error_state(afu, &state))) {
+		if (state == H_STATE_NORMAL)
+			return true;
 	}
 
-	return true;
+	return false;
 }
 
 static int afu_properties_look_ok(struct cxl_afu *afu)
@@ -929,8 +958,6 @@ int cxl_guest_init_afu(struct cxl *adapter, int slice, struct device_node *afu_n
 		return -ENOMEM;
 	}
 
-	mutex_init(&afu->guest->recovery_lock);
-
 	if ((rc = dev_set_name(&afu->dev, "afu%i.%i",
 					  adapter->adapter_num,
 					  slice)))
@@ -986,6 +1013,8 @@ int cxl_guest_init_afu(struct cxl *adapter, int slice, struct device_node *afu_n
 
 	afu->enabled = true;
 
+	start_state_thread(afu);
+
 	if ((rc = cxl_pci_vphb_add(afu)))
 		dev_info(&afu->dev, "Can't register vPHB\n");
 
-- 
1.9.1
