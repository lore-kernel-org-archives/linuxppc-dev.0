Return-Path: <Holger.Brunck@keymile.com>
Received: from mail.de.keymile.com (mail.de.keymile.com [195.8.104.1])
	by ozlabs.org (Postfix) with SMTP id 38EF2B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Jan 2011 23:22:51 +1100 (EST)
Message-ID: <4D2EEBEF.2010005@keymile.com>
Date: Thu, 13 Jan 2011 13:11:27 +0100
From: Holger Brunck <holger.brunck@keymile.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ppc, 8xx: remove obsolete mgsuvd board
Content-Type: text/plain;
	charset=ISO-8859-1
Cc: Heiko Schocher <hs@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MPC852 based mgsuvd board from Keymile was initially ported,
but later on not developed further. This patch removes the respective
files to decrease merging conflicts and unneeded maintenance.

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Acked-by: Heiko Schocher<hs@denx.de>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: Marcelo Tosatti <marcelo@kvack.org>
---
 arch/powerpc/boot/dts/mgsuvd.dts      |  163 ---------------------------------
 arch/powerpc/configs/mgsuvd_defconfig |   81 ----------------
 arch/powerpc/platforms/8xx/Kconfig    |    6 -
 arch/powerpc/platforms/8xx/Makefile   |    1 -
 arch/powerpc/platforms/8xx/mgsuvd.c   |   92 ------------------
 5 files changed, 0 insertions(+), 343 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/mgsuvd.dts
 delete mode 100644 arch/powerpc/configs/mgsuvd_defconfig
 delete mode 100644 arch/powerpc/platforms/8xx/mgsuvd.c

