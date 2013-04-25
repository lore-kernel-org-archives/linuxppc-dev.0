Return-Path: <B43644@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 765BB2C0182
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 12:35:50 +1000 (EST)
From: Po Liu <Po.Liu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/4] powerpc/85xx: Add C293PCIE board support
Date: Thu, 25 Apr 2013 09:54:16 +0800
Message-ID: <1366854857-22791-3-git-send-email-Po.Liu@freescale.com>
In-Reply-To: <1366854857-22791-1-git-send-email-Po.Liu@freescale.com>
References: <1366854857-22791-1-git-send-email-Po.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mingkai Hu <Mingkai.Hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mingkai Hu <Mingkai.Hu@freescale.com>

C293PCIE board is a series of Freescale PCIe add-in cards to perform
as public key crypto accelerator or secure key management module.

 - 512KB platform SRAM in addition to 512K L2 Cache/SRAM
 - 512MB soldered DDR3 32bit memory
 - CPLD System Logic
 - 64MB x16 NOR flash and 4GB x8 NAND flash
 - 16MB SPI flash

Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
Singed-off-by: Po Liu <Po.Liu@freescale.com>
---
Base on git://git.am.freescale.net/gitolite/mirrors/linux-2.6.git
 arch/powerpc/boot/dts/c293pcie.dts     | 251 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig    |   7 +
 arch/powerpc/platforms/85xx/Makefile   |   1 +
 arch/powerpc/platforms/85xx/c293pcie.c |  82 +++++++++++
 4 files changed, 341 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/c293pcie.dts
 create mode 100644 arch/powerpc/platforms/85xx/c293pcie.c

diff --git a/arch/powerpc/boot/dts/c293pcie.dts b/arch/powerpc/boot/dts/c293pcie.dts
new file mode 100644
index 0000000..f2f6d76
--- /dev/null
+++ b/arch/powerpc/boot/dts/c293pcie.dts
@@ -0,0 +1,251 @@
+/*
+ * C293 PCIE Device Tree Source
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
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
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
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
+/include/ "fsl/c293si-pre.dtsi"
+
+/ {
+	model = "fsl,C293PCIE";
+	compatible = "fsl,C293PCIE";
+
+	memory {
+		device_type = "memory";
+	};
+
+	ifc: ifc@fffe1e000 {
+		reg = <0xf 0xffe1e000 0 0x2000>;
+		ranges = <0x0 0x0 0xf 0xec000000 0x04000000
+			  0x2 0x0 0xf 0xffdf0000 0x00010000>;
+
+	};
+
+	soc: soc@fffe00000 {
+		ranges = <0x0 0xf 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@fffe0a000 {
+		reg = <0xf 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
+
+&ifc {
+	nor@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x4000000>;
+		bank-width = <2>;
+		device-width = <1>;
+
+		partition@0 {
+			/* 1MB for DTB Image */
+			reg = <0x0 0x00100000>;
+			label = "NOR DTB Image";
+		};
+
+		partition@100000 {
+			/* 8 MB for Linux Kernel Image */
+			reg = <0x00100000 0x00800000>;
+			label = "NOR Linux Kernel Image";
+		};
+
+		partition@900000 {
+			/* 33MB for rootfs */
+			reg = <0x00900000 0x02100000>;
+			label = "NOR Rootfs Image";
+		};
+
+		partition@2a00000 {
+			/* 20MB for JFFS2 based Root file System */
+			reg = <0x02a00000 0x01400000>;
+			label = "NOR JFFS2 Root File System";
+		};
+
+		partition@3e00000 {
+			/* 1MB for blob encrypted key */
+			reg = <0x03e00000 0x00100000>;
+			label = "NOR blob encrypted key";
+		};
+
+		partition@3f00000 {
+			/* 512KB for u-boot Bootloader Image and evn */
+			reg = <0x03f00000 0x00100000>;
+			label = "NOR U-Boot Image";
+			read-only;
+		};
+	};
+
+	nand@1,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,ifc-nand";
+		reg = <0x1 0x0 0x10000>;
+
+		partition@0 {
+			/* This location must not be altered  */
+			/* 1MB for u-boot Bootloader Image */
+			reg = <0x0 0x00100000>;
+			label = "NAND U-Boot Image";
+			read-only;
+		};
+
+		partition@100000 {
+			/* 1MB for DTB Image */
+			reg = <0x00100000 0x00100000>;
+			label = "NAND DTB Image";
+		};
+
+		partition@200000 {
+			/* 4MB for Linux Kernel Image */
+			reg = <0x00200000 0x00400000>;
+			label = "NAND Linux Kernel Image";
+		};
+
+		partition@600000 {
+			/* 4MB for Compressed Root file System Image */
+			reg = <0x00600000 0x00400000>;
+			label = "NAND Compressed RFS Image";
+		};
+
+		partition@a00000 {
+			/* 15MB for JFFS2 based Root file System */
+			reg = <0x00a00000 0x00f00000>;
+			label = "NAND JFFS2 Root File System";
+		};
+
+		partition@1900000 {
+			/* 7MB for User Area */
+			reg = <0x01900000 0x00700000>;
+			label = "NAND User area";
+		};
+	};
+
+	cpld@2,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,c293pcie-cpld";
+		reg = <0x2 0x0 0x0000020>;
+		bank-width = <1>;
+		device-width = <1>;
+	};
+};
+
+&soc {
+	i2c@3000 {
+		eeprom@50 {
+			compatible = "st,24c1024";
+			reg = <0x50>;
+		};
+
+		adt7461@4c {
+			compatible = "adi,adt7461";
+			reg = <0x4c>;
+		};
+	};
+
+	spi@7000 {
+		flash@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "spansion,s25sl12801";
+			reg = <0>;
+			spi-max-frequency = <50000000>;
+
+			partition@0 {
+				/* 1MB for u-boot Bootloader Image */
+				/* 1MB for Environment */
+				reg = <0x0 0x00100000>;
+				label = "SPI Flash U-Boot Image";
+				read-only;
+			};
+
+			partition@100000 {
+				/* 512KB for DTB Image */
+				reg = <0x00100000 0x00080000>;
+				label = "SPI Flash DTB Image";
+			};
+
+			partition@180000 {
+				/* 4MB for Linux Kernel Image */
+				reg = <0x00180000 0x00400000>;
+				label = "SPI Flash Linux Kernel Image";
+			};
+
+			partition@580000 {
+				/* 4MB for Compressed RFS Image */
+				reg = <0x00580000 0x00400000>;
+				label = "SPI Flash Compressed RFSImage";
+			};
+
+			partition@980000 {
+				/* 6.5MB for JFFS2 based RFS */
+				reg = <0x00980000 0x00680000>;
+				label = "SPI Flash JFFS2 RFS";
+			};
+		};
+	};
+
+	mdio@24000 {
+		phy0: ethernet-phy@0 {
+			interrupts = <2 1 0 0>;
+			reg = <0x0>;
+		};
+
+		phy1: ethernet-phy@1 {
+			interrupts = <2 1 0 0>;
+			reg = <0x2>;
+		};
+	};
+
+	enet0: ethernet@b0000 {
+		phy-handle = <&phy0>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	enet1: ethernet@b1000 {
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii-id";
+	};
+};
+/include/ "fsl/c293si-post.dtsi"
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index a0dcd57..df26b21 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -32,6 +32,13 @@ config BSC9131_RDB
 	  StarCore SC3850 DSP
 	  Manufacturer : Freescale Semiconductor, Inc
 
