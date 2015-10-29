Return-Path: <frederic.barrat@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B2681A0AF0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 23:39:32 +1100 (AEDT)
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <frederic.barrat@fr.ibm.com>;
 Thu, 29 Oct 2015 12:39:28 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id B4A88219005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 12:39:21 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9TCdOFi59769072
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 12:39:25 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9TCdO0v023120
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 06:39:24 -0600
From: Frederic Barrat <frederic.barrat@fr.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, Frederic Barrat <frederic.barrat@fr.ibm.com>
Subject: [PATCH] cxl: Fix reference count on struct pid when attaching
Date: Thu, 29 Oct 2015 13:39:03 +0100
Message-Id: <1446122343-26068-1-git-send-email-frederic.barrat@fr.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the cxl driver creates a context, it stores the pid of the
calling task, incrementing the reference count on the struct
pid. Current code mistakenly increments the reference count twice,
once through get_task_pid(), once through get_pid(). The reference
count is only decremented once on detach, thus the struct pid of the
task attaching is never freed. The fix is to simply remove the call to
get_pid().

Signed-off-by: Frederic Barrat <frederic.barrat@fr.ibm.com>
---
 drivers/misc/cxl/api.c  | 1 -
 drivers/misc/cxl/file.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 103baf0..94b6627 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -176,7 +176,6 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 
 	if (task) {
 		ctx->pid = get_task_pid(task, PIDTYPE_PID);
-		get_pid(ctx->pid);
 		kernel = false;
 	}
 
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 7ccd299..97003ee 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -199,7 +199,7 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	 * behalf of another process, so the AFU's mm gets bound to the process
 	 * that performs this ioctl and not the process that opened the file.
 	 */
-	ctx->pid = get_pid(get_task_pid(current, PIDTYPE_PID));
+	ctx->pid = get_task_pid(current, PIDTYPE_PID);
 
 	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
 
-- 
1.9.1
