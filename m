Return-Path: <qiang.zhao@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 76B632C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 19:52:23 +1100 (EST)
Received: from mail129-ch1 (localhost [127.0.0.1])	by
 mail129-ch1-R.bigfish.com (Postfix) with ESMTP id 23C162A0092	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 08:52:18 +0000 (UTC)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>
Subject: [PATCH] Corenet: Add QE platform support for Corenet
Date: Fri, 28 Feb 2014 16:48:29 +0800
Message-ID: <1393577309-41445-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, R63061@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is QE on platform T104x, add support.
Call funcs qe_ic_init and qe_init if CONFIG_QUICC_ENGINE is defined.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index fbd871e..f8c8e0c 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -26,6 +26,8 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/ehv_pic.h>
+#include <asm/qe.h>
+#include <asm/qe_ic.h>
 
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
@@ -38,6 +40,10 @@ void __init corenet_gen_pic_init(void)
 	unsigned int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU |
 		MPIC_NO_RESET;
 
+#ifdef CONFIG_QUICC_ENGINE
+	struct device_node *np;
+#endif
+
 	if (ppc_md.get_irq == mpic_get_coreint_irq)
 		flags |= MPIC_ENABLE_COREINT;
 
@@ -45,6 +51,16 @@ void __init corenet_gen_pic_init(void)
 	BUG_ON(mpic == NULL);
 
 	mpic_init(mpic);
+
+#ifdef CONFIG_QUICC_ENGINE
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (np) {
+		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
+				qe_ic_cascade_high_mpic);
+		of_node_put(np);
+	}
+#endif
+
 }
 
 /*
@@ -52,11 +68,24 @@ void __init corenet_gen_pic_init(void)
  */
 void __init corenet_gen_setup_arch(void)
 {
+#ifdef CONFIG_QUICC_ENGINE
+	struct device_node *np;
+#endif
 	mpc85xx_smp_init();
 
 	swiotlb_detect_4g();
 
 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
+
+#ifdef CONFIG_QUICC_ENGINE
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!np) {
+		pr_err("%s: Could not find Quicc Engine node\n", __func__);
+		return;
+	}
+	qe_reset();
+	of_node_put(np);
+#endif
 }
 
 static const struct of_device_id of_device_ids[] = {
@@ -81,6 +110,9 @@ static const struct of_device_id of_device_ids[] = {
 	{
 		.compatible	= "fsl,qoriq-pcie-v3.0",
 	},
+	{
+		.compatible	= "fsl,qe",
+	},
 	/* The following two are for the Freescale hypervisor */
 	{
 		.name		= "hypervisor",
-- 
1.8.5
