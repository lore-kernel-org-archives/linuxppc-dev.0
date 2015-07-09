Return-Path: <roy.pledge@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0131.outbound.protection.outlook.com [207.46.100.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F336C1A1079
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 06:37:58 +1000 (AEST)
From: Roy Pledge <Roy.Pledge@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/11] soc/qman: add qman_delete_cgr_safe()
Date: Thu, 9 Jul 2015 16:22:02 -0400
Message-ID: <1436473322-21247-12-git-send-email-Roy.Pledge@freescale.com>
In-Reply-To: <1436473322-21247-1-git-send-email-Roy.Pledge@freescale.com>
References: <1436473322-21247-1-git-send-email-Roy.Pledge@freescale.com>
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

From: Madalin Bucur <madalin.bucur@freescale.com>

Add qman_delete_cgr_safe() that can be called from any CPU.
This in turn schedules qman_delete_cgr() on the proper CPU.

Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
Signed-off-by: Roy Pledge <Roy.Pledge@freescale.com>
---
 drivers/soc/fsl/qbman/qman_api.c |   46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_api.c b/drivers/soc/fsl/qbman/qman_api.c
index 93f43dd..5dbcd94 100644
--- a/drivers/soc/fsl/qbman/qman_api.c
+++ b/drivers/soc/fsl/qbman/qman_api.c
@@ -2459,6 +2459,8 @@ EXPORT_SYMBOL(qman_modify_cgr);
 					QM_CHANNEL_SWPORTAL0))
 #define PORTAL_IDX(n) (n->config->public_cfg.channel - QM_CHANNEL_SWPORTAL0)
 
+static u8 qman_cgr_cpus[__CGR_NUM];
+
 int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 			struct qm_mcc_initcgr *opts)
 {
@@ -2475,7 +2477,10 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	if (cgr->cgrid >= __CGR_NUM)
 		return -EINVAL;
 
+	preempt_disable();
 	p = get_affine_portal();
+	qman_cgr_cpus[cgr->cgrid] = smp_processor_id();
+	preempt_enable();
 
 	memset(&local_opts, 0, sizeof(struct qm_mcc_initcgr));
 	cgr->chan = p->config->public_cfg.channel;
@@ -2617,6 +2622,47 @@ put_portal:
 }
 EXPORT_SYMBOL(qman_delete_cgr);
 
+struct cgr_comp {
+	struct qman_cgr *cgr;
+	struct completion completion;
+};
+
+static int qman_delete_cgr_thread(void *p)
+{
+	struct cgr_comp *cgr_comp = (struct cgr_comp *)p;
+	int res;
+
+	res = qman_delete_cgr((struct qman_cgr *)cgr_comp->cgr);
+	complete(&cgr_comp->completion);
+
+	return res;
+}
+
+void qman_delete_cgr_safe(struct qman_cgr *cgr)
+{
+	struct task_struct *thread;
+	struct cgr_comp cgr_comp;
+
+	preempt_disable();
+	if (qman_cgr_cpus[cgr->cgrid] != smp_processor_id()) {
+		init_completion(&cgr_comp.completion);
+		cgr_comp.cgr = cgr;
+		thread = kthread_create(qman_delete_cgr_thread, &cgr_comp,
+					"cgr_del");
+
+		if (likely(!IS_ERR(thread))) {
+			kthread_bind(thread, qman_cgr_cpus[cgr->cgrid]);
+			wake_up_process(thread);
+			wait_for_completion(&cgr_comp.completion);
+			preempt_enable();
+			return;
+		}
+	}
+	qman_delete_cgr(cgr);
+	preempt_enable();
+}
+EXPORT_SYMBOL(qman_delete_cgr_safe);
+
 int qman_set_wpm(int wpm_enable)
 {
 	return qm_set_wpm(wpm_enable);
-- 
1.7.9.5
