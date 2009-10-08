Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id B7A7CB7B6F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 17:20:47 +1100 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	5F1EA11A18F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 08:20:46 +0200 (CEST)
Received: from [192.168.1.6] ([82.131.201.60])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KR600KYYMYLN4F0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Thu, 08 Oct 2009 08:20:46 +0200 (CEST)
Date: Thu, 08 Oct 2009 07:54:06 +0200
From: Heiko Schocher <hs@denx.de>
Subject: [PATCH v4] mpc5200: support for the MAN mpc5200 based board uc101
In-reply-to: <fa686aa40910070657o2b68156dq25cb44d6d6509abc@mail.gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Message-id: <4ACD7E7E.8080605@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4AADF93C.3030604@denx.de> <20090914080322.GA3164@pengutronix.de>
	<fa686aa40909140745u2cf1dba7q8ae2af53c87bd216@mail.gmail.com>
	<4AC9A463.1080903@denx.de> <20091005095340.GA3890@pengutronix.de>
	<4AC9C6AA.6060009@denx.de>
	<fa686aa40910050646p168c2bbfi4b432778827102c9@mail.gmail.com>
	<4ACC37E5.4040804@denx.de> <20091007094936.GE3177@pengutronix.de>
	<fa686aa40910070657o2b68156dq25cb44d6d6509abc@mail.gmail.com>
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
- I2C with PCF8563 and Temp. Sensor ADM9240
- IDE support

Signed-off-by: Heiko Schocher <hs@denx.de>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
---

- based on:
  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next

- checked with:
$ ./scripts/checkpatch.pl 0001-mpc5200-support-for-the-MAN-mpc5200-based-board-uc1.patch
total: 0 errors, 0 warnings, 316 lines checked

0001-mpc5200-support-for-the-MAN-mpc5200-based-board-uc1.patch has no obvious style problems and is ready for submission.
$

changes since v1:

- add comments from Grant Likely <grant.likely@secretlab.ca>
  use mpc5200_defconfig as default configuration
- add comments from Wolfram Sang <w.sang@pengutronix.de>
- rebase against current next

changes since v2:
- add comment from Wolfram Sang
  remove unofficial binding

changes since v3:
- add comment from Wolfram Sang
  use "fsl,mpc5200b-immr" only
  added Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

 arch/powerpc/boot/dts/uc101.dts              |  309 ++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
 2 files changed, 310 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/uc101.dts

diff --git a/arch/powerpc/boot/dts/uc101.dts b/arch/powerpc/boot/dts/uc101.dts
new file mode 100644
index 0000000..e928d22
--- /dev/null
+++ b/arch/powerpc/boot/dts/uc101.dts
@@ -0,0 +1,309 @@
+/*
+ * uc101 board Device Tree Source
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
+	model = "manroland,uc101";
+	compatible = "manroland,uc101";
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
+		compatible = "fsl,mpc5200b-immr";
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
+		gpt4: timer@640 {	// GPT 4 in GPIO mode
+			compatible = "fsl,mpc5200b-gpt-gpio",
+					"fsl,mpc5200-gpt-gpio";
+			#gpio-cells = <2>;
+			reg = <0x640 0x10>;
+			interrupts = <1 13 0>;
+			gpio-controller;
+		};
+
+		gpt5: timer@650 {	// GPT 5 in GPIO mode
+			compatible = "fsl,mpc5200b-gpt-gpio",
+					"fsl,mpc5200-gpt-gpio";
+			#gpio-cells = <2>;
+			reg = <0x650 0x10>;
+			interrupts = <1 14 0>;
+			gpio-controller;
+		};
+
+		gpt6: timer@660 {	// GPT 6 in GPIO mode
+			compatible = "fsl,mpc5200b-gpt-gpio",
+					"fsl,mpc5200-gpt-gpio";
+			#gpio-cells = <2>;
+			reg = <0x660 0x10>;
+			interrupts = <1 15 0>;
+			gpio-controller;
+		};
+
+		gpt7: timer@670 {	// GPT 7 in GPIO mode
+			compatible = "fsl,mpc5200b-gpt-gpio",
+					"fsl,mpc5200-gpt-gpio";
+			#gpio-cells = <2>;
+			reg = <0x670 0x10>;
+			interrupts = <1 16 0>;
+			gpio-controller;
+		};
+
+		gpio_simple: gpio@b00 {
+			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
+			reg = <0xb00 0x40>;
+			interrupts = <1 7 0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpio_wkup: gpio@c00 {
+			compatible = "fsl,mpc5200b-gpio-wkup",
+					"fsl,mpc5200-gpio-wkup";
+			reg = <0xc00 0x40>;
+			interrupts = <1 8 0 0 3 0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpio_sint: gpio_sint@b00 {
+			compatible = "fsl,mpc5200b-gpio-sint",
+					"fsl,mpc5200-gpio-sint";
+			reg = <0xb00 0x40>;
+			interrupts = <1 8 0 0 3 0>;
+			gpio-controller;
+			#gpio-cells = <2>;
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
+			reg = <0x3000 0x400>;	// fec range, since we need to
+						// setup fec interrupts
+			interrupts = <2 5 0>;	// these are for "mii command
+						// finished", not link
+						// changes & co.
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
+			fsl,preserve-clocking;
+			clock-frequency = <400000>;
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
+			bank-width = <2>;
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
+
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
+				reg = <0x00740000 0x00010000>;
+			};
+			partition@750000 {
+				label = "red. Env";
+				reg = <0x00750000 0x00010000>;
+			};
+			partition@760000 {
+				label = "reserve";
+				reg = <0x00760000 0x000a0000>;
+			};
+		};
+
+	};
+};
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
index c31e5b5..caf6d92 100644
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -51,6 +51,7 @@ static void __init mpc5200_simple_setup_arch(void)
 /* list of the supported boards */
 static char *board[] __initdata = {
 	"intercontrol,digsy-mtc",
+	"manroland,uc101",
 	"phytec,pcm030",
 	"phytec,pcm032",
 	"promess,motionpro",
-- 
1.6.0.6

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
