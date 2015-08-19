Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9F151A0151
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 14:21:05 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7704E140327
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 14:21:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 19 Aug 2015 14:21:03 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9CE3D3578052
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 14:21:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7J4Ks6k62849060
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 14:21:02 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7J4KSd7007860
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 14:20:29 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Cc: mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Matt Ochs <mrochs@us.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 1/2] cxl: Add mechanism for delivering AFU driver specific
 events
Date: Wed, 19 Aug 2015 14:19:30 +1000
Message-Id: <1439957971-30483-1-git-send-email-imunsie@au.ibm.com>
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
deliver_event callbacks. An AFU driver can fill these out and associate
it with a context to enable passing custom AFU specific events to
userspace.

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

Conflicts between AFU specific events are not expected, due to the fact
that each AFU specific driver has it's own mechanism to deliver an AFU
file descriptor to userspace.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/Kconfig |  5 +++++
 drivers/misc/cxl/api.c   |  7 +++++++
 drivers/misc/cxl/cxl.h   |  6 +++++-
 drivers/misc/cxl/file.c  | 37 +++++++++++++++++++++++++++----------
 include/misc/cxl.h       | 29 +++++++++++++++++++++++++++++
 include/uapi/misc/cxl.h  | 13 +++++++++++++
 6 files changed, 86 insertions(+), 11 deletions(-)

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
index 6a768a9..e0f0c78 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -267,6 +267,13 @@ struct cxl_context *cxl_fops_get_context(struct file *file)
 }
 EXPORT_SYMBOL_GPL(cxl_fops_get_context);
 
+void cxl_set_driver_ops(struct cxl_context *ctx,
+			struct cxl_afu_driver_ops *ops)
+{
+	ctx->afu_driver_ops = ops;
+}
+EXPORT_SYMBOL_GPL(cxl_set_driver_ops);
+
 int cxl_start_work(struct cxl_context *ctx,
 		   struct cxl_ioctl_start_work *work)
 {
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 6f53866..30e44a8 100644
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
-#define CXL_API_VERSION 1
+#define CXL_API_VERSION 2
 #define CXL_API_VERSION_COMPATIBLE 1
 
 /*
@@ -462,6 +463,9 @@ struct cxl_context {
 	bool pending_fault;
 	bool pending_afu_err;
 
+	/* Used by AFU drivers for driver specific event delivery */
+	struct cxl_afu_driver_ops *afu_driver_ops;
+
 	struct rcu_head rcu;
 };
 
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 57bdb47..2ebaca3 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -279,6 +279,22 @@ int afu_mmap(struct file *file, struct vm_area_struct *vm)
 	return cxl_context_iomap(ctx, vm);
 }
 
