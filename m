Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DEDA0DDE22
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 02:55:00 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l8CGsuYE003908
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 11:54:56 -0500
Date: Wed, 12 Sep 2007 11:54:46 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] DTS cleanup
Message-ID: <Pine.LNX.4.64.0709121154120.19816@blarg.am.freescale.net>
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

Removed the following cruft from .dts files:
* 32-bit in cpu node -- doesn't exist in any spec and not used by kernel
* built-in for non-standard buses (ISA, PCI)
* Removed #interrupt-cells in places they don't need to be set
* Fixed ranges on lite5200*

---

Exists in my for-2.6.24 branch

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
 arch/powerpc/boot/dts/mpc8541cds.dts     |    3 ---
 arch/powerpc/boot/dts/mpc8544ds.dts      |    3 ---
 arch/powerpc/boot/dts/mpc8548cds.dts     |    3 ---
 arch/powerpc/boot/dts/mpc8555cds.dts     |    3 ---
 arch/powerpc/boot/dts/mpc8560ads.dts     |    5 -----
 arch/powerpc/boot/dts/mpc8568mds.dts     |    4 ----
 arch/powerpc/boot/dts/mpc8641_hpcn.dts   |    4 ----
 arch/powerpc/boot/dts/mpc866ads.dts      |    5 -----
 arch/powerpc/boot/dts/mpc885ads.dts      |    5 -----
 arch/powerpc/boot/dts/prpmc2800.dts      |    1 -
 25 files changed, 4 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/boot/dts/holly.dts b/arch/powerpc/boot/dts/holly.dts
index 80a4fab..2ecad82 100644
--- a/arch/powerpc/boot/dts/holly.dts
+++ b/arch/powerpc/boot/dts/holly.dts
@@ -35,7 +35,6 @@
 			timebase-frequency = <2faf080>;
 			clock-frequency = <23c34600>;
 			bus-frequency = <bebc200>;
-			32-bit;
 		};
 	};

diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index 63ba351..7413839 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -50,7 +50,6 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 	soc10x { /* AFAICT need to make soc for 8245's uarts to be defined */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		compatible = "mpc10x";
 		store-gathering = <0>; /* 0 == off, !0 == on */
@@ -104,7 +103,6 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 			compatible = "chrp,open-pic";
 			interrupt-controller;
 			reg = <80040000 40000>;
-			built-in;
 		};

 		pci@fec00000 {
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index e8ce0e3..3d7ceb8 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -50,7 +50,6 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 	soc10x { /* AFAICT need to make soc for 8245's uarts to be defined */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
 		compatible = "mpc10x";
 		store-gathering = <0>; /* 0 == off, !0 == on */
@@ -104,7 +103,6 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 			compatible = "chrp,open-pic";
 			interrupt-controller;
 			reg = <80040000 40000>;
-			built-in;
 		};

 		pci@fec00000 {
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index d29308f..4783503 100644
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
+		reg = <f0000000 0000c000>;
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
index f242531..1db7257 100644
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
+		reg = <f0000000 0000c000>;
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
index fb0b647..82f4b06 100644
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
@@ -240,7 +238,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <40000 40000>;
-			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
                         big-endian;
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 3e79bf0..a074700 100644
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


@@ -350,7 +348,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <40000 40000>;
-			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
 			big-endian;
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index d215d21..b88e806 100644
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
@@ -394,7 +392,6 @@
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <40000 40000>;
-			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
                         big-endian;
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index c3c8882..8622174 100644
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
@@ -240,7 +238,6 @@
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
index b0166e5..a73b279 100644
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
@@ -366,7 +363,6 @@
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
index 5300b50..55684b6 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -47,7 +47,6 @@
 	mv64x60@f1000000 { /* Marvell Discovery */
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <1>;
 		model = "mv64360";			/* Default */
 		compatible = "marvell,mv64x60";
 		clock-frequency = <7f28155>;		/* 133.333333 MHz */
-- 
1.5.2.4
