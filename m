Return-Path: <madalin.bucur@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GL0c6bjCzF3NZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 01:16:16 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: leoyang.li@nxp.com
Cc: roy.pledge@nxp.com, claudiu.manoil@nxp.com, catalin.marinas@arm.com,
 oss@buserror.net, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 4/4] soc/fsl_qbman: export coalesce change API
Date: Thu, 20 Sep 2018 18:06:51 +0300
Message-Id: <1537456011-10769-5-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow changing the QMan portal interrupt coalescing settings.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 31 +++++++++++++++++++++++++++++++
 include/soc/fsl/qman.h       | 27 +++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 7f4c57999e08..c270471a6e47 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1011,6 +1011,37 @@ static inline void put_affine_portal(void)
 
 static struct workqueue_struct *qm_portal_wq;
 
+void qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh)
+{
+	if (!portal)
+		return;
+
+	qm_dqrr_set_ithresh(&portal->p, ithresh);
+	portal->p.dqrr.ithresh = ithresh;
+}
+EXPORT_SYMBOL(qman_dqrr_set_ithresh);
+
+void qman_dqrr_get_ithresh(struct qman_portal *portal, u8 *ithresh)
+{
+	if (portal && ithresh)
+		*ithresh = portal->p.dqrr.ithresh;
+}
+EXPORT_SYMBOL(qman_dqrr_get_ithresh);
+
+void qman_portal_get_iperiod(struct qman_portal *portal, u32 *iperiod)
+{
+	if (portal && iperiod)
+		*iperiod = qm_in(&portal->p, QM_REG_ITPR);
+}
+EXPORT_SYMBOL(qman_portal_get_iperiod);
+
+void qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod)
+{
+	if (portal)
+		qm_out(&portal->p, QM_REG_ITPR, iperiod);
+}
+EXPORT_SYMBOL(qman_portal_set_iperiod);
+
 int qman_wq_alloc(void)
 {
 	qm_portal_wq = alloc_workqueue("qman_portal_wq", 0, 1);
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index d4dfefdee6c1..42f50eb51529 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -1186,4 +1186,31 @@ int qman_alloc_cgrid_range(u32 *result, u32 count);
  */
 int qman_release_cgrid(u32 id);
 
+/**
+ * qman_dqrr_get_ithresh - Get coalesce interrupt threshold
+ * @portal: portal to get the value for
+ * @ithresh: threshold pointer
+ */
+void qman_dqrr_get_ithresh(struct qman_portal *portal, u8 *ithresh);
+
+/**
+ * qman_dqrr_set_ithresh - Set coalesce interrupt threshold
+ * @portal: portal to set the new value on
+ * @ithresh: new threshold value
+ */
+void qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh);
+
+/**
+ * qman_dqrr_get_iperiod - Get coalesce interrupt period
+ * @portal: portal to get the value for
+ * @iperiod: period pointer
+ */
+void qman_portal_get_iperiod(struct qman_portal *portal, u32 *iperiod);
+/*
+ * qman_dqrr_set_iperiod - Set coalesce interrupt period
+ * @portal: portal to set the new value on
+ * @ithresh: new period value
+ */
+void qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod);
+
 #endif	/* __FSL_QMAN_H */
-- 
2.1.0
