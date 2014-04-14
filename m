Return-Path: <martijn.de.gouw@prodrive-technologies.com>
Received: from mail.prodrive.nl (mail.prodrive.nl [212.61.153.67])
 by ozlabs.org (Postfix) with ESMTP id 62E4D1400CF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 23:00:47 +1000 (EST)
From: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH] powerpc/85xx: Add OCA4080 board support
Date: Mon, 14 Apr 2014 14:35:10 +0200
Message-ID: <1397478910-26361-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: stef.van.os@prodrive-technologies.com,
 Martijn de Gouw <martijn.de.gouw@prodrive.nl>,
 Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Martijn de Gouw <martijn.de.gouw@prodrive.nl>

OCA4080 overview:
- 1.466 GHz Freescale QorIQ P4080E Processor
- 4Gbyte DDR3 on board
- 8Mbyte Nor flash
- Serial RapidIO 1.2
- 1 x 10/100/1000 BASE-T front ethernet
- 1 x 1000 BASE-BX ethernet on AMC connector

Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
---
 arch/powerpc/boot/dts/oca4080.dts             |  148 +++++++++++++++++++++++++
 arch/powerpc/configs/corenet32_smp_defconfig  |    1 +
 arch/powerpc/platforms/85xx/Kconfig           |    2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c |    4 +-
 4 files changed, 152 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/oca4080.dts

diff --git a/arch/powerpc/boot/dts/oca4080.dts b/arch/powerpc/boot/dts/oca4080.dts
new file mode 100644
index 0000000..8926a61
--- /dev/null
+++ b/arch/powerpc/boot/dts/oca4080.dts
@@ -0,0 +1,148 @@
+/*
+ * OCA4080 Device Tree Source
+ *
+ * Copyright 2014 Prodrive Technologies B.V.
+ *
+ * Based on:
+ * P4080DS Device Tree Source
+ * Copyright 2009-2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/include/ "fsl/p4080si-pre.dtsi"
+
+/ {
+	model = "fsl,OCA4080";
+	compatible = "fsl,OCA4080";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	memory {
+		device_type = "memory";
+	};
+
+	dcsr: dcsr@f00000000 {
+		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
+	};
+
+	soc: soc@ffe000000 {
+		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
+		reg = <0xf 0xfe000000 0 0x00001000>;
+
+		i2c@118000 {
+			status = "disabled";
+		};
+
+		i2c@118100 {
+			status = "disabled";
+		};
+
+		i2c@119000 {
+			status = "disabled";
+		};
+
+		i2c@119100 {
+			status = "disabled";
+		};
+
+		usb0: usb@210000 {
+			status = "disabled";
+		};
+
+		usb1: usb@211000 {
+			status = "disabled";
+		};
+	};
+
+	rio: rapidio@ffe0c0000 {
+		reg = <0xf 0xfe0c0000 0 0x11000>;
+
+		port1 {
+			ranges = <0 0 0xc 0x20000000 0 0x10000000>;
+		};
+	};
+
+	lbc: localbus@ffe124000 {
+		reg = <0xf 0xfe124000 0 0x1000>;
+		ranges = <0 0 0xf 0xef800000 0x800000>;
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0 0 0x00800000>;
+			bank-width = <2>;
+			device-width = <2>;
+			partition@rcw {
+				label = "rcw";
+				reg = <0x00000000 0x00020000>;
+			};
+			partition@fman-ucode {
+				label = "fman-ucode";
+				reg = <0x00020000 0x00020000>;
+			};
+			partition@user {
+				label = "user";
+				reg = <0x00040000 0x00680000>;
+			};
+			partition@env0 {
+				label = "env0";
+				reg = <0x006c0000 0x00020000>;
+			};
+			partition@env1 {
+				label = "env1";
+				reg = <0x006e0000 0x00020000>;
+			};
+			partition@u-boot {
+				label = "u-boot";
+				reg = <0x00700000 0x00080000>;
+			};
+			partition@u-boot-backup {
+				label = "u-boot-backup";
+				reg = <0x00780000 0x00080000>;
+			};
+		};
+	};
+
+	pci0: pcie@ffe200000 {
+		status = "disabled";
+	};
+
+	pci1: pcie@ffe201000 {
+		status = "disabled";
+	};
+
+	pci2: pcie@ffe202000 {
+		status = "disabled";
+	};
+};
+
+/include/ "fsl/p4080si-post.dtsi"
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index bbd794d..c19ff05 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -72,6 +72,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_M25P80=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index c17aae8..2e2d8ab 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -263,7 +263,7 @@ config CORENET_GENERIC
 	help
 	  This option enables support for the FSL CoreNet based boards.
 	  For 32bit kernel, the following boards are supported:
-	    P2041 RDB, P3041 DS and P4080 DS
+	    P2041 RDB, P3041 DS, OCA4080 and P4080 DS
 	  For 64bit kernel, the following boards are supported:
 	    T4240 QDS and B4 QDS
 	  The following boards are supported for both 32bit and 64bit kernel:
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index fbd871e..f3685047 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -55,8 +55,6 @@ void __init corenet_gen_setup_arch(void)
 	mpc85xx_smp_init();
 
 	swiotlb_detect_4g();
-
-	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
 }
 
 static const struct of_device_id of_device_ids[] = {
@@ -99,6 +97,7 @@ int __init corenet_gen_publish_devices(void)
 static const char * const boards[] __initconst = {
 	"fsl,P2041RDB",
 	"fsl,P3041DS",
+	"fsl,OCA4080",
 	"fsl,P4080DS",
 	"fsl,P5020DS",
 	"fsl,P5040DS",
@@ -112,6 +111,7 @@ static const char * const boards[] __initconst = {
 static const char * const hv_boards[] __initconst = {
 	"fsl,P2041RDB-hv",
 	"fsl,P3041DS-hv",
+	"fsl,OCA4080-hv",
 	"fsl,P4080DS-hv",
 	"fsl,P5020DS-hv",
 	"fsl,P5040DS-hv",
-- 
1.7.10.4
