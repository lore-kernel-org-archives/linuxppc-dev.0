Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (unknown [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C4902C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 07:14:03 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc: add alternate dts file for sbc8548 boot via
 SODIMM
Date: Wed, 23 Jan 2013 15:13:32 -0500
Message-Id: <1358972013-5271-4-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1358972013-5271-1-git-send-email-paul.gortmaker@windriver.com>
References: <1358972013-5271-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By moving the two JP12 jumpers 90 degrees, and switching the
setting of SW2.8, the sbc8548 can be configured to boot off
the alternate 64MB SODIMM, which when populated with u-boot
can be a handy recovery option, in case the u-boot in the
8MB soldered on flash gets corrupted.  Here we add an alternate
dts file to match that configuration.

To better highlight the differences, the output from the u-boot
"fli" command is shown for the normal configuration and then
the alternate configuration.

Normal:
 -----------------------
Bank # 1: CFI conformant flash (8 x 8)  Size: 8 MB in 64 Sectors
  Intel Extended command set, Manufacturer ID: 0x89, Device ID: 0x17
  Erase timeout: 4096 ms, write timeout: 1 ms
  Buffer write timeout: 2 ms, buffer size: 32 bytes

  Sector Start Addresses:
  FF800000 E      FF820000 E      FF840000 E      FF860000 E      FF880000 E
 [...]
  FFEE0000 E      FFF00000 E      FFF20000 E      FFF40000 E      FFF60000 E
  FFF80000        FFFA0000   RO   FFFC0000   RO   FFFE0000   RO

Bank # 2: CFI conformant flash (32 x 8)  Size: 64 MB in 128 Sectors
  Intel Extended command set, Manufacturer ID: 0x89, Device ID: 0x18
  Erase timeout: 4096 ms, write timeout: 1 ms
  Buffer write timeout: 2 ms, buffer size: 32 bytes

  Sector Start Addresses:
  EC000000 E      EC080000 E      EC100000 E      EC180000 E      EC200000 E
 [...]
  EFC00000 E      EFC80000 E      EFD00000 E      EFD80000 E      EFE00000 E
  EFE80000 E      EFF00000        EFF80000
 -----------------------

Alternate:
 -----------------------
Bank # 1: CFI conformant flash (32 x 8)  Size: 64 MB in 128 Sectors
  Intel Extended command set, Manufacturer ID: 0x89, Device ID: 0x18
  Erase timeout: 4096 ms, write timeout: 1 ms
  Buffer write timeout: 2 ms, buffer size: 32 bytes

  Sector Start Addresses:
  FC000000 E      FC080000 E      FC100000 E      FC180000 E      FC200000 E
 [...]
  FFC00000 E      FFC80000 E      FFD00000 E      FFD80000 E      FFE00000 E
  FFE80000 E      FFF00000   RO   FFF80000   RO

Bank # 2: CFI conformant flash (8 x 8)  Size: 8 MB in 64 Sectors
  Intel Extended command set, Manufacturer ID: 0x89, Device ID: 0x17
  Erase timeout: 4096 ms, write timeout: 1 ms
  Buffer write timeout: 2 ms, buffer size: 32 bytes

  Sector Start Addresses:
  EF800000 E      EF820000 E      EF840000 E      EF860000 E      EF880000 E
 [...]
  EFEE0000 E      EFF00000 E      EFF20000 E      EFF40000 E      EFF60000 E
  EFF80000 E      EFFA0000        EFFC0000        EFFE0000
 -----------------------

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8548-altflash.dts | 115 +++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/sbc8548-altflash.dts

diff --git a/arch/powerpc/boot/dts/sbc8548-altflash.dts b/arch/powerpc/boot/dts/sbc8548-altflash.dts
new file mode 100644
index 0000000..0b38a0d
--- /dev/null
+++ b/arch/powerpc/boot/dts/sbc8548-altflash.dts
@@ -0,0 +1,115 @@
+/*
+ * SBC8548 Device Tree Source
+ *
+ * Configured for booting off the alternate (64MB SODIMM) flash.
+ * Requires switching JP12 jumpers and changing SW2.8 setting.
+ *
+ * Copyright 2013 Wind River Systems Inc.
+ *
+ * Paul Gortmaker (see MAINTAINERS for contact information)
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/dts-v1/;
+
+/include/ "sbc8548-pre.dtsi"
+
+/{
+	localbus@e0000000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		reg = <0xe0000000 0x5000>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0x0 0x0 0xfc000000 0x04000000		/*64MB Flash*/
+			  0x3 0x0 0xf0000000 0x04000000		/*64MB SDRAM*/
+			  0x4 0x0 0xf4000000 0x04000000 	/*64MB SDRAM*/
+			  0x5 0x0 0xf8000000 0x00b10000		/* EPLD */
+			  0x6 0x0 0xef800000 0x00800000>;	/*8MB Flash*/
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0x0 0x04000000>;
+			compatible = "intel,JS28F128", "cfi-flash";
+			bank-width = <4>;
+			device-width = <1>;
+			partition@0x0 {
+				label = "space";
+				/* FC000000 -> FFEFFFFF */
+				reg = <0x00000000 0x03f00000>;
+			};
+			partition@0x03f00000 {
+				label = "bootloader";
+				/* FFF00000 -> FFFFFFFF */
+				reg = <0x03f00000 0x00100000>;
+				read-only;
+			};
+                };
+
+
+		epld@5,0 {
+			compatible = "wrs,epld-localbus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			reg = <0x5 0x0 0x00b10000>;
+			ranges = <
+				0x0 0x0 0x5 0x000000 0x1fff	/* LED */
+				0x1 0x0 0x5 0x100000 0x1fff	/* Switches */
+				0x3 0x0 0x5 0x300000 0x1fff	/* HW Rev. */
+				0xb 0x0	0x5 0xb00000 0x1fff	/* EEPROM */
+			>;
+
+			led@0,0 {
+				compatible = "led";
+				reg = <0x0 0x0 0x1fff>;
+			};
+
+			switches@1,0 {
+				compatible = "switches";
+				reg = <0x1 0x0 0x1fff>;
+			};
+
+			hw-rev@3,0 {
+				compatible = "hw-rev";
+				reg = <0x3 0x0 0x1fff>;
+			};
+
+			eeprom@b,0 {
+				compatible = "eeprom";
+				reg = <0xb 0 0x1fff>;
+			};
+
+		};
+
+		alt-flash@6,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "intel,JS28F640", "cfi-flash";
+			reg = <0x6 0x0 0x800000>;
+			bank-width = <1>;
+			device-width = <1>;
+			partition@0x0 {
+				label = "space";
+				/* EF800000 -> EFF9FFFF */
+				reg = <0x00000000 0x007a0000>;
+			};
+			partition@0x7a0000 {
+				label = "bootloader";
+				/* EFFA0000 -> EFFFFFFF */
+				reg = <0x007a0000 0x00060000>;
+				read-only;
+			};
+		};
+
+
+        };
+};
+
+/include/ "sbc8548-post.dtsi"
-- 
1.8.1
