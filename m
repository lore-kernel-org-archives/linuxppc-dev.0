Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 33DC7DDF83
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 04:30:17 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m0SHSxGm006206
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 10:29:00 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [Add mpc5121 support PATCH v4 2/4] Device tree for MPC5121 ADS
Date: Mon, 28 Jan 2008 10:28:54 -0700
Message-Id: <1201541336-28676-3-git-send-email-jrigby@freescale.com>
In-Reply-To: <1201541336-28676-2-git-send-email-jrigby@freescale.com>
References: <1201541336-28676-1-git-send-email-jrigby@freescale.com>
	<1201541336-28676-2-git-send-email-jrigby@freescale.com>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Minimal /dts-v1/ device tree for mpc5121 ads.

port-number property in uart nodes
will go away after the driver learns to use aliases

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/boot/dts/mpc5121ads.dts |  122 ++++++++++++++++++++++++++++++++++
 1 files changed, 122 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc5121ads.dts

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
new file mode 100644
index 0000000..94ad7b2
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -0,0 +1,122 @@
+/*
+ * MPC5121E MDS Device Tree Source
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "mpc5121ads";
+	compatible = "fsl,mpc5121ads";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,5121@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <0x20>;	// 32 bytes
+			i-cache-line-size = <0x20>;	// 32 bytes
+			d-cache-size = <0x8000>;	// L1, 32K
+			i-cache-size = <0x8000>;	// L1, 32K
+			timebase-frequency = <49500000>;// 49.5 MHz (csb/4)
+			bus-frequency = <198000000>;	// 198 MHz csb bus
+			clock-frequency = <396000000>;	// 396 MHz ppc core
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;	// 256MB at 0
+	};
+
+	localbus@80000020 {
+		compatible = "fsl,mpc5121ads-localbus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0x80000020 0x40>;
+
+		ranges = <0x0 0x0 0xfc000000 0x04000000
+			  0x2 0x0 0x82000000 0x00008000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0x0 0x4000000>;
+			bank-width = <4>;
+			device-width = <1>;
+		};
+
+		board-control@2,0 {
+			compatible = "fsl,mpc5121ads-cpld";
+			reg = <0x2 0x0 0x8000>;
+		};
+	};
+
+	soc@80000000 {
+		compatible = "fsl,mpc5121-immr";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		ranges = <0x0 0x80000000 0x400000>;
+		reg = <0x80000000 0x400000>;
+		bus-frequency = <66000000>;	// 66 MHz ips bus
+
+
+		// IPIC
+		// interrupts cell = <intr #, sense>
+		// sense values match linux IORESOURCE_IRQ_* defines:
+		// sense == 8: Level, low assertion
+		// sense == 2: Edge, high-to-low change
+		//
+		ipic: interrupt-controller@c00 {
+			compatible = "fsl,mpc5121-ipic", "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0xc00 0x100>;
+		};
+
+		// 512x PSCs are not 52xx PSCs compatible
+		// PSC3 serial port A aka ttyPSC0
+		serial@11300 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart";
+			// Logical port assignment needed until driver
+			// learns to use aliases
+			port-number = <0>;
+			cell-index = <3>;
+			reg = <0x11300 0x100>;
+			interrupts = <0x28 0x8>; // actually the fifo irq
+			interrupt-parent = < &ipic >;
+		};
+
+		// PSC4 serial port B aka ttyPSC1
+		serial@11400 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart";
+			// Logical port assignment needed until driver
+			// learns to use aliases
+			port-number = <1>;
+			cell-index = <4>;
+			reg = <0x11400 0x100>;
+			interrupts = <0x28 0x8>; // actually the fifo irq
+			interrupt-parent = < &ipic >;
+		};
+
+		pscsfifo@11f00 {
+			compatible = "fsl,mpc5121-psc-fifo";
+			reg = <0x11f00 0x100>;
+			interrupts = <0x28 0x8>;
+			interrupt-parent = < &ipic >;
+		};
+	};
+};
-- 
1.5.3.8
