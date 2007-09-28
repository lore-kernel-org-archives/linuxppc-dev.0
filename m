Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 7B9A7DDEF7
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:17:00 +1000 (EST)
Received: from pd3mr6so.prod.shaw.ca (pd3mr6so-qfe3.prod.shaw.ca [10.0.141.21])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300IDUC2LZO60@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:15:57 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd3mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP3005I3C2G9E00@pd3mr6so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Sep 2007 12:15:55 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300MVOC2GGPL3@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:15:52 -0600 (MDT)
Date: Fri, 28 Sep 2007 12:16:01 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 02/18] Add Kconfig macros for Xilinx Virtex support
In-reply-to: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070928181558.18608.23527.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/40x/Kconfig |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index c3dce3b..1aae0e6 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -61,13 +61,14 @@ config WALNUT
 	help
 	  This option enables support for the IBM PPC405GP evaluation board.
 
-#config XILINX_ML300
-#	bool "Xilinx-ML300"
-#	depends on 40x
-#	default y
-#	select VIRTEX_II_PRO
-#	help
-#	  This option enables support for the Xilinx ML300 evaluation board.
+config XILINX_VIRTEX_GENERIC_BOARD
+	bool "Generic Xilinx Virtex board"
+	depends on 40x
+	default y
+	select VIRTEX_II_PRO
+	select VIRTEX_4_FX
+	help
+	  This option enables generic support for Xilinx Virtex based boards.
 
 # 40x specific CPU modules, selected based on the board above.
 config NP405H
@@ -91,11 +92,19 @@ config 405EP
 config 405GPR
 	bool
 
-config VIRTEX_II_PRO
+config XILINX_VIRTEX
 	bool
+
+config XILINX_VIRTEX_II_PRO
+	bool
+	select XILINX_VIRTEX
 	select IBM405_ERR77
 	select IBM405_ERR51
 
+config XILINX_VIRTEX_4_FX
+	bool
+	select XILINX_VIRTEX
+
 config STB03xxx
 	bool
 	select IBM405_ERR77
@@ -111,11 +120,6 @@ config IBM405_ERR77
 config IBM405_ERR51
 	bool
 
-#config XILINX_OCP
-#	bool
-#	depends on XILINX_ML300
-#	default y
-
 #config BIOS_FIXUP
 #	bool
 #	depends on BUBINGA || EP405 || SYCAMORE || WALNUT
