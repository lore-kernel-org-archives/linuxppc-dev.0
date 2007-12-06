Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 09E0ADDEBE
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 10:26:09 +1100 (EST)
Date: Thu, 6 Dec 2007 16:27:56 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: David Gibson <dgibson@ozlabs.org>
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
Message-ID: <20071206232756.GB4719@mag.az.mvista.com>
References: <20071129150726.GA13751@ru.mvista.com>
	<20071129152836.GB13751@ru.mvista.com>
	<20071203015018.GC26919@localhost.localdomain>
	<20071204021026.GB18903@mag.az.mvista.com>
	<20071204025032.GH32577@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204025032.GH32577@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David, et. al.,

This is a big blob patch of what I've changed for the prpmc2800.  It
includes the necessary changes in the kernel which you can probably
ignore but they're there for reference.  If you like the dts, then I'll
split the blob up into logical pieces and Andrei can make similar
changes for the Katana Qp.

Let me know what you think.

Mark
---
This patch is based on the latest powerpc.git tree
(44032af0e7d5467b12f998dbf2f1cd23c5324fd5) with the following patches
applied:

http://patchwork.ozlabs.org/linuxppc/patch?id=14339
http://patchwork.ozlabs.org/linuxppc/patch?id=14397
http://patchwork.ozlabs.org/linuxppc/patch?id=14396
http://patchwork.ozlabs.org/linuxppc/patch?id=14631
http://patchwork.ozlabs.org/linuxppc/patch?id=14632
http://patchwork.ozlabs.org/linuxppc/patch?id=14633
http://patchwork.ozlabs.org/linuxppc/patch?id=15007

 arch/powerpc/boot/dts/prpmc2800.dts            |  320 +++++++--------
 arch/powerpc/boot/mpsc.c                       |    2 
 arch/powerpc/boot/serial.c                     |    2 
 arch/powerpc/platforms/embedded6xx/prpmc2800.c |    4 
 arch/powerpc/sysdev/mv64x60_dev.c              |   29 -
 arch/powerpc/sysdev/mv64x60_pci.c              |    6 
 arch/powerpc/sysdev/mv64x60_pic.c              |    4 
 arch/powerpc/sysdev/mv64x60_udbg.c             |    4 
 8 files changed, 181 insertions(+), 190 deletions(-)


