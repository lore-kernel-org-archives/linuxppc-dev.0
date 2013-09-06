Return-Path: <B21284@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6B05C2C00AF
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Sep 2013 18:09:01 +1000 (EST)
Received: from mail145-ch1 (localhost [127.0.0.1])	by
 mail145-ch1-R.bigfish.com (Postfix) with ESMTP id 151761C0413	for
 <linuxppc-dev@ozlabs.org>; Fri,  6 Sep 2013 08:08:58 +0000 (UTC)
Received: from CH1EHSMHS019.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.226])	by mail145-ch1.bigfish.com (Postfix) with ESMTP id
 3701B240047	for <linuxppc-dev@ozlabs.org>; Fri,  6 Sep 2013 08:08:56 +0000
 (UTC)
From: Mingkai Hu <Mingkai.Hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: DTS - re-organize the SPI partitions property
Date: Fri, 6 Sep 2013 16:05:43 +0800
Message-ID: <1378454743-17637-1-git-send-email-Mingkai.Hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Mingkai Hu <Mingkai.Hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Re-organize the SPI partitions and use the same SPI flash memory
map for most of the platforms which have 16MB SPI flash mounted.

1. Extend the U-Boot partition to 1MB
   The image for booting from SPI is larger than 512KB, while
   the size of U-Boot partition is 512KB on some boards, so
   enlarge it to 1MB in order to contain the whole U-Boot image.

2. Reserve space for U-Boot environment variables
   The environment variables are stored at offset 0x100000, so
   if other image was put at this address, it'll be overlapped
   when saving the environment variables.

3. Reserve space for FMAN ucode
   The FMAN ucode is required on DPAA platform and is stored at
   offset 0x110000, this address should not be used to store any
   other images.

4. Extend the kernel partition to 5MB

Here is diagram for the SPI flash memory map:

        0x000000 |-------------|
                 | U-Boot      |
                 | (1MB)       |
        0x100000 |-------------|
                 | Env(64KB)   |
        0x110000 |-------------|
                 | ucode       |
        0x180000 |-------------|
                 | DTB         |
                 | (512KB)     |
        0x200000 |-------------|
                 | kernel      |
                 | (5MB)       |
        0x700000 |-------------|
                 | file system |
                 | (9MB)       |
       0x1000000 |-------------|

Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
---

Based on 'next' branch on git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git

 arch/powerpc/boot/dts/bsc9131rdb.dtsi  | 35 ++++++++++++-----------------
 arch/powerpc/boot/dts/c293pcie.dts     | 35 ++++++++++++-----------------
 arch/powerpc/boot/dts/mpc8536ds.dtsi   | 12 +++++-----
 arch/powerpc/boot/dts/p1010rdb.dtsi    | 40 ++++++++++++----------------------
 arch/powerpc/boot/dts/p1020rdb-pc.dtsi | 24 +++++---------------
 arch/powerpc/boot/dts/p1020rdb-pd.dts  | 34 ++++++++++++-----------------
 arch/powerpc/boot/dts/p1020rdb.dtsi    | 23 ++++---------------
 arch/powerpc/boot/dts/p1021mds.dts     | 17 +++++++--------
 arch/powerpc/boot/dts/p1021rdb-pc.dtsi | 32 +++++++++------------------
 arch/powerpc/boot/dts/p1022ds.dtsi     | 21 +++++++++---------
 arch/powerpc/boot/dts/p1023rds.dts     | 10 ++-------
 arch/powerpc/boot/dts/p1024rdb.dtsi    | 40 ++++++++++++----------------------
 arch/powerpc/boot/dts/p1025rdb.dtsi    | 23 +++++--------------
 arch/powerpc/boot/dts/p2020rdb-pc.dtsi | 40 ++++++++++++----------------------
 arch/powerpc/boot/dts/p2020rdb.dts     | 38 ++++++++++----------------------
 arch/powerpc/boot/dts/p2041rdb.dts     | 12 +++++-----
 arch/powerpc/boot/dts/p3041ds.dts      | 12 +++++-----
 arch/powerpc/boot/dts/p4080ds.dts      | 12 +++++-----
 arch/powerpc/boot/dts/p5020ds.dts      | 12 +++++-----
 arch/powerpc/boot/dts/p5040ds.dts      | 13 ++++++-----
 20 files changed, 180 insertions(+), 305 deletions(-)

