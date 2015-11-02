Return-Path: <raghav@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0141.outbound.protection.outlook.com [207.46.100.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8462C1A03C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 17:12:47 +1100 (AEDT)
From: Dogra Raghav <raghav@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: Kushwaha Prabhakar <prabhakar@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/2] mpc85xx/lbc: modify suspend/resume entry sequence
Date: Mon, 2 Nov 2015 06:12:39 +0000
Message-ID: <BY2PR0301MB0775A3A01F8585352ED5EFADD22C0@BY2PR0301MB0775.namprd03.prod.outlook.com>
References: <1446186299-2921-1-git-send-email-raghav@freescale.com>
In-Reply-To: <1446186299-2921-1-git-send-email-raghav@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: Raghav Dogra [mailto:raghav@freescale.com]=20
Sent: Friday, October 30, 2015 11:55 AM
To: linuxppc-dev@lists.ozlabs.org
Cc: Wood Scott-B07421 <scottwood@freescale.com>; Kushwaha Prabhakar-B32579 =
<prabhakar@freescale.com>; Dogra Raghav-B46184 <raghav@freescale.com>
Subject: [PATCH 1/2] mpc85xx/lbc: modify suspend/resume entry sequence

Modify platform driver suspend/resume to syscore suspend/resume. This is be=
cause p1022ds needs to use localbus when entering the PCIE resume.

Signed-off-by: Raghav Dogra <raghav@freescale.com>
---
 arch/powerpc/sysdev/Makefile  |  2 +-
 arch/powerpc/sysdev/fsl_lbc.c | 51 +++++++++++++++++++++++++++++++++------=
----
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile in=
dex f7cb2a1..4c19e614 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -18,9 +18,9 @@ obj-$(CONFIG_PPC_PMI)		+=3D pmi.o
 obj-$(CONFIG_U3_DART)		+=3D dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+=3D mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+=3D fsl_soc.o fsl_mpic_err.o
+obj-$(CONFIG_FSL_LBC)		+=3D fsl_lbc.o
 obj-$(CONFIG_FSL_PCI)		+=3D fsl_pci.o $(fsl-msi-obj-y)
 obj-$(CONFIG_FSL_PMC)		+=3D fsl_pmc.o
-obj-$(CONFIG_FSL_LBC)		+=3D fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+=3D fsl_gtm.o
 obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+=3D fsl_85xx_l2ctlr.o fsl_85xx_cache_sr=
am.o
 obj-$(CONFIG_SIMPLE_GPIO)	+=3D simple_gpio.o
diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c =
index d631022..332d700 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/mod_devicetable.h>
+#include <linux/syscore_ops.h>
 #include <asm/prom.h>
 #include <asm/fsl_lbc.h>
=20
@@ -354,24 +355,42 @@ err:
 #ifdef CONFIG_SUSPEND
=20
 /* save lbc registers */
-static int fsl_lbc_suspend(struct platform_device *pdev, pm_message_t stat=
e)
+static int fsl_lbc_syscore_suspend(void)
 {
-	struct fsl_lbc_ctrl *ctrl =3D dev_get_drvdata(&pdev->dev);
-	struct fsl_lbc_regs __iomem *lbc =3D ctrl->regs;
+	struct fsl_lbc_ctrl *ctrl;
+	struct fsl_lbc_regs __iomem *lbc;
+
+	ctrl =3D fsl_lbc_ctrl_dev;
+	if (!ctrl)
+		goto out;
+
+	lbc =3D ctrl->regs;
+	if (!lbc)
+		goto out;
=20
 	ctrl->saved_regs =3D kmalloc(sizeof(struct fsl_lbc_regs), GFP_KERNEL);
 	if (!ctrl->saved_regs)
 		return -ENOMEM;
[Dogra Raghav-B46184] This is the existing upstream code. Are you suggestin=
g to modify the upstream code to take care of individual registers?
=20
 	_memcpy_fromio(ctrl->saved_regs, lbc, sizeof(struct fsl_lbc_regs));
+
+out:
 	return 0;
 }
=20
 /* restore lbc registers */
-static int fsl_lbc_resume(struct platform_device *pdev)
+static int fsl_lbc_syscore_resume(void)
 {
-	struct fsl_lbc_ctrl *ctrl =3D dev_get_drvdata(&pdev->dev);
-	struct fsl_lbc_regs __iomem *lbc =3D ctrl->regs;
+	struct fsl_lbc_ctrl *ctrl;
+	struct fsl_lbc_regs __iomem *lbc;
+
+	ctrl =3D fsl_lbc_ctrl_dev;
+	if (!ctrl)
+		goto out;
+
+	lbc =3D ctrl->regs;
+	if (!lbc)
+		goto out;
=20
 	if (ctrl->saved_regs) {
 		_memcpy_toio(lbc, ctrl->saved_regs,
@@ -379,7 +398,9 @@ static int fsl_lbc_resume(struct platform_device *pdev)
 		kfree(ctrl->saved_regs);
 		ctrl->saved_regs =3D NULL;
 	}
-	return 0;
+
+out:
+	return;
 }
 #endif /* CONFIG_SUSPEND */
=20
@@ -391,20 +412,26 @@ static const struct of_device_id fsl_lbc_match[] =3D =
{
 	{},
 };
=20
+#ifdef CONFIG_SUSPEND
+static struct syscore_ops lbc_syscore_pm_ops =3D {
+	.suspend =3D fsl_lbc_syscore_suspend,
+	.resume =3D fsl_lbc_syscore_resume,
+};
+#endif
+
 static struct platform_driver fsl_lbc_ctrl_driver =3D {
 	.driver =3D {
 		.name =3D "fsl-lbc",
 		.of_match_table =3D fsl_lbc_match,
 	},
 	.probe =3D fsl_lbc_ctrl_probe,
-#ifdef CONFIG_SUSPEND
-	.suspend     =3D fsl_lbc_suspend,
-	.resume      =3D fsl_lbc_resume,
-#endif
 };
=20
 static int __init fsl_lbc_init(void)
 {
+#ifdef CONFIG_SUSPEND
+	register_syscore_ops(&lbc_syscore_pm_ops);
+#endif
 	return platform_driver_register(&fsl_lbc_ctrl_driver);
 }
-module_init(fsl_lbc_init);
+arch_initcall(fsl_lbc_init);
--
1.9.1
