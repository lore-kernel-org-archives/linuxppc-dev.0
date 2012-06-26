Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2EFAB1007EC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 05:54:54 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: benh@kernel.crashing.org
Subject: [PATCH 1/3] powerpc: remove Wind River SBC8560 support
Date: Tue, 26 Jun 2012 15:54:27 -0400
Message-Id: <1340740469-31445-2-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1340740469-31445-1-git-send-email-paul.gortmaker@windriver.com>
References: <1340740469-31445-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org, David Woodhouse <David.Woodhouse@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reference board dates back to 2004, and is largely a legacy
EOL product.  The MPC8560 is a pre e500v2 CPU.  The SBC8548 is
a more modern, better e500v2 target for people to use as a
reference board with today's kernels, should they require one.

Removing support for it will also allow us to remove some
sbc8560 specific quirk handling in 8250 UART code, and some
MTD mapping support.

Cc: David Woodhouse <David.Woodhouse@intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/Makefile                  |    1 -
 arch/powerpc/boot/dts/sbc8560.dts           |  406 ---------------------------
 arch/powerpc/configs/85xx/sbc8560_defconfig |   65 -----
 arch/powerpc/platforms/85xx/Kconfig         |    6 -
 arch/powerpc/platforms/85xx/Makefile        |    1 -
 arch/powerpc/platforms/85xx/sbc8560.c       |  254 -----------------
 6 files changed, 0 insertions(+), 733 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/sbc8560.dts
 delete mode 100644 arch/powerpc/configs/85xx/sbc8560_defconfig
 delete mode 100644 arch/powerpc/platforms/85xx/sbc8560.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e8461cb..bda69ff 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -257,7 +257,6 @@ image-$(CONFIG_TQM8548)			+= cuImage.tqm8548
 image-$(CONFIG_TQM8555)			+= cuImage.tqm8555
 image-$(CONFIG_TQM8560)			+= cuImage.tqm8560
 image-$(CONFIG_SBC8548)			+= cuImage.sbc8548
-image-$(CONFIG_SBC8560)			+= cuImage.sbc8560
 image-$(CONFIG_KSI8560)			+= cuImage.ksi8560
 
 # Board ports in arch/powerpc/platform/embedded6xx/Kconfig
diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
deleted file mode 100644
index 72078eb..0000000
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ /dev/null
@@ -1,406 +0,0 @@
-/*
- * SBC8560 Device Tree Source
- *
- * Copyright 2007 Wind River Systems Inc.
- *
- * Paul Gortmaker (see MAINTAINERS for contact information)
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
-	model = "SBC8560";
-	compatible = "SBC8560";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		ethernet3 = &enet3;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8560@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <0x20>;	// 32 bytes
-			i-cache-line-size = <0x20>;	// 32 bytes
-			d-cache-size = <0x8000>;	// L1, 32K
-			i-cache-size = <0x8000>;	// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;
-			clock-frequency = <0>;
-			next-level-cache = <&L2>;
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x00000000 0x20000000>;
-	};
-
-	soc@ff700000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		ranges = <0x0 0xff700000 0x00100000>;
-		clock-frequency = <0>;
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <8>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,mpc8560-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,mpc8560-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <0x12 0x2>;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,mpc8560-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <0x20>;	// 32 bytes
-			cache-size = <0x40000>;		// L2, 256K
-			interrupt-parent = <&mpic>;
-			interrupts = <0x10 0x2>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8560-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8560-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8560-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8560-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8560-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
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
-			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-				phy0: ethernet-phy@19 {
-					interrupt-parent = <&mpic>;
-					interrupts = <0x6 0x1>;
-					reg = <0x19>;
-					device_type = "ethernet-phy";
-				};
-				phy1: ethernet-phy@1a {
-					interrupt-parent = <&mpic>;
-					interrupts = <0x7 0x1>;
-					reg = <0x1a>;
-					device_type = "ethernet-phy";
-				};
-				phy2: ethernet-phy@1b {
-					interrupt-parent = <&mpic>;
-					interrupts = <0x8 0x1>;
-					reg = <0x1b>;
-					device_type = "ethernet-phy";
-				};
-				phy3: ethernet-phy@1c {
-					interrupt-parent = <&mpic>;
-					interrupts = <0x8 0x1>;
-					reg = <0x1c>;
-					device_type = "ethernet-phy";
-				};
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
-			interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi1>;
-			phy-handle = <&phy1>;
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
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			compatible = "chrp,open-pic";
-			reg = <0x40000 0x40000>;
-			device_type = "open-pic";
-		};
-
-		cpm@919c0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8560-cpm", "fsl,cpm2";
-			reg = <0x919c0 0x30>;
-			ranges;
-
-			muram@80000 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0x0 0x80000 0x10000>;
-
-				data@0 {
-					compatible = "fsl,cpm-muram-data";
-					reg = <0x0 0x4000 0x9000 0x2000>;
-				};
-			};
-
-			brg@919f0 {
-				compatible = "fsl,mpc8560-brg",
-				             "fsl,cpm2-brg",
-				             "fsl,cpm-brg";
-				reg = <0x919f0 0x10 0x915f0 0x10>;
-				clock-frequency = <165000000>;
-			};
-
-			cpmpic: pic@90c00 {
-				interrupt-controller;
-				#address-cells = <0>;
-				#interrupt-cells = <2>;
-				interrupts = <0x2e 0x2>;
-				interrupt-parent = <&mpic>;
-				reg = <0x90c00 0x80>;
-				compatible = "fsl,mpc8560-cpm-pic", "fsl,cpm2-pic";
-			};
-
-			enet2: ethernet@91320 {
-				device_type = "network";
-				compatible = "fsl,mpc8560-fcc-enet",
-				             "fsl,cpm2-fcc-enet";
-				reg = <0x91320 0x20 0x88500 0x100 0x913b0 0x1>;
-				local-mac-address = [ 00 00 00 00 00 00 ];
-				fsl,cpm-command = <0x16200300>;
-				interrupts = <0x21 0x8>;
-				interrupt-parent = <&cpmpic>;
-				phy-handle = <&phy2>;
-			};
-
-			enet3: ethernet@91340 {
-				device_type = "network";
-				compatible = "fsl,mpc8560-fcc-enet",
-				             "fsl,cpm2-fcc-enet";
-				reg = <0x91340 0x20 0x88600 0x100 0x913d0 0x1>;
-				local-mac-address = [ 00 00 00 00 00 00 ];
-				fsl,cpm-command = <0x1a400300>;
-				interrupts = <0x22 0x8>;
-				interrupt-parent = <&cpmpic>;
-				phy-handle = <&phy3>;
-			};
-		};
-
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8560-guts";
-			reg = <0xe0000 0x1000>;
-		};
-	};
-
-	pci0: pci@ff708000 {
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
-		device_type = "pci";
-		reg = <0xff708000 0x1000>;
-		clock-frequency = <66666666>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-
-			/* IDSEL 0x02 */
-			0x1000 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x1000 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x1000 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x1000 0x0 0x0 0x4 &mpic 0x5 0x1>;
-
-		interrupt-parent = <&mpic>;
-		interrupts = <0x18 0x2>;
-		bus-range = <0x0 0x0>;
-		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
-			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
-	};
-
-	localbus@ff705000 {
-		compatible = "fsl,mpc8560-localbus", "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <1>;
-		reg = <0xff705000 0x100>;	// BRx, ORx, etc.
-
-		ranges = <
-			0x0 0x0 0xff800000 0x0800000	// 8MB boot flash
-			0x1 0x0 0xe4000000 0x4000000	// 64MB flash
-			0x3 0x0 0x20000000 0x4000000	// 64MB SDRAM
-			0x4 0x0 0x24000000 0x4000000	// 64MB SDRAM
-			0x5 0x0 0xfc000000 0x0c00000	// EPLD
-			0x6 0x0 0xe0000000 0x4000000	// 64MB flash
-			0x7 0x0 0x80000000 0x0200000	// ATM1,2
-		>;
-
-		epld@5,0 {
-			compatible = "wrs,epld-localbus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-			reg = <0x5 0x0 0xc00000>;
-			ranges = <
-				0x0 0x0 0x5 0x000000 0x1fff	// LED disp.
-				0x1 0x0 0x5 0x100000 0x1fff	// switches
-				0x2 0x0 0x5 0x200000 0x1fff	// ID reg.
-				0x3 0x0 0x5 0x300000 0x1fff	// status reg.
-				0x4 0x0 0x5 0x400000 0x1fff	// reset reg.
-				0x5 0x0 0x5 0x500000 0x1fff	// Wind port
-				0x7 0x0 0x5 0x700000 0x1fff	// UART #1
-				0x8 0x0 0x5 0x800000 0x1fff	// UART #2
-				0x9 0x0 0x5 0x900000 0x1fff	// RTC
-				0xb 0x0 0x5 0xb00000 0x1fff	// EEPROM
-			>;
-
-			bidr@2,0 {
-				compatible = "wrs,sbc8560-bidr";
-				reg = <0x2 0x0 0x10>;
-			};
-
-			bcsr@3,0 {
-				compatible = "wrs,sbc8560-bcsr";
-				reg = <0x3 0x0 0x10>;
-			};
-
-			brstcr@4,0 {
-				compatible = "wrs,sbc8560-brstcr";
-				reg = <0x4 0x0 0x10>;
-			};
-
-			serial0: serial@7,0 {
-				device_type = "serial";
-				compatible = "ns16550";
-				reg = <0x7 0x0 0x100>;
-				clock-frequency = <1843200>;
-				interrupts = <0x9 0x2>;
-				interrupt-parent = <&mpic>;
-			};
-
-			serial1: serial@8,0 {
-				device_type = "serial";
-				compatible = "ns16550";
-				reg = <0x8 0x0 0x100>;
-				clock-frequency = <1843200>;
-				interrupts = <0xa 0x2>;
-				interrupt-parent = <&mpic>;
-			};
-
-			rtc@9,0 {
-				compatible = "m48t59";
-				reg = <0x9 0x0 0x1fff>;
-			};
-		};
-	};
-};
diff --git a/arch/powerpc/configs/85xx/sbc8560_defconfig b/arch/powerpc/configs/85xx/sbc8560_defconfig
deleted file mode 100644
index f7fdb03..0000000
--- a/arch/powerpc/configs/85xx/sbc8560_defconfig
+++ /dev/null
@@ -1,65 +0,0 @@
-CONFIG_PPC_85xx=y
-CONFIG_EXPERIMENTAL=y
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_EXPERT=y
-CONFIG_SLAB=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_SBC8560=y
-CONFIG_BINFMT_MISC=y
-CONFIG_SPARSE_IRQ=y
-# CONFIG_SECCOMP is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-# CONFIG_FW_LOADER is not set
-CONFIG_PROC_DEVICETREE=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=32768
-CONFIG_NETDEVICES=y
-CONFIG_BROADCOM_PHY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_GIANFAR=y
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_VT is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
-CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-# CONFIG_HW_RANDOM is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_M48T59=y
-CONFIG_INOTIFY=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
-# CONFIG_MSDOS_PARTITION is not set
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
-CONFIG_PPC_EARLY_DEBUG=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index f000d81..b3370be 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -175,12 +175,6 @@ config SBC8548
 	help
 	  This option enables support for the Wind River SBC8548 board
 
