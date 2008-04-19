Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id DCB14DE200
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 19:59:38 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Add NOR FLASH entries to Canyonlands and
	Glacier dts
Date: Sat, 19 Apr 2008 11:57:18 +0200
Message-Id: <1208599038-11062-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds default NOR entries to the AMCC Canyonlands (460EX)
and Glacier (460GT) dts files.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/canyonlands.dts |   37 +++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/glacier.dts     |   37 +++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 6f3d38a..3963412 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -142,8 +142,45 @@
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
+				/* ranges property is supplied by U-Boot */
 				interrupts = <6 4>;
 				interrupt-parent = <&UIC1>;
+
+				nor_flash@0,0 {
+					compatible = "amd,s29gl512n", "cfi-flash";
+					bank-width = <2>;
+					reg = <0 000000 4000000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					partition@0 {
+						label = "kernel";
+						reg = <0 1e0000>;
+					};
+					partition@1e0000 {
+						label = "dtb";
+						reg = <1e0000 20000>;
+					};
+					partition@200000 {
+						label = "ramdisk";
+						reg = <200000 1400000>;
+					};
+					partition@1600000 {
+						label = "jffs2";
+						reg = <1600000 400000>;
+					};
+					partition@1a00000 {
+						label = "user";
+						reg = <1a00000 2560000>;
+					};
+					partition@3f60000 {
+						label = "env";
+						reg = <3f60000 40000>;
+					};
+					partition@3fa0000 {
+						label = "u-boot";
+						reg = <3fa0000 60000>;
+					};
+				};
 			};
 
 			UART0: serial@ef600300 {
diff --git a/arch/powerpc/boot/dts/glacier.dts b/arch/powerpc/boot/dts/glacier.dts
index 958a5ca..0f2fc07 100644
--- a/arch/powerpc/boot/dts/glacier.dts
+++ b/arch/powerpc/boot/dts/glacier.dts
@@ -145,8 +145,45 @@
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
+				/* ranges property is supplied by U-Boot */
 				interrupts = <6 4>;
 				interrupt-parent = <&UIC1>;
+
+				nor_flash@0,0 {
+					compatible = "amd,s29gl512n", "cfi-flash";
+					bank-width = <2>;
+					reg = <0 000000 4000000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					partition@0 {
+						label = "kernel";
+						reg = <0 1e0000>;
+					};
+					partition@1e0000 {
+						label = "dtb";
+						reg = <1e0000 20000>;
+					};
+					partition@200000 {
+						label = "ramdisk";
+						reg = <200000 1400000>;
+					};
+					partition@1600000 {
+						label = "jffs2";
+						reg = <1600000 400000>;
+					};
+					partition@1a00000 {
+						label = "user";
+						reg = <1a00000 2560000>;
+					};
+					partition@3f60000 {
+						label = "env";
+						reg = <3f60000 40000>;
+					};
+					partition@3fa0000 {
+						label = "u-boot";
+						reg = <3fa0000 60000>;
+					};
+				};
 			};
 
 			UART0: serial@ef600300 {
-- 
1.5.5
