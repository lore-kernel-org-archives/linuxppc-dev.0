Return-Path: <qiang.zhao@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DD90C2C030C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 12:43:22 +1100 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>,
 <galak@kernel.crashing.org>
Subject: [PATCH v3 2/2] Corenet: Add QE platform support for Corenet
Date: Thu, 6 Mar 2014 09:39:24 +0800
Message-ID: <1394069964-20721-1-git-send-email-B45475@freescale.com>
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
Changes for v3:
	- remove #ifdef which aren't really needed

 arch/powerpc/platforms/85xx/corenet_generic.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index fbd871e..19420ef 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -26,11 +26,13 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/ehv_pic.h>
+#include <asm/qe_ic.h>
 
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include "smp.h"
+#include "mpc85xx.h"
 
 void __init corenet_gen_pic_init(void)
 {
@@ -38,6 +40,8 @@ void __init corenet_gen_pic_init(void)
 	unsigned int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU |
 		MPIC_NO_RESET;
 
+	struct device_node *np;
+
 	if (ppc_md.get_irq == mpic_get_coreint_irq)
 		flags |= MPIC_ENABLE_COREINT;
 
@@ -45,6 +49,14 @@ void __init corenet_gen_pic_init(void)
 	BUG_ON(mpic == NULL);
 
 	mpic_init(mpic);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (np) {
+		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
+				qe_ic_cascade_high_mpic);
+		of_node_put(np);
+	}
+
 }
 
 /*
@@ -57,6 +69,8 @@ void __init corenet_gen_setup_arch(void)
 	swiotlb_detect_4g();
 
 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
+
+	mpc85xx_qe_init();
 }
 
 static const struct of_device_id of_device_ids[] = {
@@ -81,6 +95,9 @@ static const struct of_device_id of_device_ids[] = {
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