diff --git a/arch/powerpc/boot/dts/prpmc2800.dts b/arch/powerpc/boot/dts/prpmc2800.dts
index 24944ca..080130e 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -11,6 +11,8 @@
  * if it can determine the exact PrPMC type.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -25,64 +27,64 @@
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
+			clock-frequency = <733333333>;	/* Default */
+			bus-frequency = <133333333>;
+			timebase-frequency = <33333333>;
+			i-cache-line-size = <0x20>;
+			d-cache-line-size = <0x20>;
+			i-cache-size = <0x8000>;
+			d-cache-size = <0x8000>;
 		};
 	};
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 20000000>;	/* Default (512MB) */
+		reg = <0x00000000 0x20000000>;	/* Default (512MB) */
 	};
 
 	mv64x60@f1000000 { /* Marvell Discovery */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		model = "mv64360";			/* Default */
-		compatible = "marvell,mv64x60";
-		clock-frequency = <7f28155>;		/* 133.333333 MHz */
-		reg = <f1000000 00010000>;
-		virtual-reg = <f1000000>;
-		ranges = <88000000 88000000 01000000	/* PCI 0 I/O Space */
-			  80000000 80000000 08000000	/* PCI 0 MEM Space */
-			  a0000000 a0000000 04000000	/* User FLASH */
-			  00000000 f1000000 00010000	/* Bridge's regs */
-			  f2000000 f2000000 00040000>;	/* Integrated SRAM */
+		compatible = "marvell,mv64360";
+		clock-frequency = <133333333>;
+		reg = <0xf1000000 0x00010000>;
+		virtual-reg = <0xf1000000>;
+		ranges = <0x88000000 0x88000000 0x01000000 /* PCI 0 I/O Space */
+			  0x80000000 0x80000000 0x08000000 /* PCI 0 MEM Space */
+			  0xa0000000 0xa0000000 0x04000000 /* User FLASH */
+			  0x00000000 0xf1000000 0x00010000 /* Bridge's regs */
+			  0xf2000000 0xf2000000 0x00040000>;/* Integrated SRAM*/
 
 		flash@a0000000 {
 			compatible = "cfi-flash";
-			reg = <a0000000 04000000>;
+			reg = <0xa0000000 0x04000000>;
 			bank-width = <4>;
 			device-width = <2>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			fw@0 {
 				label = "FW Image A";
-				reg = <00000000 00100000>;
+				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
 			cfg@100000 {
 				label = "FW Config Data";	/* RW */
-				reg = <00100000 00040000>;
+				reg = <0x00100000 0x00040000>;
 			};
 			kernel@140000 {
 				label = "Kernel Image";
-				reg = <00140000 00400000>;
+				reg = <0x00140000 0x00400000>;
 				read-only;
 			};
 			fs@540000 {
 				label = "Filesystem";
-				reg = <00540000 039c0000>;
+				reg = <0x00540000 0x039c0000>;
 				read-only;
 			};
 			fw@3f00000 {
 				label = "FW Image B";
-				reg = <03f00000 00100000>;
+				reg = <0x03f00000 0x00100000>;
 				read-only;
 			};
 		};
@@ -91,171 +93,167 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "mdio";
-			compatible = "marvell,mv64x60-mdio";
-			ethernet-phy@1 {
+			compatible = "marvell,mv64360-mdio";
+			phy0: ethernet-phy@1 {
 				device_type = "ethernet-phy";
 				compatible = "broadcom,bcm5421";
-				interrupts = <4c>;	/* GPP 12 */
-				interrupt-parent = <&/mv64x60/pic>;
+				interrupts = <76>;	/* GPP 12 */
+				interrupt-parent = <&pic>;
 				reg = <1>;
 			};
-			ethernet-phy@3 {
+			phy1: ethernet-phy@3 {
 				device_type = "ethernet-phy";
 				compatible = "broadcom,bcm5421";
-				interrupts = <4c>;	/* GPP 12 */
-				interrupt-parent = <&/mv64x60/pic>;
+				interrupts = <76>;	/* GPP 12 */
+				interrupt-parent = <&pic>;
 				reg = <3>;
 			};
 		};
 
-		ethernet@2000 {
-			reg = <2000 2000>;
-			eth0 {
+		multiethernet@2000 {
+			reg = <0x2000 0x2000>;
+			ethernet@0 {
 				device_type = "network";
-				compatible = "marvell,mv64x60-eth";
-				block-index = <0>;
-				interrupts = <20>;
-				interrupt-parent = <&/mv64x60/pic>;
-				phy = <&/mv64x60/mdio/ethernet-phy@1>;
+				compatible = "marvell,mv64360-eth";
+				reg = <0>;
+				interrupts = <32>;
+				interrupt-parent = <&pic>;
+				phy = <&phy0>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
 			};
-			eth1 {
+			ethernet@1 {
 				device_type = "network";
-				compatible = "marvell,mv64x60-eth";
-				block-index = <1>;
-				interrupts = <21>;
-				interrupt-parent = <&/mv64x60/pic>;
-				phy = <&/mv64x60/mdio/ethernet-phy@3>;
+				compatible = "marvell,mv64360-eth";
+				reg = <1>;
+				interrupts = <33>;
+				interrupt-parent = <&pic>;
+				phy = <&phy1>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
 			};
 		};
 
-		sdma@4000 {
-			device_type = "dma";
-			compatible = "marvell,mv64x60-sdma";
-			reg = <4000 c18>;
-			virtual-reg = <f1004000>;
+		sdma0: sdma@4000 {
+			compatible = "marvell,mv64360-sdma";
+			reg = <0x4000 0xc18>;
+			virtual-reg = <0xf1004000>;
 			interrupt-base = <0>;
-			interrupts = <24>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupts = <36>;
+			interrupt-parent = <&pic>;
 		};
 
-		sdma@6000 {
-			device_type = "dma";
-			compatible = "marvell,mv64x60-sdma";
-			reg = <6000 c18>;
-			virtual-reg = <f1006000>;
+		sdma1: sdma@6000 {
+			compatible = "marvell,mv64360-sdma";
+			reg = <0x6000 0xc18>;
+			virtual-reg = <0xf1006000>;
 			interrupt-base = <0>;
-			interrupts = <26>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupts = <38>;
+			interrupt-parent = <&pic>;
 		};
 
-		brg@b200 {
-			compatible = "marvell,mv64x60-brg";
-			reg = <b200 8>;
+		brg0: brg@b200 {
+			compatible = "marvell,mv64360-brg";
+			reg = <0xb200 0x8>;
 			clock-src = <8>;
-			clock-frequency = <7ed6b40>;
-			current-speed = <2580>;
+			clock-frequency = <133000000>;
+			current-speed = <9600>;
 			bcr = <0>;
 		};
 
-		brg@b208 {
-			compatible = "marvell,mv64x60-brg";
-			reg = <b208 8>;
+		brg1: brg@b208 {
+			compatible = "marvell,mv64360-brg";
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
+		cunit: cunit@f200 {
+			reg = <0xf200 0x200>;
 		};
 
-		mpscrouting@b400 {
-			reg = <b400 c>;
+		mpscrouting: mpscrouting@b400 {
+			reg = <0xb400 0xc>;
 		};
 
-		mpscintr@b800 {
-			reg = <b800 100>;
-			virtual-reg = <f100b800>;
+		mpscintr: mpscintr@b800 {
+			reg = <0xb800 0x100>;
+			virtual-reg = <0xf100b800>;
 		};
 
-		mpsc@8000 {
+		mpsc0: mpsc@8000 {
 			device_type = "serial";
-			compatible = "marvell,mpsc";
-			reg = <8000 38>;
-			virtual-reg = <f1008000>;
-			sdma = <&/mv64x60/sdma@4000>;
-			brg = <&/mv64x60/brg@b200>;
-			cunit = <&/mv64x60/cunit@f200>;
-			mpscrouting = <&/mv64x60/mpscrouting@b400>;
-			mpscintr = <&/mv64x60/mpscintr@b800>;
-			block-index = <0>;
-			max_idle = <28>;
+			compatible = "marvell,mv64360-mpsc";
+			reg = <0x8000 0x38>;
+			virtual-reg = <0xf1008000>;
+			sdma = <&sdma0>;
+			brg = <&brg0>;
+			cunit = <&cunit>;
+			mpscrouting = <&mpscrouting>;
+			mpscintr = <&mpscintr>;
+			cell-index = <0>;
+			max_idle = <40>;
 			chr_1 = <0>;
 			chr_2 = <0>;
 			chr_10 = <3>;
 			mpcr = <0>;
-			interrupts = <28>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupts = <40>;
+			interrupt-parent = <&pic>;
 		};
 
-		mpsc@9000 {
+		mpsc1: mpsc@9000 {
 			device_type = "serial";
-			compatible = "marvell,mpsc";
-			reg = <9000 38>;
-			virtual-reg = <f1009000>;
-			sdma = <&/mv64x60/sdma@6000>;
-			brg = <&/mv64x60/brg@b208>;
-			cunit = <&/mv64x60/cunit@f200>;
-			mpscrouting = <&/mv64x60/mpscrouting@b400>;
-			mpscintr = <&/mv64x60/mpscintr@b800>;
-			block-index = <1>;
-			max_idle = <28>;
+			compatible = "marvell,mv64360-mpsc";
+			reg = <0x9000 0x38>;
+			virtual-reg = <0xf1009000>;
+			sdma = <&sdma1>;
+			brg = <&brg1>;
+			cunit = <&cunit>;
+			mpscrouting = <&mpscrouting>;
+			mpscintr = <&mpscintr>;
+			cell-index = <1>;
+			max_idle = <40>;
 			chr_1 = <0>;
 			chr_2 = <0>;
 			chr_10 = <3>;
 			mpcr = <0>;
-			interrupts = <2a>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupts = <42>;
+			interrupt-parent = <&pic>;
 		};
 
 		wdt@b410 {			/* watchdog timer */
-			compatible = "marvell,mv64x60-wdt";
-			reg = <b410 8>;
-			timeout = <a>;		/* wdt timeout in seconds */
+			compatible = "marvell,mv64360-wdt";
+			reg = <0xb410 0x8>;
 		};
 
 		i2c@c000 {
 			device_type = "i2c";
-			compatible = "marvell,mv64x60-i2c";
-			reg = <c000 20>;
-			virtual-reg = <f100c000>;
+			compatible = "marvell,mv64360-i2c";
+			reg = <0xc000 0x20>;
+			virtual-reg = <0xf100c000>;
 			freq_m = <8>;
 			freq_n = <3>;
-			timeout = <3e8>;		/* 1000 = 1 second */
 			retries = <1>;
-			interrupts = <25>;
-			interrupt-parent = <&/mv64x60/pic>;
+			interrupts = <37>;
+			interrupt-parent = <&pic>;
 		};
 
-		pic {
+		pic: pic@0 {
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
-			compatible = "marvell,mv64x60-pic";
-			reg = <0000 88>;
+			compatible = "marvell,mv64360-pic";
+			reg = <0x0000 0x88>;
 			interrupt-controller;
 		};
 
 		mpp@f000 {
-			compatible = "marvell,mv64x60-mpp";
-			reg = <f000 10>;
+			compatible = "marvell,mv64360-mpp";
+			reg = <0xf000 0x10>;
 		};
 
 		gpp@f100 {
-			compatible = "marvell,mv64x60-gpp";
-			reg = <f100 20>;
+			compatible = "marvell,mv64360-gpp";
+			reg = <0xf100 0x20>;
 		};
 
 		pci@80000000 {
@@ -263,68 +261,70 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			device_type = "pci";
-			compatible = "marvell,mv64x60-pci";
-			reg = <0cf8 8>;
-			ranges = <01000000 0        0 88000000 0 01000000
-				  02000000 0 80000000 80000000 0 08000000>;
-			bus-range = <0 ff>;
-			clock-frequency = <3EF1480>;
-			interrupt-pci-iack = <0c34>;
-			interrupt-parent = <&/mv64x60/pic>;
-			interrupt-map-mask = <f800 0 0 7>;
+			compatible = "marvell,mv64360-pci";
+			reg = <0x0cf8 0x8>;
+			ranges = <0x01000000 0x0        0x0
+					0x88000000 0x0 0x01000000
+				  0x02000000 0x0 0x80000000
+					0x80000000 0x0 0x08000000>;
+			bus-range = <0x0 0xff>;
+			clock-frequency = <66000000>;
+			interrupt-pci-iack = <0x0c34>;
+			interrupt-parent = <&pic>;
+			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map = <
 				/* IDSEL 0x0a */
-				5000 0 0 1 &/mv64x60/pic 50
-				5000 0 0 2 &/mv64x60/pic 51
-				5000 0 0 3 &/mv64x60/pic 5b
-				5000 0 0 4 &/mv64x60/pic 5d
+				0x5000 0 0 1 &pic 80
+				0x5000 0 0 2 &pic 81
+				0x5000 0 0 3 &pic 91
+				0x5000 0 0 4 &pic 93
 
 				/* IDSEL 0x0b */
-				5800 0 0 1 &/mv64x60/pic 5b
-				5800 0 0 2 &/mv64x60/pic 5d
-				5800 0 0 3 &/mv64x60/pic 50
-				5800 0 0 4 &/mv64x60/pic 51
+				0x5800 0 0 1 &pic 91
+				0x5800 0 0 2 &pic 93
+				0x5800 0 0 3 &pic 80
+				0x5800 0 0 4 &pic 81
 
 				/* IDSEL 0x0c */
-				6000 0 0 1 &/mv64x60/pic 5b
-				6000 0 0 2 &/mv64x60/pic 5d
-				6000 0 0 3 &/mv64x60/pic 50
-				6000 0 0 4 &/mv64x60/pic 51
+				0x6000 0 0 1 &pic 91
+				0x6000 0 0 2 &pic 93
+				0x6000 0 0 3 &pic 80
+				0x6000 0 0 4 &pic 81
 
 				/* IDSEL 0x0d */
-				6800 0 0 1 &/mv64x60/pic 5d
-				6800 0 0 2 &/mv64x60/pic 50
-				6800 0 0 3 &/mv64x60/pic 51
-				6800 0 0 4 &/mv64x60/pic 5b
+				0x6800 0 0 1 &pic 93
+				0x6800 0 0 2 &pic 80
+				0x6800 0 0 3 &pic 81
+				0x6800 0 0 4 &pic 91
 			>;
 		};
 
-		cpu-error@0070 {
-			compatible = "marvell,mv64x60-cpu-error";
-			reg = <0070 10 0128 28>;
-			interrupts = <03>;
-			interrupt-parent = <&/mv64x60/pic>;
+		cpu-error@70 {
+			compatible = "marvell,mv64360-cpu-error";
+			reg = <0x0070 0x10 0x0128 0x28>;
+			interrupts = <3>;
+			interrupt-parent = <&pic>;
 		};
 
-		sram-ctrl@0380 {
-			compatible = "marvell,mv64x60-sram-ctrl";
-			reg = <0380 80>;
-			interrupts = <0d>;
-			interrupt-parent = <&/mv64x60/pic>;
+		sram-ctrl@380 {
+			compatible = "marvell,mv64360-sram-ctrl";
+			reg = <0x0380 0x80>;
+			interrupts = <13>;
+			interrupt-parent = <&pic>;
 		};
 
 		pci-error@1d40 {
-			compatible = "marvell,mv64x60-pci-error";
-			reg = <1d40 40 0c28 4>;
-			interrupts = <0c>;
-			interrupt-parent = <&/mv64x60/pic>;
+			compatible = "marvell,mv64360-pci-error";
+			reg = <0x1d40 0x40 0x0c28 0x4>;
+			interrupts = <12>;
+			interrupt-parent = <&pic>;
 		};
 
 		mem-ctrl@1400 {
-			compatible = "marvell,mv64x60-mem-ctrl";
-			reg = <1400 60>;
-			interrupts = <11>;
-			interrupt-parent = <&/mv64x60/pic>;
+			compatible = "marvell,mv64360-mem-ctrl";
+			reg = <0x1400 0x60>;
+			interrupts = <17>;
+			interrupt-parent = <&pic>;
 		};
 	};
 
diff --git a/arch/powerpc/boot/mpsc.c b/arch/powerpc/boot/mpsc.c
index 802ea53..425ad88 100644
--- a/arch/powerpc/boot/mpsc.c
+++ b/arch/powerpc/boot/mpsc.c
@@ -141,7 +141,7 @@ int mpsc_console_init(void *devp, struct serial_console_data *scdp)
 	if (mpscintr_base == NULL)
 		goto err_out;
 
-	n = getprop(devp, "block-index", &v, sizeof(v));
+	n = getprop(devp, "cell-index", &v, sizeof(v));
 	if (n != sizeof(v))
 		goto err_out;
 	reg_set = (int)v;
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index cafeece..cbcbb20 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -119,7 +119,7 @@ int serial_console_init(void)
 
 	if (dt_is_compatible(devp, "ns16550"))
 		rc = ns16550_console_init(devp, &serial_cd);
-	else if (dt_is_compatible(devp, "marvell,mpsc"))
+	else if (dt_is_compatible(devp, "marvell,mv64360-mpsc"))
 		rc = mpsc_console_init(devp, &serial_cd);
 	else if (dt_is_compatible(devp, "fsl,cpm1-scc-uart") ||
 	         dt_is_compatible(devp, "fsl,cpm1-smc-uart") ||
diff --git a/arch/powerpc/platforms/embedded6xx/prpmc2800.c b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
index a01e219..1a1baf9 100644
--- a/arch/powerpc/platforms/embedded6xx/prpmc2800.c
+++ b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
@@ -50,13 +50,13 @@ static void __init prpmc2800_setup_arch(void)
 	 * ioremap mpp and gpp registers in case they are later
 	 * needed by prpmc2800_reset_board().
 	 */
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-mpp");
+	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360-mpp");
 	reg = of_get_property(np, "reg", NULL);
 	paddr = of_translate_address(np, reg);
 	of_node_put(np);
 	mv64x60_mpp_reg_base = ioremap(paddr, reg[1]);
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-gpp");
+	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360-gpp");
 	reg = of_get_property(np, "reg", NULL);
 	paddr = of_translate_address(np, reg);
 	of_node_put(np);
diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index 304056c..aac28ee 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -127,7 +127,7 @@ static int __init mv64x60_mpsc_device_setup(struct device_node *np, int id)
 	if (err)
 		return err;
 
-	prop = of_get_property(np, "block-index", NULL);
+	prop = of_get_property(np, "cell-index", NULL);
 	if (!prop)
 		return -ENODEV;
 	port_number = *(int *)prop;
@@ -248,7 +248,7 @@ static int __init mv64x60_eth_device_setup(struct device_node *np, int id)
 
 	memset(&pdata, 0, sizeof(pdata));
 
-	prop = of_get_property(np, "block-index", NULL);
+	prop = of_get_property(np, "reg", NULL);
 	if (!prop)
 		return -ENODEV;
 	pdata.port_number = *prop;
@@ -344,6 +344,7 @@ static int __init mv64x60_i2c_device_setup(struct device_node *np, int id)
 	of_irq_to_resource(np, 0, &r[1]);
 
 	memset(&pdata, 0, sizeof(pdata));
+	pdata.timeout = 1000;	/* Default: 1 second */
 
 	prop = of_get_property(np, "freq_m", NULL);
 	if (!prop)
@@ -355,12 +356,6 @@ static int __init mv64x60_i2c_device_setup(struct device_node *np, int id)
 		return -ENODEV;
 	pdata.freq_n = *prop;
 
-	prop = of_get_property(np, "timeout", NULL);
-	if (prop)
-		pdata.timeout = *prop;
-	else
-		pdata.timeout = 1000;	/* 1 second */
-
 	prop = of_get_property(np, "retries", NULL);
 	if (prop)
 		pdata.retries = *prop;
@@ -406,11 +401,7 @@ static int __init mv64x60_wdt_device_setup(struct device_node *np, int id)
 		return err;
 
 	memset(&pdata, 0, sizeof(pdata));
-
-	prop = of_get_property(np, "timeout", NULL);
-	if (!prop)
-		return -ENODEV;
-	pdata.timeout = *prop;
+	pdata.timeout = 10;	/* Default: 10 seconds */
 
 	np = of_get_parent(np);
 	if (!np)
@@ -452,22 +443,22 @@ static int __init mv64x60_device_setup(void)
 	int err;
 
 	id = 0;
-	for_each_compatible_node(np, "serial", "marvell,mpsc")
+	for_each_compatible_node(np, "serial", "marvell,mv64360-mpsc")
 		if ((err = mv64x60_mpsc_device_setup(np, id++)))
 			goto error;
 
 	id = 0;
-	for_each_compatible_node(np, "network", "marvell,mv64x60-eth")
+	for_each_compatible_node(np, "network", "marvell,mv64360-eth")
 		if ((err = mv64x60_eth_device_setup(np, id++)))
 			goto error;
 
 	id = 0;
-	for_each_compatible_node(np, "i2c", "marvell,mv64x60-i2c")
+	for_each_compatible_node(np, "i2c", "marvell,mv64360-i2c")
 		if ((err = mv64x60_i2c_device_setup(np, id++)))
 			goto error;
 
 	/* support up to one watchdog timer */
-	np = of_find_compatible_node(np, NULL, "marvell,mv64x60-wdt");
+	np = of_find_compatible_node(np, NULL, "marvell,mv64360-wdt");
 	if (np) {
 		if ((err = mv64x60_wdt_device_setup(np, id)))
 			goto error;
@@ -495,10 +486,10 @@ static int __init mv64x60_add_mpsc_console(void)
 	if (!np)
 		goto not_mpsc;
 
-	if (!of_device_is_compatible(np, "marvell,mpsc"))
+	if (!of_device_is_compatible(np, "marvell,mv64360-mpsc"))
 		goto not_mpsc;
 
-	prop = of_get_property(np, "block-index", NULL);
+	prop = of_get_property(np, "cell-index", NULL);
 	if (!prop)
 		goto not_mpsc;
 
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index d21ab8f..1456015 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -86,14 +86,14 @@ static int __init mv64x60_sysfs_init(void)
 	struct platform_device *pdev;
 	const unsigned int *prop;
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60");
+	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360");
 	if (!np)
 		return 0;
 
 	prop = of_get_property(np, "hs_reg_valid", NULL);
 	of_node_put(np);
 
-	pdev = platform_device_register_simple("marvell,mv64x60", 0, NULL, 0);
+	pdev = platform_device_register_simple("marvell,mv64360", 0, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
@@ -166,6 +166,6 @@ void __init mv64x60_pci_init(void)
 {
 	struct device_node *np;
 
-	for_each_compatible_node(np, "pci", "marvell,mv64x60-pci")
+	for_each_compatible_node(np, "pci", "marvell,mv64360-pci")
 		mv64x60_add_bridge(np);
 }
diff --git a/arch/powerpc/sysdev/mv64x60_pic.c b/arch/powerpc/sysdev/mv64x60_pic.c
index 19e6ef2..2aa4ed0 100644
--- a/arch/powerpc/sysdev/mv64x60_pic.c
+++ b/arch/powerpc/sysdev/mv64x60_pic.c
@@ -238,13 +238,13 @@ void __init mv64x60_init_irq(void)
 	const unsigned int *reg;
 	unsigned long flags;
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-gpp");
+	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360-gpp");
 	reg = of_get_property(np, "reg", &size);
 	paddr = of_translate_address(np, reg);
 	mv64x60_gpp_reg_base = ioremap(paddr, reg[1]);
 	of_node_put(np);
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-pic");
+	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360-pic");
 	reg = of_get_property(np, "reg", &size);
 	paddr = of_translate_address(np, reg);
 	mv64x60_irq_reg_base = ioremap(paddr, reg[1]);
diff --git a/arch/powerpc/sysdev/mv64x60_udbg.c b/arch/powerpc/sysdev/mv64x60_udbg.c
index 35c77c7..2792dc8 100644
--- a/arch/powerpc/sysdev/mv64x60_udbg.c
+++ b/arch/powerpc/sysdev/mv64x60_udbg.c
@@ -85,7 +85,7 @@ static void mv64x60_udbg_init(void)
 	if (!stdout)
 		return;
 
-	for_each_compatible_node(np, "serial", "marvell,mpsc") {
+	for_each_compatible_node(np, "serial", "marvell,mv64360-mpsc") {
 		if (np == stdout)
 			break;
 	}
@@ -94,7 +94,7 @@ static void mv64x60_udbg_init(void)
 	if (!np)
 		return;
 
-	block_index = of_get_property(np, "block-index", NULL);
+	block_index = of_get_property(np, "cell-index", NULL);
 	if (!block_index)
 		goto error;
 
