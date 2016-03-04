Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFFD31A0B99
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 22:27:10 +1100 (AEDT)
Received: from localhost
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 11:27:07 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2AF7A2190023
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:26:48 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24BR4X41507600
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:27:04 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24BR4Ge007699
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 04:27:04 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 17/20] cxl: Adapter failure handling
Date: Fri,  4 Mar 2016 12:26:41 +0100
Message-Id: <1457090804-9719-18-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Lombard <clombard@linux.vnet.ibm.com>

Check the AFU state whenever an API is called. The hypervisor may
issue a reset of the adapter when it detects a fault. When it happens,
it launches an error recovery which will either move the AFU to a
permanent failure state, or in the disabled state.
If the AFU is found to be disabled, detach all existing contexts from
it before issuing a AFU reset to re-enable it.

Before detaching contexts, notify any kernel driver through the EEH
callbacks of the AFU pci device.

Co-authored-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/context.c |   2 +-
 drivers/misc/cxl/cxl.h     |  18 ++---
 drivers/misc/cxl/file.c    |  10 +--
 drivers/misc/cxl/guest.c   | 167 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/misc/cxl/main.c    |   2 +-
 drivers/misc/cxl/native.c  |  32 ++++-----
 drivers/misc/cxl/vphb.c    |   2 +-
 7 files changed, 198 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 180c85a..10370f2 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -220,7 +220,7 @@ int __detach_context(struct cxl_context *ctx)
 	 * If detach fails when hw is down, we don't care.
 	 */
 	WARN_ON(cxl_ops->detach_process(ctx) &&
-		cxl_ops->link_ok(ctx->afu->adapter));
+		cxl_ops->link_ok(ctx->afu->adapter, ctx->afu));
 	flush_work(&ctx->fault_work); /* Only needed for dedicated process */
 
 	/* release the reference to the group leader and mm handling pid */
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index b388c97..e345860 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -379,6 +379,8 @@ struct cxl_afu_guest {
 	phys_addr_t p2n_phys;
 	u64 p2n_size;
 	int max_ints;
+	struct mutex recovery_lock;
+	int previous_state;
 };
 
 struct cxl_afu {
@@ -617,7 +619,7 @@ struct cxl_process_element {
 	__be32 software_state;
 } __packed;
 
-static inline bool cxl_adapter_link_ok(struct cxl *cxl)
+static inline bool cxl_adapter_link_ok(struct cxl *cxl, struct cxl_afu *afu)
 {
 	struct pci_dev *pdev;
 
@@ -636,13 +638,13 @@ static inline void __iomem *_cxl_p1_addr(struct cxl *cxl, cxl_p1_reg_t reg)
 
 static inline void cxl_p1_write(struct cxl *cxl, cxl_p1_reg_t reg, u64 val)
 {
-	if (likely(cxl_adapter_link_ok(cxl)))
+	if (likely(cxl_adapter_link_ok(cxl, NULL)))
 		out_be64(_cxl_p1_addr(cxl, reg), val);
 }
 
 static inline u64 cxl_p1_read(struct cxl *cxl, cxl_p1_reg_t reg)
 {
-	if (likely(cxl_adapter_link_ok(cxl)))
+	if (likely(cxl_adapter_link_ok(cxl, NULL)))
 		return in_be64(_cxl_p1_addr(cxl, reg));
 	else
 		return ~0ULL;
@@ -656,13 +658,13 @@ static inline void __iomem *_cxl_p1n_addr(struct cxl_afu *afu, cxl_p1n_reg_t reg
 
 static inline void cxl_p1n_write(struct cxl_afu *afu, cxl_p1n_reg_t reg, u64 val)
 {
-	if (likely(cxl_adapter_link_ok(afu->adapter)))
+	if (likely(cxl_adapter_link_ok(afu->adapter, afu)))
 		out_be64(_cxl_p1n_addr(afu, reg), val);
 }
 
 static inline u64 cxl_p1n_read(struct cxl_afu *afu, cxl_p1n_reg_t reg)
 {
-	if (likely(cxl_adapter_link_ok(afu->adapter)))
+	if (likely(cxl_adapter_link_ok(afu->adapter, afu)))
 		return in_be64(_cxl_p1n_addr(afu, reg));
 	else
 		return ~0ULL;
@@ -675,13 +677,13 @@ static inline void __iomem *_cxl_p2n_addr(struct cxl_afu *afu, cxl_p2n_reg_t reg
 
 static inline void cxl_p2n_write(struct cxl_afu *afu, cxl_p2n_reg_t reg, u64 val)
 {
-	if (likely(cxl_adapter_link_ok(afu->adapter)))
+	if (likely(cxl_adapter_link_ok(afu->adapter, afu)))
 		out_be64(_cxl_p2n_addr(afu, reg), val);
 }
 
 static inline u64 cxl_p2n_read(struct cxl_afu *afu, cxl_p2n_reg_t reg)
 {
-	if (likely(cxl_adapter_link_ok(afu->adapter)))
+	if (likely(cxl_adapter_link_ok(afu->adapter, afu)))
 		return in_be64(_cxl_p2n_addr(afu, reg));
 	else
 		return ~0ULL;
@@ -857,7 +859,7 @@ struct cxl_backend_ops {
 			u64 wed, u64 amr);
 	int (*detach_process)(struct cxl_context *ctx);
 	bool (*support_attributes)(const char *attr_name, enum cxl_attrs type);
-	bool (*link_ok)(struct cxl *cxl);
+	bool (*link_ok)(struct cxl *cxl, struct cxl_afu *afu);
 	void (*release_afu)(struct device *dev);
 	ssize_t (*afu_read_err_buffer)(struct cxl_afu *afu, char *buf,
 				loff_t off, size_t count);
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index e160462..eec468f 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -76,7 +76,7 @@ static int __afu_open(struct inode *inode, struct file *file, bool master)
 	if (!afu->current_mode)
 		goto err_put_afu;
 
-	if (!cxl_ops->link_ok(adapter)) {
+	if (!cxl_ops->link_ok(adapter, afu)) {
 		rc = -EIO;
 		goto err_put_afu;
 	}
@@ -257,7 +257,7 @@ long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (ctx->status == CLOSED)
 		return -EIO;
 
-	if (!cxl_ops->link_ok(ctx->afu->adapter))
+	if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu))
 		return -EIO;
 
 	pr_devel("afu_ioctl\n");
@@ -287,7 +287,7 @@ int afu_mmap(struct file *file, struct vm_area_struct *vm)
 	if (ctx->status != STARTED)
 		return -EIO;
 
-	if (!cxl_ops->link_ok(ctx->afu->adapter))
+	if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu))
 		return -EIO;
 
 	return cxl_context_iomap(ctx, vm);
@@ -334,7 +334,7 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	int rc;
 	DEFINE_WAIT(wait);
 
-	if (!cxl_ops->link_ok(ctx->afu->adapter))
+	if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu))
 		return -EIO;
 
 	if (count < CXL_READ_MIN_SIZE)
@@ -347,7 +347,7 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 		if (ctx_event_pending(ctx))
 			break;
 
-		if (!cxl_ops->link_ok(ctx->afu->adapter)) {
+		if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu)) {
 			rc = -EIO;
 			goto out;
 		}
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 4326d66..de03b25 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -15,6 +15,46 @@
 #include "hcalls.h"
 #include "trace.h"
 
+#define CXL_ERROR_DETECTED_EVENT	1
+#define CXL_SLOT_RESET_EVENT		2
+#define CXL_RESUME_EVENT		3
+
+static void pci_error_handlers(struct cxl_afu *afu,
+				int bus_error_event,
+				pci_channel_state_t state)
+{
+	struct pci_dev *afu_dev;
+
+	if (afu->phb == NULL)
+		return;
+
+	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
+		if (!afu_dev->driver)
+			continue;
+
+		switch (bus_error_event) {
+		case CXL_ERROR_DETECTED_EVENT:
+			afu_dev->error_state = state;
+
+			if (afu_dev->driver->err_handler &&
+			    afu_dev->driver->err_handler->error_detected)
+				afu_dev->driver->err_handler->error_detected(afu_dev, state);
+		break;
+		case CXL_SLOT_RESET_EVENT:
+			afu_dev->error_state = state;
+
+			if (afu_dev->driver->err_handler &&
+			    afu_dev->driver->err_handler->slot_reset)
+				afu_dev->driver->err_handler->slot_reset(afu_dev);
+		break;
+		case CXL_RESUME_EVENT:
+			if (afu_dev->driver->err_handler &&
+			    afu_dev->driver->err_handler->resume)
+				afu_dev->driver->err_handler->resume(afu_dev);
+		break;
+		}
+	}
+}
 
 static irqreturn_t guest_handle_psl_slice_error(struct cxl_context *ctx, u64 dsisr,
 					u64 errstat)
