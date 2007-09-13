Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68439DE0B8
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:34 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/22] [POWERPC] Move PCI nodes to be sibilings with SOC nodes
Date: Thu, 13 Sep 2007 16:07:50 -0500
Message-Id: <11897176992010-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11897176964013-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
	<1189717687832-git-send-email-galak@kernel.crashing.org>
	<11897176884163-git-send-email-galak@kernel.crashing.org>
	<1189717690413-git-send-email-galak@kernel.crashing.org>
	<1189717691261-git-send-email-galak@kernel.crashing.org>
	<11897176931664-git-send-email-galak@kernel.crashing.org>
	<118971769498-git-send-email-galak@kernel.crashing.org>
	<11897176964013-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updated the device trees to have the PCI nodes be at the same level as
the SOC node.  This is to make it so that the SOC nodes children address
space is just on chip registers and not other bus memory as well.

Also, for PCIe nodes added a P2P bridge to handle the virtual P2P bridge
that exists in the PHB.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/lite5200.dts       |   42 ++--
 arch/powerpc/boot/dts/lite5200b.dts      |   52 ++--
 arch/powerpc/boot/dts/mpc8313erdb.dts    |   60 +++---
 arch/powerpc/boot/dts/mpc832x_mds.dts    |  118 +++++-----
 arch/powerpc/boot/dts/mpc832x_rdb.dts    |   66 +++---
 arch/powerpc/boot/dts/mpc8349emitx.dts   |   95 ++++----
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |   44 ++--
 arch/powerpc/boot/dts/mpc834x_mds.dts    |  240 +++++++++---------
 arch/powerpc/boot/dts/mpc836x_mds.dts    |  119 +++++-----
 arch/powerpc/boot/dts/mpc8540ads.dts     |  172 +++++++-------
 arch/powerpc/boot/dts/mpc8541cds.dts     |  190 +++++++-------
 arch/powerpc/boot/dts/mpc8544ds.dts      |  372 +++++++++++++++-------------
 arch/powerpc/boot/dts/mpc8548cds.dts     |  399 +++++++++++++++---------------
 arch/powerpc/boot/dts/mpc8555cds.dts     |  190 +++++++-------
 arch/powerpc/boot/dts/mpc8560ads.dts     |  180 +++++++-------
 arch/powerpc/boot/dts/mpc8641_hpcn.dts   |  269 +++++++++++----------
 16 files changed, 1323 insertions(+), 1285 deletions(-)

diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index d8bcbb8..324e1bd 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -182,27 +182,6 @@
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
-		pci@0d00 {
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			compatible = "mpc5200-pci";
-			reg = <d00 100>;
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3
-			                 c000 0 0 2 &mpc5200_pic 0 0 3
-			                 c000 0 0 3 &mpc5200_pic 0 0 3
-			                 c000 0 0 4 &mpc5200_pic 0 0 3>;
-			clock-frequency = <0>; // From boot loader
-			interrupts = <2 8 0 2 9 0 2 a 0>;
-			interrupt-parent = <&mpc5200_pic>;
-			bus-range = <0 0>;
-			ranges = <42000000 0 80000000 80000000 0 20000000
-			          02000000 0 a0000000 a0000000 0 10000000
-			          01000000 0 00000000 b0000000 0 01000000>;
-		};
-
 		spi@f00 {
 			device_type = "spi";
 			compatible = "mpc5200-spi";
@@ -337,4 +316,25 @@
 			reg = <8000 4000>;
 		};
 	};
+
+	pci@f0000d00 {
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		compatible = "mpc5200-pci";
+		reg = <f0000d00 100>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3
+				 c000 0 0 2 &mpc5200_pic 0 0 3
+				 c000 0 0 3 &mpc5200_pic 0 0 3
+				 c000 0 0 4 &mpc5200_pic 0 0 3>;
+		clock-frequency = <0>; // From boot loader
+		interrupts = <2 8 0 2 9 0 2 a 0>;
+		interrupt-parent = <&mpc5200_pic>;
+		bus-range = <0 0>;
+		ranges = <42000000 0 80000000 80000000 0 20000000
+			  02000000 0 a0000000 a0000000 0 10000000
+			  01000000 0 00000000 b0000000 0 01000000>;
+	};
 };
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 5fe8998..3f74f73 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -182,32 +182,6 @@
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
-		pci@0d00 {
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			compatible = "mpc5200b-pci\0mpc5200-pci";
-			reg = <d00 100>;
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
-			                 c000 0 0 2 &mpc5200_pic 1 1 3
-			                 c000 0 0 3 &mpc5200_pic 1 2 3
-			                 c000 0 0 4 &mpc5200_pic 1 3 3
-
-			                 c800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
-			                 c800 0 0 2 &mpc5200_pic 1 2 3
-			                 c800 0 0 3 &mpc5200_pic 1 3 3
-			                 c800 0 0 4 &mpc5200_pic 0 0 3>;
-			clock-frequency = <0>; // From boot loader
-			interrupts = <2 8 0 2 9 0 2 a 0>;
-			interrupt-parent = <&mpc5200_pic>;
-			bus-range = <0 0>;
-			ranges = <42000000 0 80000000 80000000 0 20000000
-			          02000000 0 a0000000 a0000000 0 10000000
-			          01000000 0 00000000 b0000000 0 01000000>;
-		};
-
 		spi@f00 {
 			device_type = "spi";
 			compatible = "mpc5200b-spi\0mpc5200-spi";
@@ -342,4 +316,30 @@
 			reg = <8000 4000>;
 		};
 	};
+
+	pci@f0000d00 {
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		compatible = "mpc5200b-pci\0mpc5200-pci";
+		reg = <f0000d00 100>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
+				 c000 0 0 2 &mpc5200_pic 1 1 3
+				 c000 0 0 3 &mpc5200_pic 1 2 3
+				 c000 0 0 4 &mpc5200_pic 1 3 3
+
+				 c800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
+				 c800 0 0 2 &mpc5200_pic 1 2 3
+				 c800 0 0 3 &mpc5200_pic 1 3 3
+				 c800 0 0 4 &mpc5200_pic 0 0 3>;
+		clock-frequency = <0>; // From boot loader
+		interrupts = <2 8 0 2 9 0 2 a 0>;
+		interrupt-parent = <&mpc5200_pic>;
+		bus-range = <0 0>;
+		ranges = <42000000 0 80000000 80000000 0 20000000
+			  02000000 0 a0000000 a0000000 0 10000000
+			  01000000 0 00000000 b0000000 0 01000000>;
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index abd73a2..a8eadc8 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -150,36 +150,6 @@
 			interrupt-parent = < &ipic >;
 		};
 
-		pci@8500 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-
-					/* IDSEL 0x0E -mini PCI */
-					 7000 0 0 1 &ipic 12 8
-					 7000 0 0 2 &ipic 12 8
-					 7000 0 0 3 &ipic 12 8
-					 7000 0 0 4 &ipic 12 8
-
-					/* IDSEL 0x0F - PCI slot */
-					 7800 0 0 1 &ipic 11 8
-					 7800 0 0 2 &ipic 12 8
-					 7800 0 0 3 &ipic 11 8
-					 7800 0 0 4 &ipic 12 8>;
-			interrupt-parent = < &ipic >;
-			interrupts = <42 8>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 90000000 90000000 0 10000000
-			          42000000 0 80000000 80000000 0 10000000
-			          01000000 0 00000000 e2000000 0 00100000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8500 100>;
-			compatible = "fsl,mpc8349-pci";
-			device_type = "pci";
-		};
-
 		crypto@30000 {
 			device_type = "crypto";
 			model = "SEC2";
@@ -208,4 +178,34 @@
 			device_type = "ipic";
 		};
 	};
+
+	pci@e0008500 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+				/* IDSEL 0x0E -mini PCI */
+				 7000 0 0 1 &ipic 12 8
+				 7000 0 0 2 &ipic 12 8
+				 7000 0 0 3 &ipic 12 8
+				 7000 0 0 4 &ipic 12 8
+
+				/* IDSEL 0x0F - PCI slot */
+				 7800 0 0 1 &ipic 11 8
+				 7800 0 0 2 &ipic 12 8
+				 7800 0 0 3 &ipic 11 8
+				 7800 0 0 4 &ipic 12 8>;
+		interrupt-parent = < &ipic >;
+		interrupts = <42 8>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 90000000 90000000 0 10000000
+			  42000000 0 80000000 80000000 0 10000000
+			  01000000 0 00000000 e2000000 0 00100000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008500 100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index e88167d..fcd333c 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -97,65 +97,6 @@
 			descriptor-types-mask = <0122003f>;
 		};
 
-		pci@8500 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-					/* IDSEL 0x11 AD17 */
-					 8800 0 0 1 &ipic 14 8
-					 8800 0 0 2 &ipic 15 8
-					 8800 0 0 3 &ipic 16 8
-					 8800 0 0 4 &ipic 17 8
-
-					/* IDSEL 0x12 AD18 */
-					 9000 0 0 1 &ipic 16 8
-					 9000 0 0 2 &ipic 17 8
-					 9000 0 0 3 &ipic 14 8
-					 9000 0 0 4 &ipic 15 8
-
-					/* IDSEL 0x13 AD19 */
-					 9800 0 0 1 &ipic 17 8
-					 9800 0 0 2 &ipic 14 8
-					 9800 0 0 3 &ipic 15 8
-					 9800 0 0 4 &ipic 16 8
-
-					/* IDSEL 0x15 AD21*/
-					 a800 0 0 1 &ipic 14 8
-					 a800 0 0 2 &ipic 15 8
-					 a800 0 0 3 &ipic 16 8
-					 a800 0 0 4 &ipic 17 8
-
-					/* IDSEL 0x16 AD22*/
-					 b000 0 0 1 &ipic 17 8
-					 b000 0 0 2 &ipic 14 8
-					 b000 0 0 3 &ipic 15 8
-					 b000 0 0 4 &ipic 16 8
-
-					/* IDSEL 0x17 AD23*/
-					 b800 0 0 1 &ipic 16 8
-					 b800 0 0 2 &ipic 17 8
-					 b800 0 0 3 &ipic 14 8
-					 b800 0 0 4 &ipic 15 8
-
-					/* IDSEL 0x18 AD24*/
-					 c000 0 0 1 &ipic 15 8
-					 c000 0 0 2 &ipic 16 8
-					 c000 0 0 3 &ipic 17 8
-					 c000 0 0 4 &ipic 14 8>;
-			interrupt-parent = < &ipic >;
-			interrupts = <42 8>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 90000000 90000000 0 10000000
-			          42000000 0 80000000 80000000 0 10000000
-			          01000000 0 00000000 d0000000 0 00100000>;
-			clock-frequency = <0>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8500 100>;
-			compatible = "fsl,mpc8349-pci";
-			device_type = "pci";
-		};
-
 		ipic: pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
@@ -335,4 +276,63 @@
 			interrupt-parent = < &ipic >;
 		};
 	};
