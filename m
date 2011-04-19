Return-Path: <b22300@lc1106.zin33.ap.freescale.net>
From: Bhaskar Upadhaya <Bhaskar.Upadhaya@freescale.com>
To: <devicetree-discuss@lists.ozlabs.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][upstream] powerpc: Adding bindings for flexcan controller
Date: Tue, 19 Apr 2011 19:28:31 +0530
Message-ID: <1303221511-12903-1-git-send-email-Bhaskar.Upadhaya@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bhaskar Upadhaya <bhaskar.upadhaya@freescale.com>,
	inuxppc-dev@linux.freescale.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bhaskar Upadhaya <bhaskar.upadhaya@freescale.com>

Signed-off-by: Bhaskar Upadhaya <bhaskar.upadhaya@freescale.com>
Acked-By: Scott Wood <scottwood@freescale.com>
---
Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch -> master)

 .../devicetree/bindings/net/can/fsl-flexcan.txt    |   61 ++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100755 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
new file mode 100755
index 0000000..1a729f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -0,0 +1,61 @@
+CAN Device Tree Bindings
+------------------------
+2011 Freescale Semiconductor, Inc.
+
+fsl,flexcan-v1.0 nodes
+-----------------------
+In addition to the required compatible-, reg- and interrupt-properties, you can
+also specify which clock source shall be used for the controller.
+
+CPI Clock- Can Protocol Interface Clock
+	This CLK_SRC bit of CTRL(control register) selects the clock source to
+	the CAN Protocol Interface(CPI) to be either the peripheral clock
+	(driven by the PLL) or the crystal oscillator clock. The selected clock
+	is the one fed to the prescaler to generate the Serial Clock (Sclock).
+	The PRESDIV field of CTRL(control register) controls a prescaler that
+	generates the Serial Clock (Sclock), whose period defines the
+	time quantum used to compose the CAN waveform.
+
+Can Engine Clock Source
+	There are two sources for CAN clock
+	- Platform Clock  It represents the bus clock
+	- Oscillator Clock
+
+	Peripheral Clock (PLL)
+	--------------
+		     |
+		    ---------		      -------------
+		    |       |CPI Clock	      | Prescaler |       Sclock
+		    |       |---------------->| (1.. 256) |------------>
+		    ---------		      -------------
+                     |  |
+	--------------  ---------------------CLK_SRC
+	Oscillator Clock
+
+- fsl,flexcan-clock-source : CAN Engine Clock Source.This property selects
+			     the peripheral clock. PLL clock is fed to the
+			     prescaler to generate the Serial Clock (Sclock).
+			     Valid values are "oscillator" and "platform"
+			     "oscillator": CAN engine clock source is oscillator clock.
+			     "platform" The CAN engine clock source is the bus clock
+		             (platform clock).
+
+- fsl,flexcan-clock-divider : for the reference and system clock, an additional
+			      clock divider can be specified.
+- clock-frequency: frequency required to calculate the bitrate for FlexCAN.
+
+Note:
+	- v1.0 of flexcan-v1.0 represent the IP block version for P1010 SOC.
+	- P1010 does not have oscillator as the Clock Source.So the default
+	  Clock Source is platform clock.
+Examples:
+
+	can0@1c000 {
+		compatible = "fsl,flexcan-v1.0";
+		reg = <0x1c000 0x1000>;
+		interrupts = <48 0x2>;
+		interrupt-parent = <&mpic>;
+		fsl,flexcan-clock-source = "platform";
+		fsl,flexcan-clock-divider = <2>;
+		clock-frequency = <fixed by u-boot>;
+	};
-- 
1.5.6.5
