Return-Path: <jrigby@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3D14DDDE1A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 08:37:41 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m0GLbVel012305
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 14:37:31 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-34.am.freescale.net
	[10.214.72.34])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0GLbSnq018969
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 15:37:30 -0600 (CST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [Add mpc5121 support PATCH v2 4/8] Device tree for MPC5121 ADS
Date: Wed, 16 Jan 2008 14:37:23 -0700
Message-Id: <1200519447-25555-4-git-send-email-jrigby@freescale.com>
In-Reply-To: <1200519447-25555-3-git-send-email-jrigby@freescale.com>
References: <1200519447-25555-1-git-send-email-jrigby@freescale.com>
	<1200519447-25555-2-git-send-email-jrigby@freescale.com>
	<1200519447-25555-3-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Minimal tree for mpc5121 ads.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/boot/dts/mpc5121ads.dts |  116 ++++++++++++++++++++++++++++++++++
 1 files changed, 116 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc5121ads.dts

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
new file mode 100644
index 0000000..fac1f15
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -0,0 +1,116 @@
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
+/ {
+	model = "MPC5121ADS";
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
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <d#49500000>; // 49.5 MHz (csb/4)
+			bus-frequency = <d#198000000>;	// 198 MHz csb bus
+			clock-frequency = <d#396000000>;// 396 MHz ppc core
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 10000000>;	// 256MB at 0
+	};
+
+	localbus@80000020 {
+		compatible = "fsl,mpc5121ads_localbus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <80000020 40>;
+
+		ranges = <0 0 fc000000 04000000
+			  2 0 82000000 00008000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 4000000>;
+			bank-width = <4>;
+			device-width = <1>;
+		};
+
+		board-control@2,0 {
+			compatible = "fsl,mpc5121ads-cpld";
+			reg = <2 0 8000>;
+		};
+	};
+
+	soc@80000000 {
+		compatible = "fsl,mpc5121-immr";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		ranges = <0 80000000 400000>;
+		reg = <80000000 400000>;
+		bus-frequency = <d#66000000>;	// 66 MHz ips bus
+
+
+		// IPIC
+		// interrupts cell = <intr #, sense>
+		// sense values match linux IORESOURCE_IRQ_* defines:
+		// sense == 8: Level, low assertion
+		// sense == 2: Edge, high-to-low change
+		//
+		ipic: interrupt-controller@c00 {
+			compatible = "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <c00 100>;
+		};
+
+		// 512x PSCs are not 52xx PSCs compatible
+		// PSC3 serial port A aka ttyPSC0
+		serial@11300 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart";
+			port-number = <0>;  // Logical port assignment
+			cell-index = <3>;
+			reg = <11300 100>;
+			interrupts = <28 8>; // actually the fifo irq
+			interrupt-parent = < &ipic >;
+		};
+
+		// PSC4 serial port B aka ttyPSC1
+		serial@11400 {
+			device_type = "serial";
+			compatible = "fsl,mpc5121-psc-uart";
+			port-number = <1>;  // Logical port assignment
+			cell-index = <4>;
+			reg = <11400 100>;
+			interrupts = <28 8>; // actually the fifo irq
+			interrupt-parent = < &ipic >;
+		};
+
+		pscsfifo@11f00 {
+			compatible = "fsl,mpc512x-psc-fifo";
+			reg = <11f00 100>;
+			interrupts = <28 8>;
+			interrupt-parent = < &ipic >;
+		};
+	};
+};
-- 
1.5.3.5.726.g41a7a
