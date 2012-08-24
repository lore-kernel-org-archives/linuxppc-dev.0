Return-Path: <agust@denx.de>
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/mpc5200: add dts files for ifm camera machines
Date: Fri, 24 Aug 2012 17:39:38 +0200
Message-Id: <1345822779-32020-1-git-send-email-agust@denx.de>
Cc: devicetree-discuss@lists.ozlabs.org, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add common o2d dtsi file to reuse it for other configurations.
Add machine compatible string to mpc5200 simple platform file.
Add dts files for O2D, O2I, O2MNT, O2DNT2, O2D300 and O3DNT boards.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/o2d.dts                |   33 ++++++
 arch/powerpc/boot/dts/o2d.dtsi               |  139 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/o2d300.dts             |   52 ++++++++++
 arch/powerpc/boot/dts/o2dnt2.dts             |   48 +++++++++
 arch/powerpc/boot/dts/o2i.dts                |   33 ++++++
 arch/powerpc/boot/dts/o2mnt.dts              |   33 ++++++
 arch/powerpc/boot/dts/o3dnt.dts              |   48 +++++++++
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
 8 files changed, 387 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/o2d.dts
 create mode 100644 arch/powerpc/boot/dts/o2d.dtsi
 create mode 100644 arch/powerpc/boot/dts/o2d300.dts
 create mode 100644 arch/powerpc/boot/dts/o2dnt2.dts
 create mode 100644 arch/powerpc/boot/dts/o2i.dts
 create mode 100644 arch/powerpc/boot/dts/o2mnt.dts
 create mode 100644 arch/powerpc/boot/dts/o3dnt.dts

