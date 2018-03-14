Return-Path: <madalin.bucur@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10059.outbound.protection.outlook.com [40.107.1.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401XqZ20FWzDr71
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 00:38:33 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 camelia.groza@nxp.com, leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Madalin Bucur <madalin.bucur@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH 1/5] soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
Date: Wed, 14 Mar 2018 08:37:28 -0500
Message-Id: <20180314133732.24068-2-madalin.bucur@nxp.com>
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The wait_for_completion() call in qman_delete_cgr_safe()
was triggering a scheduling while atomic bug, replacing the
kthread with a smp_call_function_single() call to fix it.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index e4f5bb0..ba3cfa8 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2443,39 +2443,21 @@ struct cgr_comp {
 	struct completion completion;
 };
 
-static int qman_delete_cgr_thread(void *p)
+static void qman_delete_cgr_smp_call(void *p)
 {
-	struct cgr_comp *cgr_comp = (struct cgr_comp *)p;
-	int ret;
-
-	ret = qman_delete_cgr(cgr_comp->cgr);
-	complete(&cgr_comp->completion);
-
-	return ret;
+	qman_delete_cgr((struct qman_cgr *)p);
 }
 
 void qman_delete_cgr_safe(struct qman_cgr *cgr)
 {
-	struct task_struct *thread;
-	struct cgr_comp cgr_comp;
-
 	preempt_disable();
 	if (qman_cgr_cpus[cgr->cgrid] != smp_processor_id()) {
-		init_completion(&cgr_comp.completion);
-		cgr_comp.cgr = cgr;
-		thread = kthread_create(qman_delete_cgr_thread, &cgr_comp,
-					"cgr_del");
-
-		if (IS_ERR(thread))
-			goto out;
-
-		kthread_bind(thread, qman_cgr_cpus[cgr->cgrid]);
-		wake_up_process(thread);
-		wait_for_completion(&cgr_comp.completion);
+		smp_call_function_single(qman_cgr_cpus[cgr->cgrid],
+					 qman_delete_cgr_smp_call, cgr, true);
 		preempt_enable();
 		return;
 	}
-out:
+
 	qman_delete_cgr(cgr);
 	preempt_enable();
 }
-- 
2.1.0
