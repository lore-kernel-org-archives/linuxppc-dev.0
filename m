Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2x7S19NMzDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 20:55:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc: Make selects of IBM_EMAC_* depend on IBM_EMAC
Date: Mon,  1 Aug 2016 20:55:08 +1000
Message-Id: <1470048908-9405-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1470048908-9405-1-git-send-email-mpe@ellerman.id.au>
References: <1470048908-9405-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a bunch of Kconfig symbols which select various IBM_EMAC_*
symbols. These all cause warnings when IBM_EMAC is not selected.

eg.

  warning: (PPC_CELL_NATIVE && BLUESTONE && CANYONLANDS && GLACIER &&
  EIGER && 440EPX && 440GRX && 440GX && 460SX && 405EX) selects
  IBM_EMAC_RGMII which has unmet direct dependencies (NETDEVICES &&
  ETHERNET && NET_VENDOR_IBM)

So make them all depend on IBM_EMAC being enabled first.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/40x/Kconfig  | 12 ++++----
 arch/powerpc/platforms/44x/Kconfig  | 56 ++++++++++++++++++-------------------
 arch/powerpc/platforms/cell/Kconfig |  8 +++---
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index e3257f24a8a1..f8d1410aa5bb 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -102,18 +102,18 @@ config 405GP
 	bool
 	select IBM405_ERR77
 	select IBM405_ERR51
-	select IBM_EMAC_ZMII
+	select IBM_EMAC_ZMII if IBM_EMAC
 
 config 405EX
 	bool
-	select IBM_EMAC_EMAC4
-	select IBM_EMAC_RGMII
+	select IBM_EMAC_EMAC4 if IBM_EMAC
+	select IBM_EMAC_RGMII if IBM_EMAC
 
 config 405EZ
 	bool
-	select IBM_EMAC_NO_FLOW_CTRL
-	select IBM_EMAC_MAL_CLR_ICINTSTAT
-	select IBM_EMAC_MAL_COMMON_ERR
+	select IBM_EMAC_NO_FLOW_CTRL if IBM_EMAC
+	select IBM_EMAC_MAL_CLR_ICINTSTAT if IBM_EMAC
+	select IBM_EMAC_MAL_COMMON_ERR if IBM_EMAC
 
 config XILINX_VIRTEX
 	bool
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 48fc18041ff6..8d18669856f9 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -26,7 +26,7 @@ config BLUESTONE
 	select PCI_MSI
 	select PPC4xx_MSI
 	select PPC4xx_PCI_EXPRESS
-	select IBM_EMAC_RGMII
+	select IBM_EMAC_RGMII if IBM_EMAC
 	help
 	  This option enables support for the APM APM821xx Evaluation board.
 
@@ -125,8 +125,8 @@ config CANYONLANDS
 	select PPC4xx_PCI_EXPRESS
 	select PCI_MSI
 	select PPC4xx_MSI
-	select IBM_EMAC_RGMII
-	select IBM_EMAC_ZMII
+	select IBM_EMAC_RGMII if IBM_EMAC
+	select IBM_EMAC_ZMII if IBM_EMAC
 	help
 	  This option enables support for the AMCC PPC460EX evaluation board.
 
@@ -138,8 +138,8 @@ config GLACIER
 	select 460EX # Odd since it uses 460GT but the effects are the same
 	select PCI
 	select PPC4xx_PCI_EXPRESS
-	select IBM_EMAC_RGMII
-	select IBM_EMAC_ZMII
+	select IBM_EMAC_RGMII if IBM_EMAC
+	select IBM_EMAC_ZMII if IBM_EMAC
 	help
 	  This option enables support for the AMCC PPC460GT evaluation board.
 
@@ -164,7 +164,7 @@ config EIGER
 	select 460SX
 	select PCI
 	select PPC4xx_PCI_EXPRESS
-	select IBM_EMAC_RGMII
+	select IBM_EMAC_RGMII if IBM_EMAC
 	help
 	  This option enables support for the AMCC PPC460SX evaluation board.
 
@@ -213,7 +213,7 @@ config AKEBONO
 	select NETDEVICES
 	select ETHERNET
 	select NET_VENDOR_IBM
