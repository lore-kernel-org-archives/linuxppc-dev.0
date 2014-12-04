Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m2.elettra.trieste.it [140.105.206.202])
 by lists.ozlabs.org (Postfix) with ESMTP id DDACD1A0CC1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 20:23:44 +1100 (AEDT)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC PATCH v2 1/1] powerpc/85xx: Add support for Emerson/Artesyn
 MVME2500.
Date: Thu,  4 Dec 2014 10:23:29 +0100
Message-Id: <1417685009-1640-1-git-send-email-alessio.bogani@elettra.eu>
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

This patch is based on linux-3.18-rc7 and has been boot tested.

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---

v1 -> v2
	Increase an LBC window from only 0x1000 to 0x8000 bytes
	Rename:
		eeprom-vpd and spd to eeprom
		Artesyn to artesyn
	Remove:
		board_soc label
		partition scheme
		A whitespace
		#cell-index usages
		The mvm2500.dtsi file (moving its definitions at the bottom
			of the mvme2500.dts)
		mvme2500_defconfig and use mpc85xx_defconfig instead
		Useless headers in mvme2500.c
		SWIOTLB usages
	Replace:
		printk() with pr_info()
		NVRAM with MTD-RAM: Unfortunately the former doesn't cope with
		16-bit addressing of the chip used in MVME2500 board but the
		latter can due of the bank-witdth device tree definition.

 arch/powerpc/boot/dts/mvme2500.dts     | 282 +++++++++++++++++++++++++++++++++
 arch/powerpc/configs/mpc85xx_defconfig |  71 +++------
 arch/powerpc/platforms/85xx/Kconfig    |   6 +
 arch/powerpc/platforms/85xx/Makefile   |   1 +
 arch/powerpc/platforms/85xx/mvme2500.c |  74 +++++++++
 5 files changed, 387 insertions(+), 47 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mvme2500.dts
 create mode 100644 arch/powerpc/platforms/85xx/mvme2500.c

