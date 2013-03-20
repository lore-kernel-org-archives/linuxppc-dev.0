Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from ns1.gatteins.it (ns1.gatteins.it [193.58.239.94])
 by ozlabs.org (Postfix) with ESMTP id AEAC12C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 04:42:12 +1100 (EST)
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc/512x: move mpc5121_generic platform to
 mpc512x_generic.
Date: Wed, 20 Mar 2013 18:41:52 +0100
Message-Id: <1363801314-16967-2-git-send-email-matteo.facchinetti@sirius-es.it>
In-Reply-To: <1363801314-16967-1-git-send-email-matteo.facchinetti@sirius-es.it>
References: <1363801314-16967-1-git-send-email-matteo.facchinetti@sirius-es.it>
Cc: gregkh@linuxfoundation.org,
 Matteo Facchinetti <matteo.facchinetti@sirius-es.it>, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This provides a base for using 512x_generic platform on mpc5125 boards.

By this way 512x_GENERIC it could be used for all generic mpc512x boards
and kernel could be compiled with mpc512x_defconfig.

Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
---
 arch/powerpc/configs/mpc512x_defconfig                         |    2 +-
 arch/powerpc/platforms/512x/Kconfig                            |    8 ++++----
 arch/powerpc/platforms/512x/Makefile                           |    2 +-
 .../platforms/512x/{mpc5121_generic.c => mpc512x_generic.c}    |    0
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/powerpc/platforms/512x/{mpc5121_generic.c => mpc512x_generic.c} (100%)

diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index 211fcc9..0d0d981 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -13,7 +13,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_PPC_CHRP is not set
 CONFIG_PPC_MPC512x=y
 CONFIG_MPC5121_ADS=y
-CONFIG_MPC5121_GENERIC=y
+CONFIG_MPC512x_GENERIC=y
 CONFIG_PDM360NG=y
 # CONFIG_PPC_PMAC is not set
 CONFIG_NO_HZ=y
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index c169998..eb46203 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -15,16 +15,16 @@ config MPC5121_ADS
 	help
 	  This option enables support for the MPC5121E ADS board.
 
-config MPC5121_GENERIC
-	bool "Generic support for simple MPC5121 based boards"
+config MPC512x_GENERIC
+	bool "Generic support for simple MPC512x based boards"
 	depends on PPC_MPC512x
 	select DEFAULT_UIMAGE
 	help
-	  This option enables support for simple MPC5121 based boards
+	  This option enables support for simple MPC512x based boards
 	  which do not need custom platform specific setup.
 
 	  Compatible boards include:  Protonic LVT base boards (ZANMCU
-	  and VICVT2).
+	  and VICVT2), Freescale MPC5125 Tower system.
 
 config PDM360NG
 	bool "ifm PDM360NG board"
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
index 4efc1c4..72fb934 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -3,5 +3,5 @@
 #
 obj-y				+= clock.o mpc512x_shared.o
 obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o mpc5121_ads_cpld.o
-obj-$(CONFIG_MPC5121_GENERIC)	+= mpc5121_generic.o
+obj-$(CONFIG_MPC512x_GENERIC)	+= mpc512x_generic.o
 obj-$(CONFIG_PDM360NG)		+= pdm360ng.o
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc512x_generic.c
similarity index 100%
rename from arch/powerpc/platforms/512x/mpc5121_generic.c
rename to arch/powerpc/platforms/512x/mpc512x_generic.c
-- 
1.7.10.4