-	select IBM_EMAC_EMAC4
+	select IBM_EMAC_EMAC4 if IBM_EMAC
 	select USB if USB_SUPPORT
 	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
 	select USB_EHCI_HCD_PLATFORM if USB_EHCI_HCD
@@ -290,54 +290,54 @@ config 440EP
 	bool
 	select PPC_FPU
 	select IBM440EP_ERR42
-	select IBM_EMAC_ZMII
+	select IBM_EMAC_ZMII if IBM_EMAC
 
 config 440EPX
 	bool
 	select PPC_FPU
-	select IBM_EMAC_EMAC4
-	select IBM_EMAC_RGMII
-	select IBM_EMAC_ZMII
+	select IBM_EMAC_EMAC4 if IBM_EMAC
+	select IBM_EMAC_RGMII if IBM_EMAC
+	select IBM_EMAC_ZMII if IBM_EMAC
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	select USB_EHCI_BIG_ENDIAN_DESC
 
 config 440GRX
 	bool
-	select IBM_EMAC_EMAC4
-	select IBM_EMAC_RGMII
-	select IBM_EMAC_ZMII
+	select IBM_EMAC_EMAC4 if IBM_EMAC
+	select IBM_EMAC_RGMII if IBM_EMAC
+	select IBM_EMAC_ZMII if IBM_EMAC
 
 config 440GP
 	bool
-	select IBM_EMAC_ZMII
+	select IBM_EMAC_ZMII if IBM_EMAC
 
 config 440GX
 	bool
-	select IBM_EMAC_EMAC4
-	select IBM_EMAC_RGMII
-	select IBM_EMAC_ZMII #test only
-	select IBM_EMAC_TAH  #test only
+	select IBM_EMAC_EMAC4 if IBM_EMAC
+	select IBM_EMAC_RGMII if IBM_EMAC
+	select IBM_EMAC_ZMII if IBM_EMAC #test only
+	select IBM_EMAC_TAH if IBM_EMAC  #test only
 
 config 440SP
 	bool
 
 config 440SPe
 	bool
-	select IBM_EMAC_EMAC4
+	select IBM_EMAC_EMAC4 if IBM_EMAC
 
 config 460EX
 	bool
 	select PPC_FPU
-	select IBM_EMAC_EMAC4
-	select IBM_EMAC_TAH
+	select IBM_EMAC_EMAC4 if IBM_EMAC
+	select IBM_EMAC_TAH if IBM_EMAC
 
 config 460SX
 	bool
 	select PPC_FPU
-	select IBM_EMAC_EMAC4
-	select IBM_EMAC_RGMII
-	select IBM_EMAC_ZMII
-	select IBM_EMAC_TAH
+	select IBM_EMAC_EMAC4 if IBM_EMAC
+	select IBM_EMAC_RGMII if IBM_EMAC
+	select IBM_EMAC_ZMII if IBM_EMAC
+	select IBM_EMAC_TAH if IBM_EMAC
 
 config 476FPE
 	bool
@@ -346,8 +346,8 @@ config 476FPE
 config APM821xx
 	bool
 	select PPC_FPU
-	select IBM_EMAC_EMAC4
-	select IBM_EMAC_TAH
+	select IBM_EMAC_EMAC4 if IBM_EMAC
+	select IBM_EMAC_TAH if IBM_EMAC
 
 config 476FPE_ERR46
 	depends on 476FPE
diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 441ad3bad3db..a4522f09d65e 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -17,10 +17,10 @@ config PPC_CELL_NATIVE
 	select PPC_CELL_COMMON
 	select MPIC
 	select PPC_IO_WORKAROUNDS
-	select IBM_EMAC_EMAC4
-	select IBM_EMAC_RGMII
-	select IBM_EMAC_ZMII #test only
-	select IBM_EMAC_TAH  #test only
+	select IBM_EMAC_EMAC4 if IBM_EMAC
+	select IBM_EMAC_RGMII if IBM_EMAC
+	select IBM_EMAC_ZMII if IBM_EMAC #test only
+	select IBM_EMAC_TAH if IBM_EMAC  #test only
 	default n
 
 config PPC_IBM_CELL_BLADE
-- 
2.7.4
