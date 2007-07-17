Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD926DDE0C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 00:22:09 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1IAnwC-0003Xm-6U
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 09:22:05 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add StorCenter DTS first draft.
Date: Tue, 17 Jul 2007 09:22:04 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IAnwC-0003Xm-6U@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Based on the Kurobox DTS files.

Signed-off-by: Oyvind Repvik <nail@nslu2-linux.org>
Signed-off-by: Jon Loeliger <jdl@jdl.com>
---

Comments welcome, of course.


 arch/powerpc/boot/dts/storcenter.dts |  142 ++++++++++++++++++++++++++++++++++
 1 files changed, 142 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/storcenter.dts

diff --git a/arch/powerpc/boot/dts/storcenter.dts b/arch/powerpc/boot/dts/storcenter.dts
new file mode 100644
index 0000000..87193fa
--- /dev/null
+++ b/arch/powerpc/boot/dts/storcenter.dts
@@ -0,0 +1,142 @@
+/*
+ * Device Tree Source for IOMEGA StorCenter
+ *
+ * Copyright 2007 Oyvind Repvik, Jon Loeliger
+ *
+ * Based on the Kurobox DTS by G. Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * build using:
+ *    dtc -f -b 0 -I dts -O dtb -o storcenter.dtb storcenter.dts
+ */
+
+/ {
+	model = "StorCenter";
+	compatible = "storcenter";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,603e {			/* Really 8241 */
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <d# 200000000>;	/* Hz */
+			timebase-frequency = <d# 33333333>;	/* Hz */
+			bus-frequency = <0>;
+			/* Following required by dtc but not used */
+			i-cache-line-size = <0>;
+			d-cache-line-size = <0>;
+			i-cache-size = <4000>;
+			d-cache-size = <4000>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 04000000>;	/* 64MB @ 0x0 */
+	};
+
+	flash@ff800000 {
+		device_type = "rom";
+		compatible = "direct-mapped";
+		probe-type = "CFI";
+		reg = <ff800000 00800000>;
+		bank-width = <1>;
+		partitions = <
+				00000000 0000E000
+				0000E000 00002000
+				00010000 00040000
+				00050000 00200000
+				00250000 004B0000
+				00700000 00020000
+				00720000 00010000
+				00730000 00010000
+				00740000 000B0000
+		>;
+		partition-names = "uboot2env", "dtb", "uboot2",
+				  "emkernel", "emfs", "uboot1",
+				  "empty", "uboot1-env", "SysConf";
+	};
+
+
+	soc10x {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		compatible = "mpc10x";
+		store-gathering = <0>; /* 0 == off, !0 == on */
+		reg = <80000000 00100000>;
+		ranges = <80000000 80000000 70000000	/* pci mem space */
+			  fdf00000 fdf00000 00100000	/* EUMB */
+			  fe000000 fe000000 00c00000	/* pci i/o space */
+			  fec00000 fec00000 00300000	/* pci cfg regs */
+			  fef00000 fef00000 00100000>;	/* pci iack */
+
+		i2c@fdf03000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <fdf03000 1000>;
+			interrupts = <5 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial@fdf04500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <fdf04500 8>;
+			clock-frequency = <d# 100000000>; /* Hz */
+			current-speed = <d# 115200>;
+			interrupts = <9 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial@fdf04600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <fdf04600 8>;
+			clock-frequency = <d# 100000000>; /* Hz */
+			current-speed = <d# 19200>;
+			interrupts = <a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@fdf40000 {
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			device_type = "open-pic";
+			compatible = "chrp,open-pic";
+			interrupt-controller;
+			reg = <fdf40000 40000>;
+			built-in;
+		};
+
+		pci@fe800000 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			compatible = "mpc10x-pci";
+			reg = <fe800000 400000>;
+			ranges = <01000000 0        0 fe000000 0 00c00000
+				  02000000 0 80000000 80000000 0 70000000>;
+			bus-range = <0 ff>;
+			clock-frequency = <d# 100000000>; /* Hz */
+			interrupt-parent = <&mpic>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x15 - ETH */
+				7800 0 0 1 &mpic 0 1
+				7800 0 0 2 &mpic 0 1
+				7800 0 0 3 &mpic 0 1
+				7800 0 0 4 &mpic 0 1 
+			>;
+		};
+	};
+};
-- 
1.5.2.2.249.g45fd
