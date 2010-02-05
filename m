Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6A609B7EF2
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 00:43:43 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 01/11] powerpc/mpc5121: avoid using arch_initcall for clock
	init
Date: Fri,  5 Feb 2010 14:42:47 +0100
Message-Id: <1265377377-29327-2-git-send-email-agust@denx.de>
In-Reply-To: <1265377377-29327-1-git-send-email-agust@denx.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move mpc5121_clk_init() call to platform init code so it won't
get called on non-5121 platforms on a multiplatform kernel.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
Note to avoid confusion: this patch is new and was not
in previous v2 patch series. It was generated as a cleanup
patch before adding following patches.

 arch/powerpc/platforms/512x/clock.c           |    5 +----
 arch/powerpc/platforms/512x/mpc5121_ads.c     |    2 +-
 arch/powerpc/platforms/512x/mpc5121_generic.c |    2 +-
 arch/powerpc/platforms/512x/mpc512x.h         |    2 ++
 arch/powerpc/platforms/512x/mpc512x_shared.c  |    5 +++++
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index 84544d0..8733143 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -698,7 +698,7 @@ static struct clk_interface mpc5121_clk_functions = {
 	.clk_get_parent		= NULL,
 };
 
-static int
+int __init
 mpc5121_clk_init(void)
 {
 	struct device_node *np;
@@ -724,6 +724,3 @@ mpc5121_clk_init(void)
 	clk_functions = mpc5121_clk_functions;
 	return 0;
 }
-
-
-arch_initcall(mpc5121_clk_init);
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 441abc4..0f8f2e9 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -64,7 +64,7 @@ define_machine(mpc5121_ads) {
 	.name			= "MPC5121 ADS",
 	.probe			= mpc5121_ads_probe,
 	.setup_arch		= mpc5121_ads_setup_arch,
-	.init			= mpc512x_declare_of_platform_devices,
+	.init			= mpc512x_init,
 	.init_IRQ		= mpc5121_ads_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
index 2479de9..9b8c9b0 100644
--- a/arch/powerpc/platforms/512x/mpc5121_generic.c
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -51,7 +51,7 @@ static int __init mpc5121_generic_probe(void)
 define_machine(mpc5121_generic) {
 	.name			= "MPC5121 generic",
 	.probe			= mpc5121_generic_probe,
-	.init			= mpc512x_declare_of_platform_devices,
+	.init			= mpc512x_init,
 	.init_IRQ		= mpc512x_init_IRQ,
 	.get_irq		= ipic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index 22a5352..ac3da1a 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -12,5 +12,7 @@
 #ifndef __MPC512X_H__
 #define __MPC512X_H__
 extern void __init mpc512x_init_IRQ(void);
+extern void __init mpc512x_init(void);
+extern int __init mpc5121_clk_init(void);
 void __init mpc512x_declare_of_platform_devices(void);
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 434d683..b683165 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -58,3 +58,8 @@ void __init mpc512x_declare_of_platform_devices(void)
 			"Error while probing of_platform bus\n");
 }
 
+void __init mpc512x_init(void)
+{
+	mpc512x_declare_of_platform_devices();
+	mpc5121_clk_init();
+}
-- 
1.6.3.3
