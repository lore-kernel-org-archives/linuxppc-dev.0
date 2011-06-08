Return-Path: <B32579@freescale.com>
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree-discuss@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx:DTS: Fix tbi node location for Px020RDB
Date: Wed, 8 Jun 2011 08:19:39 +0530
Message-ID: <1307501379-3160-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ten-bit interface (TBI) module is part of SoC not board.

Move tbi entries from board related dts files to Si dts.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git (branch next)

 arch/powerpc/boot/dts/p1020rdb.dts            |    9 ---------
 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts |    8 --------
 arch/powerpc/boot/dts/p1020si.dtsi            |    6 +++++-
 arch/powerpc/boot/dts/p2020rdb.dts            |    8 --------
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |    8 --------
 arch/powerpc/boot/dts/p2020si.dtsi            |    6 +++++-
 6 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/p1020rdb.dts
index d6a8ae4..a4e5d6c 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dts
+++ b/arch/powerpc/boot/dts/p1020rdb.dts
@@ -211,14 +211,6 @@
 			};
 		};
 
-		mdio@25000 {
-
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		enet0: ethernet@b0000 {
 			fixed-link = <1 1 1000 0 0>;
 			phy-connection-type = "rgmii-id";
@@ -227,7 +219,6 @@
 
 		enet1: ethernet@b1000 {
 			phy-handle = <&phy0>;
-			tbi-handle = <&tbi0>;
 			phy-connection-type = "sgmii";
 
 		};
diff --git a/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts b/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
index f0bf7f4..abab234 100644
--- a/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
+++ b/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
@@ -114,20 +114,12 @@
 			};
 		};
 
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
 
 		enet1: ethernet@b1000 {
 			phy-handle = <&phy0>;
-			tbi-handle = <&tbi0>;
 			phy-connection-type = "sgmii";
 		};
 
diff --git a/arch/powerpc/boot/dts/p1020si.dtsi b/arch/powerpc/boot/dts/p1020si.dtsi
index 5c5acb6..7844d2e 100644
--- a/arch/powerpc/boot/dts/p1020si.dtsi
+++ b/arch/powerpc/boot/dts/p1020si.dtsi
@@ -190,7 +190,10 @@
 			#size-cells = <0>;
 			compatible = "fsl,etsec2-tbi";
 			reg = <0x25000 0x1000 0xb1030 0x4>;
-
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 
 		enet0: ethernet@b0000 {
@@ -229,6 +232,7 @@
 			fsl,num_tx_queues = <0x8>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
 
 			queue-group@0 {
 				#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index 1d7a05f..2941cbb 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -213,13 +213,6 @@
 				};
 		};
 
-		mdio@25520 {
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		mdio@26520 {
 			status = "disabled";
 		};
@@ -243,7 +236,6 @@
 		};
 
 		enet1: ethernet@25000 {
-			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "sgmii";
 		};
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
index fc8dddd..4641f3d 100644
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
+++ b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
@@ -124,13 +124,6 @@
 			};
 		};
 
-		mdio@25520 {
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		mdio@26520 {
 			status = "disabled";
 		};
@@ -140,7 +133,6 @@
 		};
 
 		enet1: ethernet@25000 {
-			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "sgmii";
 
diff --git a/arch/powerpc/boot/dts/p2020si.dtsi b/arch/powerpc/boot/dts/p2020si.dtsi
index 6def17f..9317075 100644
--- a/arch/powerpc/boot/dts/p2020si.dtsi
+++ b/arch/powerpc/boot/dts/p2020si.dtsi
@@ -235,6 +235,10 @@
 			#size-cells = <0>;
 			compatible = "fsl,gianfar-tbi";
 			reg = <0x26520 0x20>;
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 
 		mdio@26520 {
@@ -270,7 +274,7 @@
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
-
+			tbi-handle = <&tbi0>;
 		};
 
 		enet2: ethernet@26000 {
-- 
1.7.3
