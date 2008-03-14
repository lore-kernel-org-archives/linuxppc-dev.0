Return-Path: <asmirnov@ru.mvista.com>
Received: from spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB615DE38F
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Mar 2008 01:19:24 +1100 (EST)
Received: from spb.rtsoft.ru (spb.rtsoft.ru [127.0.0.1])
	by spb.rtsoft.ru (8.13.5/8.13.5) with ESMTP id m2EESDRC008377
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 17:28:13 +0300
Received: (from alex@localhost)
	by spb.rtsoft.ru (8.13.5/8.13.5/Submit) id m2EESDHc008376
	for linuxppc-dev@ozlabs.org; Fri, 14 Mar 2008 17:28:13 +0300
Date: Fri, 14 Mar 2008 17:28:13 +0300
From: Alexandr Smirnov <asmirnov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] Emerson ATCA-C125 device tree
Message-ID: <20080314142813.GC8228@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080314142220.GA8228@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Device tree for Emerson ATCA-C125 board

Signed-off-by: Alexandr Smirnov <asmirnov@ru.mvista.com>

 b/arch/powerpc/boot/dts/c125.dts |  283 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/arch/powerpc/boot/dts/c125.dts b/arch/powerpc/boot/dts/c125.dts
new file mode 100644
index 0000000..e089f36
--- /dev/null
+++ b/arch/powerpc/boot/dts/c125.dts
@@ -0,0 +1,283 @@
+/*
+ * Device Tree Source for Emerson ATCA-C125
+ *
+ * Author: Andrei Dolnikov <adolnikov@ru.mvista.com>
+ *         Alexandr Smirnov <asmirnov@ru.mvista.com>
+ *
+ * Based on mpc8548cds.dts
+ *
+ * 2008 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	model = "ATCA-C125";
+	compatible = "emerson,ATCA-C125";
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+
+		serial0 = &serial0;
+		serial1 = &serial1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8548@0 {
+			device_type = "cpu";
+			reg = <0>;
+			timebase-frequency = <0>;		/* From U-Boot */
+			bus-frequency = <0>;			/* From U-Boot */
+			clock-frequency = <0>;			/* From U-Boot */
+			d-cache-line-size = <0x20>;
+			i-cache-line-size = <0x20>;
+			d-cache-size = <0x8000>;		/* L1, 32K */
+			i-cache-size = <0x8000>;		/* L1, 32K */
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000>;			/* Filled in by bootwraper */
+	};
+
+	soc8548@ff700000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x00000000 0xff700000 0x00100000>;
+		reg = <0xff700000 0x00001000>;
+		bus-frequency = <0>;				/* Fixed by bootwrapper */
+
+		memory-controller@2000 {
+			compatible = "fsl,8548-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&MPIC>;
+			interrupts = <0xc 0x2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8548-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <0x20>;		/* 32 bytes */
+			cache-size = <0x80000>;			/* L2, 512K */
+			interrupt-parent = <&MPIC>;
+			interrupts = <0xa 0x2>;
+		};
+
+		i2c@3000 {
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&MPIC>;
+			dfsrr;
+		};
+
+		mdio@24520 {					/* For TSECs */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+
+			PHY0: ethernet-phy@0 {
+				device_type = "ethernet-phy";
+				interrupt-parent = <&MPIC>;
+				interrupts = <0x5 0x1>;
+				reg = <0x1>;
+			};
+
+			PHY1: ethernet-phy@1 {
+				device_type = "ethernet-phy";
+				interrupt-parent = <&MPIC>;
+				interrupts = <0x5 0x1>;
+				reg = <0x4>;
+			};
+
+			PHY2: ethernet-phy@2 {
+				device_type = "ethernet-phy";
+				interrupt-parent = <&MPIC>;
+				interrupts = <0x5 0x1>;
+				reg = <0x5>;
+			};
+
+			PHY3: ethernet-phy@3 {
+				device_type = "ethernet-phy";
+				interrupt-parent = <&MPIC>;
+				interrupts = <0x5 0x1>;
+				reg = <0x6>;
+			};
+		};
+
+		enet0: ethernet@24000 {
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			/* Mac address filled in by bootwrapper */
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
+			interrupt-parent = <&MPIC>;
+			phy-handle = <&PHY0>;
+		};
+
+		enet1: ethernet@25000 {
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			/* Mac address filled in by bootwrapper */
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
+			interrupt-parent = <&MPIC>;
+			phy-handle = <&PHY1>;
+		};
+
+		enet2: ethernet@26000 {
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			/* Mac address filled in by bootwrapper */
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x1f 0x2 0x20 0x2 0x21 0x2>;
+			interrupt-parent = <&MPIC>;
+			phy-handle = <&PHY2>;
+		};
+
+		enet3: ethernet@27000 {
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x27000 0x1000>;
+			/* Mac address filled in by bootwrapper */
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x25 0x2 0x26 0x2 0x27 0x2>;
+			interrupt-parent = <&MPIC>;
+			phy-handle = <&PHY3>;
+		};
+
+		serial0: serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;			/* Filled in by bootwraper */
+			interrupts = <0x2a 0x2>;
+			interrupt-parent = <&MPIC>;
+		};
+
+		serial1: serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;			/* Filled in by bootwraper */
+			interrupts = <0x2a 0x2>;
+			interrupt-parent = <&MPIC>;
+		};
+
+		global-utilities@e0000 {
+			compatible = "fsl,mpc8548-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+
+		MPIC: pic@40000 {
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			device_type = "open-pic";
+			compatible = "chrp,open-pic";
+			reg = <0x40000 0x40000>;
+			interrupt-controller;
+			big-endian;
+		};
+	};
+
+	localbus@ff705000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8548-localbus";
+		reg = <0xff705000 0x68>;
+
+		ranges = <0x1 0x0 0xe0000000 0x01000000
+			  0x2 0x0 0xe1000000 0x01000000
+			  0x4 0x0 0xfc400000 0x00080000>;
+
+		flash@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x1 0x0 0x01000000>;
+			bank-width = <0x2>;
+
+			partition@0 {
+				label = "Primary Kernel";
+				reg = <0x0 0x400000>;
+			};
+
+			partition@400000 {
+				label = "Primary Filesystem";
+				reg = <0x400000 0xb60000>;
+			};
+
+			partition@f60000 {
+				label = "Primary Environment";
+				reg = <0xf60000 0x20000>;
+			};
+
+			partition@f80000 {
+				label = "Primary Monitor";
+				reg = <0xf80000 0x80000>;
+				read-only;
+			};
+		};
+
+		flash@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x2 0x0 0x01000000>;
+			bank-width = <0x2>;
+
+			partition@0 {
+				label = "Secondary Kernel";
+				reg = <0x0 0x400000>;
+			};
+
+			partition@400000 {
+				label = "Secondary Filesystem";
+				reg = <0x400000 0xb60000>;
+			};
+
+			partition@f60000 {
+				label = "Secondary Environment";
+				reg = <0xf60000 0x20000>;
+			};
+
+			partition@f80000 {
+				label = "Secondary Monitor";
+				reg = <0xf80000 0x80000>;
+				read-only;
+			};
+		};
+
+		cpld@4,0 {
+			compatible = "emerson,ATCA-C125-cpld";
+			reg = <0x4 0x0 0x80000>;
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/soc8548/serial@4500";
+	};
+};
