Return-Path: <b37399@nmglablinux22.freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0116.outbound.protection.outlook.com [157.56.110.116])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53B471A0495
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 02:08:50 +1100 (EST)
From: Ashish Kumar <Ashish.Kumar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] mpc85xx: dts: Remove SPI and NAND partition from
 bsc9131rdb.dtsi
Date: Tue, 7 Oct 2014 18:04:36 +0530
Message-ID: <1412685276-5834-1-git-send-email-Ashish.Kumar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b07421@freescale.com, b01044@freesscale.com,
 Ashish Kumar <Ashish.Kumar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 * Run "mtdparts default" on u-boot to create dynamic partitions
 * Or use dynamic mtd partition with the help of bootargs in u-boot
   Append bootargs with:
    "mtdparts=ff800000.flash:1m(nand_uboot),512K(nand_dtb),8m(nand_kernel),-(fs);\
     spiff707000.0:1m(spi_uboot),4m(spi_kernel),512k(spi_dtb),-(fs)'"

Signed-off-by: Ashish Kumar <Ashish.Kumar@freescale.com>
---
 arch/powerpc/boot/dts/bsc9131rdb.dtsi |   50 ---------------------------------
 1 files changed, 0 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/boot/dts/bsc9131rdb.dtsi b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
index 9e6c013..45efcba 100644
--- a/arch/powerpc/boot/dts/bsc9131rdb.dtsi
+++ b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
@@ -40,31 +40,6 @@
 		compatible = "fsl,ifc-nand";
 		reg = <0x0 0x0 0x4000>;
 
-		partition@0 {
-			/* This location must not be altered  */
-			/* 3MB for u-boot Bootloader Image */
-			reg = <0x0 0x00300000>;
-			label = "NAND U-Boot Image";
-			read-only;
-		};
-
-		partition@300000 {
-			/* 1MB for DTB Image */
-			reg = <0x00300000 0x00100000>;
-			label = "NAND DTB Image";
-		};
-
-		partition@400000 {
-			/* 8MB for Linux Kernel Image */
-			reg = <0x00400000 0x00800000>;
-			label = "NAND Linux Kernel Image";
-		};
-
-		partition@c00000 {
-			/* Rest space for Root file System Image */
-			reg = <0x00c00000 0x07400000>;
-			label = "NAND RFS Image";
-		};
 	};
 };
 
@@ -82,31 +57,6 @@
 			reg = <0>;
 			spi-max-frequency = <50000000>;
 
-			/* 512KB for u-boot Bootloader Image */
-			partition@0 {
-				reg = <0x0 0x00080000>;
-				label = "SPI Flash U-Boot Image";
-				read-only;
-			};
-
-			/* 512KB for DTB Image */
-			partition@80000 {
-				reg = <0x00080000 0x00080000>;
-				label = "SPI Flash DTB Image";
-			};
-
-			/* 4MB for Linux Kernel Image */
-			partition@100000 {
-				reg = <0x00100000 0x00400000>;
-				label = "SPI Flash Kernel Image";
-			};
-
-			/*11MB for RFS Image */
-			partition@500000 {
-				reg = <0x00500000 0x00B00000>;
-				label = "SPI Flash RFS Image";
-			};
-
 		};
 	};
 
-- 
1.7.6.GIT
