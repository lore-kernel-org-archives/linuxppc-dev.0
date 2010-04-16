Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id AFCA4B7CF5
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Apr 2010 05:07:30 +1000 (EST)
Date: Fri, 16 Apr 2010 23:07:24 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx/86xx: Fix build w/ CONFIG_PCI=n
Message-ID: <20100416190724.GA15891@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently some MPC85xx and MPC86xx boards fail to build without
CONFIG_PCI:

arch/powerpc/platforms/fsl_uli1575.c: In function 'quirk_final_uli5249':
arch/powerpc/platforms/fsl_uli1575.c:234: error: implicit declaration of function 'pci_bus_for_each_resource'
arch/powerpc/platforms/fsl_uli1575.c:234: error: expected ';' before '{' token
cc1: warnings being treated as errors
arch/powerpc/platforms/fsl_uli1575.c:223: warning: unused variable 'dummy'
make[1]: *** [arch/powerpc/platforms/fsl_uli1575.o] Error 1

This patch fixes the issue by appending 'if PCI' condition when
selecting FSL_ULI1575 Kconfig symbol.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/powerpc/platforms/85xx/Kconfig |    4 ++--
 arch/powerpc/platforms/86xx/Kconfig |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index d951218..3a2ade2 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -51,7 +51,7 @@ config MPC85xx_DS
 	bool "Freescale MPC85xx DS"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
-	select FSL_ULI1575
+	select FSL_ULI1575 if PCI
 	select SWIOTLB
 	help
 	  This option enables support for the MPC85xx DS (MPC8544 DS) board
@@ -60,7 +60,7 @@ config MPC85xx_RDB
 	bool "Freescale MPC85xx RDB"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
-	select FSL_ULI1575
+	select FSL_ULI1575 if PCI
 	select SWIOTLB
 	help
 	  This option enables support for the MPC85xx RDB (P2020 RDB) board
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index fbe9f36..a0b5638 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -13,7 +13,7 @@ config MPC8641_HPCN
 	bool "Freescale MPC8641 HPCN"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
-	select FSL_ULI1575
+	select FSL_ULI1575 if PCI
 	select HAS_RAPIDIO
 	select SWIOTLB
 	help
@@ -28,7 +28,7 @@ config SBC8641D
 config MPC8610_HPCD
 	bool "Freescale MPC8610 HPCD"
 	select DEFAULT_UIMAGE
-	select FSL_ULI1575
+	select FSL_ULI1575 if PCI
 	help
 	  This option enables support for the MPC8610 HPCD board.
 
-- 
1.7.0.3
