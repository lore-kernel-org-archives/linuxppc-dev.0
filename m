Return-Path: <hs@denx.de>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id A8037B7C32
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 18:05:15 +1100 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	7FC4631A442
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 09:05:13 +0200 (CEST)
Received: from [192.168.1.6] ([82.131.205.183])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KR1009HD50OBGD0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Mon, 05 Oct 2009 09:05:13 +0200 (CEST)
Date: Mon, 05 Oct 2009 09:46:51 +0200
From: Heiko Schocher <hs@denx.de>
Subject: [PATCH v2] mpc5200: support for the MAN mpc5200 based board mucmc52
In-reply-to: <fa686aa40909140745u2cf1dba7q8ae2af53c87bd216@mail.gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Message-id: <4AC9A46B.3090007@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4AADF93C.3030604@denx.de> <20090914080322.GA3164@pengutronix.de>
	<fa686aa40909140745u2cf1dba7q8ae2af53c87bd216@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- serial Console on PSC1
- 64MB SDRAM
- MTD CFI Flash
- Ethernet FEC
- IDE support

Signed-off-by: Heiko Schocher <hs@denx.de>
---
- based on:
  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next

- checked with:
$ ./scripts/checkpatch.pl 0002-mpc5200-support-for-the-MAN-mpc5200-based-board-muc.patch
total: 0 errors, 0 warnings, 368 lines checked

0002-mpc5200-support-for-the-MAN-mpc5200-based-board-muc.patch has no obvious style problems and is ready for submission.
$

changes since v1:

- add comments from Grant Likely <grant.likely@secretlab.ca>
  use mpc5200_defconfig as default configuration, therefore added
  SIMPLE_GPIO support in it, because this is not selectable as a
  module.
- add comments from Wolfram Sang <w.sang@pengutronix.de>
- rebase against current next

 arch/powerpc/boot/dts/mucmc52.dts            |  353 ++++++++++++++++++++++++++
 arch/powerpc/configs/mpc5200_defconfig       |    2 +-
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
 3 files changed, 355 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mucmc52.dts

