Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id BD75CDE205
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 06:01:29 +1100 (EST)
Message-ID: <4783C888.8080002@pikatech.com>
Date: Tue, 08 Jan 2008 14:01:28 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/2] Base Warp Platform support
References: <477F0C46.6080900@pikatech.com> <1199517639.7291.45.camel@pasglop>
In-Reply-To: <1199517639.7291.45.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--- /dev/null	2005-11-20 22:22:37.000000000 -0500
+++ arch/powerpc/boot/cuboot-warp.c	2008-01-08 12:09:39.000000000 -0500
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "44x.h"
+#include "cuboot.h"
+
+#define TARGET_44x
+#include "ppcboot.h"
+
+static bd_t bd;
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+				   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+
+	warp_init(&bd.bi_enetaddr, &bd.bi_enet1addr);
+}
--- /dev/null	2005-11-20 22:22:37.000000000 -0500
+++ arch/powerpc/boot/dts/warp.dts	2008-01-08 12:04:10.000000000 -0500
@@ -0,0 +1,232 @@
+/*
+ * Device Tree Source for PIKA Warp
+ *
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "pika,warp";
+	compatible = "pika,warp";
+	dcr-parent = <&/cpus/cpu@0>;
+
+	aliases {
+		ethernet0 = &EMAC0;
+		serial0 = &UART0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC,440EP";
+			reg = <0>;
+			clock-frequency = <0>; /* Filled in by zImage */
+			timebase-frequency = <0>; /* Filled in by zImage */
+			i-cache-line-size = <20>;
+			d-cache-line-size = <20>;
+			i-cache-size = <8000>;
+			d-cache-size = <8000>;
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0 0>; /* Filled in by zImage */
+	};
+
+	UIC0: interrupt-controller0 {
+		compatible = "ibm,uic-440ep","ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0c0 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible = "ibm,uic-440ep","ibm,uic";
+		interrupt-controller;
+		cell-index = <1>;
+		dcr-reg = <0d0 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	SDR0: sdr {
+		compatible = "ibm,sdr-440ep";
+		dcr-reg = <00e 002>;
+	};
+
+	CPR0: cpr {
+		compatible = "ibm,cpr-440ep";
+		dcr-reg = <00c 002>;
+	};
+
+	plb {
+		compatible = "ibm,plb-440ep", "ibm,plb-440gp", "ibm,plb4";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by zImage */
+
+		SDRAM0: sdram {
+			compatible = "ibm,sdram-440ep", "ibm,sdram-405gp";
+			dcr-reg = <010 2>;
+		};
+
+		DMA0: dma {
+			compatible = "ibm,dma-440ep", "ibm,dma-440gp";
+			dcr-reg = <100 027>;
+		};
+
+		FPGA0: fpga {
+			compatible = "pika,fpga";
+	   		reg = <0 80000000 2200>;
+			interrupts = <18 8>;
+			interrupt-parent = <&UIC0>;
+		};
+
+		MAL0: mcmal {
+			compatible = "ibm,mcmal-440ep", "ibm,mcmal-440gp", "ibm,mcmal";
+			dcr-reg = <180 62>;
+			num-tx-chans = <4>;
+			num-rx-chans = <2>;
+			interrupt-parent = <&MAL0>;
+			interrupts = <0 1 2 3 4>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
+					/*RXEOB*/ 1 &UIC0 b 4
+					/*SERR*/  2 &UIC1 0 4
+					/*TXDE*/  3 &UIC1 1 4
+					/*RXDE*/  4 &UIC1 2 4>;
+		};
+
+		POB0: opb {
+		  	compatible = "ibm,opb-440ep", "ibm,opb-440gp", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		  	ranges = <00000000 0 00000000 80000000
+			          80000000 0 80000000 80000000>;
+		  	interrupt-parent = <&UIC1>;
+		  	interrupts = <7 4>;
+		  	clock-frequency = <0>; /* Filled in by zImage */
+
+			EBC0: ebc {
+				compatible = "ibm,ebc-440ep", "ibm,ebc-440gp", "ibm,ebc";
+				dcr-reg = <012 2>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				clock-frequency = <0>; /* Filled in by zImage */
+				interrupts = <5 1>;
+				interrupt-parent = <&UIC1>;
+
+				nor_flash@0,0 {
+					/* Really spansion */
+					compatible = "amd,s29gl512n", "cfi-flash";
+					bank-width = <2>;
+					reg = <0 ffc00000 4000000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					partition@0 {
+						label = "kernel";
+						reg = <0 180000>;
+					};
+					partition@180000 {
+						label = "root";
+						reg = <180000 3480000>;
+					};
+					partition@3600000 {
+						label = "user";
+						reg = <3600000 900000>;
+					};
+					partition@3f00000 {
+						label = "fpga";
+						reg = <3f00000 40000>;
+					};
+					partition@3f40000 {
+						label = "env";
+						reg = <3f40000 40000>;
+					};
+					partition@3f80000 {
+						label = "u-boot";
+						reg = <3f80000 80000>;
+					};
+				};
+			};
+
+			UART0: serial@ef600300 {
+		   		device_type = "serial";
+		   		compatible = "ns16550";
+		   		reg = <ef600300 8>;
+		   		virtual-reg = <ef600300>;
+		   		clock-frequency = <0>; /* Filled in by zImage */
+		   		current-speed = <1c200>;
+		   		interrupt-parent = <&UIC0>;
+		   		interrupts = <0 4>;
+	   		};
+
+			IIC0: i2c@ef600700 {
+				device_type = "i2c";
+				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
+				reg = <ef600700 14>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <2 4>;
+			};
+
+			ZMII0: emac-zmii@ef600d00 {
+				device_type = "zmii-interface";
+				compatible = "ibm,zmii-440ep", "ibm,zmii-440gp", "ibm,zmii";
+				reg = <ef600d00 c>;
+			};
+
+			EMAC0: ethernet@ef600e00 {
+				linux,network-index = <0>;
+				device_type = "network";
+				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
+				interrupt-parent = <&UIC1>;
+				interrupts = <1c 4 1d 4>;
+				reg = <ef600e00 70>;
+				local-mac-address = [000000000000];
+				mal-device = <&MAL0>;
+				mal-tx-channel = <0 1>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "rmii";
+				phy-map = <00000000>;
+				zmii-device = <&ZMII0>;
+				zmii-channel = <0>;
+			};
+
+			usb@ef601000 {
+				compatible = "ohci-be";
+				reg = <ef601000 80>;
+				interrupts = <8 1 9 1>;
+				interrupt-parent = < &UIC1 >;
+			};
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@ef600300";
+	};
+};
--- /dev/null	2005-11-20 22:22:37.000000000 -0500
+++ arch/powerpc/boot/warp.c	2008-01-08 12:09:54.000000000 -0500
@@ -0,0 +1,33 @@
+/*
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the License
+ */
+#include "ops.h"
+#include "4xx.h"
+#include "44x.h"
+
+static u8 *warp_mac0, *warp_mac1;
+
+static void warp_fixups(void)
+{
+	unsigned long sysclk = 66000000;
+
+	ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
+	ibm4xx_sdram_fixup_memsize();
+	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
+	dt_fixup_mac_addresses(warp_mac0, warp_mac1);
+}
+
+void warp_init(void *mac0, void *mac1)
+{
+	platform_ops.fixups = warp_fixups;
+	platform_ops.exit = ibm44x_dbcr_reset;
+	warp_mac0 = mac0;
+	warp_mac1 = mac1;
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
