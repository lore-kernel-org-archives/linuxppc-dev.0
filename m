Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r08Bl4V61zDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 17:03:11 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 4 May 2016 17:03:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 48A5D2CE8072
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 17:02:12 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4471swf32243932
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 17:02:02 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u44705T7006222
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 17:00:05 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <frederic.barrat@fr.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH] cxl: Add kernel API to allow a context to operate with
 relocate disabled
Date: Wed,  4 May 2016 16:54:42 +1000
Message-Id: <1462344882-1638-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

cxl devices typically access memory using an MMU in much the same way as
the CPU, and each context includes a state register much like the MSR in
the CPU. Like the CPU, the state register includes a bit to enable
relocation, which we currently always enable.

In some cases, it may be desirable to allow a device to access memory
using real addresses instead of effective addresses, so this adds a new
version of the start context kernel API, cxl_start_context2, to allow
contexts to be created with relocation disabled. This can allow for the
creation of a special privileged context that the device can use if it
needs relocation disabled, and can use regular contexts at times when it
needs relocation enabled.

This interface is only available to users of the kernel API for obvious
reasons, and will never be supported in a virtualised environment.

This will be used by the upcoming cxl support in the mlx5 driver.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/api.c    | 14 +++++++++++---
 drivers/misc/cxl/cxl.h    |  2 +-
 drivers/misc/cxl/file.c   |  4 ++--
 drivers/misc/cxl/guest.c  |  6 +++++-
 drivers/misc/cxl/native.c | 20 +++++++++++---------
 include/misc/cxl.h        |  8 ++++++++
 6 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 8075823..675952a 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -167,8 +167,8 @@ EXPORT_SYMBOL_GPL(cxl_unmap_afu_irq);
  * Start a context
  * Code here similar to afu_ioctl_start_work().
  */
-int cxl_start_context(struct cxl_context *ctx, u64 wed,
-		      struct task_struct *task)
+int cxl_start_context2(struct cxl_context *ctx, u64 wed,
+		      struct task_struct *task, bool real_mode)
 {
 	int rc = 0;
 	bool kernel = true;
@@ -183,11 +183,12 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 		ctx->pid = get_task_pid(task, PIDTYPE_PID);
 		ctx->glpid = get_task_pid(task->group_leader, PIDTYPE_PID);
 		kernel = false;
+		real_mode = false;
 	}
 
 	cxl_ctx_get();
 
