Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CB8ADDDF6
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 18:53:48 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lBC7rhN4031002
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 01:53:44 -0600
Date: Wed, 12 Dec 2007 01:52:05 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] FSL: enet device tree cleanups   
Message-ID: <Pine.LNX.4.64.0712120151590.25255@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Removed address fields in ethernet nodes
* Removed #address-cells, #size-cells from gianfar nodes
* Added cell-index to gianfar and ucc ethernet nodes
* Added enet[0..3] labels
* Renamed compatible node for gianfar mdio to "fsl,gianfar-mdio"
* Removed device_type = "mdio"

The matching for gianfar mdio still supports the old "mdio"/"gianfar" combo
but it is now considered deprecated.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 Documentation/powerpc/booting-without-of.txt |    6 +--
 arch/powerpc/boot/dts/mpc8313erdb.dts        |   11 +++---
 arch/powerpc/boot/dts/mpc832x_mds.dts        |   18 ++--------
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |   18 ++--------
 arch/powerpc/boot/dts/mpc8349emitx.dts       |   25 +++-----------
 arch/powerpc/boot/dts/mpc8349emitxgp.dts     |    8 ++--
 arch/powerpc/boot/dts/mpc834x_mds.dts        |   26 ++++-----------
 arch/powerpc/boot/dts/mpc836x_mds.dts        |   18 ++--------
 arch/powerpc/boot/dts/mpc8540ads.dts         |   37 ++++----------------
 arch/powerpc/boot/dts/mpc8541cds.dts         |   14 +++----
 arch/powerpc/boot/dts/mpc8544ds.dts          |   14 +++----
 arch/powerpc/boot/dts/mpc8548cds.dts         |   24 ++++++--------
 arch/powerpc/boot/dts/mpc8555cds.dts         |   14 +++----
 arch/powerpc/boot/dts/mpc8560ads.dts         |   42 +++++-------------------
 arch/powerpc/boot/dts/mpc8568mds.dts         |   45 ++++++--------------------
 arch/powerpc/boot/dts/mpc8572ds.dts          |   24 ++++++--------
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |   40 +++-------------------
 arch/powerpc/sysdev/fsl_soc.c                |   15 ++++++---
 18 files changed, 118 insertions(+), 281 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 7327f37..c3fc9d9 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1223,16 +1223,14 @@ platforms are moved over to use the flattened-device-tree model.

   Required properties:
     - reg : Offset and length of the register set for the device
-    - device_type : Should be "mdio"
     - compatible : Should define the compatible device type for the
