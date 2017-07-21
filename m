Return-Path: <qiang.zhao@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0068.outbound.protection.outlook.com [104.47.32.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDFHY1HbpzDrHr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 12:35:35 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <oss@buserror.net>
CC: <valentin.longchamp@keymile.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH] qe: fix compile issue for arm64
Date: Fri, 21 Jul 2017 10:19:10 +0800
Message-ID: <1500603550-5567-1-git-send-email-qiang.zhao@nxp.com>
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

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 drivers/soc/fsl/qe/qe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 2ef6fc6..d48fa4a 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -229,7 +229,9 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier)
 	/* Errata QE_General4, which affects some MPC832x and MPC836x SOCs, says
 	   that the BRG divisor must be even if you're not using divide-by-16
 	   mode. */
+#ifdef CONFIG_PPC
 	if (pvr_version_is(PVR_VER_836x) || pvr_version_is(PVR_VER_832x))
+#endif
 		if (!div16 && (divisor & 1) && (divisor > 3))
 			divisor++;
 
-- 
2.1.0.27.g96db324
