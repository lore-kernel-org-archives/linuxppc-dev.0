Return-Path: <wg@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id A96EBB6F81
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2011 23:11:59 +1100 (EST)
From: Wolfgang Grandegger <wg@grandegger.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v5 4/4] powerpc: tqm8548/tqm8xx: add and update CAN
 device nodes
Date: Wed, 30 Nov 2011 13:10:35 +0100
Message-Id: <1322655035-18809-5-git-send-email-wg@grandegger.com>
In-Reply-To: <1322655035-18809-1-git-send-email-wg@grandegger.com>
References: <1322655035-18809-1-git-send-email-wg@grandegger.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-can@vger.kernel.org,
 linuxppc-dev@ozlabs.org, socketcan-users@lists.berlios.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables or updates support for the CC770 and AN82527
CAN controller on the TQM8548 and TQM8xx boards.

CC: devicetree-discuss@lists.ozlabs.org
CC: linuxppc-dev@ozlabs.org
CC: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |   19 ++++++++++++++-----
 arch/powerpc/boot/dts/tqm8548.dts          |   19 ++++++++++++++-----
 arch/powerpc/boot/dts/tqm8xx.dts           |   25 +++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index 9452c3c..d918752 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -352,7 +352,7 @@
 		ranges = <
 			0 0x0 0xfc000000 0x04000000	// NOR FLASH bank 1
 			1 0x0 0xf8000000 0x08000000	// NOR FLASH bank 0
-			2 0x0 0xa3000000 0x00008000	// CAN (2 x i82527)
+			2 0x0 0xa3000000 0x00008000	// CAN (2 x CC770)
 			3 0x0 0xa3010000 0x00008000	// NAND FLASH
 
 		>;
@@ -393,18 +393,27 @@
 		};
 
 		/* Note: CAN support needs be enabled in U-Boot */
-		can0@2,0 {
-			compatible = "intel,82527"; // Bosch CC770
+		can@2,0 {
+			compatible = "bosch,cc770"; // Bosch CC770
 			reg = <2 0x0 0x100>;
 			interrupts = <4 1>;
 			interrupt-parent = <&mpic>;
+			bosch,external-clock-frequency = <16000000>;
+			bosch,disconnect-rx1-input;
+			bosch,disconnect-tx1-output;
+			bosch,iso-low-speed-mux;
+			bosch,clock-out-frequency = <16000000>;
 		};
 
-		can1@2,100 {
-			compatible = "intel,82527"; // Bosch CC770
+		can@2,100 {
+			compatible = "bosch,cc770"; // Bosch CC770
 			reg = <2 0x100 0x100>;
 			interrupts = <4 1>;
 			interrupt-parent = <&mpic>;
+			bosch,external-clock-frequency = <16000000>;
+			bosch,disconnect-rx1-input;
+			bosch,disconnect-tx1-output;
+			bosch,iso-low-speed-mux;
 		};
 
 		/* Note: NAND support needs to be enabled in U-Boot */
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index 619776f..988d887 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -352,7 +352,7 @@
 		ranges = <
 			0 0x0 0xfc000000 0x04000000	// NOR FLASH bank 1
 			1 0x0 0xf8000000 0x08000000	// NOR FLASH bank 0
-			2 0x0 0xe3000000 0x00008000	// CAN (2 x i82527)
+			2 0x0 0xe3000000 0x00008000	// CAN (2 x CC770)
 			3 0x0 0xe3010000 0x00008000	// NAND FLASH
 
 		>;
@@ -393,18 +393,27 @@
 		};
 
 		/* Note: CAN support needs be enabled in U-Boot */
-		can0@2,0 {
-			compatible = "intel,82527"; // Bosch CC770
+		can@2,0 {
+			compatible = "bosch,cc770"; // Bosch CC770
 			reg = <2 0x0 0x100>;
 			interrupts = <4 1>;
 			interrupt-parent = <&mpic>;
+			bosch,external-clock-frequency = <16000000>;
+			bosch,disconnect-rx1-input;
+			bosch,disconnect-tx1-output;
+			bosch,iso-low-speed-mux;
+			bosch,clock-out-frequency = <16000000>;
 		};
 
-		can1@2,100 {
-			compatible = "intel,82527"; // Bosch CC770
+		can@2,100 {
+			compatible = "bosch,cc770"; // Bosch CC770
 			reg = <2 0x100 0x100>;
 			interrupts = <4 1>;
 			interrupt-parent = <&mpic>;
+			bosch,external-clock-frequency = <16000000>;
+			bosch,disconnect-rx1-input;
+			bosch,disconnect-tx1-output;
+			bosch,iso-low-speed-mux;
 		};
 
 		/* Note: NAND support needs to be enabled in U-Boot */
diff --git a/arch/powerpc/boot/dts/tqm8xx.dts b/arch/powerpc/boot/dts/tqm8xx.dts
index f6da7ec..c3dba25 100644
--- a/arch/powerpc/boot/dts/tqm8xx.dts
+++ b/arch/powerpc/boot/dts/tqm8xx.dts
@@ -57,6 +57,7 @@
 
 		ranges = <
 			0x0 0x0 0x40000000 0x800000
+			0x3 0x0 0xc0000000 0x200
 		>;
 
 		flash@0,0 {
@@ -67,6 +68,30 @@
 			bank-width = <4>;
 			device-width = <2>;
 		};
+
+		/* Note: CAN support needs be enabled in U-Boot */
+		can@3,0 {
+			compatible = "intc,82527";
+			reg = <3 0x0 0x80>;
+			interrupts = <8 1>;
+			interrupt-parent = <&PIC>;
+			bosch,external-clock-frequency = <16000000>;
+			bosch,disconnect-rx1-input;
+			bosch,disconnect-tx1-output;
+			bosch,iso-low-speed-mux;
+			bosch,clock-out-frequency = <16000000>;
+		};
+
+		can@3,100 {
+			compatible = "intc,82527";
+			reg = <3 0x100 0x80>;
+			interrupts = <8 1>;
+			interrupt-parent = <&PIC>;
+			bosch,external-clock-frequency = <16000000>;
+			bosch,disconnect-rx1-input;
+			bosch,disconnect-tx1-output;
+			bosch,iso-low-speed-mux;
+		};
 	};
 
 	soc@fff00000 {
-- 
1.7.4.1
