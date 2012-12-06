Return-Path: <sr@denx.de>
Received: from mo6-p05-ob.rzone.de (mo6-p05-ob.rzone.de
 [IPv6:2a01:238:20a:202:5305::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E89F82C01C2
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2012 20:36:25 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc: mpc5200: Add a3m071 board support
Date: Thu,  6 Dec 2012 10:30:10 +0100
Message-Id: <1354786210-10292-1-git-send-email-sr@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the MPC5200B based a3m071 board.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
---
v2:
- Remove cdm@200 DT node as it's not used
- Disable i2c controller in dts as its unused on this board

 arch/powerpc/boot/dts/a3m071.dts             | 144 +++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/mpc5200_simple.c |   1 +
 2 files changed, 145 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/a3m071.dts

diff --git a/arch/powerpc/boot/dts/a3m071.dts b/arch/powerpc/boot/dts/a3m071.dts
new file mode 100644
index 0000000..877a28c
--- /dev/null
+++ b/arch/powerpc/boot/dts/a3m071.dts
@@ -0,0 +1,144 @@
+/*
+ * a3m071 board Device Tree Source
+ *
+ * Copyright 2012 Stefan Roese <sr@denx.de>
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
+	model = "anonymous,a3m071";
+	compatible = "anonymous,a3m071";
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
+		timer@600 {
+			fsl,has-wdt;
+		};
+
+		spi@f00 {
+			status = "disabled";
+		};
+
+		usb: usb@1000 {
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
+			status = "disabled";
+		};
+
+		psc@2400 {
+			status = "disabled";
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
+		psc@2c00 {		// PSC6
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
+			phy0: ethernet-phy@3 {
+				reg = <0x03>;
+			};
+		};
+
+		ata@3a00 {
+			status = "disabled";
+		};
+
+		i2c@3d00 {
+			status = "disabled";
+		};
+
+		i2c@3d40 {
+			status = "disabled";
+		};
+	};
+
+	localbus {
+		compatible = "fsl,mpc5200b-lpb","simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0xfc000000 0x02000000
+			  3 0 0xe9000000 0x00080000
+			  5 0 0xe8000000 0x00010000>;
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0 0x0 0x02000000>;
+			compatible = "cfi-flash";
+			bank-width = <2>;
+			partition@0x0 {
+				label = "u-boot";
+				reg = <0x00000000 0x00040000>;
+				read-only;
+			};
+			partition@0x00040000 {
+				label = "env";
+				reg = <0x00040000 0x00020000>;
+			};
+			partition@0x00060000 {
+				label = "dtb";
+				reg = <0x00060000 0x00020000>;
+			};
+			partition@0x00080000 {
+				label = "kernel";
+				reg = <0x00080000 0x00500000>;
+			};
+			partition@0x00580000 {
+				label = "root";
+				reg = <0x00580000 0x00A80000>;
+			};
+		};
+
+		fpga@3,0 {
+			compatible = "anonymous,a3m071-fpga";
+			reg = <3 0x0 0x00080000
+			       5 0x0 0x00010000>;
+			interrupts = <0 0 3>;  /* level low */
+		};
+	};
+
+	pci@f0000d00 {
+		status = "disabled";
+	};
+};
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
index 9cf3602..792a301 100644
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -50,6 +50,7 @@ static void __init mpc5200_simple_setup_arch(void)
 
 /* list of the supported boards */
 static const char *board[] __initdata = {
+	"anonymous,a3m071",
 	"anonymous,a4m072",
 	"anon,charon",
 	"ifm,o2d",
-- 
1.8.0.1