diff --git a/arch/powerpc/boot/dts/mucmc52.dts b/arch/powerpc/boot/dts/mucmc52.dts
new file mode 100644
index 0000000..88ad3e7
--- /dev/null
+++ b/arch/powerpc/boot/dts/mucmc52.dts
@@ -0,0 +1,353 @@
+/*
+ * mucmc52 board Device Tree Source
+ *
+ * Copyright (C) 2009 DENX Software Engineering GmbH
+ * Heiko Schocher <hs@denx.de>
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
+	model = "manroland,mucmc52";
+	compatible = "manroland,mucmc52";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&mpc5200_pic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,5200@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x4000>;	// L1, 16K
+			i-cache-size = <0x4000>;	// L1, 16K
+			timebase-frequency = <0>;	// from bootloader
+			bus-frequency = <0>;		// from bootloader
+			clock-frequency = <0>;		// from bootloader
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x04000000>;	// 64MB
+	};
+
+	soc5200@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc5200-immr",
+				"fsl,mpc5200b-immr";
+		ranges = <0 0xf0000000 0x0000c000>;
+		reg = <0xf0000000 0x00000100>;
+		bus-frequency = <0>;		// from bootloader
+		system-frequency = <0>;		// from bootloader
+
+		cdm@200 {
+			compatible = "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
+			reg = <0x200 0x38>;
+		};
+
+		mpc5200_pic: interrupt-controller@500 {
+			// 5200 interrupts are encoded into two levels;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
+			reg = <0x500 0x80>;
+			interrupts = <0 0 3>;
+		};
+
+		gpt0: timer@600 {	// GPT 0 in GPIO mode
+			compatible = "fsl,mpc5200b-gpt-gpio",
+					"fsl,mpc5200-gpt-gpio";
+			#gpio-cells = <2>;
+			reg = <0x600 0x10>;
+			interrupts = <1 9 0>;
+			gpio-controller;
+		};
+
+		gpt1: timer@610 {	// GPT 1 in GPIO mode
+			compatible = "fsl,mpc5200b-gpt-gpio",
+					"fsl,mpc5200-gpt-gpio";
+			#gpio-cells = <2>;
+			reg = <0x610 0x10>;
+			interrupts = <1 10 0>;
+			gpio-controller;
+		};
+
+		gpt2: timer@620 {	// GPT 2 in GPIO mode
+			compatible = "fsl,mpc5200b-gpt-gpio",
+					"fsl,mpc5200-gpt-gpio";
+			#gpio-cells = <2>;
+			reg = <0x620 0x10>;
+			interrupts = <1 11 0>;
+			gpio-controller;
+		};
+
+		gpt3: timer@630 {	// GPT 3 in GPIO mode
+			compatible = "fsl,mpc5200b-gpt-gpio",
+					"fsl,mpc5200-gpt-gpio";
+			#gpio-cells = <2>;
+			reg = <0x630 0x10>;
+			interrupts = <1 12 0>;
+			gpio-controller;
+		};
+
+		gpio_simple: gpio@b00 {
+			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
+			#gpio-cells = <2>;
+			reg = <0xb00 0x40>;
+			interrupts = <1 7 0>;
+			gpio-controller;
+		};
+
+		gpio_wkup: gpio@c00 {
+			compatible = "fsl,mpc5200b-gpio-wkup",
+					"fsl,mpc5200-gpio-wkup";
+			#gpio-cells = <2>;
+			reg = <0xc00 0x40>;
+			interrupts = <1 8 0 0 3 0>;
+			gpio-controller;
+		};
+
+		dma-controller@1200 {
+			device_type = "dma-controller";
+			compatible = "fsl,mpc5200b-bestcomm",
+					"fsl,mpc5200-bestcomm";
+			reg = <0x1200 0x80>;
+			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
+			              3 4 0  3 5 0  3 6 0  3 7 0
+			              3 8 0  3 9 0  3 10 0  3 11 0
+			              3 12 0  3 13 0  3 14 0  3 15 0>;
+		};
+
+		xlb@1f00 {
+			compatible = "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
+			reg = <0x1f00 0x100>;
+		};
+
+		serial@2000 {		// PSC1
+			compatible = "fsl,mpc5200b-psc-uart",
+					"fsl,mpc5200-psc-uart";
+			reg = <0x2000 0x100>;
+			interrupts = <2 1 0>;
+		};
+
+		serial@2200 {		// PSC2
+			compatible = "fsl,mpc5200b-psc-uart",
+					"fsl,mpc5200-psc-uart";
+			reg = <0x2200 0x100>;
+			interrupts = <2 2 0>;
+		};
+
+		serial@2c00 {		// PSC6
+			compatible = "fsl,mpc5200b-psc-uart",
+					"fsl,mpc5200-psc-uart";
+			reg = <0x2c00 0x100>;
+			interrupts = <2 6 0>;
+		};
+
+		ethernet@3000 {
+			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
+			reg = <0x3000 0x400>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <2 5 0>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
+			reg = <0x3000 0x400>; 	// fec range, since we need to
+						// setup fec interrupts
+			interrupts = <2 5 0>; 	// these are for "mii command
+						// finished", not link changes
+						//  & co.
+
+			phy0: ethernet-phy@0 {
+				compatible = "intel,lxt971";
+				reg = <0>;
+			};
+		};
+
+		ata@3a00 {
+			compatible = "fsl,mpc5200b-ata","fsl,mpc5200-ata";
+			reg = <0x3a00 0x100>;
+			interrupts = <2 7 0>;
+		};
+
+		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c",
+					"fsl-i2c";
+			reg = <0x3d40 0x40>;
+			interrupts = <2 16 0>;
+
+			hwmon@2c {
+				compatible = "ad,adm9240";
+				reg = <0x2c>;
+			};
+			rtc@51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
+		};
+
+		sram@8000 {
+			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram";
+			reg = <0x8000 0x4000>;
+		};
+
+		wdt {
+			compatible = "generic,gpio-wdt";
+			reg = <0x600 0x10>;
+			gpios = <&gpt0 0 0>;
+			period = <500>;	// WDT trigger period in msec
+		};
+	};
+
+	localbus {
+		compatible = "fsl,mpc5200b-lpb","simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0xff800000 0x00800000
+			  1 0 0x80000000 0x00800000
+			  3 0 0x80000000 0x00800000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x00800000>;
+			bank-width = <4>;
+			device-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+			partition@0 {
+				label = "DTS";
+				reg = <0x0 0x00100000>;
+			};
+			partition@100000 {
+				label = "Kernel";
+				reg = <0x100000 0x00200000>;
+			};
+			partition@300000 {
+				label = "RootFS";
+				reg = <0x00300000 0x00200000>;
+			};
+			partition@500000 {
+				label = "user";
+				reg = <0x00500000 0x00200000>;
+			};
+			partition@700000 {
+				label = "U-Boot";
+				reg = <0x00700000 0x00040000>;
+			};
+			partition@740000 {
+				label = "Env";
+				reg = <0x00740000 0x00020000>;
+			};
+			partition@760000 {
+				label = "red. Env";
+				reg = <0x00760000 0x00020000>;
+			};
+			partition@780000 {
+				label = "reserve";
+				reg = <0x00780000 0x00080000>;
+			};
+		};
+
+		simple100: gpio-controller-100@3,600100 {
+				#gpio-cells = <2>;
+				compatible = "manroland,mucmc52-aux-gpio";
+				reg = <3 0x00600100 0x1>;
+				gpio-controller;
+		};
+		simple104: gpio-controller-104@3,600104 {
+				#gpio-cells = <2>;
+				compatible = "manroland,mucmc52-aux-gpio";
+				reg = <3 0x00600104 0x1>;
+				gpio-controller;
+		};
+		simple200: gpio-controller-200@3,600200 {
+				#gpio-cells = <2>;
+				compatible = "manroland,mucmc52-aux-gpio";
+				reg = <3 0x00600200 0x1>;
+				gpio-controller;
+		};
+		simple201: gpio-controller-201@3,600201 {
+				#gpio-cells = <2>;
+				compatible = "manroland,mucmc52-aux-gpio";
+				reg = <3 0x00600201 0x1>;
+				gpio-controller;
+		};
+		simple202: gpio-controller-202@3,600202 {
+				#gpio-cells = <2>;
+				compatible = "manroland,mucmc52-aux-gpio";
+				reg = <3 0x00600202 0x1>;
+				gpio-controller;
+		};
+		simple203: gpio-controller-203@3,600203 {
+				#gpio-cells = <2>;
+				compatible = "manroland,mucmc52-aux-gpio";
+				reg = <3 0x00600203 0x1>;
+				gpio-controller;
+		};
+		simple204: gpio-controller-204@3,600204 {
+				#gpio-cells = <2>;
+				compatible = "manroland,mucmc52-aux-gpio";
+				reg = <3 0x00600204 0x1>;
+				gpio-controller;
+		};
+		simple206: gpio-controller-206@3,600206 {
+				#gpio-cells = <2>;
+				compatible = "manroland,mucmc52-aux-gpio";
+				reg = <3 0x00600206 0x1>;
+				gpio-controller;
+		};
+		simple207: gpio-controller-207@3,600207 {
+				#gpio-cells = <2>;
+				compatible = "manroland,mucmc52-aux-gpio";
+				reg = <3 0x00600207 0x1>;
+				gpio-controller;
+		};
+		simple20f: gpio-controller-20f@3,60020f {
+				#gpio-cells = <2>;
+				compatible = "manroland,mucmc52-aux-gpio";
+				reg = <3 0x0060020f 0x1>;
+				gpio-controller;
+		};
+
+	};
+
+	pci@f0000d00 {
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		compatible = "fsl,mpc5200-pci";
+		reg = <0xf0000d00 0x100>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+				/* IDSEL 0x10 */
+				0x8000 0 0 1 &mpc5200_pic 0 3 3
+				0x8000 0 0 2 &mpc5200_pic 0 3 3
+				0x8000 0 0 3 &mpc5200_pic 0 2 3
+				0x8000 0 0 4 &mpc5200_pic 0 1 3
+				>;
+		clock-frequency = <0>; // From boot loader
+		interrupts = <2 8 0 2 9 0 2 10 0>;
+		bus-range = <0 0>;
+		ranges = <0x42000000 0 0x60000000 0x60000000 0 0x10000000
+			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
+	};
+};
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index aaa4416..d035421 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -205,7 +205,7 @@ CONFIG_RTAS_PROC=y
 CONFIG_PPC_BESTCOMM=y
 CONFIG_PPC_BESTCOMM_ATA=y
 CONFIG_PPC_BESTCOMM_FEC=y
-# CONFIG_SIMPLE_GPIO is not set
+CONFIG_SIMPLE_GPIO=y

 #
 # Kernel options
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
index caf6d92..d45be5b 100644
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -51,6 +51,7 @@ static void __init mpc5200_simple_setup_arch(void)
 /* list of the supported boards */
 static char *board[] __initdata = {
 	"intercontrol,digsy-mtc",
+	"manroland,mucmc52",
 	"manroland,uc101",
 	"phytec,pcm030",
 	"phytec,pcm032",
-- 
1.6.0.6

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