@@ -133,6 +173,22 @@ static irqreturn_t guest_psl_irq(int irq, void *data)
 	return rc;
 }
 
+static int afu_read_error_state(struct cxl_afu *afu, int *state_out)
+{
+	u64 state;
+	int rc = 0;
+
+	rc = cxl_h_read_error_state(afu->guest->handle, &state);
+	if (!rc) {
+		WARN_ON(state != H_STATE_NORMAL &&
+			state != H_STATE_DISABLE &&
+			state != H_STATE_TEMP_UNAVAILABLE &&
+			state != H_STATE_PERM_UNAVAILABLE);
+		*state_out = state & 0xffffffff;
+	}
+	return rc;
+}
+
 static irqreturn_t guest_slice_irq_err(int irq, void *data)
 {
 	struct cxl_afu *afu = data;
@@ -201,10 +257,26 @@ static int irq_free_range(struct cxl *adapter, int irq, int len)
 
 static int guest_reset(struct cxl *adapter)
 {
-	int rc;
+	struct cxl_afu *afu = NULL;
+	int i, rc;
 
 	pr_devel("Adapter reset request\n");
+	for (i = 0; i < adapter->slices; i++) {
+		if ((afu = adapter->afu[i])) {
+			pci_error_handlers(afu, CXL_ERROR_DETECTED_EVENT,
+					pci_channel_io_frozen);
+			cxl_context_detach_all(afu);
+		}
+	}
+
 	rc = cxl_h_reset_adapter(adapter->guest->handle);
+	for (i = 0; i < adapter->slices; i++) {
+		if (!rc && (afu = adapter->afu[i])) {
+			pci_error_handlers(afu, CXL_SLOT_RESET_EVENT,
+					pci_channel_io_normal);
+			pci_error_handlers(afu, CXL_RESUME_EVENT, 0);
+		}
+	}
 	return rc;
 }
 
@@ -556,7 +628,7 @@ static int guest_detach_process(struct cxl_context *ctx)
 	pr_devel("in %s\n", __func__);
 	trace_cxl_detach(ctx);
 
-	if (!cxl_ops->link_ok(ctx->afu->adapter))
+	if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu))
 		return -EIO;
 
 	if (ctx->afu->current_mode == CXL_MODE_DIRECTED)
