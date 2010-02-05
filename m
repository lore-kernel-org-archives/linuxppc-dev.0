Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id D2119B81C6
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 00:43:50 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 02/11] powerpc/mpc5121: Add machine restart support
Date: Fri,  5 Feb 2010 14:42:48 +0100
Message-Id: <1265377377-29327-3-git-send-email-agust@denx.de>
In-Reply-To: <1265377377-29327-1-git-send-email-agust@denx.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
Cc: wd@denx.de, dzu@denx.de, Anatolij Gustschin <agust@denx.de>,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add reset module registers representation and
machine restart callback for mpc5121 platform.

Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
Changes since v2:
 - call mpc512x_restart_init() explicitely from platform
   init code

Changes since v1:
 - use 'struct mpc512x_reset_module *' type for 'reset_module_base'
 - remove empty line
 - remove leftover colon and use pr_err() instead of printk.

 arch/powerpc/include/asm/mpc5xxx.h            |   14 +++++++++-
 arch/powerpc/platforms/512x/mpc5121_ads.c     |    1 +
 arch/powerpc/platforms/512x/mpc5121_generic.c |    1 +
 arch/powerpc/platforms/512x/mpc512x.h         |    1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c  |   34 +++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc5xxx.h b/arch/powerpc/include/asm/mpc5xxx.h
index 5ce9c5f..0004986 100644
--- a/arch/powerpc/include/asm/mpc5xxx.h
+++ b/arch/powerpc/include/asm/mpc5xxx.h
@@ -18,5 +18,17 @@
 
 extern unsigned long mpc5xxx_get_bus_frequency(struct device_node *node);
 
-#endif /* __ASM_POWERPC_MPC5xxx_H__ */
+/* MPC512x Reset module registers */
+struct mpc512x_reset_module {
+	u32	rcwlr;	/* Reset Configuration Word Low Register */
+	u32	rcwhr;	/* Reset Configuration Word High Register */
+	u32	reserved1;
+	u32	reserved2;
+	u32	rsr;	/* Reset Status Register */
+	u32	rmr;	/* Reset Mode Register */
+	u32	rpr;	/* Reset Protection Register */
+	u32	rcr;	/* Reset Control Register */
+	u32	rcer;	/* Reset Control Enable Register */
+};
 
+#endif /* __ASM_POWERPC_MPC5xxx_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 0f8f2e9..ee6ae12 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -68,4 +68,5 @@ define_machine(mpc5121_ads) {
 	.init_IRQ		= mpc5121_ads_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
+	.restart		= mpc512x_restart,
 };
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
index 9b8c9b0..a6c0e3a 100644
--- a/arch/powerpc/platforms/512x/mpc5121_generic.c
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -55,4 +55,5 @@ define_machine(mpc5121_generic) {
 	.init_IRQ		= mpc512x_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
+	.restart		= mpc512x_restart,
 };
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index ac3da1a..b2daca0 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -15,4 +15,5 @@ extern void __init mpc512x_init_IRQ(void);
 extern void __init mpc512x_init(void);
 extern int __init mpc5121_clk_init(void);
 void __init mpc512x_declare_of_platform_devices(void);
+extern void mpc512x_restart(char *cmd);
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index b683165..ac0400e 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -21,9 +21,42 @@
 #include <asm/ipic.h>
 #include <asm/prom.h>
 #include <asm/time.h>
+#include <asm/mpc5xxx.h>
 
 #include "mpc512x.h"
 
+static struct mpc512x_reset_module __iomem *reset_module_base;
+
+static int __init mpc512x_restart_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-reset");
+	if (!np)
+		return -1;
+
+	reset_module_base = of_iomap(np, 0);
+	of_node_put(np);
+
+	return 0;
+}
+
+void mpc512x_restart(char *cmd)
+{
+	struct mpc512x_reset_module *rm = reset_module_base;
+
+	if (rm) {
+		/* Enable software reset "RSTE" */
+		out_be32(&rm->rpr, 0x52535445);
+		/* Set software hard reset */
+		out_be32(&rm->rcr, 0x2);
+	} else {
+		pr_err("Restart module not mapped.\n");
+	}
+	for (;;)
+		;
+}
+
 void __init mpc512x_init_IRQ(void)
 {
 	struct device_node *np;
@@ -62,4 +95,5 @@ void __init mpc512x_init(void)
 {
 	mpc512x_declare_of_platform_devices();
 	mpc5121_clk_init();
+	mpc512x_restart_init();
 }
-- 
1.6.3.3
