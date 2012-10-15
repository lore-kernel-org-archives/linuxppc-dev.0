Return-Path: <B04825@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A1AE22C00B5
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2012 06:52:57 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, <paul.gortmaker@windriver.com>,
 Anatolij Gustschin <agust@denx.de>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] [v2] powerpc/512x: don't compile any platform DIU code if
 the DIU is not enabled
Date: Mon, 15 Oct 2012 14:52:20 -0500
Message-ID: <1350330741-11390-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the DIU framebuffer driver is not enabled, then there's no point in
compiling any platform DIU code, because it will never be used.  Most of
the platform code was protected in the appropriate #ifdef, but not all.
This caused a break in some randconfig builds.

This is only a problem on the 512x platforms.  The P1022DS and MPC8610HPCD
platforms are already correct.

This patch reverts commit 12e36309f8774f4ccc769d5e3ff11ef092e524bc ("powerpc:
Option FB_FSL_DIU is not really optional for mpc512x") and restores the
ability to configure DIU support.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/512x/Kconfig          |    1 -
 arch/powerpc/platforms/512x/mpc5121_ads.c    |    3 +++
 arch/powerpc/platforms/512x/mpc512x.h        |   11 +++++++++--
 arch/powerpc/platforms/512x/mpc512x_shared.c |   25 ++++---------------------
 4 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index b62508b..c169998 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -2,7 +2,6 @@ config PPC_MPC512x
 	bool "512x-based boards"
 	depends on 6xx
 	select FSL_SOC
-	select FB_FSL_DIU
 	select IPIC
 	select PPC_CLOCK
 	select PPC_PCI_CHOICE
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index dcef6ad..0a134e0 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -42,7 +42,10 @@ static void __init mpc5121_ads_setup_arch(void)
 	for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
 		mpc83xx_add_bridge(np);
 #endif
+
+#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 	mpc512x_setup_diu();
+#endif
 }
 
 static void __init mpc5121_ads_init_IRQ(void)
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index 1ab6d11..c32b399 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -16,6 +16,13 @@ extern void __init mpc512x_init(void);
 extern int __init mpc5121_clk_init(void);
 void __init mpc512x_declare_of_platform_devices(void);
 extern void mpc512x_restart(char *cmd);
-extern void mpc512x_init_diu(void);
-extern void mpc512x_setup_diu(void);
+
+#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
+void mpc512x_init_diu(void);
+void mpc512x_setup_diu(void);
+#else
+#define mpc512x_init_diu NULL
+#define mpc512x_setup_diu NULL
+#endif
+
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 1650e09..35f14fd 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -58,6 +58,8 @@ void mpc512x_restart(char *cmd)
 		;
 }
 
+#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
+
 struct fsl_diu_shared_fb {
 	u8		gamma[0x300];	/* 32-bit aligned! */
 	struct diu_ad	ad0;		/* 32-bit aligned! */
@@ -66,25 +68,6 @@ struct fsl_diu_shared_fb {
 	bool		in_use;
 };
 
-u32 mpc512x_get_pixel_format(enum fsl_diu_monitor_port port,
-			     unsigned int bits_per_pixel)
-{
-	switch (bits_per_pixel) {
-	case 32:
-		return 0x88883316;
-	case 24:
-		return 0x88082219;
-	case 16:
-		return 0x65053118;
-	}
-	return 0x00000400;
-}
-
-void mpc512x_set_gamma_table(enum fsl_diu_monitor_port port,
-			     char *gamma_table_base)
-{
-}
-
 void mpc512x_set_monitor_port(enum fsl_diu_monitor_port port)
 {
 }
@@ -320,14 +303,14 @@ void __init mpc512x_setup_diu(void)
 		}
 	}
 
-	diu_ops.get_pixel_format	= mpc512x_get_pixel_format;
-	diu_ops.set_gamma_table		= mpc512x_set_gamma_table;
 	diu_ops.set_monitor_port	= mpc512x_set_monitor_port;
 	diu_ops.set_pixel_clock		= mpc512x_set_pixel_clock;
 	diu_ops.valid_monitor_port	= mpc512x_valid_monitor_port;
 	diu_ops.release_bootmem		= mpc512x_release_bootmem;
 }
 
+#endif
+
 void __init mpc512x_init_IRQ(void)
 {
 	struct device_node *np;
-- 
1.7.3.4
