Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 6243AB7D7D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 07:24:22 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/11] powerpc/mpc5121: Add machine restart support
Date: Tue, 19 Jan 2010 21:24:05 +0100
Message-Id: <1263932653-3634-4-git-send-email-agust@denx.de>
In-Reply-To: <1263932653-3634-1-git-send-email-agust@denx.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
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
 arch/powerpc/include/asm/mpc5xxx.h            |   14 +++++++++-
 arch/powerpc/platforms/512x/mpc5121_ads.c     |    1 +
 arch/powerpc/platforms/512x/mpc5121_generic.c |    1 +
 arch/powerpc/platforms/512x/mpc512x.h         |    1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c  |   35 +++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 1 deletions(-)

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
index 441abc4..2f40404 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -68,4 +68,5 @@ define_machine(mpc5121_ads) {
 	.init_IRQ		= mpc5121_ads_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
+	.restart		= mpc512x_restart,
 };
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
index 2479de9..de4c3f7 100644
--- a/arch/powerpc/platforms/512x/mpc5121_generic.c
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -55,4 +55,5 @@ define_machine(mpc5121_generic) {
 	.init_IRQ		= mpc512x_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
+	.restart		= mpc512x_restart,
 };
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index 22a5352..c38875c 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -12,5 +12,6 @@
 #ifndef __MPC512X_H__
 #define __MPC512X_H__
 extern void __init mpc512x_init_IRQ(void);
+extern void mpc512x_restart(char *cmd);
 void __init mpc512x_declare_of_platform_devices(void);
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 434d683..8a0d577 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -21,9 +21,44 @@
 #include <asm/ipic.h>
 #include <asm/prom.h>
 #include <asm/time.h>
+#include <asm/mpc5xxx.h>
 
 #include "mpc512x.h"
 
+static void __iomem *reset_module_base;
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
+arch_initcall(mpc512x_restart_init);
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
+		printk(KERN_ERR ": Restart module not mapped.\n");
+	}
+	for (;;)
+		;
+}
+
 void __init mpc512x_init_IRQ(void)
 {
 	struct device_node *np;
-- 
1.5.6.3
