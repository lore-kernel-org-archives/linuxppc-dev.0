Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9A3CADDD07
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 13:58:19 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6D3wD4t006517
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 20:58:14 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6D3wCd6018263
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 22:58:13 -0500 (CDT)
Subject: [PATCH] Update mpc7448hpc2 device tree to be compatible for tsi109
	chip
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1184299081.30789.9.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jul 2007 11:58:01 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
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
---
Based on previous patch
http://ozlabs.org/pipermail/linuxppc-dev/2007-July/038957.html

 arch/powerpc/boot/dts/mpc7448hpc2.dts |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index f141ba2..45143f3 100644
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
@@ -83,7 +84,7 @@
 			linux,network-index = <0>;
 			#size-cells = <0>;
 			device_type = "network";
-			compatible = "tsi108-ethernet";
+			compatible = "tsi109-ethernet", "tsi108-ethernet";
 			reg = <6000 200>;
 			address = [ 00 06 D2 00 00 01 ];
 			interrupts = <10 2>;
@@ -97,7 +98,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
-			compatible = "tsi108-ethernet";
+			compatible = "tsi109-ethernet", "tsi108-ethernet";
 			reg = <6400 200>;
 			address = [ 00 06 D2 00 00 02 ];
 			interrupts = <11 2>;
@@ -136,7 +137,7 @@
                        	big-endian;
 		};
 		pci@1000 {
-			compatible = "tsi108-pci";
+			compatible = "tsi109-pci", "tsi108-pci";
 			device_type = "pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
@@ -190,7 +191,7 @@
 		};
 	};
 	chosen {
-		linux,stdout-path = "/tsi108@c0000000/serial@7808";
+		linux,stdout-path = "/tsi109@c0000000/serial@7808";
 	};
 
 };
-- 
1.5.1