@@ -730,8 +802,95 @@ static void guest_unmap_slice_regs(struct cxl_afu *afu)
 		iounmap(afu->p2n_mmio);
 }
 
-static bool guest_link_ok(struct cxl *cxl)
+static int afu_update_state(struct cxl_afu *afu)
 {
+	int rc, cur_state;
+
+	rc = afu_read_error_state(afu, &cur_state);
+	if (rc)
+		return rc;
+
+	if (afu->guest->previous_state == cur_state)
+		return 0;
+
+	pr_devel("AFU(%d) update state to %#x\n", afu->slice, cur_state);
+
+	switch (cur_state) {
+	case H_STATE_NORMAL:
+		afu->guest->previous_state = cur_state;
+		rc = 1;
+		break;
+
+	case H_STATE_DISABLE:
+		pci_error_handlers(afu, CXL_ERROR_DETECTED_EVENT,
+				pci_channel_io_frozen);
+
+		cxl_context_detach_all(afu);
+		if ((rc = cxl_ops->afu_reset(afu)))
+			pr_devel("reset hcall failed %d\n", rc);
+
+		rc = afu_read_error_state(afu, &cur_state);
+		if (!rc && cur_state == H_STATE_NORMAL) {
+			pci_error_handlers(afu, CXL_SLOT_RESET_EVENT,
+					pci_channel_io_normal);
+			pci_error_handlers(afu, CXL_RESUME_EVENT, 0);
+			rc = 1;
+		}
+		afu->guest->previous_state = 0;
+		break;
+
+	case H_STATE_TEMP_UNAVAILABLE:
+		afu->guest->previous_state = cur_state;
+		break;
+
+	case H_STATE_PERM_UNAVAILABLE:
+		dev_err(&afu->dev, "AFU is in permanent error state\n");
+		pci_error_handlers(afu, CXL_ERROR_DETECTED_EVENT,
+				pci_channel_io_perm_failure);
+		afu->guest->previous_state = cur_state;
+		break;
+
+	default:
+		pr_err("Unexpected AFU(%d) error state: %#x\n",
+		       afu->slice, cur_state);
+		return -EINVAL;
+	}
+
+	return rc;
+}
+
+static int afu_do_recovery(struct cxl_afu *afu)
+{
+	int rc;
+
+	/* many threads can arrive here, in case of detach_all for example.
+	 * Only one needs to drive the recovery
+	 */
+	if (mutex_trylock(&afu->guest->recovery_lock)) {
+		rc = afu_update_state(afu);
+		mutex_unlock(&afu->guest->recovery_lock);
+		return rc;
+	}
+	return 0;
+}
+
+static bool guest_link_ok(struct cxl *cxl, struct cxl_afu *afu)
+{
+	int state;
+
+	if (afu) {
+		if (afu_read_error_state(afu, &state) ||
+			state != H_STATE_NORMAL) {
+			if (afu_do_recovery(afu) > 0) {
+				/* check again in case we've just fixed it */
+				if (!afu_read_error_state(afu, &state) &&
+					state == H_STATE_NORMAL)
+					return true;
+			}
+			return false;
+		}
+	}
+
 	return true;
 }
 
