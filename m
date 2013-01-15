Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 2653A2C007C
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2013 07:11:56 +1100 (EST)
From: Timur Tabi <timur@tabi.org>
To: Kumar Gala <galak@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl: remove extraneous DIU platform functions
Date: Tue, 15 Jan 2013 14:04:12 -0600
Message-Id: <1358280252-31261-1-git-send-email-timur@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>

The Freescale DIU driver was recently updated to not require a
set_monitor_port platform function if there is only one monitor port.  This
is the case on the P1022 RDK and the MPC5121 ADS boards.  So now we can
remove those functions.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/512x/mpc512x_shared.c |    5 -----
 arch/powerpc/platforms/85xx/p1022_rdk.c      |   12 ------------
 2 files changed, 0 insertions(+), 17 deletions(-)

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