diff --git a/arch/powerpc/boot/dts/mvme2500.dts b/arch/powerpc/boot/dts/mvme2500.dts
new file mode 100644
index 0000000..4bd134e
--- /dev/null
+++ b/arch/powerpc/boot/dts/mvme2500.dts
@@ -0,0 +1,282 @@
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
+	soc: soc@ffe00000 {
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
+			eeprom@54 {
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
+			eeprom@50 {
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
+				compatible = "atmel,at25df641";
+				reg = <0>;
+				spi-max-frequency = <10000000>;
+			};
+			flash@1 {
+				compatible = "atmel,at25df641";
+				reg = <1>;
+				spi-max-frequency = <10000000>;
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
+/include/ "fsl/pq3-mpic-message-B.dtsi"
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
+			  0x5 0x0 0x0 0xffdf0000 0x00008000>;
+
+		serial2: serial@1,0 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x1 0x0 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <11 2 0 0>;
+		};
+
+		serial3: serial@2,0 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x2 0x0 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <1 2 0 0>;
+		};
+
+		serial4: serial@3,0 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x3 0x0 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <2 2 0 0>;
+		};
+
+		serial5: serial@4,0 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4 0x0 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <3 2 0 0>;
+		};
+
+		mram@0,0 {
+			compatible = "everspin,mram", "mtd-ram";
+			reg = <0x0 0x0 0x80000>;
+			bank-width = <2>;
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
+			interrupts = <9 1 0 0>;
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
+
+/ {
+	soc@ffe00000 {
+		serial@4600 {
+			status = "disabled";
+		};
+
+		i2c@3100 {
+			status = "disabled";
+		};
+
+		sdhc@2e000 {
+			compatible = "fsl,p2020-esdhc", "fsl,esdhc";
+			non-removable;
+		};
+
+	};
+
+};
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index d2c4154..8535c34 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -20,6 +20,7 @@ CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
+CONFIG_C293_PCIE=y
 CONFIG_MPC8540_ADS=y
 CONFIG_MPC8560_ADS=y
 CONFIG_MPC85xx_CDS=y
@@ -27,7 +28,6 @@ CONFIG_MPC85xx_MDS=y
 CONFIG_MPC8536_DS=y
 CONFIG_MPC85xx_DS=y
 CONFIG_MPC85xx_RDB=y
-CONFIG_C293_PCIE=y
 CONFIG_P1010_RDB=y
 CONFIG_P1022_DS=y
 CONFIG_P1022_RDK=y
@@ -42,6 +42,7 @@ CONFIG_TQM8548=y
 CONFIG_TQM8555=y
 CONFIG_TQM8560=y
 CONFIG_SBC8548=y
+CONFIG_MVME2500=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_HIGHMEM=y
@@ -49,6 +50,8 @@ CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
 CONFIG_FORCE_MAX_ZONEORDER=12
 CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
+# CONFIG_PCIEASPM is not set
 CONFIG_PCI_MSI=y
 CONFIG_RAPIDIO=y
 CONFIG_NET=y
@@ -70,7 +73,6 @@ CONFIG_NET_IPIP=y
 CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
-CONFIG_ARPD=y
 CONFIG_INET_ESP=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_LRO is not set
@@ -80,33 +82,21 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
-CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_FTL=y
 CONFIG_MTD_CFI=y
-CONFIG_MTD_GEN_PROBE=y
-CONFIG_MTD_MAP_BANK_WIDTH_1=y
-CONFIG_MTD_MAP_BANK_WIDTH_2=y
-CONFIG_MTD_MAP_BANK_WIDTH_4=y
-CONFIG_MTD_CFI_I1=y
-CONFIG_MTD_CFI_I2=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_PLATRAM=y
 CONFIG_MTD_M25P80=y
-CONFIG_MTD_CFI_UTIL=y
-CONFIG_MTD_NAND_ECC=y
 CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_IDS=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
-CONFIG_MTD_UBI_WL_THRESHOLD=4096
-CONFIG_MTD_UBI_BEB_RESERVE=1
-CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
@@ -117,7 +107,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
@@ -133,11 +122,12 @@ CONFIG_GIANFAR=y
 CONFIG_E1000=y
 CONFIG_E1000E=y
 CONFIG_IGB=y
+CONFIG_AT803X_PHY=y
 CONFIG_MARVELL_PHY=y
 CONFIG_DAVICOM_PHY=y
 CONFIG_CICADA_PHY=y
 CONFIG_VITESSE_PHY=y
-CONFIG_AT803X_PHY=y
+CONFIG_BROADCOM_PHY=y
 CONFIG_FIXED_PHY=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
@@ -146,8 +136,8 @@ CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
-CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_NR_UARTS=6
+CONFIG_SERIAL_8250_RUNTIME_UARTS=6
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
@@ -160,15 +150,12 @@ CONFIG_SPI=y
 CONFIG_SPI_FSL_SPI=y
 CONFIG_SPI_FSL_ESPI=y
 CONFIG_GPIO_MPC8XXX=y
-# CONFIG_HWMON is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=y
+CONFIG_HWMON=m
+CONFIG_SENSORS_LM90=m
 CONFIG_FB=y
 CONFIG_FB_FSL_DIU=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
@@ -192,7 +179,6 @@ CONFIG_HID_MONTEREY=y
 CONFIG_HID_PANTHERLORD=y
 CONFIG_HID_PETALYNX=y
 CONFIG_HID_SAMSUNG=y
-CONFIG_HID_SONY=y
 CONFIG_HID_SUNPLUS=y
 CONFIG_USB=y
 CONFIG_USB_MON=y
@@ -208,6 +194,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
+CONFIG_EDAC_MPC85XX=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_DS1374=y
@@ -215,7 +202,6 @@ CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
-# CONFIG_NET_DMA is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
@@ -226,21 +212,9 @@ CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_850=y
-CONFIG_NLS_ISO8859_1=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_FS_DEBUG=1
-CONFIG_JFFS2_FS_WRITEBUFFER=y
-CONFIG_JFFS2_ZLIB=y
-CONFIG_JFFS2_RTIME=y
-CONFIG_UBIFS_FS=y
-CONFIG_UBIFS_FS_XATTR=y
-CONFIG_UBIFS_FS_LZO=y
-CONFIG_UBIFS_FS_ZLIB=y
 CONFIG_ADFS_FS=m
 CONFIG_AFFS_FS=m
 CONFIG_HFS_FS=m
@@ -248,6 +222,9 @@ CONFIG_HFSPLUS_FS=m
 CONFIG_BEFS_FS=m
 CONFIG_BFS_FS=m
 CONFIG_EFS_FS=m
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=1
+CONFIG_UBIFS_FS=y
 CONFIG_CRAMFS=y
 CONFIG_VXFS_FS=m
 CONFIG_HPFS_FS=m
@@ -258,16 +235,16 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_ISO8859_1=y
 CONFIG_CRC_T10DIF=y
-CONFIG_CRC16=y
-CONFIG_ZLIB_DEFLATE=y
-CONFIG_LZO_COMPRESS=y
-CONFIG_LZO_DECOMPRESS=y
-CONFIG_CRYPTO_DEFLATE=y
-CONFIG_CRYPTO_LZO=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEBUG_INFO=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index f22635a..2fb4b24 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -241,6 +241,12 @@ config SGY_CTS1000
 	help
 	  Enable this to support functionality in Servergy's CTS-1000 systems.
 
+config MVME2500
+	bool "Artesyn MVME2500"
+	select DEFAULT_UIMAGE
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
index 0000000..1233050
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mvme2500.c
@@ -0,0 +1,74 @@
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
+#include <linux/pci.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
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
+	pr_info("MVME2500 board from Artesyn\n");
+}
+
+machine_arch_initcall(mvme2500, mpc85xx_common_publish_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mvme2500_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "artesyn,MVME2500");
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
