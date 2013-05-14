Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 935B72C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 00:41:41 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 1/2] powerpc/mpc512x: move common code to shared.c file
Date: Tue, 14 May 2013 16:40:53 +0200
Message-Id: <1368542454-11003-2-git-send-email-gsi@denx.de>
In-Reply-To: <1368542454-11003-1-git-send-email-gsi@denx.de>
References: <1368542454-11003-1-git-send-email-gsi@denx.de>
Cc: Gerhard Sittig <gsi@denx.de>, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- implement all of the init, init early, and setup arch routines in the
  shared source file for the MPC512x PowerPC platform, and make all
  MPC512x based boards (ADS, PDM, generic) use those common routines
- remove declarations from header files for routines which aren't
  referenced from external callers any longer

this modification concentrates knowledge about the optional FSL DIU
support in one spot within the shared code, and makes all boards benefit
transparently from future improvements in the shared platform code

the change does not modify any behaviour but preserves all code paths

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/include/asm/mpc5121.h            |    1 -
 arch/powerpc/platforms/512x/mpc5121_ads.c     |    6 ++----
 arch/powerpc/platforms/512x/mpc512x.h         |   11 ++---------
 arch/powerpc/platforms/512x/mpc512x_generic.c |    4 ++--
 arch/powerpc/platforms/512x/mpc512x_shared.c  |   14 +++++++++++++-
 arch/powerpc/platforms/512x/pdm360ng.c        |    4 ++--
 6 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc5121.h b/arch/powerpc/include/asm/mpc5121.h
index 885c040..8ae133e 100644
--- a/arch/powerpc/include/asm/mpc5121.h
+++ b/arch/powerpc/include/asm/mpc5121.h
@@ -68,6 +68,5 @@ struct mpc512x_lpc {
 };
 
 int mpc512x_cs_config(unsigned int cs, u32 val);
-int __init mpc5121_clk_init(void);
 
 #endif /* __ASM_POWERPC_MPC5121_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 0a134e0..3e90ece 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -43,9 +43,7 @@ static void __init mpc5121_ads_setup_arch(void)
 		mpc83xx_add_bridge(np);
 #endif
 
-#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
-	mpc512x_setup_diu();
-#endif
+	mpc512x_setup_arch();
 }
 
 static void __init mpc5121_ads_init_IRQ(void)
@@ -69,7 +67,7 @@ define_machine(mpc5121_ads) {
 	.probe			= mpc5121_ads_probe,
 	.setup_arch		= mpc5121_ads_setup_arch,
 	.init			= mpc512x_init,
-	.init_early		= mpc512x_init_diu,
+	.init_early		= mpc512x_init_early,
 	.init_IRQ		= mpc5121_ads_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index 0a8e600..fdb4303 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -12,18 +12,11 @@
 #ifndef __MPC512X_H__
 #define __MPC512X_H__
 extern void __init mpc512x_init_IRQ(void);
+extern void __init mpc512x_init_early(void);
 extern void __init mpc512x_init(void);
+extern void __init mpc512x_setup_arch(void);
 extern int __init mpc5121_clk_init(void);
-void __init mpc512x_declare_of_platform_devices(void);
 extern const char *mpc512x_select_psc_compat(void);
 extern void mpc512x_restart(char *cmd);
 
-#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
-void mpc512x_init_diu(void);
-void mpc512x_setup_diu(void);
-#else
-#define mpc512x_init_diu NULL
-#define mpc512x_setup_diu NULL
-#endif
-
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_generic.c b/arch/powerpc/platforms/512x/mpc512x_generic.c
index 5fb919b..ce71408 100644
--- a/arch/powerpc/platforms/512x/mpc512x_generic.c
+++ b/arch/powerpc/platforms/512x/mpc512x_generic.c
@@ -45,8 +45,8 @@ define_machine(mpc512x_generic) {
 	.name			= "MPC512x generic",
 	.probe			= mpc512x_generic_probe,
 	.init			= mpc512x_init,
-	.init_early		= mpc512x_init_diu,
-	.setup_arch		= mpc512x_setup_diu,
+	.init_early		= mpc512x_init_early,
+	.setup_arch		= mpc512x_setup_arch,
 	.init_IRQ		= mpc512x_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 6eb94ab..09622d3 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -58,7 +58,7 @@ void mpc512x_restart(char *cmd)
 		;
 }
 
-#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
+#if IS_ENABLED(CONFIG_FB_FSL_DIU)
 
 struct fsl_diu_shared_fb {
 	u8		gamma[0x300];	/* 32-bit aligned! */
@@ -436,6 +436,12 @@ void __init mpc512x_psc_fifo_init(void)
 	}
 }
 
+void __init mpc512x_init_early(void)
+{
+	if (IS_ENABLED(CONFIG_FB_FSL_DIU))
+		mpc512x_init_diu();
+}
+
 void __init mpc512x_init(void)
 {
 	mpc5121_clk_init();
@@ -444,6 +450,12 @@ void __init mpc512x_init(void)
 	mpc512x_psc_fifo_init();
 }
 
+void __init mpc512x_setup_arch(void)
+{
+	if (IS_ENABLED(CONFIG_FB_FSL_DIU))
+		mpc512x_setup_diu();
+}
+
 /**
  * mpc512x_cs_config - Setup chip select configuration
  * @cs: chip select number
diff --git a/arch/powerpc/platforms/512x/pdm360ng.c b/arch/powerpc/platforms/512x/pdm360ng.c
index 0575e85..24b314d 100644
--- a/arch/powerpc/platforms/512x/pdm360ng.c
+++ b/arch/powerpc/platforms/512x/pdm360ng.c
@@ -119,9 +119,9 @@ static int __init pdm360ng_probe(void)
 define_machine(pdm360ng) {
 	.name			= "PDM360NG",
 	.probe			= pdm360ng_probe,
-	.setup_arch		= mpc512x_setup_diu,
+	.setup_arch		= mpc512x_setup_arch,
 	.init			= pdm360ng_init,
-	.init_early		= mpc512x_init_diu,
+	.init_early		= mpc512x_init_early,
 	.init_IRQ		= mpc512x_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
-- 
1.7.10.4