diff --git a/arch/powerpc/boot/dts/bsc9131rdb.dtsi b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
index 9e6c013..8250593 100644
--- a/arch/powerpc/boot/dts/bsc9131rdb.dtsi
+++ b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
@@ -81,32 +81,25 @@
 			compatible = "spansion,s25sl12801";
 			reg = <0>;
 			spi-max-frequency = <50000000>;
-
-			/* 512KB for u-boot Bootloader Image */
-			partition@0 {
-				reg = <0x0 0x00080000>;
-				label = "SPI Flash U-Boot Image";
+			partition@u-boot {
+				label = "u-boot";
+				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
-
-			/* 512KB for DTB Image */
-			partition@80000 {
-				reg = <0x00080000 0x00080000>;
-				label = "SPI Flash DTB Image";
+			partition@dtb {
+				label = "dtb";
+				reg = <0x00180000 0x00080000>;
+				read-only;
 			};
-
-			/* 4MB for Linux Kernel Image */
-			partition@100000 {
-				reg = <0x00100000 0x00400000>;
-				label = "SPI Flash Kernel Image";
+			partition@kernel {
+				label = "kernel";
+				reg = <0x00200000 0x00500000>;
+				read-only;
 			};
-
-			/*11MB for RFS Image */
-			partition@500000 {
-				reg = <0x00500000 0x00B00000>;
-				label = "SPI Flash RFS Image";
+			partition@fs {
+				label = "file system";
+				reg = <0x00700000 0x00900000>;
 			};
-
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/c293pcie.dts b/arch/powerpc/boot/dts/c293pcie.dts
index 1238bda..8ee8459 100644
--- a/arch/powerpc/boot/dts/c293pcie.dts
+++ b/arch/powerpc/boot/dts/c293pcie.dts
@@ -169,31 +169,24 @@
 			compatible = "spansion,s25sl12801";
 			reg = <0>;
 			spi-max-frequency = <50000000>;
-
-			partition@0 {
-				/* 1MB for u-boot Bootloader Image */
-				/* 1MB for Environment */
-				reg = <0x0 0x00100000>;
-				label = "SPI Flash U-Boot Image";
+			partition@u-boot {
+				label = "u-boot";
+				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
-
-			partition@100000 {
-				/* 512KB for DTB Image */
-				reg = <0x00100000 0x00080000>;
-				label = "SPI Flash DTB Image";
+			partition@dtb {
+				label = "dtb";
+				reg = <0x00180000 0x00080000>;
+				read-only;
 			};
-
-			partition@180000 {
-				/* 4MB for Linux Kernel Image */
-				reg = <0x00180000 0x00400000>;
-				label = "SPI Flash Linux Kernel Image";
+			partition@kernel {
+				label = "kernel";
+				reg = <0x00200000 0x00500000>;
+				read-only;
 			};
-
-			partition@580000 {
-				/* 10.5MB for RFS Image */
-				reg = <0x00580000 0x00a80000>;
-				label = "SPI Flash RFS Image";
+			partition@fs {
+				label = "file system";
+				reg = <0x00700000 0x00900000>;
 			};
 		};
 	};
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dtsi b/arch/powerpc/boot/dts/mpc8536ds.dtsi
index 7c3dde8..daa3de4 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dtsi
+++ b/arch/powerpc/boot/dts/mpc8536ds.dtsi
@@ -150,14 +150,14 @@
 				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
-			partition@kernel {
-				label = "kernel";
-				reg = <0x00100000 0x00500000>;
-				read-only;
-			};
 			partition@dtb {
 				label = "dtb";
-				reg = <0x00600000 0x00100000>;
+				reg = <0x00180000 0x00080000>;
+				read-only;
+			};
+			partition@kernel {
+				label = "kernel";
+				reg = <0x00200000 0x00500000>;
 				read-only;
 			};
 			partition@fs {
diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index ec7c27a..e67db57 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -152,36 +152,24 @@
 			reg = <0>;
 			spi-max-frequency = <40000000>;
 
-			partition@0 {
-				/* 1MB for u-boot Bootloader Image */
-				/* 1MB for Environment */
-				reg = <0x0 0x00100000>;
-				label = "SPI Flash U-Boot Image";
+			partition@u-boot {
+				label = "u-boot";
+				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
-
-			partition@100000 {
-				/* 512KB for DTB Image */
-				reg = <0x00100000 0x00080000>;
-				label = "SPI Flash DTB Image";
-			};
-
-			partition@180000 {
-				/* 4MB for Linux Kernel Image */
-				reg = <0x00180000 0x00400000>;
-				label = "SPI Flash Linux Kernel Image";
+			partition@dtb {
+				label = "dtb";
+				reg = <0x00180000 0x00080000>;
+				read-only;
 			};
-
-			partition@580000 {
-				/* 4MB for Compressed RFS Image */
-				reg = <0x00580000 0x00400000>;
-				label = "SPI Flash Compressed RFSImage";
+			partition@kernel {
+				label = "kernel";
+				reg = <0x00200000 0x00500000>;
+				read-only;
 			};
-
-			partition@980000 {
-				/* 6.5MB for JFFS2 based RFS */
-				reg = <0x00980000 0x00680000>;
-				label = "SPI Flash JFFS2 RFS";
+			partition@fs {
+				label = "file system";
+				reg = <0x00700000 0x00900000>;
 			};
 		};
 	};
diff --git a/arch/powerpc/boot/dts/p1020rdb-pc.dtsi b/arch/powerpc/boot/dts/p1020rdb-pc.dtsi
index c952cd3..277b563 100644
--- a/arch/powerpc/boot/dts/p1020rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/p1020rdb-pc.dtsi
@@ -154,36 +154,24 @@
 			compatible = "spansion,s25sl12801";
 			reg = <0>;
 			spi-max-frequency = <40000000>; /* input clock */
-
 			partition@u-boot {
-				/* 512KB for u-boot Bootloader Image */
-				reg = <0x0 0x00080000>;
 				label = "u-boot";
+				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
-
 			partition@dtb {
-				/* 512KB for DTB Image*/
-				reg = <0x00080000 0x00080000>;
 				label = "dtb";
+				reg = <0x00180000 0x00080000>;
+				read-only;
 			};
-
 			partition@kernel {
-				/* 4MB for Linux Kernel Image */
-				reg = <0x00100000 0x00400000>;
 				label = "kernel";
+				reg = <0x00200000 0x00500000>;
+				read-only;
 			};
-
 			partition@fs {
-				/* 4MB for Compressed RFS Image */
-				reg = <0x00500000 0x00400000>;
 				label = "file system";
-			};
-
-			partition@jffs-fs {
-				/* 7MB for JFFS2 based RFS */
-				reg = <0x00900000 0x00700000>;
-				label = "file system jffs2";
+				reg = <0x00700000 0x00900000>;
 			};
 		};
 	};
diff --git a/arch/powerpc/boot/dts/p1020rdb-pd.dts b/arch/powerpc/boot/dts/p1020rdb-pd.dts
index 987017e..b37f3e0 100644
--- a/arch/powerpc/boot/dts/p1020rdb-pd.dts
+++ b/arch/powerpc/boot/dts/p1020rdb-pd.dts
@@ -159,30 +159,24 @@
 				reg = <0>;
 				/* input clock */
 				spi-max-frequency = <40000000>;
-
-				partition@0 {
-					/* 512KB for u-boot Bootloader Image */
-					reg = <0x0 0x00080000>;
-					label = "SPI U-Boot Image";
+				partition@u-boot {
+					label = "u-boot";
+					reg = <0x00000000 0x00100000>;
 					read-only;
 				};
-
-				partition@80000 {
-					/* 512KB for DTB Image*/
-					reg = <0x00080000 0x00080000>;
-					label = "SPI DTB Image";
+				partition@dtb {
+					label = "dtb";
+					reg = <0x00180000 0x00080000>;
+					read-only;
 				};
-
-				partition@100000 {
-					/* 4MB for Linux Kernel Image */
-					reg = <0x00100000 0x00400000>;
-					label = "SPI Linux Kernel Image";
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00200000 0x00500000>;
+					read-only;
 				};
-
-				partition@500000 {
-					/* 11MB for FS System Image */
-					reg = <0x00500000 0x00b00000>;
-					label = "SPI File System Image";
+				partition@fs {
+					label = "file system";
+					reg = <0x00700000 0x00900000>;
 				};
 			};
 
diff --git a/arch/powerpc/boot/dts/p1020rdb.dtsi b/arch/powerpc/boot/dts/p1020rdb.dtsi
index 1fb7e0e..f320acc 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1020rdb.dtsi
@@ -151,39 +151,24 @@
 			compatible = "spansion,s25sl12801";
 			reg = <0>;
 			spi-max-frequency = <40000000>; /* input clock */
-
 			partition@u-boot {
-				/* 512KB for u-boot Bootloader Image */
-				reg = <0x0 0x00080000>;
 				label = "u-boot";
+				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
-
 			partition@dtb {
-				/* 512KB for DTB Image */
-				reg = <0x00080000 0x00080000>;
 				label = "dtb";
+				reg = <0x00180000 0x00080000>;
 				read-only;
 			};
-
 			partition@kernel {
-				/* 4MB for Linux Kernel Image */
-				reg = <0x00100000 0x00400000>;
 				label = "kernel";
+				reg = <0x00200000 0x00500000>;
 				read-only;
 			};
-
 			partition@fs {
-				/* 4MB for Compressed RFS Image */
-				reg = <0x00500000 0x00400000>;
 				label = "file system";
-				read-only;
-			};
-
-			partition@jffs-fs {
-				/* 7MB for JFFS2 based RFS */
-				reg = <0x00900000 0x00700000>;
-				label = "file system jffs2";
+				reg = <0x00700000 0x00900000>;
 			};
 		};
 	};
diff --git a/arch/powerpc/boot/dts/p1021mds.dts b/arch/powerpc/boot/dts/p1021mds.dts
index 97116f1..0d0b6f7 100644
--- a/arch/powerpc/boot/dts/p1021mds.dts
+++ b/arch/powerpc/boot/dts/p1021mds.dts
@@ -126,24 +126,23 @@
 				compatible = "spansion,s25sl12801";
 				reg = <0>;
 				spi-max-frequency = <40000000>; /* input clock */
-
 				partition@u-boot {
-					label = "u-boot-spi";
+					label = "u-boot";
 					reg = <0x00000000 0x00100000>;
 					read-only;
 				};
-				partition@kernel {
-					label = "kernel-spi";
-					reg = <0x00100000 0x00500000>;
+				partition@dtb {
+					label = "dtb";
+					reg = <0x00180000 0x00080000>;
 					read-only;
 				};
-				partition@dtb {
-					label = "dtb-spi";
-					reg = <0x00600000 0x00100000>;
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00200000 0x00500000>;
 					read-only;
 				};
 				partition@fs {
-					label = "file system-spi";
+					label = "file system";
 					reg = <0x00700000 0x00900000>;
 				};
 			};
diff --git a/arch/powerpc/boot/dts/p1021rdb-pc.dtsi b/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
index d6274c5..4e6aedd 100644
--- a/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
@@ -153,36 +153,24 @@
 			compatible = "spansion,s25sl12801";
 			reg = <0>;
 			spi-max-frequency = <40000000>; /* input clock */
-
 			partition@u-boot {
-				/* 512KB for u-boot Bootloader Image */
-				reg = <0x0 0x00080000>;
-				label = "SPI Flash U-Boot Image";
+				label = "u-boot";
+				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
-
 			partition@dtb {
-				/* 512KB for DTB Image */
-				reg = <0x00080000 0x00080000>;
-				label = "SPI Flash DTB Image";
+				label = "dtb";
+				reg = <0x00180000 0x00080000>;
+				read-only;
 			};
-
 			partition@kernel {
-				/* 4MB for Linux Kernel Image */
-				reg = <0x00100000 0x00400000>;
-				label = "SPI Flash Linux Kernel Image";
+				label = "kernel";
+				reg = <0x00200000 0x00500000>;
+				read-only;
 			};
-
 			partition@fs {
-				/* 4MB for Compressed RFS Image */
-				reg = <0x00500000 0x00400000>;
-				label = "SPI Flash Compressed RFSImage";
-			};
-
-			partition@jffs-fs {
-				/* 7MB for JFFS2 based RFS */
-				reg = <0x00900000 0x00700000>;
-				label = "SPI Flash JFFS2 RFS";
+				label = "file system";
+				reg = <0x00700000 0x00900000>;
 			};
 		};
 	};
diff --git a/arch/powerpc/boot/dts/p1022ds.dtsi b/arch/powerpc/boot/dts/p1022ds.dtsi
index 873da35..faa2cb0 100644
--- a/arch/powerpc/boot/dts/p1022ds.dtsi
+++ b/arch/powerpc/boot/dts/p1022ds.dtsi
@@ -162,24 +162,23 @@
 			compatible = "spansion,s25sl12801";
 			reg = <0>;
 			spi-max-frequency = <40000000>; /* input clock */
-
-			partition@0 {
-				label = "u-boot-spi";
+			partition@u-boot {
+				label = "u-boot";
 				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
-			partition@100000 {
-				label = "kernel-spi";
-				reg = <0x00100000 0x00500000>;
+			partition@dtb {
+				label = "dtb";
+				reg = <0x00180000 0x00080000>;
 				read-only;
 			};
-			partition@600000 {
-				label = "dtb-spi";
-				reg = <0x00600000 0x00100000>;
+			partition@kernel {
+				label = "kernel";
+				reg = <0x00200000 0x00500000>;
 				read-only;
 			};
-			partition@700000 {
-				label = "file system-spi";
+			partition@fs {
+				label = "file system";
 				reg = <0x00700000 0x00900000>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/p1023rds.dts b/arch/powerpc/boot/dts/p1023rds.dts
index beb6cb1..9fcf9af 100644
--- a/arch/powerpc/boot/dts/p1023rds.dts
+++ b/arch/powerpc/boot/dts/p1023rds.dts
@@ -65,15 +65,9 @@
 				reg = <0>;
 				spi-max-frequency = <40000000>; /* input clock */
 				partition@u-boot {
-					/* 512KB for u-boot Bootloader Image */
+					/* 1MB for u-boot Bootloader Image */
 					label = "u-boot-spi";
-					reg = <0x00000000 0x00080000>;
-					read-only;
-				};
-				partition@dtb {
-					/* 512KB for DTB Image */
-					label = "dtb-spi";
-					reg = <0x00080000 0x00080000>;
+					reg = <0x00000000 0x00100000>;
 					read-only;
 				};
 			};
diff --git a/arch/powerpc/boot/dts/p1024rdb.dtsi b/arch/powerpc/boot/dts/p1024rdb.dtsi
index b05dcb4..2896f98 100644
--- a/arch/powerpc/boot/dts/p1024rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1024rdb.dtsi
@@ -132,36 +132,24 @@
 			compatible = "spansion,m25p80";
 			reg = <0>;
 			spi-max-frequency = <40000000>;
-
-			partition@0 {
-				/* 512KB for u-boot Bootloader Image */
-				reg = <0x0 0x00080000>;
-				label = "SPI U-Boot Image";
+			partition@u-boot {
+				label = "u-boot";
+				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
-
-			partition@80000 {
-				/* 512KB for DTB Image */
-				reg = <0x00080000 0x00080000>;
-				label = "SPI DTB Image";
-			};
-
-			partition@100000 {
-				/* 4MB for Linux Kernel Image */
-				reg = <0x00100000 0x00400000>;
-				label = "SPI Linux Kernel Image";
+			partition@dtb {
+				label = "dtb";
+				reg = <0x00180000 0x00080000>;
+				read-only;
 			};
-
-			partition@500000 {
-				/* 4MB for Compressed RFS Image */
-				reg = <0x00500000 0x00400000>;
-				label = "SPI Compressed RFS Image";
+			partition@kernel {
+				label = "kernel";
+				reg = <0x00200000 0x00500000>;
+				read-only;
 			};
-
-			partition@900000 {
-				/* 7MB for JFFS2 based RFS */
-				reg = <0x00900000 0x00700000>;
-				label = "SPI JFFS2 RFS";
+			partition@fs {
+				label = "file system";
+				reg = <0x00700000 0x00900000>;
 			};
 		};
 	};
diff --git a/arch/powerpc/boot/dts/p1025rdb.dtsi b/arch/powerpc/boot/dts/p1025rdb.dtsi
index f502564..e74439c8 100644
--- a/arch/powerpc/boot/dts/p1025rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1025rdb.dtsi
@@ -142,34 +142,23 @@
 			spi-max-frequency = <40000000>; /* input clock */
 
 			partition@u-boot {
-				/* 512KB for u-boot Bootloader Image */
-				reg = <0x0 0x00080000>;
 				label = "u-boot";
+				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
-
 			partition@dtb {
-				/* 512KB for DTB Image */
-				reg = <0x00080000 0x00080000>;
 				label = "dtb";
+				reg = <0x00180000 0x00080000>;
+				read-only;
 			};
-
 			partition@kernel {
-				/* 4MB for Linux Kernel Image */
-				reg = <0x00100000 0x00400000>;
 				label = "kernel";
+				reg = <0x00200000 0x00500000>;
+				read-only;
 			};
-
 			partition@fs {
-				/* 4MB for Compressed RFS Image */
-				reg = <0x00500000 0x00400000>;
 				label = "file system";
-			};
-
-			partition@jffs-fs {
-				/* 7MB for JFFS2 based RFS */
-				reg = <0x00900000 0x00700000>;
-				label = "file system jffs2";
+				reg = <0x00700000 0x00900000>;
 			};
 		};
 	};
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
index c21d1c7..d501d35 100644
--- a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
@@ -154,36 +154,24 @@
 			compatible = "spansion,m25p80";
 			reg = <0>;
 			spi-max-frequency = <40000000>;
-
-			partition@0 {
-				/* 512KB for u-boot Bootloader Image */
-				reg = <0x0 0x00080000>;
-				label = "SPI U-Boot Image";
+			partition@u-boot {
+				label = "u-boot";
+				reg = <0x00000000 0x00100000>;
 				read-only;
 			};
-
-			partition@80000 {
-				/* 512KB for DTB Image */
-				reg = <0x00080000 0x00080000>;
-				label = "SPI DTB Image";
-			};
-
-			partition@100000 {
-				/* 4MB for Linux Kernel Image */
-				reg = <0x00100000 0x00400000>;
-				label = "SPI Linux Kernel Image";
+			partition@dtb {
+				label = "dtb";
+				reg = <0x00180000 0x00080000>;
+				read-only;
 			};
-
-			partition@500000 {
-				/* 4MB for Compressed RFS Image */
-				reg = <0x00500000 0x00400000>;
-				label = "SPI Compressed RFS Image";
+			partition@kernel {
+				label = "kernel";
+				reg = <0x00200000 0x00500000>;
+				read-only;
 			};
-
-			partition@900000 {
-				/* 7MB for JFFS2 based RFS */
-				reg = <0x00900000 0x00700000>;
-				label = "SPI JFFS2 RFS";
+			partition@fs {
+				label = "file system";
+				reg = <0x00700000 0x00900000>;
 			};
 		};
 	};
diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index 4d52bce..d47ae13 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -159,38 +159,24 @@
 				reg = <0>;
 				spi-max-frequency = <40000000>;
 
-				partition@0 {
-					/* 512KB for u-boot Bootloader Image */
-					reg = <0x0 0x00080000>;
-					label = "SPI (RO) U-Boot Image";
+				partition@u-boot {
+					label = "u-boot";
+					reg = <0x00000000 0x00100000>;
 					read-only;
 				};
-
-				partition@80000 {
-					/* 512KB for DTB Image */
-					reg = <0x00080000 0x00080000>;
-					label = "SPI (RO) DTB Image";
-					read-only;
-				};
-
-				partition@100000 {
-					/* 4MB for Linux Kernel Image */
-					reg = <0x00100000 0x00400000>;
-					label = "SPI (RO) Linux Kernel Image";
+				partition@dtb {
+					label = "dtb";
+					reg = <0x00180000 0x00080000>;
 					read-only;
 				};
-
-				partition@500000 {
-					/* 4MB for Compressed RFS Image */
-					reg = <0x00500000 0x00400000>;
-					label = "SPI (RO) Compressed RFS Image";
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00200000 0x00500000>;
 					read-only;
 				};
-
-				partition@900000 {
-					/* 7MB for JFFS2 based RFS */
-					reg = <0x00900000 0x00700000>;
-					label = "SPI (RW) JFFS2 RFS";
+				partition@fs {
+					label = "file system";
+					reg = <0x00700000 0x00900000>;
 				};
 			};
 		};
diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/p2041rdb.dts
index d97ad74..6fed1ea 100644
--- a/arch/powerpc/boot/dts/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/p2041rdb.dts
@@ -64,14 +64,14 @@
 					reg = <0x00000000 0x00100000>;
 					read-only;
 				};
-				partition@kernel {
-					label = "kernel";
-					reg = <0x00100000 0x00500000>;
-					read-only;
-				};
 				partition@dtb {
 					label = "dtb";
-					reg = <0x00600000 0x00100000>;
+					reg = <0x00180000 0x00080000>;
+					read-only;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00200000 0x00500000>;
 					read-only;
 				};
 				partition@fs {
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index 2fed3bc..74a3b7e 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -64,14 +64,14 @@
 					reg = <0x00000000 0x00100000>;
 					read-only;
 				};
-				partition@kernel {
-					label = "kernel";
-					reg = <0x00100000 0x00500000>;
-					read-only;
-				};
 				partition@dtb {
 					label = "dtb";
-					reg = <0x00600000 0x00100000>;
+					reg = <0x00180000 0x00080000>;
+					read-only;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00200000 0x00500000>;
 					read-only;
 				};
 				partition@fs {
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 1cf6148..06525b3 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -65,14 +65,14 @@
 					reg = <0x00000000 0x00100000>;
 					read-only;
 				};
-				partition@kernel {
-					label = "kernel";
-					reg = <0x00100000 0x00500000>;
-					read-only;
-				};
 				partition@dtb {
 					label = "dtb";
-					reg = <0x00600000 0x00100000>;
+					reg = <0x00180000 0x00080000>;
+					read-only;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00200000 0x00500000>;
 					read-only;
 				};
 				partition@fs {
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index 2869fea..b0615a3 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/p5020ds.dts
@@ -64,14 +64,14 @@
 					reg = <0x00000000 0x00100000>;
 					read-only;
 				};
-				partition@kernel {
-					label = "kernel";
-					reg = <0x00100000 0x00500000>;
-					read-only;
-				};
 				partition@dtb {
 					label = "dtb";
-					reg = <0x00600000 0x00100000>;
+					reg = <0x00180000 0x00080000>;
+					read-only;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00200000 0x00500000>;
 					read-only;
 				};
 				partition@fs {
diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/p5040ds.dts
index 860b5cc..1a3a994 100644
--- a/arch/powerpc/boot/dts/p5040ds.dts
+++ b/arch/powerpc/boot/dts/p5040ds.dts
@@ -62,14 +62,17 @@
 				partition@u-boot {
 					label = "u-boot";
 					reg = <0x00000000 0x00100000>;
-				};
-				partition@kernel {
-					label = "kernel";
-					reg = <0x00100000 0x00500000>;
+					read-only;
 				};
 				partition@dtb {
 					label = "dtb";
-					reg = <0x00600000 0x00100000>;
+					reg = <0x00180000 0x00080000>;
+					read-only;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00200000 0x00500000>;
+					read-only;
 				};
 				partition@fs {
 					label = "file system";
-- 
1.8.0
