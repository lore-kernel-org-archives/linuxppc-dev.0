Return-Path: <B43644@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F2FA2C0087
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Aug 2013 17:31:59 +1000 (EST)
From: Po Liu <Po.Liu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v4 3/3] powerpc/85xx: Add C293PCIE board support
Date: Fri, 2 Aug 2013 14:39:11 +0800
Message-ID: <1375425551-821-3-git-send-email-Po.Liu@freescale.com>
In-Reply-To: <1375425551-821-1-git-send-email-Po.Liu@freescale.com>
References: <1375174163-19246-3-git-send-email-Po.Liu@freescale.com>
 <1375425551-821-1-git-send-email-Po.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Mingkai Hu <Mingkai.Hu@freescale.com>,
 afleming@freescale.com, Po Liu <Po.Liu@freescale.com>
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
Signed-off-by: Po Liu <Po.Liu@freescale.com>
---
Changes for v2:
	- Remove the JFFS2 partitions in NOR/NAND/SPI flash;
	- Implement the NAND partitions;
	- Remove the no use descriptions for cpld node;
	- Add mpc85xx_smp_defconfig and mpc85xx_defconfig for C293;
	- Remove the no use includes in c293pcie.c
Changes for v3:
	- Remove some partitions for NAND, merge them into RFS
	- Modify the SPI RFS partition expression
	- Remove #address-cells #size-cells in cpld node
Changes for v4:
	- Set NAND kernel image partition to be 16MB size from 4MB

 arch/powerpc/boot/dts/c293pcie.dts         | 223 +++++++++++++++++++++++++++++
 arch/powerpc/configs/mpc85xx_defconfig     |   1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig |   1 +
 arch/powerpc/platforms/85xx/Kconfig        |   6 +
 arch/powerpc/platforms/85xx/Makefile       |   1 +
 arch/powerpc/platforms/85xx/c293pcie.c     |  75 ++++++++++
 6 files changed, 307 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/c293pcie.dts
 create mode 100644 arch/powerpc/platforms/85xx/c293pcie.c

diff --git a/arch/powerpc/boot/dts/c293pcie.dts b/arch/powerpc/boot/dts/c293pcie.dts
new file mode 100644
index 0000000..1238bda
--- /dev/null
+++ b/arch/powerpc/boot/dts/c293pcie.dts
@@ -0,0 +1,223 @@
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
+			/* 53MB for rootfs */
+			reg = <0x00900000 0x03500000>;
+			label = "NOR Rootfs Image";
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
+			/* 16MB for Linux Kernel Image */
+			reg = <0x00200000 0x01000000>;
+			label = "NAND Linux Kernel Image";
+		};
+
+		partition@1200000 {
+			/* 4078MB for Root file System Image */
+			reg = <0x00600000 0xfee00000>;
+			label = "NAND RFS Image";
+		};
+	};
+
+	cpld@2,0 {
+		compatible = "fsl,c293pcie-cpld";
+		reg = <0x2 0x0 0x20>;
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
+				/* 10.5MB for RFS Image */
+				reg = <0x00580000 0x00a80000>;
+				label = "SPI Flash RFS Image";
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
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 5a58882..1592f8c 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -27,6 +27,7 @@ CONFIG_MPC85xx_MDS=y
 CONFIG_MPC8536_DS=y
 CONFIG_MPC85xx_DS=y
 CONFIG_MPC85xx_RDB=y
+CONFIG_C293_PCIE=y
 CONFIG_P1010_RDB=y
 CONFIG_P1022_DS=y
 CONFIG_P1022_RDK=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 152fa05..d6549ff 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -30,6 +30,7 @@ CONFIG_MPC85xx_MDS=y
 CONFIG_MPC8536_DS=y
 CONFIG_MPC85xx_DS=y
 CONFIG_MPC85xx_RDB=y
+CONFIG_C293_PCIE=y
 CONFIG_P1010_RDB=y
 CONFIG_P1022_DS=y
 CONFIG_P1022_RDK=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index efdd37c..42fc72a 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -32,6 +32,12 @@ config BSC9131_RDB
 	  StarCore SC3850 DSP
 	  Manufacturer : Freescale Semiconductor, Inc
 
+config C293_PCIE
+	  bool "Freescale C293PCIE"
+	  select DEFAULT_UIMAGE
+	  help
+	  This option enables support for the C293PCIE board
+
 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 2eab37e..53c9f75 100644
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
index 0000000..6208e49
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/c293pcie.c
@@ -0,0 +1,75 @@
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
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
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
