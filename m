Return-Path: <B25806@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54CC42C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 18:21:47 +1000 (EST)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Add P1023RDB board support
Date: Fri, 14 Jun 2013 16:26:20 +0800
Message-ID: <1371198380-12792-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Chunhe Lan <Chunhe.Lan@freescale.com>
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
Cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1023rdb.dts           |  191 ++++++++++++++++++++++++++
 arch/powerpc/configs/85xx/p1023rds_defconfig |    4 +
 arch/powerpc/platforms/85xx/Kconfig          |    6 +
 arch/powerpc/platforms/85xx/p1023_rds.c      |   24 +++-
 4 files changed, 224 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1023rdb.dts

diff --git a/arch/powerpc/boot/dts/p1023rdb.dts b/arch/powerpc/boot/dts/p1023rdb.dts
new file mode 100644
index 0000000..4ce1cc9
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1023rdb.dts
@@ -0,0 +1,191 @@
+/*
+ * P1023 RDB Device Tree Source
+ *
+ *    Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Author: Roy Zang <tie-fei.zang@freescale.com>
+ *	   Chunhe Lan <Chunhe.Lan@freescale.com>
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
+		/* NOR Flash */
+		ranges = <0x0 0x0 0x0 0xec000000 0x04000000>;
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
+				label = "ramdisk";
+				reg = <0x00000000 0x03000000>;
+			};
+			partition@3000000 {
+				label = "kernel";
+				reg = <0x03000000 0x00ee0000>;
+			};
+			partiton@3ee0000 {
+				label = "dtb";
+				reg = <0x03ee0000 0x00020000>;
+			};
+			partition@3f00000 {
+				label = "firmware";
+				reg = <0x03f00000 0x00080000>;
+				read-only;
+			};
+			partition@3f80000 {
+				label = "u-boot";
+				reg = <0x03f80000 0x00080000>;
+				read-only;
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
diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023rds_defconfig
index b80bcc6..092a746 100644
--- a/arch/powerpc/configs/85xx/p1023rds_defconfig
+++ b/arch/powerpc/configs/85xx/p1023rds_defconfig
@@ -22,6 +22,7 @@ CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
+CONFIG_P1023_RDB=y
 CONFIG_P1023_RDS=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
@@ -67,6 +68,7 @@ CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
@@ -102,6 +104,7 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_QE=m
 CONFIG_NVRAM=y
 CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_CPM=m
 CONFIG_I2C_MPC=y
 CONFIG_GPIO_MPC8XXX=y
@@ -121,6 +124,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index efdd37c..d0e8ff9 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -111,6 +111,12 @@ config P1022_RDK
 	  This option enables support for the Freescale / iVeia P1022RDK
 	  reference board.
 
+config P1023_RDB
+	bool "Freescale P1023 RDB"
+	select P1023_RDS
+	help
+	  This option enables support for the P1023 RDB board
+
 config P1023_RDS
 	bool "Freescale P1023 RDS"
 	select DEFAULT_UIMAGE
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
