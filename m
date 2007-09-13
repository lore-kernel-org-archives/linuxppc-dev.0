Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02FB8DE02D
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:31 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/22] [POWERPC] DTS cleanup
Date: Thu, 13 Sep 2007 16:07:49 -0500
Message-Id: <11897176964013-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <118971769498-git-send-email-galak@kernel.crashing.org>
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
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removed the following cruft from .dts files:
* 32-bit in cpu node -- doesn't exist in any spec and not used by kernel
* removed built-in (chrp legacy)
* Removed #interrupt-cells in places they don't need to be set
* Fixed ranges on lite5200*
* Removed clock-frequency from i8259 pic node, not sure where this came from
* Removed big-endian from i8259 pic nodes, this was just bogus

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/holly.dts          |    1 -
 arch/powerpc/boot/dts/kuroboxHD.dts      |    2 --
 arch/powerpc/boot/dts/kuroboxHG.dts      |    2 --
 arch/powerpc/boot/dts/lite5200.dts       |    7 ++-----
 arch/powerpc/boot/dts/lite5200b.dts      |    7 ++-----
 arch/powerpc/boot/dts/mpc7448hpc2.dts    |    4 ----
 arch/powerpc/boot/dts/mpc8272ads.dts     |    5 -----
 arch/powerpc/boot/dts/mpc8313erdb.dts    |    3 ---
 arch/powerpc/boot/dts/mpc832x_mds.dts    |    4 ----
 arch/powerpc/boot/dts/mpc832x_rdb.dts    |    4 ----
 arch/powerpc/boot/dts/mpc8349emitx.dts   |    3 ---
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    3 ---
 arch/powerpc/boot/dts/mpc834x_mds.dts    |    3 ---
 arch/powerpc/boot/dts/mpc836x_mds.dts    |    4 ----
 arch/powerpc/boot/dts/mpc8540ads.dts     |    3 ---
 arch/powerpc/boot/dts/mpc8541cds.dts     |    6 ------
 arch/powerpc/boot/dts/mpc8544ds.dts      |    5 -----
 arch/powerpc/boot/dts/mpc8548cds.dts     |    5 -----
 arch/powerpc/boot/dts/mpc8555cds.dts     |    6 ------
 arch/powerpc/boot/dts/mpc8560ads.dts     |    5 -----
 arch/powerpc/boot/dts/mpc8568mds.dts     |    4 ----
 arch/powerpc/boot/dts/mpc8641_hpcn.dts   |    6 ------
 arch/powerpc/boot/dts/mpc866ads.dts      |    5 -----
 arch/powerpc/boot/dts/mpc885ads.dts      |    5 -----
 arch/powerpc/boot/dts/prpmc2800.dts      |    1 -
 25 files changed, 4 insertions(+), 99 deletions(-)

diff --git a/arch/powerpc/boot/dts/holly.dts b/arch/powerpc/boot/dts/holly.dts
index 1a4d0be..b5d8789 100644
--- a/arch/powerpc/boot/dts/holly.dts
+++ b/arch/powerpc/boot/dts/holly.dts
@@ -31,7 +31,6 @@
 			timebase-frequency = <2faf080>;
 			clock-frequency = <23c34600>;
 			bus-frequency = <bebc200>;
-			32-bit;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index a7b3714..ec71ab8 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -47,7 +47,6 @@ XXXX add flash parts, rtc, ??
 	soc10x { /* AFAICT need to make soc for 8245's uarts to be defined */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		compatible = "mpc10x";
 		store-gathering = <0>; /* 0 == off, !0 == on */
@@ -101,7 +100,6 @@ XXXX add flash parts, rtc, ??
 			compatible = "chrp,open-pic";
 			interrupt-controller;
 			reg = <80040000 40000>;
-			built-in;
 		};
 
 		pci@fec00000 {
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index a0007b9..32ecd23 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -47,7 +47,6 @@ XXXX add flash parts, rtc, ??
 	soc10x { /* AFAICT need to make soc for 8245's uarts to be defined */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		compatible = "mpc10x";
 		store-gathering = <0>; /* 0 == off, !0 == on */
@@ -101,7 +100,6 @@ XXXX add flash parts, rtc, ??
 			compatible = "chrp,open-pic";
 			interrupt-controller;
 			reg = <80040000 40000>;
-			built-in;
 		};
 
 		pci@fec00000 {
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index d29308f..d8bcbb8 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -37,7 +37,6 @@
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
-			32-bit;
 		};
 	};
 
