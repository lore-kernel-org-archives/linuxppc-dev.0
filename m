Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41DvdG0J1qzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 02:24:17 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5PGO2Z7095391
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 12:24:15 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ju3rngajf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 12:24:15 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 25 Jun 2018 17:24:12 +0100
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: alastair@au1.ibm.com, andrew.donnellan@au1.ibm.com, vaibhav@linux.ibm.com,
 clombard@linux.ibm.com, felix@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
Subject: [PATCH 01/10] Revert "cxl: Add kernel API to allow a context to
 operate with relocate disabled"
Date: Mon, 25 Jun 2018 18:23:57 +0200
In-Reply-To: <20180625162406.10813-1-fbarrat@linux.ibm.com>
References: <20180625162406.10813-1-fbarrat@linux.ibm.com>
Message-Id: <20180625162406.10813-2-fbarrat@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

Remove abandonned capi support for the Mellanox CX4.
The symbol 'cxl_set_translation_mode' is never called, so
ctx->real_mode is always false.

This reverts commit 7a0d85d313c2066712e530e668bc02bb741a685c.
---
 drivers/misc/cxl/api.c    | 19 -------------------
 drivers/misc/cxl/cxl.h    |  1 -
 drivers/misc/cxl/guest.c  |  3 ---
 drivers/misc/cxl/native.c |  3 ++-
 include/misc/cxl.h        |  8 --------
 5 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 753b1a698fc4..21d620e29fea 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -324,7 +324,6 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 	if (task) {
 		ctx->pid = get_task_pid(task, PIDTYPE_PID);
 		kernel = false;
-		ctx->real_mode = false;
 
 		/* acquire a reference to the task's mm */
 		ctx->mm = get_task_mm(current);
@@ -388,24 +387,6 @@ void cxl_set_master(struct cxl_context *ctx)
 }
 EXPORT_SYMBOL_GPL(cxl_set_master);
 
-int cxl_set_translation_mode(struct cxl_context *ctx, bool real_mode)
-{
-	if (ctx->status == STARTED) {
-		/*
-		 * We could potentially update the PE and issue an update LLCMD
-		 * to support this, but it doesn't seem to have a good use case
-		 * since it's trivial to just create a second kernel context
-		 * with different translation modes, so until someone convinces
-		 * me otherwise:
-		 */
-		return -EBUSY;
-	}
-
-	ctx->real_mode = real_mode;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cxl_set_translation_mode);
-
 /* wrappers around afu_* file ops which are EXPORTED */
 int cxl_fd_open(struct inode *inode, struct file *file)
 {
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 918d4fb742d1..af8794719956 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -613,7 +613,6 @@ struct cxl_context {
 	bool pe_inserted;
 	bool master;
 	bool kernel;
-	bool real_mode;
 	bool pending_irq;
 	bool pending_fault;
 	bool pending_afu_err;
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 4644f16606a3..f5dc740fcd13 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -623,9 +623,6 @@ static int guest_attach_process(struct cxl_context *ctx, bool kernel, u64 wed, u
 {
 	pr_devel("in %s\n", __func__);
 
-	if (ctx->real_mode)
-		return -EPERM;
-
 	ctx->kernel = kernel;
 	if (ctx->afu->current_mode == CXL_MODE_DIRECTED)
 		return attach_afu_directed(ctx, wed, amr);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 98f867fcef24..c9d5d82dce8e 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -605,6 +605,7 @@ u64 cxl_calculate_sr(bool master, bool kernel, bool real_mode, bool p9)
 		sr |= CXL_PSL_SR_An_MP;
 	if (mfspr(SPRN_LPCR) & LPCR_TC)
 		sr |= CXL_PSL_SR_An_TC;
+
 	if (kernel) {
 		if (!real_mode)
 			sr |= CXL_PSL_SR_An_R;
@@ -629,7 +630,7 @@ u64 cxl_calculate_sr(bool master, bool kernel, bool real_mode, bool p9)
 
 static u64 calculate_sr(struct cxl_context *ctx)
 {
-	return cxl_calculate_sr(ctx->master, ctx->kernel, ctx->real_mode,
+	return cxl_calculate_sr(ctx->master, ctx->kernel, false,
 				cxl_is_power9());
 }
 
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index b712be544f8c..82cc6ffafe2d 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -173,14 +173,6 @@ int cxl_afu_reset(struct cxl_context *ctx);
  */
 void cxl_set_master(struct cxl_context *ctx);
 
-/*
- * Sets the context to use real mode memory accesses to operate with
- * translation disabled. Note that this only makes sense for kernel contexts
- * under bare metal, and will not work with virtualisation. May only be
- * performed on stopped contexts.
- */
-int cxl_set_translation_mode(struct cxl_context *ctx, bool real_mode);
-
 /*
  * Map and unmap the AFU Problem Space area. The amount and location mapped
  * depends on if this context is a master or slave.
-- 
2.17.1
