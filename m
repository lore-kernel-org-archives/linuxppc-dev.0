Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8vbc4sZ0zDqCJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 23:06:36 +1000 (AEST)
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Wed, 18 May 2016 14:06:33 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 62014219006D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 14:06:04 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4ID6Tk958392660
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 13:06:29 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4ID6Sqx005329
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 07:06:29 -0600
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mrochs@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com, mpe@ellerman.id.au,
 imunsie@au1.ibm.com, mikey@neuling.org,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [RESEND v4,1/2] cxl: Add mechanism for delivering AFU driver
Date: Wed, 18 May 2016 15:06:21 +0200
Message-Id: <1463576781-19569-1-git-send-email-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This adds an afu_driver_ops structure with deliver_event callback. An
AFU driver such as cxlflash can fill this out and associate it with a
context to enable passing custom AFU specific events to userspace.

This also adds a new kernel API function cxl_context_pending_events(),
that the AFU driver can use to notify the cxl driver that new specific
events are ready to be delivered, and wake up anyone waiting on the
context wait queue.

The current count of AFU driver specific events is stored in the field
afu_driver_events of the context structure.

The cxl driver will check the afu_driver_events count during poll,
select, read, etc. calls to check if an AFU driver specific event is
pending, and will call deliver_event() to deliver that event. This way,
the cxl driver takes care of all the usual locking semantics around
these calls and handles all the generic cxl events, so that the AFU
driver only needs to worry about it's own events.

The deliver_event() call is passed a struct cxl_event buffer to fill in.
The header will already be filled in for an AFU driver event, and the
AFU driver is expected to expand the header.size as necessary (up to
max_size, defined by struct cxl_event_afu_driver_reserved) and fill out
it's own information.

Since AFU drivers provide their own means for userspace to obtain the
AFU file descriptor (i.e. cxlflash uses an ioctl on their scsi file
descriptor to obtain the AFU file descriptor) and the generic cxl driver
will never use this event, the ABI of the event is up to each individual
AFU driver.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
Changes since v3:
- Removed driver ops callback ctx_event_pending
- Created cxl function cxl_context_pending_events
- Created cxl function cxl_unset_driver_ops
- Added atomic event counter afu_driver_events

Changes since v2:
- Fixed some typos spotted by Matt Ochs

Changes since v1:
- Rebased on upstream
- Bumped cxl api version to 3
- Addressed comments from mpe:
  - Clarified commit message & some comments
  - Mentioned 'cxlflash' as a possible user of this event
  - Check driver ops on registration and warn if missing calls
  - Remove redundant checks where driver ops is used
  - Simplified ctx_event_pending and removed underscore version
  - Changed deliver_event to take the context as the first argument

 drivers/misc/cxl/Kconfig |  5 +++++
 drivers/misc/cxl/api.c   | 27 +++++++++++++++++++++++++++
 drivers/misc/cxl/cxl.h   |  6 +++++-
 drivers/misc/cxl/file.c  | 36 +++++++++++++++++++++++++-----------
 include/misc/cxl.h       | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/misc/cxl.h  | 22 ++++++++++++++++++++++
 6 files changed, 127 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
index 8756d06..560412c 100644
--- a/drivers/misc/cxl/Kconfig
+++ b/drivers/misc/cxl/Kconfig
@@ -15,12 +15,17 @@ config CXL_EEH
 	bool
 	default n
 
+config CXL_AFU_DRIVER_OPS
+	bool
+	default n
+
 config CXL
 	tristate "Support for IBM Coherent Accelerators (CXL)"
 	depends on PPC_POWERNV && PCI_MSI && EEH
 	select CXL_BASE
 	select CXL_KERNEL_API
 	select CXL_EEH
+	select CXL_AFU_DRIVER_OPS
 	default m
 	help
 	  Select this option to enable driver support for IBM Coherent
diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 2107c94..cd47f39 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -313,6 +313,33 @@ struct cxl_context *cxl_fops_get_context(struct file *file)
 }
 EXPORT_SYMBOL_GPL(cxl_fops_get_context);
 
