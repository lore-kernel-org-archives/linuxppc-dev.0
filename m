Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 493E8DDE1C
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 04:32:56 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lB5HWpWj014457
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Dec 2007 10:32:51 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lB5HWooc003446
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Dec 2007 11:32:51 -0600 (CST)
Subject: [PATCH] Add aliases node to 8641hpcn DTS file.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1196875970.8544.12.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 05 Dec 2007 11:32:50 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The addition of the aliases node is needed for U-Boot
and, eventually, cuImage, to help locate the proper
nodes reliably when using the libfdt approach.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index abb26dc..b039f21 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -16,6 +16,17 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -107,7 +118,7 @@
 			};
 		};
 
-		ethernet@24000 {
+		enet0: ethernet@24000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
@@ -127,7 +138,7 @@
 			phy-connection-type = "rgmii-id";
 		};
 
-		ethernet@25000 {
+		enet1: ethernet@25000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
@@ -147,7 +158,7 @@
 			phy-connection-type = "rgmii-id";
 		};
 		
-		ethernet@26000 {
+		enet2: ethernet@26000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
@@ -167,7 +178,7 @@
 			phy-connection-type = "rgmii-id";
 		};
 
-		ethernet@27000 {
+		enet3: ethernet@27000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
@@ -186,7 +197,8 @@
 			phy-handle = <&phy3>;
 			phy-connection-type = "rgmii-id";
 		};
-		serial@4500 {
+
+		serial0: serial@4500 {
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4500 100>;
@@ -195,7 +207,7 @@
 			interrupt-parent = <&mpic>;
 		};
 
-		serial@4600 {
+		serial1: serial@4600 {
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <4600 100>;
@@ -222,7 +234,7 @@
 		};
 	};
 
-	pcie@f8008000 {
+	pci0: pcie@f8008000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
@@ -430,7 +442,7 @@
 
 	};
 
-	pcie@f8009000 {
+	pci1: pcie@f8009000 {
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
 		#interrupt-cells = <1>;
-- 
1.5.2.1.126.g6abd0