diff --git a/arch/powerpc/boot/dts/o2d.dts b/arch/powerpc/boot/dts/o2d.dts
new file mode 100644
index 0000000..460064b
--- /dev/null
+++ b/arch/powerpc/boot/dts/o2d.dts
@@ -0,0 +1,33 @@
+/*
+ * O2D Device Tree Source
+ *
+ * Copyright (C) 2012 DENX Software Engineering
+ * Anatolij Gustschin <agust@denx.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "o2d.dtsi"
+
+/ {
+	model = "ifm,o2d";
+	compatible = "ifm,o2d";
+
+	localbus {
+		flash@0,0 {
+			partition@60000 {
+				label = "kernel";
+				reg = <0x00060000 0x00260000>;
+				read-only;
+			};
+			/* o2d specific partitions */
+                        partition@2c0000 {
+                                label = "o2d user defined";
+                                reg = <0x002c0000 0x00d40000>;
+                        };
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/o2d.dtsi b/arch/powerpc/boot/dts/o2d.dtsi
new file mode 100644
index 0000000..3444eb8
--- /dev/null
+++ b/arch/powerpc/boot/dts/o2d.dtsi
@@ -0,0 +1,139 @@
+/*
+ * O2D base Device Tree Source
+ *
+ * Copyright (C) 2012 DENX Software Engineering
+ * Anatolij Gustschin <agust@denx.de>
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
+	model = "ifm,o2d";
+	compatible = "ifm,o2d";
+
+	memory {
+		reg = <0x00000000 0x04000000>;	// 64MB
+	};
+
+	soc5200@f0000000 {
+
+		gpio_simple: gpio@b00 {
+		};
+
+		timer@600 {	// General Purpose Timer
+			#gpio-cells = <2>;
+			gpio-controller;
+			fsl,has-wdt;
+			fsl,wdt-on-boot = <0>;
+		};
+
+		timer@610 {
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		timer7: timer@670 {
+		};
+
+		rtc@800 {
+			status = "disabled";
+		};
+
+		psc@2000 {		// PSC1
+			compatible = "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+
+			spidev@0 {
+				compatible = "spidev";
+				spi-max-frequency = <250000>;
+				reg = <0>;
+			};
+		};
+
+		psc@2200 {		// PSC2
+			status = "disabled";
+		};
+
+		psc@2400 {		// PSC3
+			status = "disabled";
+		};
+
+		psc@2600 {		// PSC4
+			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+		};
+
+		psc@2800 {		// PSC5
+			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+		};
+
+		psc@2c00 {		// PSC6
+			status = "disabled";
+		};
+
+		ethernet@3000 {
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			phy0: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		sclpc@3c00 {
+			compatible = "fsl,mpc5200-lpbfifo";
+			reg = <0x3c00 0x60>;
+			interrupts = <3 23 0>;
+		};
+	};
+
+	localbus {
+		ranges = <0 0 0xff000000 0x01000000
+			  3 0 0xe3000000 0x00100000>;
+
+		// flash device at LocalPlus Bus CS0
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x01000000>;
+			bank-width = <1>;
+			device-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+			no-unaligned-direct-access;
+
+			/* common layout for all machines */
+			partition@0 {
+				label = "u-boot";
+				reg = <0x00000000 0x00040000>;
+				read-only;
+			};
+			partition@40000 {
+				label = "env";
+				reg = <0x00040000 0x00020000>;
+				read-only;
+			};
+		};
+
+		csi@3,0 {
+			compatible = "ifm,o2d-csi";
+			reg = <3 0 0x00100000>;
+			ifm,csi-clk-handle = <&timer7>;
+			gpios = <&gpio_simple 23 0	/* imag_capture */
+				 &gpio_simple 26 0	/* imag_reset */
+				 &gpio_simple 29 0>;	/* imag_master_en */
+
+			interrupts = <1 1 2>;		/* IRQ1, edge falling */
+
+			ifm,csi-addr-bus-width = <24>;
+			ifm,csi-data-bus-width = <8>;
+			ifm,csi-wait-cycles = <0>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/o2d300.dts b/arch/powerpc/boot/dts/o2d300.dts
new file mode 100644
index 0000000..29affe0
--- /dev/null
+++ b/arch/powerpc/boot/dts/o2d300.dts
@@ -0,0 +1,52 @@
+/*
+ * O2D300 Device Tree Source
+ *
+ * Copyright (C) 2012 DENX Software Engineering
+ * Anatolij Gustschin <agust@denx.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "o2d.dtsi"
+
+/ {
+	model = "ifm,o2d300";
+	compatible = "ifm,o2d";
+
+	localbus {
+		ranges = <0 0 0xfc000000 0x02000000
+			  3 0 0xe3000000 0x00100000>;
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x02000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+
+			partition@40000 {
+				label = "env_1";
+				reg = <0x00040000 0x00020000>;
+				read-only;
+			};
+			partition@60000 {
+				label = "env_2";
+				reg = <0x00060000 0x00020000>;
+				read-only;
+			};
+			partition@80000 {
+				label = "kernel";
+				reg = <0x00080000 0x00260000>;
+				read-only;
+			};
+			/* o2d300 specific partitions */
+			partition@2e0000 {
+				label = "o2d300 user defined";
+				reg = <0x002e0000 0x01d20000>;
+			};
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/o2dnt2.dts b/arch/powerpc/boot/dts/o2dnt2.dts
new file mode 100644
index 0000000..a0f5b97
--- /dev/null
+++ b/arch/powerpc/boot/dts/o2dnt2.dts
@@ -0,0 +1,48 @@
+/*
+ * O2DNT2 Device Tree Source
+ *
+ * Copyright (C) 2012 DENX Software Engineering
+ * Anatolij Gustschin <agust@denx.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "o2d.dtsi"
+
+/ {
+	model = "ifm,o2dnt2";
+	compatible = "ifm,o2d";
+
+	memory {
+		reg = <0x00000000 0x08000000>;  // 128MB
+	};
+
+	localbus {
+		ranges = <0 0 0xfc000000 0x02000000
+			  3 0 0xe3000000 0x00100000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x02000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+
+			partition@60000 {
+				label = "kernel";
+				reg = <0x00060000 0x00260000>;
+				read-only;
+			};
+
+			/* o2dnt2 specific partitions */
+			partition@2c0000 {
+				label = "o2dnt2 user defined";
+				reg = <0x002c0000 0x01d40000>;
+			};
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/o2i.dts b/arch/powerpc/boot/dts/o2i.dts
new file mode 100644
index 0000000..e3cc99d
--- /dev/null
+++ b/arch/powerpc/boot/dts/o2i.dts
@@ -0,0 +1,33 @@
+/*
+ * O2I Device Tree Source
+ *
+ * Copyright (C) 2012 DENX Software Engineering
+ * Anatolij Gustschin <agust@denx.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "o2d.dtsi"
+
+/ {
+	model = "ifm,o2i";
+	compatible = "ifm,o2d";
+
+	localbus {
+		flash@0,0 {
+			partition@60000 {
+				label = "kernel";
+				reg = <0x00060000 0x00260000>;
+				read-only;
+			};
+			/* o2i specific partitions */
+			partition@2c0000 {
+				label = "o2i user defined";
+				reg = <0x002c0000 0x00d40000>;
+			};
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/o2mnt.dts b/arch/powerpc/boot/dts/o2mnt.dts
new file mode 100644
index 0000000..2fa4349
--- /dev/null
+++ b/arch/powerpc/boot/dts/o2mnt.dts
@@ -0,0 +1,33 @@
+/*
+ * O2MNT Device Tree Source
+ *
+ * Copyright (C) 2012 DENX Software Engineering
+ * Anatolij Gustschin <agust@denx.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "o2d.dtsi"
+
+/ {
+	model = "ifm,o2mnt";
+	compatible = "ifm,o2d";
+
+	localbus {
+		flash@0,0 {
+			partition@60000 {
+				label = "kernel";
+				reg = <0x00060000 0x00260000>;
+				read-only;
+			};
+			/* add o2mnt specific partitions */
+                        partition@2c0000 {
+                                label = "o2mnt user defined";
+                                reg = <0x002c0000 0x00d40000>;
+                        };
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/o3dnt.dts b/arch/powerpc/boot/dts/o3dnt.dts
new file mode 100644
index 0000000..acce493
--- /dev/null
+++ b/arch/powerpc/boot/dts/o3dnt.dts
@@ -0,0 +1,48 @@
+/*
+ * O3DNT Device Tree Source
+ *
+ * Copyright (C) 2012 DENX Software Engineering
+ * Anatolij Gustschin <agust@denx.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "o2d.dtsi"
+
+/ {
+	model = "ifm,o3dnt";
+	compatible = "ifm,o2d";
+
+	memory {
+		reg = <0x00000000 0x04000000>;  // 64MB
+	};
+
+	localbus {
+		ranges = <0 0 0xfc000000 0x01000000
+			  3 0 0xe3000000 0x00100000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x01000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+
+			partition@60000 {
+				label = "kernel";
+				reg = <0x00060000 0x00260000>;
+				read-only;
+			};
+
+			/* o3dnt specific partitions */
+			partition@2c0000 {
+				label = "o3dnt user defined";
+				reg = <0x002c0000 0x00d40000>;
+			};
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
index c0aa040..9cf3602 100644
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -52,6 +52,7 @@ static void __init mpc5200_simple_setup_arch(void)
 static const char *board[] __initdata = {
 	"anonymous,a4m072",
 	"anon,charon",
+	"ifm,o2d",
 	"intercontrol,digsy-mtc",
 	"manroland,mucmc52",
 	"manroland,uc101",
-- 
1.7.1
