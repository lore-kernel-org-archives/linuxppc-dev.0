Return-Path: <B38951@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 77077B720F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2011 18:44:33 +1100 (EST)
Received: from mail111-db3 (localhost [127.0.0.1])	by
 mail111-db3-R.bigfish.com (Postfix) with ESMTP id 039F31401D2	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2011 07:44:36 +0000 (UTC)
Received: from DB3EHSMHS005.bigfish.com (unknown [10.3.81.248])	by
 mail111-db3.bigfish.com (Postfix) with ESMTP id CC8ED640042	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2011 07:44:35 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Add lbc suspend support for PM
Date: Mon, 21 Nov 2011 14:29:11 +0800
Message-ID: <1321856951-10789-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B11780@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power supply for LBC registers is off when system go to deep-sleep state.
We save the values of registers before suspend and restore to registers
after resume.

We removed the last two reservation arrays from struct fsl_lbc_regs for
allocating less memory and minimizing the memcpy size.

Signed-off-by: Jiang Yutang <b14898@freescale.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/include/asm/fsl_lbc.h |    7 +++++--
 arch/powerpc/sysdev/fsl_lbc.c      |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
index 8a0b5ec..420b453 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -238,8 +238,6 @@ struct fsl_lbc_regs {
 #define FPAR_LP_CI_SHIFT      0
 	__be32 fbcr;            /**< Flash Byte Count Register */
 #define FBCR_BC      0x00000FFF
-	u8 res11[0x8];
-	u8 res8[0xF00];
 };
 
 /*
@@ -294,6 +292,11 @@ struct fsl_lbc_ctrl {
 
 	/* status read from LTESR by irq handler */
 	unsigned int			irq_status;
+
+#ifdef CONFIG_SUSPEND
+	/* save regs when system go to deep-sleep */
+	struct fsl_lbc_regs		*saved_regs;
+#endif
 };
 
 extern int fsl_upm_run_pattern(struct fsl_upm *upm, void __iomem *io_base,
diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index d917573..9f33e40 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -330,6 +330,38 @@ err:
 	return ret;
 }
 
+#ifdef CONFIG_SUSPEND
+
+/* save lbc registers */
+static int fsl_lbc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct fsl_lbc_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
+	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
+
+	ctrl->saved_regs = kmalloc(sizeof(struct fsl_lbc_regs), GFP_KERNEL);
+	if (!ctrl->saved_regs)
+		return -ENOMEM;
+
+	_memcpy_fromio(ctrl->saved_regs, lbc, sizeof(struct fsl_lbc_regs));
+	return 0;
+}
+
+/* restore lbc registers */
+static int fsl_lbc_resume(struct platform_device *pdev)
+{
+	struct fsl_lbc_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
+	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
+
+	if (ctrl->saved_regs) {
+		_memcpy_toio(lbc, ctrl->saved_regs,
+				sizeof(struct fsl_lbc_regs));
+		kfree(ctrl->saved_regs);
+		ctrl->saved_regs = NULL;
+	}
+	return 0;
+}
+#endif /* CONFIG_SUSPEND */
+
 static const struct of_device_id fsl_lbc_match[] = {
 	{ .compatible = "fsl,elbc", },
 	{ .compatible = "fsl,pq3-localbus", },
@@ -344,6 +376,10 @@ static struct platform_driver fsl_lbc_ctrl_driver = {
 		.of_match_table = fsl_lbc_match,
 	},
 	.probe = fsl_lbc_ctrl_probe,
+#ifdef CONFIG_SUSPEND
+	.suspend     = fsl_lbc_suspend,
+	.resume      = fsl_lbc_resume,
+#endif
 };
 
 static int __init fsl_lbc_init(void)
-- 
1.7.5.1
