Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRLVM30cjzDqZj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 23:08:11 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4FD4KNB026119
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 09:08:05 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aedu0ym49-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 09:08:05 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Mon, 15 May 2017 14:08:02 +0100
From: Ivan Mikhaylov <ivan@de.ibm.com>
To: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@ozlabs.au.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/4] arch/powerpc/44x/fsp2: add device tree for fsp2 board
Date: Mon, 15 May 2017 16:07:52 +0300
Message-Id: <20170515130754.59363-3-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a device tree for fsp2 board (476 based).

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 arch/powerpc/boot/dts/fsp2.dts |  608 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 608 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsp2.dts

diff --git a/arch/powerpc/boot/dts/fsp2.dts b/arch/powerpc/boot/dts/fsp2.dts
new file mode 100644
index 0000000..475953a
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsp2.dts
@@ -0,0 +1,608 @@
+/*
+ * Device Tree Source for FSP2
+ *
+ * Copyright 2010,2012 IBM Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "ibm,fsp2";
+	compatible = "ibm,fsp2";
+	dcr-parent = <&{/cpus/cpu@0}>;
+
+	aliases {
+		ethernet0 = &EMAC0;
+		ethernet1 = &EMAC1;
+		serial0 = &UART0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC, 476FSP2";
+			reg = <0x0>;
+			clock-frequency = <0>;    /* Filled in by cuboot */
+			timebase-frequency = <0>; /* Filled in by cuboot */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by
+							     cuboot */
+	};
+
+	clocks {
+		mmc_clk: mmc_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+			clock-output-names = "mmc_clk";
+		};
+	};
+
+	UIC0: uic0 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0x2c0 0x8>;
+	};
+
+	/* "interrupts" field is <bit level bit level>
+	   first pair is non-critical, second is critical */
+	UIC1_0: uic1_0 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <1>;
+		dcr-reg = <0x2c8 0x8>;
+		interrupt-parent = <&UIC0>;
+		interrupts = <21 0x4 4 0x84>;
+	};
+
+	/* PSI and DMA */
+	UIC1_1: uic1_1 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <2>;
+		dcr-reg = <0x350 0x8>;
+		interrupt-parent = <&UIC0>;
+		interrupts = <22 0x4 5 0x84>;
+	};
+
+	/* Ethernet and USB */
+	UIC1_2: uic1_2 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <3>;
+		dcr-reg = <0x358 0x8>;
+		interrupt-parent = <&UIC0>;
+		interrupts = <23 0x4 6 0x84>;
+	};
+
+	/* PLB Errors */
+	UIC1_3: uic1_3 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <4>;
+		dcr-reg = <0x360 0x8>;
+		interrupt-parent = <&UIC0>;
+		interrupts = <24 0x4 7 0x84>;
+	};
+
+	UIC1_4: uic1_4 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <5>;
+		dcr-reg = <0x368 0x8>;
+		interrupt-parent = <&UIC0>;
+		interrupts = <25 0x4 8 0x84>;
+	};
+
+	UIC1_5: uic1_5 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <6>;
+		dcr-reg = <0x370 0x8>;
+		interrupt-parent = <&UIC0>;
+		interrupts = <26 0x4 9 0x84>;
+	};
+
+	/* 2nd level UICs for FSI */
+	UIC2_0: uic2_0 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <7>;
+		dcr-reg = <0x2d0 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <16 0x4 0 0x84>;
+	};
+
+	UIC2_1: uic2_1 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <8>;
+		dcr-reg = <0x2d8 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <17 0x4 1 0x84>;
+	};
+
+	UIC2_2: uic2_2 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <9>;
+		dcr-reg = <0x2e0 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <18 0x4 2 0x84>;
+	};
+
+	UIC2_3: uic2_3 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <10>;
+		dcr-reg = <0x2e8 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <19 0x4 3 0x84>;
+	};
+
+	UIC2_4: uic2_4 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <11>;
+		dcr-reg = <0x2f0 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <20 0x4 4 0x84>;
+	};
+
+	UIC2_5: uic2_5 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <12>;
+		dcr-reg = <0x2f8 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <21 0x4 5 0x84>;
+	};
+
+	UIC2_6: uic2_6 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <13>;
+		dcr-reg = <0x300 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <22 0x4 6 0x84>;
+	};
+
+	UIC2_7: uic2_7 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <14>;
+		dcr-reg = <0x308 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <23 0x4 7 0x84>;
+	};
+
+	UIC2_8: uic2_8 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <15>;
+		dcr-reg = <0x310 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <24 0x4 8 0x84>;
+	};
+
+	UIC2_9: uic2_9 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <16>;
+		dcr-reg = <0x318 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <25 0x4 9 0x84>;
+	};
+
+	UIC2_10: uic2_10 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <17>;
+		dcr-reg = <0x320 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <26 0x4 10 0x84>;
+	};
+
+	UIC2_11: uic2_11 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <18>;
+		dcr-reg = <0x328 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <27 0x4 11 0x84>;
+	};
+
+	UIC2_12: uic2_12 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <19>;
+		dcr-reg = <0x330 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <28 0x4 12 0x84>;
+	};
+
+	UIC2_13: uic2_13 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <20>;
+		dcr-reg = <0x338 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <29 0x4 13 0x84>;
+	};
+
+	UIC2_14: uic2_14 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <21>;
+		dcr-reg = <0x340 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <30 0x4 14 0x84>;
+	};
+
+	UIC2_15: uic2_15 {
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <22>;
+		dcr-reg = <0x348 0x8>;
+		interrupt-parent = <&UIC1_0>;
+		interrupts = <31 0x4 15 0x84>;
+	};
+
+	mmc0: sdhci@020c0000 {
+		compatible	= "st,sdhci-stih407", "st,sdhci";
+		status		= "disabled";
+		reg		= <0x020c0000 0x20000>;
+		reg-names	= "mmc";
+		interrupt-parent = <&UIC1_3>;
+		interrupts	= <21 0x4 22 0x4>;
+		interrupt-names	= "mmcirq";
+		pinctrl-names	= "default";
+		pinctrl-0	= <>;
+		clock-names	= "mmc";
+		clocks		= <&mmc_clk>;
+	};
+
+	plb6 {
+		compatible = "ibm,plb6";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		MCW0: memory-controller-wrapper {
+			compatible = "ibm,cw-476fsp2";
+			dcr-reg = <0x11111800 0x40>;
+		};
+
+		MCIF0: memory-controller {
+			compatible = "ibm,sdram-476fsp2", "ibm,sdram-4xx-ddr3";
+			dcr-reg = <0x11120000 0x10000>;
+			mcer-device = <&MCW0>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <10 0x84   /* ECC UE */
+				      11 0x84>; /* ECC CE */
+		};
+	};
+
+	plb4 {
+		compatible = "ibm,plb4";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00000000 0x00000010 0x00000000 0x80000000
+			  0x80000000 0x00000010 0x80000000 0x80000000>;
+		clock-frequency = <333333334>;
+
+		plb6-system-hung-irq {
+			compatible = "ibm,bus-error-irq";
+			#interrupt-cells = <2>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <0 0x84>;
+		};
+
+		l2-error-irq {
+			compatible = "ibm,bus-error-irq";
+			#interrupt-cells = <2>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <20 0x84>;
+		};
+
+		plb6-plb4-irq {
+			compatible = "ibm,bus-error-irq";
+			#interrupt-cells = <2>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <1 0x84>;
+		};
+
+		plb4-ahb-irq {
+			compatible = "ibm,bus-error-irq";
+			#interrupt-cells = <2>;
+			interrupt-parent = <&UIC1_3>;
+			interrupts = <20 0x84>;
+		};
+
+		opbd-error-irq {
+			compatible = "ibm,opbd-error-irq";
+			#interrupt-cells = <2>;
+			interrupt-parent = <&UIC1_4>;
+			interrupts = <5 0x84>;
+		};
+
+		cmu-error-irq {
+			compatible = "ibm,cmu-error-irq";
+			#interrupt-cells = <2>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <28 0x84>;
+		};
+
+		conf-error-irq {
+			compatible = "ibm,conf-error-irq";
+			#interrupt-cells = <2>;
+			interrupt-parent = <&UIC1_4>;
+			interrupts = <11 0x84>;
+		};
+
+		mc-ue-irq {
+			compatible = "ibm,mc-ue-irq";
+			#interrupt-cells = <2>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <10 0x84>;
+		};
+
+		reset-warning-irq {
+			compatible = "ibm,reset-warning-irq";
+			#interrupt-cells = <2>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <17 0x84>;
+		};
+
+		MAL0: mcmal0 {
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			compatible = "ibm,mcmal";
+			dcr-reg = <0x80 0x80>;
+			num-tx-chans = <1>;
+			num-rx-chans = <1>;
+			interrupt-parent = <&MAL0>;
+			interrupts = <0 1 2 3 4>;
+			/* index interrupt-parent interrupt# type */
+			interrupt-map = </*TXEOB*/ 0 &UIC1_2 4 0x4
+					 /*RXEOB*/ 1 &UIC1_2 3 0x4
+					 /*SERR*/  2 &UIC1_2 7 0x4
+					 /*TXDE*/  3 &UIC1_2 6 0x4
+					 /*RXDE*/  4 &UIC1_2 5 0x4>;
+		};
+
+		MAL1: mcmal1 {
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			compatible = "ibm,mcmal";
+			dcr-reg = <0x100 0x80>;
+			num-tx-chans = <1>;
+			num-rx-chans = <1>;
+			interrupt-parent = <&MAL1>;
+			interrupts = <0 1 2 3 4>;
+			/* index interrupt-parent interrupt# type */
+			interrupt-map = </*TXEOB*/ 0 &UIC1_2 12 0x4
+					 /*RXEOB*/ 1 &UIC1_2 11 0x4
+					 /*SERR*/  2 &UIC1_2 15 0x4
+					 /*TXDE*/  3 &UIC1_2 14 0x4
+					 /*RXDE*/  4 &UIC1_2 13 0x4>;
+		};
+
+		opb {
+			compatible = "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges; // pass-thru to parent bus
+			clock-frequency = <83333334>;
+
+			EMAC0: ethernet@b0000000 {
+				linux,network-index = <0>;
+				device_type = "network";
+				compatible = "ibm,emac4sync";
+				has-inverted-stacr-oc;
+				interrupt-parent = <&UIC1_2>;
+				interrupts = <1 0x4 0 0x4>;
+				reg = <0xb0000000 0x100>;
+				local-mac-address = [000000000000]; /* Filled in by
+							       cuboot */
+				mal-device = <&MAL0>;
+				mal-tx-channel = <0>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <4096>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <8192>;
+				phy-address = <1>;
+				phy-mode = "rgmii";
+				phy-map = <00000003>;
+				rgmii-device = <&RGMII>;
+				rgmii-channel = <0>;
+			};
+
+			EMAC1: ethernet@b0000100 {
+				linux,network-index = <1>;
+				device_type = "network";
+				compatible = "ibm,emac4sync";
+				has-inverted-stacr-oc;
+				interrupt-parent = <&UIC1_2>;
+				interrupts = <9 0x4 8 0x4>;
+				reg = <0xb0000100 0x100>;
+				local-mac-address = [000000000000]; /* Filled in by
+							       cuboot */
+				mal-device = <&MAL1>;
+				mal-tx-channel = <0>;
+				mal-rx-channel = <0>;
+				cell-index = <1>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <4096>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <8192>;
+				phy-address = <2>;
+				phy-mode = "rgmii";
+				phy-map = <00000003>;
+				rgmii-device = <&RGMII>;
+				rgmii-channel = <1>;
+			};
+
+			RGMII: rgmii@b0000600 {
+				compatible = "ibm,rgmii";
+				has-mdio;
+				reg = <0xb0000600 0x8>;
+			};
+
+			UART0: serial@b0020000 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <0xb0020000 0x8>;
+				virtual-reg = <0xb0020000>;
+				clock-frequency = <20833333>;
+				current-speed = <115200>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <31 0x4>;
+			};
+		};
+
+		OHCI1: ohci@02040000 {
+			compatible = "ohci-le";
+			reg = <0x02040000 0xa0>;
+			interrupt-parent = <&UIC1_3>;
+			interrupts = <28 0x8 29 0x8>;
+		};
+
+		OHCI2: ohci@02080000 {
+			compatible = "ohci-le";
+			reg = <0x02080000 0xa0>;
+			interrupt-parent = <&UIC1_3>;
+			interrupts = <30 0x8 31 0x8>;
+		};
+
+		EHCI: ehci@02000000 {
+			compatible = "usb-ehci";
+			reg = <0x02000000 0xa4>;
+			interrupt-parent = <&UIC1_3>;
+			interrupts = <23 0x4>;
+		};
+
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@b0020000";
+		bootargs = "console=ttyS0,115200 rw log_buf_len=32768 debug";
+	};
+};
-- 
1.7.1