@@ -770,6 +929,8 @@ int cxl_guest_init_afu(struct cxl *adapter, int slice, struct device_node *afu_n
 		return -ENOMEM;
 	}
 
+	mutex_init(&afu->guest->recovery_lock);
+
 	if ((rc = dev_set_name(&afu->dev, "afu%i.%i",
 					  adapter->adapter_num,
 					  slice)))
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index b3c3ebf..b5eeb71 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -48,7 +48,7 @@ int cxl_afu_slbia(struct cxl_afu *afu)
 		/* If the adapter has gone down, we can assume that we
 		 * will PERST it and that will invalidate everything.
 		 */
-		if (!cxl_ops->link_ok(afu->adapter))
+		if (!cxl_ops->link_ok(afu->adapter, afu))
 			return -EIO;
 		cpu_relax();
 	}
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index e564ae6..387fcbd 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -42,7 +42,7 @@ static int afu_control(struct cxl_afu *afu, u64 command,
 			goto out;
 		}
 
-		if (!cxl_ops->link_ok(afu->adapter)) {
+		if (!cxl_ops->link_ok(afu->adapter, afu)) {
 			afu->enabled = enabled;
 			rc = -EIO;
 			goto out;
@@ -92,7 +92,7 @@ static int native_afu_reset(struct cxl_afu *afu)
 
 static int native_afu_check_and_enable(struct cxl_afu *afu)
 {
-	if (!cxl_ops->link_ok(afu->adapter)) {
+	if (!cxl_ops->link_ok(afu->adapter, afu)) {
 		WARN(1, "Refusing to enable afu while link down!\n");
 		return -EIO;
 	}
@@ -114,7 +114,7 @@ int cxl_psl_purge(struct cxl_afu *afu)
 
 	pr_devel("PSL purge request\n");
 
-	if (!cxl_ops->link_ok(afu->adapter)) {
+	if (!cxl_ops->link_ok(afu->adapter, afu)) {
 		dev_warn(&afu->dev, "PSL Purge called with link down, ignoring\n");
 		rc = -EIO;
 		goto out;
@@ -136,7 +136,7 @@ int cxl_psl_purge(struct cxl_afu *afu)
 			rc = -EBUSY;
 			goto out;
 		}
-		if (!cxl_ops->link_ok(afu->adapter)) {
+		if (!cxl_ops->link_ok(afu->adapter, afu)) {
 			rc = -EIO;
 			goto out;
 		}
@@ -250,7 +250,7 @@ int cxl_tlb_slb_invalidate(struct cxl *adapter)
 			dev_warn(&adapter->dev, "WARNING: CXL adapter wide TLBIA timed out!\n");
 			return -EBUSY;
 		}
-		if (!cxl_ops->link_ok(adapter))
+		if (!cxl_ops->link_ok(adapter, NULL))
 			return -EIO;
 		cpu_relax();
 	}
@@ -261,7 +261,7 @@ int cxl_tlb_slb_invalidate(struct cxl *adapter)
 			dev_warn(&adapter->dev, "WARNING: CXL adapter wide SLBIA timed out!\n");
 			return -EBUSY;
 		}
-		if (!cxl_ops->link_ok(adapter))
+		if (!cxl_ops->link_ok(adapter, NULL))
 			return -EIO;
 		cpu_relax();
 	}
@@ -302,7 +302,7 @@ static void slb_invalid(struct cxl_context *ctx)
 	cxl_p1_write(adapter, CXL_PSL_SLBIA, CXL_TLB_SLB_IQ_LPIDPID);
 
 	while (1) {
-		if (!cxl_ops->link_ok(adapter))
+		if (!cxl_ops->link_ok(adapter, NULL))
 			break;
 		slbia = cxl_p1_read(adapter, CXL_PSL_SLBIA);
 		if (!(slbia & CXL_TLB_SLB_P))
@@ -333,7 +333,7 @@ static int do_process_element_cmd(struct cxl_context *ctx,
 			rc = -EBUSY;
 			goto out;
 		}
-		if (!cxl_ops->link_ok(ctx->afu->adapter)) {
+		if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu)) {
 			dev_warn(&ctx->afu->dev, "WARNING: Device link down, aborting Process Element Command!\n");
 			rc = -EIO;
 			goto out;
@@ -389,7 +389,7 @@ static int terminate_process_element(struct cxl_context *ctx)
 	 * should always succeed: it's not running if the hw has gone
 	 * away and is being reset.
 	 */
-	if (cxl_ops->link_ok(ctx->afu->adapter))
+	if (cxl_ops->link_ok(ctx->afu->adapter, ctx->afu))
 		rc = do_process_element_cmd(ctx, CXL_SPA_SW_CMD_TERMINATE,
 					    CXL_PE_SOFTWARE_STATE_V | CXL_PE_SOFTWARE_STATE_T);
 	ctx->elem->software_state = 0;	/* Remove Valid bit */
@@ -408,7 +408,7 @@ static int remove_process_element(struct cxl_context *ctx)
 	/* We could be asked to remove when the hw is down. Again, if
 	 * the hw is down, the PE is gone, so we succeed.
 	 */
-	if (cxl_ops->link_ok(ctx->afu->adapter))
+	if (cxl_ops->link_ok(ctx->afu->adapter, ctx->afu))
 		rc = do_process_element_cmd(ctx, CXL_SPA_SW_CMD_REMOVE, 0);
 
 	if (!rc)
@@ -650,7 +650,7 @@ static int native_afu_activate_mode(struct cxl_afu *afu, int mode)
 	if (!(mode & afu->modes_supported))
 		return -EINVAL;
 
-	if (!cxl_ops->link_ok(afu->adapter)) {
+	if (!cxl_ops->link_ok(afu->adapter, afu)) {
 		WARN(1, "Device link is down, refusing to activate!\n");
 		return -EIO;
 	}
@@ -666,7 +666,7 @@ static int native_afu_activate_mode(struct cxl_afu *afu, int mode)
 static int native_attach_process(struct cxl_context *ctx, bool kernel,
 				u64 wed, u64 amr)
 {
-	if (!cxl_ops->link_ok(ctx->afu->adapter)) {
+	if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu)) {
 		WARN(1, "Device link is down, refusing to attach process!\n");
 		return -EIO;
 	}
@@ -718,7 +718,7 @@ static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
 	/* If the adapter has gone away, we can't get any meaningful
 	 * information.
 	 */
-	if (!cxl_ops->link_ok(afu->adapter))
+	if (!cxl_ops->link_ok(afu->adapter, afu))
 		return -EIO;
 
 	info->dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
@@ -975,7 +975,7 @@ static bool native_support_attributes(const char *attr_name,
 
 static int native_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off, u64 *out)
 {
-	if (unlikely(!cxl_ops->link_ok(afu->adapter)))
+	if (unlikely(!cxl_ops->link_ok(afu->adapter, afu)))
 		return -EIO;
 	if (unlikely(off >= afu->crs_len))
 		return -ERANGE;
@@ -986,7 +986,7 @@ static int native_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off, u64 *out)
 
 static int native_afu_cr_read32(struct cxl_afu *afu, int cr, u64 off, u32 *out)
 {
-	if (unlikely(!cxl_ops->link_ok(afu->adapter)))
+	if (unlikely(!cxl_ops->link_ok(afu->adapter, afu)))
 		return -EIO;
 	if (unlikely(off >= afu->crs_len))
 		return -ERANGE;
@@ -1021,7 +1021,7 @@ static int native_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off, u8 *out)
 
 static int native_afu_cr_write32(struct cxl_afu *afu, int cr, u64 off, u32 in)
 {
-	if (unlikely(!cxl_ops->link_ok(afu->adapter)))
+	if (unlikely(!cxl_ops->link_ok(afu->adapter, afu)))
 		return -EIO;
 	if (unlikely(off >= afu->crs_len))
 		return -ERANGE;
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index c960a09..490b934 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -49,7 +49,7 @@ static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
 	phb = pci_bus_to_host(dev->bus);
 	afu = (struct cxl_afu *)phb->private_data;
 
-	if (!cxl_ops->link_ok(afu->adapter)) {
+	if (!cxl_ops->link_ok(afu->adapter, afu)) {
 		dev_warn(&dev->dev, "%s: Device link is down, refusing to enable AFU\n", __func__);
 		return false;
 	}
-- 
1.9.1
