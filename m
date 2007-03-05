Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 2E05DDDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Mar 2007 21:40:34 +1100 (EST)
Date: Mon, 5 Mar 2007 11:40:31 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: [PATCH try3] lite5200(b) support for i2c
Message-ID: <20070305104031.GW4397@moe.telargo.com>
References: <20070302104718.GU4397@moe.telargo.com>
	<20070305100802.GV4397@moe.telargo.com>
	<45EBEFEE.9030309@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45EBEFEE.9030309@246tNt.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add fsl-i2c to mpc5200 i2c node in device tree, and enable FSL_SOC.

Tested to work with built-in eeprom on lite5200b.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
D'oh, of course it makes more sense under PPC_MPC52xx.

 arch/powerpc/Kconfig                |    1 +
 arch/powerpc/boot/dts/lite5200.dts  |    6 ++++--
 arch/powerpc/boot/dts/lite5200b.dts |    6 ++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

Index: grant.git/arch/powerpc/Kconfig
===================================================================
--- grant.git.orig/arch/powerpc/Kconfig
+++ grant.git/arch/powerpc/Kconfig
@@ -434,6 +434,7 @@ config PPC_CHRP
 
 config PPC_MPC52xx
 	bool
+	select FSL_SOC
 	default n
 
 config PPC_MPC5200
Index: grant.git/arch/powerpc/boot/dts/lite5200b.dts
===================================================================
--- grant.git.orig/arch/powerpc/boot/dts/lite5200b.dts
+++ grant.git/arch/powerpc/boot/dts/lite5200b.dts
@@ -323,20 +323,22 @@
 
 		i2c@3d00 {
 			device_type = "i2c";
-			compatible = "mpc5200b-i2c\0mpc5200-i2c";
+			compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
 			cell-index = <0>;
 			reg = <3d00 40>;
 			interrupts = <2 f 0>;
 			interrupt-parent = <500>;
+			fsl5200-clocking;
 		};
 
 		i2c@3d40 {
 			device_type = "i2c";
-			compatible = "mpc5200b-i2c\0mpc5200-i2c";
+			compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
 			cell-index = <1>;
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <500>;
+			fsl5200-clocking;
 		};
 		sram@8000 {
 			device_type = "sram";
Index: grant.git/arch/powerpc/boot/dts/lite5200.dts
===================================================================
--- grant.git.orig/arch/powerpc/boot/dts/lite5200.dts
+++ grant.git/arch/powerpc/boot/dts/lite5200.dts
@@ -318,20 +318,22 @@
 
 		i2c@3d00 {
 			device_type = "i2c";
-			compatible = "mpc5200-i2c";
+			compatible = "mpc5200-i2c\0fsl-i2c";
 			cell-index = <0>;
 			reg = <3d00 40>;
 			interrupts = <2 f 0>;
 			interrupt-parent = <500>;
+			fsl5200-clocking;
 		};
 
 		i2c@3d40 {
 			device_type = "i2c";
-			compatible = "mpc5200-i2c";
+			compatible = "mpc5200-i2c\0fsl-i2c";
 			cell-index = <1>;
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <500>;
+			fsl5200-clocking;
 		};
 		sram@8000 {
 			device_type = "sram";
