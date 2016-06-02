Return-Path: <qiang.zhao@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0082.outbound.protection.outlook.com [207.46.100.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKr096p11zDqXp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 11:55:21 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <oss@buserror.net>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <xiaobo.xie@nxp.com>, Zhao Qiang
 <qiang.zhao@nxp.com>
Subject: [PATCH v2 1/5] fsl/qe: add rx_sync and tx_sync for TDM mode
Date: Thu, 2 Jun 2016 09:44:57 +0800
Message-ID: <1464831901-15913-1-git-send-email-qiang.zhao@nxp.com>
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

Rx_sync and tx_sync are used by QE-TDM mode,
add them to struct ucc_fast_info.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2:
	- use strcmp instead of strcasecmp

 drivers/soc/fsl/qe/qe.c       | 6 ++++++
 include/soc/fsl/qe/qe.h       | 2 ++
 include/soc/fsl/qe/ucc_fast.h | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 709fc63..7026507 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -239,6 +239,12 @@ enum qe_clock qe_clock_source(const char *source)
 	if (strcasecmp(source, "none") == 0)
 		return QE_CLK_NONE;
 
+	if (strcmp(source, "tsync_pin") == 0)
+		return QE_TSYNC_PIN;
+
+	if (strcmp(source, "rsync_pin") == 0)
+		return QE_RSYNC_PIN;
+
 	if (strncasecmp(source, "brg", 3) == 0) {
 		i = simple_strtoul(source + 3, NULL, 10);
 		if ((i >= 1) && (i <= 16))
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index 33b29ea..f918745 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -80,6 +80,8 @@ enum qe_clock {
 	QE_CLK22,		/* Clock 22 */
 	QE_CLK23,		/* Clock 23 */
 	QE_CLK24,		/* Clock 24 */
+	QE_RSYNC_PIN,		/* RSYNC from pin */
+	QE_TSYNC_PIN,		/* TSYNC from pin */
 	QE_CLK_DUMMY
 };
 
diff --git a/include/soc/fsl/qe/ucc_fast.h b/include/soc/fsl/qe/ucc_fast.h
index df8ea79..31548b7 100644
--- a/include/soc/fsl/qe/ucc_fast.h
+++ b/include/soc/fsl/qe/ucc_fast.h
@@ -120,6 +120,8 @@ struct ucc_fast_info {
 	int ucc_num;
 	enum qe_clock rx_clock;
 	enum qe_clock tx_clock;
+	enum qe_clock rx_sync;
+	enum qe_clock tx_sync;
 	u32 regs;
 	int irq;
 	u32 uccm_mask;
-- 
2.1.0.27.g96db324