@@ -50,10 +49,9 @@
 		model = "fsl,mpc5200";
 		compatible = "mpc5200";
 		revision = "";			// from bootloader
-		#interrupt-cells = <3>;
 		device_type = "soc";
-		ranges = <0 f0000000 f0010000>;
-		reg = <f0000000 00010000>;
+		ranges = <0 f0000000 0000c000>;
+		reg = <f0000000 00000100>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
 
@@ -69,7 +67,6 @@
 			device_type = "interrupt-controller";
 			compatible = "mpc5200-pic";
 			reg = <500 80>;
-			built-in;
 		};
 
 		gpt@600 {	// General Purpose Timer
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index f242531..5fe8998 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -37,7 +37,6 @@
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
-			32-bit;
 		};
 	};
 
@@ -50,10 +49,9 @@
 		model = "fsl,mpc5200b";
 		compatible = "mpc5200";
 		revision = "";			// from bootloader
-		#interrupt-cells = <3>;
 		device_type = "soc";
-		ranges = <0 f0000000 f0010000>;
-		reg = <f0000000 00010000>;
+		ranges = <0 f0000000 0000c000>;
+		reg = <f0000000 00000100>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
 
@@ -69,7 +67,6 @@
 			device_type = "interrupt-controller";
 			compatible = "mpc5200b-pic\0mpc5200-pic";
 			reg = <500 80>;
-			built-in;
 		};
 
 		gpt@600 {	// General Purpose Timer
diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index c60ad34..70e8a2e 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -31,7 +31,6 @@
 			timebase-frequency = <0>;	// 33 MHz, from uboot
 			clock-frequency = <0>;		// From U-Boot
 			bus-frequency = <0>;		// From U-Boot
-			32-bit;
 		};
 	};
 
@@ -44,7 +43,6 @@
 	tsi109@c0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "tsi-bridge";
 		compatible = "tsi109-bridge", "tsi108-bridge";
 		ranges = <00000000 c0000000 00010000>;
@@ -129,7 +127,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <7400 400>;
-			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
                        	big-endian;
@@ -181,7 +178,6 @@
 				device_type = "pic-router";
 				#address-cells = <0>;
 				#interrupt-cells = <2>;
-				built-in;
 				big-endian;
 				interrupts = <17 2>;
 				interrupt-parent = <&mpic>;
diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 4d09dca..4313054 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -29,7 +29,6 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			32-bit;
 		};
 	};
 
@@ -38,7 +37,6 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <f8200000 f8200004>;
-		built-in;
 		device_type = "pci-pic";
 	};
 
@@ -56,7 +54,6 @@
 	soc8272@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <00000000 f0000000 00053000>;
 		reg = <f0000000 10000>;
@@ -118,7 +115,6 @@
 		cpm@f0000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			#interrupt-cells = <2>;
 			device_type = "cpm";
 			model = "CPM2";
 			ranges = <00000000 00000000 20000>;
@@ -161,7 +157,6 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			reg = <10c00 80>;
-			built-in;
 			device_type = "cpm-pic";
 			compatible = "CPM2";
 		};
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index c5adbe4..abd73a2 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -29,7 +29,6 @@
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
-			32-bit;
 		};
 	};
 
@@ -41,7 +40,6 @@
 	soc8313@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00000200>;
