Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64A75DDE26
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 09:37:46 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1JHRkS-0005du-O1
	for linuxppc-dev@ozlabs.org; Tue, 22 Jan 2008 16:37:43 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3 v3] Add StorCenter DTS first draft.
Date: Tue, 22 Jan 2008 16:37:40 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JHRkS-0005du-O1@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Based on the Kurobox DTS files.

Signed-off-by: Andy Wilcox <andy@protium.com>
Signed-off-by: Jon Loeliger <jdl@jdl.com>
---
 arch/powerpc/boot/dts/storcenter.dts |  139 ++++++++++++++++++++++++++++++++++
 1 files changed, 139 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/storcenter.dts

diff --git a/arch/powerpc/boot/dts/storcenter.dts b/arch/powerpc/boot/dts/storcenter.dts
new file mode 100644
index 0000000..fd2f3aa
--- /dev/null
+++ b/arch/powerpc/boot/dts/storcenter.dts
@@ -0,0 +1,139 @@
+/*
+ * Device Tree Source for IOMEGA StorCenter
+ *
+ * Copyright 2007 Oyvind Repvik
+ * Copyright 2007 Jon Loeliger
+ *
+ * Based on the Kurobox DTS by G. Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	model = "StorCenter";
+	compatible = "storcenter";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8241@0 {
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <d# 200000000>;	/* Hz */
+			timebase-frequency = <d# 25000000>;	/* Hz */
+			bus-frequency = <0>;	/* from bootwrapper */
+			i-cache-line-size = <d# 32>;	/* bytes */
+			d-cache-line-size = <d# 32>;	/* bytes */
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
+	soc@fc000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,mpc8241", "mpc10x";
+		store-gathering = <0>; /* 0 == off, !0 == on */
+		ranges = <0 fc000000 100000>;
+		reg = <fc000000 100000>;	/* EUMB */
+		bus-frequency = <0>;		/* fixed by loader */
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl-i2c";
+			reg = <3000 1000>;
+			interrupts = <5 2>;
+			interrupt-parent = <&mpic>;
+
+			rtc@68 {
+				compatible = "dallas,ds1337";
+				reg = <68>;
+			};
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 20>;
+			clock-frequency = <d# 97553800>; /* Hz */
+			current-speed = <d# 115200>;
+			interrupts = <9 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 20>;
+			clock-frequency = <d# 97553800>; /* Hz */
+			current-speed = <d# 9600>;
+			interrupts = <a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: interrupt-controller@40000 {
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			device_type = "open-pic";
+			compatible = "chrp,open-pic";
+			interrupt-controller;
+			reg = <40000 40000>;
+		};
+
+	};
+
+	pci0: pci@fe800000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "mpc10x-pci";
+		reg = <fe800000 1000>;
+		ranges = <01000000 0        0 fe000000 0 00c00000
+			  02000000 0 80000000 80000000 0 70000000>;
+		bus-range = <0 ff>;
+		clock-frequency = <d# 97553800>; /* Hz */
+		interrupt-parent = <&mpic>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 13 - IDE */
+			6800 0 0 1 &mpic 0 1
+			6800 0 0 2 &mpic 0 1
+			6800 0 0 3 &mpic 0 1
+			/* IDSEL 14 - USB */
+			7000 0 0 1 &mpic 0 1
+			7000 0 0 2 &mpic 0 1
+			7000 0 0 3 &mpic 0 1
+			7000 0 0 4 &mpic 0 1
+			/* IDSEL 15 - ETH */
+			7800 0 0 1 &mpic 0 1
+			7800 0 0 2 &mpic 0 1
+			7800 0 0 3 &mpic 0 1
+			7800 0 0 4 &mpic 0 1
+		>;
+	};
+
+	chosen {
+		linux,stdout-path = "/soc/serial@4500";
+	};
+};
-- 
1.5.4.rc0
