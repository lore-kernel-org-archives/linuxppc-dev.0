Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 12/14] Add device tree for Ebony
In-Reply-To: <20070220020837.GF17818@localhost.localdomain>
Message-Id: <20070220021235.DC02DDDD06@ozlabs.org>
Date: Tue, 20 Feb 2007 13:12:35 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a device tree for the Ebony evaluation board (440GP based).  This
tree is not complete or finalized.  This tree needs a very recent
version of dtc to process.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/boot/dts/ebony.dts |  225 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 225 insertions(+)

Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-02-19 15:31:36.000000000 +1100
@@ -0,0 +1,225 @@
+/*
+ * Device Tree Source for IBM Ebony
+ *
+ * Copyright (c) 2006, 2007 IBM Corp.
+ * Josh Boyer <jdub@us.ibm.com>, David Gibson <dwg@au1.ibm.com>
+ *
+ * FIXME: Draft only!
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ *
+ * To build:
+ *   dtc -I dts -O asm -o ebony.S -b 0 -V 16 ebony.dts
+ *   dtc -I dts -O dtb -o ebony.dtb -b 0 -V 16 ebony.dts
+ */
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "Ebony";
+	compatible = "Ebony";
+	dcr-parent = <&/cpus/PowerPC,440GP@0>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,440GP@0 {
+			model = "440GP Rev. C";
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <17d78400>; /* 400MHz FIXME: poke in zImage */
+			timebase-frequency = <17d78400>; /* 400MHz FIXME: wrong, poke in zImage */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <0>;
+			d-cache-size = <0>;
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 00000000 08000000>; /* Set by bootwrapper */
+	};
+
+	UIC0: interrupt-controller { /* UIC0 */
+		device_type = "interrupt-controller";
+		compatible = "ibm,uic440gp", "ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0c0 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		UIC1: interrupt-controller@1 { /* UIC1 */
+			device_type = "interrupt-controller";
+			compatible = "ibm,uic440gp", "ibm,uic";
+			interrupt-controller;
+			cell-index = <1>;
+			dcr-reg = <0d0 009>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			#interrupt-cells = <2>;
+			interrupts = <1e 4 1f 4>; /* cascade */
+		};
+	};
+
+	plb {
+		device_type = "ibm,plb";
+		compatible = "ibm,plb-440gp", "ibm,plb4";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		POB0: opb@0 {
+			device_type = "ibm,opb";
+			compatible = "ibm,opb-440gp", "ibm,opb";
+			ranges;
+			dcr-reg = <090 00b>;
+			interrupt-parent = <&UIC1>;
+			interrupts = <7 4>;
+			clock-frequency = <3ef1480>; // FIXME: 66MHz
+
+			UART0: serial@140000200 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <1 40000200 8>;
+				virtual-reg = <e0000200>;
+				clock-frequency = <A8C000>;
+				current-speed = <2580>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0 4>;
+			};
+
+			UART1: serial@140000300 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <1 40000300 8>;
+				virtual-reg = <e0000300>;
+				clock-frequency = <A8C000>;
+				current-speed = <2580>; /* FIXME */
+				interrupt-parent = <&UIC0>;
+				interrupts = <1 4>;
+			};
+
+			IIC0: i2c@140000400 {
+				/* FIXME */
+				device_type = "i2c";
+				compatible = "ibm,iic-440gp", "ibm,iic";
+				reg = <1 40000400 14>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <2 4>;
+			};
+			IIC1: i2c@140000500 {
+				/* FIXME */
+				device_type = "i2c";
+				compatible = "ibm,iic-440gp", "ibm,iic";
+				reg = <1 40000500 14>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <3 4>;
+			};
+
+			GPIO0: gpio@140000700 {
+				/* FIXME */
+				device_type = "gpio";
+				compatible = "ibm,gpio-440gp";
+				reg = <1 40000700 20>;
+			};
+
+			ZMII0: emac-zmii@140000780 {
+				device_type = "emac-zmii";
+				compatible = "ibm,zmii-440gp", "ibm,zmii";
+				reg = <1 40000780 c>;
+			};
+
+			EMAC0: ethernet@140000800 {
+				device_type = "network";
+				compatible = "ibm,emac-440gp", "ibm,emac";
+				interrupt-parent = <&UIC1>;
+				interrupts = <1c 4 1d 4>;
+				reg = <1 40000800 70>;
+				local-mac-address = [0004ace31b1e]; // FIXME
+				mal-device = <&MAL0>;
+				mal-tx-channel = <0 1>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "rmii";
+				phy-map = <00000001>;
+				zmii-device = <&ZMII0>;
+				zmii-channel = <0>;
+			};
+			EMAC1: ethernet@140000900 {
+				device_type = "network";
+				compatible = "ibm,emac-440gp", "ibm,emac";
+				interrupt-parent = <&UIC1>;
+				interrupts = <1e 4 1f 4>;
+				reg = <1 40000900 70>;
+				local-mac-address = [0004ace31b1f]; // FIXME
+				mal-device = <&MAL0>;
+				mal-tx-channel = <2 3>;
+				mal-rx-channel = <1>;
+				cell-index = <1>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "rmii";
+				phy-map = <00000001>;
+				zmii-device = <&ZMII0>;
+				zmii-channel = <1>;
+			};
+
+
+			GPT0: gpt@140000a00 {
+				/* FIXME */
+				reg = <1 40000a00 d4>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <12 4 13 4 14 4 15 4 16 4>;
+			};
+
+		};
+
+		PCIX0: pci@1234 {
+			device_type = "pci";
+			/* FIXME */
+			reg = <2 0ec00000 8
+			       2 0ec80000 f0
+			       2 0ec80100 fc>;
+		};
+
+		MAL0: mcmal {
+			/* FIXME */
+			device_type = "mcmal-dma";
+			compatible = "ibm,mcmal-440gp", "ibm,mcmal";
+			dcr-reg = <180 62>;
+			num-tx-chans = <4>;
+			num-rx-chans = <4>;
+			interrupt-parent = <&MAL0>;
+			interrupts = <0 1 2 3 4>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
+					 /*RXEOB*/ 1 &UIC0 b 4
+					 /*SERR*/  2 &UIC1 0 4
+					 /*TXDE*/  3 &UIC1 1 4
+					 /*RXDE*/  4 &UIC1 2 4>;
+			interrupt-map-mask = <ffffffff>;
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb@0/serial@140000200";
+		linux,initrd-start = <0>; /* FIXME */
+		linux,initrd-end = <0>;
+		interrupt-controller = <&UIC0>;
+	};
+};
+
