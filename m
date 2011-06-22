Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B98F5B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 20:39:18 +1000 (EST)
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/4] powerpc, mpc52xx: add a4m072 board support
Date: Wed, 22 Jun 2011 12:39:10 +0200
Message-Id: <1308739150-31527-1-git-send-email-hs@denx.de>
In-Reply-To: <1308729311-15375-3-git-send-email-hs@denx.de>
References: <1308729311-15375-3-git-send-email-hs@denx.de>
Cc: Heiko Schocher <hs@denx.de>, Wolfgang Denk <wd@denx.de>,
	devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: Grant Likely <grant.likely@secretlab.ca>
cc: devicetree-discuss@ozlabs.org
cc: Wolfgang Denk <wd@denx.de>
cc: Wolfram Sang <w.sang@pengutronix.de>
---
For this patchseries following patch is needed:

http://patchwork.ozlabs.org/patch/91919/

Grant? Do you have some comments on that patch?

changes for v2:
  add comment from Wolfram Sang:
  use mpc5200.dtsi

 arch/powerpc/boot/dts/a4m072.dts             |  172 ++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
 2 files changed, 173 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/a4m072.dts

diff --git a/arch/powerpc/boot/dts/a4m072.dts b/arch/powerpc/boot/dts/a4m072.dts
new file mode 100644
index 0000000..adb6746
--- /dev/null
+++ b/arch/powerpc/boot/dts/a4m072.dts
@@ -0,0 +1,172 @@
+/*
+ * a4m072 board Device Tree Source
+ *
+ * Copyright (C) 2011 DENX Software Engineering GmbH
+ * Heiko Schocher <hs@denx.de>
+ *
+ * Copyright (C) 2007 Semihalf
+ * Marian Balakowicz <m8@semihalf.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "mpc5200b.dtsi"
+
+/ {
+	model = "anonymous,a4m072";
+	compatible = "anonymous,a4m072";
+
+	soc5200@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc5200b-immr";
+		ranges = <0 0xf0000000 0x0000c000>;
+		reg = <0xf0000000 0x00000100>;
+		bus-frequency = <0>; /* From boot loader */
+		system-frequency = <0>; /* From boot loader */
+
+		cdm@200 {
+			fsl,ext_48mhz_en = <0x0>;
+			fsl,fd_enable = <0x01>;
+			fsl,fd_counters = <0xbbbb>;
+		};
+
+		timer@600 {
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <0x600 0x80>;
+			interrupts = <1 9 0>;
+			fsl,has-wdt;
+		};
+
+		gpt3: timer@630 { /* General Purpose Timer in GPIO mode */
+			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpt4: timer@640 { /* General Purpose Timer in GPIO mode */
+			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpt5: timer@650 { /* General Purpose Timer in GPIO mode */
+			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		spi@f00 {
+			status = "disabled";
+		};
+
+		psc@2000 {
+			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			reg = <0x2000 0x100>;
+			interrupts = <2 1 0>;
+		};
+
+		psc@2200 {
+			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			reg = <0x2200 0x100>;
+			interrupts = <2 2 0>;
+		};
+
+		psc@2400 {
+			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			reg = <0x2400 0x100>;
+			interrupts = <2 3 0>;
+		};
+
+		psc@2600 {
+			status = "disabled";
+		};
+
+		psc@2800 {
+			status = "disabled";
+		};
+
+		psc@2c00 {
+			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			reg = <0x2c00 0x100>;
+			interrupts = <2 4 0>;
+		};
+
+		ethernet@3000 {
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			phy0: ethernet-phy@1f {
+				reg = <0x1f>;
+				interrupts = <1 2 0>; /* IRQ 2 active low */
+			};
+		};
+
+		i2c@3d00 {
+			status = "disabled";
+		};
+
+		i2c@3d40 {
+			 hwmon@2e {
+				compatible = "nsc,lm87";
+				reg = <0x2e>;
+			};
+			 rtc@51 {
+				compatible = "nxp,rtc8564";
+				reg = <0x51>;
+			};
+		};
+	};
+
+	localbus {
+		compatible = "fsl,mpc5200b-lpb","simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0xfe000000 0x02000000
+			  1 0 0x62000000 0x00400000
+			  2 0 0x64000000 0x00200000
+			  3 0 0x66000000 0x01000000
+			  6 0 0x68000000 0x01000000
+			  7 0 0x6a000000 0x00000004
+			 >;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x02000000>;
+			bank-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+		};
+		sram0@1,0 {
+			compatible = "mtd-ram";
+			reg = <1 0x00000 0x00400000>;
+			bank-width = <2>;
+		};
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
+				 /* IDSEL 0x16 */
+				 0xc000 0 0 1 &mpc5200_pic 1 3 3
+				 0xc000 0 0 2 &mpc5200_pic 1 3 3
+				 0xc000 0 0 3 &mpc5200_pic 1 3 3
+				 0xc000 0 0 4 &mpc5200_pic 1 3 3>;
+		clock-frequency = <0>; /* From boot loader */
+		interrupts = <2 8 0 2 9 0 2 10 0>;
+		bus-range = <0 0>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000
+			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
+	};
+};
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
index e36d6e2..192b4ff 100644
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -50,6 +50,7 @@ static void __init mpc5200_simple_setup_arch(void)
 
 /* list of the supported boards */
 static const char *board[] __initdata = {
+	"anonymous,a4m072",
 	"intercontrol,digsy-mtc",
 	"manroland,mucmc52",
 	"manroland,uc101",
-- 
1.7.5.4
