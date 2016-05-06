Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1P5R2MSLzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 17:47:55 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 6 May 2016 17:47:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9D6903578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 17:47:48 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u467le2X55247100
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 17:47:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u467lGAI017044
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 17:47:16 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH v2] cxl: Add kernel API to allow a context to operate with
 relocate disabled
Date: Fri,  6 May 2016 17:46:36 +1000
Message-Id: <1462520796-30089-1-git-send-email-imunsie@au.ibm.com>
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
API, cxl_set_translation_mode, that can be used to disable relocation
on a given kernel context. This can allow for the creation of a special
privileged context that the device can use if it needs relocation
disabled, and can use regular contexts at times when it needs relocation
enabled.

This interface is only available to users of the kernel API for obvious
reasons, and will never be supported in a virtualised environment.

This will be used by the upcoming cxl support in the mlx5 driver.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---

Changes since v1:
- Changed API to use a dedicated cxl_set_translation_mode() call instead of
  adding an extra parameter to cxl_start_context2() based on review feedback
  from Frederic Barrat
- Changed error code for attempting to use in PowerVM environment to -EPERM

 drivers/misc/cxl/api.c    | 19 +++++++++++++++++++
 drivers/misc/cxl/cxl.h    |  1 +
 drivers/misc/cxl/guest.c  |  3 +++
 drivers/misc/cxl/native.c |  5 +++--
 include/misc/cxl.h        |  8 ++++++++
 5 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 8075823..6d228cc 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -183,6 +183,7 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 		ctx->pid = get_task_pid(task, PIDTYPE_PID);
 		ctx->glpid = get_task_pid(task->group_leader, PIDTYPE_PID);
 		kernel = false;
+		ctx->real_mode = false;
 	}
 
 	cxl_ctx_get();
@@ -219,6 +220,24 @@ void cxl_set_master(struct cxl_context *ctx)
 }
 EXPORT_SYMBOL_GPL(cxl_set_master);
 
+int cxl_set_translation_mode(struct cxl_context *ctx, bool real_mode)
+{
+	if (ctx->status == STARTED) {
+		/*
+		 * We could potentially update the PE and issue an update LLCMD
+		 * to support this, but it doesn't seem to have a good use case
+		 * since it's trivial to just create a second kernel context
+		 * with different translation modes, so until someone convinces
+		 * me otherwise:
+		 */
+		return -EBUSY;
+	}
+
+	ctx->real_mode = real_mode;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_set_translation_mode);
+
 /* wrappers around afu_* file ops which are EXPORTED */
 int cxl_fd_open(struct inode *inode, struct file *file)
 {
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index dfdbfb0..6e3e485 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -523,6 +523,7 @@ struct cxl_context {
 	bool pe_inserted;
 	bool master;
 	bool kernel;
+	bool real_mode;
 	bool pending_irq;
 	bool pending_fault;
 	bool pending_afu_err;
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 769971c..c2815b9 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -617,6 +617,9 @@ static int guest_attach_process(struct cxl_context *ctx, bool kernel, u64 wed, u
 {
 	pr_devel("in %s\n", __func__);
 
+	if (ctx->real_mode)
+		return -EPERM;
+
 	ctx->kernel = kernel;
 	if (ctx->afu->current_mode == CXL_MODE_DIRECTED)
 		return attach_afu_directed(ctx, wed, amr);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index ef494ba..ba459a9 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -485,8 +485,9 @@ static u64 calculate_sr(struct cxl_context *ctx)
 	if (mfspr(SPRN_LPCR) & LPCR_TC)
 		sr |= CXL_PSL_SR_An_TC;
 	if (ctx->kernel) {
-		sr |= CXL_PSL_SR_An_R | (mfmsr() & MSR_SF);
-		sr |= CXL_PSL_SR_An_HV;
+		if (!ctx->real_mode)
+			sr |= CXL_PSL_SR_An_R;
+		sr |= (mfmsr() & MSR_SF) | CXL_PSL_SR_An_HV;
 	} else {
 		sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
 		sr &= ~(CXL_PSL_SR_An_HV);
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index 7d5e261..56560c5 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -127,6 +127,14 @@ int cxl_afu_reset(struct cxl_context *ctx);
 void cxl_set_master(struct cxl_context *ctx);
 
 /*
+ * Sets the context to use real mode memory accesses to operate with
+ * translation disabled. Note that this only makes sense for kernel contexts
+ * under bare metal, and will not work with virtualisation. May only be
+ * performed on stopped contexts.
+ */
+int cxl_set_translation_mode(struct cxl_context *ctx, bool real_mode);
+
+/*
  * Map and unmap the AFU Problem Space area. The amount and location mapped
  * depends on if this context is a master or slave.
  */
-- 
2.8.1
