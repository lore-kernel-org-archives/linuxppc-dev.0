Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 41C162C0085
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2013 10:26:57 +1100 (EST)
From: Timur Tabi <timur@tabi.org>
To: Kumar Gala <kumar.gala@freescale.com>,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] [v2] powerpc/fsl: remove extraneous DIU platform functions
Date: Thu, 17 Jan 2013 17:26:54 -0600
Message-Id: <1358465214-18746-1-git-send-email-timur@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>

The Freescale DIU driver was recently updated to not require every DIU
platform function, so now we can remove the unneeded functions from
some boards.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/512x/mpc512x_shared.c |    5 ---
 arch/powerpc/platforms/85xx/p1022_ds.c       |   38 --------------------------
 arch/powerpc/platforms/85xx/p1022_rdk.c      |   12 --------
 3 files changed, 0 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 35f14fd..c7f47cf 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -68,10 +68,6 @@ struct fsl_diu_shared_fb {
 	bool		in_use;
 };
 
-void mpc512x_set_monitor_port(enum fsl_diu_monitor_port port)
-{
-}
-
 #define DIU_DIV_MASK	0x000000ff
 void mpc512x_set_pixel_clock(unsigned int pixclock)
 {
@@ -303,7 +299,6 @@ void __init mpc512x_setup_diu(void)
 		}
 	}
 
-	diu_ops.set_monitor_port	= mpc512x_set_monitor_port;
 	diu_ops.set_pixel_clock		= mpc512x_set_pixel_clock;
 	diu_ops.valid_monitor_port	= mpc512x_valid_monitor_port;
 	diu_ops.release_bootmem		= mpc512x_release_bootmem;
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 7328b8d..c4777ee 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -106,42 +106,6 @@
 	(c2 << AD_COMP_2_SHIFT) | (c1 << AD_COMP_1_SHIFT) | \
 	(c0 << AD_COMP_0_SHIFT) | (size << AD_PIXEL_S_SHIFT))
 
-/**
- * p1022ds_get_pixel_format: return the Area Descriptor for a given pixel depth
- *
- * The Area Descriptor is a 32-bit value that determine which bits in each
- * pixel are to be used for each color.
- */
-static u32 p1022ds_get_pixel_format(enum fsl_diu_monitor_port port,
-				    unsigned int bits_per_pixel)
-{
-	switch (bits_per_pixel) {
-	case 32:
-		/* 0x88883316 */
-		return MAKE_AD(3, 2, 0, 1, 3, 8, 8, 8, 8);
-	case 24:
-		/* 0x88082219 */
-		return MAKE_AD(4, 0, 1, 2, 2, 0, 8, 8, 8);
-	case 16:
-		/* 0x65053118 */
-		return MAKE_AD(4, 2, 1, 0, 1, 5, 6, 5, 0);
-	default:
-		pr_err("fsl-diu: unsupported pixel depth %u\n", bits_per_pixel);
-		return 0;
-	}
-}
-
-/**
- * p1022ds_set_gamma_table: update the gamma table, if necessary
- *
- * On some boards, the gamma table for some ports may need to be modified.
- * This is not the case on the P1022DS, so we do nothing.
-*/
-static void p1022ds_set_gamma_table(enum fsl_diu_monitor_port port,
-				    char *gamma_table_base)
-{
-}
-
 struct fsl_law {
 	u32	lawbar;
 	u32	reserved1;
@@ -510,8 +474,6 @@ static void __init p1022_ds_setup_arch(void)
 		ppc_md.progress("p1022_ds_setup_arch()", 0);
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
-	diu_ops.get_pixel_format	= p1022ds_get_pixel_format;
-	diu_ops.set_gamma_table		= p1022ds_set_gamma_table;
 	diu_ops.set_monitor_port	= p1022ds_set_monitor_port;
 	diu_ops.set_pixel_clock		= p1022ds_set_pixel_clock;
 	diu_ops.valid_monitor_port	= p1022ds_valid_monitor_port;
diff --git a/arch/powerpc/platforms/85xx/p1022_rdk.c b/arch/powerpc/platforms/85xx/p1022_rdk.c
index 55ffa1c..8c92971 100644
--- a/arch/powerpc/platforms/85xx/p1022_rdk.c
+++ b/arch/powerpc/platforms/85xx/p1022_rdk.c
@@ -35,17 +35,6 @@
 #define CLKDVDR_PXCLK_MASK	0x00FF0000
 
 /**
- * p1022rdk_set_monitor_port: switch the output to a different monitor port
- */
-static void p1022rdk_set_monitor_port(enum fsl_diu_monitor_port port)
-{
-	if (port != FSL_DIU_PORT_DVI) {
-		pr_err("p1022rdk: unsupported monitor port %i\n", port);
-		return;
-	}
-}
-
-/**
  * p1022rdk_set_pixel_clock: program the DIU's clock
  *
  * @pixclock: the wavelength, in picoseconds, of the clock
@@ -124,7 +113,6 @@ static void __init p1022_rdk_setup_arch(void)
 		ppc_md.progress("p1022_rdk_setup_arch()", 0);
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
-	diu_ops.set_monitor_port	= p1022rdk_set_monitor_port;
 	diu_ops.set_pixel_clock		= p1022rdk_set_pixel_clock;
 	diu_ops.valid_monitor_port	= p1022rdk_valid_monitor_port;
 #endif
-- 
1.7.3.4