+
+	pci@e0008500 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+				/* IDSEL 0x11 AD17 */
+				 8800 0 0 1 &ipic 14 8
+				 8800 0 0 2 &ipic 15 8
+				 8800 0 0 3 &ipic 16 8
+				 8800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x12 AD18 */
+				 9000 0 0 1 &ipic 16 8
+				 9000 0 0 2 &ipic 17 8
+				 9000 0 0 3 &ipic 14 8
+				 9000 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x13 AD19 */
+				 9800 0 0 1 &ipic 17 8
+				 9800 0 0 2 &ipic 14 8
+				 9800 0 0 3 &ipic 15 8
+				 9800 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x15 AD21*/
+				 a800 0 0 1 &ipic 14 8
+				 a800 0 0 2 &ipic 15 8
+				 a800 0 0 3 &ipic 16 8
+				 a800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x16 AD22*/
+				 b000 0 0 1 &ipic 17 8
+				 b000 0 0 2 &ipic 14 8
+				 b000 0 0 3 &ipic 15 8
+				 b000 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x17 AD23*/
+				 b800 0 0 1 &ipic 16 8
+				 b800 0 0 2 &ipic 17 8
+				 b800 0 0 3 &ipic 14 8
+				 b800 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x18 AD24*/
+				 c000 0 0 1 &ipic 15 8
+				 c000 0 0 2 &ipic 16 8
+				 c000 0 0 3 &ipic 17 8
+				 c000 0 0 4 &ipic 14 8>;
+		interrupt-parent = < &ipic >;
+		interrupts = <42 8>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 90000000 90000000 0 10000000
+			  42000000 0 80000000 80000000 0 10000000
+			  01000000 0 00000000 d0000000 0 00100000>;
+		clock-frequency = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008500 100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 01393e6..cdc4a94 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -92,39 +92,6 @@
 			descriptor-types-mask = <0122003f>;
 		};
 
-		pci@8500 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-					/* IDSEL 0x10 AD16 (USB) */
-					 8000 0 0 1 &pic 11 8
-
-					/* IDSEL 0x11 AD17 (Mini1)*/
-					 8800 0 0 1 &pic 12 8
-					 8800 0 0 2 &pic 13 8
-					 8800 0 0 3 &pic 14 8
-					 8800 0 0 4 &pic 30 8
-
-					/* IDSEL 0x12 AD18 (PCI/Mini2) */
-					 9000 0 0 1 &pic 13 8
-					 9000 0 0 2 &pic 14 8
-					 9000 0 0 3 &pic 30 8
-					 9000 0 0 4 &pic 11 8>;
-
-			interrupt-parent = <&pic>;
-			interrupts = <42 8>;
-			bus-range = <0 0>;
-			ranges = <42000000 0 80000000 80000000 0 10000000
-			          02000000 0 90000000 90000000 0 10000000
-			          01000000 0 d0000000 d0000000 0 04000000>;
-			clock-frequency = <0>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8500 100>;
-			compatible = "fsl,mpc8349-pci";
-			device_type = "pci";
-		};
-
 		pic:pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
@@ -294,4 +261,37 @@
 			interrupt-parent = <&pic>;
 		};
 	};
+
+	pci@e0008500 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+				/* IDSEL 0x10 AD16 (USB) */
+				 8000 0 0 1 &pic 11 8
+
+				/* IDSEL 0x11 AD17 (Mini1)*/
+				 8800 0 0 1 &pic 12 8
+				 8800 0 0 2 &pic 13 8
+				 8800 0 0 3 &pic 14 8
+				 8800 0 0 4 &pic 30 8
+
+				/* IDSEL 0x12 AD18 (PCI/Mini2) */
+				 9000 0 0 1 &pic 13 8
+				 9000 0 0 2 &pic 14 8
+				 9000 0 0 3 &pic 30 8
+				 9000 0 0 4 &pic 11 8>;
+
+		interrupt-parent = <&pic>;
+		interrupts = <42 8>;
+		bus-range = <0 0>;
+		ranges = <42000000 0 80000000 80000000 0 10000000
+			  02000000 0 90000000 90000000 0 10000000
+			  01000000 0 d0000000 d0000000 0 04000000>;
+		clock-frequency = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008500 100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index f98c785..6778160 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -178,52 +178,6 @@
 			interrupt-parent = < &ipic >;
 		};
 
-		pci@8500 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-					/* IDSEL 0x10 - SATA */
-					8000 0 0 1 &ipic 16 8 /* SATA_INTA */
-					>;
-			interrupt-parent = < &ipic >;
-			interrupts = <42 8>;
-			bus-range = <0 0>;
-			ranges = <42000000 0 80000000 80000000 0 10000000
-				  02000000 0 90000000 90000000 0 10000000
-				  01000000 0 00000000 e2000000 0 01000000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8500 100>;
-			compatible = "fsl,mpc8349-pci";
-			device_type = "pci";
-		};
-
-		pci@8600 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-					/* IDSEL 0x0E - MiniPCI Slot */
-					7000 0 0 1 &ipic 15 8 /* PCI_INTA */
-
-					/* IDSEL 0x0F - PCI Slot */
-					7800 0 0 1 &ipic 14 8 /* PCI_INTA */
-					7800 0 0 2 &ipic 15 8 /* PCI_INTB */
-					 >;
-			interrupt-parent = < &ipic >;
-			interrupts = <43 8>;
-			bus-range = <1 1>;
-			ranges = <42000000 0 a0000000 a0000000 0 10000000
-				  02000000 0 b0000000 b0000000 0 10000000
-				  01000000 0 00000000 e3000000 0 01000000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8600 100>;
-			compatible = "fsl,mpc8349-pci";
-			device_type = "pci";
-		};
-
 		crypto@30000 {
 			device_type = "crypto";
 			model = "SEC2";
@@ -245,4 +199,53 @@
 			device_type = "ipic";
 		};
 	};
+
+	pci@e0008500 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+				/* IDSEL 0x10 - SATA */
+				8000 0 0 1 &ipic 16 8 /* SATA_INTA */
+				>;
+		interrupt-parent = < &ipic >;
+		interrupts = <42 8>;
+		bus-range = <0 0>;
+		ranges = <42000000 0 80000000 80000000 0 10000000
+			  02000000 0 90000000 90000000 0 10000000
+			  01000000 0 00000000 e2000000 0 01000000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008500 100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
+
+	pci@e0008600 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+				/* IDSEL 0x0E - MiniPCI Slot */
+				7000 0 0 1 &ipic 15 8 /* PCI_INTA */
+
+				/* IDSEL 0x0F - PCI Slot */
+				7800 0 0 1 &ipic 14 8 /* PCI_INTA */
+				7800 0 0 2 &ipic 15 8 /* PCI_INTB */
+				 >;
+		interrupt-parent = < &ipic >;
+		interrupts = <43 8>;
+		bus-range = <0 0>;
+		ranges = <42000000 0 a0000000 a0000000 0 10000000
+			  02000000 0 b0000000 b0000000 0 10000000
+			  01000000 0 00000000 e3000000 0 01000000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008600 100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
+
+
+
 };
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index 7c89ff7..fa852ba 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -134,28 +134,6 @@
 			interrupt-parent = < &ipic >;
 		};
 
-		pci@8600 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-					/* IDSEL 0x0F - PCI Slot */
-					7800 0 0 1 &ipic 14 8 /* PCI_INTA */
-					7800 0 0 2 &ipic 15 8 /* PCI_INTB */
-					 >;
-			interrupt-parent = < &ipic >;
-			interrupts = <43 8>;
-			bus-range = <1 1>;
-			ranges = <42000000 0 a0000000 a0000000 0 10000000
-				  02000000 0 b0000000 b0000000 0 10000000
-				  01000000 0 00000000 e3000000 0 01000000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8600 100>;
-			compatible = "fsl,mpc8349-pci";
-			device_type = "pci";
-		};
-
 		crypto@30000 {
 			device_type = "crypto";
 			model = "SEC2";
@@ -177,4 +155,26 @@
 			device_type = "ipic";
 		};
 	};
+
+	pci@e0008600 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+				/* IDSEL 0x0F - PCI Slot */
+				7800 0 0 1 &ipic 14 8 /* PCI_INTA */
+				7800 0 0 2 &ipic 15 8 /* PCI_INTB */
+				 >;
+		interrupt-parent = < &ipic >;
+		interrupts = <43 8>;
+		bus-range = <1 1>;
+		ranges = <42000000 0 a0000000 a0000000 0 10000000
+			  02000000 0 b0000000 b0000000 0 10000000
+			  01000000 0 00000000 e3000000 0 01000000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008600 100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index f4ba857..1b8882e 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -183,126 +183,6 @@
 			interrupt-parent = < &ipic >;
 		};
 
-		pci@8500 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-
-					/* IDSEL 0x11 */
-					 8800 0 0 1 &ipic 14 8
-					 8800 0 0 2 &ipic 15 8
-					 8800 0 0 3 &ipic 16 8
-					 8800 0 0 4 &ipic 17 8
-
-					/* IDSEL 0x12 */
-					 9000 0 0 1 &ipic 16 8
-					 9000 0 0 2 &ipic 17 8
-					 9000 0 0 3 &ipic 14 8
-					 9000 0 0 4 &ipic 15 8
-
-					/* IDSEL 0x13 */
-					 9800 0 0 1 &ipic 17 8
-					 9800 0 0 2 &ipic 14 8
-					 9800 0 0 3 &ipic 15 8
-					 9800 0 0 4 &ipic 16 8
-
-					/* IDSEL 0x15 */
-					 a800 0 0 1 &ipic 14 8
-					 a800 0 0 2 &ipic 15 8
-					 a800 0 0 3 &ipic 16 8
-					 a800 0 0 4 &ipic 17 8
-
-					/* IDSEL 0x16 */
-					 b000 0 0 1 &ipic 17 8
-					 b000 0 0 2 &ipic 14 8
-					 b000 0 0 3 &ipic 15 8
-					 b000 0 0 4 &ipic 16 8
-
-					/* IDSEL 0x17 */
-					 b800 0 0 1 &ipic 16 8
-					 b800 0 0 2 &ipic 17 8
-					 b800 0 0 3 &ipic 14 8
-					 b800 0 0 4 &ipic 15 8
-
-					/* IDSEL 0x18 */
-					 c000 0 0 1 &ipic 15 8
-					 c000 0 0 2 &ipic 16 8
-					 c000 0 0 3 &ipic 17 8
-					 c000 0 0 4 &ipic 14 8>;
-			interrupt-parent = < &ipic >;
-			interrupts = <42 8>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 90000000 90000000 0 10000000
-				  42000000 0 80000000 80000000 0 10000000
-				  01000000 0 00000000 e2000000 0 00100000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8500 100>;
-			compatible = "fsl,mpc8349-pci";
-			device_type = "pci";
-		};
-
-		pci@8600 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-
-					/* IDSEL 0x11 */
-					 8800 0 0 1 &ipic 14 8
-					 8800 0 0 2 &ipic 15 8
-					 8800 0 0 3 &ipic 16 8
-					 8800 0 0 4 &ipic 17 8
-
-					/* IDSEL 0x12 */
-					 9000 0 0 1 &ipic 16 8
-					 9000 0 0 2 &ipic 17 8
-					 9000 0 0 3 &ipic 14 8
-					 9000 0 0 4 &ipic 15 8
-
-					/* IDSEL 0x13 */
-					 9800 0 0 1 &ipic 17 8
-					 9800 0 0 2 &ipic 14 8
-					 9800 0 0 3 &ipic 15 8
-					 9800 0 0 4 &ipic 16 8
-
-					/* IDSEL 0x15 */
-					 a800 0 0 1 &ipic 14 8
-					 a800 0 0 2 &ipic 15 8
-					 a800 0 0 3 &ipic 16 8
-					 a800 0 0 4 &ipic 17 8
-
-					/* IDSEL 0x16 */
-					 b000 0 0 1 &ipic 17 8
-					 b000 0 0 2 &ipic 14 8
-					 b000 0 0 3 &ipic 15 8
-					 b000 0 0 4 &ipic 16 8
-
-					/* IDSEL 0x17 */
-					 b800 0 0 1 &ipic 16 8
-					 b800 0 0 2 &ipic 17 8
-					 b800 0 0 3 &ipic 14 8
-					 b800 0 0 4 &ipic 15 8
-
-					/* IDSEL 0x18 */
-					 c000 0 0 1 &ipic 15 8
-					 c000 0 0 2 &ipic 16 8
-					 c000 0 0 3 &ipic 17 8
-					 c000 0 0 4 &ipic 14 8>;
-			interrupt-parent = < &ipic >;
-			interrupts = <42 8>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 b0000000 b0000000 0 10000000
-				  42000000 0 a0000000 a0000000 0 10000000
-				  01000000 0 00000000 e2100000 0 00100000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8600 100>;
-			compatible = "fsl,mpc8349-pci";
-			device_type = "pci";
-		};
-
 		/* May need to remove if on a part without crypto engine */
 		crypto@30000 {
 			device_type = "crypto";
@@ -333,4 +213,124 @@
 			device_type = "ipic";
 		};
 	};
