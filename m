Return-Path: <vgallardo@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F334CDDF92
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 08:47:56 +1000 (EST)
From: Victor Gallardo <vgallardo@amcc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] Add AMCC Arches eval board support to platforms/44x
Date: Thu, 18 Sep 2008 15:47:52 -0700
Message-Id: <1221778072-6336-1-git-send-email-vgallardo@amcc.com>
Cc: fkan@amcc.com, Victor Gallardo <vgallardo@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Victor Gallardo <vgallardo@amcc.com>
---
 v2:
 - remove arches.c and instead use canyonlands.c
 - remove reference to IBM_NEW_EMAC_RGMII for ARCHES config
 - remove reference to IBM_NEW_EMAC_ZMII for ARCHES config
 - moved reference to IBM_NEW_EMAC_RGMII under CANYONLANDS config
 - moved reference to IBM_NEW_EMAC_ZMII under CANYONLANDS config

 arch/powerpc/platforms/44x/Kconfig  |   18 ++++++++++++++----
 arch/powerpc/platforms/44x/Makefile |    1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 249ba01..be1bce7 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -83,9 +83,23 @@ config CANYONLANDS
 	select 460EX
 	select PCI
 	select PPC4xx_PCI_EXPRESS
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_RGMII
+	select IBM_NEW_EMAC_ZMII
+	select IBM_NEW_EMAC_TAH
 	help
 	  This option enables support for the AMCC PPC460EX evaluation board.
 
+config ARCHES
+	bool "Arches"
+	depends on 44x
+	default n
+	select 460EX
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_TAH
+	help
+	  This option enables support for the AMCC PPC460GT evaluation board.
+
 config YOSEMITE
 	bool "Yosemite"
 	depends on 44x
@@ -169,10 +183,6 @@ config 440SPe
 config 460EX
 	bool
 	select PPC_FPU
-	select IBM_NEW_EMAC_EMAC4
-	select IBM_NEW_EMAC_RGMII
-	select IBM_NEW_EMAC_ZMII
-	select IBM_NEW_EMAC_TAH
 
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 8d0b1a1..3f83f73 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_KATMAI)	+= katmai.o
 obj-$(CONFIG_RAINIER)	+= rainier.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_WARP)	+= warp-nand.o
+obj-$(CONFIG_ARCHES)	+= canyonlands.o
 obj-$(CONFIG_CANYONLANDS) += canyonlands.o
 obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
-- 
1.5.5
