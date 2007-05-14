Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1CDB4DDEEB
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 00:58:01 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4EEwwjF029210
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:58:58 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4EEvw8Q512568
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:57:59 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4EEvwaH012023
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:57:58 -0400
Received: from [9.67.220.166] (wecm-9-67-220-166.wecm.ibm.com [9.67.220.166])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l4EEvvbE011956
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:57:58 -0400
Subject: [PATCH 1/3] Bamboo DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1179154608.3420.21.camel@zod.rchland.ibm.com>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 14 May 2007 09:57:55 -0500
Message-Id: <1179154675.3420.22.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

AMCC Bamboo board DTS

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/dts/bamboo.dts |  253 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 253 insertions(+)

--- /dev/null
+++ linux-2.6/arch/powerpc/boot/dts/bamboo.dts
@@ -0,0 +1,253 @@
+/*
+ * Device Tree Source for AMCC Bamboo
+ *
+ * Copyright (c) 2006, 2007 IBM Corp.
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * FIXME: Draft only!
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ *
+ * To build:
+ *   dtc -I dts -O asm -o bamboo.S -b 0 bamboo.dts
+ *   dtc -I dts -O dtb -o bamboo.dtb -b 0 bamboo.dts
+ */
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "amcc,bamboo";
+	compatible = "amcc,bamboo";
+	dcr-parent = <&/cpus/PowerPC,440EP@0>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,440EP@0 {
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <0>; /* Filled in by zImage */
+			timebase-frequency = <0>; /* Filled in by zImage */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <2000000>;
+			d-cache-size = <2000000>;
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
+		compatible = "ibm,uic-440gp","ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0c0 009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible = "ibm,uic-440gp","ibm,uic";
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
+		compatible = "ibm,plb-440gp", "ibm,plb4";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by zImage */
+
+		SDRAM0: sdram {
+			device_type = "memory-controller";
+			compatible = "ibm,sdram-440gp","ibm,sdram";
+			dcr-reg = <010 2>;
+		};
+
+		DMA0: dma {
+			compatible = "ibm,dma-440gp", "ibm,dma-4xx";
+			dcr-reg = <100 027>;
+		};
+
+		MAL0: mcmal {
+			device_type = "dma-controller";
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
+					/*RXEOB*/ 1 &UIC0 b 4
+					/*SERR*/  2 &UIC1 0 4
+					/*TXDE*/  3 &UIC1 1 4
+					/*RXDE*/  4 &UIC1 3 4>;
+			interrupt-map-mask = <ffffffff>;
+		};
+
+		POB0: opb {
+		  	compatible = "ibm,opb-440gp", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* Bamboo is oddball in the 44x world and doesn't use the ERPN
+			 * bits.
+			 */
+		  	ranges = <00000000 0 00000000 80000000
+			          80000000 0 80000000 80000000>;
+		  	interrupt-parent = <&UIC1>;
+		  	interrupts = <7 4>;
+		  	clock-frequency = <0>; /* Filled in by zImage */
+
+			EBC0: ebc {
+				compatible = "ibm,ebc-440gp";
+				dcr-reg = <012 2>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				clock-frequency = <0>; /* Filled in by zImage */
+				ranges;
+				interrupts = <5 1>;
+				interrupt-parent = <&UIC1>;
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
+			UART1: serial@ef600400 {
+		   		device_type = "serial";
+		   		compatible = "ns16550";
+		   		reg = <ef600400 8>;
+		   		virtual-reg = <ef600400>;
+		   		clock-frequency = <0>;
+		   		current-speed = <0>;
+		   		interrupt-parent = <&UIC0>;
+		   		interrupts = <1 4>;
+	   		};
+
+			UART2: serial@ef600500 {
+		   		device_type = "serial";
+		   		compatible = "ns16550";
+		   		reg = <ef600500 8>;
+		   		virtual-reg = <ef600500>;
+		   		clock-frequency = <0>;
+		   		current-speed = <0>;
+		   		interrupt-parent = <&UIC0>;
+		   		interrupts = <3 4>;
+	   		};
+
+			UART3: serial@ef600600 {
+		   		device_type = "serial";
+		   		compatible = "ns16550";
+		   		reg = <ef600600 8>;
+		   		virtual-reg = <ef600600>;
+		   		clock-frequency = <0>;
+		   		current-speed = <0>;
+		   		interrupt-parent = <&UIC0>;
+		   		interrupts = <4 4>;
+	   		};
+
+			IIC0: i2c@ef600700 {
+				device_type = "i2c";
+				compatible = "ibm,iic-440gp", "ibm,iic";
+				reg = <ef600700 14>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <2 4>;
+			};
+
+			IIC1: i2c@ef600800 {
+				device_type = "i2c";
+				compatible = "ibm,iic-44gp", "ibm,iic";
+				reg = <ef600800 14>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <7 4>;
+			};
+
+			ZMII0: emac-zmii@ef600d00 {
+				device_type = "zmii-interface";
+				compatible = "ibm,zmii-440gp", "ibm,zmii";
+				reg = <ef600d00 c>;
+			};
+
+			EMAC0: ethernet@ef600e00 {
+				device_type = "network";
+				compatible = "ibm,emac-440gp", "ibm,emac";
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
+				phy-map = <00000001>;
+				zmii-device = <&ZMII0>;
+				zmii-channel = <0>;
+			};
+
+			EMAC1: ethernet@ef600f00 {
+				device_type = "network";
+				compatible = "ibm,emac-440gp", "ibm,emac";
+				interrupt-parent = <&UIC1>;
+				interrupts = <1e 4 1f 4>;
+				reg = <ef600f00 70>;
+				local-mac-address = [000000000000];
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
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@ef600300";
+		bootargs = "console=ttyS0,115200";
+	};
+};
