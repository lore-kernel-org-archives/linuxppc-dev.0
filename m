Return-Path: <nm127@freemail.hu>
Received: from relay01.digicable.hu (relay01.digicable.hu [92.249.128.189])
	by ozlabs.org (Postfix) with ESMTP id E548FB7DDA
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 17:26:35 +1100 (EST)
Message-ID: <4B99DE95.8010304@freemail.hu>
Date: Fri, 12 Mar 2010 07:26:29 +0100
From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for
	PowerPC e200 core?)
References: <4B934CCA.8030608@freemail.hu>
	<fa686aa41003080934q5d5bebabl7d582d1264da4dcd@mail.gmail.com>
	<4B95458A.4000304@freemail.hu>
	<fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
	<4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
	<4B9889AC.4080309@freemail.hu> <20100311062331.GI11655@yookeroo>
In-Reply-To: <20100311062331.GI11655@yookeroo>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

thank you for the comments, I reworked the Freescale MPC5554 device tree
accordingly. I'm listening for comments on this draft.

Regards,

	Márton Németh

---
From: Márton Németh <nm127@freemail.hu>

Add device tree for Freescale MPC5554.

Signed-off-by: Márton Németh <nm127@freemail.hu>
---
diff -uprN linux-2.6.33.orig/arch/powerpc/boot/dts/mpc5554.dts linux/arch/powerpc/boot/dts/mpc5554.dts
--- linux-2.6.33.orig/arch/powerpc/boot/dts/mpc5554.dts	1970-01-01 01:00:00.000000000 +0100
+++ linux/arch/powerpc/boot/dts/mpc5554.dts	2010-03-12 07:22:37.000000000 +0100
@@ -0,0 +1,189 @@
+/*
+ * Freescale MPC5554 Device Tree Source
+ *
+ * Based on MPC5553/5554 Microcontroller Reference Manual, Rev. 4.0, 04/2007
+ * http://www.freescale.com/files/32bit/doc/ref_manual/MPC5553_MPC5554_RM.pdf
+ *
+ * Copyright 2010 Márton Németh
+ * Márton Németh <nm127@freemail.hu>
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
+	model = "MPC5554";
+	compatible = "fsl,MPC5554EVB";		// Freescale MPC5554 Evaluation Board
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "PowerPC,5554";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;	// L1, 32KiB
+			i-cache-size = <0x8000>;	// L1, 32KiB
+			timebase-frequency = <0>;	// from bootloader
+			bus-frequency = <0>;		// from bootloader
+			clock-frequency = <0>;		// from bootloader
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x10000>;	// 32KiB internal SRAM
+	};
+
+	xbar@fff04000 {		// System Bus Crossbar Switch (XBAR)
+		compatible = "fsl,mpc5554-xbar";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		// The full memory range is covered by XBAR
+		ranges = <>;
+		reg = <0xfff04000 0x4000>;
+
+		flash@0 {	// read-only FLASH
+			compatible = "fsl,mpc5554-flash";
+			reg = <0x00000000 0x200000>;	// 2MiB internal FLASH
+		};
+
+		bridge@c3f00000 {
+			compatible = "fsl,mpc5554-pbridge-a";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xc0000000 0x20000000>;
+			reg = <0xc3f00000 0x4000>;
+
+			fmpll@3f80000 {		// Frequency Modulated PLL
+				compatible = "fsl,mpc5554-fmpll";
+				reg = <0x03f80000 0x4000>;
+			};
+
+			flashconfig@3f88000 {	// Flash Configuration
+				compatible = "fsl,mpc5554-flashconfig";
+				reg = <0x03f88000 0x4000>;
+			};
+
+			siu@3f89000 {		// System Integration Unit
+				compatible = "fsl,mpc5554-siu";
+				reg = <0x03f90000 0x4000>;
+			};
+
+			emios@3fa0000 {		// Modular Timer System
+				compatible = "fsl,mpc5554-emios";
+				reg = <0x03fa0000 0x4000>;
+			};
+
+			etpu@3fc0000 {		// Enhanced Time Processing Unit
+				compatible = "fsl,mpc5554-etpu";
+				reg = <0x03fc0000 0x4000>;
+			};
+
+			etpudata@3fc8000 {	// eTPU Shared Data Memory (Parameter RAM)
+				compatible = "fsl,mpc5554-etpudata";
+				reg = <0x03fc8000 0x4000>;
+			};
+
+			etpudata@3fcc000 {	// eTPU Shared Data Memory (Parameter RAM) mirror
+				compatible = "fsl,mpc5554-etpudata";
+				reg = <0x03fcc000 0x4000>;
+			};
+
+			etpucode@3fd0000 {		// eTPU Shared Code RAM
+				compatible = "fsl,mpc5554-etpucode";
+				reg = <0x03fd0000 0x4000>;
+			};
+		};
+
+		bridge@fff00000 {
+			compatible = "fsl,mpc5554-pbridge-b";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xe0000000 0x20000000>;
+			reg = <0xfff00000 0x4000>;
+
+			ecsm@fff40000 {		// Error Correction Status Module (ECSM)
+				compatible = "fsl,mpc5554-ecsm";
+				reg = <0xfff40000 0x4000>;
+			};
+
+			edma@fff44000 {		// Enhanced DMA Controller (eDMA)
+				compatible = "fsl,mpc5554-edma";
+				reg = <0xfff44000 0x4000>;
+			};
+
+			intc@fff48000 {		// Interrupt Controller (INTC)
+				compatible = "fsl,mpc5554-intc";
+				reg = <0xfff48000 0x4000>;
+			};
+
+			eqadc@fff80000 {	// Enhanced Queued Analog-to-Digital Converter (eQADC)
+				compatible = "fsl,mpc5554-eqacd";
+				reg = <0xfff80000 0x4000>;
+			};
+
+			dspi@fff90000 {		// Deserial Serial Peripheral Interface (DSPI_A)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0xfff90000 0x4000>;
+			};
+
+			dspi@fff94000 {		// Deserial Serial Peripheral Interface (DSPI_B)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0xfff94000 0x4000>;
+			};
+
+			dspi@fff98000 {		// Deserial Serial Peripheral Interface (DSPI_C)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0xfff98000 0x4000>;
+			};
+
+			dspi@fff9c000 {		// Deserial Serial Peripheral Interface (DSPI_D)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0xfff9c000 0x4000>;
+			};
+
+			sci@fffb0000 {		// Serial Communications Interface (SCI_A)
+				compatible = "fsl,mpc5554-sci";
+				reg = <0xfffb0000 0x4000>;
+			};
+
+			sci@fffb4000 {		// Serial Communications Interface (SCI_B)
+				compatible = "fsl,mpc5554-sci";
+				reg = <0xfffb4000 0x4000>;
+			};
+
+			can@fffc0000 {		// Controller Area Network (FlexCAN_A)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0xfffc0000 0x4000>;
+			};
+
+			can@fffc4000 {		// Controller Area Network (FlexCAN_B)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0xfffc4000 0x4000>;
+			};
+
+			can@fffc8000 {		// Controller Area Network (FlexCAN_C)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0xfffc8000 0x4000>;
+			};
+
+			bam@ffffc000 {		// Boot Assist Module (BAM)
+				compatible = "fsl,mpc5554-bam";
+				reg = <0xffffc000 0x4000>;
+			};
+
+		};
+
+	};
+
+};
