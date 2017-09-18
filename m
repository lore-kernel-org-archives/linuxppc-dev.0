Return-Path: <roy.pledge@nxp.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0052.outbound.protection.outlook.com [104.47.33.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwyYc3nkKzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 06:40:04 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <leoyang.li@nxp.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
CC: <oss@buserror.net>, <madalin.bucur@nxp.com>, <catalin.marinas@arm.com>,
 <linux@armlinux.org.uk>, <arnd@arndb.de>, <mark.rutland@arm.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [v5 10/12] soc/fsl/qbman: different register offsets on ARM
Date: Mon, 18 Sep 2017 16:39:45 -0400
Message-ID: <1505767187-4596-11-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
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

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/bman.c | 22 ++++++++++++++++++++++
 drivers/soc/fsl/qbman/qman.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index 5dbb5cc..2e6e682 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -35,6 +35,27 @@
 
 /* Portal register assists */
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+/* Cache-inhibited register offsets */
+#define BM_REG_RCR_PI_CINH	0x3000
+#define BM_REG_RCR_CI_CINH	0x3100
+#define BM_REG_RCR_ITR		0x3200
+#define BM_REG_CFG		0x3300
+#define BM_REG_SCN(n)		(0x3400 + ((n) << 6))
+#define BM_REG_ISR		0x3e00
+#define BM_REG_IER		0x3e40
+#define BM_REG_ISDR		0x3e80
+#define BM_REG_IIR		0x3ec0
+
+/* Cache-enabled register offsets */
+#define BM_CL_CR		0x0000
+#define BM_CL_RR0		0x0100
+#define BM_CL_RR1		0x0140
+#define BM_CL_RCR		0x1000
+#define BM_CL_RCR_PI_CENA	0x3000
+#define BM_CL_RCR_CI_CENA	0x3100
+
+#else
 /* Cache-inhibited register offsets */
 #define BM_REG_RCR_PI_CINH	0x0000
 #define BM_REG_RCR_CI_CINH	0x0004
@@ -53,6 +74,7 @@
 #define BM_CL_RCR		0x1000
 #define BM_CL_RCR_PI_CENA	0x3000
 #define BM_CL_RCR_CI_CENA	0x3100
+#endif
 
 /*
  * Portal modes.
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 8934c27..7cb7bad 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -41,6 +41,43 @@
 
 /* Portal register assists */
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+/* Cache-inhibited register offsets */
+#define QM_REG_EQCR_PI_CINH	0x3000
+#define QM_REG_EQCR_CI_CINH	0x3040
+#define QM_REG_EQCR_ITR		0x3080
+#define QM_REG_DQRR_PI_CINH	0x3100
+#define QM_REG_DQRR_CI_CINH	0x3140
+#define QM_REG_DQRR_ITR		0x3180
+#define QM_REG_DQRR_DCAP	0x31C0
+#define QM_REG_DQRR_SDQCR	0x3200
+#define QM_REG_DQRR_VDQCR	0x3240
+#define QM_REG_DQRR_PDQCR	0x3280
+#define QM_REG_MR_PI_CINH	0x3300
+#define QM_REG_MR_CI_CINH	0x3340
+#define QM_REG_MR_ITR		0x3380
+#define QM_REG_CFG		0x3500
+#define QM_REG_ISR		0x3600
+#define QM_REG_IER		0x3640
+#define QM_REG_ISDR		0x3680
+#define QM_REG_IIR		0x36C0
+#define QM_REG_ITPR		0x3740
+
+/* Cache-enabled register offsets */
+#define QM_CL_EQCR		0x0000
+#define QM_CL_DQRR		0x1000
+#define QM_CL_MR		0x2000
+#define QM_CL_EQCR_PI_CENA	0x3000
+#define QM_CL_EQCR_CI_CENA	0x3040
+#define QM_CL_DQRR_PI_CENA	0x3100
+#define QM_CL_DQRR_CI_CENA	0x3140
+#define QM_CL_MR_PI_CENA	0x3300
+#define QM_CL_MR_CI_CENA	0x3340
+#define QM_CL_CR		0x3800
+#define QM_CL_RR0		0x3900
+#define QM_CL_RR1		0x3940
+
+#else
 /* Cache-inhibited register offsets */
 #define QM_REG_EQCR_PI_CINH	0x0000
 #define QM_REG_EQCR_CI_CINH	0x0004
@@ -75,6 +112,7 @@
 #define QM_CL_CR		0x3800
 #define QM_CL_RR0		0x3900
 #define QM_CL_RR1		0x3940
+#endif
 
 /*
  * BTW, the drivers (and h/w programming model) already obtain the required
-- 
2.7.4
