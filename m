Return-Path: <holt@sgi.com>
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>, "David S. Miller" <davem@davemloft.net>,
	Kumar Gala <galak@kernel.crashing.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	U Bhaskar-B22300 <B22300@freescale.com>
Subject: [PATCH v13 3/6] flexcan: Fix up fsl-flexcan device tree binding.
Date: Tue, 16 Aug 2011 22:32:21 -0500
Message-Id: <1313551944-28603-4-git-send-email-holt@sgi.com>
In-Reply-To: <1313551944-28603-1-git-send-email-holt@sgi.com>
References: <1313551944-28603-1-git-send-email-holt@sgi.com>
Cc: , socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	U Bhaskar-B22300 <B22300@freescale.com>,
	Robin Holt <holt@sgi.com>, Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch cleans up the documentation of the device-tree binding for
the Flexcan devices on Freescale's PowerPC and ARM cores. Extra
properties are not used by the driver so we are removing them.

Signed-off-by: Robin Holt <holt@sgi.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>,
Acked-by: Wolfgang Grandegger <wg@grandegger.com>,
Cc: U Bhaskar-B22300 <B22300@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: socketcan-core@lists.berlios.de,
Cc: netdev@vger.kernel.org,
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
Cc: devicetree-discuss@lists.ozlabs.org
---
 .../devicetree/bindings/net/can/fsl-flexcan.txt    |   61 ++++----------------
 arch/powerpc/boot/dts/p1010rdb.dts                 |   10 +---
 arch/powerpc/boot/dts/p1010si.dtsi                 |   10 +--
 3 files changed, 17 insertions(+), 64 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index 1a729f0..8dfb98b 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -1,61 +1,22 @@
-CAN Device Tree Bindings
-------------------------
-2011 Freescale Semiconductor, Inc.
+Flexcan CAN contoller on Freescale's ARM and PowerPC system-on-a-chip (SOC).
 
-fsl,flexcan-v1.0 nodes
------------------------
-In addition to the required compatible-, reg- and interrupt-properties, you can
-also specify which clock source shall be used for the controller.
+Required properties:
 
-CPI Clock- Can Protocol Interface Clock
-	This CLK_SRC bit of CTRL(control register) selects the clock source to
-	the CAN Protocol Interface(CPI) to be either the peripheral clock
-	(driven by the PLL) or the crystal oscillator clock. The selected clock
-	is the one fed to the prescaler to generate the Serial Clock (Sclock).
-	The PRESDIV field of CTRL(control register) controls a prescaler that
-	generates the Serial Clock (Sclock), whose period defines the
-	time quantum used to compose the CAN waveform.
+- compatible : Should be "fsl,<processor>-flexcan"
 
-Can Engine Clock Source
-	There are two sources for CAN clock
-	- Platform Clock  It represents the bus clock
-	- Oscillator Clock
+  An implementation should also claim any of the following compatibles
+  that it is fully backwards compatible with:
 
-	Peripheral Clock (PLL)
-	--------------
-		     |
-		    ---------		      -------------
-		    |       |CPI Clock	      | Prescaler |       Sclock
-		    |       |---------------->| (1.. 256) |------------>
-		    ---------		      -------------
-                     |  |
-	--------------  ---------------------CLK_SRC
-	Oscillator Clock
+  - fsl,p1010-flexcan
 
-- fsl,flexcan-clock-source : CAN Engine Clock Source.This property selects
-			     the peripheral clock. PLL clock is fed to the
-			     prescaler to generate the Serial Clock (Sclock).
-			     Valid values are "oscillator" and "platform"
-			     "oscillator": CAN engine clock source is oscillator clock.
-			     "platform" The CAN engine clock source is the bus clock
-		             (platform clock).
+- reg : Offset and length of the register set for this device
+- interrupts : Interrupt tuple for this device
 
-- fsl,flexcan-clock-divider : for the reference and system clock, an additional
-			      clock divider can be specified.
-- clock-frequency: frequency required to calculate the bitrate for FlexCAN.
+Example:
 
-Note:
-	- v1.0 of flexcan-v1.0 represent the IP block version for P1010 SOC.
-	- P1010 does not have oscillator as the Clock Source.So the default
-	  Clock Source is platform clock.
-Examples:
-
-	can0@1c000 {
-		compatible = "fsl,flexcan-v1.0";
+	can@1c000 {
+		compatible = "fsl,p1010-flexcan";
 		reg = <0x1c000 0x1000>;
 		interrupts = <48 0x2>;
 		interrupt-parent = <&mpic>;
-		fsl,flexcan-clock-source = "platform";
-		fsl,flexcan-clock-divider = <2>;
-		clock-frequency = <fixed by u-boot>;
 	};
diff --git a/arch/powerpc/boot/dts/p1010rdb.dts b/arch/powerpc/boot/dts/p1010rdb.dts
index 6b33b73..d6c669c 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dts
+++ b/arch/powerpc/boot/dts/p1010rdb.dts
@@ -23,6 +23,8 @@
 		ethernet2 = &enet2;
 		pci0 = &pci0;
 		pci1 = &pci1;
+		can0 = &can0;
+		can1 = &can1;
 	};
 
 	memory {
@@ -169,14 +171,6 @@
 			};
 		};
 
-		can0@1c000 {
-			fsl,flexcan-clock-source = "platform";
-		};
-
-		can1@1d000 {
-			fsl,flexcan-clock-source = "platform";
-		};
-
 		usb@22000 {
 			phy_type = "utmi";
 		};
diff --git a/arch/powerpc/boot/dts/p1010si.dtsi b/arch/powerpc/boot/dts/p1010si.dtsi
index 7f51104..cabe0a4 100644
--- a/arch/powerpc/boot/dts/p1010si.dtsi
+++ b/arch/powerpc/boot/dts/p1010si.dtsi
@@ -140,20 +140,18 @@
 			interrupt-parent = <&mpic>;
 		};
 
-		can0@1c000 {
-			compatible = "fsl,flexcan-v1.0";
+		can0: can@1c000 {
+			compatible = "fsl,p1010-flexcan";
 			reg = <0x1c000 0x1000>;
 			interrupts = <48 0x2>;
 			interrupt-parent = <&mpic>;
-			fsl,flexcan-clock-divider = <2>;
 		};
 
-		can1@1d000 {
-			compatible = "fsl,flexcan-v1.0";
+		can1: can@1d000 {
+			compatible = "fsl,p1010-flexcan";
 			reg = <0x1d000 0x1000>;
 			interrupts = <61 0x2>;
 			interrupt-parent = <&mpic>;
-			fsl,flexcan-clock-divider = <2>;
 		};
 
 		L2: l2-cache-controller@20000 {
-- 
1.7.2.1
