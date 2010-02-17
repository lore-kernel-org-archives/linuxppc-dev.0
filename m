Return-Path: <wg@denx.de>
From: Wolfgang Grandegger <wg@grandegger.com>
To: Linux-i2c@vger.kernel.org
Subject: [PATCH v8 4/4] powerpc: doc/dts-bindings: update doc of FSL I2C
	bindings
Date: Wed, 17 Feb 2010 11:19:20 +0100
Message-Id: <1266401960-19127-5-git-send-email-wg@grandegger.com>
In-Reply-To: <1266401960-19127-4-git-send-email-wg@grandegger.com>
References: <1266401960-19127-1-git-send-email-wg@grandegger.com>
	<1266401960-19127-2-git-send-email-wg@grandegger.com>
	<1266401960-19127-3-git-send-email-wg@grandegger.com>
	<1266401960-19127-4-git-send-email-wg@grandegger.com>
Cc: Devicetree-discuss@lists.ozlabs.org, Linuxppc-dev@lists.ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wolfgang Grandegger <wg@denx.de>

This patch adds the MPC5121 to the list of supported devices,
enhances the doc of the "clock-frequency" property and removes
the obsolete "cell-index", "device_type" and "fsl-i2c" property.
Furthermore an example for the MPC5121 has been added.

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
---
 Documentation/powerpc/dts-bindings/fsl/i2c.txt |   30 +++++++++++++++++------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/i2c.txt b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
index b6d2e21..50da203 100644
--- a/Documentation/powerpc/dts-bindings/fsl/i2c.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
@@ -2,15 +2,14 @@
 
 Required properties :
 
- - device_type : Should be "i2c"
  - reg : Offset and length of the register set for the device
+ - compatible : should be "fsl,CHIP-i2c" where CHIP is the name of a
+   compatible processor, e.g. mpc8313, mpc8543, mpc8544, mpc5121,
+   mpc5200 or mpc5200b. For the mpc5121, an additional node
+   "fsl,mpc5121-i2c-ctrl" is required as shown in the example below.
 
 Recommended properties :
 
- - compatible : compatibility list with 2 entries, the first should
-   be "fsl,CHIP-i2c" where CHIP is the name of a compatible processor,
-   e.g. mpc8313, mpc8543, mpc8544, mpc5200 or mpc5200b. The second one
-   should be "fsl-i2c".
  - interrupts : <a b> where a is the interrupt number and b is a
    field that represents an encoding of the sense and level
    information for the interrupt.  This should be encoded based on
@@ -24,25 +23,40 @@ Recommended properties :
 
 Examples :
 
+	/* MPC5121 based board */
+	i2c@1740 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,mpc5121-i2c", "fsl-i2c";
+		reg = <0x1740 0x20>;
+		interrupts = <11 0x8>;
+		interrupt-parent = <&ipic>;
+		clock-frequency = <100000>;
+	};
+
+	i2ccontrol@1760 {
+		compatible = "fsl,mpc5121-i2c-ctrl";
+		reg = <0x1760 0x8>;
+	};
+
+	/* MPC5200B based board */
 	i2c@3d00 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
-		cell-index = <0>;
 		reg = <0x3d00 0x40>;
 		interrupts = <2 15 0>;
 		interrupt-parent = <&mpc5200_pic>;
 		fsl,preserve-clocking;
 	};
 
+	/* MPC8544 base board */
 	i2c@3100 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cell-index = <1>;
 		compatible = "fsl,mpc8544-i2c", "fsl-i2c";
 		reg = <0x3100 0x100>;
 		interrupts = <43 2>;
 		interrupt-parent = <&mpic>;
 		clock-frequency = <400000>;
 	};
-
-- 
1.6.2.5
