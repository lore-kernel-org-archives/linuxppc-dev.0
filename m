Return-Path: <wg@denx.de>
Message-Id: <20090331124036.057237866@denx.de>
Date: Tue, 31 Mar 2009 14:37:33 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/8] --- arch/powerpc/boot/dts/socrates.dts | 9 +++++++-- 1
	file changed, 7 insertions(+), 2 deletions(-)
References: <20090331123727.853787299@denx.de>
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Index: linux-2.6/arch/powerpc/boot/dts/socrates.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/socrates.dts	2009-03-31 13:24:38.078719288 +0200
+++ linux-2.6/arch/powerpc/boot/dts/socrates.dts	2009-03-31 13:47:56.986720719 +0200
@@ -52,6 +52,7 @@
 	soc8544@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
+		device_type = "soc";
 
 		ranges = <0x00000000 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00001000>;	// CCSRBAR 1M
@@ -78,10 +79,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
-			compatible = "fsl-i2c";
+			compatible = "fsl,mpc8544-i2c", "fsl-i2c";
 			reg = <0x3000 0x100>;
 			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
+			clock-frequency = <103000>;
 			dfsrr;
 
 			dtt@28 {
@@ -110,10 +112,12 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <1>;
-			compatible = "fsl-i2c";
+			compatible = "fsl,mpc8544-i2c", "fsl-i2c";
 			reg = <0x3100 0x100>;
 			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
+			fsl,preserve-clocking;
+			clock-frequency = <400000>;
 			dfsrr;
 		};
 
@@ -207,6 +211,7 @@
 			compatible = "fsl,mpc8548-guts";
 			reg = <0xe0000 0x1000>;
 			fsl,has-rstcr;
+			fsl,has-sec-cfg;
 		};
 
 		mpic: pic@40000 {
