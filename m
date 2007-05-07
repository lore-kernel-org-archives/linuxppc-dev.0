Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A4376DDEBC
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 01:01:46 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l47EwI6N012134
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 10:58:18 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47F1bnr161614
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 09:01:37 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47F1bls012546
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 09:01:37 -0600
Subject: [PATCH v3 6/7] Holly DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
In-Reply-To: <1178549324.2990.52.camel@zod.rchland.ibm.com>
References: <1178549324.2990.52.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 07 May 2007 09:56:05 -0500
Message-Id: <1178549765.2990.67.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add Holly DTS file

Signed-off-by: Stephen Winiecki <stevewin@us.ibm.com>
Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/holly.dts |  198 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

--- /dev/null
+++ linux-2.6/arch/powerpc/boot/dts/holly.dts
@@ -0,0 +1,198 @@
+/*
+ * Device Tree Source for IBM Holly (PPC 750CL with TSI controller)
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
+	model = "41K7339";
+	compatible = "ibm,holly";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells =<0>;
+		PowerPC,750CL@0 {
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
+		device_type = "memory";
+		reg = <00000000 20000000>;
+	};
+
+  	tsi109@c0000000 {
+		device_type = "tsi-bridge";
+		compatible = "tsi-bridge";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <00000000 c0000000 00010000>;
+		reg = <c0000000 00010000>;
+
+		i2c@7000 {
+			device_type = "i2c";
+			compatible  = "tsi-i2c";
+			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupts = <e 2>;
+			reg = <7000 400>;
+		};
+
+		mdio@6000 {
+			device_type = "mdio";
+			compatible = "tsi-ethernet";
+
+			PHY1: ethernet-phy@6000 {
+				device_type = "ethernet-phy";
+				compatible = "bcm54xx";
+				reg = <6000 50>;
+				phy-id = <1>;
+			};
+
+			PHY2: ethernet-phy@6400 {
+				device_type = "ethernet-phy";
+				compatible = "bcm54xx";
+				reg = <6000 50>;
+				phy-id = <2>;
+			};
+		};
+
+		ethernet@6200 {
+			device_type = "network";
+			compatible = "tsi-ethernet";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6000 200>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupts = <10 2>;
+			phy-handle = <&PHY1>;
+		};
+
+		ethernet@6600 {
+			device_type = "network";
+			compatible = "tsi-ethernet";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6400 200>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupts = <11 2>;
+			phy-handle = <&PHY2>;
+		};
+
+		serial@7808 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <7808 200>;
+			virtual-reg = <c0007808>;
+			clock-frequency = <3F9C6000>;
+			current-speed = <1c200>;
+			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupts = <c 2>;
+		};
+
+		serial@7c08 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <7c08 200>;
+			virtual-reg = <c0007c08>;
+			clock-frequency = <3F9C6000>;
+			current-speed = <1c200>;
+			interrupt-parent = < &/tsi109@c0000000/pic@7400 >;
+			interrupts = <d 2>;
+		};
+
+	  	MPIC: pic@7400 {
+			device_type = "open-pic";
+			compatible = "chrp,open-pic";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <7400 400>;
+			big-endian;
+		};
+
+		pci@1000 {
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
+				0800 0 0 1 &RT0 24 0
+				0800 0 0 2 &RT0 25 0
+				0800 0 0 3 &RT0 26 0
+				0800 0 0 4 &RT0 27 0
+
+				1000 0 0 1 &RT0 25 0
+				1000 0 0 2 &RT0 26 0
+				1000 0 0 3 &RT0 27 0
+				1000 0 0 4 &RT0 24 0
+
+				1800 0 0 1 &RT0 26 0
+				1800 0 0 2 &RT0 27 0
+				1800 0 0 3 &RT0 24 0
+				1800 0 0 4 &RT0 25 0
+
+				2000 0 0 1 &RT0 27 0
+				2000 0 0 2 &RT0 24 0
+				2000 0 0 3 &RT0 25 0
+				2000 0 0 4 &RT0 26 0
+				>;
+
+			RT0: router@1180 {
+ 				device_type = "pic-router";
+ 				interrupt-controller;
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
+		linux,stdout-path = "/tsi109@c0000000/serial@7808";
+		bootargs = "console=ttyS0,115200";
+	};
+};