+
+	pci@e0008500 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+				/* IDSEL 0x11 */
+				 8800 0 0 1 &ipic 14 8
+				 8800 0 0 2 &ipic 15 8
+				 8800 0 0 3 &ipic 16 8
+				 8800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x12 */
+				 9000 0 0 1 &ipic 16 8
+				 9000 0 0 2 &ipic 17 8
+				 9000 0 0 3 &ipic 14 8
+				 9000 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x13 */
+				 9800 0 0 1 &ipic 17 8
+				 9800 0 0 2 &ipic 14 8
+				 9800 0 0 3 &ipic 15 8
+				 9800 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x15 */
+				 a800 0 0 1 &ipic 14 8
+				 a800 0 0 2 &ipic 15 8
+				 a800 0 0 3 &ipic 16 8
+				 a800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x16 */
+				 b000 0 0 1 &ipic 17 8
+				 b000 0 0 2 &ipic 14 8
+				 b000 0 0 3 &ipic 15 8
+				 b000 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x17 */
+				 b800 0 0 1 &ipic 16 8
+				 b800 0 0 2 &ipic 17 8
+				 b800 0 0 3 &ipic 14 8
+				 b800 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x18 */
+				 c000 0 0 1 &ipic 15 8
+				 c000 0 0 2 &ipic 16 8
+				 c000 0 0 3 &ipic 17 8
+				 c000 0 0 4 &ipic 14 8>;
+		interrupt-parent = < &ipic >;
+		interrupts = <42 8>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 90000000 90000000 0 10000000
+			  42000000 0 80000000 80000000 0 10000000
+			  01000000 0 00000000 e2000000 0 00100000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008500 100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
+
+	pci@e0008600 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+				/* IDSEL 0x11 */
+				 8800 0 0 1 &ipic 14 8
+				 8800 0 0 2 &ipic 15 8
+				 8800 0 0 3 &ipic 16 8
+				 8800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x12 */
+				 9000 0 0 1 &ipic 16 8
+				 9000 0 0 2 &ipic 17 8
+				 9000 0 0 3 &ipic 14 8
+				 9000 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x13 */
+				 9800 0 0 1 &ipic 17 8
+				 9800 0 0 2 &ipic 14 8
+				 9800 0 0 3 &ipic 15 8
+				 9800 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x15 */
+				 a800 0 0 1 &ipic 14 8
+				 a800 0 0 2 &ipic 15 8
+				 a800 0 0 3 &ipic 16 8
+				 a800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x16 */
+				 b000 0 0 1 &ipic 17 8
+				 b000 0 0 2 &ipic 14 8
+				 b000 0 0 3 &ipic 15 8
+				 b000 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x17 */
+				 b800 0 0 1 &ipic 16 8
+				 b800 0 0 2 &ipic 17 8
+				 b800 0 0 3 &ipic 14 8
+				 b800 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x18 */
+				 c000 0 0 1 &ipic 15 8
+				 c000 0 0 2 &ipic 16 8
+				 c000 0 0 3 &ipic 17 8
+				 c000 0 0 4 &ipic 14 8>;
+		interrupt-parent = < &ipic >;
+		interrupts = <42 8>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 b0000000 b0000000 0 10000000
+			  42000000 0 a0000000 a0000000 0 10000000
+			  01000000 0 00000000 e2100000 0 00100000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008600 100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index f14e88e..fbd1573 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -111,66 +111,6 @@
 			descriptor-types-mask = <01010ebf>;
 		};
 
-		pci@8500 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-
-					/* IDSEL 0x11 AD17 */
-					 8800 0 0 1 &ipic 14 8
-					 8800 0 0 2 &ipic 15 8
-					 8800 0 0 3 &ipic 16 8
-					 8800 0 0 4 &ipic 17 8
-
-					/* IDSEL 0x12 AD18 */
-					 9000 0 0 1 &ipic 16 8
-					 9000 0 0 2 &ipic 17 8
-					 9000 0 0 3 &ipic 14 8
-					 9000 0 0 4 &ipic 15 8
-
-					/* IDSEL 0x13 AD19 */
-					 9800 0 0 1 &ipic 17 8
-					 9800 0 0 2 &ipic 14 8
-					 9800 0 0 3 &ipic 15 8
-					 9800 0 0 4 &ipic 16 8
-
-					/* IDSEL 0x15 AD21*/
-					 a800 0 0 1 &ipic 14 8
-					 a800 0 0 2 &ipic 15 8
-					 a800 0 0 3 &ipic 16 8
-					 a800 0 0 4 &ipic 17 8
-
-					/* IDSEL 0x16 AD22*/
-					 b000 0 0 1 &ipic 17 8
-					 b000 0 0 2 &ipic 14 8
-					 b000 0 0 3 &ipic 15 8
-					 b000 0 0 4 &ipic 16 8
-
-					/* IDSEL 0x17 AD23*/
-					 b800 0 0 1 &ipic 16 8
-					 b800 0 0 2 &ipic 17 8
-					 b800 0 0 3 &ipic 14 8
-					 b800 0 0 4 &ipic 15 8
-
-					/* IDSEL 0x18 AD24*/
-					 c000 0 0 1 &ipic 15 8
-					 c000 0 0 2 &ipic 16 8
-					 c000 0 0 3 &ipic 17 8
-					 c000 0 0 4 &ipic 14 8>;
-			interrupt-parent = < &ipic >;
-			interrupts = <42 8>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 a0000000 a0000000 0 10000000
-				  42000000 0 80000000 80000000 0 10000000
-				  01000000 0 00000000 e2000000 0 00100000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8500 100>;
-			compatible = "fsl,mpc8349-pci";
-			device_type = "pci";
-		};
-
 		ipic: pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
@@ -365,6 +305,65 @@
 			interrupts = <20 8 21 8>; //high:32 low:33
 			interrupt-parent = < &ipic >;
 		};
+	};
 
+	pci@e0008500 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+				/* IDSEL 0x11 AD17 */
+				 8800 0 0 1 &ipic 14 8
+				 8800 0 0 2 &ipic 15 8
+				 8800 0 0 3 &ipic 16 8
+				 8800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x12 AD18 */
+				 9000 0 0 1 &ipic 16 8
+				 9000 0 0 2 &ipic 17 8
+				 9000 0 0 3 &ipic 14 8
+				 9000 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x13 AD19 */
+				 9800 0 0 1 &ipic 17 8
+				 9800 0 0 2 &ipic 14 8
+				 9800 0 0 3 &ipic 15 8
+				 9800 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x15 AD21*/
+				 a800 0 0 1 &ipic 14 8
+				 a800 0 0 2 &ipic 15 8
+				 a800 0 0 3 &ipic 16 8
+				 a800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x16 AD22*/
+				 b000 0 0 1 &ipic 17 8
+				 b000 0 0 2 &ipic 14 8
+				 b000 0 0 3 &ipic 15 8
+				 b000 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x17 AD23*/
+				 b800 0 0 1 &ipic 16 8
+				 b800 0 0 2 &ipic 17 8
+				 b800 0 0 3 &ipic 14 8
+				 b800 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x18 AD24*/
+				 c000 0 0 1 &ipic 15 8
+				 c000 0 0 2 &ipic 16 8
+				 c000 0 0 3 &ipic 17 8
+				 c000 0 0 4 &ipic 14 8>;
+		interrupt-parent = < &ipic >;
+		interrupts = <42 8>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 a0000000 a0000000 0 10000000
+			  42000000 0 80000000 80000000 0 10000000
+			  01000000 0 00000000 e2000000 0 00100000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008500 100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index e038c04..6442a71 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -171,104 +171,104 @@
 			interrupts = <2a 2>;
 			interrupt-parent = <&mpic>;
 		};
-		pci@8000 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+		};
+	};
 
-				/* IDSEL 0x02 */
-				1000 0 0 1 &mpic 1 1
-				1000 0 0 2 &mpic 2 1
-				1000 0 0 3 &mpic 3 1
-				1000 0 0 4 &mpic 4 1
+	pci@e0008000 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
 
-				/* IDSEL 0x03 */
-				1800 0 0 1 &mpic 4 1
-				1800 0 0 2 &mpic 1 1
-				1800 0 0 3 &mpic 2 1
-				1800 0 0 4 &mpic 3 1
+			/* IDSEL 0x02 */
+			1000 0 0 1 &mpic 1 1
+			1000 0 0 2 &mpic 2 1
+			1000 0 0 3 &mpic 3 1
+			1000 0 0 4 &mpic 4 1
 
-				/* IDSEL 0x04 */
-				2000 0 0 1 &mpic 3 1
-				2000 0 0 2 &mpic 4 1
-				2000 0 0 3 &mpic 1 1
-				2000 0 0 4 &mpic 2 1
+			/* IDSEL 0x03 */
+			1800 0 0 1 &mpic 4 1
+			1800 0 0 2 &mpic 1 1
+			1800 0 0 3 &mpic 2 1
+			1800 0 0 4 &mpic 3 1
 
-				/* IDSEL 0x05 */
-				2800 0 0 1 &mpic 2 1
-				2800 0 0 2 &mpic 3 1
-				2800 0 0 3 &mpic 4 1
-				2800 0 0 4 &mpic 1 1
+			/* IDSEL 0x04 */
+			2000 0 0 1 &mpic 3 1
+			2000 0 0 2 &mpic 4 1
+			2000 0 0 3 &mpic 1 1
+			2000 0 0 4 &mpic 2 1
 
-				/* IDSEL 0x0c */
-				6000 0 0 1 &mpic 1 1
-				6000 0 0 2 &mpic 2 1
-				6000 0 0 3 &mpic 3 1
-				6000 0 0 4 &mpic 4 1
+			/* IDSEL 0x05 */
+			2800 0 0 1 &mpic 2 1
+			2800 0 0 2 &mpic 3 1
+			2800 0 0 3 &mpic 4 1
+			2800 0 0 4 &mpic 1 1
 
