Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C99DC43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 08:55:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C6B2152A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 08:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C6B2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42M59V6cyqzF3D4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 18:55:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.21; helo=inva021.nxp.com;
 envelope-from=madalin.bucur@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42M4w11M2qzF3Bk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 18:43:44 +1000 (AEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E534B200071;
 Fri, 28 Sep 2018 10:43:41 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D901520000A;
 Fri, 28 Sep 2018 10:43:41 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net
 (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7CC352039E;
 Fri, 28 Sep 2018 10:43:41 +0200 (CEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: leoyang.li@nxp.com
Subject: [PATCH v2 5/5] soc/fsl_qbman: export coalesce change API
Date: Fri, 28 Sep 2018 11:43:24 +0300
Message-Id: <1538124204-31406-6-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Reply-To: madalin.bucur@nxp.com
Cc: Madalin Bucur <madalin.bucur@nxp.com>, catalin.marinas@arm.com,
 roy.pledge@nxp.com, linux-kernel@vger.kernel.org, oss@buserror.net,
 claudiu.manoil@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Export the API required to control the QMan portal interrupt coalescing
settings.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 31 +++++++++++++++++++++++++++++++
 include/soc/fsl/qman.h       | 27 +++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 99d0f87889b8..8ab75bb44c4d 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1012,6 +1012,37 @@ static inline void put_affine_portal(void)
 
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

