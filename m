Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 3D882DDE00
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 04:46:31 +1000 (EST)
Date: Sun, 4 May 2008 22:46:27 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2] [POWERPC] 86xx: mpc8610_hpcd: add support for NOR and
	NAND flashes
Message-ID: <20080504184627.GA16998@polina.dev.rtsoft.ru>
References: <20080504150727.GA27038@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080504150727.GA27038@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds device tree nodes for NOR and NAND flashes and places
board-control node inside the localbus.

defconfig and board file updated appropriately.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Heh, this is v2. The flash setup on the MPC8610 tricked me.

There is single NAND package, but with four physical NAND
chips inside. Each occupy its own localbus CE line, i.e. bank.

 arch/powerpc/boot/dts/mpc8610_hpcd.dts      |   60 +++++++++++++++++-
 arch/powerpc/configs/mpc8610_hpcd_defconfig |   88 ++++++++++++++++++++++++++-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c  |    1 +
 3 files changed, 145 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index bba234e..08a780d 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -46,9 +46,63 @@
 		reg = <0x00000000 0x20000000>;	// 512M at 0x0
 	};
 
-	board-control@e8000000 {
-		compatible = "fsl,fpga-pixis";
-		reg = <0xe8000000 32>;		// pixis at 0xe8000000
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8610-elbc", "fsl,elbc", "simple-bus";
+		reg = <0xe0005000 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+		ranges = <0 0 0xf8000000 0x08000000
+			  1 0 0xf0000000 0x08000000
+			  2 0 0xe8400000 0x00008000
+			  4 0 0xe8440000 0x00008000
+			  5 0 0xe8480000 0x00008000
+			  6 0 0xe84c0000 0x00008000
+			  3 0 0xe8000000 0x00000020>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x8000000>;
+			bank-width = <2>;
+			device-width = <1>;
+		};
+
+		flash@1,0 {
+			compatible = "cfi-flash";
+			reg = <1 0 0x8000000>;
+			bank-width = <2>;
+			device-width = <1>;
+		};
+
+		flash@2,0 {
+			compatible = "fsl,mpc8610-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <2 0 0x8000>;
+		};
+
+		flash@4,0 {
+			compatible = "fsl,mpc8610-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <4 0 0x8000>;
+		};
+
+		flash@5,0 {
+			compatible = "fsl,mpc8610-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <5 0 0x8000>;
+		};
+
+		flash@6,0 {
+			compatible = "fsl,mpc8610-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <6 0 0x8000>;
+		};
+
+		board-control@3,0 {
+			compatible = "fsl,fpga-pixis";
+			reg = <3 0 0x20>;
+		};
 	};
 
 	soc@e0000000 {
diff --git a/arch/powerpc/configs/mpc8610_hpcd_defconfig b/arch/powerpc/configs/mpc8610_hpcd_defconfig
index f9e53bd..7e5b9ce 100644
--- a/arch/powerpc/configs/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/mpc8610_hpcd_defconfig
@@ -358,7 +358,93 @@ CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_OF_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_CAFE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+CONFIG_MTD_NAND_FSL_ELBC=y
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 CONFIG_OF_DEVICE=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 5e1e8cf..782d1cb 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -43,6 +43,7 @@ static unsigned char *pixis_bdcfg0, *pixis_arch;
 
 static struct of_device_id __initdata mpc8610_ids[] = {
 	{ .compatible = "fsl,mpc8610-immr", },
+	{ .compatible = "simple-bus", },
 	{}
 };
 
-- 
1.5.5.1