+void cxl_set_driver_ops(struct cxl_context *ctx,
+			struct cxl_afu_driver_ops *ops)
+{
+	WARN_ON(!ops->deliver_event);
+	atomic_set(&ctx->afu_driver_events, 0);
+	ctx->afu_driver_ops = ops;
+}
+EXPORT_SYMBOL_GPL(cxl_set_driver_ops);
+
+int cxl_unset_driver_ops(struct cxl_context *ctx)
+{
+	if (atomic_read(&ctx->afu_driver_events))
+		return -EBUSY;
+
+	ctx->afu_driver_ops = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_unset_driver_ops);
+
+void cxl_context_events_pending(struct cxl_context *ctx,
+				unsigned int new_events)
+{
+	atomic_add(new_events, &ctx->afu_driver_events);
+	wake_up_all(&ctx->wq);
+}
+EXPORT_SYMBOL_GPL(cxl_context_events_pending);
+
 int cxl_start_work(struct cxl_context *ctx,
 		   struct cxl_ioctl_start_work *work)
 {
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 73dc2a3..b48828c 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -24,6 +24,7 @@
 #include <asm/reg.h>
 #include <misc/cxl-base.h>
 
+#include <misc/cxl.h>
 #include <uapi/misc/cxl.h>
 
 extern uint cxl_verbose;
@@ -34,7 +35,7 @@ extern uint cxl_verbose;
  * Bump version each time a user API change is made, whether it is
  * backwards compatible ot not.
  */
-#define CXL_API_VERSION 2
+#define CXL_API_VERSION 3
 #define CXL_API_VERSION_COMPATIBLE 1
 
 /*
@@ -528,6 +529,9 @@ struct cxl_context {
 	bool pending_fault;
 	bool pending_afu_err;
 
+	/* Used by AFU drivers for driver specific event delivery */
+	struct cxl_afu_driver_ops *afu_driver_ops;
+	atomic_t afu_driver_events;
 	struct rcu_head rcu;
 };
 
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index eec468f..6f19dcc 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -293,6 +293,17 @@ int afu_mmap(struct file *file, struct vm_area_struct *vm)
 	return cxl_context_iomap(ctx, vm);
 }
 
