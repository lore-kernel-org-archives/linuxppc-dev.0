Return-Path: <qiang.zhao@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46EED2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 18:26:07 +1100 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>,
 <galak@kernel.crashing.org>
Subject: [PATCh v2 2/2] Corenet: Add QE platform support for Corenet
Date: Wed, 5 Mar 2014 15:21:32 +0800
Message-ID: <1394004092-4622-2-git-send-email-B45475@freescale.com>
In-Reply-To: <1394004092-4622-1-git-send-email-B45475@freescale.com>
References: <1394004092-4622-1-git-send-email-B45475@freescale.com>
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
Changes for v2:
	- use mpc85xx_qe_init() instead
 arch/powerpc/platforms/85xx/corenet_generic.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index fbd871e..f1f4575 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -26,11 +26,14 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/ehv_pic.h>
+#include <asm/qe.h>
+#include <asm/qe_ic.h>
 
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include "smp.h"
+#include "mpc85xx.h"
 
 void __init corenet_gen_pic_init(void)
 {
@@ -38,6 +41,10 @@ void __init corenet_gen_pic_init(void)
 	unsigned int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU |
 		MPIC_NO_RESET;
 
+#ifdef CONFIG_QUICC_ENGINE
+	struct device_node *np;
+#endif
+
 	if (ppc_md.get_irq == mpic_get_coreint_irq)
 		flags |= MPIC_ENABLE_COREINT;
 
@@ -45,6 +52,16 @@ void __init corenet_gen_pic_init(void)
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
@@ -57,6 +74,11 @@ void __init corenet_gen_setup_arch(void)
 	swiotlb_detect_4g();
 
 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
+
+#ifdef CONFIG_QUICC_ENGINE
+	mpc85xx_qe_init();
+#endif
+
 }
 
 static const struct of_device_id of_device_ids[] = {
@@ -81,6 +103,9 @@ static const struct of_device_id of_device_ids[] = {
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
