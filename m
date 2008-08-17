Return-Path: <wg@grandegger.com>
Message-ID: <48A7E68D.8090405@grandegger.com>
Date: Sun, 17 Aug 2008 10:51:25 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: 85xx: TQM8548: DTS file fixes and cleanup
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Due to the missing compatible property for the SOC, the MPC I2C buses are
not found any more. This patch fixes this issue. Furthermore it corrects
the name of the SOC node and adds the missing I2C node for the RTC.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |    8 +++++++-
 arch/powerpc/boot/dts/tqm8548.dts          |    3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm8548.dts
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/boot/dts/tqm8548.dts
+++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8548.dts
@@ -50,13 +50,14 @@
 		reg = <0x00000000 0x00000000>;	// Filled in by U-Boot
 	};
 
-	soc8548@e0000000 {
+	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0x0 0xe0000000 0x100000>;
 		reg = <0xe0000000 0x1000>;	// CCSRBAR
 		bus-frequency = <0>;
+		compatible = "fsl,mpc8548-immr", "simple-bus";
 
 		memory-controller@2000 {
 			compatible = "fsl,mpc8548-memory-controller";
Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm8548-bigflash.dts
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -50,13 +50,14 @@
 		reg = <0x00000000 0x00000000>;	// Filled in by U-Boot
 	};
 
-	soc8548@a0000000 {
+	soc@a0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0x0 0xa0000000 0x100000>;
 		reg = <0xa0000000 0x1000>;	// CCSRBAR
 		bus-frequency = <0>;
+		compatible = "fsl,mpc8548-immr", "simple-bus";
 
 		memory-controller@2000 {
 			compatible = "fsl,mpc8548-memory-controller";
@@ -83,6 +84,11 @@
 			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
+
+			rtc@68 {
+				compatible = "dallas,ds1337";
+				reg = <0x68>;
+			};
 		};
 
 		i2c@3100 {
