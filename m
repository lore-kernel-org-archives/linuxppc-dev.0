Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 58A9C1A010A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 12:49:54 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2F5EF1402A8
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 12:49:54 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 8 Mar 2016 11:49:53 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8735D3578056
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 12:49:50 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u281ngeu1507784
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 12:49:50 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u281nIxY011397
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 12:49:18 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Matt Ochs <mrochs@us.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver specific
 events
Date: Tue,  8 Mar 2016 12:48:34 +1100
Message-Id: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This adds an afu_driver_ops structure with event_pending and
deliver_event callbacks. An AFU driver such as cxlflash can fill these
out and associate it with a context to enable passing custom AFU
specific events to userspace.

The cxl driver will call event_pending() during poll, select, read, etc.
calls to check if an AFU driver specific event is pending, and will call
deliver_event() to deliver that event. This way, the cxl driver takes
care of all the usual locking semantics around these calls and handles
all the generic cxl events, so that the AFU driver only needs to worry
about it's own events.

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

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---

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
 drivers/misc/cxl/api.c   |  8 ++++++++
 drivers/misc/cxl/cxl.h   |  6 +++++-
 drivers/misc/cxl/file.c  | 36 +++++++++++++++++++++++++-----------
 include/misc/cxl.h       | 29 +++++++++++++++++++++++++++++
 include/uapi/misc/cxl.h  | 22 ++++++++++++++++++++++
 6 files changed, 94 insertions(+), 12 deletions(-)

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
index ea3eeb7..eebc9c3 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -296,6 +296,14 @@ struct cxl_context *cxl_fops_get_context(struct file *file)
 }
 EXPORT_SYMBOL_GPL(cxl_fops_get_context);
 
+void cxl_set_driver_ops(struct cxl_context *ctx,
+			struct cxl_afu_driver_ops *ops)
+{
+	WARN_ON(!ops->event_pending || !ops->deliver_event);
+	ctx->afu_driver_ops = ops;
+}
+EXPORT_SYMBOL_GPL(cxl_set_driver_ops);
+
 int cxl_start_work(struct cxl_context *ctx,
 		   struct cxl_ioctl_start_work *work)
 {
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index a521bc7..64e8e0a 100644
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
@@ -485,6 +486,9 @@ struct cxl_context {
 	bool pending_fault;
 	bool pending_afu_err;
 
+	/* Used by AFU drivers for driver specific event delivery */
+	struct cxl_afu_driver_ops *afu_driver_ops;
+
 	struct rcu_head rcu;
 };
 
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 783337d..d1cc297 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -295,6 +295,17 @@ int afu_mmap(struct file *file, struct vm_area_struct *vm)
 	return cxl_context_iomap(ctx, vm);
 }
 
