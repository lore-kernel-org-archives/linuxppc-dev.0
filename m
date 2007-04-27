Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id 3DC8BDE055
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 05:50:27 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org,
	paulus@samba.org
Subject: [PATCH 1/7] [PPC] Rework Kconfig dependancies for Xilinx Virtex
	ppc405 platform
Date: Fri, 27 Apr 2007 13:49:59 -0600
Message-Id: <1177703413868-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1177703413970-git-send-email-grant.likely@secretlab.ca>
References: <11777034052773-git-send-email-grant.likely@secretlab.ca>
	<1177703413970-git-send-email-grant.likely@secretlab.ca>
Cc: Peter Korsgaard <jacmet@sunsite.dk>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Rick Moleres <Rick.Moleres@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Reverse dependency order for Xilinx Virtex parts.  For these parts, It
makes more sense for boards/chips to specify which features they
provide instead of the features listing the parts they are implemented
in.  I think it also makes adding new board ports simpler.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/ppc/platforms/4xx/Kconfig |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 705ae56..76551b6 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -29,6 +29,7 @@ config CPCI405
 
 config EP405
 	bool "EP405/EP405PC"
+	select EMBEDDEDBOOT
 	help
 	  This option enables support for the EP405/EP405PC boards.
 
@@ -54,11 +55,15 @@ config WALNUT
 
 config XILINX_ML300
 	bool "Xilinx-ML300"
+	select XILINX_VIRTEX_II_PRO
+	select EMBEDDEDBOOT
 	help
 	  This option enables support for the Xilinx ML300 evaluation board.
 
 config XILINX_ML403
 	bool "Xilinx-ML403"
+	select XILINX_VIRTEX_4_FX
+	select EMBEDDEDBOOT
 	help
 	  This option enables support for the Xilinx ML403 evaluation board.
 endchoice
@@ -215,18 +220,14 @@ config 405GPR
 
 config XILINX_VIRTEX_II_PRO
 	bool
-	depends on XILINX_ML300
-	default y
+	select XILINX_VIRTEX
 
 config XILINX_VIRTEX_4_FX
 	bool
-	depends on XILINX_ML403
-	default y
+	select XILINX_VIRTEX
 
 config XILINX_VIRTEX
 	bool
-	depends on XILINX_VIRTEX_II_PRO || XILINX_VIRTEX_4_FX
-	default y
 
 config STB03xxx
 	bool
@@ -235,8 +236,6 @@ config STB03xxx
 
 config EMBEDDEDBOOT
 	bool
-	depends on EP405 || XILINX_ML300 || XILINX_ML403
-	default y
 
 config IBM_OPENBIOS
 	bool
-- 
1.5.1
