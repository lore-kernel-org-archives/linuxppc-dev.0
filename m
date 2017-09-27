Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1zZ21ghCzDsPN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 10:42:49 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8R0cYwO098012
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 20:42:46 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d7uqp82h3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 20:42:46 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 27 Sep 2017 10:42:43 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8R0gf1Q36962502
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 10:42:41 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8R0gYL9028644
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 10:42:34 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: stable@vger.kernel.org
Cc: fbarrat@linux.vnet.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4.9] cxl: Fix driver use count
Date: Wed, 27 Sep 2017 10:42:28 +1000
Message-Id: <20170927004228.9411-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

commit 197267d0356004a31c4d6b6336598f5dff3301e1 upstream.

cxl keeps a driver use count, which is used with the hash memory model
on p8 to know when to upgrade local TLBIs to global and to trigger
callbacks to manage the MMU for PSL8.

If a process opens a context and closes without attaching or fails the
attachment, the driver use count is never decremented. As a
consequence, TLB invalidations remain global, even if there are no
active cxl contexts.

We should increment the driver use count when the process is attaching
to the cxl adapter, and not on open. It's not needed before the
adapter starts using the context and the use count is decremented on
the detach path, so it makes more sense.

It affects only the user api. The kernel api is already doing The
Right Thing.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # v4.2+
Fixes: 7bb5d91a4dda ("cxl: Rework context lifetimes")
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[ajd: backport to stable v4.9 tree]
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/api.c  | 4 ++++
 drivers/misc/cxl/file.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 2e5233b60971..ae856161faa9 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -244,6 +244,10 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 		ctx->real_mode = false;
 	}
 
+	/*
+	 * Increment driver use count. Enables global TLBIs for hash
+	 * and callbacks to handle the segment table
+	 */
 	cxl_ctx_get();
 
 	if ((rc = cxl_ops->attach_process(ctx, kernel, wed, 0))) {
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index afa211397048..d3e009438991 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -91,7 +91,6 @@ static int __afu_open(struct inode *inode, struct file *file, bool master)
 
 	pr_devel("afu_open pe: %i\n", ctx->pe);
 	file->private_data = ctx;
-	cxl_ctx_get();
 
 	/* indicate success */
 	rc = 0;
@@ -213,6 +212,12 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	ctx->glpid = get_task_pid(current->group_leader, PIDTYPE_PID);
 
 
+	/*
+	 * Increment driver use count. Enables global TLBIs for hash
+	 * and callbacks to handle the segment table
+	 */
+	cxl_ctx_get();
+
 	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
 
 	if ((rc = cxl_ops->attach_process(ctx, false, work.work_element_descriptor,
@@ -222,6 +227,7 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 		put_pid(ctx->glpid);
 		put_pid(ctx->pid);
 		ctx->glpid = ctx->pid = NULL;
+		cxl_ctx_put();
 		goto out;
 	}
 
-- 
2.11.0
