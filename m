Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1176DE3E4
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 04:46:53 +1000 (EST)
Date: Mon, 7 Apr 2008 11:46:33 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: paulus@samba.org
Message-ID: <20080407184633.GC7438@farnsworth.org>
References: <20080407183228.GA7438@farnsworth.org>
MIME-Version: 1.0
In-Reply-To: <20080407183228.GA7438@farnsworth.org>
Subject: [PATCH 2/9 v2] powerpc: prpmc2800: convert DTS to v1 and add labels
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Update the prpmc2800 DTS file to version 1 and add labels.
I verified that there was no change in the resulting dtb file.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

---
 arch/powerpc/boot/dts/prpmc2800.dts |  264 +++++++++++++-------------
 1 file changed, 134 insertions(+), 130 deletions(-)

Index: linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/prpmc2800.dts
+++ linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
@@ -11,6 +11,8 @@
  * if it can determine the exact PrPMC type.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -25,19 +27,19 @@
 		PowerPC,7447 {
 			device_type = "cpu";
 			reg = <0>;
-			clock-frequency = <2bb0b140>;	/* Default (733 MHz) */
-			bus-frequency = <7f28155>;	/* 133.333333 MHz */
-			timebase-frequency = <1fca055>;	/* 33.333333 MHz */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <8000>;
-			d-cache-size = <8000>;
+			clock-frequency = <733000000>;	/* Default */
+			bus-frequency = <133333333>;
+			timebase-frequency = <33333333>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
 		};
 	};
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 20000000>;	/* Default (512MB) */
+		reg = <0x0 0x20000000>;			/* Default (512MB) */
 	};
 
 	mv64x60@f1000000 { /* Marvell Discovery */
@@ -45,26 +47,26 @@
 		#size-cells = <1>;
 		model = "mv64360";			/* Default */
 		compatible = "mrvl,mv64x60";
-		clock-frequency = <7f28155>;		/* 133.333333 MHz */
-		reg = <f1000000 00010000>;
-		virtual-reg = <f1000000>;
-		ranges = <88000000 88000000 01000000	/* PCI 0 I/O Space */
-			  80000000 80000000 08000000	/* PCI 0 MEM Space */
-			  a0000000 a0000000 04000000	/* User FLASH */
-			  00000000 f1000000 00010000	/* Bridge's regs */
-			  f2000000 f2000000 00040000>;	/* Integrated SRAM */
+		clock-frequency = <133333333>;
+		reg = <0xf1000000 0x10000>;
+		virtual-reg = <0xf1000000>;
+		ranges = <0x88000000 0x88000000 0x1000000 /* PCI 0 I/O Space */
+			  0x80000000 0x80000000 0x8000000 /* PCI 0 MEM Space */
+			  0xa0000000 0xa0000000 0x4000000 /* User FLASH */
+			  0x00000000 0xf1000000 0x0010000 /* Bridge's regs */
+			  0xf2000000 0xf2000000 0x0040000>;/* Integrated SRAM */
 
 		flash@a0000000 {
 			device_type = "rom";
 			compatible = "direct-mapped";
-			reg = <a0000000 4000000>; /* Default (64MB) */
+			reg = <0xa0000000 0x4000000>; /* Default (64MB) */
 			probe-type = "CFI";
 			bank-width = <4>;
-			partitions = <00000000 00100000 /* RO */
-				      00100000 00040001 /* RW */
-				      00140000 00400000 /* RO */
-				      00540000 039c0000 /* RO */
-				      03f00000 00100000>; /* RO */
+			partitions = <0x00000000 0x00100000 /* RO */
+				      0x00100000 0x00040001 /* RW */
+				      0x00140000 0x00400000 /* RO */
+				      0x00540000 0x039c0000 /* RO */
+				      0x03f00000 0x00100000>; /* RO */
 			partition-names = "FW Image A", "FW Config Data", "Kernel Image", "Filesystem", "FW Image B";
 		};
 
@@ -73,170 +75,170 @@
 			#size-cells = <0>;
 			device_type = "mdio";
 			compatible = "mrvl,mv64x60-mdio";
-			ethernet-phy@1 {
+			PHY0: ethernet-phy@1 {
 				device_type = "ethernet-phy";
 				compatible = "broadcom,bcm5421";
-				interrupts = <4c>;	/* GPP 12 */
-				interrupt-parent = <&/mv64x60/pic>;
+				interrupts = <76>;	/* GPP 12 */
+				interrupt-parent = <&PIC>;
 				reg = <1>;
 			};
-			ethernet-phy@3 {
+			PHY1: ethernet-phy@3 {
 				device_type = "ethernet-phy";
 				compatible = "broadcom,bcm5421";
-				interrupts = <4c>;	/* GPP 12 */
-				interrupt-parent = <&/mv64x60/pic>;
+				interrupts = <76>;	/* GPP 12 */
+				interrupt-parent = <&PIC>;
 				reg = <3>;
 			};
 		};
 
 		ethernet@2000 {
-			reg = <2000 2000>;
+			reg = <0x2000 0x2000>;
 			eth0 {
 				device_type = "network";
 				compatible = "mrvl,mv64x60-eth";
 				block-index = <0>;
-				interrupts = <20>;
-				interrupt-parent = <&/mv64x60/pic>;
-				phy = <&/mv64x60/mdio/ethernet-phy@1>;
+				interrupts = <32>;
+				interrupt-parent = <&PIC>;
+				phy = <&PHY0>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
 			};
 			eth1 {
 				device_type = "network";
 				compatible = "mrvl,mv64x60-eth";
 				block-index = <1>;
-				interrupts = <21>;
-				interrupt-parent = <&/mv64x60/pic>;
-				phy = <&/mv64x60/mdio/ethernet-phy@3>;
+				interrupts = <33>;
+				interrupt-parent = <&PIC>;
+				phy = <&PHY1>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
 			};
 		};
 
-		sdma@4000 {
+		SDMA0: sdma@4000 {
 			device_type = "dma";
 			compatible = "mrvl,mv64x60-sdma";
-			reg = <4000 c18>;
-			virtual-reg = <f1004000>;
+			reg = <0x4000 0xc18>;
+			virtual-reg = <0xf1004000>;
 			interrupt-base = <0>;
-			interrupts = <24>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupts = <36>;
+			interrupt-parent = <&PIC>;
 		};
 
-		sdma@6000 {
+		SDMA1: sdma@6000 {
 			device_type = "dma";
 			compatible = "mrvl,mv64x60-sdma";
-			reg = <6000 c18>;
-			virtual-reg = <f1006000>;
+			reg = <0x6000 0xc18>;
+			virtual-reg = <0xf1006000>;
 			interrupt-base = <0>;
-			interrupts = <26>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupts = <38>;
+			interrupt-parent = <&PIC>;
 		};
 
-		brg@b200 {
+		BRG0: brg@b200 {
 			compatible = "mrvl,mv64x60-brg";
-			reg = <b200 8>;
+			reg = <0xb200 0x8>;
 			clock-src = <8>;
-			clock-frequency = <7ed6b40>;
-			current-speed = <2580>;
+			clock-frequency = <133000000>;
+			current-speed = <9600>;
 			bcr = <0>;
 		};
 
-		brg@b208 {
+		BRG1: brg@b208 {
 			compatible = "mrvl,mv64x60-brg";
-			reg = <b208 8>;
+			reg = <0xb208 0x8>;
 			clock-src = <8>;
-			clock-frequency = <7ed6b40>;
-			current-speed = <2580>;
+			clock-frequency = <133000000>;
+			current-speed = <9600>;
 			bcr = <0>;
 		};
 
-		cunit@f200 {
-			reg = <f200 200>;
+		CUNIT: cunit@f200 {
+			reg = <0xf200 0x200>;
 		};
 
-		mpscrouting@b400 {
-			reg = <b400 c>;
+		MPSCROUTING: mpscrouting@b400 {
+			reg = <0xb400 0xc>;
 		};
 
-		mpscintr@b800 {
-			reg = <b800 100>;
-			virtual-reg = <f100b800>;
+		MPSCINTR: mpscintr@b800 {
+			reg = <0xb800 0x100>;
+			virtual-reg = <0xf100b800>;
 		};
 
-		mpsc@8000 {
+		MPSC0: mpsc@8000 {
 			device_type = "serial";
 			compatible = "mrvl,mpsc";
-			reg = <8000 38>;
-			virtual-reg = <f1008000>;
-			sdma = <&/mv64x60/sdma@4000>;
-			brg = <&/mv64x60/brg@b200>;
-			cunit = <&/mv64x60/cunit@f200>;
-			mpscrouting = <&/mv64x60/mpscrouting@b400>;
-			mpscintr = <&/mv64x60/mpscintr@b800>;
+			reg = <0x8000 0x38>;
+			virtual-reg = <0xf1008000>;
+			sdma = <&SDMA0>;
+			brg = <&BRG0>;
+			cunit = <&CUNIT>;
+			mpscrouting = <&MPSCROUTING>;
+			mpscintr = <&MPSCINTR>;
 			block-index = <0>;
-			max_idle = <28>;
+			max_idle = <40>;
 			chr_1 = <0>;
 			chr_2 = <0>;
 			chr_10 = <3>;
 			mpcr = <0>;
-			interrupts = <28>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupts = <40>;
+			interrupt-parent = <&PIC>;
 		};
 
-		mpsc@9000 {
+		MPSC1: mpsc@9000 {
 			device_type = "serial";
 			compatible = "mrvl,mpsc";
-			reg = <9000 38>;
-			virtual-reg = <f1009000>;
-			sdma = <&/mv64x60/sdma@6000>;
-			brg = <&/mv64x60/brg@b208>;
-			cunit = <&/mv64x60/cunit@f200>;
-			mpscrouting = <&/mv64x60/mpscrouting@b400>;
-			mpscintr = <&/mv64x60/mpscintr@b800>;
+			reg = <0x9000 0x38>;
+			virtual-reg = <0xf1009000>;
+			sdma = <&SDMA1>;
+			brg = <&BRG1>;
+			cunit = <&CUNIT>;
+			mpscrouting = <&MPSCROUTING>;
+			mpscintr = <&MPSCINTR>;
 			block-index = <1>;
-			max_idle = <28>;
+			max_idle = <40>;
 			chr_1 = <0>;
 			chr_2 = <0>;
 			chr_10 = <3>;
 			mpcr = <0>;
-			interrupts = <2a>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupts = <42>;
+			interrupt-parent = <&PIC>;
 		};
 
 		wdt@b410 {			/* watchdog timer */
 			compatible = "mrvl,mv64x60-wdt";
-			reg = <b410 8>;
-			timeout = <a>;		/* wdt timeout in seconds */
+			reg = <0xb410 0x8>;
+			timeout = <10>;		/* wdt timeout in seconds */
 		};
 
 		i2c@c000 {
 			device_type = "i2c";
 			compatible = "mrvl,mv64x60-i2c";
-			reg = <c000 20>;
-			virtual-reg = <f100c000>;
+			reg = <0xc000 0x20>;
+			virtual-reg = <0xf100c000>;
 			freq_m = <8>;
 			freq_n = <3>;
-			timeout = <3e8>;		/* 1000 = 1 second */
+			timeout = <1000>;		/* 1000 = 1 second */
 			retries = <1>;
-			interrupts = <25>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupts = <37>;
+			interrupt-parent = <&PIC>;
 		};
 
-		pic {
+		PIC: pic {
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			compatible = "mrvl,mv64x60-pic";
-			reg = <0000 88>;
+			reg = <0x0 0x88>;
 			interrupt-controller;
 		};
 
 		mpp@f000 {
 			compatible = "mrvl,mv64x60-mpp";
-			reg = <f000 10>;
+			reg = <0xf000 0x10>;
 		};
 
 		gpp@f100 {
 			compatible = "mrvl,mv64x60-gpp";
-			reg = <f100 20>;
+			reg = <0xf100 0x20>;
 		};
 
 		pci@80000000 {
@@ -245,72 +247,74 @@
 			#interrupt-cells = <1>;
 			device_type = "pci";
 			compatible = "mrvl,mv64x60-pci";
-			reg = <0cf8 8>;
-			ranges = <01000000 0        0 88000000 0 01000000
-				  02000000 0 80000000 80000000 0 08000000>;
-			bus-range = <0 ff>;
-			clock-frequency = <3EF1480>;
-			interrupt-pci-iack = <0c34>;
-			interrupt-parent = <&/mv64x60/pic>;
-			interrupt-map-mask = <f800 0 0 7>;
+			reg = <0xcf8 0x8>;
+			ranges = <0x01000000 0x0        0x0
+					0x88000000 0x0 0x01000000
+				  0x02000000 0x0 0x80000000
+				  	0x80000000 0x0 0x08000000>;
+			bus-range = <0 255>;
+			clock-frequency = <66000000>;
+			interrupt-pci-iack = <0xc34>;
+			interrupt-parent = <&PIC>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 			interrupt-map = <
 				/* IDSEL 0x0a */
-				5000 0 0 1 &/mv64x60/pic 50
-				5000 0 0 2 &/mv64x60/pic 51
-				5000 0 0 3 &/mv64x60/pic 5b
-				5000 0 0 4 &/mv64x60/pic 5d
+				0x5000 0 0 1 &PIC 80
+				0x5000 0 0 2 &PIC 81
+				0x5000 0 0 3 &PIC 91
+				0x5000 0 0 4 &PIC 93
 
 				/* IDSEL 0x0b */
-				5800 0 0 1 &/mv64x60/pic 5b
-				5800 0 0 2 &/mv64x60/pic 5d
-				5800 0 0 3 &/mv64x60/pic 50
-				5800 0 0 4 &/mv64x60/pic 51
+				0x5800 0 0 1 &PIC 91
+				0x5800 0 0 2 &PIC 93
+				0x5800 0 0 3 &PIC 80
+				0x5800 0 0 4 &PIC 81
 
 				/* IDSEL 0x0c */
-				6000 0 0 1 &/mv64x60/pic 5b
-				6000 0 0 2 &/mv64x60/pic 5d
-				6000 0 0 3 &/mv64x60/pic 50
-				6000 0 0 4 &/mv64x60/pic 51
+				0x6000 0 0 1 &PIC 91
+				0x6000 0 0 2 &PIC 93
+				0x6000 0 0 3 &PIC 80
+				0x6000 0 0 4 &PIC 81
 
 				/* IDSEL 0x0d */
-				6800 0 0 1 &/mv64x60/pic 5d
-				6800 0 0 2 &/mv64x60/pic 50
-				6800 0 0 3 &/mv64x60/pic 51
-				6800 0 0 4 &/mv64x60/pic 5b
+				0x6800 0 0 1 &PIC 93
+				0x6800 0 0 2 &PIC 80
+				0x6800 0 0 3 &PIC 81
+				0x6800 0 0 4 &PIC 91
 			>;
 		};
 
 		cpu-error@0070 {
 			compatible = "mrvl,mv64x60-cpu-error";
-			reg = <0070 10 0128 28>;
-			interrupts = <03>;
-			interrupt-parent = <&/mv64x60/pic>;
+			reg = <0x70 0x10 0x128 0x28>;
+			interrupts = <3>;
+			interrupt-parent = <&PIC>;
 		};
 
 		sram-ctrl@0380 {
 			compatible = "mrvl,mv64x60-sram-ctrl";
-			reg = <0380 80>;
-			interrupts = <0d>;
-			interrupt-parent = <&/mv64x60/pic>;
+			reg = <0x380 0x80>;
+			interrupts = <13>;
+			interrupt-parent = <&PIC>;
 		};
 
 		pci-error@1d40 {
 			compatible = "mrvl,mv64x60-pci-error";
-			reg = <1d40 40 0c28 4>;
-			interrupts = <0c>;
-			interrupt-parent = <&/mv64x60/pic>;
+			reg = <0x1d40 0x40 0xc28 0x4>;
+			interrupts = <12>;
+			interrupt-parent = <&PIC>;
 		};
 
 		mem-ctrl@1400 {
 			compatible = "mrvl,mv64x60-mem-ctrl";
-			reg = <1400 60>;
-			interrupts = <11>;
-			interrupt-parent = <&/mv64x60/pic>;
+			reg = <0x1400 0x60>;
+			interrupts = <17>;
+			interrupt-parent = <&PIC>;
 		};
 	};
 
 	chosen {
 		bootargs = "ip=on";
-		linux,stdout-path = "/mv64x60@f1000000/mpsc@8000";
+		linux,stdout-path = &MPSC0;
 	};
 };
