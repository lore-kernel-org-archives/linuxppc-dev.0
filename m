Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75ED21A0225
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 23:20:18 +1100 (AEDT)
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 3 Nov 2015 12:20:13 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8D6A12190063
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 12:20:05 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA3CK9RP5898750
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 12:20:09 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA3CK8Oa015950
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 05:20:08 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: <stable@vger.kernel.org>
Subject: [PATCH] cxl: Fix struct pid leak when attaching a process through
 user API
Date: Tue,  3 Nov 2015 13:13:52 +0100
Message-Id: <1446552832-17592-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the cxl driver creates a context, it stores the pid of the
calling task, and mistakenly increments the reference count of the
struct pid twice, once through get_task_pid(), once through
get_pid(). The reference count is only decremented once on detach. As
a result, a struct pid is leaked and it reduces the number of
processes that can run simultaneously by one.
The fix is to simply remove the call to get_pid().

There is a separate patch for the kernel API, since it goes to
different kernel versions.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org> # 3.18+
---
 drivers/misc/cxl/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
