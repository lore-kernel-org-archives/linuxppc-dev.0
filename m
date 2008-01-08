Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 728E6DE000
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 03:01:42 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m08G1bGV026094
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 09:01:37 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-80.am.freescale.net
	[10.214.72.80])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m08G1XJK004714
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 10:01:36 -0600 (CST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/7] Device tree for MPC5121 ADS
Date: Tue,  8 Jan 2008 09:01:30 -0700
Message-Id: <1199808093-15929-5-git-send-email-jrigby@freescale.com>
In-Reply-To: <1199808093-15929-4-git-send-email-jrigby@freescale.com>
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bare minimum tree containing only
what is currently supported.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/boot/dts/mpc5121ads.dts |  102 ++++++++++++++++++++++++++++++++++
 1 files changed, 102 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc5121ads.dts

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
new file mode 100644
index 0000000..26471ff
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -0,0 +1,102 @@
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
+	compatible = "MPC5121ADS";
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
+			ref-frequency = <3ef1480>;	// 66MHz ref clock
+			timebase-frequency = <2f34f60>; // 49.5MHz (396MHz/8) makes time tick correctly
+			bus-frequency = <bcd3d80>;	// 198MHz csb bus
+			clock-frequency = <179a7b00>;	// 396MHz ppc core ??
+			32-bit;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 10000000>;	// 256MB at 0
+	};
+
+	cpld@82000000 {
+		device_type = "board-control";
+		reg = <82000000 8000>;
+	};
+
+	soc5121@80000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 80000000 400000>;
+		reg = <80000000 400000>;
+		ref-frequency = <3ef1480>;	// 66MHz ref
+		bus-frequency = <5e69ec0>;	// 99MHz ips ref
+
+		// IPIC
+		// interrupts cell = <intr #, sense>
+		// sense values match linux IORESOURCE_IRQ_* defines:
+		// sense == 8: Level, low assertion
+		// sense == 2: Edge, high-to-low change
+		//
+		ipic: pic@c00 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <c00 100>;
+			built-in;
+			device_type = "ipic";
+		};
+
+		// 512x PSCs are not 52xx PSCs compatible
+		// PSC3 serial port A aka ttyPSC0
+		serial@11300 {
+			device_type = "serial";
+			compatible = "mpc512x-psc-uart";
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
+			compatible = "mpc512x-psc-uart";
+			port-number = <1>;  // Logical port assignment
+			cell-index = <4>;
+			reg = <11400 100>;
+			interrupts = <28 8>; // actually the fifo irq
+			interrupt-parent = < &ipic >;
+		};
+
+		pscsfifo@11f00 {
+			compatible = "mpc512x-pscsfifo";
+			reg = <11f00 100>;
+			interrupts = <28 8>;
+			interrupt-parent = < &ipic >;
+		};
+	};
+};
-- 
1.5.3.5.726.g41a7a
