Return-Path: <niklaus.giger@member.fsf.org>
Received: from fep12.mx.upcmail.net (fep12.mx.upcmail.net [62.179.121.32])
	by ozlabs.org (Postfix) with ESMTP id 366B1B6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 20:43:03 +1000 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] Remove obsolete HCU4 board
Date: Fri, 22 Jul 2011 12:41:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201107221241.05264.niklaus.giger@member.fsf.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Niklaus Giger <niklaus.giger@member.fsf.org>
---
 arch/powerpc/boot/dts/hcu4.dts          |  168 
-------------------------------
 arch/powerpc/configs/40x/hcu4_defconfig |   80 ---------------
 arch/powerpc/platforms/40x/hcu4.c       |   61 -----------
 3 files changed, 0 insertions(+), 309 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/hcu4.dts
 delete mode 100644 arch/powerpc/configs/40x/hcu4_defconfig
 delete mode 100644 arch/powerpc/platforms/40x/hcu4.c

diff --git a/arch/powerpc/boot/dts/hcu4.dts b/arch/powerpc/boot/dts/hcu4.dts
deleted file mode 100644
index 7988598..0000000
--- a/arch/powerpc/boot/dts/hcu4.dts
+++ /dev/null
@@ -1,168 +0,0 @@
-/*
-* Device Tree Source for Netstal Maschinen HCU4
-* based on the IBM Walnut
-*
-* Copyright 2008
-* Niklaus Giger <niklaus.giger@member.fsf.org>
-*
-* Copyright 2007 IBM Corp.
-* Josh Boyer <jwboyer@linux.vnet.ibm.com>
-*
-* This file is licensed under the terms of the GNU General Public
-* License version 2.  This program is licensed "as is" without
-* any warranty of any kind, whether express or implied.
-*/
-
-/dts-v1/;
-
-/ {
-	#address-cells = <0x1>;
-	#size-cells = <0x1>;
-	model = "netstal,hcu4";
-	compatible = "netstal,hcu4";
-	dcr-parent = <0x1>;
-
-	aliases {
-		ethernet0 = "/plb/opb/ethernet@ef600800";
-		serial0 = "/plb/opb/serial@ef600300";
-	};
-
-	cpus {
-		#address-cells = <0x1>;
-		#size-cells = <0x0>;
-
-		cpu@0 {
-			device_type = "cpu";
-			model = "PowerPC,405GPr";
-			reg = <0x0>;
-			clock-frequency = <0>;		/* Filled in by U-Boot */
-			timebase-frequency = <0x0>;	/* Filled in by U-Boot */
-			i-cache-line-size = <0x20>;
-			d-cache-line-size = <0x20>;
-			i-cache-size = <0x4000>;
-			d-cache-size = <0x4000>;
-			dcr-controller;
-			dcr-access-method = "native";
-			linux,phandle = <0x1>;
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x0 0x0>;	/* Filled in by U-Boot */
-	};
-
-	UIC0: interrupt-controller {
-		compatible = "ibm,uic";
-		interrupt-controller;
-		cell-index = <0x0>;
-		dcr-reg = <0xc0 0x9>;
-		#address-cells = <0x0>;
-		#size-cells = <0x0>;
-		#interrupt-cells = <0x2>;
-		linux,phandle = <0x2>;
-	};
-
-	plb {
-		compatible = "ibm,plb3";
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
-		ranges;
-		clock-frequency = <0x0>;	/* Filled in by U-Boot */
-
-		SDRAM0: memory-controller {
-			compatible = "ibm,sdram-405gp";
-			dcr-reg = <0x10 0x2>;
-		};
-
-		MAL: mcmal {
-			compatible = "ibm,mcmal-405gp", "ibm,mcmal";
-			dcr-reg = <0x180 0x62>;
-			num-tx-chans = <0x1>;
-			num-rx-chans = <0x1>;
-			interrupt-parent = <0x2>;
-			interrupts = <0xb 0x4 0xc 0x4 0xa 0x4 0xd 0x4 0xe 0x4>;
-			linux,phandle = <0x3>;
-		};
-
-		POB0: opb {
-			compatible = "ibm,opb-405gp", "ibm,opb";
-			#address-cells = <0x1>;
-			#size-cells = <0x1>;
-			ranges = <0xef600000 0xef600000 0xa00000>;
-			dcr-reg = <0xa0 0x5>;
-			clock-frequency = <0x0>;	/* Filled in by U-Boot */
-
-			UART0: serial@ef600300 {
-				device_type = "serial";
-				compatible = "ns16550";
-				reg = <0xef600300 0x8>;
-				virtual-reg = <0xef600300>;
-				clock-frequency = <0x0>;/* Filled in by U-Boot */
-				current-speed = <0>;	/* Filled in by U-Boot */
-				interrupt-parent = <0x2>;
-				interrupts = <0x0 0x4>;
-			};
-
-			IIC: i2c@ef600500 {
-				compatible = "ibm,iic-405gp", "ibm,iic";
-				reg = <0xef600500 0x11>;
-				interrupt-parent = <0x2>;
-				interrupts = <0x2 0x4>;
-			};
-
-			GPIO: gpio@ef600700 {
-				compatible = "ibm,gpio-405gp";
-				reg = <0xef600700 0x20>;
-			};
-
-			EMAC: ethernet@ef600800 {
-				device_type = "network";
-				compatible = "ibm,emac-405gp", "ibm,emac";
-				interrupt-parent = <0x2>;
-				interrupts = <0xf 0x4 0x9 0x4>;
-				local-mac-address = [00 00 00 00 00 00];
-				reg = <0xef600800 0x70>;
-				mal-device = <0x3>;
-				mal-tx-channel = <0x0>;
-				mal-rx-channel = <0x0>;
-				cell-index = <0x0>;
-				max-frame-size = <0x5dc>;
-				rx-fifo-size = <0x1000>;
-				tx-fifo-size = <0x800>;
-				phy-mode = "rmii";
-				phy-map = <0x1>;
-			};
-		};
-
-		EBC0: ebc {
-			compatible = "ibm,ebc-405gp", "ibm,ebc";
-			dcr-reg = <0x12 0x2>;
-			#address-cells = <0x2>;
-			#size-cells = <0x1>;
-			clock-frequency = <0x0>;	/* Filled in by U-Boot */
-
-			sram@0,0 {
-				reg = <0x0 0x0 0x80000>;
-			};
-
-			flash@0,80000 {
-				compatible = "jedec-flash";
-				bank-width = <0x1>;
-				reg = <0x0 0x80000 0x80000>;
-				#address-cells = <0x1>;
-				#size-cells = <0x1>;
-
-				partition@0 {
-					label = "OpenBIOS";
-					reg = <0x0 0x80000>;
-					read-only;
-				};
-			};
-		};
-	};
-
-	chosen {
-		linux,stdout-path = "/plb/opb/serial@ef600300";
-	};
-};
diff --git a/arch/powerpc/configs/40x/hcu4_defconfig 
b/arch/powerpc/configs/40x/hcu4_defconfig
deleted file mode 100644
index ebeb4ac..0000000
--- a/arch/powerpc/configs/40x/hcu4_defconfig
+++ /dev/null
@@ -1,80 +0,0 @@
-CONFIG_40x=y
-CONFIG_EXPERIMENTAL=y
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_EXPERT=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_KALLSYMS_EXTRA_PASS=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_HCU4=y
-# CONFIG_WALNUT is not set
-CONFIG_SPARSE_IRQ=y
-CONFIG_PCI=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_CONNECTOR=y
-CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_OF_PARTS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=m
-CONFIG_MTD_CFI=y
-CONFIG_MTD_JEDECPROBE=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_PROC_DEVICETREE=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=35000
-CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_IBM_NEW_EMAC=y
-# CONFIG_INPUT is not set
-# CONFIG_SERIO is not set
-# CONFIG_VT is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_EXTENDED=y
-CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_SERIAL_OF_PLATFORM=y
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=m
-# CONFIG_USB_SUPPORT is not set
-CONFIG_EXT2_FS=y
-CONFIG_INOTIFY=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_CRAMFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_ROOT_NFS=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_ECB=y
-CONFIG_CRYPTO_PCBC=y
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/platforms/40x/hcu4.c 
b/arch/powerpc/platforms/40x/hcu4.c
deleted file mode 100644
index 60b2afe..0000000
--- a/arch/powerpc/platforms/40x/hcu4.c
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * Architecture- / platform-specific boot-time initialization code for
- * IBM PowerPC 4xx based boards. Adapted from original
- * code by Gary Thomas, Cort Dougan <cort@fsmlabs.com>, and Dan Malek
- * <dan@net4x.com>.
- *
- * Copyright(c) 1999-2000 Grant Erickson <grant@lcse.umn.edu>
- *
- * Rewritten and ported to the merged powerpc tree:
- * Copyright 2007 IBM Corporation
- * Josh Boyer <jwboyer@linux.vnet.ibm.com>
- *
- * 2002 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#include <linux/init.h>
-#include <linux/of_platform.h>
-
-#include <asm/machdep.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <asm/time.h>
-#include <asm/uic.h>
-#include <asm/ppc4xx.h>
-
-static __initdata struct of_device_id hcu4_of_bus[] = {
-	{ .compatible = "ibm,plb3", },
-	{ .compatible = "ibm,opb", },
-	{ .compatible = "ibm,ebc", },
-	{},
-};
-
-static int __init hcu4_device_probe(void)
-{
-	of_platform_bus_probe(NULL, hcu4_of_bus, NULL);
-	return 0;
-}
-machine_device_initcall(hcu4, hcu4_device_probe);
-
-static int __init hcu4_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "netstal,hcu4"))
-		return 0;
-
-	return 1;
-}
-
-define_machine(hcu4) {
-	.name			= "HCU4",
-	.probe			= hcu4_probe,
-	.progress		= udbg_progress,
-	.init_IRQ		= uic_init_tree,
-	.get_irq		= uic_get_irq,
-	.restart		= ppc4xx_reset_system,
-	.calibrate_decr		= generic_calibrate_decr,
-};
-- 
1.7.5.4