@@ -207,7 +205,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <700 100>;
-			built-in;
 			device_type = "ipic";
 		};
 	};
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index f158ed7..e88167d 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -29,7 +29,6 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			32-bit;
 		};
 	};
 
@@ -46,7 +45,6 @@
 	soc8323@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00000200>;
@@ -163,7 +161,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <700 100>;
-			built-in;
 			device_type = "ipic";
 		};
 		
@@ -333,7 +330,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			reg = <80 80>;
-			built-in;
 			big-endian;
 			interrupts = <20 8 21 8>; //high:32 low:33
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 7c4beff..01393e6 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -29,7 +29,6 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			32-bit;
 		};
 	};
 
@@ -41,7 +40,6 @@
 	soc8323@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00000200>;
@@ -132,7 +130,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <700 100>;
-			built-in;
 			device_type = "ipic";
 		};
 
@@ -292,7 +289,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			reg = <80 80>;
-			built-in;
 			big-endian;
 			interrupts = <20 8 21 8>; //high:32 low:33
 			interrupt-parent = <&pic>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 502f47c..f98c785 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -28,7 +28,6 @@
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
-			32-bit;
 		};
 	};
 
@@ -40,7 +39,6 @@
 	soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00000200>;
@@ -244,7 +242,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <700 100>;
-			built-in;
 			device_type = "ipic";
 		};
 	};
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index 0b83871..7c89ff7 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -28,7 +28,6 @@
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
-			32-bit;
 		};
 	};
 
@@ -40,7 +39,6 @@
 	soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00000200>;
@@ -176,7 +174,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <700 100>;
-			built-in;
 			device_type = "ipic";
 		};
 	};
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 4810997..f4ba857 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -29,7 +29,6 @@
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
-			32-bit;
 		};
 	};
 
@@ -46,7 +45,6 @@
 	soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00000200>;
@@ -332,7 +330,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <700 100>;
-			built-in;
 			device_type = "ipic";
 		};
 	};
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index e3f7c12..f14e88e 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -34,7 +34,6 @@
 			timebase-frequency = <3EF1480>;
 			bus-frequency = <FBC5200>;
 			clock-frequency = <1F78A400>;
-			32-bit;
 		};
 	};
 
@@ -51,7 +50,6 @@
 	soc8360@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00000200>;
@@ -178,7 +176,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <700 100>;
-			built-in;
 			device_type = "ipic";
 		};
 
@@ -364,7 +361,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			reg = <80 80>;
-			built-in;
 			big-endian;
 			interrupts = <20 8 21 8>; //high:32 low:33
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index fc8dff9..e038c04 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -30,7 +30,6 @@
 			timebase-frequency = <0>;	//  33 MHz, from uboot
 			bus-frequency = <0>;	// 166 MHz
 			clock-frequency = <0>;	// 825 MHz, from uboot
-			32-bit;
 		};
 	};
 
@@ -42,7 +41,6 @@
 	soc8540@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00100000>;	// CCSRBAR 1M
@@ -268,7 +266,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <40000 40000>;
-			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
 			big-endian;
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index fb0b647..98afd4d 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -30,7 +30,6 @@
 			timebase-frequency = <0>;	//  33 MHz, from uboot
 			bus-frequency = <0>;	// 166 MHz
 			clock-frequency = <0>;	// 825 MHz, from uboot
-			32-bit;
 		};
 	};
 
@@ -42,7 +41,6 @@
 	soc8541@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00100000>;	// CCSRBAR 1M
@@ -197,15 +195,12 @@
 			device_type = "pci";
 
 			i8259@19000 {
-				clock-frequency = <0>;
 				interrupt-controller;
 				device_type = "interrupt-controller";
 				reg = <19000 0 0 0 1>;
 				#address-cells = <0>;
 				#interrupt-cells = <2>;
-				built-in;
 				compatible = "chrp,iic";
-				big-endian;
 				interrupts = <1>;
 				interrupt-parent = <&pci1>;
 			};
