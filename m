Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj1cM2J4FzDqMc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 20:16:03 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7UAFQhJ083682
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 06:16:01 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cnmg7hsb7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 06:16:00 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 30 Aug 2017 11:15:58 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
Cc: alistair@popple.id.au
Subject: [PATCH v2 2/3] cxl: Fix driver use count
Date: Wed, 30 Aug 2017 12:15:49 +0200
In-Reply-To: <20170830101550.16821-1-fbarrat@linux.vnet.ibm.com>
References: <20170830101550.16821-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20170830101550.16821-2-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
---
Changelog:
v2: fix typo in comments (Thanks to Andrew)

 drivers/misc/cxl/api.c  | 4 ++++
 drivers/misc/cxl/file.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 1a138c83f877..a0c44d16bf30 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -336,6 +336,10 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
 			mmput(ctx->mm);
 	}
 
+	/*
+	 * Increment driver use count. Enables global TLBIs for hash
+	 * and callbacks to handle the segment table
+	 */
 	cxl_ctx_get();
 
 	if ((rc = cxl_ops->attach_process(ctx, kernel, wed, 0))) {
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 0761271d68c5..4bfad9f6dc9f 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -95,7 +95,6 @@ static int __afu_open(struct inode *inode, struct file *file, bool master)
 
 	pr_devel("afu_open pe: %i\n", ctx->pe);
 	file->private_data = ctx;
-	cxl_ctx_get();
 
 	/* indicate success */
 	rc = 0;
@@ -225,6 +224,12 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	if (ctx->mm)
 		mmput(ctx->mm);
 
+	/*
+	 * Increment driver use count. Enables global TLBIs for hash
+	 * and callbacks to handle the segment table
+	 */
+	cxl_ctx_get();
+
 	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
 
 	if ((rc = cxl_ops->attach_process(ctx, false, work.work_element_descriptor,
@@ -233,6 +238,7 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 		cxl_adapter_context_put(ctx->afu->adapter);
 		put_pid(ctx->pid);
 		ctx->pid = NULL;
+		cxl_ctx_put();
 		cxl_context_mm_count_put(ctx);
 		goto out;
 	}
-- 
2.11.0