-config SBC8560
-	bool "Wind River SBC8560"
-	select DEFAULT_UIMAGE
-	help
-	  This option enables support for the Wind River SBC8560 board
-
 config GE_IMP3A
 	bool "GE Intelligent Platforms IMP3A"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 2125d4c..50280cc 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -22,7 +22,6 @@ obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
-obj-$(CONFIG_SBC8560)     += sbc8560.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
 obj-$(CONFIG_SOCRATES)    += socrates.o socrates_fpga_pic.o
 obj-$(CONFIG_KSI8560)	  += ksi8560.o
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
deleted file mode 100644
index b1be632..0000000
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ /dev/null
@@ -1,254 +0,0 @@
-/*
- * Wind River SBC8560 setup and early boot code.
- *
- * Copyright 2007 Wind River Systems Inc.
- *
- * By Paul Gortmaker (see MAINTAINERS for contact information)
- *
- * Based largely on the MPC8560ADS support - Copyright 2005 Freescale Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/of_platform.h>
-
-#include <asm/time.h>
-#include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/mpic.h>
-#include <mm/mmu_decl.h>
-#include <asm/udbg.h>
-
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
-
-#include "mpc85xx.h"
-
-#ifdef CONFIG_CPM2
-#include <asm/cpm2.h>
-#include <sysdev/cpm2_pic.h>
-#endif
-
-static void __init sbc8560_pic_init(void)
-{
-	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-	mpic_init(mpic);
-
-	mpc85xx_cpm2_pic_init();
-}
-
-/*
- * Setup the architecture
- */
-#ifdef CONFIG_CPM2
-struct cpm_pin {
-	int port, pin, flags;
-};
-
-static const struct cpm_pin sbc8560_pins[] = {
-	/* SCC1 */
-	{3, 29, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
-	{3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-
-	/* SCC2 */
-	{3, 26, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{3, 27, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{3, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-
-	/* FCC2 */
-	{1, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 20, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 22, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{1, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{1, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{1, 25, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{1, 26, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 27, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
-	{1, 30, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{2, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* CLK14 */
-	{2, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* CLK13 */
-
-	/* FCC3 */
-	{1, 4, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{1, 5, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{1, 6, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{1, 7, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{1, 8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 9, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 10, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 11, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 12, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 13, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 14, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{1, 15, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
-	{1, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{2, 16, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* CLK16 */
-	{2, 17, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* CLK15 */
-};
-
-static void __init init_ioports(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(sbc8560_pins); i++) {
-		const struct cpm_pin *pin = &sbc8560_pins[i];
-		cpm2_set_pin(pin->port, pin->pin, pin->flags);
-	}
-
-	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_RX);
-	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_TX);
-	cpm2_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_RX);
-	cpm2_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_TX);
-	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK13, CPM_CLK_RX);
-	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK14, CPM_CLK_TX);
-	cpm2_clk_setup(CPM_CLK_FCC3, CPM_CLK15, CPM_CLK_RX);
-	cpm2_clk_setup(CPM_CLK_FCC3, CPM_CLK16, CPM_CLK_TX);
-}
-#endif
-
-static void __init sbc8560_setup_arch(void)
-{
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
-	if (ppc_md.progress)
-		ppc_md.progress("sbc8560_setup_arch()", 0);
-
-#ifdef CONFIG_CPM2
-	cpm2_reset();
-	init_ioports();
-#endif
-
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
-		fsl_add_bridge(np, 1);
-#endif
-}
-
-static void sbc8560_show_cpuinfo(struct seq_file *m)
-{
-	uint pvid, svid, phid1;
-
-	pvid = mfspr(SPRN_PVR);
-	svid = mfspr(SPRN_SVR);
-
-	seq_printf(m, "Vendor\t\t: Wind River\n");
-	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
-	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
-
-	/* Display cpu Pll setting */
-	phid1 = mfspr(SPRN_HID1);
-	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
-}
-
-machine_device_initcall(sbc8560, mpc85xx_common_publish_devices);
-
-/*
- * Called very early, device-tree isn't unflattened
- */
-static int __init sbc8560_probe(void)
-{
-        unsigned long root = of_get_flat_dt_root();
-
-        return of_flat_dt_is_compatible(root, "SBC8560");
-}
-
-#ifdef CONFIG_RTC_DRV_M48T59
-static int __init sbc8560_rtc_init(void)
-{
-	struct device_node *np;
-	struct resource res;
-	struct platform_device *rtc_dev;
-
-	np = of_find_compatible_node(NULL, NULL, "m48t59");
-	if (np == NULL) {
-		printk("No RTC in DTB. Has it been eaten by wild dogs?\n");
-		return -ENODEV;
-	}
-
-	of_address_to_resource(np, 0, &res);
-	of_node_put(np);
-
-	printk("Found RTC (m48t59) at i/o 0x%x\n", res.start);
-
-	rtc_dev = platform_device_register_simple("rtc-m48t59", 0, &res, 1);
-
-	if (IS_ERR(rtc_dev)) {
-		printk("Registering sbc8560 RTC device failed\n");
-		return PTR_ERR(rtc_dev);
-	}
-
-	return 0;
-}
-
-arch_initcall(sbc8560_rtc_init);
-
-#endif	/* M48T59 */
-
-static __u8 __iomem *brstcr;
-
-static int __init sbc8560_bdrstcr_init(void)
-{
-	struct device_node *np;
-	struct resource res;
-
-	np = of_find_compatible_node(NULL, NULL, "wrs,sbc8560-brstcr");
-	if (np == NULL) {
-		printk(KERN_WARNING "sbc8560: No board specific RSTCR in DTB.\n");
-		return -ENODEV;
-	}
-
-	of_address_to_resource(np, 0, &res);
-
-	printk(KERN_INFO "sbc8560: Found BRSTCR at %pR\n", &res);
-
-	brstcr = ioremap(res.start, resource_size(&res));
-	if(!brstcr)
-		printk(KERN_WARNING "sbc8560: ioremap of brstcr failed.\n");
-
-	of_node_put(np);
-
-	return 0;
-}
-
-arch_initcall(sbc8560_bdrstcr_init);
-
-void sbc8560_rstcr_restart(char * cmd)
-{
-	local_irq_disable();
-	if(brstcr)
-		clrbits8(brstcr, 0x80);
-
-	while(1);
-}
-
-define_machine(sbc8560) {
-	.name			= "SBC8560",
-	.probe			= sbc8560_probe,
-	.setup_arch		= sbc8560_setup_arch,
-	.init_IRQ		= sbc8560_pic_init,
-	.show_cpuinfo		= sbc8560_show_cpuinfo,
-	.get_irq		= mpic_get_irq,
-	.restart		= sbc8560_rstcr_restart,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-};
-- 
1.7.9.1
