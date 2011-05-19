Return-Path: <B36685@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5AF12B6F87
	for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2011 21:07:07 +1000 (EST)
Received: from mail183-va3 (localhost.localdomain [127.0.0.1])	by
	mail183-va3-R.bigfish.com (Postfix) with ESMTP id 28C5017C83A6	for
	<linuxppc-dev@ozlabs.org>; Thu, 19 May 2011 11:07:00 +0000 (UTC)
Received: from VA3EHSMHS002.bigfish.com (unknown [10.7.14.246])	by
	mail183-va3.bigfish.com (Postfix) with ESMTP id E5BF143804F	for
	<linuxppc-dev@ozlabs.org>; Thu, 19 May 2011 11:06:59 +0000 (UTC)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Powerpc/fsl_lbc: Add workaround for ELBC-A001 erratum
Date: Thu, 19 May 2011 18:48:01 +0800
Message-ID: <1305802081-19733-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, kumar.gala@freescale.com,
	Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simultaneous FCM and GPCM or UPM operation may erroneously trigger
bus monitor timeout.

Set the local bus monitor timeout value to the maximum by setting
LBCR[BMT] = 0 and LBCR[BMTPS] = 0xF.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Signed-off-by: Gala Kumar <kumar.gala@freescale.com>
---
 arch/powerpc/include/asm/fsl_lbc.h |    2 ++
 arch/powerpc/sysdev/fsl_lbc.c      |    9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
index 5c1bf34..8a0b5ec 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -157,6 +157,8 @@ struct fsl_lbc_regs {
 #define LBCR_EPAR_SHIFT    16
 #define LBCR_BMT   0x0000FF00
 #define LBCR_BMT_SHIFT      8
+#define LBCR_BMTPS 0x0000000F
+#define LBCR_BMTPS_SHIFT    0
 #define LBCR_INIT  0x00040000
 	__be32 lcrr;            /**< Clock Ratio Register */
 #define LCRR_DBYP    0x80000000
diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index 4fcb5a4..19a4ecd 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -184,7 +184,8 @@ int fsl_upm_run_pattern(struct fsl_upm *upm, void __iomem *io_base, u32 mar)
 }
 EXPORT_SYMBOL(fsl_upm_run_pattern);
 
-static int __devinit fsl_lbc_ctrl_init(struct fsl_lbc_ctrl *ctrl)
+static int __devinit fsl_lbc_ctrl_init(struct fsl_lbc_ctrl *ctrl,
+				       struct device_node *node)
 {
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 
@@ -198,6 +199,10 @@ static int __devinit fsl_lbc_ctrl_init(struct fsl_lbc_ctrl *ctrl)
 	/* Enable interrupts for any detected events */
 	out_be32(&lbc->lteir, LTEIR_ENABLE);
 
+	/* Set the monitor timeout value to the maximum for erratum A001 */
+	if (of_device_is_compatible(node, "fsl,elbc"))
+		clrsetbits_be32(&lbc->lbcr, LBCR_BMT, LBCR_BMTPS);
+
 	return 0;
 }
 
@@ -304,7 +309,7 @@ static int __devinit fsl_lbc_ctrl_probe(struct platform_device *dev)
 
 	fsl_lbc_ctrl_dev->dev = &dev->dev;
 
-	ret = fsl_lbc_ctrl_init(fsl_lbc_ctrl_dev);
+	ret = fsl_lbc_ctrl_init(fsl_lbc_ctrl_dev, ofdev->node);
 	if (ret < 0)
 		goto err;
 
-- 
1.6.4
