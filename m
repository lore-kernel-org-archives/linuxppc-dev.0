Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m2.elettra.trieste.it [140.105.206.202])
 by lists.ozlabs.org (Postfix) with ESMTP id A0ED51A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 02:17:57 +1100 (AEDT)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC PATCH v1 1/1] powerpc/85xx: Add support for Emerson/Artesyn
 MVME2500.
Date: Wed, 26 Nov 2014 15:17:48 +0100
Message-Id: <1417011468-13485-1-git-send-email-alessio.bogani@elettra.eu>
Cc: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the Artesyn MVME2500 Single Board Computer.

The MVME2500 is a 6U form factor VME64 computer with:

	- A single Freescale QorIQ P2010 CPU
	- 1 GB of DDR3 onboard memory
	- Three Gigabit Ethernets
	- Five 16550 compatible UARTS
	- One USB 2.0 port, one SHDC socket and one SATA connector
	- One PCI/PCI eXpress Mezzanine Card (PMC/XMC) Slot
	- MultiProcessor Interrupt Controller (MPIC)
	- A DS1375T Real Time Clock (RTC) and 512 KB of Non-Volatile Memory
	- Two 64 KB EEPROMs
	- U-Boot in 16 SPI Flash

This patch is based on linux-3.18-rc6 and has been boot tested.

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 arch/powerpc/boot/dts/mvme2500.dts           | 324 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mvme2500.dtsi          |  28 +++
 arch/powerpc/configs/85xx/mvme2500_defconfig | 222 ++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig          |   8 +
 arch/powerpc/platforms/85xx/Makefile         |   1 +
 arch/powerpc/platforms/85xx/mvme2500.c       |  95 ++++++++
 6 files changed, 678 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/mvme2500.dts
 create mode 100644 arch/powerpc/boot/dts/mvme2500.dtsi
 create mode 100644 arch/powerpc/configs/85xx/mvme2500_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/mvme2500.c

