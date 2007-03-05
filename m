Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id D1C92DDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Mar 2007 21:08:06 +1100 (EST)
Date: Mon, 5 Mar 2007 11:08:02 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH alternative] lite5200(b) support for i2c
Message-ID: <20070305100802.GV4397@moe.telargo.com>
References: <20070302104718.GU4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070302104718.GU4397@moe.telargo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add fsl-i2c to lite5200 i2c nodes in device tree, and enable FSL_SOC.

Tested to work with built-in eeprom on lite5200b.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
This patch obsoletes the previous one, and is shorter too :-)


 arch/powerpc/Kconfig                |    1 +
 arch/powerpc/boot/dts/lite5200.dts  |    6 ++++--
 arch/powerpc/boot/dts/lite5200b.dts |    6 ++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

Index: grant.git/arch/powerpc/Kconfig
===================================================================
--- grant.git.orig/arch/powerpc/Kconfig
+++ grant.git/arch/powerpc/Kconfig
@@ -128,6 +128,7 @@ config CLASSIC32
 	bool "52xx/6xx/7xx/74xx"
 	select PPC_FPU
 	select 6xx
+	select FSL_SOC
 	help
 	  There are four families of PowerPC chips supported.  The more common
 	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
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
