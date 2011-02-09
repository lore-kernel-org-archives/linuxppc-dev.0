Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14514B71C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 10:10:35 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p19ImPhW030085
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 13:52:24 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 487BF72825F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 18:09:26 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p19N8HXQ320886
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 18:08:17 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p19N8GM4027439
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 18:08:17 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 6/6] powerpc/476: Create a dts files for two 476 AMP
	instances under ISS
Date: Wed,  9 Feb 2011 17:08:13 -0600
Message-Id: <1297292893-30241-7-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1297292893-30241-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1297292893-30241-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are completely independent OS instances, each running on 2 cores.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/boot/Makefile            |    6 ++-
 arch/powerpc/boot/dts/iss476-amp1.dts |  119 ++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/iss476-amp2.dts |  120 +++++++++++++++++++++++++++++++++
 arch/powerpc/boot/wrapper             |    7 ++
 4 files changed, 251 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/iss476-amp1.dts
 create mode 100644 arch/powerpc/boot/dts/iss476-amp2.dts

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8917816..99dbc39 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -45,6 +45,8 @@ $(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
 $(obj)/cuboot-acadia.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-iss4xx.o: BOOTCFLAGS += -mcpu=405
+$(obj)/treeboot-iss476-amp1.o: BOOTCFLAGS += -mcpu=405
+$(obj)/treeboot-iss476-amp2.o: BOOTCFLAGS += -mcpu=405
 $(obj)/virtex405-head.o: BOOTAFLAGS += -mcpu=405
 
 
@@ -208,7 +210,9 @@ image-$(CONFIG_KATMAI)			+= cuImage.katmai
 image-$(CONFIG_WARP)			+= cuImage.warp
 image-$(CONFIG_YOSEMITE)		+= cuImage.yosemite
 image-$(CONFIG_ISS4xx)			+= treeImage.iss4xx \
-					   treeImage.iss4xx-mpic
+					   treeImage.iss4xx-mpic \
+					   treeImage.iss476-amp1 \
+					   treeImage.iss476-amp2
 
 # Board ports in arch/powerpc/platform/8xx/Kconfig
 image-$(CONFIG_MPC86XADS)		+= cuImage.mpc866ads
diff --git a/arch/powerpc/boot/dts/iss476-amp1.dts b/arch/powerpc/boot/dts/iss476-amp1.dts
new file mode 100644
index 0000000..1fa882c
--- /dev/null
+++ b/arch/powerpc/boot/dts/iss476-amp1.dts
@@ -0,0 +1,119 @@
+/*
+ * Device Tree Source for IBM Embedded PPC 476 Platform
+ *
+ * Copyright 2010 Torez Smith, IBM Corporation.
+ *
+ * Based on earlier code:
+ *     Copyright (c) 2006, 2007 IBM Corp.
+ *     Josh Boyer <jwboyer@linux.vnet.ibm.com>, David Gibson <dwg@au1.ibm.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "ibm,iss-4xx";
+	compatible = "ibm,iss-4xx";
+	cooperative-partition;
+	dcr-parent = <&{/cpus/cpu@0}>;
+
+	aliases {
+		serial0 = &UART0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC,4xx";
+			reg = <0>;
+			clock-frequency = <100000000>; // 100Mhz :-)
+			timebase-frequency = <100000000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+			status = "okay";
+		};
+		cpu@1 {
+			device_type = "cpu";
+			model = "PowerPC,4xx"; // real CPU changed in sim
+			reg = <1>;
+			clock-frequency = <100000000>; // 100Mhz :-)
+			timebase-frequency = <100000000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+			status = "disabled";
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x01f00100>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg =  <0x00000000 0x00000000 0x02000000>;
+
+	};
+
+	MPIC: interrupt-controller {
+		compatible = "chrp,open-pic";
+		interrupt-controller;
+		dcr-reg = <0xffc00000 0x00030000>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		protected-sources = <1>;	/* uart */
+
+	};
+
+	plb {
+		compatible = "ibm,plb-4xx", "ibm,plb4"; /* Could be PLB6, doesn't matter */
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; // Filled in by zImage
+
+		POB0: opb {
+			compatible = "ibm,opb-4xx", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* Wish there was a nicer way of specifying a full 32-bit
+			   range */
+			ranges = <0x00000000 0x00000001 0x00000000 0x80000000
+				  0x80000000 0x00000001 0x80000000 0x80000000>;
+			clock-frequency = <0>; // Filled in by zImage
+			UART0: serial@40000200 {
+				device_type = "serial";
+				compatible = "ns16550a";
+				reg = <0x40000200 0x00000008>;
+				virtual-reg = <0xe0000200>;
+				clock-frequency = <11059200>;
+				current-speed = <115200>;
+				interrupt-parent = <&MPIC>;
+				interrupts = <0x0 0x2>;
+			};
+		};
+	};
+
+	nvrtc {
+		compatible = "ds1743-nvram", "ds1743", "rtc-ds1743";
+		reg = <0 0xEF703000 0x2000>;
+	};
+
+	chosen {
+		linux,stdout-path = &UART0;
+	};
+};
diff --git a/arch/powerpc/boot/dts/iss476-amp2.dts b/arch/powerpc/boot/dts/iss476-amp2.dts
new file mode 100644
index 0000000..09b4c57
--- /dev/null
+++ b/arch/powerpc/boot/dts/iss476-amp2.dts
@@ -0,0 +1,120 @@
+/*
+ * Device Tree Source for IBM Embedded PPC 476 Platform
+ *
+ * Copyright 2010 Torez Smith, IBM Corporation.
+ *
+ * Based on earlier code:
+ *     Copyright (c) 2006, 2007 IBM Corp.
+ *     Josh Boyer <jwboyer@linux.vnet.ibm.com>, David Gibson <dwg@au1.ibm.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "ibm,iss-4xx";
+	compatible = "ibm,iss-4xx";
+	cooperative-partition;
+	dcr-parent = <&{/cpus/cpu@2}>;
+
+	aliases {
+		serial0 = &UART0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@2 {
+			device_type = "cpu";
+			model = "PowerPC,4xx";
+			reg = <2>;
+			clock-frequency = <100000000>; // 100Mhz :-)
+			timebase-frequency = <100000000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+			status = "okay";
+		};
+		cpu@3 {
+			device_type = "cpu";
+			model = "PowerPC,4xx"; // real CPU changed in sim
+			reg = <3>;
+			clock-frequency = <100000000>; // 100Mhz :-)
+			timebase-frequency = <100000000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+			status = "disabled";
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x11f00300>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = < 0x0 0x10000000 0x02000000 >;
+
+	};
+
+	MPIC: interrupt-controller {
+		compatible = "chrp,open-pic";
+		interrupt-controller;
+		dcr-reg = <0xffc00000 0x00030000>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		protected-sources = <0>;	/* uart */
+
+	};
+
+	plb {
+		compatible = "ibm,plb-4xx", "ibm,plb4"; /* Could be PLB6, doesn't matter */
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; // Filled in by zImage
+
+		POB0: opb {
+			compatible = "ibm,opb-4xx", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* Wish there was a nicer way of specifying a full 32-bit
+			   range */
+			ranges = <0x00000000 0x00000001 0x00000000 0x80000000
+				  0x80000000 0x00000001 0x80000000 0x80000000>;
+			clock-frequency = <0>; // Filled in by zImage
+			UART0: serial@40001200 {
+				device_type = "serial";
+				compatible = "ns16550a";
+				reg = <0x40001200 0x00000008>;
+				virtual-reg = <0xe0001200>;
+				clock-frequency = <11059200>;
+				current-speed = <115200>;
+				interrupt-parent = <&MPIC>;
+				interrupts = <0x1 0x2>;
+			};
+		};
+	};
+
+	nvrtc {
+		compatible = "ds1743-nvram", "ds1743", "rtc-ds1743";
+		reg = <0 0xEF703000 0x2000>;
+	};
+
+	chosen {
+		bootargs = "uart_addr=0xf0001200";
+		linux,stdout-path = &UART0;
+	};
+};
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index cb97e75..8e6ca36 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -244,6 +244,13 @@ gamecube|wii)
 treeboot-iss4xx-mpic)
     platformo="$object/treeboot-iss4xx.o"
     ;;
+treeboot-iss476-amp1)
+    platformo="$object/treeboot-iss4xx.o"
+    ;;
+treeboot-iss476-amp2)
+    platformo="$object/treeboot-iss4xx.o"
+    link_address='0x10400000'
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
-- 
1.7.3.4