-				/* IDSEL 0x0d */
-				6800 0 0 1 &mpic 4 1
-				6800 0 0 2 &mpic 1 1
-				6800 0 0 3 &mpic 2 1
-				6800 0 0 4 &mpic 3 1
+			/* IDSEL 0x0c */
+			6000 0 0 1 &mpic 1 1
+			6000 0 0 2 &mpic 2 1
+			6000 0 0 3 &mpic 3 1
+			6000 0 0 4 &mpic 4 1
 
-				/* IDSEL 0x0e */
-				7000 0 0 1 &mpic 3 1
-				7000 0 0 2 &mpic 4 1
-				7000 0 0 3 &mpic 1 1
-				7000 0 0 4 &mpic 2 1
+			/* IDSEL 0x0d */
+			6800 0 0 1 &mpic 4 1
+			6800 0 0 2 &mpic 1 1
+			6800 0 0 3 &mpic 2 1
+			6800 0 0 4 &mpic 3 1
 
-				/* IDSEL 0x0f */
-				7800 0 0 1 &mpic 2 1
-				7800 0 0 2 &mpic 3 1
-				7800 0 0 3 &mpic 4 1
-				7800 0 0 4 &mpic 1 1
+			/* IDSEL 0x0e */
+			7000 0 0 1 &mpic 3 1
+			7000 0 0 2 &mpic 4 1
+			7000 0 0 3 &mpic 1 1
+			7000 0 0 4 &mpic 2 1
 
-				/* IDSEL 0x12 */
-				9000 0 0 1 &mpic 1 1
-				9000 0 0 2 &mpic 2 1
-				9000 0 0 3 &mpic 3 1
-				9000 0 0 4 &mpic 4 1
+			/* IDSEL 0x0f */
+			7800 0 0 1 &mpic 2 1
+			7800 0 0 2 &mpic 3 1
+			7800 0 0 3 &mpic 4 1
+			7800 0 0 4 &mpic 1 1
 
-				/* IDSEL 0x13 */
-				9800 0 0 1 &mpic 4 1
-				9800 0 0 2 &mpic 1 1
-				9800 0 0 3 &mpic 2 1
-				9800 0 0 4 &mpic 3 1
+			/* IDSEL 0x12 */
+			9000 0 0 1 &mpic 1 1
+			9000 0 0 2 &mpic 2 1
+			9000 0 0 3 &mpic 3 1
+			9000 0 0 4 &mpic 4 1
 
-				/* IDSEL 0x14 */
-				a000 0 0 1 &mpic 3 1
-				a000 0 0 2 &mpic 4 1
-				a000 0 0 3 &mpic 1 1
-				a000 0 0 4 &mpic 2 1
+			/* IDSEL 0x13 */
+			9800 0 0 1 &mpic 4 1
+			9800 0 0 2 &mpic 1 1
+			9800 0 0 3 &mpic 2 1
+			9800 0 0 4 &mpic 3 1
 
-				/* IDSEL 0x15 */
-				a800 0 0 1 &mpic 2 1
-				a800 0 0 2 &mpic 3 1
-				a800 0 0 3 &mpic 4 1
-				a800 0 0 4 &mpic 1 1>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 80000000 80000000 0 20000000
-				  01000000 0 00000000 e2000000 0 00100000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8000 1000>;
-			compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
-			device_type = "pci";
-		};
+			/* IDSEL 0x14 */
+			a000 0 0 1 &mpic 3 1
+			a000 0 0 2 &mpic 4 1
+			a000 0 0 3 &mpic 1 1
+			a000 0 0 4 &mpic 2 1
 
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <40000 40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-			big-endian;
-		};
+			/* IDSEL 0x15 */
+			a800 0 0 1 &mpic 2 1
+			a800 0 0 2 &mpic 3 1
+			a800 0 0 3 &mpic 4 1
+			a800 0 0 4 &mpic 1 1>;
+		interrupt-parent = <&mpic>;
+		interrupts = <18 2>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 80000000 80000000 0 20000000
+			  01000000 0 00000000 e2000000 0 00100000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008000 1000>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 98afd4d..6633e07 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -43,7 +43,7 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00100000>;	// CCSRBAR 1M
+		reg = <e0000000 00001000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
 		memory-controller@2000 {
@@ -135,100 +135,6 @@
 			interrupt-parent = <&mpic>;
 		};
 
-		pci1: pci@8000 {
-			interrupt-map-mask = <1f800 0 0 7>;
-			interrupt-map = <
-
-				/* IDSEL 0x10 */
-				08000 0 0 1 &mpic 0 1
-				08000 0 0 2 &mpic 1 1
-				08000 0 0 3 &mpic 2 1
-				08000 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x11 */
-				08800 0 0 1 &mpic 0 1
-				08800 0 0 2 &mpic 1 1
-				08800 0 0 3 &mpic 2 1
-				08800 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x12 (Slot 1) */
-				09000 0 0 1 &mpic 0 1
-				09000 0 0 2 &mpic 1 1
-				09000 0 0 3 &mpic 2 1
-				09000 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x13 (Slot 2) */
-				09800 0 0 1 &mpic 1 1
-				09800 0 0 2 &mpic 2 1
-				09800 0 0 3 &mpic 3 1
-				09800 0 0 4 &mpic 0 1
-
-				/* IDSEL 0x14 (Slot 3) */
-				0a000 0 0 1 &mpic 2 1
-				0a000 0 0 2 &mpic 3 1
-				0a000 0 0 3 &mpic 0 1
-				0a000 0 0 4 &mpic 1 1
-
-				/* IDSEL 0x15 (Slot 4) */
-				0a800 0 0 1 &mpic 3 1
-				0a800 0 0 2 &mpic 0 1
-				0a800 0 0 3 &mpic 1 1
-				0a800 0 0 4 &mpic 2 1
-
-				/* Bus 1 (Tundra Bridge) */
-				/* IDSEL 0x12 (ISA bridge) */
-				19000 0 0 1 &mpic 0 1
-				19000 0 0 2 &mpic 1 1
-				19000 0 0 3 &mpic 2 1
-				19000 0 0 4 &mpic 3 1>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 80000000 80000000 0 20000000
-				  01000000 0 00000000 e2000000 0 00100000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8000 1000>;
-			compatible = "fsl,mpc8540-pci";
-			device_type = "pci";
-
-			i8259@19000 {
-				interrupt-controller;
-				device_type = "interrupt-controller";
-				reg = <19000 0 0 0 1>;
-				#address-cells = <0>;
-				#interrupt-cells = <2>;
-				compatible = "chrp,iic";
-				interrupts = <1>;
-				interrupt-parent = <&pci1>;
-			};
-		};
-
-		pci@9000 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-
-				/* IDSEL 0x15 */
-				a800 0 0 1 &mpic b 1
-				a800 0 0 2 &mpic b 1
-				a800 0 0 3 &mpic b 1
-				a800 0 0 4 &mpic b 1>;
-			interrupt-parent = <&mpic>;
-			interrupts = <19 2>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 a0000000 a0000000 0 20000000
-				  01000000 0 00000000 e3000000 0 00100000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <9000 1000>;
-			compatible = "fsl,mpc8540-pci";
-			device_type = "pci";
-		};
-
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
@@ -240,4 +146,98 @@
                         big-endian;
 		};
 	};
+
+	pci1: pci@e0008000 {
+		interrupt-map-mask = <1f800 0 0 7>;
+		interrupt-map = <
+
+			/* IDSEL 0x10 */
+			08000 0 0 1 &mpic 0 1
+			08000 0 0 2 &mpic 1 1
+			08000 0 0 3 &mpic 2 1
+			08000 0 0 4 &mpic 3 1
+
+			/* IDSEL 0x11 */
+			08800 0 0 1 &mpic 0 1
+			08800 0 0 2 &mpic 1 1
+			08800 0 0 3 &mpic 2 1
+			08800 0 0 4 &mpic 3 1
+
+			/* IDSEL 0x12 (Slot 1) */
+			09000 0 0 1 &mpic 0 1
+			09000 0 0 2 &mpic 1 1
+			09000 0 0 3 &mpic 2 1
+			09000 0 0 4 &mpic 3 1
+
+			/* IDSEL 0x13 (Slot 2) */
+			09800 0 0 1 &mpic 1 1
+			09800 0 0 2 &mpic 2 1
+			09800 0 0 3 &mpic 3 1
+			09800 0 0 4 &mpic 0 1
+
+			/* IDSEL 0x14 (Slot 3) */
+			0a000 0 0 1 &mpic 2 1
+			0a000 0 0 2 &mpic 3 1
+			0a000 0 0 3 &mpic 0 1
+			0a000 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x15 (Slot 4) */
+			0a800 0 0 1 &mpic 3 1
+			0a800 0 0 2 &mpic 0 1
+			0a800 0 0 3 &mpic 1 1
+			0a800 0 0 4 &mpic 2 1
+
+			/* Bus 1 (Tundra Bridge) */
+			/* IDSEL 0x12 (ISA bridge) */
+			19000 0 0 1 &mpic 0 1
+			19000 0 0 2 &mpic 1 1
+			19000 0 0 3 &mpic 2 1
+			19000 0 0 4 &mpic 3 1>;
+		interrupt-parent = <&mpic>;
+		interrupts = <18 2>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 80000000 80000000 0 20000000
+			  01000000 0 00000000 e2000000 0 00100000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008000 1000>;
+		compatible = "fsl,mpc8540-pci";
+		device_type = "pci";
+
+		i8259@19000 {
+			interrupt-controller;
+			device_type = "interrupt-controller";
+			reg = <19000 0 0 0 1>;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			compatible = "chrp,iic";
+			interrupts = <1>;
+			interrupt-parent = <&pci1>;
+		};
+	};
+
+	pci@e0009000 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+			/* IDSEL 0x15 */
+			a800 0 0 1 &mpic b 1
+			a800 0 0 2 &mpic b 1
+			a800 0 0 3 &mpic b 1
+			a800 0 0 4 &mpic b 1>;
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 a0000000 a0000000 0 20000000
+			  01000000 0 00000000 e3000000 0 00100000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0009000 1000>;
+		compatible = "fsl,mpc8540-pci";
+		device_type = "pci";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 88082ac..3f9d15c 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -43,16 +43,7 @@
 		#size-cells = <1>;
 		device_type = "soc";
 
-
-		ranges = <00001000 e0001000 000ff000
-			  80000000 80000000 20000000
-			  a0000000 a0000000 10000000
-			  b0000000 b0000000 00100000
-			  c0000000 c0000000 20000000
-			  b0100000 b0100000 00100000
-			  e1000000 e1000000 00010000
-			  e1010000 e1010000 00010000
-			  e1020000 e1020000 00010000>;
+		ranges = <00000000 e0000000 00100000>;
 		reg = <e0000000 00001000>;	// CCSRBAR 1M
 		bus-frequency = <0>;		// Filled out by uboot.
 
@@ -147,115 +138,173 @@
 			interrupt-parent = <&mpic>;
 		};
 
