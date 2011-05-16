Return-Path: <agust@denx.de>
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/5200: dts: digsy_mtc.dts: update to add can, pci,
	serial and spi
Date: Mon, 16 May 2011 18:02:44 +0200
Message-Id: <1305561764-5942-2-git-send-email-agust@denx.de>
In-Reply-To: <1305561764-5942-1-git-send-email-agust@denx.de>
References: <1305561764-5942-1-git-send-email-agust@denx.de>
Cc: devicetree-discuss@lists.ozlabs.org, Heiko Schocher <hs@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add new nodes to describe more hardware the board is
equipped with:
 - two can nodes for SJA1000 on localbus
 - pci node to support Coral-PA graphics controller
 - serial node for SC28L92 DUART on localbus
 - spi node for MSP430 device

Also correct i2c eeprom node name.

Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/digsy_mtc.dts |   50 ++++++++++++++++++++++++++++++++--
 1 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index 27bd267..e205d17 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -38,6 +38,14 @@
 			status = "disabled";
 		};
 
+		spi@f00 {
+			msp430@0 {
+				compatible = "spidev";
+				spi-max-frequency = <32000>;
+				reg = <0>;
+			};
+		};
+
 		psc@2000 {		// PSC1
 			status = "disabled";
 		};
@@ -73,11 +81,16 @@
 		};
 
 		i2c@3d00 {
-			rtc@50 {
+			eeprom@50 {
 				compatible = "at,24c08";
 				reg = <0x50>;
 			};
 
+			rtc@56 {
+				compatible = "mc,rv3029c2";
+				reg = <0x56>;
+			};
+
 			rtc@68 {
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
@@ -90,11 +103,22 @@
 	};
 
 	pci@f0000d00 {
-		status = "disabled";
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0xc000 0 0 1 &mpc5200_pic 0 0 3
+				 0xc000 0 0 2 &mpc5200_pic 0 0 3
+				 0xc000 0 0 3 &mpc5200_pic 0 0 3
+				 0xc000 0 0 4 &mpc5200_pic 0 0 3>;
+		clock-frequency = <0>; // From boot loader
+		interrupts = <2 8 0 2 9 0 2 10 0>;
+		bus-range = <0 0>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000
+			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
 	};
 
 	localbus {
-		ranges = <0 0 0xff000000 0x1000000>;
+		ranges = <0 0 0xff000000 0x1000000
+			  4 0 0x60000000 0x0001000>;
 
 		// 16-bit flash device at LocalPlus Bus CS0
 		flash@0,0 {
@@ -122,5 +146,25 @@
 				reg = <0x00f00000 0x100000>;
 			};
 		};
+
+		can@4,0 {
+			compatible = "nxp,sja1000";
+			reg = <4 0x000 0x80>;
+			nxp,external-clock-frequency = <24000000>;
+			interrupts = <1 2 3>; // Level-low
+		};
+
+		can@4,100 {
+			compatible = "nxp,sja1000";
+			reg = <4 0x100 0x80>;
+			nxp,external-clock-frequency = <24000000>;
+			interrupts = <1 2 3>;  // Level-low
+		};
+
+		serial@4,200 {
+			compatible = "nxp,sc28l92";
+			reg = <4 0x200 0x10>;
+			interrupts = <1 3 3>;
+		};
 	};
 };
-- 
1.7.1
