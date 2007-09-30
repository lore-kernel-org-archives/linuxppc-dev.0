Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 7F2A5DDEAB
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 08:22:06 +1000 (EST)
Received: from pd2mr1so.prod.shaw.ca
	(pd2mr1so-qfe3.prod.shaw.ca [10.0.141.110]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP7009AMCQJIG20@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:20:43 -0600 (MDT)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
	by pd2mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP700EWICQJS220@pd2mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 30 Sep 2007 16:20:43 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP700B8LCQ9ITZA@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:20:33 -0600 (MDT)
Date: Sun, 30 Sep 2007 16:20:33 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCHv2 2/4] Virtex: Add Kconfig macros for Xilinx Virtex board
	support
In-reply-to: <20070930221613.583.252.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20070930222025.583.11450.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070930221613.583.252.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Add the needed kconfig macros to enable Xilinx Virtex board support

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/40x/Kconfig |   38 ++++++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index c3dce3b..9d5574a 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -61,13 +61,22 @@ config WALNUT
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
+	default n
+	select VIRTEX_II_PRO
+	select VIRTEX_4_FX
+	help
+	  This option enables generic support for Xilinx Virtex based boards.
+
+	  The generic virtex board support matches any device tree which
+	  specifies 'xilinx,virtex' in its compatible field.  This includes
+	  the Xilinx ML3xx and ML4xx reference designs using the powerpc
+	  core.
+
+	  Most Virtex designs should use this unless it needs to do some
+	  special configuration at board probe time.
 
 # 40x specific CPU modules, selected based on the board above.
 config NP405H
@@ -91,11 +100,19 @@ config 405EP
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
@@ -111,11 +128,6 @@ config IBM405_ERR77
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
