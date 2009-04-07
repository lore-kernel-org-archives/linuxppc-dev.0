Return-Path: <wg@denx.de>
Message-Id: <20090407082231.646648985@denx.de>
Date: Tue, 07 Apr 2009 10:20:56 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH v3 4/5] powerpc: i2c-mpc: document new FSL I2C bindings and
	cleanup
References: <20090407082052.477328750@denx.de>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch documents the new bindings for the MPC I2C bus driver.
Furthermore, it removes obsolete FSL device related definitions
for I2C.
It should go through the appropriate PowerPC maintainer(s) hands.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 Documentation/powerpc/dts-bindings/fsl/i2c.txt |   46 ++++++++++++++++---------
 include/linux/fsl_devices.h                    |    4 --
 2 files changed, 31 insertions(+), 19 deletions(-)

Index: linux-2.6-galak/Documentation/powerpc/dts-bindings/fsl/i2c.txt
===================================================================
--- linux-2.6-galak.orig/Documentation/powerpc/dts-bindings/fsl/i2c.txt	2009-04-07 10:09:08.185721241 +0200
+++ linux-2.6-galak/Documentation/powerpc/dts-bindings/fsl/i2c.txt	2009-04-07 10:09:15.413719535 +0200
@@ -7,8 +7,10 @@
 
 Recommended properties :
 
- - compatible : Should be "fsl-i2c" for parts compatible with
-   Freescale I2C specifications.
+ - compatible : compatibility list with 2 entries, the first should
+   be "fsl,CHIP-i2c" where CHIP is the name of a compatible processor,
+   e.g. mpc8313, mpc8543, mpc8544, mpc5200 or mpc5200b. The second one
+   should be "fsl-i2c".
  - interrupts : <a b> where a is the interrupt number and b is a
    field that represents an encoding of the sense and level
    information for the interrupt.  This should be encoded based on
@@ -16,17 +18,31 @@
    controller you have.
  - interrupt-parent : the phandle for the interrupt controller that
    services interrupts for this device.
- - dfsrr : boolean; if defined, indicates that this I2C device has
-   a digital filter sampling rate register
- - fsl5200-clocking : boolean; if defined, indicated that this device
-   uses the FSL 5200 clocking mechanism.
-
-Example :
-	i2c@3000 {
-		interrupt-parent = <40000>;
-		interrupts = <1b 3>;
-		reg = <3000 18>;
-		device_type = "i2c";
-		compatible  = "fsl-i2c";
-		dfsrr;
+ - fsl,preserve-clocking : boolean; if defined, the clock settings
+   from the bootloader are preserved (not touched).
+ - clock-frequency : desired I2C bus clock frequency in Hz.
+
+Examples :
+
+	i2c@3d00 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
+		cell-index = <0>;
+		reg = <0x3d00 0x40>;
+		interrupts = <2 15 0>;
+		interrupt-parent = <&mpc5200_pic>;
+		fsl,preserve-clocking;
 	};
+
+	i2c@3100 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cell-index = <1>;
+		compatible = "fsl,mpc8544-i2c", "fsl-i2c";
+		reg = <0x3100 0x100>;
+		interrupts = <43 2>;
+		interrupt-parent = <&mpic>;
+		clock-frequency = <400000>;
+	};
+
Index: linux-2.6-galak/include/linux/fsl_devices.h
===================================================================
--- linux-2.6-galak.orig/include/linux/fsl_devices.h	2009-04-07 10:09:08.185721241 +0200
+++ linux-2.6-galak/include/linux/fsl_devices.h	2009-04-07 10:09:15.414719119 +0200
@@ -43,10 +43,6 @@
  *
  */
 
-/* Flags related to I2C device features */
-#define FSL_I2C_DEV_SEPARATE_DFSRR	0x00000001
-#define FSL_I2C_DEV_CLOCK_5200		0x00000002
-
 enum fsl_usb2_operating_modes {
 	FSL_USB2_MPH_HOST,
 	FSL_USB2_DR_HOST,