@@ -240,7 +235,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <40000 40000>;
-			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
                         big-endian;
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 3e79bf0..88082ac 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -30,7 +30,6 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			32-bit;
 		};
 	};
 
@@ -42,7 +41,6 @@
 	soc8544@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 
 
@@ -295,12 +293,10 @@
 							reg = <1 20 2
 							       1 a0 2
 							       1 4d0 2>;
-							clock-frequency = <0>;
 							interrupt-controller;
 							device_type = "interrupt-controller";
 							#address-cells = <0>;
 							#interrupt-cells = <2>;
-							built-in;
 							compatible = "chrp,iic";
 							interrupts = <9 2>;
 							interrupt-parent = <&mpic>;
@@ -350,7 +346,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <40000 40000>;
-			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
 			big-endian;
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index d215d21..11b8235 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -30,7 +30,6 @@
 			timebase-frequency = <0>;	//  33 MHz, from uboot
 			bus-frequency = <0>;	// 166 MHz
 			clock-frequency = <0>;	// 825 MHz, from uboot
-			32-bit;
 		};
 	};
 
@@ -42,7 +41,6 @@
 	soc8548@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <00001000 e0001000 000ff000
 			  80000000 80000000 10000000
@@ -318,7 +316,6 @@
 					interrupt-parent = <&i8259>;
 
 					i8259: interrupt-controller@20 {
-						clock-frequency = <0>;
 						interrupt-controller;
 						device_type = "interrupt-controller";
 						reg = <1 20 2
@@ -326,7 +323,6 @@
 						       1 4d0 2>;
 						#address-cells = <0>;
 						#interrupt-cells = <2>;
-						built-in;
 						compatible = "chrp,iic";
 						interrupts = <0 1>;
 						interrupt-parent = <&mpic>;
@@ -394,7 +390,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <40000 40000>;
-			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
                         big-endian;
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index c3c8882..ce11d11 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -30,7 +30,6 @@
 			timebase-frequency = <0>;	//  33 MHz, from uboot
 			bus-frequency = <0>;	// 166 MHz
 			clock-frequency = <0>;	// 825 MHz, from uboot
-			32-bit;
 		};
 	};
 
@@ -42,7 +41,6 @@
 	soc8555@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00100000>;	// CCSRBAR 1M
@@ -197,15 +195,12 @@
 			device_type = "pci";
 
 			i8259@19000 {
-				clock-frequency = <0>;
 				interrupt-controller;
 				device_type = "interrupt-controller";
 				reg = <19000 0 0 0 1>;
 				#address-cells = <0>;
 				#interrupt-cells = <2>;
-				built-in;
 				compatible = "chrp,iic";
-				big-endian;
 				interrupts = <1>;
 				interrupt-parent = <&pci1>;
 			};
@@ -240,7 +235,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <40000 40000>;
-			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
                         big-endian;
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 16dbe84..cf87c30 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -30,7 +30,6 @@
 			timebase-frequency = <04ead9a0>;
 			bus-frequency = <13ab6680>;
 			clock-frequency = <312c8040>;
-			32-bit;
 		};
 	};
 
@@ -42,7 +41,6 @@
 	soc8560@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00000200>;
@@ -227,14 +225,12 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <40000 40000>;
-			built-in;
 			device_type = "open-pic";
 		};
 
 		cpm@e0000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			#interrupt-cells = <2>;
 			device_type = "cpm";
 			model = "CPM2";
 			ranges = <0 0 c0000>;
@@ -249,7 +245,6 @@
 				interrupts = <2e 2>;
 				interrupt-parent = <&mpic>;
 				reg = <90c00 80>;
-				built-in;
 				device_type = "cpm-pic";
 			};
 
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index b1dcfbe..c472a4b 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -34,7 +34,6 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			32-bit;
 		};
 	};
 
@@ -51,7 +50,6 @@
 	soc8568@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00100000>;
@@ -258,7 +256,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <40000 40000>;
-			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
                         big-endian;
