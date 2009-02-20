Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 024DBDDE17
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 04:13:03 +1100 (EST)
Date: Fri, 20 Feb 2009 20:12:58 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/83xx: Add power management support for MPC837x boards
Message-ID: <20090220171258.GA3050@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
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

A processor is able to wakeup the boards on LAN events (Wake-On-Lan),
console events (with no_console_suspend kernel command line), GPIO
events and external IRQs (IRQ1 and IRQ2).

The processor can also wakeup the boards by the fourth general purpose
timer in GTM1 block, but the GTM wakeup support isn't yet implemented
(it's tested to work, but it's unclear how can we use the quite short
GTM timers, and how do we want to expose the GTM to userspace).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8377_mds.dts |   20 ++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8377_rdb.dts |   20 ++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8378_mds.dts |   18 ++++++++++++++++++
 arch/powerpc/boot/dts/mpc8378_rdb.dts |   18 ++++++++++++++++++
 arch/powerpc/boot/dts/mpc8379_mds.dts |   20 ++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8379_rdb.dts |   20 ++++++++++++++++++++
 6 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 3e3ec8f..c54b90d 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -137,6 +137,7 @@
 			reg = <0x3000 0x100>;
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0c000000>;
 			dfsrr;
 
 			rtc@68 {
@@ -176,6 +177,7 @@
 			interrupts = <38 0x8>;
 			dr_mode = "host";
 			phy_type = "ulpi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		mdio@24520 {
@@ -226,6 +228,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 		};
 
 		enet1: ethernet@25000 {
@@ -240,6 +244,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy3>;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -311,6 +317,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x9fe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		sdhci@2e000 {
@@ -318,6 +325,7 @@
 			reg = <0x2e000 0x1000>;
 			interrupts = <42 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0c000000>;
 			/* Filled in by U-Boot */
 			clock-frequency = <0>;
 		};
@@ -327,6 +335,7 @@
 			reg = <0x18000 0x1000>;
 			interrupts = <44 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x000000c0>;
 		};
 
 		sata@19000 {
@@ -334,6 +343,7 @@
 			reg = <0x19000 0x1000>;
 			interrupts = <45 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000030>;
 		};
 
 		/* IPIC
@@ -349,6 +359,13 @@
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
@@ -403,6 +420,7 @@
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
+		sleep = <&pmc 0x00010000>;
 		clock-frequency = <0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
@@ -428,6 +446,7 @@
 				 0 0 0 2 &ipic 1 8
 				 0 0 0 3 &ipic 1 8
 				 0 0 0 4 &ipic 1 8>;
+		sleep = <&pmc 0x00300000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
@@ -459,6 +478,7 @@
 				 0 0 0 2 &ipic 2 8
 				 0 0 0 3 &ipic 2 8
 				 0 0 0 4 &ipic 2 8>;
+		sleep = <&pmc 0x000c0000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 6f4d614..6c2ce11 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -117,6 +117,7 @@
 			reg = <0x3000 0x100>;
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0c000000>;
 			dfsrr;
 			rtc@68 {
 				compatible = "dallas,ds1339";
@@ -199,6 +200,7 @@
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
 			phy_type = "ulpi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		mdio@24520 {
@@ -243,6 +245,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 		};
 
 		enet1: ethernet@25000 {
@@ -257,6 +261,8 @@
 			interrupt-parent = <&ipic>;
 			fixed-link = <1 1 1000 0 0>;
 			tbi-handle = <&tbi1>;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -289,6 +295,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x9fe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		sdhci@2e000 {
@@ -296,6 +303,7 @@
 			reg = <0x2e000 0x1000>;
 			interrupts = <42 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0c000000>;
 			/* Filled in by U-Boot */
 			clock-frequency = <0>;
 		};
