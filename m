Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E3C4ADDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 05:01:43 +1100 (EST)
Date: Thu, 19 Mar 2009 21:01:42 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc/83xx: Add power management support for MPC837x
	boards
Message-ID: <20090319180142.GA6114@oksana.dev.rtsoft.ru>
References: <20090319180055.GA3155@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090319180055.GA3155@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds pmc nodes to the device tree files so that the boards
will able to use standby capability of MPC837x processors. The MPC837x
PMC controllers are compatible with MPC8349 ones (i.e. no deep sleep).

sleep = <> properties are used to specify SCCR masks as described
in "Specifying Device Power Management Information (sleep property)"
chapter in Documentation/powerpc/booting-without-of.txt.

Since I2C1 and eSDHC controllers share the same clock source, they
are now placed under sleep-nexus nodes.

A processor is able to wakeup the boards on LAN events (Wake-On-Lan),
console events (with no_console_suspend kernel command line), GPIO
events and external IRQs (IRQ1 and IRQ2).

The processor can also wakeup the boards by the fourth general purpose
timer in GTM1 block, but the GTM wakeup support isn't yet implemented
(it's tested to work, but it's unclear how can we use the quite short
GTM timers, and how do we want to expose the GTM to userspace).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8377_mds.dts |   68 ++++++++++++++++-------
 arch/powerpc/boot/dts/mpc8377_rdb.dts |   98 +++++++++++++++++++++------------
 arch/powerpc/boot/dts/mpc8378_mds.dts |   66 +++++++++++++++-------
 arch/powerpc/boot/dts/mpc8378_rdb.dts |   96 ++++++++++++++++++++------------
 arch/powerpc/boot/dts/mpc8379_mds.dts |   68 ++++++++++++++++-------
 arch/powerpc/boot/dts/mpc8379_rdb.dts |   98 +++++++++++++++++++++------------
 6 files changed, 323 insertions(+), 171 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 3e3ec8f..cebfc50 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -129,21 +129,38 @@
 			reg = <0x200 0x100>;
 		};
 
