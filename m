Return-Path: <mgreer@mvista.com>
Date: Wed, 25 Apr 2007 17:01:51 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 11/13] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070426000151.GM4046@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070425234630.GA4046@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 prpmc2800.dts |  322 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 322 insertions(+)

Index: powerpc/arch/powerpc/boot/dts/prpmc2800.dts
===================================================================
--- /dev/null
+++ powerpc/arch/powerpc/boot/dts/prpmc2800.dts
@@ -0,0 +1,322 @@
+/* Device Tree Source for Motorola PrPMC2800
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2007 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * To build:
+ *   dtc -I dts -O asm -o prpmc2800.S -V 16 -b 0 prpmc2800.dts
+ *   dtc -I dts -O dtb -o prpmc2800.dtb -V 16 -b 0 prpmc2800.dts
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	model = "PrPMC280/PrPMC2800"; /* Updated by bootwrapper */
+	compatible = "PrPMC2800";
+	coherency-off;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,7447 {
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <0>;		/* Set by bootwrapper */
+			bus-frequency = <7f28155>;	/* 133.333333 MHz */
+			timebase-frequency = <1fca055>;	/* 33.333333 MHz */
+			/* Following required by dtc but not used */
+			i-cache-line-size = <0>;
+			d-cache-line-size = <0>;
+			i-cache-size = <0>;
+			d-cache-size = <0>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 00000000>;	/* Set by bootwrapper */
+	};
+
+	mv64x60@f1000000 { /* Marvell Discovery */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <1>;
+		device_type = "mv64360";
+		compatible = "mv64x60";
+		clock-frequency = <7f28155>;		/* 133.333333 Mhz */
+		reg = <f1000000 00010000>;
+		virtual-reg = <f1000000>;
+		ranges = <88000000 88000000 01000000	/* PCI 0 I/O Space */
+			  80000000 80000000 08000000	/* PCI 0 MEM Space */
+			  a0000000 a0000000 04000000	/* User FLASH */
+			  00000000 f1000000 00010000	/* Bridge's regs */
+			  f2000000 f2000000 00040000>;	/* Integrated SRAM */
+
+		flash@a0000000 {
+			device_type = "rom";
+			compatible = "direct-mapped";
+			reg = <a0000000 0>; /* Size set by bootwrapper */
+			probe-type = "CFI";
+			bank-width = <4>;
+			partitions = <00000000 00100000 /* RO */
+				      00100000 00040001 /* RW */
+				      00140000 00400000 /* RO */
+				      00540000 039c0000 /* RO */
+				      03f00000 00100000>; /* RO */
+			partition-names = "FW Image A\0FW Config Data\0Kernel Image\0Filesystem\0FW Image B";
+		};
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "mv64x60-mdio";
+			ethernet-phy@1 {
+				device_type = "ethernet-phy";
+				compatible = "bcm5421";
+				interrupts = <4c>;	/* GPP 12 */
+				interrupt-parent = <&/mv64x60/pic>;
+				reg = <1>;
+			};
+			ethernet-phy@3 {
+				device_type = "ethernet-phy";
+				compatible = "bcm5421";
+				interrupts = <4c>;	/* GPP 12 */
+				interrupt-parent = <&/mv64x60/pic>;
+				reg = <3>;
+			};
+		};
+
+		ethernet@2000 {		/* mac-address set by bootwrapper */
+			reg = <2000 2000>;
+			eth0 {
+				device_type = "network";
+				compatible = "mv64x60-eth";
+				block-index = <0>;
+				interrupts = <20>;
+				interrupt-parent = <&/mv64x60/pic>;
+				phy = <&/mv64x60/mdio/ethernet-phy@1>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+			};
+			eth1 {
+				device_type = "network";
+				compatible = "mv64x60-eth";
+				block-index = <1>;
+				interrupts = <21>;
+				interrupt-parent = <&/mv64x60/pic>;
+				phy = <&/mv64x60/mdio/ethernet-phy@3>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+			};
+		};
+
+		sdma@4000 {
+			device_type = "dma";
+			compatible = "mv64x60-sdma";
+			reg = <4000 c18>;
+			virtual-reg = <f1004000>;
+			interrupt-base = <0>;
+			interrupts = <24>;
+			interrupt-parent = <&/mv64x60/pic>;
+		};
+
+		sdma@6000 {
+			device_type = "dma";
+			compatible = "mv64x60-sdma";
+			reg = <6000 c18>;
+			virtual-reg = <f1006000>;
+			interrupt-base = <0>;
+			interrupts = <26>;
+			interrupt-parent = <&/mv64x60/pic>;
+		};
+
+		brg@b200 {
+			device_type = "brg";
+			compatible = "mv64x60-brg";
+			reg = <b200 8>;
+			clock-src = <8>;
+			clock-frequency = <7ed6b40>;
+			current-speed = <2580>;
+			bcr = <0>;
+		};
+
+		brg@b208 {
+			device_type = "brg";
+			compatible = "mv64x60-brg";
+			reg = <b208 8>;
+			clock-src = <8>;
+			clock-frequency = <7ed6b40>;
+			current-speed = <2580>;
+			bcr = <0>;
+		};
+
+		cunit@f200 {
+			device_type = "mv64x60-cunit";
+			reg = <f200 200>;
+		};
+
+		mpscrouting@b400 {
+			device_type = "mpscrouting";
+			reg = <b400 c>;
+		};
+
+		mpscintr@b800 {
+			device_type = "mpscintr";
+			reg = <b800 100>;
+			virtual-reg = <f100b800>;
+		};
+
+		mpsc@8000 {
+			device_type = "serial";
+			compatible = "mpsc";
+			reg = <8000 38>;
+			virtual-reg = <f1008000>;
+			sdma = <&/mv64x60/sdma@4000>;
+			brg = <&/mv64x60/brg@b200>;
+			cunit = <&/mv64x60/cunit@f200>;
+			mpscrouting = <&/mv64x60/mpscrouting@b400>;
+			mpscintr = <&/mv64x60/mpscintr@b800>;
+			block-index = <0>;
+			max_idle = <28>;
+			chr_1 = <0>;
+			chr_2 = <0>;
+			chr_10 = <3>;
+			mpcr = <0>;
+			interrupts = <28>;
+			interrupt-parent = <&/mv64x60/pic>;
+		};
+
+		mpsc@9000 {
+			device_type = "serial";
+			compatible = "mpsc";
+			reg = <9000 38>;
+			virtual-reg = <f1009000>;
+			sdma = <&/mv64x60/sdma@6000>;
+			brg = <&/mv64x60/brg@b208>;
+			cunit = <&/mv64x60/cunit@f200>;
+			mpscrouting = <&/mv64x60/mpscrouting@b400>;
+			mpscintr = <&/mv64x60/mpscintr@b800>;
+			block-index = <1>;
+			max_idle = <28>;
+			chr_1 = <0>;
+			chr_2 = <0>;
+			chr_10 = <3>;
+			mpcr = <0>;
+			interrupts = <2a>;
+			interrupt-parent = <&/mv64x60/pic>;
+		};
+
+		i2c@c000 {
+			device_type = "i2c";
+			compatible = "mv64x60-i2c";
+			reg = <c000 20>;
+			virtual-reg = <f100c000>;
+			freq_m = <8>;
+			freq_n = <3>;
+			timeout = <3e8>;		/* 1000 = 1 second */
+			retries = <1>;
+			interrupts = <25>;
+			interrupt-parent = <&/mv64x60/pic>;
+		};
+
+		pic {
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			device_type = "mv64x60-pic";
+			compatible = "mv64x60-pic";
+			reg = <0000 88>;
+			interrupt-controller;
+		};
+
+		mpp@f000 {
+			device_type = "mv64x60-mpp";
+			compatible = "mv64x60-mpp";
+			reg = <f000 10>;
+		};
+
+		gpp@f100 {
+			device_type = "mv64x60-gpp";
+			compatible = "mv64x60-gpp";
+			reg = <f100 20>;
+		};
+
+		pci@80000000 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			compatible = "mv64x60-pci";
+			reg = <0cf8 8>;
+			ranges = <01000000 0        0 88000000 0 01000000
+				  02000000 0 80000000 80000000 0 08000000>;
+			bus-range = <0 ff>;
+			clock-frequency = <3EF1480>;
+			interrupt-pci-iack = <0c34>;
+			interrupt-parent = <&/mv64x60/pic>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0a */
+				5000 0 0 1 &/mv64x60/pic 50
+				5000 0 0 2 &/mv64x60/pic 51
+				5000 0 0 3 &/mv64x60/pic 5b
+				5000 0 0 4 &/mv64x60/pic 5d
+
+				/* IDSEL 0x0b */
+				5800 0 0 1 &/mv64x60/pic 5b
+				5800 0 0 2 &/mv64x60/pic 5d
+				5800 0 0 3 &/mv64x60/pic 50
+				5800 0 0 4 &/mv64x60/pic 51
+
+				/* IDSEL 0x0c */
+				6000 0 0 1 &/mv64x60/pic 5b
+				6000 0 0 2 &/mv64x60/pic 5d
+				6000 0 0 3 &/mv64x60/pic 50
+				6000 0 0 4 &/mv64x60/pic 51
+
+				/* IDSEL 0x0d */
+				6800 0 0 1 &/mv64x60/pic 5d
+				6800 0 0 2 &/mv64x60/pic 50
+				6800 0 0 3 &/mv64x60/pic 51
+				6800 0 0 4 &/mv64x60/pic 5b
+			>;
+		};
+
+		cpu-error@0070 {
+			device_type = "mv64x60-cpu-error";
+			reg = <0070 10 0128 28>;
+			interrupts = <03>;
+			interrupt-parent = <&/mv64x60/pic>;
+		};
+
+		sram-error@0380 {
+			device_type = "mv64x60-sram-error";
+			reg = <0380 80>;
+			interrupts = <0d>;
+			interrupt-parent = <&/mv64x60/pic>;
+		};
+
+		pci-error@1dc0 {
+			device_type = "mv64x60-pci-error";
+			reg = <1d40 40 0c28 4>;
+			interrupts = <0c>;
+			interrupt-parent = <&/mv64x60/pic>;
+		};
+
+		memctrl@1400 {
+			device_type = "mv64x60-memctrl";
+			reg = <1400 60>;
+			interrupts = <11>;
+			interrupt-parent = <&/mv64x60/pic>;
+		};
+	};
+
+	chosen {
+		linux,platform = <1>;
+		bootargs = "ip=on console=ttyMM0";
+		linux,stdout-path = "/mv64x60/mpsc@8000";
+	};
+};