-		pci@8000 {
-			compatible = "fsl,mpc8540-pci";
-			device_type = "pci";
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-
-				/* IDSEL 0x11 J17 Slot 1 */
-				8800 0 0 1 &mpic 2 1
-				8800 0 0 2 &mpic 3 1
-				8800 0 0 3 &mpic 4 1
-				8800 0 0 4 &mpic 1 1
+		global-utilities@e0000 {	//global utilities block
+			compatible = "fsl,mpc8548-guts";
+			reg = <e0000 1000>;
+			fsl,has-rstcr;
+		};
 
-				/* IDSEL 0x12 J16 Slot 2 */
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+		};
+	};
 
-				9000 0 0 1 &mpic 3 1
-				9000 0 0 2 &mpic 4 1
-				9000 0 0 3 &mpic 2 1
-				9000 0 0 4 &mpic 1 1>;
+	pci@e0008000 {
+		compatible = "fsl,mpc8540-pci";
+		device_type = "pci";
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+			/* IDSEL 0x11 J17 Slot 1 */
+			8800 0 0 1 &mpic 2 1
+			8800 0 0 2 &mpic 3 1
+			8800 0 0 3 &mpic 4 1
+			8800 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x12 J16 Slot 2 */
+
+			9000 0 0 1 &mpic 3 1
+			9000 0 0 2 &mpic 4 1
+			9000 0 0 3 &mpic 2 1
+			9000 0 0 4 &mpic 1 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <18 2>;
+		bus-range = <0 ff>;
+		ranges = <02000000 0 c0000000 c0000000 0 20000000
+			  01000000 0 00000000 e1000000 0 00010000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008000 1000>;
+	};
 
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-			bus-range = <0 ff>;
-			ranges = <02000000 0 c0000000 c0000000 0 20000000
-				  01000000 0 00000000 e1000000 0 00010000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
+	pcie@e0009000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0009000 1000>;
+		bus-range = <0 ff>;
+		ranges = <02000000 0 80000000 80000000 0 20000000
+			  01000000 0 00000000 e1010000 0 00010000>;
+		clock-frequency = <1fca055>;
+		interrupt-parent = <&mpic>;
+		interrupts = <1a 2>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 4 1
+			0000 0 0 2 &mpic 5 1
+			0000 0 0 3 &mpic 6 1
+			0000 0 0 4 &mpic 7 1
+			>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			reg = <8000 1000>;
-		};
-
-		pcie@9000 {
-			compatible = "fsl,mpc8548-pcie";
 			device_type = "pci";
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <9000 1000>;
-			bus-range = <0 ff>;
-			ranges = <02000000 0 80000000 80000000 0 20000000
-				  01000000 0 00000000 e1010000 0 00010000>;
-			clock-frequency = <1fca055>;
-			interrupt-parent = <&mpic>;
-			interrupts = <1a 2>;
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 4 1
-				0000 0 0 2 &mpic 5 1
-				0000 0 0 3 &mpic 6 1
-				0000 0 0 4 &mpic 7 1
-				>;
+			ranges = <02000000 0 80000000
+				  02000000 0 80000000
+				  0 20000000
+
+				  01000000 0 00000000
+				  01000000 0 00000000
+				  0 00010000>;
 		};
+	};
 
-		pcie@a000 {
-			compatible = "fsl,mpc8548-pcie";
-			device_type = "pci";
-			#interrupt-cells = <1>;
+	pcie@e000a000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e000a000 1000>;
+		bus-range = <0 ff>;
+		ranges = <02000000 0 a0000000 a0000000 0 10000000
+			  01000000 0 00000000 e1020000 0 00010000>;
+		clock-frequency = <1fca055>;
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 0 1
+			0000 0 0 2 &mpic 1 1
+			0000 0 0 3 &mpic 2 1
+			0000 0 0 4 &mpic 3 1
+			>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			reg = <a000 1000>;
-			bus-range = <0 ff>;
-			ranges = <02000000 0 a0000000 a0000000 0 10000000
-				  01000000 0 00000000 e1020000 0 00010000>;
-			clock-frequency = <1fca055>;
-			interrupt-parent = <&mpic>;
-			interrupts = <19 2>;
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 0 1
-				0000 0 0 2 &mpic 1 1
-				0000 0 0 3 &mpic 2 1
-				0000 0 0 4 &mpic 3 1
-				>;
+			device_type = "pci";
+			ranges = <02000000 0 a0000000
+				  02000000 0 a0000000
+				  0 10000000
+
+				  01000000 0 00000000
+				  01000000 0 00000000
+				  0 00010000>;
 		};
+	};
 
