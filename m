Return-Path: <prvs=0189afdd1f=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7EF16140110
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 19:30:42 +1000 (EST)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 3/3] powerpc/mpc85xx: add support for Keymile's kmcoge4
 board
Date: Tue, 22 Apr 2014 11:30:31 +0200
Message-Id: <1398159031-10110-4-git-send-email-valentin.longchamp@keymile.com>
In-Reply-To: <1398159031-10110-1-git-send-email-valentin.longchamp@keymile.com>
References: <1398159031-10110-1-git-send-email-valentin.longchamp@keymile.com>
Cc: devicetree@vger.kernel.org,
 Valentin Longchamp <valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch introduces the support for Keymile's kmcoge4 board which is
the internal reference design for boards based on Freescale's
P2040/P2041 SoCs. This internal reference design is named kmp204x.

The peripherals used on this board are:
- SPI NOR Flash as bootloader medium
- NAND Flash with a ubi partition
- 2 PCIe busses (hosts 1 and 3)
- 3 FMAN Ethernet devices (FMAN1 DTSEC1/2/5)
- 4 Local Bus windows, with one dedicated to the QRIO reset/power mgmt
  CPLD
- 2 I2C busses
- last but not least, the mandatory serial port

The patch also adds a defconfig file for this reference design that is
necessary because of the lowmem option that must be set higher due to
the number of PCIe devices with big ioremapped mem ranges on the boad.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>

---

Changes in v4:
- remove the partition layout for the NAND Flash as well as it was
  forgotten
- Rebased on top of v3.15-rc1

Changes in v3:
- add the compatible strings for the localbus nodes
- remove the IRQ part of the board-control node as it is currently being
  reworked

Changes in v2:
- add some nodes on the localbus CS when possible
- only use the corenet_generic machine and add kmcoge4 to the supported
  boards instead of defining a new kmp204x machine
- set better and more precise device nodes for the spi devices
- remove the partion layout for the spi_flash@0

 arch/powerpc/boot/dts/kmcoge4.dts             | 152 +++++++++++++++++
 arch/powerpc/configs/85xx/kmp204x_defconfig   | 225 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig           |   2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c |   3 +-
 4 files changed, 380 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/kmcoge4.dts
 create mode 100644 arch/powerpc/configs/85xx/kmp204x_defconfig