diff --git a/arch/powerpc/boot/dts/mgsuvd.dts b/arch/powerpc/boot/dts/mgsuvd.dts
deleted file mode 100644
index e4fc53a..0000000
--- a/arch/powerpc/boot/dts/mgsuvd.dts
+++ /dev/null
@@ -1,163 +0,0 @@
-/*
- * MGSUVD Device Tree Source
- *
- * Copyright 2008 DENX Software Engineering GmbH
- * Heiko Schocher <hs@denx.de>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/dts-v1/;
-/ {
-	model = "MGSUVD";
-	compatible = "keymile,mgsuvd";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,852@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <16>;
-			i-cache-line-size = <16>;
-			d-cache-size = <8192>;
-			i-cache-size = <8192>;
-			timebase-frequency = <0>;	/* Filled in by u-boot */
-			bus-frequency = <0>;		/* Filled in by u-boot */
-			clock-frequency = <0>;		/* Filled in by u-boot */
-			interrupts = <15 2>;		/* decrementer interrupt */
-			interrupt-parent = <&PIC>;
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <00000000 0x4000000>;  /* Filled in by u-boot */
-	};
-
-	localbus@fff00100 {
-		compatible = "fsl,mpc852-localbus", "fsl,pq1-localbus", "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <1>;
-		reg = <0xfff00100 0x40>;
-
-		ranges = <0 0 0xf0000000 0x01000000>;  /* Filled in by u-boot */
-
-		flash@0,0 {
-			compatible = "cfi-flash";
-			reg = <0 0 0x1000000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			bank-width = <1>;
-			device-width = <1>;
-			partition@0 {
-				label = "u-boot";
-				reg = <0 0x80000>;
-			};
-			partition@80000 {
-				label = "env";
-				reg = <0x80000 0x20000>;
-			};
-			partition@a0000 {
-				label = "kernel";
-				reg = <0xa0000 0x1e0000>;
-			};
-			partition@280000 {
-				label = "dtb";
-				reg = <0x280000 0x20000>;
-			};
-			partition@2a0000 {
-			        label = "root";
-			        reg = <0x2a0000 0x500000>;
-			};
-			partition@7a0000 {
-			        label = "user";
-			        reg = <0x7a0000 0x860000>;
-			};
-		};
-	};
-
-	soc@fff00000 {
-		compatible = "fsl,mpc852", "fsl,pq1-soc", "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		ranges = <0 0xfff00000 0x00004000>;
-
-		PIC: interrupt-controller@0 {
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			reg = <0 24>;
-			compatible = "fsl,mpc852-pic", "fsl,pq1-pic";
-		};
-
-		cpm@9c0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc852-cpm", "fsl,cpm1", "simple-bus";
-			interrupts = <0>;	/* cpm error interrupt */
-			interrupt-parent = <&CPM_PIC>;
-			reg = <0x9c0 10>;
-			ranges;
-
-			muram@2000 {
-				compatible = "fsl,cpm-muram";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x2000 0x2000>;
-
-				data@0 {
-					compatible = "fsl,cpm-muram-data";
-					reg = <0x800 0x1800>;
-				};
-			};
-
-			brg@9f0 {
-				compatible = "fsl,mpc852-brg",
-				             "fsl,cpm1-brg",
-				             "fsl,cpm-brg";
-				reg = <0x9f0 0x10>;
-				clock-frequency = <0>; /* Filled in by u-boot */
-			};
-
-			CPM_PIC: interrupt-controller@930 {
-				interrupt-controller;
-				#interrupt-cells = <1>;
-				interrupts = <5 2 0 2>;
-				interrupt-parent = <&PIC>;
-				reg = <0x930 0x20>;
-				compatible = "fsl,cpm1-pic";
-			};
-
-			/* MON-1 */
-			serial@a80 {
-				device_type = "serial";
-				compatible = "fsl,cpm1-smc-uart";
-				reg = <0xa80 0x10 0x3fc0 0x40>;
-				interrupts = <4>;
-				interrupt-parent = <&CPM_PIC>;
-				fsl,cpm-brg = <1>;
-				fsl,cpm-command = <0x0090>;
-				current-speed = <0>; /* Filled in by u-boot */
-			};
-
-			ethernet@a40 {
-				device_type = "network";
-				compatible  = "fsl,mpc866-scc-enet",
-				              "fsl,cpm1-scc-enet";
-				reg = <0xa40 0x18 0x3e00 0x100>;
-				local-mac-address = [ 00 00 00 00 00 00 ];  /* Filled in by u-boot */
-				interrupts = <28>;
-				interrupt-parent = <&CPM_PIC>;
-				fsl,cpm-command = <0x80>;
-				fixed-link = <0 0 10 0 0>;
-			};
-		};
-	};
-};
diff --git a/arch/powerpc/configs/mgsuvd_defconfig
b/arch/powerpc/configs/mgsuvd_defconfig
deleted file mode 100644
index f276c7c..0000000
--- a/arch/powerpc/configs/mgsuvd_defconfig
+++ /dev/null
@@ -1,81 +0,0 @@
-CONFIG_PPC_8xx=y
-CONFIG_EXPERIMENTAL=y
-# CONFIG_SWAP is not set
-CONFIG_SYSVIPC=y
-CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_EMBEDDED=y
-# CONFIG_SYSCTL_SYSCALL is not set
-# CONFIG_HOTPLUG is not set
-# CONFIG_BUG is not set
-# CONFIG_BASE_FULL is not set
-# CONFIG_EPOLL is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-CONFIG_SLAB=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PPC_MGSUVD=y
-CONFIG_8xx_COPYBACK=y
-CONFIG_8xx_CPU6=y
-CONFIG_I2C_SPI_SMC1_UCODE_PATCH=y
-CONFIG_HZ_1000=y
-CONFIG_MATH_EMULATION=y
-CONFIG_SPARSE_IRQ=y
-# CONFIG_SECCOMP is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
-CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_OF_PARTS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_ADV_OPTIONS=y
-CONFIG_MTD_CFI_GEOMETRY=y
-# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_STAA=y
-CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-# CONFIG_MISC_DEVICES is not set
-CONFIG_NETDEVICES=y
-CONFIG_FIXED_PHY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_FS_ENET=y
-# CONFIG_FS_ENET_HAS_FEC is not set
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_INPUT is not set
-# CONFIG_SERIO is not set
-# CONFIG_VT is not set
-CONFIG_SERIAL_CPM=y
-CONFIG_SERIAL_CPM_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_GEN_RTC=y
-# CONFIG_HWMON is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_INOTIFY=y
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_CRAMFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_CRC_CCITT=y
-CONFIG_DEBUG_FS=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index dd35ce0..ee56a9e 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -49,12 +49,6 @@ config PPC_ADDER875
 	  This enables support for the Analogue & Micro Adder 875
 	  board.

-config PPC_MGSUVD
-	bool "MGSUVD"
-	select CPM1
-	help
-	  This enables support for the Keymile MGSUVD board.
-
 config TQM8XX
 	bool "TQM8XX"
 	select CPM1
