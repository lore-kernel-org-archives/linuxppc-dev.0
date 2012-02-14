Return-Path: <B32736@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B4B301007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2012 20:23:57 +1100 (EST)
From: Zhicheng Fan <B32736@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH 1/2 v4] powerpc/85xx: Add Quicc Engine support for p1025rdb
Date: Tue, 14 Feb 2012 17:20:19 +0800
Message-ID: <1329211220-15660-1-git-send-email-B32736@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhicheng Fan <b32736@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhicheng Fan <b32736@freescale.com>

Signed-off-by: Zhicheng Fan <b32736@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   78 ++++++++++++++++++++++++++++-
 1 files changed, 77 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index e95aef7..52d5745 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -26,6 +26,9 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#include <asm/qe.h>
+#include <asm/qe_ic.h>
+#include <asm/fsl_guts.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -47,6 +50,10 @@ void __init mpc85xx_rdb_pic_init(void)
 	struct mpic *mpic;
 	unsigned long root = of_get_flat_dt_root();
 
+#ifdef CONFIG_QUICC_ENGINE
+	struct device_node *np;
+#endif
+
 	if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
 		mpic = mpic_alloc(NULL, 0,
 			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
@@ -62,6 +69,18 @@ void __init mpc85xx_rdb_pic_init(void)
 
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
+
+#ifdef CONFIG_QUICC_ENGINE
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (np) {
+		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
+				qe_ic_cascade_high_mpic);
+		of_node_put(np);
+
+	} else
+		pr_err("%s: Could not find qe-ic node\n", __func__);
+#endif
+
 }
 
 /*
@@ -69,7 +88,7 @@ void __init mpc85xx_rdb_pic_init(void)
  */
 static void __init mpc85xx_rdb_setup_arch(void)
 {
-#ifdef CONFIG_PCI
+#if defined(CONFIG_PCI) || defined(CONFIG_QUICC_ENGINE)
 	struct device_node *np;
 #endif
 
@@ -85,6 +104,63 @@ static void __init mpc85xx_rdb_setup_arch(void)
 #endif
 
 	mpc85xx_smp_init();
+
+#ifdef CONFIG_QUICC_ENGINE
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!np) {
+		pr_err("%s: Could not find Quicc Engine node\n", __func__);
+		goto qe_fail;
+	}
+
+	qe_reset();
+	of_node_put(np);
+
+	np = of_find_node_by_name(NULL, "par_io");
+	if (np) {
+		struct device_node *ucc;
+
+		par_io_init(np);
+		of_node_put(np);
+
+		for_each_node_by_name(ucc, "ucc")
+			par_io_of_config(ucc);
+
+	}
+#if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
+	if (machine_is(p1025_rdb)) {
+
+		struct ccsr_guts_85xx __iomem *guts;
+
+		np = of_find_node_by_name(NULL, "global-utilities");
+		if (np) {
+
+			guts = of_iomap(np, 0);
+			if (!guts) {
+
+				pr_err("mpc85xx-rdb: could not map global utilties register!\n");
+
+			} else {
+			/* P1025 has pins muxed for QE and other functions. To
+			* enable QE UEC mode, we need to set bit QE0 for UCC1
+			* in Eth mode, QE0 and QE3 for UCC5 in Eth mode, QE9
+			* and QE12 for QE MII management singals in PMUXCR
+			* register.
+			*/
+				setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE0 |
+						MPC85xx_PMUXCR_QE3 |
+						MPC85xx_PMUXCR_QE9 |
+						MPC85xx_PMUXCR_QE12);
+#endif
+				iounmap(guts);
+			}
+			of_node_put(np);
+		}
+
+	}
+
+qe_fail:
+#endif	/* CONFIG_QUICC_ENGINE */
+
 	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
 }
 
-- 
1.7.0.4
