Return-Path: <baruch@tkos.co.il>
Received: from tango.tkos.co.il (tango.tkos.co.il [62.219.50.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 490E91007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 18:32:30 +1100 (EST)
From: Baruch Siach <baruch@tkos.co.il>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4] powerpc: 85xx: separate e500 from e500mc
Date: Tue,  8 Nov 2011 09:31:30 +0200
Message-Id: <5b7992dbbf0f10ab3207a8e3a0520597f10a7044.1320737269.git.baruch@tkos.co.il>
Cc: Scott Wood <scottwood@freescale.com>, Baruch Siach <baruch@tkos.co.il>,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_E500MC breaks e500/e500v2 systems. It defines L1_CACHE_SHIFT to 6, thus
breaking clear_pages(), probably others too.

This patch adds a new "Processor Type" entry for e500mc, and makes e500 systems
depend on PPC_E500_V1_V2.

Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

Changes from v3:

	* Rebase on 3.2-rc1 (add P3060_QDS)

Changes from v2:

	* s/CONFIG_PPC_E500/CONFIG_PPC_E500_V1_V2/ as suggested by Scott Wood

Changes from v1:

	* Rebase on 3.1-rc1

	* Remove the list of processor families from the PPC_E500 and 
	  PPC_E500MC options description. The P20xx can be either e500v2 or 
	  e500mc.

 arch/powerpc/platforms/85xx/Kconfig    |   14 +++++++++-----
 arch/powerpc/platforms/Kconfig.cputype |   27 +++++++++++++++------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 45023e2..cfa2bc9 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -13,6 +13,8 @@ if FSL_SOC_BOOKE
 
 if PPC32
 
+if PPC_E500_V1_V2
+
 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
 	select DEFAULT_UIMAGE
@@ -171,10 +173,13 @@ config SBC8560
 	help
 	  This option enables support for the Wind River SBC8560 board
 
+endif # PPC_E500_V1_V2
+
+if PPC_E500MC
+
 config P2041_RDB
 	bool "Freescale P2041 RDB"
 	select DEFAULT_UIMAGE
-	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
 	select ARCH_REQUIRE_GPIOLIB
@@ -187,7 +192,6 @@ config P2041_RDB
 config P3041_DS
 	bool "Freescale P3041 DS"
 	select DEFAULT_UIMAGE
-	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
 	select ARCH_REQUIRE_GPIOLIB
@@ -200,7 +204,6 @@ config P3041_DS
 config P3060_QDS
 	bool "Freescale P3060 QDS"
 	select DEFAULT_UIMAGE
-	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
 	select MPC8xxx_GPIO
@@ -212,7 +215,6 @@ config P3060_QDS
 config P4080_DS
 	bool "Freescale P4080 DS"
 	select DEFAULT_UIMAGE
-	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
 	select ARCH_REQUIRE_GPIOLIB
@@ -222,13 +224,15 @@ config P4080_DS
 	help
 	  This option enables support for the P4080 DS board
 
+endif # PPC_E500MC
+
 endif # PPC32
 
 config P5020_DS
 	bool "Freescale P5020 DS"
+	depends on PPC_E500MC
 	select DEFAULT_UIMAGE
 	select E500
-	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index fbecae0..e08d1e3 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -10,13 +10,13 @@ choice
 	prompt "Processor Type"
 	depends on PPC32
 	help
-	  There are five families of 32 bit PowerPC chips supported.
+	  There are six families of 32 bit PowerPC chips supported.
 	  The most common ones are the desktop and server CPUs (601, 603,
 	  604, 740, 750, 74xx) CPUs from Freescale and IBM, with their
 	  embedded 512x/52xx/82xx/83xx/86xx counterparts.
-	  The other embeeded parts, namely 4xx, 8xx, e200 (55xx) and e500
-	  (85xx) each form a family of their own that is not compatible
-	  with the others.
+	  The other embedded parts, namely 4xx, 8xx, e200 (55xx), e500
+	  (85xx), and e500mc each form a family of their own that is not
+	  compatible with the others.
 
 	  If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
 
@@ -24,10 +24,15 @@ config PPC_BOOK3S_32
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_FPU
 
-config PPC_85xx
-	bool "Freescale 85xx"
+config PPC_E500_V1_V2
+	bool "Freescale e500v1/e500v2"
+	select PPC_85xx
 	select E500
 
+config PPC_E500MC
+	bool "Freescale e500mc/e5500"
+	select PPC_85xx
+
 config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC
@@ -129,15 +134,13 @@ config TUNE_CELL
 config 8xx
 	bool
 
-config E500
+config PPC_85xx
+	bool
 	select FSL_EMB_PERFMON
 	select PPC_FSL_BOOK3E
-	bool
 
-config PPC_E500MC
-	bool "e500mc Support"
-	select PPC_FPU
-	depends on E500
+config E500
+	bool
 
 config PPC_FPU
 	bool
-- 
1.7.7.1