+static inline int _ctx_event_pending(struct cxl_context *ctx)
+{
+	bool afu_driver_event_pending = false;
+
+	if (ctx->afu_driver_ops && ctx->afu_driver_ops->event_pending)
+		afu_driver_event_pending = ctx->afu_driver_ops->event_pending(ctx);
+
+	return (ctx->pending_irq || ctx->pending_fault ||
+	    ctx->pending_afu_err || afu_driver_event_pending);
+}
+
+static inline int ctx_event_pending(struct cxl_context *ctx)
+{
+	return _ctx_event_pending(ctx) || (ctx->status == CLOSED);
+}
+
 unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
 {
 	struct cxl_context *ctx = file->private_data;
@@ -291,8 +307,7 @@ unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
 	pr_devel("afu_poll wait done pe: %i\n", ctx->pe);
 
 	spin_lock_irqsave(&ctx->lock, flags);
-	if (ctx->pending_irq || ctx->pending_fault ||
-	    ctx->pending_afu_err)
+	if (_ctx_event_pending(ctx))
 		mask |= POLLIN | POLLRDNORM;
 	else if (ctx->status == CLOSED)
 		/* Only error on closed when there are no futher events pending
@@ -305,12 +320,6 @@ unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
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
@@ -360,7 +369,15 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	memset(&event, 0, sizeof(event));
 	event.header.process_element = ctx->pe;
 	event.header.size = sizeof(struct cxl_event_header);
-	if (ctx->pending_irq) {
+	if (ctx->afu_driver_ops
+			&& ctx->afu_driver_ops->event_pending
+			&& ctx->afu_driver_ops->deliver_event
+			&& ctx->afu_driver_ops->event_pending(ctx)) {
+		pr_devel("afu_read delivering AFU driver specific event\n");
+		event.header.type = CXL_EVENT_AFU_DRIVER;
+		ctx->afu_driver_ops->deliver_event(&event, ctx, sizeof(event));
+		WARN_ON(event.header.size > sizeof(event));
+	} else if (ctx->pending_irq) {
 		pr_devel("afu_read delivering AFU interrupt\n");
 		event.header.size += sizeof(struct cxl_event_afu_interrupt);
 		event.header.type = CXL_EVENT_AFU_INTERRUPT;
@@ -538,7 +555,7 @@ int __init cxl_file_init(void)
 	 * If these change we really need to update API.  Either change some
 	 * flags or update API version number CXL_API_VERSION.
 	 */
-	BUILD_BUG_ON(CXL_API_VERSION != 1);
+	BUILD_BUG_ON(CXL_API_VERSION != 2);
 	BUILD_BUG_ON(sizeof(struct cxl_ioctl_start_work) != 64);
 	BUILD_BUG_ON(sizeof(struct cxl_event_header) != 8);
 	BUILD_BUG_ON(sizeof(struct cxl_event_afu_interrupt) != 8);
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index f2ffe5b..73e03a6 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -210,4 +210,33 @@ ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
 void cxl_perst_reloads_same_image(struct cxl_afu *afu,
 				  bool perst_reloads_same_image);
 
+/*
+ * AFU driver ops allows an AFU driver to create their own events to pass to
+ * userspace through the file descriptor as a simpler alternative to overriding
+ * the read() and poll() calls that works with the generic cxl events. These
+ * events are given priority over the generic cxl events, so will be delivered
+ * first if multiple types of events are pending.
+ *
+ * even_pending() will be called by the cxl driver to check if an event is
+ * pending (e.g. in select/poll/read calls).
+ *
+ * deliver_event() will be called to fill out a cxl_event structure with the
+ * driver specific event. The header will already have the type and
+ * process_element fields filled in, and header.size will be set to
+ * sizeof(struct cxl_event_header). The AFU driver can extend that size up to
+ * max_size (which can be increased if necessary by reserving more space in the
+ * struct cxl_event_afu_driver_reserved definition).
+ *
+ * Both of these calls are made with a spin lock held, so they must not sleep.
+ */
+struct cxl_afu_driver_ops {
+	bool (*event_pending) (struct cxl_context *cxl);
+	void (*deliver_event) (struct cxl_event *event,
+			       struct cxl_context *cxl, size_t max_size);
+};
+
+/* Associate the above driver ops with a specific context */
+void cxl_set_driver_ops(struct cxl_context *ctx,
+			struct cxl_afu_driver_ops *ops);
+
 #endif /* _MISC_CXL_H */
diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
index 99a8ca1..97f20b3 100644
--- a/include/uapi/misc/cxl.h
+++ b/include/uapi/misc/cxl.h
@@ -67,6 +67,7 @@ enum cxl_event_type {
 	CXL_EVENT_AFU_INTERRUPT = 1,
 	CXL_EVENT_DATA_STORAGE  = 2,
 	CXL_EVENT_AFU_ERROR     = 3,
+	CXL_EVENT_AFU_DRIVER    = 4,
 };
 
 struct cxl_event_header {
@@ -98,12 +99,24 @@ struct cxl_event_afu_error {
 	__u64 error;
 };
 
+struct cxl_event_afu_driver_reserved {
+	/*
+	 * Reserves space for AFU driver specific events. If an AFU driver
+	 * needs a larger buffer they should increase this to match so the cxl
+	 * driver will allocate enough space.
+	 *
+	 * This is not ABI. The contents will be, but that's up the AFU driver.
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
