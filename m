Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D1BA1A0DD6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 16:07:48 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v3 17/24] cxl: Only check pid for userspace contexts
Date: Wed, 27 May 2015 16:07:11 +1000
Message-Id: <1432706838-20794-18-git-send-email-mikey@neuling.org>
In-Reply-To: <1432706838-20794-1-git-send-email-mikey@neuling.org>
References: <1432706838-20794-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We only need to check the pid attached to this context for userspace contexts.
Kernel contexts can skip this check.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/fault.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 5286b8b..25a5418 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -172,8 +172,8 @@ void cxl_handle_fault(struct work_struct *fault_work)
 		container_of(fault_work, struct cxl_context, fault_work);
 	u64 dsisr = ctx->dsisr;
 	u64 dar = ctx->dar;
-	struct task_struct *task;
-	struct mm_struct *mm;
+	struct task_struct *task = NULL;
+	struct mm_struct *mm = NULL;
 
 	if (cxl_p2n_read(ctx->afu, CXL_PSL_DSISR_An) != dsisr ||
 	    cxl_p2n_read(ctx->afu, CXL_PSL_DAR_An) != dar ||
@@ -194,17 +194,19 @@ void cxl_handle_fault(struct work_struct *fault_work)
 	pr_devel("CXL BOTTOM HALF handling fault for afu pe: %i. "
 		"DSISR: %#llx DAR: %#llx\n", ctx->pe, dsisr, dar);
 
-	if (!(task = get_pid_task(ctx->pid, PIDTYPE_PID))) {
-		pr_devel("cxl_handle_fault unable to get task %i\n",
-			 pid_nr(ctx->pid));
-		cxl_ack_ae(ctx);
-		return;
-	}
-	if (!(mm = get_task_mm(task))) {
-		pr_devel("cxl_handle_fault unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		cxl_ack_ae(ctx);
-		goto out;
+	if (!ctx->kernel) {
+		if (!(task = get_pid_task(ctx->pid, PIDTYPE_PID))) {
+			pr_devel("cxl_handle_fault unable to get task %i\n",
+				 pid_nr(ctx->pid));
+			cxl_ack_ae(ctx);
+			return;
+		}
+		if (!(mm = get_task_mm(task))) {
+			pr_devel("cxl_handle_fault unable to get mm %i\n",
+				 pid_nr(ctx->pid));
+			cxl_ack_ae(ctx);
+			goto out;
+		}
 	}
 
 	if (dsisr & CXL_PSL_DSISR_An_DS)
@@ -214,9 +216,11 @@ void cxl_handle_fault(struct work_struct *fault_work)
 	else
 		WARN(1, "cxl_handle_fault has nothing to handle\n");
 
-	mmput(mm);
+	if (mm)
+		mmput(mm);
 out:
-	put_task_struct(task);
+	if (task)
+		put_task_struct(task);
 }
 
 static void cxl_prefault_one(struct cxl_context *ctx, u64 ea)
-- 
2.1.0
