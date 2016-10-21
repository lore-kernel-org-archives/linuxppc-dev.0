Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0ZSC3QbpzDvZh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 16:46:51 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9L5hiFx101874
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 01:46:48 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2675yxef8b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 01:46:48 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 21 Oct 2016 15:46:46 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E7D5A2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 16:46:43 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9L5khdq9240632
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 16:46:43 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9L5khWx015847
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 16:46:43 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 gkurz@linux.vnet.ibm.com
Subject: [PATCH] cxl: Fix leaking pid refs in some error paths
Date: Fri, 21 Oct 2016 11:16:23 +0530
Message-Id: <1477028783-1260-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In some error paths in functions cxl_start_context and
afu_ioctl_start_work pid references to the current & group-leader tasks
can leak after they are taken. This patch fixes these error paths to
release these pid references before exiting the error path.

This patch is based on earlier patch "cxl: Prevent adapter reset
if an active context exists" at
https://patchwork.ozlabs.org/patch/682187/

Fixes: 7b8ad495("cxl: Fix DSI misses when the context owning task exits")
Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c  |  2 ++
 drivers/misc/cxl/file.c | 22 +++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index af23d7d..2e5233b 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -247,7 +247,9 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 	cxl_ctx_get();
 
 	if ((rc = cxl_ops->attach_process(ctx, kernel, wed, 0))) {
+		put_pid(ctx->glpid);
 		put_pid(ctx->pid);
+		ctx->glpid = ctx->pid = NULL;
 		cxl_adapter_context_put(ctx->afu->adapter);
 		cxl_ctx_put();
 		goto out;
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index d0b421f..77080cc 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -194,6 +194,16 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	ctx->mmio_err_ff = !!(work.flags & CXL_START_WORK_ERR_FF);
 
 	/*
+	 * Increment the mapped context count for adapter. This also checks
+	 * if adapter_context_lock is taken.
+	 */
+	rc = cxl_adapter_context_get(ctx->afu->adapter);
+	if (rc) {
+		afu_release_irqs(ctx, ctx);
+		goto out;
+	}
+
+	/*
 	 * We grab the PID here and not in the file open to allow for the case
 	 * where a process (master, some daemon, etc) has opened the chardev on
 	 * behalf of another process, so the AFU's mm gets bound to the process
@@ -205,15 +215,6 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	ctx->pid = get_task_pid(current, PIDTYPE_PID);
 	ctx->glpid = get_task_pid(current->group_leader, PIDTYPE_PID);
 
-	/*
-	 * Increment the mapped context count for adapter. This also checks
-	 * if adapter_context_lock is taken.
-	 */
-	rc = cxl_adapter_context_get(ctx->afu->adapter);
-	if (rc) {
-		afu_release_irqs(ctx, ctx);
-		goto out;
-	}
 
 	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
 
@@ -221,6 +222,9 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 							amr))) {
 		afu_release_irqs(ctx, ctx);
 		cxl_adapter_context_put(ctx->afu->adapter);
+		put_pid(ctx->glpid);
+		put_pid(ctx->pid);
+		ctx->glpid = ctx->pid = NULL;
 		goto out;
 	}
 
-- 
2.7.4
