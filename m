Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9EC63DDF01
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 12:33:34 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m0PMamd9000606
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 15:36:48 -0700 (MST)
Received: from [10.214.72.96] (mvp-10-214-72-96.am.freescale.net
	[10.214.72.96])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0PMalF8013093
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 16:36:48 -0600 (CST)
Message-ID: <479A647F.7090300@freescale.com>
Date: Fri, 25 Jan 2008 16:36:47 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] POWERPC: Convert StorCenter DTS file to /dts-v1/ format.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/boot/dts/storcenter.dts |   73 +++++++++++++++++----------------
 1 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/boot/dts/storcenter.dts b/arch/powerpc/boot/dts/storcenter.dts
index 6aa1d69..2204874 100644
--- a/arch/powerpc/boot/dts/storcenter.dts
+++ b/arch/powerpc/boot/dts/storcenter.dts
@@ -11,6 +11,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	model = "StorCenter";
 	compatible = "storcenter";
@@ -30,19 +32,19 @@
 		PowerPC,8241@0 {
 			device_type = "cpu";
 			reg = <0>;
-			clock-frequency = <d# 200000000>;	/* Hz */
-			timebase-frequency = <d# 25000000>;	/* Hz */
+			clock-frequency = <200000000>;
+			timebase-frequency = <25000000>;
 			bus-frequency = <0>;	/* from bootwrapper */
-			i-cache-line-size = <d# 32>;	/* bytes */
-			d-cache-line-size = <d# 32>;	/* bytes */
-			i-cache-size = <4000>;
-			d-cache-size = <4000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <16384>;
+			d-cache-size = <16384>;
 		};
 	};
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 04000000>;	/* 64MB @ 0x0 */
+		reg = <0x00000000 0x04000000>;	/* 64MB @ 0x0 */
 	};
 
 	soc@fc000000 {
@@ -51,15 +53,15 @@
 		device_type = "soc";
 		compatible = "fsl,mpc8241", "mpc10x";
 		store-gathering = <0>; /* 0 == off, !0 == on */
-		ranges = <0 fc000000 100000>;
-		reg = <fc000000 100000>;	/* EUMB */
+		ranges = <0x0 0xfc000000 0x100000>;
+		reg = <0xfc000000 0x100000>;	/* EUMB */
 		bus-frequency = <0>;		/* fixed by loader */
 
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl-i2c";
-			reg = <3000 100>;
+			reg = <0x3000 0x100>;
 			interrupts = <5 2>;
 			interrupt-parent = <&mpic>;
 
@@ -73,9 +75,9 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 20>;
-			clock-frequency = <d# 97553800>; /* Hz */
-			current-speed = <d# 115200>;
+			reg = <0x4500 0x20>;
+			clock-frequency = <97553800>; /* Hz */
+			current-speed = <115200>;
 			interrupts = <9 2>;
 			interrupt-parent = <&mpic>;
 		};
@@ -84,10 +86,10 @@
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4600 20>;
-			clock-frequency = <d# 97553800>; /* Hz */
-			current-speed = <d# 9600>;
-			interrupts = <a 2>;
+			reg = <0x4600 0x20>;
+			clock-frequency = <97553800>; /* Hz */
+			current-speed = <9600>;
+			interrupts = <10 2>;
 			interrupt-parent = <&mpic>;
 		};
 
@@ -96,7 +98,7 @@
 			device_type = "open-pic";
 			compatible = "chrp,open-pic";
 			interrupt-controller;
-			reg = <40000 40000>;
+			reg = <0x40000 0x40000>;
 		};
 
 	};
@@ -107,28 +109,29 @@
 		#interrupt-cells = <1>;
 		device_type = "pci";
 		compatible = "mpc10x-pci";
-		reg = <fe800000 1000>;
-		ranges = <01000000 0        0 fe000000 0 00c00000
-			  02000000 0 80000000 80000000 0 70000000>;
-		bus-range = <0 ff>;
-		clock-frequency = <d# 97553800>; /* Hz */
+		reg = <0xfe800000 0x1000>;
+		ranges = <0x01000000 0x0        0x0 0xfe000000 0x0 0x00c00000
+			  0x02000000 0x0 0x80000000 0x80000000 0x0 0x70000000>;
+		bus-range = <0 0xff>;
+		clock-frequency = <97553800>;
 		interrupt-parent = <&mpic>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 13 - IDE */
-			6800 0 0 1 &mpic 0 1
-			6800 0 0 2 &mpic 0 1
-			6800 0 0 3 &mpic 0 1
+			0x6800 0 0 1 &mpic 0 1
+			0x6800 0 0 2 &mpic 0 1
+			0x6800 0 0 3 &mpic 0 1
+			0x6800 0 0 4 &mpic 0 1
 			/* IDSEL 14 - USB */
-			7000 0 0 1 &mpic 0 1
-			7000 0 0 2 &mpic 0 1
-			7000 0 0 3 &mpic 0 1
-			7000 0 0 4 &mpic 0 1
+			0x7000 0 0 1 &mpic 0 1
+			0x7000 0 0 2 &mpic 0 1
+			0x7000 0 0 3 &mpic 0 1
+			0x7000 0 0 4 &mpic 0 1
 			/* IDSEL 15 - ETH */
-			7800 0 0 1 &mpic 0 1
-			7800 0 0 2 &mpic 0 1
-			7800 0 0 3 &mpic 0 1
-			7800 0 0 4 &mpic 0 1
+			0x7800 0 0 1 &mpic 0 1
+			0x7800 0 0 2 &mpic 0 1
+			0x7800 0 0 3 &mpic 0 1
+			0x7800 0 0 4 &mpic 0 1
 		>;
 	};
 
-- 
1.5.2.1.126.g6abd0
