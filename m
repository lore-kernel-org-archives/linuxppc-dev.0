Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE415DDF32
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:50:01 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m766ntWK000030
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 23:49:55 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m766nrIS000135
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 01:49:54 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH 1/6] powerpc: update flash size and partition in mpc8272ads dts
Date: Wed,  6 Aug 2008 15:04:40 +0800
Message-Id: <1218006285-27138-1-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make the flash size 8M to be consistent with the module comes with board.
Add predefined partitions for the flash.  Add ethernet port aliases.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8272ads.dts |   38 +++++++++++++++++++++++++++++----
 1 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 2a1929a..b2ce4c0 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -17,6 +17,11 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -46,15 +51,38 @@
 		#size-cells = <1>;
 		reg = <0xf0010100 0x40>;
 
-		ranges = <0x0 0x0 0xfe000000 0x2000000
+		ranges = <0x0 0x0 0xff800000 0x800000
 		          0x1 0x0 0xf4500000 0x8000
 		          0x3 0x0 0xf8200000 0x8000>;
 
 		flash@0,0 {
-			compatible = "jedec-flash";
-			reg = <0x0 0x0 0x2000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			probe-type = "CFI";
+			reg = <0x0 0x0 0x800000>;
 			bank-width = <4>;
 			device-width = <1>;
+			hrcw@0 {
+				label = "hrcw";
+				reg = <0x0 0x40000>;
+			};
+			fs@40000 {
+				label = "fs";
+				reg = <0x40000 0x540000>;
+			};
+			kernel@580000 {
+				label = "kernel";
+				reg = <0x580000 0x180000>;
+			};
+			u-boot@700000 {
+				label = "u-boot";
+				reg = <0x700000 0x40000>;
+			};
+			u-boot-env@740000 {
+				label = "u-boot-env";
+				reg = <0x740000 0x40000>;
+			};
 		};
 
 		board-control@1,0 {
@@ -192,7 +220,7 @@
 				};
 			};
 
-			ethernet@11300 {
+			enet0: ethernet@11300 {
 				device_type = "network";
 				compatible = "fsl,mpc8272-fcc-enet",
 				             "fsl,cpm2-fcc-enet";
@@ -205,7 +233,7 @@
 				fsl,cpm-command = <0x12000300>;
 			};
 
-			ethernet@11320 {
+			enet1: ethernet@11320 {
 				device_type = "network";
 				compatible = "fsl,mpc8272-fcc-enet",
 				             "fsl,cpm2-fcc-enet";
-- 
1.5.5.1.248.g4b17
