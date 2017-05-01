Return-Path: <roy.pledge@nxp.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0088.outbound.protection.outlook.com [104.47.38.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGyJQ6BgnzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 07:30:30 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <oss@buserror.net>, <robin.murphy@arm.com>
CC: <madalin.bucur@nxp.com>, <roy.pledge@nxp.com>
Subject: [PATCH v3 08/11] soc/fsl/qbman: add QMAN_REV32
Date: Mon, 1 May 2017 17:30:10 -0400
Message-ID: <1493674213-963-9-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
References: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
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

From: Madalin Bucur <madalin.bucur@nxp.com>

Add revision 3.2 of the QBMan block.  This is the version
for LS1043A and LS1046A SoCs.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c | 2 ++
 drivers/soc/fsl/qbman/qman_priv.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 17a4aaa..af66e63 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -720,6 +720,8 @@ static int fsl_qman_probe(struct platform_device *pdev)
 		qman_ip_rev = QMAN_REV30;
 	else if (major == 3 && minor == 1)
 		qman_ip_rev = QMAN_REV31;
+	else if (major == 3 && minor == 2)
+		qman_ip_rev = QMAN_REV32;
 	else {
 		dev_err(dev, "Unknown QMan version\n");
 		return -ENODEV;
diff --git a/drivers/soc/fsl/qbman/qman_priv.h b/drivers/soc/fsl/qbman/qman_priv.h
index 1e998ea5..96f58c4 100644
--- a/drivers/soc/fsl/qbman/qman_priv.h
+++ b/drivers/soc/fsl/qbman/qman_priv.h
@@ -186,6 +186,7 @@ struct qm_portal_config {
 #define QMAN_REV20 0x0200
 #define QMAN_REV30 0x0300
 #define QMAN_REV31 0x0301
+#define QMAN_REV32 0x0302
 extern u16 qman_ip_rev; /* 0 if uninitialised, otherwise QMAN_REVx */
 
 #define QM_FQID_RANGE_START 1 /* FQID 0 reserved for internal use */
-- 
2.7.4