+static inline bool ctx_event_pending(struct cxl_context *ctx)
+{
+	if (ctx->pending_irq || ctx->pending_fault || ctx->pending_afu_err)
+		return true;
+
+	if (ctx->afu_driver_ops)
+		return ctx->afu_driver_ops->event_pending(ctx);
+
+	return false;
+}
+
 unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
 {
 	struct cxl_context *ctx = file->private_data;
@@ -307,8 +318,7 @@ unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
 	pr_devel("afu_poll wait done pe: %i\n", ctx->pe);
 
 	spin_lock_irqsave(&ctx->lock, flags);
-	if (ctx->pending_irq || ctx->pending_fault ||
-	    ctx->pending_afu_err)
+	if (ctx_event_pending(ctx))
 		mask |= POLLIN | POLLRDNORM;
 	else if (ctx->status == CLOSED)
 		/* Only error on closed when there are no futher events pending
@@ -321,12 +331,6 @@ unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
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
@@ -346,7 +350,7 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 
 	for (;;) {
 		prepare_to_wait(&ctx->wq, &wait, TASK_INTERRUPTIBLE);
-		if (ctx_event_pending(ctx))
+		if (ctx_event_pending(ctx) || (ctx->status == CLOSED))
 			break;
 
 		if (!cxl_adapter_link_ok(ctx->afu->adapter)) {
@@ -376,7 +380,14 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	memset(&event, 0, sizeof(event));
 	event.header.process_element = ctx->pe;
 	event.header.size = sizeof(struct cxl_event_header);
-	if (ctx->pending_irq) {
+
+	if (ctx->afu_driver_ops && ctx->afu_driver_ops->event_pending(ctx)) {
+		pr_devel("afu_read delivering AFU driver specific event\n");
+		event.header.type = CXL_EVENT_AFU_DRIVER;
+		ctx->afu_driver_ops->deliver_event(ctx, &event, sizeof(event));
+		WARN_ON(event.header.size > sizeof(event));
+
+	} else if (ctx->pending_irq) {
 		pr_devel("afu_read delivering AFU interrupt\n");
 		event.header.size += sizeof(struct cxl_event_afu_interrupt);
 		event.header.type = CXL_EVENT_AFU_INTERRUPT;
@@ -384,6 +395,7 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 		clear_bit(event.irq.irq - 1, ctx->irq_bitmap);
 		if (bitmap_empty(ctx->irq_bitmap, ctx->irq_count))
 			ctx->pending_irq = false;
+
 	} else if (ctx->pending_fault) {
 		pr_devel("afu_read delivering data storage fault\n");
 		event.header.size += sizeof(struct cxl_event_data_storage);
@@ -391,12 +403,14 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
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
@@ -554,7 +568,7 @@ int __init cxl_file_init(void)
 	 * If these change we really need to update API.  Either change some
 	 * flags or update API version number CXL_API_VERSION.
 	 */
-	BUILD_BUG_ON(CXL_API_VERSION != 2);
+	BUILD_BUG_ON(CXL_API_VERSION != 3);
 	BUILD_BUG_ON(sizeof(struct cxl_ioctl_start_work) != 64);
 	BUILD_BUG_ON(sizeof(struct cxl_event_header) != 8);
 	BUILD_BUG_ON(sizeof(struct cxl_event_afu_interrupt) != 8);
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index f2ffe5b..01d66a3 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -210,4 +210,33 @@ ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
 void cxl_perst_reloads_same_image(struct cxl_afu *afu,
 				  bool perst_reloads_same_image);
 
+/*
+ * AFU driver ops allows an AFU driver to create their own events to pass to
+ * userspace through the file descriptor as a simpler alternative to overriding
+ * the read() and poll() calls that works with the generic cxl events. These
+ * events are given priority over the generic cxl events, so they will be
+ * delivered first if multiple types of events are pending.
+ *
+ * event_pending() will be called by the cxl driver to check if an event is
+ * pending (e.g. in select/poll/read calls).
+ *
+ * deliver_event() will be called to fill out a cxl_event structure with the
+ * driver specific event. The header will already have the type and
+ * process_element fields filled in, and header.size will be set to
+ * sizeof(struct cxl_event_header). The AFU driver can extend that size up to
+ * max_size (if an afu driver requires more space, they should submit a patch
+ * increasing the size in the struct cxl_event_afu_driver_reserved definition).
+ *
+ * Both of these calls are made with a spin lock held, so they must not sleep.
+ */
+struct cxl_afu_driver_ops {
+	bool (*event_pending) (struct cxl_context *ctx);
+	void (*deliver_event) (struct cxl_context *ctx,
+			struct cxl_event *event, size_t max_size);
+};
+
+/* Associate the above driver ops with a specific context */
+void cxl_set_driver_ops(struct cxl_context *ctx,
+			struct cxl_afu_driver_ops *ops);
+
 #endif /* _MISC_CXL_H */
diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
index 1e889aa..8b097db 100644
--- a/include/uapi/misc/cxl.h
+++ b/include/uapi/misc/cxl.h
@@ -69,6 +69,7 @@ enum cxl_event_type {
 	CXL_EVENT_AFU_INTERRUPT = 1,
 	CXL_EVENT_DATA_STORAGE  = 2,
 	CXL_EVENT_AFU_ERROR     = 3,
+	CXL_EVENT_AFU_DRIVER    = 4,
 };
 
 struct cxl_event_header {
@@ -100,12 +101,33 @@ struct cxl_event_afu_error {
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
2.1.4
