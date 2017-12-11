Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yw86F0bXYzDr4p
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 14:47:16 +1100 (AEDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
CC: <linuxppc-dev@lists.ozlabs.org>, Paul Gortmaker
 <paul.gortmaker@windriver.com>
Subject: [PATCH-next] powerpc: remove retired sbc834x support
Date: Sun, 10 Dec 2017 22:29:13 -0500
Message-ID: <20171211032913.31253-1-paul.gortmaker@windriver.com>
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

I no longer have a functional version of this board for even the most
basic sanity boot testing, and they have not been available for purchase
for quite some years now.

There is no point in adding a burden to testing coverage that does
walk all the possible defconfigs, so with all the above in mind, it
makes sense to remove it.  Of course it will remain in the git history
for anyone who happens to stumble on one and wants to tinker with it.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8349.dts           | 331 ----------------------------
 arch/powerpc/configs/83xx/sbc834x_defconfig |  74 -------
 arch/powerpc/platforms/83xx/Kconfig         |   7 -
 arch/powerpc/platforms/83xx/Makefile        |   1 -
 arch/powerpc/platforms/83xx/sbc834x.c       |  73 ------
 5 files changed, 486 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/sbc8349.dts
 delete mode 100644 arch/powerpc/configs/83xx/sbc834x_defconfig
 delete mode 100644 arch/powerpc/platforms/83xx/sbc834x.c

diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
deleted file mode 100644
index fc89e00b765c..000000000000
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ /dev/null
@@ -1,331 +0,0 @@
-/*
- * SBC8349E Device Tree Source
- *
- * Copyright 2007 Wind River Inc.
- *
- * Paul Gortmaker (see MAINTAINERS for contact information)
- *
- *	-based largely on the Freescale MPC834x_MDS dts.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/dts-v1/;
-
-/ {
-	model = "SBC8349E";
-	compatible = "SBC834xE";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8349@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			d-cache-line-size = <32>;
-			i-cache-line-size = <32>;
-			d-cache-size = <32768>;
-			i-cache-size = <32768>;
-			timebase-frequency = <0>;	// from bootloader
-			bus-frequency = <0>;		// from bootloader
-			clock-frequency = <0>;		// from bootloader
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x00000000 0x10000000>;	// 256MB at 0
-	};
-
-	soc8349@e0000000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		ranges = <0x0 0xe0000000 0x00100000>;
-		reg = <0xe0000000 0x00000200>;
-		bus-frequency = <0>;
-
-		wdt@200 {
-			compatible = "mpc83xx_wdt";
-			reg = <0x200 0x100>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <14 0x8>;
-			interrupt-parent = <&ipic>;
-			dfsrr;
-		};
-
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <15 0x8>;
-			interrupt-parent = <&ipic>;
-			dfsrr;
-		};
-
-		spi@7000 {
-			cell-index = <0>;
-			compatible = "fsl,spi";
-			reg = <0x7000 0x1000>;
-			interrupts = <16 0x8>;
-			interrupt-parent = <&ipic>;
-			mode = "cpu";
-		};
-
-		dma@82a8 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
-			reg = <0x82a8 4>;
-			ranges = <0 0x8100 0x1a8>;
-			interrupt-parent = <&ipic>;
-			interrupts = <71 8>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-				reg = <0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&ipic>;
-				interrupts = <71 8>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&ipic>;
-				interrupts = <71 8>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&ipic>;
-				interrupts = <71 8>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-				reg = <0x180 0x28>;
-				cell-index = <3>;
-				interrupt-parent = <&ipic>;
-				interrupts = <71 8>;
-			};
-		};
-
-		/* phy type (ULPI or SERIAL) are only types supported for MPH */
-		/* port = 0 or 1 */
-		usb@22000 {
-			compatible = "fsl-usb2-mph";
-			reg = <0x22000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupt-parent = <&ipic>;
-			interrupts = <39 0x8>;
-			phy_type = "ulpi";
-			port0;
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <32 0x8 33 0x8 34 0x8>;
-			interrupt-parent = <&ipic>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			linux,network-index = <0>;
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@19 {
-					interrupt-parent = <&ipic>;
-					interrupts = <20 0x8>;
-					reg = <0x19>;
-				};
-
-				phy1: ethernet-phy@1a {
-					interrupt-parent = <&ipic>;
-					interrupts = <21 0x8>;
-					reg = <0x1a>;
-				};
-
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 0x8 36 0x8 37 0x8>;
-			interrupt-parent = <&ipic>;
-			tbi-handle = <&tbi1>;
-			phy-handle = <&phy1>;
-			linux,network-index = <1>;
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi1: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <9 0x8>;
-			interrupt-parent = <&ipic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <10 0x8>;
-			interrupt-parent = <&ipic>;
-		};
-
-		crypto@30000 {
-			compatible = "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <11 0x8>;
-			interrupt-parent = <&ipic>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0x7e>;
-			fsl,descriptor-types-mask = <0x01010ebf>;
-		};
-
-		/* IPIC
-		 * interrupts cell = <intr #, sense>
-		 * sense values match linux IORESOURCE_IRQ_* defines:
-		 * sense == 8: Level, low assertion
-		 * sense == 2: Edge, high-to-low change
-		 */
-		ipic: pic@700 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x700 0x100>;
-			device_type = "ipic";
-		};
-	};
-
-	localbus@e0005000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8349-localbus", "simple-bus";
-		reg = <0xe0005000 0x1000>;
-		interrupts = <77 0x8>;
-		interrupt-parent = <&ipic>;
-		ranges = <0x0 0x0 0xff800000 0x00800000		/* 8MB Flash */
-			  0x1 0x0 0xf8000000 0x00002000		/* 8KB EEPROM */
-			  0x2 0x0 0x10000000 0x04000000		/* 64MB SDRAM */
-			  0x3 0x0 0x10000000 0x04000000>;	/* 64MB SDRAM */
-
-		flash@0,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "intel,28F640J3A", "cfi-flash";
-			reg = <0x0 0x0 0x800000>;
-			bank-width = <2>;
-			device-width = <1>;
-
-			partition@0 {
-				label = "u-boot";
-				reg = <0x00000000 0x00040000>;
-				read-only;
-			};
-
-			partition@40000 {
-				label = "user";
-				reg = <0x00040000 0x006c0000>;
-			};
-
-			partition@700000 {
-				label = "legacy u-boot";
-				reg = <0x00700000 0x00100000>;
-				read-only;
-			};
-
-		};
-	};
-
-	pci0: pci@e0008500 {
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-
-				/* IDSEL 0x11 */
-				 0x8800 0x0 0x0 0x1 &ipic 48 0x8
-				 0x8800 0x0 0x0 0x2 &ipic 17 0x8
-				 0x8800 0x0 0x0 0x3 &ipic 18 0x8
-				 0x8800 0x0 0x0 0x4 &ipic 19 0x8>;
-
-		interrupt-parent = <&ipic>;
-		interrupts = <0x42 0x8>;
-		bus-range = <0 0>;
-		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
-			  0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
-			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
-		clock-frequency = <66666666>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xe0008500 0x100		/* internal registers */
-		       0xe0008300 0x8>;		/* config space access registers */
-		compatible = "fsl,mpc8349-pci";
-		device_type = "pci";
-	};
-};
diff --git a/arch/powerpc/configs/83xx/sbc834x_defconfig b/arch/powerpc/configs/83xx/sbc834x_defconfig
deleted file mode 100644
index 7d74699334da..000000000000
--- a/arch/powerpc/configs/83xx/sbc834x_defconfig
+++ /dev/null
@@ -1,74 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_EXPERT=y
-# CONFIG_KALLSYMS is not set
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_PPC_CHRP is not set
-# CONFIG_PPC_PMAC is not set
-CONFIG_PPC_83xx=y
-CONFIG_SBC834x=y
-CONFIG_GEN_RTC=y
-CONFIG_PCI=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=m
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_SYN_COOKIES=y
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-# CONFIG_FW_LOADER is not set
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=32768
-CONFIG_SCSI=y
-# CONFIG_SCSI_PROC_FS is not set
-CONFIG_BLK_DEV_SD=y
-# CONFIG_SCSI_LOWLEVEL is not set
-CONFIG_NETDEVICES=y
-CONFIG_GIANFAR=y
-CONFIG_BROADCOM_PHY=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_VT is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_SERIAL_8250_PCI is not set
-CONFIG_SERIAL_8250_NR_UARTS=2
-CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_MPC=y
-CONFIG_WATCHDOG=y
-# CONFIG_USB_HID is not set
-CONFIG_USB=y
-CONFIG_USB_MON=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_STORAGE=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT4_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V4=y
-CONFIG_ROOT_NFS=y
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 7e38b7b71a5a..071f53b0c0a0 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -90,13 +90,6 @@ config MPC837x_RDB
 	help
 	  This option enables support for the MPC837x RDB and WLAN Boards.
 
