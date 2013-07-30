Return-Path: <B25806@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1DAD52C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 19:40:59 +1000 (EST)
Received: from mail15-tx2 (localhost [127.0.0.1])	by mail15-tx2-R.bigfish.com
 (Postfix) with ESMTP id 19C2748006B	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 31 Jul 2013 09:40:50 +0000 (UTC)
Received: from TX2EHSMHS038.bigfish.com (unknown [10.9.14.251])	by
 mail15-tx2.bigfish.com (Postfix) with ESMTP id C71E240235	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 09:40:47 +0000 (UTC)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3] powerpc/85xx: Add P1023RDB board support
Date: Wed, 31 Jul 2013 05:39:26 +0800
Message-ID: <1375220366-9247-1-git-send-email-Chunhe.Lan@freescale.com>
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
Changes for v2:
	- Add the NAND flash node in the device tree
	- Rename defconfig from p1023rds_defconfig to p1023_defconfig
	- Delete a new p1023rdb Kconfig option
Changes for v3:
	- Add changes information for revision
	- Delete the a needless NAND partition from the device tree
	- Modify the name and description in the Kconfig file

 arch/powerpc/boot/dts/p1023rdb.dts                 |  234 ++++++++++++++++++++
 .../85xx/{p1023rds_defconfig => p1023_defconfig}   |   24 ++-
 arch/powerpc/platforms/85xx/Kconfig                |    4 +-
 arch/powerpc/platforms/85xx/p1023_rds.c            |   24 ++-
 4 files changed, 280 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1023rdb.dts
 rename arch/powerpc/configs/85xx/{p1023rds_defconfig => p1023_defconfig} (88%)

diff --git a/arch/powerpc/boot/dts/p1023rdb.dts b/arch/powerpc/boot/dts/p1023rdb.dts
new file mode 100644
index 0000000..0a06a88
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1023rdb.dts
@@ -0,0 +1,234 @@
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
+				/* 48MB for Root File System */
+				reg = <0x00000000 0x03000000>;
+				label = "NOR Root File System";
+			};
+
+			partition@3000000 {
+				/* 1MB for DTB Image */
+				reg = <0x03000000 0x00100000>;
+				label = "NOR DTB Image";
+			};
+
+			partition@3100000 {
+				/* 14MB for Linux Kernel Image */
+				reg = <0x03100000 0x00e00000>;
+				label = "NOR Linux Kernel Image";
+			};
+
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
+				/* 96MB for Root File System Image */
+				reg = <0x01000000 0x06000000>;
+				label = "NAND Root File System";
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
diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023_defconfig
similarity index 88%
rename from arch/powerpc/configs/85xx/p1023rds_defconfig
rename to arch/powerpc/configs/85xx/p1023_defconfig
index b80bcc6..912ad28 100644
--- a/arch/powerpc/configs/85xx/p1023rds_defconfig
+++ b/arch/powerpc/configs/85xx/p1023_defconfig
@@ -1,14 +1,13 @@
 CONFIG_PPC_85xx=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_AUDIT=y
-CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_RCU_FANOUT=32
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -22,6 +21,8 @@ CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
+CONFIG_PHYSICAL_START=0x00000000
+CONFIG_P1023_RDB=y
 CONFIG_P1023_RDS=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
@@ -63,10 +64,20 @@ CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
@@ -82,6 +93,8 @@ CONFIG_DUMMY=y
 CONFIG_FS_ENET=y
 CONFIG_FSL_PQ_MDIO=y
 CONFIG_E1000E=y
+CONFIG_PHYLIB=y
+CONFIG_AT803X_PHY=y
 CONFIG_MARVELL_PHY=y
 CONFIG_DAVICOM_PHY=y
 CONFIG_CICADA_PHY=y
@@ -96,12 +109,15 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
-CONFIG_SERIAL_QE=m
+CONFIG_HW_RANDOM=y
 CONFIG_NVRAM=y
 CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_CPM=m
 CONFIG_I2C_MPC=y
 CONFIG_GPIO_MPC8XXX=y
@@ -121,6 +137,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
@@ -161,6 +178,7 @@ CONFIG_DEBUG_FS=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
+CONFIG_STRICT_DEVMEM=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index efdd37c..b8f0d32 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -112,10 +112,10 @@ config P1022_RDK
 	  reference board.
 
 config P1023_RDS
-	bool "Freescale P1023 RDS"
+	bool "Freescale P1023 RDS/RDB"
 	select DEFAULT_UIMAGE
 	help
-	  This option enables support for the P1023 RDS board
+	  This option enables support for the P1023 RDS and RDB boards
 
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
