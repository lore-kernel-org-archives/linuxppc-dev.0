Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 104F3DE5E3
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 23:38:22 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so161285ywh.39
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 05:38:21 -0700 (PDT)
Message-Id: <9d81f5b9dda891b7ade9a7e1c2c4a76ad6e45ea2.1223642006.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1223642006.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1223642006.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: [PATCH 1/5] powerpc/40x: AMCC PowerPC 405EZ Acadia DTS
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Date: Fri, 10 Oct 2008 12:38:24 -0000

Add the DTS for the AMCC PowerPC 405EZ Acadia evaluation board

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/acadia.dts |  224 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/acadia.dts

diff --git a/arch/powerpc/boot/dts/acadia.dts b/arch/powerpc/boot/dts/acadia.dts
new file mode 100644
index 0000000..57291f6
--- /dev/null
+++ b/arch/powerpc/boot/dts/acadia.dts
@@ -0,0 +1,224 @@
+/*
+ * Device Tree Source for AMCC Acadia (405EZ)
+ *
+ * Copyright IBM Corp. 2008
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	model = "amcc,acadia";
+	compatible = "amcc,acadia";
+	dcr-parent = <&{/cpus/cpu@0}>;
+
+	aliases {
+		ethernet0 = &EMAC0;
+		serial0 = &UART0;
+		serial1 = &UART1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC,405EZ";
+			reg = <0x0>;
+			clock-frequency = <0>; /* Filled in by wrapper */
+			timebase-frequency = <0>; /* Filled in by wrapper */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <16384>;
+			d-cache-size = <16384>;
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>; /* Filled in by wrapper */
+	};
+
+	UIC0: interrupt-controller {
+		compatible = "ibm,uic-405ez", "ibm,uic";
+		interrupt-controller;
+		dcr-reg = <0x0c0 0x009>;
+		cell-index = <0>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	plb {
+		compatible = "ibm,plb-405ez", "ibm,plb3";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by wrapper */
+
+		MAL0: mcmal {
+			compatible = "ibm,mcmal-405ez", "ibm,mcmal";
+			dcr-reg = <0x380 0x62>;
+			num-tx-chans = <1>;
+			num-rx-chans = <1>;
+			interrupt-parent = <&UIC0>;
+			/* 405EZ has only 3 interrupts to the UIC, as
+			 * SERR, TXDE, and RXDE are or'd together into
+			 * one UIC bit
+			 */
+			interrupts = <
+				0x13 0x4 /* TXEOB */
+				0x15 0x4 /* RXEOB */
+				0x12 0x4 /* SERR, TXDE, RXDE */>;
+		};
+
+		POB0: opb {
+			compatible = "ibm,opb-405ez", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			dcr-reg = <0x0a 0x05>;
+			clock-frequency = <0>; /* Filled in by wrapper */
+
+			UART0: serial@ef600300 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <0xef600300 0x8>;
+				virtual-reg = <0xef600300>;
+				clock-frequency = <0>; /* Filled in by wrapper */
+				current-speed = <115200>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x5 0x4>;
+			};
+
+			UART1: serial@ef600400 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <0xef600400 0x8>;
+				clock-frequency = <0>; /* Filled in by wrapper */
+				current-speed = <115200>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x6 0x4>;
+			};
+
+			IIC: i2c@ef600500 {
+				compatible = "ibm,iic-405ez", "ibm,iic";
+				reg = <0xef600500 0x11>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0xa 0x4>;
+			};
+
+			GPIO0: gpio@ef600700 {
+				compatible = "ibm,gpio-405ez";
+				reg = <0xef600700 0x20>;
+			};
+
+			GPIO1: gpio@ef600800 {
+				compatible = "ibm,gpio-405ez";
+				reg = <0xef600800 0x20>;
+			};
+
+			EMAC0: ethernet@ef600900 {
+				device_type = "network";
+				compatible = "ibm,emac-405ez", "ibm,emac";
+				interrupt-parent = <&UIC0>;
+				interrupts = <
+					0x10 0x4 /* Ethernet */
+					0x11 0x4 /* Ethernet Wake up */>;
+				local-mac-address = [000000000000]; /* Filled in by wrapper */
+				reg = <0xef600900 0x70>;
+				mal-device = <&MAL0>;
+				mal-tx-channel = <0>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
+				phy-mode = "mii";
+				phy-map = <0x0>;
+			};
+
+			CAN0: can@ef601000 {
+				compatible = "amcc,can-405ez";
+				reg = <0xef601000 0x620>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x7 0x4>;
+			};
+
+			CAN1: can@ef601800 {
+				compatible = "amcc,can-405ez";
+				reg = <0xef601800 0x620>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x8 0x4>;
+			};
+
+			cameleon@ef602000 {
+				compatible = "amcc,cameleon-405ez";
+				reg = <0xef602000 0x800>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0xb 0x4 0xc 0x4>;
+			};
+
+			ieee1588@ef602800 {
+				compatible = "amcc,ieee1588-405ez";
+				reg = <0xef602800 0x60>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x4 0x4>;
+				/* This thing is a bit weird.  It has it's own UIC
+				 * that it uses to generate snapshot triggers.  We
+				 * don't really support this device yet, and it needs
+				 * work to figure this out.
+				 */
+				dcr-reg = <0xe0 0x9>;
+			};
+
+			usb@ef603000 {
+				compatible = "ohci-be";
+				reg = <0xef603000 0x80>;
+				interrupts-parent = <&UIC0>;
+				interrupts = <0xd 0x4 0xe 0x4>;
+			};
+
+			dac@ef603300 {
+				compatible = "amcc,dac-405ez";
+				reg = <0xef603300 0x40>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x18 0x4>;
+			};
+
+			adc@ef603400 {
+				compatible = "amcc,adc-405ez";
+				reg = <0xef603400 0x40>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x17 0x4>;
+			};
+
+			spi@ef603500 {
+				compatible = "amcc,spi-405ez";
+				reg = <0xef603500 0x100>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x9 0x4>;
+			};
+		};
+
+		EBC0: ebc {
+			compatible = "ibm,ebc-405ez", "ibm,ebc";
+			dcr-reg = <0x12 0x2>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			clock-frequency = <0>; /* Filled in by wrapper */
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@ef600300";
+	};
+};
-- 
1.5.5.1