+static inline bool ctx_event_pending(struct cxl_context *ctx)
+{
+	if (ctx->pending_irq || ctx->pending_fault || ctx->pending_afu_err)
+		return true;
+
+	if (ctx->afu_driver_ops && atomic_read(&ctx->afu_driver_events))
+		return true;
+
+	return false;
+}
+
 unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
 {
 	struct cxl_context *ctx = file->private_data;
@@ -305,8 +316,7 @@ unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
 	pr_devel("afu_poll wait done pe: %i\n", ctx->pe);
 
 	spin_lock_irqsave(&ctx->lock, flags);
-	if (ctx->pending_irq || ctx->pending_fault ||
-	    ctx->pending_afu_err)
+	if (ctx_event_pending(ctx))
 		mask |= POLLIN | POLLRDNORM;
 	else if (ctx->status == CLOSED)
 		/* Only error on closed when there are no futher events pending
@@ -319,12 +329,6 @@ unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
 	return mask;
 }
 
-static inline int ctx_event_pending(struct cxl_context *ctx)
-{
-	return (ctx->pending_irq || ctx->pending_fault ||
-	    ctx->pending_afu_err || (ctx->status == CLOSED));
-}
-
 ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 			loff_t *off)
 {
@@ -344,7 +348,7 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 
 	for (;;) {
 		prepare_to_wait(&ctx->wq, &wait, TASK_INTERRUPTIBLE);
-		if (ctx_event_pending(ctx))
+		if (ctx_event_pending(ctx) || (ctx->status == CLOSED))
 			break;
 
 		if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu)) {
@@ -374,7 +378,14 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	memset(&event, 0, sizeof(event));
 	event.header.process_element = ctx->pe;
 	event.header.size = sizeof(struct cxl_event_header);
-	if (ctx->pending_irq) {
+	if (ctx->afu_driver_ops && atomic_read(&ctx->afu_driver_events)) {
+		pr_devel("afu_read delivering AFU driver specific event\n");
+		event.header.type = CXL_EVENT_AFU_DRIVER;
+		ctx->afu_driver_ops->deliver_event(ctx, &event, sizeof(event));
+		WARN_ON(event.header.size > sizeof(event));
+		atomic_dec(&ctx->afu_driver_events);
+
+	} else if (ctx->pending_irq) {
 		pr_devel("afu_read delivering AFU interrupt\n");
 		event.header.size += sizeof(struct cxl_event_afu_interrupt);
 		event.header.type = CXL_EVENT_AFU_INTERRUPT;
@@ -382,6 +393,7 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 		clear_bit(event.irq.irq - 1, ctx->irq_bitmap);
 		if (bitmap_empty(ctx->irq_bitmap, ctx->irq_count))
 			ctx->pending_irq = false;
+
 	} else if (ctx->pending_fault) {
 		pr_devel("afu_read delivering data storage fault\n");
 		event.header.size += sizeof(struct cxl_event_data_storage);
@@ -389,12 +401,14 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 		event.fault.addr = ctx->fault_addr;
 		event.fault.dsisr = ctx->fault_dsisr;
 		ctx->pending_fault = false;
+
 	} else if (ctx->pending_afu_err) {
 		pr_devel("afu_read delivering afu error\n");
 		event.header.size += sizeof(struct cxl_event_afu_error);
 		event.header.type = CXL_EVENT_AFU_ERROR;
 		event.afu_error.error = ctx->afu_err;
 		ctx->pending_afu_err = false;
+
 	} else if (ctx->status == CLOSED) {
 		pr_devel("afu_read fatal error\n");
 		spin_unlock_irqrestore(&ctx->lock, flags);
@@ -558,7 +572,7 @@ int __init cxl_file_init(void)
 	 * If these change we really need to update API.  Either change some
 	 * flags or update API version number CXL_API_VERSION.
 	 */
-	BUILD_BUG_ON(CXL_API_VERSION != 2);
+	BUILD_BUG_ON(CXL_API_VERSION != 3);
 	BUILD_BUG_ON(sizeof(struct cxl_ioctl_start_work) != 64);
 	BUILD_BUG_ON(sizeof(struct cxl_event_header) != 8);
 	BUILD_BUG_ON(sizeof(struct cxl_event_afu_interrupt) != 8);
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index 7d5e261..8a7677e2 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -212,4 +212,47 @@ void cxl_perst_reloads_same_image(struct cxl_afu *afu,
  */
 ssize_t cxl_read_adapter_vpd(struct pci_dev *dev, void *buf, size_t count);
 
+/*
+ * AFU driver ops allows an AFU driver to create their own events to pass to
+ * userspace through the file descriptor as a simpler alternative to overriding
+ * the read() and poll() calls that works with the generic cxl events. These
+ * events are given priority over the generic cxl events, so they will be
+ * delivered first if multiple types of events are pending.
+ *
+ * The AFU driver must call cxl_context_events_pending() to notify the cxl
+ * driver that new events are ready to be delivered for a specific context.
+ * cxl_context_events_pending() will adjust the current count of AFU driver
+ * events for this context, and wake up anyone waiting on the context wait
+ * queue.
+ *
+ * The cxl driver will then call deliver_event() to fill out a cxl_event
+ * structure with the driver specific event. The header will already have the
+ * type and process_element fields filled in, and header.size will be set to
+ * sizeof(struct cxl_event_header). The AFU driver can extend that size up to
+ * max_size (if an afu driver requires more space, they should submit a patch
+ * increasing the size in the struct cxl_event_afu_driver_reserved definition).
+ *
+ * deliver_event() is called with a spin lock held, so it must not sleep.
+ */
+struct cxl_afu_driver_ops {
+	void (*deliver_event) (struct cxl_context *ctx,
+			       struct cxl_event *event, size_t max_size);
+};
+
+/*
+ * Associate the above driver ops with a specific context.
+ * Reset the current count of AFU driver events.
+ */
+void cxl_set_driver_ops(struct cxl_context *ctx,
+			struct cxl_afu_driver_ops *ops);
+/*
+ * Remove the driver ops from a specific context.
+ * The current count of AFU driver events must be 0.
+ */
+int cxl_unset_driver_ops(struct cxl_context *ctx);
+
+/* Notify cxl driver that new events are ready to be delivered for context */
+void cxl_context_events_pending(struct cxl_context *ctx,
+				unsigned int new_events);
+
 #endif /* _MISC_CXL_H */
diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
index 8cd334f..5485eb1 100644
--- a/include/uapi/misc/cxl.h
+++ b/include/uapi/misc/cxl.h
@@ -93,6 +93,7 @@ enum cxl_event_type {
 	CXL_EVENT_AFU_INTERRUPT = 1,
 	CXL_EVENT_DATA_STORAGE  = 2,
 	CXL_EVENT_AFU_ERROR     = 3,
+	CXL_EVENT_AFU_DRIVER    = 4,
 };
 
 struct cxl_event_header {
@@ -124,12 +125,33 @@ struct cxl_event_afu_error {
 	__u64 error;
 };
 
+struct cxl_event_afu_driver_reserved {
+	/*
+	 * Reserves space for AFU driver specific events. Not actually
+	 * reserving any more space compared to other events as we can't know
+	 * how much an AFU driver will need (but it is likely to be small). If
+	 * your AFU driver needs more than this, please submit a patch
+	 * increasing it as part of your driver submission.
+	 *
+	 * This is not ABI since the event header.size passed to the user for
+	 * existing events is set in the read call to sizeof(cxl_event_header)
+	 * + sizeof(whatever event is being dispatched) and will not increase
+	 * just because this is, and the user is already required to use a 4K
+	 * buffer on the read call. This is merely the size of the buffer
+	 * passed between the cxl and AFU drivers.
+	 *
+	 * Of course the contents will be ABI, but that's up the AFU driver.
+	 */
+	__u64 reserved[4];
+};
+
 struct cxl_event {
 	struct cxl_event_header header;
 	union {
 		struct cxl_event_afu_interrupt irq;
 		struct cxl_event_data_storage fault;
 		struct cxl_event_afu_error afu_error;
+		struct cxl_event_afu_driver_reserved afu_driver_event;
 	};
 };
 
-- 
2.1.0
