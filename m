Return-Path: <asmirnov@ru.mvista.com>
Received: from spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA695DDE09
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 05:39:19 +1100 (EST)
Received: from spb.rtsoft.ru (spb.rtsoft.ru [127.0.0.1])
	by spb.rtsoft.ru (8.13.5/8.13.5) with ESMTP id m1SIlRUA027288
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 21:47:27 +0300
Received: (from alex@localhost)
	by spb.rtsoft.ru (8.13.5/8.13.5/Submit) id m1SIlR5Y027287
	for linuxppc-dev@ozlabs.org; Thu, 28 Feb 2008 21:47:27 +0300
Date: Thu, 28 Feb 2008 21:47:27 +0300
From: Alexandr Smirnov <asmirnov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] Emerson KSI8560 device tree
Message-ID: <20080228184727.GC26971@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080228183503.GA26971@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


diff --git a/arch/powerpc/boot/dts/ksi8560.dts b/arch/powerpc/boot/dts/ksi8560.dts
new file mode 100644
index 0000000..d6e8d8b
--- /dev/null
+++ b/arch/powerpc/boot/dts/ksi8560.dts
@@ -0,0 +1,269 @@
+/*
+ * Device Tree Source for Emerson KSI8560
+ *
+ * Author: Alexandr Smirnov <asmirnov@ru.mvista.com>
+ *
+ * Based on mpc8560ads.dts
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
+	model = "KSI8560";
+	compatible = "emerson,KSI8560";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8560@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;		/* L1, 32K */
+			i-cache-size = <0x8000>;		/* L1, 32K */
+			timebase-frequency = <0>;		/* From U-boot */
+			bus-frequency = <0>;			/* From U-boot */
+			clock-frequency = <0>;			/* From U-boot */
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;			/* Fixed by bootwrapper */
+	};
+
+	soc@fdf00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x00000000 0xfdf00000 0x00100000>;
+		reg = <0xfdf00000 0x200>;
+		bus-frequency = <0>;				/* Fixed by bootwrapper */
+
+		memory-controller@2000 {
+			compatible = "fsl,8540-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&MPIC>;
+			interrupts = <0x12 0x2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8540-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <0x20>;		/* 32 bytes */
+			cache-size = <0x40000>;			/* L2, 256K */
+			interrupt-parent = <&MPIC>;
+			interrupts = <0x10 0x2>;
+		};
+
+		i2c@3000 {
+			device_type = "i2c";
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
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <0x24520 0x20>;
+
+			PHY1: ethernet-phy@1 {
+				interrupt-parent = <&MPIC>;
+				reg = <0x1>;
+				device_type = "ethernet-phy";
+			};
+
+			PHY2: ethernet-phy@2 {
+				interrupt-parent = <&MPIC>;
+				reg = <0x2>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			linux,network-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			/* Mac address filled in by bootwrapper */
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
+			interrupt-parent = <&MPIC>;
+			phy-handle = <&PHY1>;
+		};
+
+		enet1: ethernet@25000 {
+			linux,network-index = <1>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			/* Mac address filled in by bootwrapper */
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
+			interrupt-parent = <&MPIC>;
+			phy-handle = <&PHY2>;
+		};
+
+		MPIC: pic@40000 {
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0x40000 0x40000>;
+			device_type = "open-pic";
+		};
+
+		cpm@919c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8560-cpm", "fsl,cpm2";
+			reg = <0x919c0 0x30>;
+			ranges;
+
+			muram@80000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x80000 0x10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0x0 0x4000 0x9000 0x2000>;
+				};
+			};
+
+			brg@919f0 {
+				compatible = "fsl,mpc8560-brg",
+					     "fsl,cpm2-brg",
+					     "fsl,cpm-brg";
+				reg = <0x919f0 0x10 0x915f0 0x10>;
+				clock-frequency = <165000000>;	/* 166MHz */
+			};
+
+			CPMPIC: pic@90c00 {
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				interrupts = <0x2e 0x2>;
+				interrupt-parent = <&MPIC>;
+				reg = <0x90c00 0x80>;
+				compatible = "fsl,mpc8560-cpm-pic", "fsl,cpm2-pic";
+			};
+
+			serial@91a00 {
+				device_type = "serial";
+				compatible = "fsl,mpc8560-scc-uart",
+					     "fsl,cpm2-scc-uart";
+				reg = <0x91a00 0x20 0x88000 0x100>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <0x800000>;
+				current-speed = <0x1c200>;
+				interrupts = <0x28 0x8>;
+				interrupt-parent = <&CPMPIC>;
+			};
+
+			serial@91a20 {
+				device_type = "serial";
+				compatible = "fsl,mpc8560-scc-uart",
+					     "fsl,cpm2-scc-uart";
+				reg = <0x91a20 0x20 0x88100 0x100>;
+				fsl,cpm-brg = <2>;
+				fsl,cpm-command = <0x4a00000>;
+				current-speed = <0x1c200>;
+				interrupts = <0x29 0x8>;
+				interrupt-parent = <&CPMPIC>;
+			};
+
+			mdio@90d00 {				/* For FCCs */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				device_type = "mdio";
+				compatible = "fsl,cpm2-mdio-bitbang";
+				reg = <0x90d00 0x14>;
+				fsl,mdio-pin = <24>;
+				fsl,mdc-pin = <25>;
+
+				PHY0: ethernet-phy@0 {
+					interrupt-parent = <&MPIC>;
+					reg = <0x0>;
+					device_type = "ethernet-phy";
+				};
+			};
+
+			enet2: ethernet@91300 {
+				linux,network-index = <2>;
+				device_type = "network";
+				compatible = "fsl,mpc8560-fcc-enet",
+					     "fsl,cpm2-fcc-enet";
+				reg = <0x91300 0x20 0x88400 0x100 0x91390 0x1>;
+				/* Mac address filled in by bootwrapper */
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				fsl,cpm-command = <0x12000300>;
+				interrupts = <0x20 0x8>;
+				interrupt-parent = <&CPMPIC>;
+				phy-handle = <&PHY0>;
+			};
+		};
+	};
+
+	localbus@fdf05000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8560-localbus";
+		reg = <0xfdf05000 0x68>;
+
+		ranges = <0xe0000000 0xe0000000 0x00800000>;
+
+		flash@e0000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "jedec-flash";
+			reg = <0xe0000000 0x800000>;
+			bank-width = <0x2>;
+
+			partition@0 {
+				label = "Primary Kernel";
+				reg = <0x0 0x180000>;
+			};
+			partition@180000 {
+				label = "Primary Filesystem";
+				reg = <0x180000 0x580000>;
+			};
+			partition@700000 {
+				label = "Monitor";
+				reg = <0x300000 0x100000>;
+				read-only;
+			};
+		};
+	};
+
+	cpld@e8080000 {
+		compatible = "altera,maxii";
+		reg = <0xe8080000 0x80000>;
+	};
+
+	chosen {
+		linux,stdout-path = "/soc/cpm/serial@91a00";
+	};
+};