-config SBC834x
-	bool "Wind River SBC834x"
-	select DEFAULT_UIMAGE
-	select PPC_MPC834x
-	help
-	  This option enables support for the Wind River SBC834x board.
-
 config ASP834x
 	bool "Analogue & Micro ASP 834x"
 	select PPC_MPC834x
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index bb4720897f6a..41cb5f842eff 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_MPC836x_MDS)	+= mpc836x_mds.o
 obj-$(CONFIG_MPC836x_RDK)	+= mpc836x_rdk.o
 obj-$(CONFIG_MPC832x_MDS)	+= mpc832x_mds.o
 obj-$(CONFIG_MPC837x_MDS)	+= mpc837x_mds.o
-obj-$(CONFIG_SBC834x)		+= sbc834x.o
 obj-$(CONFIG_MPC837x_RDB)	+= mpc837x_rdb.o
 obj-$(CONFIG_ASP834x)		+= asp834x.o
 obj-$(CONFIG_KMETER1)		+= km83xx.o
diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
deleted file mode 100644
index cb4bdabfdf1c..000000000000
--- a/arch/powerpc/platforms/83xx/sbc834x.c
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * arch/powerpc/platforms/83xx/sbc834x.c
- *
- * Wind River SBC834x board specific routines
- *
- * By Paul Gortmaker (see MAINTAINERS for contact information)
- *
- * Based largely on the mpc834x_mds.c support by Kumar Gala.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/of_platform.h>
-
-#include <linux/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
-#include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
-
-#include "mpc83xx.h"
-
-/* ************************************************************************
- *
- * Setup the architecture
- *
- */
-static void __init sbc834x_setup_arch(void)
-{
-	mpc83xx_setup_arch();
-}
-
-machine_device_initcall(sbc834x, mpc83xx_declare_of_platform_devices);
-
-/*
- * Called very early, MMU is off, device-tree isn't unflattened
- */
-static int __init sbc834x_probe(void)
-{
-	return of_machine_is_compatible("SBC834xE");
-}
-
-define_machine(sbc834x) {
-	.name			= "SBC834xE",
-	.probe			= sbc834x_probe,
-	.setup_arch		= sbc834x_setup_arch,
-	.init_IRQ		= mpc83xx_ipic_init_IRQ,
-	.get_irq		= ipic_get_irq,
-	.restart		= mpc83xx_restart,
-	.time_init		= mpc83xx_time_init,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-};
-- 
2.14.1