-		i2c@3000 {
+		sleep-nexus {
 			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <14 0x8>;
-			interrupt-parent = <&ipic>;
-			dfsrr;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			sleep = <&pmc 0x0c000000>;
+			ranges;
 
-			rtc@68 {
-				compatible = "dallas,ds1374";
-				reg = <0x68>;
-				interrupts = <19 0x8>;
+			i2c@3000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <0>;
+				compatible = "fsl-i2c";
+				reg = <0x3000 0x100>;
+				interrupts = <14 0x8>;
 				interrupt-parent = <&ipic>;
+				dfsrr;
+
+				rtc@68 {
+					compatible = "dallas,ds1374";
+					reg = <0x68>;
+					interrupts = <19 0x8>;
+					interrupt-parent = <&ipic>;
+				};
+			};
+
+			sdhci@2e000 {
+				compatible = "fsl,mpc8377-esdhc", "fsl,mpc8379-esdhc";
+				reg = <0x2e000 0x1000>;
+				interrupts = <42 0x8>;
+				interrupt-parent = <&ipic>;
+				/* Filled in by U-Boot */
+				clock-frequency = <0>;
 			};
 		};
 
@@ -176,6 +193,7 @@
 			interrupts = <38 0x8>;
 			dr_mode = "host";
 			phy_type = "ulpi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		mdio@24520 {
@@ -226,6 +244,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 		};
 
 		enet1: ethernet@25000 {
@@ -240,6 +260,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy3>;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -311,15 +333,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x9fe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,mpc8377-esdhc", "fsl,mpc8379-esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <42 0x8>;
-			interrupt-parent = <&ipic>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		sata@18000 {
@@ -327,6 +341,7 @@
 			reg = <0x18000 0x1000>;
 			interrupts = <44 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x000000c0>;
 		};
 
 		sata@19000 {
@@ -334,6 +349,7 @@
 			reg = <0x19000 0x1000>;
 			interrupts = <45 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000030>;
 		};
 
 		/* IPIC
@@ -349,6 +365,13 @@
 			#interrupt-cells = <2>;
 			reg = <0x700 0x100>;
 		};
+
+		pmc: power@b00 {
+			compatible = "fsl,mpc8377-pmc", "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 0x8>;
+			interrupt-parent = <&ipic>;
+		};
 	};
 
 	pci0: pci@e0008500 {
@@ -403,6 +426,7 @@
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
+		sleep = <&pmc 0x00010000>;
 		clock-frequency = <0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
@@ -428,6 +452,7 @@
 				 0 0 0 2 &ipic 1 8
 				 0 0 0 3 &ipic 1 8
 				 0 0 0 4 &ipic 1 8>;
+		sleep = <&pmc 0x00300000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
@@ -459,6 +484,7 @@
 				 0 0 0 2 &ipic 2 8
 				 0 0 0 3 &ipic 2 8
 				 0 0 0 4 &ipic 2 8>;
+		sleep = <&pmc 0x000c0000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index fb1d884..32311c8 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -127,37 +127,54 @@
 			gpio-controller;
 		};
 
-		i2c@3000 {
+		sleep-nexus {
 			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <14 0x8>;
-			interrupt-parent = <&ipic>;
-			dfsrr;
-
-			dtt@48 {
-				compatible = "national,lm75";
-				reg = <0x48>;
-			};
-
-			at24@50 {
-				compatible = "at24,24c256";
-				reg = <0x50>;
-			};
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			sleep = <&pmc 0x0c000000>;
+			ranges;
 
-			rtc@68 {
-				compatible = "dallas,ds1339";
-				reg = <0x68>;
+			i2c@3000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <0>;
+				compatible = "fsl-i2c";
+				reg = <0x3000 0x100>;
+				interrupts = <14 0x8>;
+				interrupt-parent = <&ipic>;
+				dfsrr;
+
+				dtt@48 {
+					compatible = "national,lm75";
+					reg = <0x48>;
+				};
+
+				at24@50 {
+					compatible = "at24,24c256";
+					reg = <0x50>;
+				};
+
+				rtc@68 {
+					compatible = "dallas,ds1339";
+					reg = <0x68>;
+				};
+
+				mcu_pio: mcu@a {
+					#gpio-cells = <2>;
+					compatible = "fsl,mc9s08qg8-mpc8377erdb",
+						     "fsl,mcu-mpc8349emitx";
+					reg = <0x0a>;
+					gpio-controller;
+				};
 			};
 
-			mcu_pio: mcu@a {
-				#gpio-cells = <2>;
-				compatible = "fsl,mc9s08qg8-mpc8377erdb",
-					     "fsl,mcu-mpc8349emitx";
-				reg = <0x0a>;
-				gpio-controller;
+			sdhci@2e000 {
+				compatible = "fsl,mpc8377-esdhc", "fsl,mpc8379-esdhc";
+				reg = <0x2e000 0x1000>;
+				interrupts = <42 0x8>;
+				interrupt-parent = <&ipic>;
+				/* Filled in by U-Boot */
+				clock-frequency = <0>;
 			};
 		};
 
@@ -228,6 +245,7 @@
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
 			phy_type = "ulpi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		mdio@24520 {
@@ -272,6 +290,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 		};
 
 		enet1: ethernet@25000 {
@@ -286,6 +306,8 @@
 			interrupt-parent = <&ipic>;
 			fixed-link = <1 1 1000 0 0>;
 			tbi-handle = <&tbi1>;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -318,15 +340,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x9fe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,mpc8377-esdhc", "fsl,mpc8379-esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <42 0x8>;
-			interrupt-parent = <&ipic>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		sata@18000 {
@@ -334,6 +348,7 @@
 			reg = <0x18000 0x1000>;
 			interrupts = <44 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x000000c0>;
 		};
 
 		sata@19000 {
@@ -341,6 +356,7 @@
 			reg = <0x19000 0x1000>;
 			interrupts = <45 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000030>;
 		};
 
 		/* IPIC
@@ -356,6 +372,13 @@
 			#interrupt-cells = <2>;
 			reg = <0x700 0x100>;
 		};
+
+		pmc: power@b00 {
+			compatible = "fsl,mpc8377-pmc", "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 0x8>;
+			interrupt-parent = <&ipic>;
+		};
 	};
 
 	pci0: pci@e0008500 {
@@ -381,6 +404,7 @@
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		sleep = <&pmc 0x00010000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
@@ -406,6 +430,7 @@
 				 0 0 0 2 &ipic 1 8
 				 0 0 0 3 &ipic 1 8
 				 0 0 0 4 &ipic 1 8>;
+		sleep = <&pmc 0x00300000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
@@ -437,6 +462,7 @@
 				 0 0 0 2 &ipic 2 8
 				 0 0 0 3 &ipic 2 8
 				 0 0 0 4 &ipic 2 8>;
+		sleep = <&pmc 0x000c0000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index c3b212c..155841d 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -129,21 +129,38 @@
 			reg = <0x200 0x100>;
 		};
 
-		i2c@3000 {
+		sleep-nexus {
 			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <14 0x8>;
-			interrupt-parent = <&ipic>;
-			dfsrr;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			sleep = <&pmc 0x0c000000>;
+			ranges;
 
-			rtc@68 {
-				compatible = "dallas,ds1374";
-				reg = <0x68>;
-				interrupts = <19 0x8>;
+			i2c@3000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <0>;
+				compatible = "fsl-i2c";
+				reg = <0x3000 0x100>;
+				interrupts = <14 0x8>;
 				interrupt-parent = <&ipic>;
+				dfsrr;
+
+				rtc@68 {
+					compatible = "dallas,ds1374";
+					reg = <0x68>;
+					interrupts = <19 0x8>;
+					interrupt-parent = <&ipic>;
+				};
+			};
+
+			sdhci@2e000 {
+				compatible = "fsl,mpc8378-esdhc", "fsl,mpc8379-esdhc";
+				reg = <0x2e000 0x1000>;
+				interrupts = <42 0x8>;
+				interrupt-parent = <&ipic>;
+				/* Filled in by U-Boot */
+				clock-frequency = <0>;
 			};
 		};
 