diff --git a/arch/powerpc/platforms/8xx/Makefile
b/arch/powerpc/platforms/8xx/Makefile
index a491fe6..76a81c3 100644
--- a/arch/powerpc/platforms/8xx/Makefile
+++ b/arch/powerpc/platforms/8xx/Makefile
@@ -6,5 +6,4 @@ obj-$(CONFIG_MPC885ADS)   += mpc885ads_setup.o
 obj-$(CONFIG_MPC86XADS)   += mpc86xads_setup.o
 obj-$(CONFIG_PPC_EP88XC)  += ep88xc.o
 obj-$(CONFIG_PPC_ADDER875) += adder875.o
-obj-$(CONFIG_PPC_MGSUVD) += mgsuvd.o
 obj-$(CONFIG_TQM8XX)      += tqm8xx_setup.o
diff --git a/arch/powerpc/platforms/8xx/mgsuvd.c
b/arch/powerpc/platforms/8xx/mgsuvd.c
deleted file mode 100644
index ca3cb07..0000000
--- a/arch/powerpc/platforms/8xx/mgsuvd.c
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- *
- * Platform setup for the Keymile mgsuvd board
- *
- * Heiko Schocher <hs@denx.de>
- *
- * Copyright 2008 DENX Software Engineering GmbH
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#include <linux/ioport.h>
-#include <linux/of_platform.h>
-
-#include <asm/io.h>
-#include <asm/machdep.h>
-#include <asm/processor.h>
-#include <asm/cpm1.h>
-#include <asm/prom.h>
-#include <asm/fs_pd.h>
-
-#include "mpc8xx.h"
-
-struct cpm_pin {
-	int port, pin, flags;
-};
-
-static __initdata struct cpm_pin mgsuvd_pins[] = {
-	/* SMC1 */
-	{CPM_PORTB, 24, CPM_PIN_INPUT}, /* RX */
-	{CPM_PORTB, 25, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TX */
-
-	/* SCC3 */
-	{CPM_PORTA, 10, CPM_PIN_INPUT},
-	{CPM_PORTA, 11, CPM_PIN_INPUT},
-	{CPM_PORTA, 3, CPM_PIN_INPUT},
-	{CPM_PORTA, 2, CPM_PIN_INPUT},
-	{CPM_PORTC, 13, CPM_PIN_INPUT},
-};
-
-static void __init init_ioports(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mgsuvd_pins); i++) {
-		struct cpm_pin *pin = &mgsuvd_pins[i];
-		cpm1_set_pin(pin->port, pin->pin, pin->flags);
-	}
-
-	setbits16(&mpc8xx_immr->im_ioport.iop_pcso, 0x300);
-	cpm1_clk_setup(CPM_CLK_SCC3, CPM_CLK5, CPM_CLK_RX);
-	cpm1_clk_setup(CPM_CLK_SCC3, CPM_CLK6, CPM_CLK_TX);
-	cpm1_clk_setup(CPM_CLK_SMC1, CPM_BRG1, CPM_CLK_RTX);
-}
-
-static void __init mgsuvd_setup_arch(void)
-{
-	cpm_reset();
-	init_ioports();
-}
-
-static __initdata struct of_device_id of_bus_ids[] = {
-	{ .compatible = "simple-bus" },
-	{},
-};
-
-static int __init declare_of_platform_devices(void)
-{
-	of_platform_bus_probe(NULL, of_bus_ids, NULL);
-	return 0;
-}
-machine_device_initcall(mgsuvd, declare_of_platform_devices);
-
-static int __init mgsuvd_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-	return of_flat_dt_is_compatible(root, "keymile,mgsuvd");
-}
-
-define_machine(mgsuvd) {
-	.name           = "MGSUVD",
-	.probe          = mgsuvd_probe,
-	.setup_arch     = mgsuvd_setup_arch,
-	.init_IRQ       = mpc8xx_pics_init,
-	.get_irq        = mpc8xx_get_irq,
-	.restart        = mpc8xx_restart,
-	.calibrate_decr = mpc8xx_calibrate_decr,
-	.set_rtc_time   = mpc8xx_set_rtc_time,
-	.get_rtc_time   = mpc8xx_get_rtc_time,
-};
-- 
1.7.0.5
