Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F7F1A0298
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 23:20:40 +1100 (AEDT)
Received: from localhost
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 3 Nov 2015 12:20:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id F35F517D8066
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 12:20:48 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA3CKXXr29425806
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 12:20:33 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA3CKXPs001607
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 05:20:33 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: <stable@vger.kernel.org>
Subject: [PATCH] cxl: Fix struct pid leak when attaching a process through
 kernel API
Date: Tue,  3 Nov 2015 13:20:15 +0100
Message-Id: <1446553215-18273-1-git-send-email-fbarrat@linux.vnet.ibm.com>
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

There is a separate patch for the user API, since it goes to
different kernel versions.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org> # 4.3+
---
 drivers/misc/cxl/api.c | 1 -
 1 file changed, 1 deletion(-)

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
 
-- 
1.9.1