@@ -215,6 +232,7 @@
 			interrupts = <38 0x8>;
 			dr_mode = "host";
 			phy_type = "ulpi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		mdio@24520 {
@@ -265,6 +283,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 		};
 
 		enet1: ethernet@25000 {
@@ -279,6 +299,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy3>;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -311,15 +333,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x9fe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,mpc8378-esdhc", "fsl,mpc8379-esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <42 0x8>;
-			interrupt-parent = <&ipic>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		/* IPIC
@@ -335,6 +349,13 @@
 			#interrupt-cells = <2>;
 			reg = <0x700 0x100>;
 		};
+
+		pmc: power@b00 {
+			compatible = "fsl,mpc8378-pmc", "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 0x8>;
+			interrupt-parent = <&ipic>;
+		};
 	};
 
 	pci0: pci@e0008500 {
@@ -390,6 +411,7 @@
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
 		clock-frequency = <0>;
+		sleep = <&pmc 0x00010000>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
@@ -414,6 +436,7 @@
 				 0 0 0 2 &ipic 1 8
 				 0 0 0 3 &ipic 1 8
 				 0 0 0 4 &ipic 1 8>;
+		sleep = <&pmc 0x00300000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
@@ -445,6 +468,7 @@
 				 0 0 0 2 &ipic 2 8
 				 0 0 0 3 &ipic 2 8
 				 0 0 0 4 &ipic 2 8>;
+		sleep = <&pmc 0x000c0000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 37c8555..54ad96c 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -127,37 +127,54 @@
 			gpio-controller;
 		};
 
-		i2c@3000 {
+		sleep-nexus {
 			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <14 0x8>;
-			interrupt-parent = <&ipic>;
-			dfsrr;
-
-			dtt@48 {
-				compatible = "national,lm75";
-				reg = <0x48>;
-			};
-
-			at24@50 {
-				compatible = "at24,24c256";
-				reg = <0x50>;
-			};
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			sleep = <&pmc 0x0c000000>;
+			ranges;
 
-			rtc@68 {
-				compatible = "dallas,ds1339";
-				reg = <0x68>;
+			i2c@3000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <0>;
+				compatible = "fsl-i2c";
+				reg = <0x3000 0x100>;
+				interrupts = <14 0x8>;
+				interrupt-parent = <&ipic>;
+				dfsrr;
+
+				dtt@48 {
+					compatible = "national,lm75";
+					reg = <0x48>;
+				};
+
+				at24@50 {
+					compatible = "at24,24c256";
+					reg = <0x50>;
+				};
+
+				rtc@68 {
+					compatible = "dallas,ds1339";
+					reg = <0x68>;
+				};
+
+				mcu_pio: mcu@a {
+					#gpio-cells = <2>;
+					compatible = "fsl,mc9s08qg8-mpc8378erdb",
+						     "fsl,mcu-mpc8349emitx";
+					reg = <0x0a>;
+					gpio-controller;
+				};
 			};
 
-			mcu_pio: mcu@a {
-				#gpio-cells = <2>;
-				compatible = "fsl,mc9s08qg8-mpc8378erdb",
-					     "fsl,mcu-mpc8349emitx";
-				reg = <0x0a>;
-				gpio-controller;
+			sdhci@2e000 {
+				compatible = "fsl,mpc8378-esdhc", "fsl,mpc8379-esdhc";
+				reg = <0x2e000 0x1000>;
+				interrupts = <42 0x8>;
+				interrupt-parent = <&ipic>;
+				/* Filled in by U-Boot */
+				clock-frequency = <0>;
 			};
 		};
 