@@ -305,6 +313,7 @@
 			reg = <0x18000 0x1000>;
 			interrupts = <44 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x000000c0>;
 		};
 
 		sata@19000 {
@@ -312,6 +321,7 @@
 			reg = <0x19000 0x1000>;
 			interrupts = <45 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000030>;
 		};
 
 		/* IPIC
@@ -327,6 +337,13 @@
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
@@ -352,6 +369,7 @@
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		sleep = <&pmc 0x00010000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
@@ -377,6 +395,7 @@
 				 0 0 0 2 &ipic 1 8
 				 0 0 0 3 &ipic 1 8
 				 0 0 0 4 &ipic 1 8>;
+		sleep = <&pmc 0x00300000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
@@ -408,6 +427,7 @@
 				 0 0 0 2 &ipic 2 8
 				 0 0 0 3 &ipic 2 8
 				 0 0 0 4 &ipic 2 8>;
+		sleep = <&pmc 0x000c0000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index c3b212c..fbccd1c 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -137,6 +137,7 @@
 			reg = <0x3000 0x100>;
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0c000000>;
 			dfsrr;
 
 			rtc@68 {
@@ -215,6 +216,7 @@
 			interrupts = <38 0x8>;
 			dr_mode = "host";
 			phy_type = "ulpi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		mdio@24520 {
@@ -265,6 +267,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 		};
 
 		enet1: ethernet@25000 {
@@ -279,6 +283,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy3>;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -311,6 +317,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x9fe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		sdhci@2e000 {
@@ -318,6 +325,7 @@
 			reg = <0x2e000 0x1000>;
 			interrupts = <42 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0c000000>;
 			/* Filled in by U-Boot */
 			clock-frequency = <0>;
 		};
@@ -335,6 +343,13 @@
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
@@ -390,6 +405,7 @@
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
 		clock-frequency = <0>;
+		sleep = <&pmc 0x00010000>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
@@ -414,6 +430,7 @@
 				 0 0 0 2 &ipic 1 8
 				 0 0 0 3 &ipic 1 8
 				 0 0 0 4 &ipic 1 8>;
+		sleep = <&pmc 0x00300000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
@@ -445,6 +462,7 @@
 				 0 0 0 2 &ipic 2 8
 				 0 0 0 3 &ipic 2 8
 				 0 0 0 4 &ipic 2 8>;