-		pcie@b000 {
-			compatible = "fsl,mpc8548-pcie";
-			device_type = "pci";
-			#interrupt-cells = <1>;
+	pcie@e000b000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e000b000 1000>;
+		bus-range = <0 ff>;
+		ranges = <02000000 0 b0000000 b0000000 0 00100000
+			  01000000 0 00000000 b0100000 0 00100000>;
+		clock-frequency = <1fca055>;
+		interrupt-parent = <&mpic>;
+		interrupts = <1b 2>;
+		interrupt-map-mask = <fb00 0 0 0>;
+		interrupt-map = <
+			// IDSEL 0x1c  USB
+			e000 0 0 0 &i8259 c 2
+			e100 0 0 0 &i8259 9 2
+			e200 0 0 0 &i8259 a 2
+			e300 0 0 0 &i8259 b 2
+
+			// IDSEL 0x1d  Audio
+			e800 0 0 0 &i8259 6 2
+
+			// IDSEL 0x1e Legacy
+			f000 0 0 0 &i8259 7 2
+			f100 0 0 0 &i8259 7 2
+
+			// IDSEL 0x1f IDE/SATA
+			f800 0 0 0 &i8259 e 2
+			f900 0 0 0 &i8259 5 2
+		>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			reg = <b000 1000>;
-			bus-range = <0 ff>;
-			ranges = <02000000 0 b0000000 b0000000 0 00100000
-				  01000000 0 00000000 b0100000 0 00100000>;
-			clock-frequency = <1fca055>;
-			interrupt-parent = <&mpic>;
-			interrupts = <1b 2>;
-			interrupt-map-mask = <fb00 0 0 0>;
-			interrupt-map = <
-				// IDSEL 0x1c  USB
-				e000 0 0 0 &i8259 c 2
-				e100 0 0 0 &i8259 9 2
-				e200 0 0 0 &i8259 a 2
-				e300 0 0 0 &i8259 b 2
-
-				// IDSEL 0x1d  Audio
-				e800 0 0 0 &i8259 6 2
-
-				// IDSEL 0x1e Legacy
-				f000 0 0 0 &i8259 7 2
-				f100 0 0 0 &i8259 7 2
-
-				// IDSEL 0x1f IDE/SATA
-				f800 0 0 0 &i8259 e 2
-				f900 0 0 0 &i8259 5 2
-			>;
+			device_type = "pci";
+			ranges = <02000000 0 b0000000
+				  02000000 0 b0000000
+				  0 00100000
+
+				  01000000 0 00000000
+				  01000000 0 00000000
+				  0 00100000>;
+
 			uli1575@0 {
 				reg = <0 0 0 0 0>;
 				#size-cells = <2>;
@@ -263,92 +312,63 @@
 				ranges = <02000000 0 b0000000
 					  02000000 0 b0000000
 					  0 00100000
+
 					  01000000 0 00000000
 					  01000000 0 00000000
 					  0 00100000>;
-
-				pci_bridge@0 {
-					reg = <0 0 0 0 0>;
-					#size-cells = <2>;
-					#address-cells = <3>;
-					ranges = <02000000 0 b0000000
-						  02000000 0 b0000000
-						  0 00100000
-						  01000000 0 00000000
-						  01000000 0 00000000
-						  0 00100000>; 
-
-					isa@1e {
-						device_type = "isa";
+				isa@1e {
+					device_type = "isa";
+					#interrupt-cells = <2>;
+					#size-cells = <1>;
+					#address-cells = <2>;
+					reg = <f000 0 0 0 0>;
+					ranges = <1 0
+						  01000000 0 0
+						  00001000>;
+					interrupt-parent = <&i8259>;
+
+					i8259: interrupt-controller@20 {
+						reg = <1 20 2
+						       1 a0 2
+						       1 4d0 2>;
+						interrupt-controller;
+						device_type = "interrupt-controller";
+						#address-cells = <0>;
 						#interrupt-cells = <2>;
-						#size-cells = <1>;
-						#address-cells = <2>;
-						reg = <f000 0 0 0 0>;
-						ranges = <1 0
-							  01000000 0 0
-							  00001000>;
+						compatible = "chrp,iic";
+						interrupts = <9 2>;
+						interrupt-parent = <&mpic>;
+					};
+
+					i8042@60 {
+						#size-cells = <0>;
+						#address-cells = <1>;
+						reg = <1 60 1 1 64 1>;
+						interrupts = <1 3 c 3>;
 						interrupt-parent = <&i8259>;
 
-						i8259: interrupt-controller@20 {
-							reg = <1 20 2
-							       1 a0 2
-							       1 4d0 2>;
-							interrupt-controller;
-							device_type = "interrupt-controller";
-							#address-cells = <0>;
-							#interrupt-cells = <2>;
-							compatible = "chrp,iic";
-							interrupts = <9 2>;
-							interrupt-parent = <&mpic>;
+						keyboard@0 {
+							reg = <0>;
+							compatible = "pnpPNP,303";
 						};
 
-						i8042@60 {
-							#size-cells = <0>;
-							#address-cells = <1>;
-							reg = <1 60 1 1 64 1>;
-							interrupts = <1 3 c 3>;
-							interrupt-parent = <&i8259>;
-
-							keyboard@0 {
-								reg = <0>;
-								compatible = "pnpPNP,303";
-							};
-
-							mouse@1 {
-								reg = <1>;
-								compatible = "pnpPNP,f03";
-							};
+						mouse@1 {
+							reg = <1>;
+							compatible = "pnpPNP,f03";
 						};
+					};
 
-						rtc@70 {
-							compatible = "pnpPNP,b00";
-							reg = <1 70 2>;
-						};
+					rtc@70 {
+						compatible = "pnpPNP,b00";
+						reg = <1 70 2>;
+					};
 
-						gpio@400 {
-							reg = <1 400 80>;
-						};
+					gpio@400 {
+						reg = <1 400 80>;
 					};
 				};
 			};
-
 		};
 
-		global-utilities@e0000 {	//global utilities block
-			compatible = "fsl,mpc8548-guts";
-			reg = <e0000 1000>;
-			fsl,has-rstcr;
-		};
-
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <40000 40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-			big-endian;
-		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 11b8235..69ca502 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -42,13 +42,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <00001000 e0001000 000ff000
-			  80000000 80000000 10000000
-			  e2000000 e2000000 00800000
-			  90000000 90000000 10000000
-			  e2800000 e2800000 00800000
-			  a0000000 a0000000 20000000
-		          e3000000 e3000000 01000000>;
+		ranges = <00000000 e0000000 00100000>;
 		reg = <e0000000 00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
@@ -187,212 +181,225 @@
 			fsl,has-rstcr;
 		};
 
-		pci@8000 {
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+                        big-endian;
+		};
+	};
+
+	pci@e0008000 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x4 (PCIX Slot 2) */
+			02000 0 0 1 &mpic 0 1
+			02000 0 0 2 &mpic 1 1
+			02000 0 0 3 &mpic 2 1
+			02000 0 0 4 &mpic 3 1
+
+			/* IDSEL 0x5 (PCIX Slot 3) */
+			02800 0 0 1 &mpic 1 1
+			02800 0 0 2 &mpic 2 1
+			02800 0 0 3 &mpic 3 1
+			02800 0 0 4 &mpic 0 1
+
+			/* IDSEL 0x6 (PCIX Slot 4) */
+			03000 0 0 1 &mpic 2 1
+			03000 0 0 2 &mpic 3 1
+			03000 0 0 3 &mpic 0 1
+			03000 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x8 (PCIX Slot 5) */
+			04000 0 0 1 &mpic 0 1
+			04000 0 0 2 &mpic 1 1
+			04000 0 0 3 &mpic 2 1
+			04000 0 0 4 &mpic 3 1
+
+			/* IDSEL 0xC (Tsi310 bridge) */
+			06000 0 0 1 &mpic 0 1
+			06000 0 0 2 &mpic 1 1
+			06000 0 0 3 &mpic 2 1
+			06000 0 0 4 &mpic 3 1
+
+			/* IDSEL 0x14 (Slot 2) */
+			0a000 0 0 1 &mpic 0 1
+			0a000 0 0 2 &mpic 1 1
+			0a000 0 0 3 &mpic 2 1
+			0a000 0 0 4 &mpic 3 1
+
+			/* IDSEL 0x15 (Slot 3) */
+			0a800 0 0 1 &mpic 1 1
+			0a800 0 0 2 &mpic 2 1
+			0a800 0 0 3 &mpic 3 1
+			0a800 0 0 4 &mpic 0 1
+
+			/* IDSEL 0x16 (Slot 4) */
+			0b000 0 0 1 &mpic 2 1
+			0b000 0 0 2 &mpic 3 1
+			0b000 0 0 3 &mpic 0 1
+			0b000 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x18 (Slot 5) */
+			0c000 0 0 1 &mpic 0 1
+			0c000 0 0 2 &mpic 1 1
+			0c000 0 0 3 &mpic 2 1
+			0c000 0 0 4 &mpic 3 1
+
+			/* IDSEL 0x1C (Tsi310 bridge PCI primary) */
+			0E000 0 0 1 &mpic 0 1
+			0E000 0 0 2 &mpic 1 1
+			0E000 0 0 3 &mpic 2 1
+			0E000 0 0 4 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <18 2>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 80000000 80000000 0 10000000
+			  01000000 0 00000000 e2000000 0 00800000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008000 1000>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+
+		pci_bridge@1c {
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
-				/* IDSEL 0x4 (PCIX Slot 2) */
-				02000 0 0 1 &mpic 0 1
-				02000 0 0 2 &mpic 1 1
-				02000 0 0 3 &mpic 2 1
-				02000 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x5 (PCIX Slot 3) */
-				02800 0 0 1 &mpic 1 1
-				02800 0 0 2 &mpic 2 1
-				02800 0 0 3 &mpic 3 1
-				02800 0 0 4 &mpic 0 1
-
-				/* IDSEL 0x6 (PCIX Slot 4) */
-				03000 0 0 1 &mpic 2 1
-				03000 0 0 2 &mpic 3 1
-				03000 0 0 3 &mpic 0 1
-				03000 0 0 4 &mpic 1 1
-
-				/* IDSEL 0x8 (PCIX Slot 5) */
-				04000 0 0 1 &mpic 0 1
-				04000 0 0 2 &mpic 1 1
-				04000 0 0 3 &mpic 2 1
-				04000 0 0 4 &mpic 3 1
-
-				/* IDSEL 0xC (Tsi310 bridge) */
-				06000 0 0 1 &mpic 0 1
-				06000 0 0 2 &mpic 1 1
-				06000 0 0 3 &mpic 2 1
-				06000 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x14 (Slot 2) */
-				0a000 0 0 1 &mpic 0 1
-				0a000 0 0 2 &mpic 1 1
-				0a000 0 0 3 &mpic 2 1
-				0a000 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x15 (Slot 3) */
-				0a800 0 0 1 &mpic 1 1
-				0a800 0 0 2 &mpic 2 1
-				0a800 0 0 3 &mpic 3 1
-				0a800 0 0 4 &mpic 0 1
-
-				/* IDSEL 0x16 (Slot 4) */
-				0b000 0 0 1 &mpic 2 1
-				0b000 0 0 2 &mpic 3 1
-				0b000 0 0 3 &mpic 0 1
-				0b000 0 0 4 &mpic 1 1
-
-				/* IDSEL 0x18 (Slot 5) */
-				0c000 0 0 1 &mpic 0 1
-				0c000 0 0 2 &mpic 1 1
-				0c000 0 0 3 &mpic 2 1
-				0c000 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x1C (Tsi310 bridge PCI primary) */
-				0E000 0 0 1 &mpic 0 1
-				0E000 0 0 2 &mpic 1 1
-				0E000 0 0 3 &mpic 2 1
-				0E000 0 0 4 &mpic 3 1>;
 
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 80000000 80000000 0 10000000
-				  01000000 0 00000000 e2000000 0 00800000>;
-			clock-frequency = <3f940aa>;
+				/* IDSEL 0x00 (PrPMC Site) */
+				0000 0 0 1 &mpic 0 1
+				0000 0 0 2 &mpic 1 1
+				0000 0 0 3 &mpic 2 1
+				0000 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x04 (VIA chip) */
+				2000 0 0 1 &mpic 0 1
+				2000 0 0 2 &mpic 1 1
+				2000 0 0 3 &mpic 2 1
+				2000 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x05 (8139) */
+				2800 0 0 1 &mpic 1 1
+
+				/* IDSEL 0x06 (Slot 6) */
+				3000 0 0 1 &mpic 2 1
+				3000 0 0 2 &mpic 3 1
+				3000 0 0 3 &mpic 0 1
+				3000 0 0 4 &mpic 1 1
+
+				/* IDESL 0x07 (Slot 7) */
+				3800 0 0 1 &mpic 3 1
+				3800 0 0 2 &mpic 0 1
+				3800 0 0 3 &mpic 1 1
+				3800 0 0 4 &mpic 2 1>;
+
+			reg = <e000 0 0 0 0>;
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			reg = <8000 1000>;
-			compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
-			device_type = "pci";
+			ranges = <02000000 0 80000000
+				  02000000 0 80000000
+				  0 20000000
+				  01000000 0 00000000
+				  01000000 0 00000000
+				  0 00080000>;
+			clock-frequency = <1fca055>;
 
-			pci_bridge@1c {
-				interrupt-map-mask = <f800 0 0 7>;
-				interrupt-map = <
-
-					/* IDSEL 0x00 (PrPMC Site) */
-					0000 0 0 1 &mpic 0 1
-					0000 0 0 2 &mpic 1 1
-					0000 0 0 3 &mpic 2 1
-					0000 0 0 4 &mpic 3 1
-
-					/* IDSEL 0x04 (VIA chip) */
-					2000 0 0 1 &mpic 0 1
-					2000 0 0 2 &mpic 1 1
-					2000 0 0 3 &mpic 2 1
-					2000 0 0 4 &mpic 3 1
-
-					/* IDSEL 0x05 (8139) */
-					2800 0 0 1 &mpic 1 1
-
-					/* IDSEL 0x06 (Slot 6) */
-					3000 0 0 1 &mpic 2 1
-					3000 0 0 2 &mpic 3 1
-					3000 0 0 3 &mpic 0 1
-					3000 0 0 4 &mpic 1 1
-
-					/* IDESL 0x07 (Slot 7) */
-					3800 0 0 1 &mpic 3 1
-					3800 0 0 2 &mpic 0 1
-					3800 0 0 3 &mpic 1 1
-					3800 0 0 4 &mpic 2 1>;
-
-				reg = <e000 0 0 0 0>;
-				#interrupt-cells = <1>;
-				#size-cells = <2>;
-				#address-cells = <3>;
-				ranges = <02000000 0 80000000
-					  02000000 0 80000000
-					  0 20000000
-					  01000000 0 00000000
-					  01000000 0 00000000
-					  0 00080000>;
-				clock-frequency = <1fca055>;
-
-				isa@4 {
-					device_type = "isa";
+			isa@4 {
+				device_type = "isa";
+				#interrupt-cells = <2>;
+				#size-cells = <1>;
+				#address-cells = <2>;
+				reg = <2000 0 0 0 0>;
+				ranges = <1 0 01000000 0 0 00001000>;
+				interrupt-parent = <&i8259>;
+
+				i8259: interrupt-controller@20 {
+					interrupt-controller;
+					device_type = "interrupt-controller";
+					reg = <1 20 2
+					       1 a0 2
+					       1 4d0 2>;
+					#address-cells = <0>;
 					#interrupt-cells = <2>;
-					#size-cells = <1>;
-					#address-cells = <2>;
-					reg = <2000 0 0 0 0>;
-					ranges = <1 0 01000000 0 0 00001000>;
-					interrupt-parent = <&i8259>;
-
-					i8259: interrupt-controller@20 {
-						interrupt-controller;
-						device_type = "interrupt-controller";
-						reg = <1 20 2
-						       1 a0 2
-						       1 4d0 2>;
-						#address-cells = <0>;
-						#interrupt-cells = <2>;
-						compatible = "chrp,iic";
-						interrupts = <0 1>;
-						interrupt-parent = <&mpic>;
-					};
-
-					rtc@70 {
-						compatible = "pnpPNP,b00";
-						reg = <1 70 2>;
-					};
+					compatible = "chrp,iic";
+					interrupts = <0 1>;
+					interrupt-parent = <&mpic>;
 				};
-			};
-		};
 
-		pci@9000 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-
-				/* IDSEL 0x15 */
-				a800 0 0 1 &mpic b 1
-				a800 0 0 2 &mpic 1 1
-				a800 0 0 3 &mpic 2 1
-				a800 0 0 4 &mpic 3 1>;
-
-			interrupt-parent = <&mpic>;
-			interrupts = <19 2>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 90000000 90000000 0 10000000
-				  01000000 0 00000000 e2800000 0 00800000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <9000 1000>;
-			compatible = "fsl,mpc8540-pci";
-			device_type = "pci";
+				rtc@70 {
+					compatible = "pnpPNP,b00";
+					reg = <1 70 2>;
+				};
+			};
 		};
-		/* PCI Express */
-		pcie@a000 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
+	};
 
-				/* IDSEL 0x0 (PEX) */
-				00000 0 0 1 &mpic 0 1
-				00000 0 0 2 &mpic 1 1
-				00000 0 0 3 &mpic 2 1
-				00000 0 0 4 &mpic 3 1>;
+	pci@e0009000 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+			/* IDSEL 0x15 */
+			a800 0 0 1 &mpic b 1
+			a800 0 0 2 &mpic 1 1
+			a800 0 0 3 &mpic 2 1
+			a800 0 0 4 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 90000000 90000000 0 10000000
+			  01000000 0 00000000 e2800000 0 00800000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0009000 1000>;
+		compatible = "fsl,mpc8540-pci";
+		device_type = "pci";
+	};
 