@@ -228,6 +245,7 @@
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
 			phy_type = "ulpi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		mdio@24520 {
@@ -271,6 +289,8 @@
 			phy-connection-type = "mii";
 			interrupt-parent = <&ipic>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 		};
 
 		enet1: ethernet@25000 {
@@ -284,6 +304,8 @@
 			phy-connection-type = "mii";
 			interrupt-parent = <&ipic>;
 			fixed-link = <1 1 1000 0 0>;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -316,15 +338,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x9fe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,mpc8378-esdhc", "fsl,mpc8379-esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <42 0x8>;
-			interrupt-parent = <&ipic>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		/* IPIC
@@ -340,6 +354,13 @@
 			#interrupt-cells = <2>;
 			reg = <0x700 0x100>;
 		};
+
+		pmc: power@b00 {
+			compatible = "fsl,mpc8378-pmc", "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 0x8>;
+			interrupt-parent = <&ipic>;
+		};
 	};
 
 	pci0: pci@e0008500 {
@@ -365,6 +386,7 @@
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		sleep = <&pmc 0x00010000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
@@ -390,6 +412,7 @@
 				 0 0 0 2 &ipic 1 8
 				 0 0 0 3 &ipic 1 8
 				 0 0 0 4 &ipic 1 8>;
+		sleep = <&pmc 0x00300000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
@@ -421,6 +444,7 @@
 				 0 0 0 2 &ipic 2 8
 				 0 0 0 3 &ipic 2 8
 				 0 0 0 4 &ipic 2 8>;
+		sleep = <&pmc 0x000c0000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index 1b61cda..9deb5b2 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -127,21 +127,38 @@
 			reg = <0x200 0x100>;
 		};
 
-		i2c@3000 {
+		sleep-nexus {
 			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <14 0x8>;
-			interrupt-parent = <&ipic>;
-			dfsrr;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			sleep = <&pmc 0x0c000000>;
+			ranges;
 
-			rtc@68 {
-				compatible = "dallas,ds1374";
-				reg = <0x68>;
-				interrupts = <19 0x8>;
+			i2c@3000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <0>;
+				compatible = "fsl-i2c";
+				reg = <0x3000 0x100>;
+				interrupts = <14 0x8>;
 				interrupt-parent = <&ipic>;
+				dfsrr;
+
+				rtc@68 {
+					compatible = "dallas,ds1374";
+					reg = <0x68>;
+					interrupts = <19 0x8>;
+					interrupt-parent = <&ipic>;
+				};
+			};
+
+			sdhci@2e000 {
+				compatible = "fsl,mpc8379-esdhc";
+				reg = <0x2e000 0x1000>;
+				interrupts = <42 0x8>;
+				interrupt-parent = <&ipic>;
+				/* Filled in by U-Boot */
+				clock-frequency = <0>;
 			};
 		};
 
@@ -213,6 +230,7 @@
 			interrupts = <38 0x8>;
 			dr_mode = "host";
 			phy_type = "ulpi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		mdio@24520 {
