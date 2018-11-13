Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EC3C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 16:41:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C28216FD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 16:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C28216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vYKP57HbzF3Pw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 03:40:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.21; helo=inva021.nxp.com;
 envelope-from=madalin.bucur@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
X-Greylist: delayed 418 seconds by postgrey-1.36 at bilbo;
 Wed, 14 Nov 2018 03:37:12 AEDT
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vYF44pp3zF3K4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 03:37:12 +1100 (AEDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8875D20024F;
 Tue, 13 Nov 2018 17:30:07 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C6F6200110;
 Tue, 13 Nov 2018 17:30:07 +0100 (CET)
Received: from fsr-fed2164-101.ea.freescale.net
 (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 15DC5205F8;
 Tue, 13 Nov 2018 17:30:07 +0100 (CET)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/2] soc/qman: add return value to interrupt coalesce
 changing APIs
Date: Tue, 13 Nov 2018 18:29:50 +0200
Message-Id: <1542126591-5114-2-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
References: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
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
Cc: Madalin Bucur <madalin.bucur@nxp.com>, roy.pledge@nxp.com,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Check that the values received by the portal interrupt coalesce
change APIs are in range.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 33 ++++++++++++++++++++++++++-------
 include/soc/fsl/qman.h       |  8 ++++++--
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 5ce24718c2fd..5b9de224193c 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -36,6 +36,8 @@
 #define MAX_IRQNAME	16	/* big enough for "QMan portal %d" */
 #define QMAN_POLL_LIMIT 32
 #define QMAN_PIRQ_DQRR_ITHRESH 12
+#define QMAN_DQRR_IT_MAX 15
+#define QMAN_ITP_MAX 0xFFF
 #define QMAN_PIRQ_MR_ITHRESH 4
 #define QMAN_PIRQ_IPERIOD 100
 
@@ -727,9 +729,15 @@ static inline void qm_dqrr_vdqcr_set(struct qm_portal *portal, u32 vdqcr)
 	qm_out(portal, QM_REG_DQRR_VDQCR, vdqcr);
 }
 
-static inline void qm_dqrr_set_ithresh(struct qm_portal *portal, u8 ithresh)
+static inline int qm_dqrr_set_ithresh(struct qm_portal *portal, u8 ithresh)
 {
+
+	if (ithresh > QMAN_DQRR_IT_MAX)
+		return -EINVAL;
+
 	qm_out(portal, QM_REG_DQRR_ITR, ithresh);
+
+	return 0;
 }
 
 /* --- MR API --- */
@@ -1012,13 +1020,20 @@ static inline void put_affine_portal(void)
 
 static struct workqueue_struct *qm_portal_wq;
 
-void qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh)
+int qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh)
 {
+	int res;
+
 	if (!portal)
-		return;
+		return -EINVAL;
+
+	res = qm_dqrr_set_ithresh(&portal->p, ithresh);
+	if (res)
+		return res;
 
-	qm_dqrr_set_ithresh(&portal->p, ithresh);
 	portal->p.dqrr.ithresh = ithresh;
+
+	return 0;
 }
 EXPORT_SYMBOL(qman_dqrr_set_ithresh);
 
@@ -1036,10 +1051,14 @@ void qman_portal_get_iperiod(struct qman_portal *portal, u32 *iperiod)
 }
 EXPORT_SYMBOL(qman_portal_get_iperiod);
 
-void qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod)
+int qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod)
 {
-	if (portal)
-		qm_out(&portal->p, QM_REG_ITPR, iperiod);
+	if (!portal || iperiod > QMAN_ITP_MAX)
+		return -EINVAL;
+
+	qm_out(&portal->p, QM_REG_ITPR, iperiod);
+
+	return 0;
 }
 EXPORT_SYMBOL(qman_portal_set_iperiod);
 
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index 56877660d5ba..5cc7af06c1ba 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -1205,8 +1205,10 @@ void qman_dqrr_get_ithresh(struct qman_portal *portal, u8 *ithresh);
  * qman_dqrr_set_ithresh - Set coalesce interrupt threshold
  * @portal: portal to set the new value on
  * @ithresh: new threshold value
+ *
+ * Returns 0 on success, or a negative error code.
  */
-void qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh);
+int qman_dqrr_set_ithresh(struct qman_portal *portal, u8 ithresh);
 
 /**
  * qman_dqrr_get_iperiod - Get coalesce interrupt period
@@ -1219,7 +1221,9 @@ void qman_portal_get_iperiod(struct qman_portal *portal, u32 *iperiod);
  * qman_dqrr_set_iperiod - Set coalesce interrupt period
  * @portal: portal to set the new value on
  * @ithresh: new period value
+ *
+ * Returns 0 on success, or a negative error code.
  */
-void qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod);
+int qman_portal_set_iperiod(struct qman_portal *portal, u32 iperiod);
 
 #endif	/* __FSL_QMAN_H */
-- 
2.1.0

