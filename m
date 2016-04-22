Return-Path: <clombard@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrxYY0y1XzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:39:28 +1000 (AEST)
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Fri, 22 Apr 2016 14:39:25 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7225D1B08067
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 14:40:09 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3MDdOXg2294164
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 13:39:24 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3MDdNFe029975
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 09:39:24 -0400
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2] cxl: Check periodically the coherent platform function's
 state
Date: Fri, 22 Apr 2016 15:39:22 +0200
Message-Id: <1461332362-5309-1-git-send-email-clombard@linux.vnet.ibm.com>
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

In the PowerVM environment, the PHYP CoherentAccel component manages
the state of the Coherent Accelerator Processor Interface adapter and
virtualizes CAPI resources, handles CAPP, PSL, PSL Slice errors - and
interrupts - and provides a new set of hcalls for the OS APIs to utilize
Accelerator Function Unit (AFU).

During the course of operation, a coherent platform function can
encounter errors. Some possible reason for errors are:
• Hardware recoverable and unrecoverable errors
• Transient and over-threshold correctable errors

PHYP implements its own state model for the coherent platform function.
The state of the AFU is available through a hcall.

The current implementation of the cxl driver, for the PowerVM
environment, checks this state of the AFU only when an action is
requested - open a device, ioctl command, memory map, attach/detach a
process - from an external driver - cxlflash, libcxl. If an error is
detected the cxl driver handles the error according the content of the
Power Architecture Platform Requirements document.

But in case of low-level troubles (or error injection), the PHYP
component may reset the card and change the AFU state. The PHYP
interface doesn't provide any way to be notified when that happens thus
implies that the cxl driver:
• cannot handle immediatly the state change of the AFU.
• cannot notify other drivers (cxlflash, ...)

The purpose of this patch is to wake up the cpu periodically to check
the current state of each AFU and to see if we need to enter an error
recovery path.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
change from V1:
  * Improved comments.
  * Use a delayed queue work instead of our own kthread.
---
 drivers/misc/cxl/cxl.h   |  4 +++-
 drivers/misc/cxl/guest.c | 57 +++++++++++++++++++++++++-----------------------
 2 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 38e21cf..1586b21 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -375,11 +375,13 @@ struct cxl_afu_native {
 };
 
 struct cxl_afu_guest {
+	struct cxl_afu *parent;
 	u64 handle;
 	phys_addr_t p2n_phys;
 	u64 p2n_size;
 	int max_ints;
-	struct mutex recovery_lock;
+	bool handle_err;
+	struct delayed_work work_err;
 	int previous_state;
 };
 
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 8213372..39afbba 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -178,6 +178,9 @@ static int afu_read_error_state(struct cxl_afu *afu, int *state_out)
 	u64 state;
 	int rc = 0;
 
+	if (!afu)
+		return -EIO;
+
 	rc = cxl_h_read_error_state(afu->guest->handle, &state);
 	if (!rc) {
 		WARN_ON(state != H_STATE_NORMAL &&
@@ -818,7 +821,6 @@ static int afu_update_state(struct cxl_afu *afu)
 	switch (cur_state) {
 	case H_STATE_NORMAL:
 		afu->guest->previous_state = cur_state;
-		rc = 1;
 		break;
 
 	case H_STATE_DISABLE:
@@ -834,7 +836,6 @@ static int afu_update_state(struct cxl_afu *afu)
 			pci_error_handlers(afu, CXL_SLOT_RESET_EVENT,
 					pci_channel_io_normal);
 			pci_error_handlers(afu, CXL_RESUME_EVENT, 0);
-			rc = 1;
 		}
 		afu->guest->previous_state = 0;
 		break;
@@ -859,39 +860,30 @@ static int afu_update_state(struct cxl_afu *afu)
 	return rc;
 }
 
-static int afu_do_recovery(struct cxl_afu *afu)
+static void afu_handle_errstate(struct work_struct *work)
 {
-	int rc;
+	struct cxl_afu_guest *afu_guest =
+		container_of(to_delayed_work(work), struct cxl_afu_guest, work_err);
 
-	/* many threads can arrive here, in case of detach_all for example.
-	 * Only one needs to drive the recovery
-	 */
-	if (mutex_trylock(&afu->guest->recovery_lock)) {
-		rc = afu_update_state(afu);
-		mutex_unlock(&afu->guest->recovery_lock);
-		return rc;
-	}
-	return 0;
+	if (!afu_update_state(afu_guest->parent) &&
+	    afu_guest->previous_state == H_STATE_PERM_UNAVAILABLE)
+		return;
+
+	if (afu_guest->handle_err == true)
+		schedule_delayed_work(&afu_guest->work_err,
+				      msecs_to_jiffies(3000));
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
@@ -929,8 +921,6 @@ int cxl_guest_init_afu(struct cxl *adapter, int slice, struct device_node *afu_n
 		return -ENOMEM;
 	}
 
-	mutex_init(&afu->guest->recovery_lock);
-
 	if ((rc = dev_set_name(&afu->dev, "afu%i.%i",
 					  adapter->adapter_num,
 					  slice)))
@@ -986,6 +976,15 @@ int cxl_guest_init_afu(struct cxl *adapter, int slice, struct device_node *afu_n
 
 	afu->enabled = true;
 
+	/* 
+	 * wake up the cpu periodically to check the state
+	 * of the AFU using "afu" stored in the guest structure.
+	 */
+	afu->guest->parent = afu;
+	afu->guest->handle_err = true;
+	INIT_DELAYED_WORK(&afu->guest->work_err, afu_handle_errstate);
+	schedule_delayed_work(&afu->guest->work_err, msecs_to_jiffies(1000));
+
 	if ((rc = cxl_pci_vphb_add(afu)))
 		dev_info(&afu->dev, "Can't register vPHB\n");
 
@@ -1014,6 +1013,10 @@ void cxl_guest_remove_afu(struct cxl_afu *afu)
 	if (!afu)
 		return;
 
+	/* flush and stop pending job */
+	afu->guest->handle_err = false;
+	flush_delayed_work(&afu->guest->work_err);
+
 	cxl_pci_vphb_remove(afu);
 	cxl_sysfs_afu_remove(afu);
 
-- 
1.9.1
