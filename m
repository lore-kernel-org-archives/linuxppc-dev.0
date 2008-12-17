Return-Path: <gerickson@nuovations.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id B87A1DDF23
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 06:56:12 +1100 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/4xx: DTS: Add Add'l SDRAM0 Compatible and Interrupt
	Info
Date: Wed, 17 Dec 2008 11:56:07 -0800
Message-Id: <1229543767-1617-1-git-send-email-gerickson@nuovations.com>
Cc: bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added additional information for type and compatibility strings and
interrupt information to the SDRAM0 memory-controller device tree
nodes for AMCC PowerPC 405EX[r]-based boards to facilitate binding
with the new "ibm,sdram-4xx-ddr2" EDAC memory controller adapter driver.

Signed-off-by: Grant Erickson <gerickson@nuovations.com>
---
As support in the associated EDAC adapter driver is added over time,
similar changes will/should be made to the DTS files for boards
leveraging realizations of this "ibm,sdram-4xx-ddr2" controller,
including the 440SP, 440SPe, 460EX, 460GT and 460SX.

 arch/powerpc/boot/dts/haleakala.dts |   11 ++++++++++-
 arch/powerpc/boot/dts/kilauea.dts   |   11 ++++++++++-
 arch/powerpc/boot/dts/makalu.dts    |   11 ++++++++++-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/haleakala.dts b/arch/powerpc/boot/dts/haleakala.dts
index 513bc43..e45ce7e 100644
--- a/arch/powerpc/boot/dts/haleakala.dts
+++ b/arch/powerpc/boot/dts/haleakala.dts
@@ -89,8 +89,17 @@
 		clock-frequency = <0>; /* Filled in by U-Boot */
 
 		SDRAM0: memory-controller {
-			compatible = "ibm,sdram-405exr";
+			device_type = "memory-controller";
+			compatible = "ibm,sdram-405exr", "ibm,sdram-4xx-ddr2";
 			dcr-reg = <0x010 0x002>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&SDRAM0>;
+			interrupts = <0x0 0x1>;
+			interrupt-map = </* ECCDED Error */ 0x0 &UIC2 0x5 0x4
+					 /* ECCSEC Error */ 0x1 &UIC2 0x6 0x4>;
+			interrupt-map-mask = <0xffffffff>;
 		};
 
 		MAL0: mcmal {
diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index dececc4..d492ead 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -90,8 +90,17 @@
 		clock-frequency = <0>; /* Filled in by U-Boot */
 
 		SDRAM0: memory-controller {
-			compatible = "ibm,sdram-405ex";
+			device_type = "memory-controller";
+			compatible = "ibm,sdram-405ex", "ibm,sdram-4xx-ddr2";
 			dcr-reg = <0x010 0x002>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&SDRAM0>;
+			interrupts = <0x0 0x1>;
+			interrupt-map = </* ECCDED Error */ 0x0 &UIC2 0x5 0x4
+					 /* ECCSEC Error */ 0x1 &UIC2 0x6 0x4>;
+			interrupt-map-mask = <0xffffffff>;
 		};
 
 		MAL0: mcmal {
diff --git a/arch/powerpc/boot/dts/makalu.dts b/arch/powerpc/boot/dts/makalu.dts
index 945508c..52b9f32 100644
--- a/arch/powerpc/boot/dts/makalu.dts
+++ b/arch/powerpc/boot/dts/makalu.dts
@@ -90,8 +90,17 @@
 		clock-frequency = <0>; /* Filled in by U-Boot */
 
 		SDRAM0: memory-controller {
-			compatible = "ibm,sdram-405ex";
+			device_type = "memory-controller";
+			compatible = "ibm,sdram-405ex", "ibm,sdram-4xx-ddr2";
 			dcr-reg = <0x010 0x002>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&SDRAM0>;
+			interrupts = <0x0 0x1>;
+			interrupt-map = </* ECCDED Error */ 0x0 &UIC2 0x5 0x4
+					 /* ECCSEC Error */ 0x1 &UIC2 0x6 0x4>;
+			interrupt-map-mask = <0xffffffff>;
 		};
 
 		MAL0: mcmal {
-- 
1.6.0.4
