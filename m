Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3FE23DDDE6
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 04:21:02 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l44IKuLU027501
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 14:20:56 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l44IKtZJ147212
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 12:20:55 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l44IKt1m021273
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 12:20:55 -0600
Received: from [9.10.86.166] (zod.rchland.ibm.com [9.10.86.166])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l44IKtWg021268
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 12:20:55 -0600
Subject: [PATCH 3/4] Holly DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1178302414.3026.202.camel@zod.rchland.ibm.com>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 04 May 2007 13:16:00 -0500
Message-Id: <1178302560.3026.210.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add Holly/Hickory DTS file

Signed-off-by: Stephen Winiecki <stevewin@us.ibm.com>
Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/holly.dts |  229 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)

--- /dev/null
+++ linux-2.6/arch/powerpc/boot/dts/holly.dts
@@ -0,0 +1,229 @@
+/*
+ * Device Tree Source for IBM Holly/Hickory (PPC 750CL/GX with TSI controller)
+ * Copyright 2007, IBM Corporation
+ *
+ * Stephen Winiecki <stevewin@us.ibm.com>
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ *
+ * To build:
+ *   dtc -I dts -O asm -o holly.S -b 0 holly.dts
+ *   dtc -I dts -O dtb -o holly.dtb -b 0 holly.dts
+ */
+
+/ {
+	model = "ppc750-tsi109";
+	compatible = "ppc750";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		name = "cpus";
+		#address-cells = <1>;
+		#size-cells =<0>;
+		PowerPC,750@0 {
+			name = "PowerPC,750";
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;
+			i-cache-line-size = <20>;
+			d-cache-size = <8000>;
+			i-cache-size = <8000>;
+			d-cache-sets = <80>;
+			i-cache-sets = <80>;
+			timebase-frequency = <2faf080>;
+			clock-frequency = <23c34600>;
+			bus-frequency = <bebc200>;
+			32-bit;
+		};
+	};
+
+	memory@0 {
+		name = "memory";
+		device_type = "memory";
+		reg = <00000000 20000000>;
+	};
+
+  	tsi109@c0000000 {
+		name = "tsi109";
+		device_type = "tsi-bridge";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <00000000 c0000000 00010000>;
+		reg = <c0000000 00010000>;
+		bus-frequency = <0>;
+
+		i2c@7000 {
+			name = "i2c";
+			device_type = "i2c";
+			compatible  = "tsi-i2c";
+			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupts = <e 2>;
+			reg = <7000 400>;
+		};
+
+		mdio@6000 {
+			name = "mdio";
+			device_type = "mdio";
+			compatible = "tsi-ethernet";
+			ethernet-phy@6000 {
+				name = "ethernet-phy";
+				device_type = "ethernet-phy";
+				reg = <6000 50>;
+				phy-id = <1>;
+				linux,phandle = <421>;
+			};
+			ethernet-phy@6400 {
+				name = "ethernet-phy";
+				device_type = "ethernet-phy";
+				reg = <6000 50>;
+				phy-id = <2>;
+				linux,phandle = <422>;
+			};
+		};
+
+		ethernet@6200 {
+			name = "ethernet";
+			device_type = "network";
+			compatible = "tsi-ethernet";
+			model = "TSI-ETH";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6000 200>;
+			address = [ 00 0d 60 f4 3f 04 ];
+			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupts = <10 2>;
+			phy-handle = <421>;
+		};
+
+		ethernet@6600 {
+			name = "ethernet";
+			device_type = "network";
+			compatible = "tsi-ethernet";
+			model = "TSI-ETH";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6400 200>;
+			address = [ 00 0d 60 f4 3f 05 ];
+			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupts = <11 2>;
+			phy-handle = <422>;
+		};
+
+		serial@7808 {
+			name = "serial";
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <7808 200>;
+			virtual-reg = <c0007808>;
+			reg-shift = <0>;
+			clock-frequency = <3F9C6000>;
+			current-speed = <1c200>;
+			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupts = <c 2>;
+		};
+
+		serial@7c08 {
+			name = "serial";
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <7c08 200>;
+			virtual-reg = <c0007c08>;
+			reg-shift = <0>;
+			clock-frequency = <3F9C6000>;
+			current-speed = <1c200>;
+			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupts = <d 2>;
+		};
+
+	  	pic@7400 {
+			name = "pic";
+			device_type = "open-pic";
+			compatible = "chrp,open-pic";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <7400 400>;
+			built-in;
+			big-endian;
+		};
+
+		pci@1000 {
+			name = "pci";
+			device_type = "pci";
+			compatible = "tsi109";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <1000 1000>;
+			bus-range = <0 0>;
+			/*----------------------------------------------------+
+			| PCI memory range.
+			| 01 denotes I/O space
+			| 02 denotes 32-bit memory space
+			+----------------------------------------------------*/
+			ranges = <02000000 0 40000000 40000000 0 10000000
+				  01000000 0 00000000 7e000000 0 00010000>;
+			clock-frequency = <7f28154>;
+			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupts = <17 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			/*----------------------------------------------------+
+			| The INTA, INTB, INTC, INTD are shared.
+			+----------------------------------------------------*/
+			interrupt-map = <
+				/*--------------------------------------------+
+				| AD17.
+				+--------------------------------------------*/
+				0800 0 0 1 1180 24 0
+				0800 0 0 2 1180 25 0
+				0800 0 0 3 1180 26 0
+				0800 0 0 4 1180 27 0
+				/*--------------------------------------------+
+				| AD18.
+				+--------------------------------------------*/
+				1000 0 0 1 1180 25 0
+				1000 0 0 2 1180 26 0
+				1000 0 0 3 1180 27 0
+				1000 0 0 4 1180 24 0
+				/*--------------------------------------------+
+				| AD19.
+				+--------------------------------------------*/
+				1800 0 0 1 1180 26 0
+				1800 0 0 2 1180 27 0
+				1800 0 0 3 1180 24 0
+				1800 0 0 4 1180 25 0
+
+				2000 0 0 1 1180 27 0
+				2000 0 0 2 1180 24 0
+				2000 0 0 3 1180 25 0
+				2000 0 0 4 1180 26 0
+				>;
+
+			router@1180 {
+				name = "router";
+ 				device_type = "pic-router";
+				linux,phandle = <1180>;
+ 				interrupt-controller;
+ 				built-in;
+ 				big-endian;
+ 				clock-frequency = <0>;
+ 				#address-cells = <0>;
+ 				#interrupt-cells = <2>;
+ 				interrupts = <17 2>;
+				interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			};
+		};
+	};
+
+	chosen {
+		name = "chosen";
+		linux,stdout-path = "/tsi109@c0000000/serial@7808";
+		bootargs = "console=ttyS0,115200";
+		linux,platform = <0>;
+		linux,initrd-start = <0>;
+		linux,initrd-end = <0>;
+	};
+};
