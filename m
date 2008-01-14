Return-Path: <mgreer@mvista.com>
Date: Mon, 14 Jan 2008 15:59:26 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: [PATCH 3/4] powerpc: Katana750i - Add DTS file
Message-ID: <20080114225926.GB22862@mag.az.mvista.com>
References: <20080114225150.GB21940@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080114225150.GB21940@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Add DTS file for the Emerson Katana 750i & 752i platforms.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/boot/dts/katana750i.dts |  372 +++++++++++++++++++++++++
 1 file changed, 372 insertions(+)

diff --git a/arch/powerpc/boot/dts/katana750i.dts b/arch/powerpc/boot/dts/katana750i.dts
new file mode 100644
index 0000000..03d9fd1
--- /dev/null
+++ b/arch/powerpc/boot/dts/katana750i.dts
@@ -0,0 +1,372 @@
+/* Device Tree Source for Emerson Katana 750i/752i
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2007 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Property values that are labeled as "Default" will be updated by bootwrapper
+ * if it can determine the exact PrPMC type.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	model = "Katana-75xi";	/* Default */
+	compatible = "emerson,katana-750i";
+	coherency-off;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,750 {
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <733333333>;		/* Default */
+			bus-frequency = <133333333>;		/* Default */
+			timebase-frequency = <33333333>;	/* Default */
+			i-cache-line-size = <0x20>;
+			d-cache-line-size = <0x20>;
+			i-cache-size = <0x8000>;
+			d-cache-size = <0x8000>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x04000000>;	/* Default (64MB) */
+	};
+
+	mv64x60@f8100000 { /* Marvell Discovery */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		model = "mv64360";	/* Default */
+		compatible = "marvell,mv64360";
+		clock-frequency = <133333333>;
+		hs_reg_valid;
+		reg = <0xf8100000 0x00010000>;
+		virtual-reg = <0xf8100000>;
+		ranges = <0xb0000000 0xb0000000 0x04000000 /* PCI 1 I/O Space */
+			  0x80000000 0x80000000 0x30000000 /* PCI 1 MEM Space */
+			  0xe8000000 0xe8000000 0x10000000 /* User FLASH */
+			  0x00000000 0xf8100000 0x00010000 /* Bridge's regs */
+			  0xf8080000 0xf8080000 0x00010000 /* PCI 0 I/O Space */
+			  0xf8090000 0xf8090000 0x00010000 /* PCI 0 MEM Space */
+			  0xf8200000 0xf8200000 0x00200000 /* CPLD & HSL Regs */
+			  0xf8300000 0xf8300000 0x00040000>;/* Integrated SRAM*/
+
+		cpld@f8200000 {
+			compatible = "katana750i,cpld";
+			reg = <0xf8200000 0x00200000>;
+			virtual-reg = <0xf8200000>;
+		};
+
+		flash@e8000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			bank-width = <4>;
+			device-width = <2>;
+			reg = <0xe8000000 0x04000000>;
+			monitor@0 {
+				label = "Monitor";
+				reg = <0x00000000 0x00100000>;
+			};
+			pkernel@100000 {
+				label = "Primary Kernel";
+				reg = <0x00100000 0x00180000>;
+			};
+			pfs@280000 {
+				label = "Primary Filesystem";
+				reg = <0x00280000 0x01e00000>;
+			};
+			skernel@2080000 {
+				label = "Secondary Kernel";
+				reg = <0x02080000 0x00180000>;
+			};
+			sfs@2200000 {
+				label = "Secondary Filesystem";
+				reg = <0x02200000 0x01e00000>;
+			};
+			user@100000 { /* overlay all but monitor */
+				label = "User FLASH";
+				reg = <0x00100000 0x03f00000>;
+			};
+		};
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "marvell,mv64360-mdio";
+			PHY0: ethernet-phy@12 {
+				device_type = "ethernet-phy";
+				compatible = "broadcom,bcm5461";
+				reg = <12>;
+			};
+			PHY1: ethernet-phy@11 {
+				device_type = "ethernet-phy";
+				compatible = "broadcom,bcm5461";
+				reg = <11>;
+			};
+			PHY2: ethernet-phy@4 {
+				device_type = "ethernet-phy";
+				compatible = "broadcom,bcm5461";
+				reg = <4>;
+			};
+		};
+
+		multiethernet@2000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2000 0x2000>;
+			ethernet@0 {
+				device_type = "network";
+				compatible = "marvell,mv64360-eth";
+				reg = <0>;
+				interrupts = <32>;
+				interrupt-parent = <&PIC>;
+				phy = <&PHY0>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+			};
+			ethernet@1 {
+				device_type = "network";
+				compatible = "marvell,mv64360-eth";
+				reg = <1>;
+				interrupts = <33>;
+				interrupt-parent = <&PIC>;
+				phy = <&PHY1>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+			};
+			ethernet@2 {
+				device_type = "network";
+				compatible = "marvell,mv64360-eth";
+				reg = <2>;
+				interrupts = <34>;
+				interrupt-parent = <&PIC>;
+				phy = <&PHY2>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+			};
+		};
+
+		SDMA0: sdma@4000 {
+			compatible = "marvell,mv64360-sdma";
+			reg = <0x4000 0xc18>;
+			virtual-reg = <0xf8104000>;
+			interrupt-base = <0>;
+			interrupts = <36>;
+			interrupt-parent = <&PIC>;
+		};
+
+		SDMA1: sdma@6000 {
+			compatible = "marvell,mv64360-sdma";
+			reg = <0x6000 0xc18>;
+			virtual-reg = <0xf8106000>;
+			interrupt-base = <0>;
+			interrupts = <38>;
+			interrupt-parent = <&PIC>;
+		};
+
+		BRG0: brg@b200 {
+			compatible = "marvell,mv64360-brg";
+			reg = <0xb200 0x8>;
+			clock-src = <8>;
+			clock-frequency = <133333333>;
+			current-speed = <9600>;
+			bcr = <0>;
+		};
+
+		BRG1: brg@b208 {
+			compatible = "marvell,mv64360-brg";
+			reg = <0xb208 0x8>;
+			clock-src = <8>;
+			clock-frequency = <133333333>;
+			current-speed = <9600>;
+			bcr = <0>;
+		};
+
+		CUNIT: cunit@f200 {
+			reg = <0xf200 0x200>;
+		};
+
+		MPSCROUTING: mpscrouting@b400 {
+			reg = <0xb400 0xc>;
+		};
+
+		MPSCINTR: mpscintr@b800 {
+			reg = <0xb800 0x100>;
+			virtual-reg = <0xf810b800>;
+		};
+
+		mpsc@8000 {
+			device_type = "serial";
+			compatible = "marvell,mv64360-mpsc";
+			reg = <0x8000 0x38>;
+			virtual-reg = <0xf8108000>;
+			sdma = <&SDMA0>;
+			brg = <&BRG0>;
+			cunit = <&CUNIT>;
+			mpscrouting = <&MPSCROUTING>;
+			mpscintr = <&MPSCINTR>;
+			cell-index = <0>;
+			max_idle = <40>;
+			chr_1 = <0>;
+			chr_2 = <0>;
+			chr_10 = <3>;
+			mpcr = <0>;
+			interrupts = <40>;
+			interrupt-parent = <&PIC>;
+		};
+
+		mpsc@9000 {
+			device_type = "serial";
+			compatible = "marvell,mv64360-mpsc";
+			reg = <0x9000 0x38>;
+			virtual-reg = <0xf8109000>;
+			sdma = <&SDMA1>;
+			brg = <&BRG1>;
+			cunit = <&CUNIT>;
+			mpscrouting = <&MPSCROUTING>;
+			mpscintr = <&MPSCINTR>;
+			cell-index = <1>;
+			max_idle = <40>;
+			chr_1 = <0>;
+			chr_2 = <0>;
+			chr_10 = <3>;
+			mpcr = <0>;
+			interrupts = <42>;
+			interrupt-parent = <&PIC>;
+		};
+
+		wdt@b410 {			/* watchdog timer */
+			compatible = "marvell,mv64360-wdt";
+			reg = <0xb410 0x8>;
+		};
+
+		i2c@c000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "i2c";
+			compatible = "marvell,mv64360-i2c";
+			reg = <0xc000 0x20>;
+			virtual-reg = <0xf810c000>;
+			freq_m = <8>;
+			freq_n = <3>;
+			interrupts = <37>;
+			interrupt-parent = <&PIC>;
+			rtc@68 {
+				compatible = "dallas,ds1307";
+				reg = <0x68>;
+			};
+		};
+
+		PIC: pic {
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			compatible = "marvell,mv64360-pic";
+			reg = <0x0000 0x88>;
+			interrupt-controller;
+		};
+
+		mpp@f000 {
+			compatible = "marvell,mv64360-mpp";
+			reg = <0xf000 0x10>;
+		};
+
+		gpp@f100 {
+			compatible = "marvell,mv64360-gpp";
+			reg = <0xf100 0x20>;
+		};
+
+		pci@80000000 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			compatible = "marvell,mv64360-pci";
+			cell-index = <1>;
+			reg = <0x0c78 0x8>;
+			ranges = <0x01000000 0x0 0x0
+					0xb0000000 0x0 0x04000000
+				  0x02000000 0x0 0x80000000
+					0x80000000 0x0 0x30000000>;
+			bus-range = <0x0 0xff>;
+			clock-frequency = <66000000>;
+			interrupt-pci-iack = <0x0cb4>;
+			interrupt-parent = <&PIC>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+			interrupt-map = <
+				/* IDSEL 0x04 - PMC 1 */
+				0x2000 0 0 1 &PIC 73
+				0x2000 0 0 2 &PIC 74
+				0x2000 0 0 3 &PIC 78
+				0x2000 0 0 4 &PIC 72
+
+				/* IDSEL 0x05 - PMC 2 */
+				0x2800 0 0 1 &PIC 74
+				0x2800 0 0 2 &PIC 78
+				0x2800 0 0 3 &PIC 72
+				0x2800 0 0 4 &PIC 73
+
+				/* IDSEL 0x06 - T8110 */
+				0x3000 0 0 1 &PIC 78
+
+				/* IDSEL 0x08 - i82544 */
+				0x4000 0 0 1 &PIC 78
+			>;
+		};
+
+		pci@f8080000 { /* Required to acces Hotswap register */
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			compatible = "marvell,mv64360-pci";
+			cell-index = <0>;
+			reg = <0x0cf8 0x8>;
+			ranges = <0x01000000 0x0 0x0
+					0xf8080000 0x0 0x00010000
+				  0x02000000 0x0 0xf8090000
+					0xf8090000 0x0 0x00010000>;
+			bus-range = <0x0 0xff>;
+		};
+
+		cpu-error@70 {
+			compatible = "marvell,mv64360-cpu-error";
+			reg = <0x0070 0x10 0x0128 0x28>;
+			interrupts = <3>;
+			interrupt-parent = <&PIC>;
+		};
+
+		sram-ctrl@380 {
+			compatible = "marvell,mv64360-sram-ctrl";
+			reg = <0x0380 0x80>;
+			interrupts = <13>;
+			interrupt-parent = <&PIC>;
+		};
+
+		pci-error@1d40 {
+			compatible = "marvell,mv64360-pci-error";
+			reg = <0x1d40 0x40 0x0c28 0x4>;
+			interrupts = <12>;
+			interrupt-parent = <&PIC>;
+		};
+
+		mem-ctrl@1400 {
+			compatible = "marvell,mv64360-mem-ctrl";
+			reg = <0x1400 0x60>;
+			interrupts = <17>;
+			interrupt-parent = <&PIC>;
+		};
+	};
+
+	chosen {
+		bootargs = "ip=on";
+		linux,stdout-path = "/mv64x60@f8100000/mpsc@8000";
+	};
+};