-			interrupt-parent = <&mpic>;
-			interrupts = <1a 2>;
-			bus-range = <0 ff>;
-			ranges = <02000000 0 a0000000 a0000000 0 20000000
-				  01000000 0 00000000 e3000000 0 08000000>;
-			clock-frequency = <1fca055>;
-			#interrupt-cells = <1>;
+	pcie@e000a000 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+			/* IDSEL 0x0 (PEX) */
+			00000 0 0 1 &mpic 0 1
+			00000 0 0 2 &mpic 1 1
+			00000 0 0 3 &mpic 2 1
+			00000 0 0 4 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <1a 2>;
+		bus-range = <0 ff>;
+		ranges = <02000000 0 a0000000 a0000000 0 20000000
+			  01000000 0 00000000 e3000000 0 08000000>;
+		clock-frequency = <1fca055>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e000a000 1000>;
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		pcie@0 {
+			reg = <0 0 0 0 0>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			reg = <a000 1000>;
-			compatible = "fsl,mpc8548-pcie";
 			device_type = "pci";
-		};
+			ranges = <02000000 0 a0000000
+				  02000000 0 a0000000
+				  0 20000000
 
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <40000 40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-                        big-endian;
+				  01000000 0 00000000
+				  01000000 0 00000000
+				  0 08000000>;
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index ce11d11..9919929 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -43,7 +43,7 @@
 		#size-cells = <1>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00100000>;	// CCSRBAR 1M
+		reg = <e0000000 00001000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
 		memory-controller@2000 {
@@ -135,100 +135,6 @@
 			interrupt-parent = <&mpic>;
 		};
 
-		pci1: pci@8000 {
-			interrupt-map-mask = <1f800 0 0 7>;
-			interrupt-map = <
-
-				/* IDSEL 0x10 */
-				08000 0 0 1 &mpic 0 1
-				08000 0 0 2 &mpic 1 1
-				08000 0 0 3 &mpic 2 1
-				08000 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x11 */
-				08800 0 0 1 &mpic 0 1
-				08800 0 0 2 &mpic 1 1
-				08800 0 0 3 &mpic 2 1
-				08800 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x12 (Slot 1) */
-				09000 0 0 1 &mpic 0 1
-				09000 0 0 2 &mpic 1 1
-				09000 0 0 3 &mpic 2 1
-				09000 0 0 4 &mpic 3 1
-
-				/* IDSEL 0x13 (Slot 2) */
-				09800 0 0 1 &mpic 1 1
-				09800 0 0 2 &mpic 2 1
-				09800 0 0 3 &mpic 3 1
-				09800 0 0 4 &mpic 0 1
-
-				/* IDSEL 0x14 (Slot 3) */
-				0a000 0 0 1 &mpic 2 1
-				0a000 0 0 2 &mpic 3 1
-				0a000 0 0 3 &mpic 0 1
-				0a000 0 0 4 &mpic 1 1
-
-				/* IDSEL 0x15 (Slot 4) */
-				0a800 0 0 1 &mpic 3 1
-				0a800 0 0 2 &mpic 0 1
-				0a800 0 0 3 &mpic 1 1
-				0a800 0 0 4 &mpic 2 1
-
-				/* Bus 1 (Tundra Bridge) */
-				/* IDSEL 0x12 (ISA bridge) */
-				19000 0 0 1 &mpic 0 1
-				19000 0 0 2 &mpic 1 1
-				19000 0 0 3 &mpic 2 1
-				19000 0 0 4 &mpic 3 1>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 80000000 80000000 0 20000000
-				  01000000 0 00000000 e2000000 0 00100000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8000 1000>;
-			compatible = "fsl,mpc8540-pci";
-			device_type = "pci";
-
-			i8259@19000 {
-				interrupt-controller;
-				device_type = "interrupt-controller";
-				reg = <19000 0 0 0 1>;
-				#address-cells = <0>;
-				#interrupt-cells = <2>;
-				compatible = "chrp,iic";
-				interrupts = <1>;
-				interrupt-parent = <&pci1>;
-			};
-		};
-
-		pci@9000 {
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-
-				/* IDSEL 0x15 */
-				a800 0 0 1 &mpic b 1
-				a800 0 0 2 &mpic b 1
-				a800 0 0 3 &mpic b 1
-				a800 0 0 4 &mpic b 1>;
-			interrupt-parent = <&mpic>;
-			interrupts = <19 2>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 a0000000 a0000000 0 20000000
-				  01000000 0 00000000 e3000000 0 00100000>;
-			clock-frequency = <3f940aa>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <9000 1000>;
-			compatible = "fsl,mpc8540-pci";
-			device_type = "pci";
-		};
-
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
@@ -240,4 +146,98 @@
                         big-endian;
 		};
 	};
+
+	pci1: pci@e0008000 {
+		interrupt-map-mask = <1f800 0 0 7>;
+		interrupt-map = <
+
+			/* IDSEL 0x10 */
+			08000 0 0 1 &mpic 0 1
+			08000 0 0 2 &mpic 1 1
+			08000 0 0 3 &mpic 2 1
+			08000 0 0 4 &mpic 3 1
+
+			/* IDSEL 0x11 */
+			08800 0 0 1 &mpic 0 1
+			08800 0 0 2 &mpic 1 1
+			08800 0 0 3 &mpic 2 1
+			08800 0 0 4 &mpic 3 1
+
+			/* IDSEL 0x12 (Slot 1) */
+			09000 0 0 1 &mpic 0 1
+			09000 0 0 2 &mpic 1 1
+			09000 0 0 3 &mpic 2 1
+			09000 0 0 4 &mpic 3 1
+
+			/* IDSEL 0x13 (Slot 2) */
+			09800 0 0 1 &mpic 1 1
+			09800 0 0 2 &mpic 2 1
+			09800 0 0 3 &mpic 3 1
+			09800 0 0 4 &mpic 0 1
+
+			/* IDSEL 0x14 (Slot 3) */
+			0a000 0 0 1 &mpic 2 1
+			0a000 0 0 2 &mpic 3 1
+			0a000 0 0 3 &mpic 0 1
+			0a000 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x15 (Slot 4) */
+			0a800 0 0 1 &mpic 3 1
+			0a800 0 0 2 &mpic 0 1
+			0a800 0 0 3 &mpic 1 1
+			0a800 0 0 4 &mpic 2 1
+
+			/* Bus 1 (Tundra Bridge) */
+			/* IDSEL 0x12 (ISA bridge) */
+			19000 0 0 1 &mpic 0 1
+			19000 0 0 2 &mpic 1 1
+			19000 0 0 3 &mpic 2 1
+			19000 0 0 4 &mpic 3 1>;
+		interrupt-parent = <&mpic>;
+		interrupts = <18 2>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 80000000 80000000 0 20000000
+			  01000000 0 00000000 e2000000 0 00100000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008000 1000>;
+		compatible = "fsl,mpc8540-pci";
+		device_type = "pci";
+
+		i8259@19000 {
+			interrupt-controller;
+			device_type = "interrupt-controller";
+			reg = <19000 0 0 0 1>;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			compatible = "chrp,iic";
+			interrupts = <1>;
+			interrupt-parent = <&pci1>;
+		};
+	};
+
+	pci@e0009000 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+			/* IDSEL 0x15 */
+			a800 0 0 1 &mpic b 1
+			a800 0 0 2 &mpic b 1
+			a800 0 0 3 &mpic b 1
+			a800 0 0 4 &mpic b 1>;
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 a0000000 a0000000 0 20000000
+			  01000000 0 00000000 e3000000 0 00100000>;
+		clock-frequency = <3f940aa>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0009000 1000>;
+		compatible = "fsl,mpc8540-pci";
+		device_type = "pci";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index cf87c30..5577ec1 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -130,96 +130,6 @@
 			phy-handle = <&phy1>;
 		};
 
-		pci@8000 {
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
-			device_type = "pci";
-			reg = <8000 1000>;
-			clock-frequency = <3f940aa>;
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-
-					/* IDSEL 0x2 */
-					 1000 0 0 1 &mpic 1 1
-					 1000 0 0 2 &mpic 2 1
-					 1000 0 0 3 &mpic 3 1
-					 1000 0 0 4 &mpic 4 1
-
-					/* IDSEL 0x3 */
-					 1800 0 0 1 &mpic 4 1
-					 1800 0 0 2 &mpic 1 1
-					 1800 0 0 3 &mpic 2 1
-					 1800 0 0 4 &mpic 3 1
-
-					/* IDSEL 0x4 */
-					 2000 0 0 1 &mpic 3 1
-					 2000 0 0 2 &mpic 4 1
-					 2000 0 0 3 &mpic 1 1
-					 2000 0 0 4 &mpic 2 1
-
-					/* IDSEL 0x5  */
-					 2800 0 0 1 &mpic 2 1
-					 2800 0 0 2 &mpic 3 1
-					 2800 0 0 3 &mpic 4 1
-					 2800 0 0 4 &mpic 1 1
-
-					/* IDSEL 12 */
-					 6000 0 0 1 &mpic 1 1
-					 6000 0 0 2 &mpic 2 1
-					 6000 0 0 3 &mpic 3 1
-					 6000 0 0 4 &mpic 4 1
-
-					/* IDSEL 13 */
-					 6800 0 0 1 &mpic 4 1
-					 6800 0 0 2 &mpic 1 1
-					 6800 0 0 3 &mpic 2 1
-					 6800 0 0 4 &mpic 3 1
-
-					/* IDSEL 14*/
-					 7000 0 0 1 &mpic 3 1
-					 7000 0 0 2 &mpic 4 1
-					 7000 0 0 3 &mpic 1 1
-					 7000 0 0 4 &mpic 2 1
-
-					/* IDSEL 15 */
-					 7800 0 0 1 &mpic 2 1
-					 7800 0 0 2 &mpic 3 1
-					 7800 0 0 3 &mpic 4 1
-					 7800 0 0 4 &mpic 1 1
-
-					/* IDSEL 18 */
-					 9000 0 0 1 &mpic 1 1
-					 9000 0 0 2 &mpic 2 1
-					 9000 0 0 3 &mpic 3 1
-					 9000 0 0 4 &mpic 4 1
-
-					/* IDSEL 19 */
-					 9800 0 0 1 &mpic 4 1
-					 9800 0 0 2 &mpic 1 1
-					 9800 0 0 3 &mpic 2 1
-					 9800 0 0 4 &mpic 3 1
-
-					/* IDSEL 20 */
-					 a000 0 0 1 &mpic 3 1
-					 a000 0 0 2 &mpic 4 1
-					 a000 0 0 3 &mpic 1 1
-					 a000 0 0 4 &mpic 2 1
-
-					/* IDSEL 21 */
-					 a800 0 0 1 &mpic 2 1
-					 a800 0 0 2 &mpic 3 1
-					 a800 0 0 3 &mpic 4 1
-					 a800 0 0 4 &mpic 1 1>;
-
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 80000000 80000000 0 20000000
-				  01000000 0 00000000 e2000000 0 01000000>;
-		};
-
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
@@ -319,4 +229,94 @@
 			};
 		};
 	};