-      mdio.  Currently, this is most likely to be "gianfar"
+      mdio.  Currently, this is most likely to be "fsl,gianfar-mdio"

   Example:

 	mdio@24520 {
 		reg = <24520 20>;
-		device_type = "mdio";
-		compatible = "gianfar";
+		compatible = "fsl,gianfar-mdio";

 		ethernet-phy@0 {
 			......
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index d417f1b..2f83050 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -95,11 +95,10 @@
 		};

 		mdio@24520 {
-			device_type = "mdio";
-			compatible = "gianfar";
-			reg = <24520 20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <24520 20>;
 			phy1: ethernet-phy@1 {
 				interrupt-parent = < &ipic >;
 				interrupts = <13 8>;
@@ -114,7 +113,8 @@
 			};
 		};

-		ethernet@24000 {
+		enet0: ethernet@24000 {
+			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
@@ -125,7 +125,8 @@
 			phy-handle = < &phy1 >;
 		};

-		ethernet@25000 {
+		enet1: ethernet@25000 {
+			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index f866e81..b0d89d6 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -208,20 +208,15 @@
 			mode = "slave";
 		};

-		ucc@2200 {
+		enet0: ucc@2200 {
 			device_type = "network";
 			compatible = "ucc_geth";
 			model = "UCC";
+			cell-index = <3>;
 			device-id = <3>;
 			reg = <2200 200>;
 			interrupts = <22>;
 			interrupt-parent = < &qeic >;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <19>;
 			tx-clock = <1a>;
@@ -229,20 +224,15 @@
 			pio-handle = < &pio3 >;
 		};

-		ucc@3200 {
+		enet1: ucc@3200 {
 			device_type = "network";
 			compatible = "ucc_geth";
 			model = "UCC";
+			cell-index = <4>;
 			device-id = <4>;
 			reg = <3200 200>;
 			interrupts = <23>;
 			interrupt-parent = < &qeic >;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <17>;
 			tx-clock = <18>;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 91849dd..0c64381 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -189,20 +189,15 @@
 			mode = "cpu";
 		};

-		ucc@3000 {
+		enet0: ucc@3000 {
 			device_type = "network";
 			compatible = "ucc_geth";
 			model = "UCC";
+			cell-index = <2>;
 			device-id = <2>;
 			reg = <3000 200>;
 			interrupts = <21>;
 			interrupt-parent = <&qeic>;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <20>;
 			tx-clock = <13>;
@@ -210,20 +205,15 @@
 			pio-handle = <&ucc2pio>;
 		};

-		ucc@2200 {
+		enet1: ucc@2200 {
 			device_type = "network";
 			compatible = "ucc_geth";
 			model = "UCC";
+			cell-index = <3>;
 			device-id = <3>;
 			reg = <2200 200>;
 			interrupts = <22>;
 			interrupt-parent = <&qeic>;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <19>;
 			tx-clock = <1a>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index c29e4f4..d2184ad 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -106,11 +106,10 @@
 		};

 		mdio@24520 {
-			device_type = "mdio";
-			compatible = "gianfar";
-			reg = <24520 20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <24520 20>;

 			/* Vitesse 8201 */
 			phy1c: ethernet-phy@1c {
@@ -129,17 +128,12 @@
 			};
 		};

-		ethernet@24000 {
+		enet0: ethernet@24000 {
+			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			/*
-			 * address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <20 8 21 8 22 8>;
 			interrupt-parent = < &ipic >;
@@ -147,19 +141,12 @@
 			linux,network-index = <0>;
 		};

-		ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet1: ethernet@25000 {
+			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			/*
-			 * address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 8 24 8 25 8>;
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index 6e51d17..30c6816 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -94,11 +94,10 @@
 		};

 		mdio@24520 {
-			device_type = "mdio";
-			compatible = "gianfar";
-			reg = <24520 20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <24520 20>;

 			/* Vitesse 8201 */
 			phy1c: ethernet-phy@1c {
@@ -109,7 +108,8 @@
 			};
 		};

-		ethernet@24000 {
+		enet0: ethernet@24000 {
+			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 73311e8..c5239c9 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -119,11 +119,11 @@
 		};

 		mdio@24520 {
-			device_type = "mdio";
-			compatible = "gianfar";
-			reg = <24520 20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <24520 20>;
+
 			phy0: ethernet-phy@0 {
 				interrupt-parent = < &ipic >;
 				interrupts = <11 8>;
@@ -138,17 +138,12 @@
 			};
 		};

-		ethernet@24000 {
+		enet0: ethernet@24000 {
+			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			/*
-			 * address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <20 8 21 8 22 8>;
 			interrupt-parent = < &ipic >;
@@ -156,19 +151,12 @@
 			linux,network-index = <0>;
 		};

-		ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet1: ethernet@25000 {
+			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			/*
-			 * address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 8 24 8 25 8>;
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 8b7d778..3b0873a 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -239,20 +239,15 @@
 			mode = "slave";
 		};

-		ucc@2000 {
+		enet0: ucc@2000 {
 			device_type = "network";
 			compatible = "ucc_geth";
 			model = "UCC";
+			cell-index = <1>;
 			device-id = <1>;
 			reg = <2000 200>;
 			interrupts = <20>;
 			interrupt-parent = < &qeic >;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <0>;
 			tx-clock = <19>;
@@ -261,20 +256,15 @@
 			pio-handle = < &pio1 >;
 		};

-		ucc@3000 {
+		enet1: ucc@3000 {
 			device_type = "network";
 			compatible = "ucc_geth";
 			model = "UCC";
+			cell-index = <2>;
 			device-id = <2>;
 			reg = <3000 200>;
 			interrupts = <21>;
 			interrupt-parent = < &qeic >;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <0>;
 			tx-clock = <14>;
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 435a2b6..7961d91 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -76,9 +76,9 @@
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "mdio";
-			compatible = "gianfar";
+			compatible = "fsl,gianfar-mdio";
 			reg = <24520 20>;
+
 			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
 				interrupts = <5 1>;
@@ -99,57 +99,36 @@
 			};
 		};

-		ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet0: ethernet@24000 {
+			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			/*
-			 * address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <1d 2 1e 2 22 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
 		};

-		ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet1: ethernet@25000 {
+			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			/*
-			 * address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 2 24 2 28 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
 		};

-		ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet2: ethernet@26000 {
+			cell-index = <2>;
 			device_type = "network";
 			model = "FEC";
 			compatible = "gianfar";
 			reg = <26000 1000>;
-			/*
-			 * address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <29 2>;
 			interrupt-parent = <&mpic>;
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 101c0b6..8637fe0 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -76,9 +76,9 @@
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "mdio";
-			compatible = "gianfar";
+			compatible = "fsl,gianfar-mdio";
 			reg = <24520 20>;
+
 			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
 				interrupts = <5 1>;
@@ -93,9 +93,8 @@
 			};
 		};

-		ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet0: ethernet@24000 {
+			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
@@ -106,9 +105,8 @@
 			phy-handle = <&phy0>;
 		};

-		ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet1: ethernet@25000 {
+			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index a81ecca..a98c46e 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -88,9 +88,9 @@
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "mdio";
-			compatible = "gianfar";
+			compatible = "fsl,gianfar-mdio";
 			reg = <24520 20>;
+
 			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
 				interrupts = <a 1>;
@@ -105,9 +105,8 @@
 			};
 		};

-		ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet0: ethernet@24000 {
+			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
@@ -119,9 +118,8 @@
 			phy-connection-type = "rgmii-id";
 		};

-		ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet1: ethernet@26000 {
+			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 70358dc..64f83d0 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -87,9 +87,9 @@
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "mdio";
-			compatible = "gianfar";
+			compatible = "fsl,gianfar-mdio";
 			reg = <24520 20>;
+
 			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
 				interrupts = <5 1>;
@@ -116,9 +116,8 @@
 			};
 		};

-		ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet0: ethernet@24000 {
+			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
@@ -129,9 +128,8 @@
 			phy-handle = <&phy0>;
 		};

-		ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet1: ethernet@25000 {
+			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
@@ -143,9 +141,8 @@
 		};

 /* eTSEC 3/4 are currently broken
-		ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet2: ethernet@26000 {
+			cell-index = <2>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
@@ -156,9 +153,8 @@
 			phy-handle = <&phy2>;
 		};

-		ethernet@27000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet3: ethernet@27000 {
+			cell-index = <3>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 1e8bf46..339e873 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -76,9 +76,9 @@
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "mdio";
-			compatible = "gianfar";
+			compatible = "fsl,gianfar-mdio";
 			reg = <24520 20>;
+
 			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
 				interrupts = <5 1>;
@@ -93,9 +93,8 @@
 			};
 		};

-		ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet0: ethernet@24000 {
+			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
@@ -106,9 +105,8 @@
 			phy-handle = <&phy0>;
 		};

-		ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet1: ethernet@25000 {
+			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 6b362f8..936a4d5 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -63,11 +63,11 @@
 		};

 		mdio@24520 {
-			device_type = "mdio";
-			compatible = "gianfar";
-			reg = <24520 20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <24520 20>;
+
 			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
 				interrupts = <5 1>;
@@ -94,36 +94,24 @@
 			};
 		};

-		ethernet@24000 {
+		enet0: ethernet@24000 {
+			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			/*
-			 * address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <1d 2 1e 2 22 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
 		};

-		ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet1: ethernet@25000 {
+			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			/*
-			 * address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 2 24 2 28 2>;
 			interrupt-parent = <&mpic>;
@@ -198,17 +186,11 @@
 				interrupt-parent = <&cpmpic>;
 			};

-			ethernet@91320 {
+			enet2: ethernet@91320 {
 				device_type = "network";
 				compatible = "fsl,mpc8560-fcc-enet",
 				             "fsl,cpm2-fcc-enet";
 				reg = <91320 20 88500 100 913b0 1>;
-				/*
-				 * mac-address is deprecated and will be removed
-				 * in 2.6.25.  Only recent versions of
-				 * U-Boot support local-mac-address, however.
-				 */
-				mac-address = [ 00 00 00 00 00 00 ];
 				local-mac-address = [ 00 00 00 00 00 00 ];
 				fsl,cpm-command = <16200300>;
 				interrupts = <21 8>;
@@ -216,17 +198,11 @@
 				phy-handle = <&phy2>;
 			};

-			ethernet@91340 {
+			enet3: ethernet@91340 {
 				device_type = "network";
 				compatible = "fsl,mpc8560-fcc-enet",
 				             "fsl,cpm2-fcc-enet";
 				reg = <91340 20 88600 100 913d0 1>;
-				/*
-				 * mac-address is deprecated and will be removed
-				 * in 2.6.25.  Only recent versions of
-				 * U-Boot support local-mac-address, however.
-				 */
-				mac-address = [ 00 00 00 00 00 00 ];
 				local-mac-address = [ 00 00 00 00 00 00 ];
 				fsl,cpm-command = <1a400300>;
 				interrupts = <22 8>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index d73e5f1..60f0eab 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -101,9 +101,9 @@
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "mdio";
-			compatible = "gianfar";
+			compatible = "fsl,gianfar-mdio";
 			reg = <24520 20>;
+
 			phy0: ethernet-phy@7 {
 				interrupt-parent = <&mpic>;
 				interrupts = <1 1>;
@@ -130,38 +130,24 @@
 			};
 		};

-		ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet0: ethernet@24000 {
+			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
  			interrupts = <1d 2 1e 2 22 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy2>;
 		};

-		ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet1: ethernet@25000 {
+			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
  			interrupts = <23 2 24 2 28 2>;
 			interrupt-parent = <&mpic>;
@@ -318,20 +304,15 @@
 			mode = "cpu";
 		};

-		ucc@2000 {
+		enet2: ucc@2000 {
 			device_type = "network";
 			compatible = "ucc_geth";
 			model = "UCC";
+			cell-index = <1>;
 			device-id = <1>;
 			reg = <2000 200>;
 			interrupts = <20>;
 			interrupt-parent = <&qeic>;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <0>;
 			tx-clock = <20>;
@@ -340,20 +321,15 @@
 			phy-connection-type = "rgmii-id";
 		};

-		ucc@3000 {
+		enet3: ucc@3000 {
 			device_type = "network";
 			compatible = "ucc_geth";
 			model = "UCC";
+			cell-index = <2>;
 			device-id = <2>;
 			reg = <3000 200>;
 			interrupts = <21>;
 			interrupt-parent = <&qeic>;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <0>;
 			tx-clock = <20>;
@@ -366,7 +342,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2120 18>;
-			device_type = "mdio";
 			compatible = "ucc_geth_phy";

 			/* These are the same PHYs as on
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 91d15e8..c2a8ffa 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -93,9 +93,9 @@
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "mdio";
-			compatible = "gianfar";
+			compatible = "fsl,gianfar-mdio";
 			reg = <24520 20>;
+
 			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
 				interrupts = <a 1>;
@@ -118,9 +118,8 @@
 			};
 		};

-		ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet0: ethernet@24000 {
+			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
@@ -132,9 +131,8 @@
 			phy-connection-type = "rgmii-id";
 		};

-		ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet1: ethernet@25000 {
+			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
@@ -146,9 +144,8 @@
 			phy-connection-type = "rgmii-id";
 		};

-		ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet2: ethernet@26000 {
+			cell-index = <2>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
@@ -160,9 +157,8 @@
 			phy-connection-type = "rgmii-id";
 		};

-		ethernet@27000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		enet3: ethernet@27000 {
+			cell-index = <3>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index dc0efaf..ddd8fbb 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -93,9 +93,9 @@
 		mdio@24520 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			device_type = "mdio";
-			compatible = "gianfar";
+			compatible = "fsl,gianfar-mdio";
 			reg = <24520 20>;
+
 			phy0: ethernet-phy@0 {
 				interrupt-parent = <&mpic>;
 				interrupts = <a 1>;
@@ -123,18 +123,11 @@
 		};

 		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <24000 1000>;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <1d 2 1e 2 22 2>;
 			interrupt-parent = <&mpic>;
@@ -143,18 +136,11 @@
 		};

 		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <25000 1000>;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 2 24 2 28 2>;
 			interrupt-parent = <&mpic>;
@@ -163,18 +149,11 @@
 		};

 		enet2: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+			cell-index = <2>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <26000 1000>;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <1F 2 20 2 21 2>;
 			interrupt-parent = <&mpic>;
@@ -183,18 +162,11 @@
 		};

 		enet3: ethernet@27000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
+			cell-index = <3>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <27000 1000>;
-			/*
-			 * mac-address is deprecated and will be removed
-			 * in 2.6.25.  Only recent versions of
-			 * U-Boot support local-mac-address, however.
-			 */
-			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <25 2 26 2 27 2>;
 			interrupt-parent = <&mpic>;
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 81af4bd..4baad80 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -132,15 +132,18 @@ EXPORT_SYMBOL(get_baudrate);

 static int __init gfar_mdio_of_init(void)
 {
-	struct device_node *np;
-	unsigned int i;
+	struct device_node *np = NULL;
 	struct platform_device *mdio_dev;
 	struct resource res;
 	int ret;

-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "mdio", "gianfar")) != NULL;
-	     i++) {
+	np = of_find_compatible_node(np, NULL, "fsl,gianfar-mdio");
+
+	/* try the deprecated version */
+	if (!np)
+		np = of_find_compatible_node(np, "mdio", "gianfar");
+
+	if (np) {
 		int k;
 		struct device_node *child = NULL;
 		struct gianfar_mdio_data mdio_data;
@@ -179,11 +182,13 @@ static int __init gfar_mdio_of_init(void)
 			goto unreg;
 	}

+	of_node_put(np);
 	return 0;

 unreg:
 	platform_device_unregister(mdio_dev);
 err:
+	of_node_put(np);
 	return ret;
 }

-- 
1.5.3.4