diff --git a/arch/powerpc/boot/dts/mvme2500.dts b/arch/powerpc/boot/dts/mvme2500.dts
new file mode 100644
index 0000000..fca05fc
--- /dev/null
+++ b/arch/powerpc/boot/dts/mvme2500.dts
@@ -0,0 +1,324 @@
+/*
+ * Device tree source for the Emerson/Artesyn MVME2500
+ *
+ * Copyright 2014 Elettra-Sincrotrone Trieste S.C.p.A.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Based on: P2020 DS Device Tree Source
+ * Copyright 2009 Freescale Semiconductor Inc.
+ */
+
+/include/ "fsl/p2020si-pre.dtsi"
+
+/ {
+	model = "MVME2500";
+	compatible = "artesyn,MVME2500";
+
+	aliases {
+		serial2 = &serial2;
+		serial3 = &serial3;
+		serial4 = &serial4;
+		serial5 = &serial5;
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	board_soc: soc: soc@ffe00000 {
+		ranges = <0x0 0 0xffe00000 0x100000>;
+
+		i2c@3000 {
+			hwmon@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
+			rtc@68 {
+				compatible = "dallas,ds1337";
+				reg = <0x68>;
+				interrupts = <8 1 0 0>;
+			};
+
+			eeprom-vpd@54 {
+				compatible = "atmel,24c64";
+				reg = <0x54>;
+			};
+
+			eeprom@52 {
+				compatible = "atmel,24c512";
+				reg = <0x52>;
+			};
+
+			eeprom@53 {
+				compatible = "atmel,24c512";
+				reg = <0x53>;
+			};
+
+			spd@50 {
+				compatible = "atmel,24c02";
+				reg = <0x50>;
+			};
+
+		};
+
+		spi0: spi@7000 {
+			fsl,espi-num-chipselects = <2>;
+
+			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "atmel,at25df641";
+				reg = <0>;
+				spi-max-frequency = <10000000>;
+				partition@u-boot {
+					label = "u-boot";
+					reg = <0x00000000 0x000A0000>;
+					read-only;
+				};
+				partition@dtb {
+					label = "dtb";
+					reg = <0x000A0000 0x00020000>;
+				};
+				partition@misc {
+					label = "misc";
+					reg = <0x000C0000 0x00040000>;
+				};
+				partition@u-boot-env {
+					label = "u-boot-env";
+					reg = <0x00100000 0x00020000>;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00120000 0x004E0000>;
+				};
+				partition@fs {
+					label = "file system";
+					reg = <0x00600000 0x00200000>;
+				};
+			};
+			flash@1 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "atmel,at25df641";
+				reg = <1>;
+				spi-max-frequency = <10000000>;
+				partition@u-boot {
+					label = "u-boot";
+					reg = <0x00000000 0x000A0000>;
+					read-only;
+				};
+				partition@dtb {
+					label = "dtb";
+					reg = <0x000A0000 0x00020000>;
+				};
+				partition@misc {
+					label = "misc";
+					reg = <0x000C0000 0x00040000>;
+				};
+				partition@u-boot-env {
+					label = "u-boot-env";
+					reg = <0x00100000 0x00020000>;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00120000 0x004E0000>;
+				};
+				partition@fs {
+					label = "file system";
+					reg = <0x00600000 0x00200000>;
+				};
+			};
+		};
+
+		usb@22000 {
+			dr_mode = "host";
+			phy_type = "ulpi";
+		};
+
+		enet0: ethernet@24000 {
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		mdio@24520 {
+			phy1: ethernet-phy@1 {
+				compatible = "brcm,bcm54616S";
+				interrupts = <6 1 0 0>;
+				reg = <0x1>;
+			};
+
+			phy2: ethernet-phy@2 {
+				compatible = "brcm,bcm54616S";
+				interrupts = <6 1 0 0>;
+				reg = <0x2>;
+			};
+
+			phy3: ethernet-phy@3 {
+				compatible = "brcm,bcm54616S";
+				interrupts = <5 1 0 0>;
+				reg = <0x3>;
+			};
+
+			phy7: ethernet-phy@7 {
+				compatible = "brcm,bcm54616S";
+				interrupts = <7 1 0 0>;
+				reg = <0x7>;
+			};
+
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		enet1: ethernet@25000 {
+			tbi-handle = <&tbi1>;
+			phy-handle = <&phy7>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		mdio@25520 {
+			tbi1: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		enet2: ethernet@26000 {
+			tbi-handle = <&tbi2>;
+			phy-handle = <&phy3>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		mdio@26520 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		sdhc@2e000 {
+			non-removable;
+		};
+	};
+
+	lbc: localbus@ffe05000 {
+		reg = <0 0xffe05000 0 0x1000>;
+
+		ranges = <0x0 0x0 0x0 0xfff00000 0x00080000
+			  0x1 0x0 0x0 0xffc40000 0x00010000
+			  0x2 0x0 0x0 0xffc50000 0x00010000
+			  0x3 0x0 0x0 0xffc60000 0x00010000
+			  0x4 0x0 0x0 0xffc70000 0x00010000
+			  0x6 0x0 0x0 0xffc80000 0x00010000
+			  0x5 0x0 0x0 0xffdf0000 0x00001000>;
+
+		serial2: serial@1,0 {
+			#cell-index = <2>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x1 0x0 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <11 2 0 0>;
+		};
+
+		serial3: serial@2,0 {
+			#cell-index = <3>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x2 0x0 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <1 2 0 0>;
+		};
+
+		serial4: serial@3,0 {
+			#cell-index = <4>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x3 0x0 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <2 2 0 0>;
+		};
+
+		serial5: serial@4,0 {
+			#cell-index = <5>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4 0x0 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <3 2 0 0>;
+		};
+
+		nvram@0,0 {
+			device_type = "nvram";
+			compatible = "everspin,mram";
+			reg = <0x0 0x0 0x80000>;
+		};
+
+		board-control@5,0 {
+			compatible = "artesyn,mvme2500-fpga";
+			reg = <0x5 0x0 0x01000>;
+		};
+
+		cpld@6,0 {
+			compatible = "artesyn,mvme2500-cpld";
+			reg = <0x6 0x0 0x10000>;
+			interrupts = <9 1 0 0 >;
+		};
+	};
+
+	pci0: pcie@ffe08000 {
+		reg = <0 0xffe08000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x10000>;
+		};
+	};
+
+	pci1: pcie@ffe09000 {
+		reg = <0 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xa0000000
+				  0x2000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x10000>;
+		};
+
+	};
+
+	pci2: pcie@ffe0a000 {
+		reg = <0 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xc0000000
+				  0x2000000 0x0 0xc0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x10000>;
+		};
+	};
+};
+
+/include/ "fsl/p2020si-post.dtsi"
+/include/ "mvme2500.dtsi"
diff --git a/arch/powerpc/boot/dts/mvme2500.dtsi b/arch/powerpc/boot/dts/mvme2500.dtsi
new file mode 100644
index 0000000..6966f13
--- /dev/null
+++ b/arch/powerpc/boot/dts/mvme2500.dtsi
@@ -0,0 +1,28 @@
+/*
+ * Device tree source stub for the Emerson/Artesyn MVME2500
+ *
+ * Copyright 2014 Elettra-Sincrotrone Trieste S.C.p.A.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+&board_soc {
+	// Not connected
+	i2c@3000 {
+		status = "disabled";
+	};
+
+	// Note connected
+	serial@4600 {
+		status = "disabled";
+	};
+
+	gpio-controller@f000 {
+		reg = <0xfc00 0x100>;
+	};
+
+/include/ "fsl/pq3-mpic-message-B.dtsi"
+};
diff --git a/arch/powerpc/configs/85xx/mvme2500_defconfig b/arch/powerpc/configs/85xx/mvme2500_defconfig
new file mode 100644
index 0000000..06fe629
--- /dev/null
+++ b/arch/powerpc/configs/85xx/mvme2500_defconfig
@@ -0,0 +1,222 @@
+CONFIG_PPC_85xx=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
+CONFIG_AUDIT=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_CGROUPS=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
+CONFIG_SLAB=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_MVME2500=y
+CONFIG_HIGHMEM=y
+CONFIG_HZ_1000=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_MATH_EMULATION=y
+CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED=y
+# CONFIG_COMPACTION is not set
+# CONFIG_MIGRATION is not set
+# CONFIG_BOUNCE is not set
+CONFIG_FORCE_MAX_ZONEORDER=13
+# CONFIG_SUSPEND is not set
+# CONFIG_SECCOMP is not set
+CONFIG_FSL_LBC=y
+CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
+# CONFIG_PCIEASPM is not set
+CONFIG_PCI_MSI=y
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_LOWMEM_SIZE_BOOL=y
+CONFIG_LOWMEM_SIZE=0x40000000
+CONFIG_PAGE_OFFSET_BOOL=y
+CONFIG_PAGE_OFFSET=0x80000000
+CONFIG_KERNEL_START_BOOL=y
+CONFIG_TASK_SIZE_BOOL=y
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+CONFIG_IPV6=y
+# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET6_XFRM_MODE_BEET is not set
+# CONFIG_IPV6_SIT is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_MTD=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=262144
+CONFIG_EEPROM_AT24=y
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_SG=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+# CONFIG_ATA_VERBOSE_ERROR is not set
+CONFIG_SATA_AHCI=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_MD=y
+CONFIG_BLK_DEV_DM=y
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_ADAPTEC is not set
+# CONFIG_NET_VENDOR_AGERE is not set
+# CONFIG_NET_VENDOR_ALTEON is not set
+# CONFIG_NET_VENDOR_AMD is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_ATHEROS is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_BROCADE is not set
+# CONFIG_NET_VENDOR_CHELSIO is not set
+# CONFIG_NET_VENDOR_CISCO is not set
+# CONFIG_NET_VENDOR_DEC is not set
+# CONFIG_NET_VENDOR_DLINK is not set
+# CONFIG_NET_VENDOR_EMULEX is not set
+# CONFIG_NET_VENDOR_EXAR is not set
+CONFIG_GIANFAR=y
+# CONFIG_NET_VENDOR_HP is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MELLANOX is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_MYRI is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NVIDIA is not set
+# CONFIG_NET_VENDOR_OKI is not set
+# CONFIG_NET_PACKET_ENGINE is not set
+# CONFIG_NET_VENDOR_QLOGIC is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
+# CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SILAN is not set
+# CONFIG_NET_VENDOR_SIS is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_SUN is not set
+# CONFIG_NET_VENDOR_TEHUTI is not set
+# CONFIG_NET_VENDOR_TI is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_NET_VENDOR_XILINX is not set
+CONFIG_BROADCOM_PHY=y
+CONFIG_FIXED_PHY=y
+# CONFIG_USB_NET_DRIVERS is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_LIBPS2=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=6
+CONFIG_SERIAL_8250_RUNTIME_UARTS=6
+CONFIG_SERIAL_8250_RSA=y
+CONFIG_NVRAM=y
+CONFIG_I2C=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MPC=y
+CONFIG_SPI=y
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_FSL_ESPI=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_GENERIC_PLATFORM=y
+CONFIG_GPIO_MPC8XXX=y
+CONFIG_SENSORS_LM90=y
+CONFIG_THERMAL=y
+# CONFIG_VGA_ARB is not set
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_FSL=y
+# CONFIG_USB_EHCI_HCD_PPC_OF is not set
+CONFIG_USB_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_ESDHC=y
+CONFIG_EDAC=y
+# CONFIG_EDAC_LEGACY_SYSFS is not set
+CONFIG_EDAC_MM_EDAC=y
+CONFIG_EDAC_MPC85XX=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_DMADEVICES=y
+CONFIG_FSL_DMA=y
+CONFIG_ASYNC_TX_DMA=y
+CONFIG_STAGING=y
+CONFIG_VME_BUS=y
+CONFIG_VME_TSI148=y
+CONFIG_VME_USER=y
+CONFIG_GENERIC_PHY=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT4_FS=y
+CONFIG_FANOTIFY=y
+CONFIG_AUTOFS4_FS=y
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_NTFS_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
+CONFIG_DEBUG_INFO=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+# CONFIG_STRICT_DEVMEM is not set
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_DEV_TALITOS=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index f22635a..b92674a 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -241,6 +241,14 @@ config SGY_CTS1000
 	help
 	  Enable this to support functionality in Servergy's CTS-1000 systems.
 
+config MVME2500
+	bool "Artesyn MVME2500"
+	select DEFAULT_UIMAGE
+	select SWIOTLB
+	select MMIO_NVRAM
+	help
+	  This option enables support for the Emerson/Artesyn MVME2500 board.
+
 endif # PPC32
 
 config PPC_QEMU_E500
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 7303260..1fe7fb9 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_XES_MPC85xx) += xes_mpc85xx.o
 obj-$(CONFIG_GE_IMP3A)	  += ge_imp3a.o
 obj-$(CONFIG_PPC_QEMU_E500) += qemu_e500.o
 obj-$(CONFIG_SGY_CTS1000) += sgy_cts1000.o
+obj-$(CONFIG_MVME2500)	  += mvme2500.o
diff --git a/arch/powerpc/platforms/85xx/mvme2500.c b/arch/powerpc/platforms/85xx/mvme2500.c
new file mode 100644
index 0000000..af8c4eb
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mvme2500.c
@@ -0,0 +1,95 @@
+/*
+ * Board setup routines for the Emerson/Artesyn MVME2500
+ *
+ * Copyright 2014 Elettra-Sincrotrone Trieste S.C.p.A.
+ *
+ * Based on earlier code by:
+ *
+ *	Xianghua Xiao (x.xiao@freescale.com)
+ *	Tom Armistead (tom.armistead@emerson.com)
+ *	Copyright 2012 Emerson
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Author Alessio Igor Bogani <alessio.bogani@elettra.eu>
+ *
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
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
+#include <asm/swiotlb.h>
+#include <asm/nvram.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+#include "mpc85xx.h"
+
+void __init mvme2500_pic_init(void)
+{
+	struct mpic *mpic = mpic_alloc(NULL, 0,
+		  MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU,
+		0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+	mpic_init(mpic);
+}
+
+/*
+ * Setup the architecture
+ */
+static void __init mvme2500_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("mvme2500_setup_arch()", 0);
+	fsl_pci_assign_primary();
+	swiotlb_detect_4g();
+#if defined(CONFIG_MMIO_NVRAM)
+	mmio_nvram_init();
+#endif
+	printk(KERN_INFO "MVME2500 board from Artesyn\n");
+}
+
+machine_arch_initcall(mvme2500, mpc85xx_common_publish_devices);
+machine_arch_initcall(mvme2500, swiotlb_setup_bus_notifier);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mvme2500_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "Artesyn,MVME2500");
+}
+
+define_machine(mvme2500) {
+	.name			= "MVME2500",
+	.probe			= mvme2500_probe,
+	.setup_arch		= mvme2500_setup_arch,
+	.init_IRQ		= mvme2500_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
2.1.3