+
+	pci@e0008000 {
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+		reg = <e0008000 1000>;
+		clock-frequency = <3f940aa>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+				/* IDSEL 0x2 */
+				 1000 0 0 1 &mpic 1 1
+				 1000 0 0 2 &mpic 2 1
+				 1000 0 0 3 &mpic 3 1
+				 1000 0 0 4 &mpic 4 1
+
+				/* IDSEL 0x3 */
+				 1800 0 0 1 &mpic 4 1
+				 1800 0 0 2 &mpic 1 1
+				 1800 0 0 3 &mpic 2 1
+				 1800 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x4 */
+				 2000 0 0 1 &mpic 3 1
+				 2000 0 0 2 &mpic 4 1
+				 2000 0 0 3 &mpic 1 1
+				 2000 0 0 4 &mpic 2 1
+
+				/* IDSEL 0x5  */
+				 2800 0 0 1 &mpic 2 1
+				 2800 0 0 2 &mpic 3 1
+				 2800 0 0 3 &mpic 4 1
+				 2800 0 0 4 &mpic 1 1
+
+				/* IDSEL 12 */
+				 6000 0 0 1 &mpic 1 1
+				 6000 0 0 2 &mpic 2 1
+				 6000 0 0 3 &mpic 3 1
+				 6000 0 0 4 &mpic 4 1
+
+				/* IDSEL 13 */
+				 6800 0 0 1 &mpic 4 1
+				 6800 0 0 2 &mpic 1 1
+				 6800 0 0 3 &mpic 2 1
+				 6800 0 0 4 &mpic 3 1
+
+				/* IDSEL 14*/
+				 7000 0 0 1 &mpic 3 1
+				 7000 0 0 2 &mpic 4 1
+				 7000 0 0 3 &mpic 1 1
+				 7000 0 0 4 &mpic 2 1
+
+				/* IDSEL 15 */
+				 7800 0 0 1 &mpic 2 1
+				 7800 0 0 2 &mpic 3 1
+				 7800 0 0 3 &mpic 4 1
+				 7800 0 0 4 &mpic 1 1
+
+				/* IDSEL 18 */
+				 9000 0 0 1 &mpic 1 1
+				 9000 0 0 2 &mpic 2 1
+				 9000 0 0 3 &mpic 3 1
+				 9000 0 0 4 &mpic 4 1
+
+				/* IDSEL 19 */
+				 9800 0 0 1 &mpic 4 1
+				 9800 0 0 2 &mpic 1 1
+				 9800 0 0 3 &mpic 2 1
+				 9800 0 0 4 &mpic 3 1
+
+				/* IDSEL 20 */
+				 a000 0 0 1 &mpic 3 1
+				 a000 0 0 2 &mpic 4 1
+				 a000 0 0 3 &mpic 1 1
+				 a000 0 0 4 &mpic 2 1
+
+				/* IDSEL 21 */
+				 a800 0 0 1 &mpic 2 1
+				 a800 0 0 2 &mpic 3 1
+				 a800 0 0 3 &mpic 4 1
+				 a800 0 0 4 &mpic 1 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <18 2>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 80000000 80000000 0 20000000
+			  01000000 0 00000000 e2000000 0 01000000>;
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 4d53d9b..f797662 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -53,11 +53,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <00001000 f8001000 000ff000
-			  80000000 80000000 20000000
-			  e2000000 e2000000 00100000
-			  a0000000 a0000000 20000000
-			  e3000000 e3000000 00100000>;
+		ranges = <00000000 f8000000 00100000>;
 		reg = <f8000000 00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
@@ -208,50 +204,75 @@
 			interrupt-parent = <&mpic>;
 		};
 
-		pcie@8000 {
-			compatible = "fsl,mpc8641-pcie";
-			device_type = "pci";
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			reg = <8000 1000>;
-			bus-range = <0 ff>;
-			ranges = <02000000 0 80000000 80000000 0 20000000
-				  01000000 0 00000000 e2000000 0 00100000>;
-			clock-frequency = <1fca055>;
-			interrupt-parent = <&mpic>;
-			interrupts = <18 2>;
-			interrupt-map-mask = <fb00 0 0 0>;
-			interrupt-map = <
-				/* IDSEL 0x11 */
-				8800 0 0 1 &i8259 9 2
-				8800 0 0 2 &i8259 a 2
-				8800 0 0 3 &i8259 b 2
-				8800 0 0 4 &i8259 c 2
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+		};
+	};
 
-				/* IDSEL 0x12 */
-				9000 0 0 1 &i8259 a 2
-				9000 0 0 2 &i8259 b 2
-				9000 0 0 3 &i8259 c 2
-				9000 0 0 4 &i8259 9 2
+	pcie@f8008000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <f8008000 1000>;
+		bus-range = <0 ff>;
+		ranges = <02000000 0 80000000 80000000 0 20000000
+			  01000000 0 00000000 e2000000 0 00100000>;
+		clock-frequency = <1fca055>;
+		interrupt-parent = <&mpic>;
+		interrupts = <18 2>;
+		interrupt-map-mask = <fb00 0 0 0>;
+		interrupt-map = <
+			/* IDSEL 0x11 */
+			8800 0 0 1 &i8259 9 2
+			8800 0 0 2 &i8259 a 2
+			8800 0 0 3 &i8259 b 2
+			8800 0 0 4 &i8259 c 2
 
-				// IDSEL 0x1c  USB
-				e000 0 0 0 &i8259 c 2
-				e100 0 0 0 &i8259 9 2
-				e200 0 0 0 &i8259 a 2
-				e300 0 0 0 &i8259 b 2
+			/* IDSEL 0x12 */
+			9000 0 0 1 &i8259 a 2
+			9000 0 0 2 &i8259 b 2
+			9000 0 0 3 &i8259 c 2
+			9000 0 0 4 &i8259 9 2
 
-				// IDSEL 0x1d  Audio
-				e800 0 0 0 &i8259 6 2
+			// IDSEL 0x1c  USB
+			e000 0 0 0 &i8259 c 2
+			e100 0 0 0 &i8259 9 2
+			e200 0 0 0 &i8259 a 2
+			e300 0 0 0 &i8259 b 2
 
-				// IDSEL 0x1e Legacy
-				f000 0 0 0 &i8259 7 2
-				f100 0 0 0 &i8259 7 2
+			// IDSEL 0x1d  Audio
+			e800 0 0 0 &i8259 6 2
 
-				// IDSEL 0x1f IDE/SATA
-				f800 0 0 0 &i8259 e 2
-				f900 0 0 0 &i8259 5 2
-				>;
+			// IDSEL 0x1e Legacy
+			f000 0 0 0 &i8259 7 2
+			f100 0 0 0 &i8259 7 2
+
+			// IDSEL 0x1f IDE/SATA
+			f800 0 0 0 &i8259 e 2
+			f900 0 0 0 &i8259 5 2
+			>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <02000000 0 80000000
+				  02000000 0 80000000
+				  0 20000000
+
+				  01000000 0 00000000
+				  01000000 0 00000000
+				  0 00100000>;
 			uli1575@0 {
 				reg = <0 0 0 0 0>;
 				#size-cells = <2>;
@@ -262,108 +283,96 @@
 					  01000000 0 00000000
 					  01000000 0 00000000
 					  0 00100000>;
+				isa@1e {
+					device_type = "isa";
+					#interrupt-cells = <2>;
+					#size-cells = <1>;
+					#address-cells = <2>;
+					reg = <f000 0 0 0 0>;
+					ranges = <1 0 01000000 0 0
+						  00001000>;
+					interrupt-parent = <&i8259>;
 
-				pci_bridge@0 {
-					reg = <0 0 0 0 0>;
-					#size-cells = <2>;
-					#address-cells = <3>;
-					ranges = <02000000 0 80000000
-						  02000000 0 80000000
-						  0 20000000
-						  01000000 0 00000000
-						  01000000 0 00000000
-						  0 00100000>;
-
-					isa@1e {
-						device_type = "isa";
+					i8259: interrupt-controller@20 {
+						reg = <1 20 2
+						       1 a0 2
+						       1 4d0 2>;
+						interrupt-controller;
+						device_type = "interrupt-controller";
+						#address-cells = <0>;
 						#interrupt-cells = <2>;
-						#size-cells = <1>;
-						#address-cells = <2>;
-						reg = <f000 0 0 0 0>;
-						ranges = <1 0 01000000 0 0
-							  00001000>;
-						interrupt-parent = <&i8259>;
-
-						i8259: interrupt-controller@20 {
-							reg = <1 20 2
-							       1 a0 2
-							       1 4d0 2>;
-							interrupt-controller;
-							device_type = "interrupt-controller";
-							#address-cells = <0>;
-							#interrupt-cells = <2>;
-							compatible = "chrp,iic";
-							interrupts = <9 2>;
-							interrupt-parent =
-								<&mpic>;
-						};
-
-						i8042@60 {
-							#size-cells = <0>;
-							#address-cells = <1>;
-							reg = <1 60 1 1 64 1>;
-							interrupts = <1 3 c 3>;
-							interrupt-parent =
-								<&i8259>;
+						compatible = "chrp,iic";
+						interrupts = <9 2>;
+						interrupt-parent = <&mpic>;
+					};
 
-							keyboard@0 {
-								reg = <0>;
-								compatible = "pnpPNP,303";
-							};
+					i8042@60 {
+						#size-cells = <0>;
+						#address-cells = <1>;
+						reg = <1 60 1 1 64 1>;
+						interrupts = <1 3 c 3>;
+						interrupt-parent =
+							<&i8259>;
 
-							mouse@1 {
-								reg = <1>;
-								compatible = "pnpPNP,f03";
-							};
+						keyboard@0 {
+							reg = <0>;
+							compatible = "pnpPNP,303";
 						};
 
-						rtc@70 {
-							compatible =
-								"pnpPNP,b00";
-							reg = <1 70 2>;
+						mouse@1 {
+							reg = <1>;
+							compatible = "pnpPNP,f03";
 						};
+					};
 
-						gpio@400 {
-							reg = <1 400 80>;
-						};
+					rtc@70 {
+						compatible =
+							"pnpPNP,b00";
+						reg = <1 70 2>;
+					};
+
+					gpio@400 {
+						reg = <1 400 80>;
 					};
 				};
 			};
-
 		};
 
-		pcie@9000 {
-			compatible = "fsl,mpc8641-pcie";
-			device_type = "pci";
-			#interrupt-cells = <1>;
+	};
+
+	pcie@f8009000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <f8009000 1000>;
+		bus-range = <0 ff>;
+		ranges = <02000000 0 a0000000 a0000000 0 20000000
+			  01000000 0 00000000 e3000000 0 00100000>;
+		clock-frequency = <1fca055>;
+		interrupt-parent = <&mpic>;
+		interrupts = <19 2>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 4 1
+			0000 0 0 2 &mpic 5 1
+			0000 0 0 3 &mpic 6 1
+			0000 0 0 4 &mpic 7 1
+			>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			reg = <9000 1000>;
-			bus-range = <0 ff>;
-			ranges = <02000000 0 a0000000 a0000000 0 20000000
-				  01000000 0 00000000 e3000000 0 00100000>;
-			clock-frequency = <1fca055>;
-			interrupt-parent = <&mpic>;
-			interrupts = <19 2>;
-			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <
-				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 4 1
-				0000 0 0 2 &mpic 5 1
-				0000 0 0 3 &mpic 6 1
-				0000 0 0 4 &mpic 7 1
-				>;
-		};
+			device_type = "pci";
+			ranges = <02000000 0 a0000000
+				  02000000 0 a0000000
+				  0 20000000
 
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <40000 40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-			big-endian;
+				  01000000 0 00000000
+				  01000000 0 00000000
+				  0 00100000>;
 		};
 	};
 };
-- 
1.5.2.4
