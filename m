Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62557DDEE6
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 23:59:55 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6BDxqna003166
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 09:59:52 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6BDxpVt202534
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:59:51 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6BDxovU011742
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:59:50 -0600
Subject: [RFC][PATCH 6/8] Walnut DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Jul 2007 08:59:49 -0500
Message-Id: <1184162389.32199.65.camel@weaponx.rchland.ibm.com>
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
 arch/powerpc/boot/dts/walnut.dts |  113 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

--- /dev/null
+++ linux-2.6/arch/powerpc/boot/dts/walnut.dts
@@ -0,0 +1,113 @@
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
+			i-cache-size = <8000>;
+			d-cache-size = <8000>;
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
+	UIC0: interrupt-controller0 {
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
+		compatible = "ibm,plb";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by zImage */
+
+		SDRAM0: memory-controller {
+			compatible = "ibm,sdram-405gp", "ibm,sdram-440gp";
+			dcr-reg = <010 2>;
+		};
+
+		POB0: opb {
+			compatible = "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			dcr-reg = <0a0 5>;
+			clock-frequency = <0>; /* Filled in by zImage */
+
+			UART0: serial@ef600300 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <ef600300 8>;
+				virtual-reg = <ef600300>;
+				clock-frequency = <0>; /* Filled in by zImage */
+				current-speed = <2580>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0 4>;
+			};
+
+			UART1: serial@ef600400 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <ef600400 8>;
+				virtual-reg = <ef600400>;
+				clock-frequency = <0>; /* Filled in by zImage */
+				current-speed = <2580>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <1 4>;
+			};
+
+			EBC0: ebc {
+				compatible = "ibm,ebc-405gp", "ibm,ebc";
+				dcr-reg = <012 2>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				clock-frequency = <0>; /* Filled in by zImage */
+			};
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@ef600300";
+	};
+};