+		sleep = <&pmc 0x000c0000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 6457ef1..e0364cf 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -117,6 +117,7 @@
 			reg = <0x3000 0x100>;
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0c000000>;
 			dfsrr;
 			rtc@68 {
 				compatible = "dallas,ds1339";
@@ -199,6 +200,7 @@
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
 			phy_type = "ulpi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		mdio@24520 {
@@ -242,6 +244,8 @@
 			phy-connection-type = "mii";
 			interrupt-parent = <&ipic>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 		};
 
 		enet1: ethernet@25000 {
@@ -255,6 +259,8 @@
 			phy-connection-type = "mii";
 			interrupt-parent = <&ipic>;
 			fixed-link = <1 1 1000 0 0>;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -287,6 +293,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x9fe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		sdhci@2e000 {
@@ -294,6 +301,7 @@
 			reg = <0x2e000 0x1000>;
 			interrupts = <42 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0c000000>;
 			/* Filled in by U-Boot */
 			clock-frequency = <0>;
 		};
@@ -311,6 +319,13 @@
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
@@ -336,6 +351,7 @@
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		sleep = <&pmc 0x00010000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
@@ -361,6 +377,7 @@
 				 0 0 0 2 &ipic 1 8
 				 0 0 0 3 &ipic 1 8
 				 0 0 0 4 &ipic 1 8>;
+		sleep = <&pmc 0x00300000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
@@ -392,6 +409,7 @@
 				 0 0 0 2 &ipic 2 8
 				 0 0 0 3 &ipic 2 8
 				 0 0 0 4 &ipic 2 8>;
+		sleep = <&pmc 0x000c0000>;
 		clock-frequency = <0>;
 
 		pcie@0 {
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index 1b61cda..307969b 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -135,6 +135,7 @@
 			reg = <0x3000 0x100>;
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0c000000>;
 			dfsrr;
 
 			rtc@68 {
@@ -213,6 +214,7 @@
 			interrupts = <38 0x8>;
 			dr_mode = "host";
 			phy_type = "ulpi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		mdio@24520 {
@@ -262,6 +264,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 		};
 
 		enet1: ethernet@25000 {
@@ -276,6 +280,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy3>;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -308,6 +314,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x9fe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		sdhci@2e000 {
@@ -315,6 +322,7 @@
 			reg = <0x2e000 0x1000>;
 			interrupts = <42 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0c000000>;
 			/* Filled in by U-Boot */
 			clock-frequency = <0>;
 		};
@@ -324,6 +332,7 @@
 			reg = <0x18000 0x1000>;
 			interrupts = <44 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x000000c0>;
 		};
 
 		sata@19000 {
@@ -331,6 +340,7 @@
 			reg = <0x19000 0x1000>;
 			interrupts = <45 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000030>;
 		};
 
 		sata@1a000 {
@@ -338,6 +348,7 @@
 			reg = <0x1a000 0x1000>;
 			interrupts = <46 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0000000c>;
 		};
 
 		sata@1b000 {
@@ -345,6 +356,7 @@
 			reg = <0x1b000 0x1000>;
 			interrupts = <47 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000003>;
 		};
 
 		/* IPIC
@@ -360,6 +372,13 @@
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
@@ -414,6 +433,7 @@
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe0300000 0x0 0x00100000>;
+		sleep = <&pmc 0x00010000>;
 		clock-frequency = <0>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 203fff2..434c01c 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -115,6 +115,7 @@
 			reg = <0x3000 0x100>;
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0c000000>;
 			dfsrr;
 			rtc@68 {
 				compatible = "dallas,ds1339";
@@ -197,6 +198,7 @@
 			interrupt-parent = <&ipic>;
 			interrupts = <38 0x8>;
 			phy_type = "ulpi";
+			sleep = <&pmc 0x00c00000>;
 		};
 
 		mdio@24520 {
@@ -240,6 +242,8 @@
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+			sleep = <&pmc 0xc0000000>;
+			fsl,magic-packet;
 		};
 
 		enet1: ethernet@25000 {
@@ -254,6 +258,8 @@
 			interrupt-parent = <&ipic>;
 			fixed-link = <1 1 1000 0 0>;
 			tbi-handle = <&tbi1>;
+			sleep = <&pmc 0x30000000>;
+			fsl,magic-packet;
 		};
 
 		serial0: serial@4500 {
@@ -286,6 +292,7 @@
 			fsl,channel-fifo-len = <24>;
 			fsl,exec-units-mask = <0x9fe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
+			sleep = <&pmc 0x03000000>;
 		};
 
 		sdhci@2e000 {
@@ -293,6 +300,7 @@
 			reg = <0x2e000 0x1000>;
 			interrupts = <42 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0c000000>;
 			/* Filled in by U-Boot */
 			clock-frequency = <0>;
 		};
@@ -302,6 +310,7 @@
 			reg = <0x18000 0x1000>;
 			interrupts = <44 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x000000c0>;
 		};
 
 		sata@19000 {
@@ -309,6 +318,7 @@
 			reg = <0x19000 0x1000>;
 			interrupts = <45 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000030>;
 		};
 
 		sata@1a000 {
@@ -316,6 +326,7 @@
 			reg = <0x1a000 0x1000>;
 			interrupts = <46 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x0000000c>;
 		};
 
 		sata@1b000 {
@@ -323,6 +334,7 @@
 			reg = <0x1b000 0x1000>;
 			interrupts = <47 0x8>;
 			interrupt-parent = <&ipic>;
+			sleep = <&pmc 0x00000003>;
 		};
 
 		/* IPIC
@@ -338,6 +350,13 @@
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
@@ -363,6 +382,7 @@
 		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
 		          0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 		          0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		sleep = <&pmc 0x00010000>;
 		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
-- 
1.5.6.5