@@ -449,7 +446,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			reg = <80 80>;
-			built-in;
 			big-endian;
 			interrupts = <2e 2 2e 2>; //high:30 low:30
 			interrupt-parent = <&mpic>;
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index b0166e5..4d53d9b 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -30,7 +30,6 @@
 			timebase-frequency = <0>;	// 33 MHz, from uboot
 			bus-frequency = <0>;		// From uboot
 			clock-frequency = <0>;		// From uboot
-			32-bit;
 		};
 		PowerPC,8641@1 {
 			device_type = "cpu";
@@ -42,7 +41,6 @@
 			timebase-frequency = <0>;	// 33 MHz, from uboot
 			bus-frequency = <0>;		// From uboot
 			clock-frequency = <0>;		// From uboot
-			32-bit;
 		};
 	};
 
@@ -54,7 +52,6 @@
 	soc8641@f8000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <00001000 f8001000 000ff000
 			  80000000 80000000 20000000
@@ -291,12 +288,10 @@
 							reg = <1 20 2
 							       1 a0 2
 							       1 4d0 2>;
-							clock-frequency = <0>;
 							interrupt-controller;
 							device_type = "interrupt-controller";
 							#address-cells = <0>;
 							#interrupt-cells = <2>;
-							built-in;
 							compatible = "chrp,iic";
 							interrupts = <9 2>;
 							interrupt-parent =
@@ -366,7 +361,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <40000 40000>;
-			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
 			big-endian;
diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index e5e7726..90f2293 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -30,7 +30,6 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			32-bit;
 			interrupts = <f 2>;	// decrementer interrupt
 			interrupt-parent = <&Mpc8xx_pic>;
 		};
@@ -44,7 +43,6 @@
 	soc866@ff000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 ff000000 00100000>;
 		reg = <ff000000 00000200>;
@@ -78,7 +76,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0 24>;
-			built-in;
 			device_type = "mpc8xx-pic";
 			compatible = "CPM";
 		};
@@ -86,7 +83,6 @@
 		cpm@ff000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			#interrupt-cells = <2>;
 			device_type = "cpm";
 			model = "CPM";
 			ranges = <0 0 4000>;
@@ -103,7 +99,6 @@
 				interrupts = <5 2 0 2>;
 				interrupt-parent = <&Mpc8xx_pic>;
 				reg = <930 20>;
-				built-in;
 				device_type = "cpm-pic";
 				compatible = "CPM";
 			};
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index dc7ab9c..e9aa9d0 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -30,7 +30,6 @@
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			32-bit;
 			interrupts = <f 2>;	// decrementer interrupt
 			interrupt-parent = <&Mpc8xx_pic>;
 		};
@@ -44,7 +43,6 @@
 	soc885@ff000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		ranges = <0 ff000000 00100000>;
 		reg = <ff000000 00000200>;
@@ -98,7 +96,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0 24>;
-			built-in;
 			device_type = "mpc8xx-pic";
 			compatible = "CPM";
 		};
@@ -117,7 +114,6 @@
 		cpm@ff000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			#interrupt-cells = <2>;
 			device_type = "cpm";
 			model = "CPM";
 			ranges = <0 0 4000>;
@@ -134,7 +130,6 @@
 				interrupts = <5 2 0 2>;
 				interrupt-parent = <&Mpc8xx_pic>;
 				reg = <930 20>;
-				built-in;
 				device_type = "cpm-pic";
 				compatible = "CPM";
 			};
diff --git a/arch/powerpc/boot/dts/prpmc2800.dts b/arch/powerpc/boot/dts/prpmc2800.dts
index e416ea6..297dfa5 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -43,7 +43,6 @@
 	mv64x60@f1000000 { /* Marvell Discovery */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <1>;
 		model = "mv64360";			/* Default */
 		compatible = "marvell,mv64x60";
 		clock-frequency = <7f28155>;		/* 133.333333 MHz */
-- 
1.5.2.4