@@ -262,6 +280,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 		};
 
 		enet1: ethernet@25000 {
@@ -276,6 +296,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy3>;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -308,15 +330,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x9fe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,mpc8379-esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <42 0x8>;
-			interrupt-parent = <&ipic>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		sata@18000 {
@@ -324,6 +338,7 @@
 			reg = <0x18000 0x1000>;
 			interrupts = <44 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x000000c0>;
 		};
 
 		sata@19000 {
@@ -331,6 +346,7 @@
 			reg = <0x19000 0x1000>;
 			interrupts = <45 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000030>;
 		};
 
 		sata@1a000 {
@@ -338,6 +354,7 @@
 			reg = <0x1a000 0x1000>;
 			interrupts = <46 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0000000c>;
 		};
 
 		sata@1b000 {
@@ -345,6 +362,7 @@
 			reg = <0x1b000 0x1000>;
 			interrupts = <47 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000003>;
 		};
 
 		/* IPIC
@@ -360,6 +378,13 @@
 			#interrupt-cells = <2>;
 			reg = <0x700 0x100>;
 		};
+
+		pmc: power@b00 {
+			compatible = "fsl,mpc8379-pmc", "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 0x8>;
+			interrupt-parent = <&ipic>;
+		};
 	};
 
 	pci0: pci@e0008500 {
@@ -414,6 +439,7 @@
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
+		sleep = <&pmc 0x00010000>;
 		clock-frequency = <0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index e2f98e6..3f4778f 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -125,37 +125,54 @@
 			gpio-controller;
 		};
 
-		i2c@3000 {
+		sleep-nexus {
 			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <14 0x8>;
-			interrupt-parent = <&ipic>;
-			dfsrr;
-
-			dtt@48 {
-				compatible = "national,lm75";
-				reg = <0x48>;
-			};
-
-			at24@50 {
-				compatible = "at24,24c256";
-				reg = <0x50>;
-			};
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			sleep = <&pmc 0x0c000000>;
+			ranges;
 
-			rtc@68 {
-				compatible = "dallas,ds1339";
-				reg = <0x68>;
+			i2c@3000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <0>;
+				compatible = "fsl-i2c";
+				reg = <0x3000 0x100>;
+				interrupts = <14 0x8>;
+				interrupt-parent = <&ipic>;
+				dfsrr;
+
+				dtt@48 {
+					compatible = "national,lm75";
+					reg = <0x48>;
+				};
+
+				at24@50 {
+					compatible = "at24,24c256";
+					reg = <0x50>;
+				};
+
+				rtc@68 {
+					compatible = "dallas,ds1339";
+					reg = <0x68>;
+				};
+
+				mcu_pio: mcu@a {
+					#gpio-cells = <2>;
+					compatible = "fsl,mc9s08qg8-mpc8379erdb",
+						     "fsl,mcu-mpc8349emitx";
+					reg = <0x0a>;
+					gpio-controller;
+				};
 			};
 
-			mcu_pio: mcu@a {
-				#gpio-cells = <2>;
-				compatible = "fsl,mc9s08qg8-mpc8379erdb",
-					     "fsl,mcu-mpc8349emitx";
-				reg = <0x0a>;
-				gpio-controller;
+			sdhci@2e000 {
+				compatible = "fsl,mpc8379-esdhc";
+				reg = <0x2e000 0x1000>;
+				interrupts = <42 0x8>;
+				interrupt-parent = <&ipic>;
+				/* Filled in by U-Boot */
+				clock-frequency = <0>;
 			};
 		};
 
@@ -226,6 +243,7 @@
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
 			phy_type = "ulpi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		mdio@24520 {
@@ -269,6 +287,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 		};
 
 		enet1: ethernet@25000 {
@@ -283,6 +303,8 @@
 			interrupt-parent = <&ipic>;
 			fixed-link = <1 1 1000 0 0>;
 			tbi-handle = <&tbi1>;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -315,15 +337,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x9fe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
-		};
-
-		sdhci@2e000 {
-			compatible = "fsl,mpc8379-esdhc";
-			reg = <0x2e000 0x1000>;
-			interrupts = <42 0x8>;
-			interrupt-parent = <&ipic>;
-			/* Filled in by U-Boot */
-			clock-frequency = <0>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		sata@18000 {
@@ -331,6 +345,7 @@
 			reg = <0x18000 0x1000>;
 			interrupts = <44 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x000000c0>;
 		};
 
 		sata@19000 {
@@ -338,6 +353,7 @@
 			reg = <0x19000 0x1000>;
 			interrupts = <45 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000030>;
 		};
 
 		sata@1a000 {
@@ -345,6 +361,7 @@
 			reg = <0x1a000 0x1000>;
 			interrupts = <46 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0000000c>;
 		};
 
 		sata@1b000 {
@@ -352,6 +369,7 @@
 			reg = <0x1b000 0x1000>;
 			interrupts = <47 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000003>;
 		};
 
 		/* IPIC
@@ -367,6 +385,13 @@
 			#interrupt-cells = <2>;
 			reg = <0x700 0x100>;
 		};
+
+		pmc: power@b00 {
+			compatible = "fsl,mpc8379-pmc", "fsl,mpc8349-pmc";
+			reg = <0xb00 0x100 0xa00 0x100>;
+			interrupts = <80 0x8>;
+			interrupt-parent = <&ipic>;
+		};
 	};
 
 	pci0: pci@e0008500 {
@@ -392,6 +417,7 @@
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		sleep = <&pmc 0x00010000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
-- 
1.5.6.5
