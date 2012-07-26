Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 90A3A2C0092
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2012 01:09:08 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: Kim Phillips <kim.phillips@freescale.com>, Scott Wood
 <scottwood@freescale.com>, Kumar Gala <galak@kernel.crashing.org>,
 <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] [v4] powerpc/p5040ds: Add support for P5040DS board
Date: Thu, 26 Jul 2012 10:08:54 -0500
Message-ID: <1343315334-800-3-git-send-email-timur@freescale.com>
In-Reply-To: <1343315334-800-1-git-send-email-timur@freescale.com>
References: <1343315334-800-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the Freescale P5040DS Reference Board ("Superhydra"), which
is similar to the P5020DS.  Features of the P5040 are listed below, but
not all of these features (e.g. DPAA networking) are currently supported.

Four P5040 single-threaded e5500 cores built
    Up to 2.4 GHz with 64-bit ISA support
    Three levels of instruction: user, supervisor, hypervisor
CoreNet platform cache (CPC)
    2.0 MB configures as dual 1 MB blocks hierarchical interconnect fabric
Two 64-bit DDR3/3L SDRAM memory controllers with ECC and interleaving support
    Up to 1600MT/s
    Memory pre-fetch engine
DPAA incorporating acceleration for the following functions
    Packet parsing, classification, and distribution (FMAN)
    Queue management for scheduling, packet sequencing and
	congestion management (QMAN)
    Hardware buffer management for buffer allocation and
	de-allocation (BMAN)
    Cryptography acceleration (SEC 5.0) at up to 40 Gbps
SerDes
    20 lanes at up to 5 Gbps
    Supports SGMII, XAUI, PCIe rev1.1/2.0, SATA
Ethernet interfaces
    Two 10 Gbps Ethernet MACs
    Ten 1 Gbps Ethernet MACs
High-speed peripheral interfaces
    Two PCI Express 2.0/3.0 controllers
Additional peripheral interfaces
    Two serial ATA (SATA 2.0) controllers
    Two high-speed USB 2.0 controllers with integrated PHY
    Enhanced secure digital host controller (SD/MMC/eMMC)
    Enhanced serial peripheral interface (eSPI)
    Two I2C controllers
    Four UARTs
    Integrated flash controller supporting NAND and NOR flash
DMA
    Dual four channel
Support for hardware virtualization and partitioning enforcement
    Extra privileged level for hypervisor support
QorIQ Trust Architecture 1.1
    Secure boot, secure debug, tamper detection, volatile key storage

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/p5040ds.dts            |  203 ++++++++++++++++++++++++++
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/configs/corenet64_smp_defconfig |    1 +
 arch/powerpc/platforms/85xx/Kconfig          |   14 ++
 arch/powerpc/platforms/85xx/Makefile         |    1 +
 arch/powerpc/platforms/85xx/corenet_ds.c     |   10 +-
 arch/powerpc/platforms/85xx/p5040_ds.c       |   89 +++++++++++
 7 files changed, 318 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p5040ds.dts
 create mode 100644 arch/powerpc/platforms/85xx/p5040_ds.c

diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/p5040ds.dts
new file mode 100644
index 0000000..d86bf2e
--- /dev/null
+++ b/arch/powerpc/boot/dts/p5040ds.dts
@@ -0,0 +1,203 @@
+/*
+ * P5040DS Device Tree Source
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
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
+ * This software is provided by Freescale Semiconductor "as is" and any
+ * express or implied warranties, including, but not limited to, the implied
+ * warranties of merchantability and fitness for a particular purpose are
+ * disclaimed. In no event shall Freescale Semiconductor be liable for any
+ * direct, indirect, incidental, special, exemplary, or consequential damages
+ * (including, but not limited to, procurement of substitute goods or services;
+ * loss of use, data, or profits; or business interruption) however caused and
+ * on any theory of liability, whether in contract, strict liability, or tort
+ * (including negligence or otherwise) arising in any way out of the use of this
+ * software, even if advised of the possibility of such damage.
+ */
+
+/include/ "fsl/p5040si-pre.dtsi"
+
+/ {
+	model = "fsl,P5040DS";
+	compatible = "fsl,P5040DS";
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
+		spi@110000 {
+			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "spansion,s25sl12801";
+				reg = <0>;
+				spi-max-frequency = <40000000>; /* input clock */
+				partition@u-boot {
+					label = "u-boot";
+					reg = <0x00000000 0x00100000>;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00100000 0x00500000>;
+				};
+				partition@dtb {
+					label = "dtb";
+					reg = <0x00600000 0x00100000>;
+				};
+				partition@fs {
+					label = "file system";
+					reg = <0x00700000 0x00900000>;
+				};
+			};
+		};
+
+		i2c@118100 {
+			eeprom@51 {
+				compatible = "at24,24c256";
+				reg = <0x51>;
+			};
+			eeprom@52 {
+				compatible = "at24,24c256";
+				reg = <0x52>;
+			};
+		};
+
+		i2c@119100 {
+			rtc@68 {
+				compatible = "dallas,ds3232";
+				reg = <0x68>;
+				interrupts = <0x1 0x1 0 0>;
+			};
+		};
+	};
+
+	lbc: localbus@ffe124000 {
+		reg = <0xf 0xfe124000 0 0x1000>;
+		ranges = <0 0 0xf 0xe8000000 0x08000000
+			  2 0 0xf 0xffa00000 0x00040000
+			  3 0 0xf 0xffdf0000 0x00008000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x08000000>;
+			bank-width = <2>;
+			device-width = <2>;
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,elbc-fcm-nand";
+			reg = <0x2 0x0 0x40000>;
+
+			partition@0 {
+				label = "NAND U-Boot Image";
+				reg = <0x0 0x02000000>;
+			};
+
+			partition@2000000 {
+				label = "NAND Root File System";
+				reg = <0x02000000 0x10000000>;
+			};
+
+			partition@12000000 {
+				label = "NAND Compressed RFS Image";
+				reg = <0x12000000 0x08000000>;
+			};
+
+			partition@1a000000 {
+				label = "NAND Linux Kernel Image";
+				reg = <0x1a000000 0x04000000>;
+			};
+
+			partition@1e000000 {
+				label = "NAND DTB Image";
+				reg = <0x1e000000 0x01000000>;
+			};
+
+			partition@1f000000 {
+				label = "NAND Writable User area";
+				reg = <0x1f000000 0x01000000>;
+			};
+		};
+
+		board-control@3,0 {
+			compatible = "fsl,p5040ds-fpga", "fsl,fpga-ngpixis";
+			reg = <3 0 0x40>;
+		};
+	};
+
+	pci0: pcie@ffe200000 {
+		reg = <0xf 0xfe200000 0 0x1000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x20000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+
+	pci1: pcie@ffe201000 {
+		reg = <0xf 0xfe201000 0 0x1000>;
+		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x20000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+
+	pci2: pcie@ffe202000 {
+		reg = <0xf 0xfe202000 0 0x1000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x20000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+};
+
+/include/ "fsl/p5040si-post.dtsi"
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index cbb98c1..3b40015 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -25,6 +25,7 @@ CONFIG_P2041_RDB=y
 CONFIG_P3041_DS=y
 CONFIG_P4080_DS=y
 CONFIG_P5020_DS=y
+CONFIG_P5040_DS=y
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index dd89de8..36df45b 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -23,6 +23,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
 CONFIG_P5020_DS=y
+CONFIG_P5040_DS=y
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_BINFMT_MISC=m
 CONFIG_IRQ_ALL_CPUS=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 159c01e..31f0618 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -254,6 +254,20 @@ config P5020_DS
 	help
 	  This option enables support for the P5020 DS board
 
+config P5040_DS
+	bool "Freescale P5040 DS"
+	select DEFAULT_UIMAGE
+	select E500
+	select PPC_E500MC
+	select PHYS_64BIT
+	select SWIOTLB
+	select ARCH_REQUIRE_GPIOLIB
+	select GPIO_MPC8XXX
+	select HAS_RAPIDIO
+	select PPC_EPAPR_HV_PIC
+	help
+	  This option enables support for the P5040 DS board
+
 config PPC_QEMU_E500
 	bool "QEMU generic e500 platform"
 	depends on EXPERIMENTAL
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 3dfe811..d99268a 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_P2041_RDB)   += p2041_rdb.o corenet_ds.o
 obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
+obj-$(CONFIG_P5040_DS)    += p5040_ds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 925b028..473d573 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -63,7 +63,9 @@ void __init corenet_ds_setup_arch(void)
 #ifdef CONFIG_PCI
 	for_each_node_by_type(np, "pci") {
 		if (of_device_is_compatible(np, "fsl,p4080-pcie") ||
-		    of_device_is_compatible(np, "fsl,qoriq-pcie-v2.2")) {
+		    of_device_is_compatible(np, "fsl,qoriq-pcie-v2.2") ||
+		    of_device_is_compatible(np, "fsl,qoriq-pcie-v2.3") ||
+		    of_device_is_compatible(np, "fsl,qoriq-pcie-v2.4")) {
 			fsl_add_bridge(np, 0);
 			hose = pci_find_hose_for_OF_device(np);
 			max = min(max, hose->dma_window_base_cur +
@@ -99,6 +101,12 @@ static const struct of_device_id of_device_ids[] __devinitconst = {
 	{
 		.compatible	= "fsl,qoriq-pcie-v2.2",
 	},
+	{
+		.compatible	= "fsl,qoriq-pcie-v2.3",
+	},
+	{
+		.compatible	= "fsl,qoriq-pcie-v2.4",
+	},
 	/* The following two are for the Freescale hypervisor */
 	{
 		.name		= "hypervisor",
diff --git a/arch/powerpc/platforms/85xx/p5040_ds.c b/arch/powerpc/platforms/85xx/p5040_ds.c
new file mode 100644
index 0000000..8e22a34
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/p5040_ds.c
@@ -0,0 +1,89 @@
+/*
+ * P5040 DS Setup
+ *
+ * Copyright 2009-2010 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include <asm/machdep.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+#include <linux/of_fdt.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include <asm/ehv_pic.h>
+
+#include "corenet_ds.h"
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init p5040_ds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+#ifdef CONFIG_SMP
+	extern struct smp_ops_t smp_85xx_ops;
+#endif
+
+	if (of_flat_dt_is_compatible(root, "fsl,P5040DS"))
+		return 1;
+
+	/* Check if we're running under the Freescale hypervisor */
+	if (of_flat_dt_is_compatible(root, "fsl,P5040DS-hv")) {
+		ppc_md.init_IRQ = ehv_pic_init;
+		ppc_md.get_irq = ehv_pic_get_irq;
+		ppc_md.restart = fsl_hv_restart;
+		ppc_md.power_off = fsl_hv_halt;
+		ppc_md.halt = fsl_hv_halt;
+#ifdef CONFIG_SMP
+		/*
+		 * Disable the timebase sync operations because we can't write
+		 * to the timebase registers under the hypervisor.
+		  */
+		smp_85xx_ops.give_timebase = NULL;
+		smp_85xx_ops.take_timebase = NULL;
+#endif
+		return 1;
+	}
+
+	return 0;
+}
+
+define_machine(p5040_ds) {
+	.name			= "P5040 DS",
+	.probe			= p5040_ds_probe,
+	.setup_arch		= corenet_ds_setup_arch,
+	.init_IRQ		= corenet_ds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
+#ifdef CONFIG_PPC64
+	.get_irq		= mpic_get_irq,
+#else
+	.get_irq		= mpic_get_coreint_irq,
+#endif
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+#ifdef CONFIG_PPC64
+	.power_save		= book3e_idle,
+#else
+	.power_save		= e500_idle,
+#endif
+};
+
+machine_device_initcall(p5040_ds, corenet_ds_publish_devices);
+
+#ifdef CONFIG_SWIOTLB
+machine_arch_initcall(p5040_ds, swiotlb_setup_bus_notifier);
+#endif
-- 
1.7.3.4
