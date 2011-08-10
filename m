Return-Path: <baruch@tkos.co.il>
Received: from tango.tkos.co.il (tango.tkos.co.il [62.219.50.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75EEDB71A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 15:22:44 +1000 (EST)
From: Baruch Siach <baruch@tkos.co.il>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] powerpc: 85xx: separate e500 from e500mc
Date: Wed, 10 Aug 2011 08:21:18 +0300
Message-Id: <b965536bbd0457ab9614777dc00fc0dd22cf1d47.1312953203.git.baruch@tkos.co.il>
In-Reply-To: <20110810044307.GA2804@sapphire.tkos.co.il>
References: <20110810044307.GA2804@sapphire.tkos.co.il>
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

Changes from v2:

	* s/CONFIG_PPC_E500/CONFIG_PPC_E500_V1_V2/ to avoid confusion as
	  noted by Scott Wood

Changes from v1:

	* Rebase on 3.1-rc1

	* Remove the list of processor families from the PPC_E500 and 
	  PPC_E500MC options description. The P20xx can be either e500v2 or 
	  e500mc.

 arch/powerpc/platforms/85xx/Kconfig    |   13 +++++++++----
 arch/powerpc/platforms/Kconfig.cputype |   27 +++++++++++++++------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 498534c..00d4720 100644
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
 config P2040_RDB
 	bool "Freescale P2040 RDB"
 	select DEFAULT_UIMAGE
-	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
 	select MPC8xxx_GPIO
@@ -186,7 +191,6 @@ config P2040_RDB
 config P3041_DS
 	bool "Freescale P3041 DS"
 	select DEFAULT_UIMAGE
-	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
 	select MPC8xxx_GPIO
@@ -198,7 +202,6 @@ config P3041_DS
 config P4080_DS
 	bool "Freescale P4080 DS"
 	select DEFAULT_UIMAGE
-	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
 	select MPC8xxx_GPIO
@@ -207,13 +210,15 @@ config P4080_DS
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
 	select MPC8xxx_GPIO
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e06e395..e6cb00c 100644
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
+	  The other embeeded parts, namely 4xx, 8xx, e200 (55xx), e500
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
@@ -128,15 +133,13 @@ config TUNE_CELL
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
1.7.5.4
