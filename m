Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 34629DDDE4
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 06:17:47 +1000 (EST)
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1HvIzl-0002x5-00
	for <linuxppc-dev@ozlabs.org>; Mon, 04 Jun 2007 22:17:41 +0200
Date: Mon, 4 Jun 2007 22:17:41 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] add rtc-on-i2c node to two linkstation device-trees
Message-ID: <Pine.LNX.4.60.0706042159090.3653@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If approved here, this patch will follow the previous one for i2c-of 
definitions to the -mm tree, to fix linkstation breakage caused by 
converting rtc-rs5c372 driver to the new i2c api.

Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>

diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index 919eb29..4a904b1 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -70,11 +70,20 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 
 		i2c@80003000 {
 			linux,phandle = <4300>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <80003000 1000>;
 			interrupts = <5 2>;
 			interrupt-parent = <4400>;
+
+			rtc@32 {
+				device_type = "rtc";
+				compatible = "rtc-rs5c372";
+				model = "rs5c372b";
+				reg = <32>;
+			};
 		};
 
 		serial@80004500 {
diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index 157dc98..b5c0e78 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -70,11 +70,20 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 
 		i2c@80003000 {
 			linux,phandle = <4300>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <80003000 1000>;
 			interrupts = <5 2>;
 			interrupt-parent = <4400>;
+
+			rtc@32 {
+				device_type = "rtc";
+				compatible = "rtc-rs5c372";
+				model = "rs5c372b";
+				reg = <32>;
+			};
 		};
 
 		serial@80004500 {