diff --git a/arch/powerpc/boot/dts/kmcoge4.dts b/arch/powerpc/boot/dts/kmcoge4.dts
new file mode 100644
index 0000000..89b4119
--- /dev/null
+++ b/arch/powerpc/boot/dts/kmcoge4.dts
@@ -0,0 +1,152 @@
+/*
+ * Keymile kmcoge4 Device Tree Source, based on the P2041RDB DTS
+ *
+ * (C) Copyright 2014
+ * Valentin Longchamp, Keymile AG, valentin.longchamp@keymile.com
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "fsl/p2041si-pre.dtsi"
+
+/ {
+	model = "keymile,kmcoge4";
+	compatible = "keymile,kmcoge4", "keymile,kmp204x";
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
+				compatible = "spansion,s25fl256s1";
+				reg = <0>;
+				spi-max-frequency = <20000000>; /* input clock */
+			};
+
+			network_clock@1 {
+				compatible = "zarlink,zl30343";
+				reg = <1>;
+				spi-max-frequency = <8000000>;
+			};
+
+			flash@2 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "micron,m25p32";
+				reg = <2>;
+				spi-max-frequency = <15000000>;
+			};
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
+
+		sata@220000 {
+			status = "disabled";
+		};
+
+		sata@221000 {
+			status = "disabled";
+		};
+	};
+
+	rio: rapidio@ffe0c0000 {
+		status = "disabled";
+	};
+
+	lbc: localbus@ffe124000 {
+		reg = <0xf 0xfe124000 0 0x1000>;
+		ranges = <0 0 0xf 0xffa00000 0x00040000		/* LB 0 */
+			  1 0 0xf 0xfb000000 0x00010000		/* LB 1 */
+			  2 0 0xf 0xd0000000 0x10000000		/* LB 2 */
+			  3 0 0xf 0xe0000000 0x10000000>;	/* LB 3 */
+
+		nand@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,elbc-fcm-nand";
+			reg = <0 0 0x40000>;
+		};
+
+		board-control@1,0 {
+			compatible = "keymile,qriox";
+			reg = <1 0 0x80>;
+		};
+
+		chassis-mgmt@3,0 {
+			compatible = "keymile,bfticu";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <3 0 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <6 1 0 0>;
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
+		status = "disabled";
+	};
+
+	pci2: pcie@ffe202000 {
+		reg = <0xf 0xfe202000 0 0x1000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x20000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xf 0xf8010000 0 0x00010000>;
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
+/include/ "fsl/p2041si-post.dtsi"
diff --git a/arch/powerpc/configs/85xx/kmp204x_defconfig b/arch/powerpc/configs/85xx/kmp204x_defconfig
new file mode 100644
index 0000000..e9a81e5
--- /dev/null
+++ b/arch/powerpc/configs/85xx/kmp204x_defconfig
@@ -0,0 +1,225 @@
+CONFIG_PPC_85xx=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=8
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_AUDIT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
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
+CONFIG_MAC_PARTITION=y
+CONFIG_CORENET_GENERIC=y
+CONFIG_MPIC_MSGR=y
+CONFIG_HIGHMEM=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_BINFMT_MISC=m
+CONFIG_KEXEC=y
+CONFIG_FORCE_MAX_ZONEORDER=13
+CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
+# CONFIG_PCIEASPM is not set
+CONFIG_PCI_MSI=y
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_LOWMEM_SIZE_BOOL=y
+CONFIG_LOWMEM_SIZE=0x20000000
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM_USER=y
+CONFIG_XFRM_SUB_POLICY=y
+CONFIG_XFRM_STATISTICS=y
+CONFIG_NET_KEY=y
+CONFIG_NET_KEY_MIGRATE=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_NET_IPIP=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_INET_AH=y
+CONFIG_INET_ESP=y
+CONFIG_INET_IPCOMP=y
+# CONFIG_INET_LRO is not set
+CONFIG_IPV6=y
+CONFIG_IP_SCTP=m
+CONFIG_TIPC=y
+CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_CBQ=y
+CONFIG_NET_SCH_HTB=y
+CONFIG_NET_SCH_HFSC=y
+CONFIG_NET_SCH_PRIO=y
+CONFIG_NET_SCH_MULTIQ=y
+CONFIG_NET_SCH_RED=y
+CONFIG_NET_SCH_SFQ=y
+CONFIG_NET_SCH_TEQL=y
+CONFIG_NET_SCH_TBF=y
+CONFIG_NET_SCH_GRED=y
+CONFIG_NET_CLS_BASIC=y
+CONFIG_NET_CLS_TCINDEX=y
+CONFIG_NET_CLS_U32=y
+CONFIG_CLS_U32_PERF=y
+CONFIG_CLS_U32_MARK=y
+CONFIG_NET_CLS_FLOW=y
+CONFIG_NET_CLS_CGROUP=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/mdev"
+CONFIG_DEVTMPFS=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_PHRAM=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_ECC_BCH=y
+CONFIG_MTD_NAND_FSL_ELBC=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_GLUEBI=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=2
+CONFIG_BLK_DEV_RAM_SIZE=2048
+CONFIG_EEPROM_AT24=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_LOGGING=y
+CONFIG_SCSI_SYM53C8XX_2=y
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_ADAPTEC is not set
+# CONFIG_NET_VENDOR_ALTEON is not set
+# CONFIG_NET_VENDOR_AMD is not set
+# CONFIG_NET_VENDOR_ATHEROS is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_BROCADE is not set
+# CONFIG_NET_VENDOR_CHELSIO is not set
+# CONFIG_NET_VENDOR_CISCO is not set
+# CONFIG_NET_VENDOR_DEC is not set
+# CONFIG_NET_VENDOR_DLINK is not set
+# CONFIG_NET_VENDOR_EMULEX is not set
+# CONFIG_NET_VENDOR_EXAR is not set
+CONFIG_FSL_PQ_MDIO=y
+CONFIG_FSL_XGMAC_MDIO=y
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
+# CONFIG_NET_VENDOR_REALTEK is not set
+# CONFIG_NET_VENDOR_RDC is not set
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
+CONFIG_MARVELL_PHY=y
+CONFIG_VITESSE_PHY=y
+CONFIG_FIXED_PHY=y
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_PPC_EPAPR_HV_BYTECHAN=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_DETECT_IRQ=y
+CONFIG_SERIAL_8250_RSA=y
+CONFIG_NVRAM=y
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
+CONFIG_I2C_MPC=y
+CONFIG_SPI=y
+CONFIG_SPI_FSL_SPI=y
+CONFIG_SPI_FSL_ESPI=y
+CONFIG_SPI_SPIDEV=m
+CONFIG_PTP_1588_CLOCK=y
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_EDAC=y
+CONFIG_EDAC_MM_EDAC=y
+CONFIG_EDAC_MPC85XX=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS3232=y
+CONFIG_RTC_DRV_CMOS=y
+CONFIG_UIO=y
+CONFIG_STAGING=y
+# CONFIG_NET_VENDOR_SILICOM is not set
+CONFIG_CLK_PPC_CORENET=y
+CONFIG_EXT2_FS=y
+CONFIG_NTFS_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_UBIFS_FS=y
+CONFIG_CRAMFS=y
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=m
+CONFIG_CRC_ITU_T=m
+CONFIG_DEBUG_INFO=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_SHIRQ=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_SCHEDSTATS=y
+CONFIG_RCU_TRACE=y
+CONFIG_UPROBE_EVENT=y
+CONFIG_CRYPTO_NULL=y
+CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_MD4=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index c17aae8..fb98fd6 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -263,7 +263,7 @@ config CORENET_GENERIC
 	help
 	  This option enables support for the FSL CoreNet based boards.
 	  For 32bit kernel, the following boards are supported:
-	    P2041 RDB, P3041 DS and P4080 DS
+	    P2041 RDB, P3041 DS, P4080 DS and kmcoge4
 	  For 64bit kernel, the following boards are supported:
 	    T4240 QDS and B4 QDS
 	  The following boards are supported for both 32bit and 64bit kernel:
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 8e4b1e1..ceb0dac 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -67,7 +67,7 @@ void __init corenet_gen_setup_arch(void)
 
 	swiotlb_detect_4g();
 
-	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
+	pr_info("%s board\n", ppc_md.name);
 
 	mpc85xx_qe_init();
 }
@@ -122,6 +122,7 @@ static const char * const boards[] __initconst = {
 	"fsl,B4860QDS",
 	"fsl,B4420QDS",
 	"fsl,B4220QDS",
+	"keymile,kmcoge4",
 	NULL
 };
 
-- 
1.8.0.1