+config C293_PCIE
+	  bool "Freescale C293PCIE"
+	  select DEFAULT_UIMAGE
+	  select SWIOTLB
+	  help
+	  This option enables support for the C293PCIE board
+
 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 07d0dbb..55b32cc 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SMP) += smp.o
 obj-y += common.o
 
 obj-$(CONFIG_BSC9131_RDB) += bsc913x_rdb.o
+obj-$(CONFIG_C293_PCIE)   += c293pcie.o
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
diff --git a/arch/powerpc/platforms/85xx/c293pcie.c b/arch/powerpc/platforms/85xx/c293pcie.c
new file mode 100644
index 0000000..75dda12
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/c293pcie.c
@@ -0,0 +1,82 @@
+/*
+ * C293PCIE Board Setup
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+#include "mpc85xx.h"
+
+void __init c293_pcie_pic_init(void)
+{
+	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
+	  MPIC_SINGLE_DEST_CPU, 0, 256, " OpenPIC  ");
+
+	BUG_ON(mpic == NULL);
+
+	mpic_init(mpic);
+}
+
+
+/*
+ * Setup the architecture
+ */
+static void __init c293_pcie_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("c293_pcie_setup_arch()", 0);
+
+	fsl_pci_assign_primary();
+
+	printk(KERN_INFO "C293 PCIE board from Freescale Semiconductor\n");
+}
+
+machine_arch_initcall(c293_pcie, mpc85xx_common_publish_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init c293_pcie_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "fsl,C293PCIE"))
+		return 1;
+	return 0;
+}
+
+define_machine(c293_pcie) {
+	.name			= "C293 PCIE",
+	.probe			= c293_pcie_probe,
+	.setup_arch		= c293_pcie_setup_arch,
+	.init_IRQ		= c293_pcie_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.8.0
