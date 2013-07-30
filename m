Return-Path: <B25806@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 238C42C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 21:36:27 +1000 (EST)
Received: from mail187-db9 (localhost [127.0.0.1])	by
 mail187-db9-R.bigfish.com (Postfix) with ESMTP id E1E713A017C	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 11:36:18 +0000 (UTC)
Received: from DB9EHSMHS020.bigfish.com (unknown [10.174.16.251])	by
 mail187-db9.bigfish.com (Postfix) with ESMTP id A810F240066	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 11:35:19 +0000 (UTC)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/85xx: Add P1023RDB board support
Date: Tue, 30 Jul 2013 19:40:29 +0800
Message-ID: <1375184429-22145-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P1023RDB Specification:
-----------------------
Memory subsystem:
   512MB DDR3 (Fixed DDR on board)
   64MB NOR flash
   128MB NAND flash

Ethernet:
   eTSEC1: Connected to Atheros AR8035 GETH PHY
   eTSEC2: Connected to Atheros AR8035 GETH PHY

PCIe:
   Three mini-PCIe slots

USB:
   Two USB2.0 Type A ports

I2C:
   AT24C08 8K Board EEPROM (8 bit address)

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/p1023rdb.dts           |  237 ++++++++++++++++++++++++++
 arch/powerpc/configs/85xx/p1023_defconfig    |  183 ++++++++++++++++++++
 arch/powerpc/configs/85xx/p1023rds_defconfig |  169 ------------------
 arch/powerpc/platforms/85xx/Kconfig          |    4 +-
 arch/powerpc/platforms/85xx/p1023_rds.c      |   24 +++-
 5 files changed, 445 insertions(+), 172 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1023rdb.dts
 create mode 100644 arch/powerpc/configs/85xx/p1023_defconfig
 delete mode 100644 arch/powerpc/configs/85xx/p1023rds_defconfig

