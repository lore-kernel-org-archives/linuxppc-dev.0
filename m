Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2E619DDF69
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 11:50:17 +1000 (EST)
Date: Fri, 25 Jul 2008 21:50:19 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Warp DTS changes
Message-ID: <20080725215019.5f441b7c@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added support for the new at24 eeprom driver.
Documented a new fpga section, the DMA scatter gather list.
Removed index from i2c. No longer needed.
Fixed the leds section.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
index 340018c..7300736 100644
--- a/arch/powerpc/boot/dts/warp.dts
+++ b/arch/powerpc/boot/dts/warp.dts
@@ -139,6 +139,11 @@
 					interrupt-parent = <&UIC0>;
 				};
 
+				fpga@2,2000 {
+					compatible = "pika,fpga-sgl";
+			   		reg = <0x00000002 0x00002000 0x00000200>;
+				};
+
 				fpga@2,4000 {
 					compatible = "pika,fpga-sd";
 					reg = <0x00000002 0x00004000 0x00000A00>;
@@ -181,7 +186,6 @@
 				reg = <0xef600700 0x00000014>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <0x2 0x4>;
-				index = <0x0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -191,6 +195,12 @@
 					interrupts = <0x19 0x8>;
 					interrupt-parent = <&UIC0>;
 				};
+
+				/* This will create 52 and 53 */
+				at24@52 {
+					compatible = "at,24c04";
+					reg = <0x52>;
+				};
 			};
 
 			GPIO0: gpio@ef600b00 {
@@ -209,7 +219,13 @@
 				led@31 {
 					compatible = "linux,gpio-led";
 					linux,name = ":green:";
-					gpios = <&GPIO1 0x30 0>;
+					gpios = <&GPIO1 31 0>;
+				};		
+	
+				led@30 {	
+					compatible = "linux,gpio-led";
+					linux,name = ":red:";
+					gpios = <&GPIO1 30 0>;
 				};
 			};
 
