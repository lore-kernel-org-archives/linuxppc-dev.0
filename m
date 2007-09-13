Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37FE0DDFD2
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:21 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/22] [POWERPC] Update mpc7448hpc2 device tree to be
	compatible for tsi109 chip
Date: Thu, 13 Sep 2007 16:07:42 -0500
Message-Id: <11897176851400-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11897176841013-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Update mpc7448hpc2 device tree to be compatible for tsi109 chip.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc7448hpc2.dts |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index b9158eb..c60ad34 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -41,11 +41,12 @@
 		       >;
 	};
 
-  	tsi108@c0000000 {
+	tsi109@c0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
 		device_type = "tsi-bridge";
+		compatible = "tsi109-bridge", "tsi108-bridge";
 		ranges = <00000000 c0000000 00010000>;
 		reg = <c0000000 00010000>;
 		bus-frequency = <0>;
@@ -55,12 +56,12 @@
 			interrupts = <E 0>;
 			reg = <7000 400>;
 			device_type = "i2c";
-			compatible  = "tsi108-i2c";
+			compatible  = "tsi109-i2c", "tsi108-i2c";
 		};
 
 		MDIO: mdio@6000 {
 			device_type = "mdio";
-			compatible = "tsi108-mdio";
+			compatible = "tsi109-mdio", "tsi108-mdio";
 			reg = <6000 50>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -82,7 +83,7 @@
 		ethernet@6200 {
 			#size-cells = <0>;
 			device_type = "network";
-			compatible = "tsi108-ethernet";
+			compatible = "tsi109-ethernet", "tsi108-ethernet";
 			reg = <6000 200>;
 			address = [ 00 06 D2 00 00 01 ];
 			interrupts = <10 2>;
@@ -95,7 +96,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
-			compatible = "tsi108-ethernet";
+			compatible = "tsi109-ethernet", "tsi108-ethernet";
 			reg = <6400 200>;
 			address = [ 00 06 D2 00 00 02 ];
 			interrupts = <11 2>;
@@ -134,7 +135,7 @@
                        	big-endian;
 		};
 		pci@1000 {
-			compatible = "tsi108-pci";
+			compatible = "tsi109-pci", "tsi108-pci";
 			device_type = "pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
-- 
1.5.2.4