diff --git a/arch/powerpc/boot/dts/p1023rdb.dts b/arch/powerpc/boot/dts/p1023rdb.dts
new file mode 100644
index 0000000..107c676
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1023rdb.dts
@@ -0,0 +1,237 @@
+/*
+ * P1023 RDB Device Tree Source
+ *
+ *    Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Author: Chunhe Lan <Chunhe.Lan@freescale.com>
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
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
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
+/include/ "fsl/p1023si-pre.dtsi"
+
+/ {
+	model = "fsl,P1023";
+	compatible = "fsl,P1023RDB";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	memory {
+		device_type = "memory";
+	};
+
+	soc: soc@ff600000 {
+		ranges = <0x0 0x0 0xff600000 0x200000>;
+
+		i2c@3000 {
+			eeprom@53 {
+				compatible = "at24,24c04";
+				reg = <0x53>;
+			};
+
+			rtc@6f {
+				compatible = "microchip,mcp7941x";
+				reg = <0x6f>;
+			};
+		};
+
+		usb@22000 {
+			dr_mode = "host";
+			phy_type = "ulpi";
+		};
+	};
+
+	lbc: localbus@ff605000 {
+		reg = <0 0xff605000 0 0x1000>;
+
+		/* NOR, NAND Flashes */
+		ranges = <0x0 0x0 0x0 0xec000000 0x04000000
+			  0x1 0x0 0x0 0xffa00000 0x08000000>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x04000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			partition@0 {
+				/* 48MB for JFFS2 based Root file System */
+				reg = <0x00000000 0x03000000>;
+				label = "NOR JFFS2 Root File System";
+			};
+			partition@3000000 {
+				/* 1MB for DTB Image */
+				reg = <0x03000000 0x00100000>;
+				label = "NOR DTB Image";
+			};
+			partition@3100000 {
+				/* 14MB for Linux Kernel Image */
+				reg = <0x03100000 0x00e00000>;
+				label = "NOR Linux Kernel Image";
+			};
+			partition@3f00000 {
+				/* This location must not be altered  */
+				/* 512KB for u-boot Bootloader Image */
+				/* 512KB for u-boot Environment Variables */
+				reg = <0x03f00000 0x00100000>;
+				label = "NOR U-Boot Image";
+				read-only;
+			};
+		};
+
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,elbc-fcm-nand";
+			reg = <0x1 0x0 0x40000>;
+
+			partition@0 {
+				/* This location must not be altered  */
+				/* 1MB for u-boot Bootloader Image */
+				reg = <0x0 0x00100000>;
+				label = "NAND U-Boot Image";
+				read-only;
+			};
+
+			partition@100000 {
+				/* 1MB for DTB Image */
+				reg = <0x00100000 0x00100000>;
+				label = "NAND DTB Image";
+			};
+
+			partition@200000 {
+				/* 14MB for Linux Kernel Image */
+				reg = <0x00200000 0x00e00000>;
+				label = "NAND Linux Kernel Image";
+			};
+
+			partition@1000000 {
+				/* 32MB for Compressed Root file System Image */
+				reg = <0x01000000 0x02000000>;
+				label = "NAND Compressed RFS Image";
+			};
+
+			partition@3000000 {
+				/* 64MB for JFFS2 based Root file System */
+				reg = <0x03000000 0x04000000>;
+				label = "NAND JFFS2 Root File System";
+			};
+
+			partition@7000000 {
+				/* 16MB for User Writable Area */
+				reg = <0x07000000 0x01000000>;
+				label = "NAND Writable User area";
+			};
+		};
+	};
+
+	pci0: pcie@ff60a000 {
+		reg = <0 0xff60a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
+		pcie@0 {
+			/* IRQ[0:3] are pulled up on board, set to active-low */
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 0 1 0 0
+				0000 0 0 2 &mpic 1 1 0 0
+				0000 0 0 3 &mpic 2 1 0 0
+				0000 0 0 4 &mpic 3 1 0 0
+				>;
+			ranges = <0x2000000 0x0 0xc0000000
+				  0x2000000 0x0 0xc0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	board_pci1: pci1: pcie@ff609000 {
+		reg = <0 0xff609000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			/*
+			 * IRQ[4:6] only for PCIe, set to active-high,
+			 * IRQ[7] is pulled up on board, set to active-low
+			 */
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 4 2 0 0
+				0000 0 0 2 &mpic 5 2 0 0
+				0000 0 0 3 &mpic 6 2 0 0
+				0000 0 0 4 &mpic 7 1 0 0
+				>;
+			ranges = <0x2000000 0x0 0xa0000000
+				  0x2000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci2: pcie@ff60b000 {
+		reg = <0 0xff60b000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			/*
+			 * IRQ[8:10] are pulled up on board, set to active-low
+			 * IRQ[11] only for PCIe, set to active-high,
+			 */
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 8 1 0 0
+				0000 0 0 2 &mpic 9 1 0 0
+				0000 0 0 3 &mpic 10 1 0 0
+				0000 0 0 4 &mpic 11 2 0 0
+				>;
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+};
+
+/include/ "fsl/p1023si-post.dtsi"
diff --git a/arch/powerpc/configs/85xx/p1023_defconfig b/arch/powerpc/configs/85xx/p1023_defconfig
new file mode 100644
index 0000000..ac29fb8
--- /dev/null
+++ b/arch/powerpc/configs/85xx/p1023_defconfig
@@ -0,0 +1,183 @@
+CONFIG_PPC_85xx=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_AUDIT=y
+CONFIG_IRQ_DOMAIN_DEBUG=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_MAC_PARTITION=y
+CONFIG_P1023_RDB=y
+CONFIG_P1023_RDS=y
+CONFIG_QUICC_ENGINE=y
+CONFIG_QE_GPIO=y
+CONFIG_CPM2=y
+CONFIG_HIGHMEM=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_BINFMT_MISC=m
+CONFIG_MATH_EMULATION=y
+CONFIG_SWIOTLB=y
+CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
+# CONFIG_PCIEAER is not set
+# CONFIG_PCIEASPM is not set
+CONFIG_PCI_MSI=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM_USER=y
+CONFIG_NET_KEY=y
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
+CONFIG_ARPD=y
+CONFIG_INET_ESP=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_IPV6=y
+CONFIG_IP_SCTP=m
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_FSL_ELBC=y
+CONFIG_PROC_DEVICETREE=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_EEPROM_AT24=y
+CONFIG_EEPROM_LEGACY=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_LOGGING=y
+CONFIG_ATA=y
+CONFIG_SATA_FSL=y
+CONFIG_SATA_SIL24=y
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=y
+CONFIG_FS_ENET=y
+CONFIG_FSL_PQ_MDIO=y
+CONFIG_E1000E=y
+CONFIG_AT803X_PHY=y
+CONFIG_MARVELL_PHY=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_VITESSE_PHY=y
+CONFIG_FIXED_PHY=y
+CONFIG_INPUT_FF_MEMLESS=m
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_SERIO_LIBPS2=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_DETECT_IRQ=y
+CONFIG_SERIAL_8250_RSA=y
+CONFIG_SERIAL_QE=m
+CONFIG_NVRAM=y
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_CPM=m
+CONFIG_I2C_MPC=y
+CONFIG_GPIO_MPC8XXX=y
+# CONFIG_HWMON is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
+CONFIG_USB=y
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_MON=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_FSL=y
+CONFIG_USB_STORAGE=y
+CONFIG_EDAC=y
+CONFIG_EDAC_MM_EDAC=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_CMOS=y
+CONFIG_DMADEVICES=y
+CONFIG_FSL_DMA=y
+# CONFIG_NET_DMA is not set
+CONFIG_STAGING=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=y
+CONFIG_NTFS_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_ADFS_FS=m
+CONFIG_AFFS_FS=m
+CONFIG_HFS_FS=m
+CONFIG_HFSPLUS_FS=m
+CONFIG_BEFS_FS=m
+CONFIG_BFS_FS=m
+CONFIG_EFS_FS=m
+CONFIG_CRAMFS=y
+CONFIG_VXFS_FS=m
+CONFIG_HPFS_FS=m
+CONFIG_QNX4FS_FS=m
+CONFIG_SYSV_FS=m
+CONFIG_UFS_FS=m
+CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=y
+CONFIG_CRC_T10DIF=y
+CONFIG_FRAME_WARN=8092
+CONFIG_DEBUG_FS=y
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO=y
+CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_AES=y
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_DEV_FSL_CAAM=y
diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023rds_defconfig
deleted file mode 100644
index b80bcc6..0000000
--- a/arch/powerpc/configs/85xx/p1023rds_defconfig
+++ /dev/null
@@ -1,169 +0,0 @@
-CONFIG_PPC_85xx=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=2
-CONFIG_EXPERIMENTAL=y
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_AUDIT=y
-CONFIG_IRQ_DOMAIN_DEBUG=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_EMBEDDED=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_MAC_PARTITION=y
-CONFIG_P1023_RDS=y
-CONFIG_QUICC_ENGINE=y
-CONFIG_QE_GPIO=y
-CONFIG_CPM2=y
-CONFIG_HIGHMEM=y
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_BINFMT_MISC=m
-CONFIG_MATH_EMULATION=y
-CONFIG_SWIOTLB=y
-CONFIG_PCI=y
-CONFIG_PCIEPORTBUS=y
-# CONFIG_PCIEAER is not set
-# CONFIG_PCIEASPM is not set
-CONFIG_PCI_MSI=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=y
-CONFIG_NET_KEY=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_ROUTE_MULTIPATH=y
-CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-CONFIG_NET_IPIP=y
-CONFIG_IP_MROUTE=y
-CONFIG_IP_PIMSM_V1=y
-CONFIG_IP_PIMSM_V2=y
-CONFIG_ARPD=y
-CONFIG_INET_ESP=y
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-CONFIG_IPV6=y
-CONFIG_IP_SCTP=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_DEVTMPFS=y
-CONFIG_PROC_DEVICETREE=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=131072
-CONFIG_EEPROM_LEGACY=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_ST=y
-CONFIG_BLK_DEV_SR=y
-CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_MULTI_LUN=y
-CONFIG_SCSI_LOGGING=y
-CONFIG_ATA=y
-CONFIG_SATA_FSL=y
-CONFIG_SATA_SIL24=y
-CONFIG_NETDEVICES=y
-CONFIG_DUMMY=y
-CONFIG_FS_ENET=y
-CONFIG_FSL_PQ_MDIO=y
-CONFIG_E1000E=y
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_FIXED_PHY=y
-CONFIG_INPUT_FF_MEMLESS=m
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_SERIO_LIBPS2=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
-CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-CONFIG_SERIAL_8250_MANY_PORTS=y
-CONFIG_SERIAL_8250_DETECT_IRQ=y
-CONFIG_SERIAL_8250_RSA=y
-CONFIG_SERIAL_QE=m
-CONFIG_NVRAM=y
-CONFIG_I2C=y
-CONFIG_I2C_CPM=m
-CONFIG_I2C_MPC=y
-CONFIG_GPIO_MPC8XXX=y
-# CONFIG_HWMON is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=y
-CONFIG_SOUND=y
-CONFIG_SND=y
-CONFIG_SND_MIXER_OSS=y
-CONFIG_SND_PCM_OSS=y
-# CONFIG_SND_SUPPORT_OLD_API is not set
-CONFIG_USB=y
-CONFIG_USB_DEVICEFS=y
-CONFIG_USB_MON=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_STORAGE=y
-CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_CMOS=y
-CONFIG_DMADEVICES=y
-CONFIG_FSL_DMA=y
-# CONFIG_NET_DMA is not set
-CONFIG_STAGING=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_ISO9660_FS=m
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_UDF_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=y
-CONFIG_NTFS_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_ADFS_FS=m
-CONFIG_AFFS_FS=m
-CONFIG_HFS_FS=m
-CONFIG_HFSPLUS_FS=m
-CONFIG_BEFS_FS=m
-CONFIG_BFS_FS=m
-CONFIG_EFS_FS=m
-CONFIG_CRAMFS=y
-CONFIG_VXFS_FS=m
-CONFIG_HPFS_FS=m
-CONFIG_QNX4FS_FS=m
-CONFIG_SYSV_FS=m
-CONFIG_UFS_FS=m
-CONFIG_NFS_FS=y
-CONFIG_NFS_V4=y
-CONFIG_ROOT_NFS=y
-CONFIG_NFSD=y
-CONFIG_CRC_T10DIF=y
-CONFIG_FRAME_WARN=8092
-CONFIG_DEBUG_FS=y
-CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_DEBUG_INFO=y
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_SHA256=y
-CONFIG_CRYPTO_SHA512=y
-CONFIG_CRYPTO_AES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRYPTO_DEV_FSL_CAAM=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index efdd37c..d6424e9 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -112,10 +112,10 @@ config P1022_RDK
 	  reference board.
 
 config P1023_RDS
-	bool "Freescale P1023 RDS"
+	bool "Freescale P1023 RDS (P1023 RDB)"
 	select DEFAULT_UIMAGE
 	help
-	  This option enables support for the P1023 RDS board
+	  This option enables support for the P1023 RDS (P1023 RDB) board
 
 config SOCRATES
 	bool "Socrates"
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index 9cc60a7..2ae9d49 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2010-2011 Freescale Semiconductor, Inc.
+ * Copyright 2010-2011, 2013 Freescale Semiconductor, Inc.
  *
  * Author: Roy Zang <tie-fei.zang@freescale.com>
  *
@@ -86,6 +86,7 @@ static void __init mpc85xx_rds_setup_arch(void)
 }
 
 machine_arch_initcall(p1023_rds, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1023_rdb, mpc85xx_common_publish_devices);
 
 static void __init mpc85xx_rds_pic_init(void)
 {
@@ -106,6 +107,14 @@ static int __init p1023_rds_probe(void)
 
 }
 
+static int __init p1023_rdb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,P1023RDB");
+
+}
+
 define_machine(p1023_rds) {
 	.name			= "P1023 RDS",
 	.probe			= p1023_rds_probe,
@@ -120,3 +129,16 @@ define_machine(p1023_rds) {
 #endif
 };
 
+define_machine(p1023_rdb) {
+	.name			= "P1023 RDB",
+	.probe			= p1023_rdb_probe,
+	.setup_arch		= mpc85xx_rds_setup_arch,
+	.init_IRQ		= mpc85xx_rds_pic_init,
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+};
-- 
1.7.6.5