-	if ((rc = cxl_ops->attach_process(ctx, kernel, wed, 0))) {
+	if ((rc = cxl_ops->attach_process(ctx, kernel, real_mode, wed, 0))) {
 		put_pid(ctx->pid);
 		cxl_ctx_put();
 		goto out;
@@ -198,6 +199,13 @@ out:
 	mutex_unlock(&ctx->status_mutex);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(cxl_start_context2);
+
+int cxl_start_context(struct cxl_context *ctx, u64 wed,
+		      struct task_struct *task)
+{
+	return cxl_start_context2(ctx, wed, task, false);
+}
 EXPORT_SYMBOL_GPL(cxl_start_context);
 
 int cxl_process_element(struct cxl_context *ctx)
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index dfdbfb0..cffded1 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -857,7 +857,7 @@ struct cxl_backend_ops {
 	irqreturn_t (*psl_interrupt)(int irq, void *data);
 	int (*ack_irq)(struct cxl_context *ctx, u64 tfc, u64 psl_reset_mask);
 	int (*attach_process)(struct cxl_context *ctx, bool kernel,
-			u64 wed, u64 amr);
+			bool real_mode, u64 wed, u64 amr);
 	int (*detach_process)(struct cxl_context *ctx);
 	bool (*support_attributes)(const char *attr_name, enum cxl_attrs type);
 	bool (*link_ok)(struct cxl *cxl, struct cxl_afu *afu);
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index eec468f..0f7a418 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -207,8 +207,8 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 
 	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
 
-	if ((rc = cxl_ops->attach_process(ctx, false, work.work_element_descriptor,
-							amr))) {
+	if ((rc = cxl_ops->attach_process(ctx, false, false,
+					  work.work_element_descriptor, amr))) {
 		afu_release_irqs(ctx, ctx);
 		goto out;
 	}
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 769971c..9a53d45 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -613,10 +613,14 @@ out_free:
 	return rc;
 }
 
-static int guest_attach_process(struct cxl_context *ctx, bool kernel, u64 wed, u64 amr)
+static int guest_attach_process(struct cxl_context *ctx, bool kernel,
+				bool real_mode, u64 wed, u64 amr)
 {
 	pr_devel("in %s\n", __func__);
 
+	if (real_mode)
+		return -EINVAL;
+
 	ctx->kernel = kernel;
 	if (ctx->afu->current_mode == CXL_MODE_DIRECTED)
 		return attach_afu_directed(ctx, wed, amr);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index ef494ba..c00a275 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -475,7 +475,7 @@ err:
 #define set_endian(sr) ((sr) &= ~(CXL_PSL_SR_An_LE))
 #endif
 
-static u64 calculate_sr(struct cxl_context *ctx)
+static u64 calculate_sr(struct cxl_context *ctx, bool real_mode)
 {
 	u64 sr = 0;
 
@@ -485,7 +485,9 @@ static u64 calculate_sr(struct cxl_context *ctx)
 	if (mfspr(SPRN_LPCR) & LPCR_TC)
 		sr |= CXL_PSL_SR_An_TC;
 	if (ctx->kernel) {
-		sr |= CXL_PSL_SR_An_R | (mfmsr() & MSR_SF);
+		if (!real_mode)
+			sr |= CXL_PSL_SR_An_R;
+		sr |= (mfmsr() & MSR_SF);
 		sr |= CXL_PSL_SR_An_HV;
 	} else {
 		sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
@@ -496,7 +498,7 @@ static u64 calculate_sr(struct cxl_context *ctx)
 	return sr;
 }
 
-static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
+static int attach_afu_directed(struct cxl_context *ctx, bool real_mode, u64 wed, u64 amr)
 {
 	u32 pid;
 	int r, result;
@@ -514,7 +516,7 @@ static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
 	ctx->elem->common.tid = 0;
 	ctx->elem->common.pid = cpu_to_be32(pid);
 
-	ctx->elem->sr = cpu_to_be64(calculate_sr(ctx));
+	ctx->elem->sr = cpu_to_be64(calculate_sr(ctx, real_mode));
 
 	ctx->elem->common.csrp = 0; /* disable */
 	ctx->elem->common.aurp0 = 0; /* disable */
@@ -589,7 +591,7 @@ static int activate_dedicated_process(struct cxl_afu *afu)
 	return cxl_chardev_d_afu_add(afu);
 }
 
-static int attach_dedicated(struct cxl_context *ctx, u64 wed, u64 amr)
+static int attach_dedicated(struct cxl_context *ctx, bool real_mode, u64 wed, u64 amr)
 {
 	struct cxl_afu *afu = ctx->afu;
 	u64 pid;
@@ -600,7 +602,7 @@ static int attach_dedicated(struct cxl_context *ctx, u64 wed, u64 amr)
 		pid = 0;
 	cxl_p2n_write(afu, CXL_PSL_PID_TID_An, pid);
 
-	cxl_p1n_write(afu, CXL_PSL_SR_An, calculate_sr(ctx));
+	cxl_p1n_write(afu, CXL_PSL_SR_An, calculate_sr(ctx, real_mode));
 
 	if ((rc = cxl_write_sstp(afu, ctx->sstp0, ctx->sstp1)))
 		return rc;
@@ -673,7 +675,7 @@ static int native_afu_activate_mode(struct cxl_afu *afu, int mode)
 }
 
 static int native_attach_process(struct cxl_context *ctx, bool kernel,
-				u64 wed, u64 amr)
+				bool real_mode, u64 wed, u64 amr)
 {
 	if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu)) {
 		WARN(1, "Device link is down, refusing to attach process!\n");
@@ -682,10 +684,10 @@ static int native_attach_process(struct cxl_context *ctx, bool kernel,
 
 	ctx->kernel = kernel;
 	if (ctx->afu->current_mode == CXL_MODE_DIRECTED)
-		return attach_afu_directed(ctx, wed, amr);
+		return attach_afu_directed(ctx, real_mode, wed, amr);
 
 	if (ctx->afu->current_mode == CXL_MODE_DEDICATED)
-		return attach_dedicated(ctx, wed, amr);
+		return attach_dedicated(ctx, real_mode, wed, amr);
 
 	return -EINVAL;
 }
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index 7d5e261..ec0e3ed 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -111,6 +111,14 @@ void cxl_unmap_afu_irq(struct cxl_context *cxl, int num, void *cookie);
  */
 int cxl_start_context(struct cxl_context *ctx, u64 wed,
 		      struct task_struct *task);
+
+/*
+ * Variant of cxl_start_context that allows the context to operate with
+ * translation disabled. Note that this only makes sense for kernel contexts
+ * under bare metal, and will not work with virtualisation.
+ */
+int cxl_start_context2(struct cxl_context *ctx, u64 wed,
+		      struct task_struct *task, bool real_mode);
 /*
  * Stop a context and remove it from the PSL
  */
-- 
2.8.1
