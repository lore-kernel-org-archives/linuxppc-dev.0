Return-Path: <scavanagh@secretlab.ca>
Received: from defout.telus.net (defout.telus.net [204.209.205.55])
	by ozlabs.org (Postfix) with ESMTP id 119F4DE68C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Apr 2008 02:52:59 +1000 (EST)
From: Steven Cavanagh <scavanagh@secretlab.ca>
Subject: [PATCH] Added device tree for media5200 evaluation board
To: linuxppc-embedded@ozlabs.org
Date: Mon, 21 Apr 2008 09:14:49 -0600
Message-ID: <20080421151449.10696.79839.stgit@eci-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Added the media5200 device tree to support the
Freescale media5200. Added board configuration
under PPC_LITE5200

Signed-off-by: Steven Cavanagh <scavanagh@secretlab.ca>
---

 arch/powerpc/boot/Makefile                   |    1 
 arch/powerpc/boot/dts/media5200.dts          |  277 ++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/Kconfig          |    3 
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 
 4 files changed, 281 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index f2e9abe..22cb470 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -227,6 +227,7 @@ image-$(CONFIG_PPC_ADDER875)		+= cuImage.adder875-uboot \
 # Board ports in arch/powerpc/platform/52xx/Kconfig
 image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200 cuImage.lite5200b
 image-$(CONFIG_PPC_GDC_CSB)		+= cuImage.gdc-csb gdc-csb.dtb
+image-$(CONFIG_PPC_MPC5200_SIMPLE)	+= cuImage.media5200 
 
 # Board ports in arch/powerpc/platform/82xx/Kconfig
 image-$(CONFIG_MPC8272_ADS)		+= cuImage.mpc8272ads
diff --git a/arch/powerpc/boot/dts/media5200.dts b/arch/powerpc/boot/dts/media5200.dts
new file mode 100644
index 0000000..59207e1
--- /dev/null
+++ b/arch/powerpc/boot/dts/media5200.dts
@@ -0,0 +1,277 @@
+/*
+ * Freescale Media5200  board Device Tree Source
+ *
+ * Copyright 2008 Secret Lab Technologies Ltd.
+ * Grant Likely <grant.likely@secretlab.ca>
+ * Steven Cavanagh <scavanagh@secretlab.ca>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+/ {
+	model = "fsl,media5200";
+	compatible = "fsl,media5200";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		console = &console;
+		ethernet0 = &eth0;
+	};
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
+			d-cache-size = <0x4000>;		// L1, 16K
+			i-cache-size = <0x4000>;		// L1, 16K
+			timebase-frequency = <0x1f78a40>;	// 33 MHz
+			bus-frequency = <0x7de2900>;		// 132 MHz
+			clock-frequency = <0x179a7b00>;		// 396 MHz
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x8000000>;	// 128MB
+	};
+
+	soc@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc5200b-immr";
+		ranges = <0 0xf0000000 0xc000>;
+		reg = <0xf0000000 0x100>;
+		bus-frequency = <0x7de2900>;// 132 MHz 
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
+			device_type = "interrupt-controller";
+			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
+			reg = <0x500 0x80>;
+		};
+
+		timer@600 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <0>;
+			reg = <0x600 0x10>;
+			interrupts = <1 9 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			fsl,has-wdt;
+		};
+
+		timer@610 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <1>;
+			reg = <0x610 0x10>;
+			interrupts = <1 10 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		timer@620 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <2>;
+			reg = <0x620 0x10>;
+			interrupts = <1 11 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		timer@630 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <3>;
+			reg = <0x630 0x10>;
+			interrupts = <1 12 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		timer@640 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <4>;
+			reg = <0x640 0x10>;
+			interrupts = <1 13 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		timer@650 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <5>;
+			reg = <0x650 0x10>;
+			interrupts = <1 14 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		timer@660 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <6>;
+			reg = <0x660 0x10>;
+			interrupts = <1 15 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		timer@670 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <7>;
+			reg = <0x670 0x10>;
+			interrupts = <1 16 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		rtc@800 {	// Real time clock
+			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
+			device_type = "rtc";
+			reg = <0x800 0x100>;
+			interrupts = <1 5 0 1 6 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		can@900 {
+			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
+			cell-index = <0>;
+			interrupts = <2 17 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			reg = <0x900 0x80>;
+		};
+
+		can@980 {
+			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
+			cell-index = <1>;
+			interrupts = <2 18 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			reg = <0x980 0x80>;
+		};
+
+		gpio@b00 {
+			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
+			reg = <0xb00 0x40>;
+			interrupts = <1 7 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpio@c00 {
+			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
+			reg = <0xc00 0x40>;
+			interrupts = <1 8 0 0 3 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		spi@f00 {
+			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
+			reg = <0xf00 0x20>;
+			interrupts = <2 13 0 2 14 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		usb@1000 {
+			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
+			reg = <0x1000 0x100>;
+			interrupts = <2 6 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		dma-controller@1200 {
+			device_type = "dma-controller";
+			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
+			reg = <0x1200 0x80>;
+			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
+			              3 4 0  3 5 0  3 6 0  3 7 0
+			              3 8 0  3 9 0  3 10 0  3 11 0
+			              3 12 0  3 13 0  3 14 0  3 15 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		xlb@1f00 {
+			compatible = "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
+			reg = <0x1f00 0x100>;
+		};
+
+		// PSC6 in uart mode
+		console: serial@2c00 {		// PSC6
+			device_type = "serial";
+			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			cell-index = <5>;
+			port-number = <0>;  // Logical port assignment
+			reg = <0x2c00 0x100>;
+			interrupts = <2 4 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		eth0: ethernet@3000 {
+			device_type = "network";
+			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
+			reg = <0x3000 0x400>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <2 5 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-mdio", "fsl,mpc5200-mdio";
+			reg = <0x3000 0x400>;	// fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
+			interrupt-parent = <&mpc5200_pic>;
+
+			phy0:ethernet-phy@0 {
+				device_type = "ethernet-phy";
+				reg = <0>;
+			};
+		};
+
+		ata@3a00 {
+			device_type = "ata";
+			compatible = "fsl,mpc5200b-ata","fsl,mpc5200-ata";
+			reg = <0x3a00 0x100>;
+			interrupts = <2 7 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		i2c@3d00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
+			cell-index = <0>;
+			reg = <0x3d00 0x40>;
+			interrupts = <2 15 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			fsl5200-clocking;
+		};
+
+		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
+			cell-index = <1>;
+			reg = <0x3d40 0x40>;
+			interrupts = <2 16 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			fsl5200-clocking;
+		};
+		sram@8000 {
+			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram","sram";
+			reg = <0x8000 0x4000>;
+		};
+	};
+
+	chosen {
+		linux,stdout-path = &console;
+	};
+};
diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index a0636d4..1914650 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -21,7 +21,8 @@ config PPC_MPC5200_SIMPLE
 	    and if there is a PCI bus node defined in the device tree.
 
 	  Boards that are compatible with this generic platform support
-	  are: 'tqc,tqm5200', 'promess,motionpro', 'schindler,cm5200'.
+	  are: 'tqc,tqm5200', 'promess,motionpro', 'schindler,cm5200',
+	  'fsl,media5200'.
 
 config PPC_EFIKA
 	bool "bPlan Efika 5k2. MPC5200B based computer"
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
index c48b82b..3a31576 100644
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -53,6 +53,7 @@ static char *board[] __initdata = {
 	"promess,motionpro",
 	"schindler,cm5200",
 	"tqc,tqm5200",
+	"fsl,media5200",
 	NULL
 };
 
