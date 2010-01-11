Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og102.obsmtp.com (exprod5og102.obsmtp.com [64.18.0.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1EFF0B7E80
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 23:25:57 +1100 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 4/8] powerpc: Basic flash support for GE SBC610
To: galak@kernel.crashing.org
Date: Mon, 11 Jan 2010 12:23:31 +0000
Message-ID: <20100111122331.8306.66922.stgit@ES-J7S4D2J.amer.consind.ge.com>
In-Reply-To: <20100111121622.8306.87501.stgit@ES-J7S4D2J.amer.consind.ge.com>
References: <20100111121622.8306.87501.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Support for the SBC610 VPX Single Board Computer from GE (PowerPC MPC8641D).

This patch adds basic support for the on-board flash.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc610.dts           |   50 ++++++++++++++++++++----
 arch/powerpc/configs/86xx/gef_sbc610_defconfig |   23 +++++++----
 2 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index 78c336f..bb70600 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -75,14 +75,48 @@
 		interrupts = <19 2>;
 		interrupt-parent = <&mpic>;
 
-		ranges = <0 0 0xff000000 0x01000000     // 16MB Boot flash
-			  1 0 0xe8000000 0x08000000     // Paged Flash 0
-			  2 0 0xe0000000 0x08000000     // Paged Flash 1
-			  3 0 0xfc100000 0x00020000     // NVRAM
-			  4 0 0xfc000000 0x00008000     // FPGA
-			  5 0 0xfc008000 0x00008000     // AFIX FPGA
-			  6 0 0xfd000000 0x00800000     // IO FPGA (8-bit)
-			  7 0 0xfd800000 0x00800000>;   // IO FPGA (32-bit)
+		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
+			  1 0 0xe8000000 0x08000000	// Paged Flash 0
+			  2 0 0xe0000000 0x08000000	// Paged Flash 1
+			  3 0 0xfc100000 0x00020000	// NVRAM
+			  4 0 0xfc000000 0x00008000	// FPGA
+			  5 0 0xfc008000 0x00008000	// AFIX FPGA
+			  6 0 0xfd000000 0x00800000	// IO FPGA (8-bit)
+			  7 0 0xfd800000 0x00800000>;	// IO FPGA (32-bit)
+
+		/* flash@0,0 is a mirror of part of the memory in flash@1,0
+		flash@0,0 {
+			compatible = "gef,sbc610-firmware-mirror", "cfi-flash";
+			reg = <0x0 0x0 0x1000000>;
+			bank-width = <4>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "firmware";
+				reg = <0x0 0x1000000>;
+				read-only;
+			};
+		};
+		*/
+
+		flash@1,0 {
+			compatible = "gef,sbc610-paged-flash", "cfi-flash";
+			reg = <0x1 0x0 0x8000000>;
+			bank-width = <4>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "user";
+				reg = <0x0 0x7800000>;
+			};
+			partition@7800000 {
+				label = "firmware";
+				reg = <0x7800000 0x800000>;
+				read-only;
+			};
+		};
 
 		nvram@3,0 {
 			device_type = "nvram";
diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
index 1975d41..9284f04 100644
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
@@ -623,7 +623,7 @@ CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
-# CONFIG_MTD_OF_PARTS is not set
+CONFIG_MTD_OF_PARTS=y
 # CONFIG_MTD_AR7_PARTS is not set
 
 #
@@ -643,13 +643,9 @@ CONFIG_MTD_BLOCK=y
 # RAM/ROM/Flash chip drivers
 #
 CONFIG_MTD_CFI=y
-# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_GEN_PROBE=y
-CONFIG_MTD_CFI_ADV_OPTIONS=y
-# CONFIG_MTD_CFI_NOSWAP is not set
-# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
-CONFIG_MTD_CFI_LE_BYTE_SWAP=y
-# CONFIG_MTD_CFI_GEOMETRY is not set
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
 CONFIG_MTD_MAP_BANK_WIDTH_1=y
 CONFIG_MTD_MAP_BANK_WIDTH_2=y
 CONFIG_MTD_MAP_BANK_WIDTH_4=y
@@ -660,7 +656,6 @@ CONFIG_MTD_CFI_I1=y
 CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
-# CONFIG_MTD_OTP is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 # CONFIG_MTD_CFI_STAA is not set
@@ -1682,7 +1677,17 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS2_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set


--
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 927559189
