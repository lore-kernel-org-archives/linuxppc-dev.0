Return-Path: <B32736@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7637FB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2012 15:59:15 +1100 (EST)
From: Zhicheng Fan <B32736@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] P1025RDB: add Quicc Engine support
Date: Fri, 20 Jan 2012 13:00:10 +0800
Message-ID: <1327035611-22794-1-git-send-email-B32736@freescale.com>
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Fanzc <b32736@freeescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Fanzc <b32736@freeescale.com>

Signed-off-by: Fanzc <b32736@freeescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   79 ++++++++++++++++++++++++++++-
 1 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 1950076..1ba67aa 100644
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
+		printk(KERN_ERR "Could not find qe-ic node\n");
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
 
@@ -85,6 +104,64 @@ static void __init mpc85xx_rdb_setup_arch(void)
 #endif
 
 	mpc85xx_smp_init();
+
+#ifdef CONFIG_QUICC_ENGINE
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!np) {
+		printk(KERN_ERR "Could not find Quicc Engine node\n");
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
+	if (machine_is(p1025_rdb)) {
+
+		__be32 __iomem *pmuxcr;
+
+		np = of_find_node_by_name(NULL, "global-utilities");
+
+		if (np) {
+			pmuxcr = of_iomap(np, 0) + MPC85xx_PMUXCR_OFFSET;
+
+			if (!pmuxcr)
+				pr_err(KERN_EMERG "Error: Alternate function"
+					" signal multiplex control register not"
+					" mapped!\n");
+			else {
+#if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
+			/* P1025 has pins muxed for QE and other functions. To
+			* enable QE UEC mode, we need to set bit QE0 for UCC1
+			* in Eth mode, QE0 and QE3 for UCC5 in Eth mode, QE9
+			* and QE12 for QE MII management singals in PMUXCR
+			* register.
+			*/
+				setbits32(pmuxcr, MPC85xx_PMUXCR_QE0 |
+						MPC85xx_PMUXCR_QE3 |
+						MPC85xx_PMUXCR_QE9 |
+						MPC85xx_PMUXCR_QE12);
+#endif
+			}
+
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
