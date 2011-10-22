Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A0B59B7090
 for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2011 08:20:56 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p9MLKrJK009755
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2011 16:20:53 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/11] powerpc/85xx: Simplify P1020RDB CAMP dts using includes
Date: Sat, 22 Oct 2011 16:20:43 -0500
Message-Id: <1319318452-27036-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1319318452-27036-1-git-send-email-galak@kernel.crashing.org>
References: <1319318452-27036-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we include the p1020rdb.dts instead of p1020si.dts we greatly reduce
duplication and maintenance.  We can just list which devices are
disabled for the given core and mpic protected sources.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts |  154 +------------------------
 arch/powerpc/boot/dts/p1020rdb_camp_core1.dts |   11 +--
 2 files changed, 4 insertions(+), 161 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts b/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
index f0bf7f4..41b4585 100644
--- a/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
+++ b/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
@@ -16,7 +16,7 @@
  * option) any later version.
  */
 
-/include/ "p1020si.dtsi"
+/include/ "p1020rdb.dts"
 
 / {
 	model = "fsl,P1020RDB";
@@ -32,7 +32,7 @@
 
 	cpus {
 		PowerPC,P1020@1 {
-		status = "disabled";
+			status = "disabled";
 		};
 	};
 
@@ -45,169 +45,19 @@
 	};
 
 	soc@ffe00000 {
-		i2c@3000 {
-			rtc@68 {
-				compatible = "dallas,ds1339";
-				reg = <0x68>;
-			};
-		};
-
 		serial1: serial@4600 {
 			status = "disabled";
 		};
 
-		spi@7000 {
-			fsl_m25p80@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "fsl,espi-flash";
-				reg = <0>;
-				linux,modalias = "fsl_m25p80";
-				spi-max-frequency = <40000000>;
-
-				partition@0 {
-					/* 512KB for u-boot Bootloader Image */
-					reg = <0x0 0x00080000>;
-					label = "SPI (RO) U-Boot Image";
-					read-only;
-				};
-
-				partition@80000 {
-					/* 512KB for DTB Image */
-					reg = <0x00080000 0x00080000>;
-					label = "SPI (RO) DTB Image";
-					read-only;
-				};
-
-				partition@100000 {
-					/* 4MB for Linux Kernel Image */
-					reg = <0x00100000 0x00400000>;
-					label = "SPI (RO) Linux Kernel Image";
-					read-only;
-				};
-
-				partition@500000 {
-					/* 4MB for Compressed RFS Image */
-					reg = <0x00500000 0x00400000>;
-					label = "SPI (RO) Compressed RFS Image";
-					read-only;
-				};
-
-				partition@900000 {
-					/* 7MB for JFFS2 based RFS */
-					reg = <0x00900000 0x00700000>;
-					label = "SPI (RW) JFFS2 RFS";
-				};
-			};
-		};
-
-		mdio@24000 {
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <3 1>;
-				reg = <0x0>;
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <2 1>;
-				reg = <0x1>;
-			};
-		};
-
-		mdio@25000 {
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		enet0: ethernet@b0000 {
 			status = "disabled";
 		};
 
-		enet1: ethernet@b1000 {
-			phy-handle = <&phy0>;
-			tbi-handle = <&tbi0>;
-			phy-connection-type = "sgmii";
-		};
-
-		enet2: ethernet@b2000 {
-			phy-handle = <&phy1>;
-			phy-connection-type = "rgmii-id";
-		};
-
-		usb@22000 {
-			phy_type = "ulpi";
-		};
-
-		/* USB2 is shared with localbus, so it must be disabled
-		   by default. We can't put 'status = "disabled";' here
-		   since U-Boot doesn't clear the status property when
-		   it enables USB2. OTOH, U-Boot does create a new node
-		   when there isn't any. So, just comment it out.
-		usb@23000 {
-			phy_type = "ulpi";
-		};
-		*/
-
 		mpic: pic@40000 {
 			protected-sources = <
 			42 29 30 34	/* serial1, enet0-queue-group0 */
 			17 18 24 45	/* enet0-queue-group1, crypto */
 			>;
 		};
-
-	};
-
-	pci0: pcie@ffe09000 {
-		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x4 0x1
-			0000 0x0 0x0 0x2 &mpic 0x5 0x1
-			0000 0x0 0x0 0x3 &mpic 0x6 0x1
-			0000 0x0 0x0 0x4 &mpic 0x7 0x1
-			>;
-		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x2000000 0x0 0xa0000000
-				  0x2000000 0x0 0xa0000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
-
-	pci1: pcie@ffe0a000 {
-		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0000 0x0 0x0 0x4 &mpic 0x3 0x1
-			>;
-		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x2000000 0x0 0x80000000
-				  0x2000000 0x0 0x80000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/p1020rdb_camp_core1.dts b/arch/powerpc/boot/dts/p1020rdb_camp_core1.dts
index 6ec0220..5174538 100644
--- a/arch/powerpc/boot/dts/p1020rdb_camp_core1.dts
+++ b/arch/powerpc/boot/dts/p1020rdb_camp_core1.dts
@@ -15,7 +15,7 @@
  * option) any later version.
  */
 
-/include/ "p1020si.dtsi"
+/include/ "p1020rdb.dts"
 
 / {
 	model = "fsl,P1020RDB";
@@ -28,7 +28,7 @@
 
 	cpus {
 		PowerPC,P1020@0 {
-		status = "disabled";
+			status = "disabled";
 		};
 	};
 
@@ -85,12 +85,6 @@
 			status = "disabled";
 		};
 
-		enet0: ethernet@b0000 {
-			fixed-link = <1 1 1000 0 0>;
-			phy-connection-type = "rgmii-id";
-
-		};
-
 		enet1: ethernet@b1000 {
 			status = "disabled";
 		};
@@ -135,7 +129,6 @@
 		global-utilities@e0000 {	//global utilities block
 			status = "disabled";
 		};
-
 	};
 
 	pci0: pcie@ffe09000 {
-- 
1.7.3.4
