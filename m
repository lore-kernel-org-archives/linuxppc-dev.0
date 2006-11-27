Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 4CC7467DEE
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:17:13 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/9] [POWERPC] Put mpc52xx support file in platforms/52xx
Date: Mon, 27 Nov 2006 14:16:24 -0700
Message-Id: <11646622073115-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11646622063980-git-send-email-grant.likely@secretlab.ca>
References: <1164662190802-git-send-email-grant.likely@secretlab.ca>
	<11646622052490-git-send-email-grant.likely@secretlab.ca>
	<11646622063980-git-send-email-grant.likely@secretlab.ca>
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

platforms/embedded6xx is probably going away, and 52xx boards need some extra
support the 52xx interrupt controller and DMA engine anyway.  It makes sense
to group all the 52xx bits into a single path

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/Kconfig                       |    4 ++++
 arch/powerpc/platforms/embedded6xx/Kconfig |   12 ------------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c9949d9..2c6f8d1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -408,6 +408,10 @@ config PPC_CHRP
 	select PPC_UDBG_16550
 	default y
 
+config PPC_MPC52xx
+	bool
+	default n
+
 config PPC_EFIKA
 	bool "bPlan Efika 5k2. MPC5200B based computer"
 	depends on PPC_MULTIPLATFORM && PPC32
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 234a861..910d50a 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -146,15 +146,6 @@ config PQ2FADS
 	  Select PQ2FADS if you wish to configure for a Freescale
 	  PQ2FADS board (-VR or -ZU).
 
-config LITE5200
-	bool "Freescale LITE5200 / (IceCube)"
-	select PPC_MPC52xx
-	help
-	  Support for the LITE5200 dev board for the MPC5200 from Freescale.
-	  This is for the LITE5200 version 2.0 board. Don't know if it changes
-	  much but it's only been tested on this board version. I think this
-	  board is also known as IceCube.
-
 config EV64360
 	bool "Marvell-EV64360BP"
 	help
@@ -172,9 +163,6 @@ config TQM8xxL
 	depends on 8xx && (TQM823L || TQM850L || FPS850L || TQM855L || TQM860L)
 	default y
 
-config PPC_MPC52xx
-	bool
-
 config 8260
 	bool "CPM2 Support" if WILLOW
 	depends on 6xx
-- 
1.4.3.rc2.g0503
