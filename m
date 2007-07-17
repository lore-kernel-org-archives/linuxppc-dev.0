Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BDA81DDF7D
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 04:33:01 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6HIWwAu025814
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 14:32:58 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6HIWsML262198
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:57 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6HIWoVr013775
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:50 -0600
Received: from [9.10.86.36] (weaponx.rchland.ibm.com [9.10.86.36])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6HIWnwS013749
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:49 -0600
Message-Id: <20070717182621.902905000@linux.vnet.ibm.com>>
References: <20070717181547.310201000@linux.vnet.ibm.com>>
Date: Tue, 17 Jul 2007 13:15:55 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 08/14] Walnut DTS
In-Reply-To: <20070717181547.310201000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Device tree source file for the PPC405 Walnut evaluation board.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/dts/walnut.dts |  153 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

--- /dev/null
+++ linux-2.6/arch/powerpc/boot/dts/walnut.dts
@@ -0,0 +1,153 @@
+/*
+ * Device Tree Source for IBM Walnut
+ *
+ * Copyright 2007 IBM Corp.
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * FIXME: Draft only!
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ *
+ * To build:
+ *   dtc -I dts -O asm -o walnut.S -b 0 walnut.dts
+ *   dtc -I dts -O dtb -o walnut.dtb -b 0 walnut.dts
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	model = "ibm,walnut";
+	compatible = "ibm,walnut";
+	dcr-parent = <&/cpus/PowerPC,405GP@0>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,405GP@0 {
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <bebc200>; /* Filled in by zImage */
+			timebase-frequency = <0>; /* Filled in by zImage */
+			i-cache-line-size = <20>;
+			d-cache-line-size = <20>;
+			i-cache-size = <4000>;
+			d-cache-size = <4000>;
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0>; /* Filled in by zImage */
+	};
+
+	UIC0: interrupt-controller {
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0c0 9>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	plb {
+		compatible = "ibm,plb3";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by zImage */
+
+		SDRAM0: memory-controller {
+			compatible = "ibm,sdram-405gp";
+			dcr-reg = <010 2>;
+		};
+
+		MAL: mcmal {
+			compatible = "ibm,mcmal-405gp", "ibm,mcmal";
+			dcr-reg = <180 62>;
+			num-tx-chans = <2>;
+			num-rx-chans = <1>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <a 4 b 4 c 4 d 4 e 4>;
+		};
+
+		POB0: opb {
+			compatible = "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 ef600000 a00000>;
+			dcr-reg = <0a0 5>;
+			clock-frequency = <0>; /* Filled in by zImage */
+
+			UART0: serial@300 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <300 8>;
+				virtual-reg = <ef600300>;
+				clock-frequency = <0>; /* Filled in by zImage */
+				current-speed = <2580>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0 4>;
+			};
+
+			UART1: serial@400 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <400 8>;
+				virtual-reg = <ef600400>;
+				clock-frequency = <0>; /* Filled in by zImage */
+				current-speed = <2580>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <1 4>;
+			};
+
+			IIC: i2c@500 {
+				compatible = "ibm,iic-405gp", "ibm,iic";
+				reg = <500 11>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <2 4>;
+			};
+
+			GPIO: gpio@700 {
+				compatible = "ibm,gpio-405gp";
+				reg = <700 20>;
+			};
+
+			EMAC: ethernet@800 {
+				linux,network-index = <0>;
+				device_type = "network";
+				compatible = "ibm,emac-405gp", "ibm,emac";
+				interrupt-parent = <&UIC0>;
+				interrupts = <9 4 f 4>;
+				reg = <800 70>;
+				mal-device = <&MAL>;
+				mal-tx-channel = <0 1>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <5dc>;
+				rx-fifo-size = <1000>;
+				tx-fifo-size = <800>;
+				phy-mode = "rmii";
+				phy-map = <00000001>;
+			};
+
+		};
+
+		EBC0: ebc {
+			compatible = "ibm,ebc-405gp", "ibm,ebc";
+			dcr-reg = <012 2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clock-frequency = <0>; /* Filled in by zImage */
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@300";
+	};
+};

-- 
