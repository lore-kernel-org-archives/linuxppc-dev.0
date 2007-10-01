Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1295EDDE05
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 00:13:20 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l91ECARr024043
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 18:12:10 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l91EC9w0024040
	for linuxppc-dev@ozlabs.org; Mon, 1 Oct 2007 18:12:09 +0400
Date: Mon, 1 Oct 2007 18:12:09 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: Add RGMII support for Sequoia 440EPx
Message-ID: <20071001141209.GA23971@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds RGMII support to Sequoia DTS and sets correct phy-mode
for EMACs. According to Sequoia datasheet, both ethernet ports
are connected to RGMII interface, while ZMII is used only for MDIO.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/dts/sequoia.dts  |   14 ++++++++++++--
 arch/powerpc/platforms/44x/Kconfig |    1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff -ruNp linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts linux-2.6/arch/powerpc/boot/dts/sequoia.dts
--- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	2007-09-29 16:59:29.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/dts/sequoia.dts	2007-09-29 17:35:55.000000000 +0400
@@ -241,6 +241,12 @@
 				reg = <ef600d00 c>;
 			};
 
+			RGMII0: emac-rgmii@ef601000 {
+				device_type = "rgmii-interface";
+				compatible = "ibm,rgmii-440epx", "ibm,rgmii";
+				reg = <ef601000 8>;
+			};
+
 			EMAC0: ethernet@ef600e00 {
 				linux,network-index = <0>;
 				device_type = "network";
@@ -261,10 +267,12 @@
 				max-frame-size = <5dc>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
-				phy-mode = "rmii";
+				phy-mode = "rgmii";
 				phy-map = <00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
+				rgmii-device = <&RGMII0>;
+				rgmii-channel = <0>;
 			};
 
 			EMAC1: ethernet@ef600f00 {
@@ -287,10 +295,12 @@
 				max-frame-size = <5dc>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
-				phy-mode = "rmii";
+				phy-mode = "rgmii";
 				phy-map = <00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
+				rgmii-device = <&RGMII0>;
+				rgmii-channel = <1>;
 			};
 		};
 	};
diff -ruNp linux-2.6.orig/arch/powerpc/platforms/44x/Kconfig linux-2.6/arch/powerpc/platforms/44x/Kconfig
--- linux-2.6.orig/arch/powerpc/platforms/44x/Kconfig	2007-09-29 16:59:31.000000000 +0400
+++ linux-2.6/arch/powerpc/platforms/44x/Kconfig	2007-09-29 17:59:51.000000000 +0400
@@ -50,6 +50,7 @@ config 440EPX
 	select PPC_FPU
 # Disabled until the new EMAC Driver is merged.
 #	select IBM_NEW_EMAC_EMAC4
+#	select IBM_NEW_EMAC_RGMII
 #	select IBM_NEW_EMAC_ZMII
 
 config 440GP
