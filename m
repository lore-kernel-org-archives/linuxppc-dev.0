Return-Path: <meador_inge@mentor.com>
From: Meador Inge <meador_inge@mentor.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 4/4] powerpc: Replacing "protected-sources" with
	"pic-no-reset" in DTS files
Date: Fri,  4 Feb 2011 17:25:41 -0600
Message-Id: <1296861941-3370-5-git-send-email-meador_inge@mentor.com>
In-Reply-To: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Hollis Blanchard <hollis_blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "protected-sources" property was being used in the AMP configured
MPC8572DS and P2020RDB DTS files.  This changeset modifies those files
to use "pic-no-reset" instead.

Signed-off-by: Meador Inge <meador_inge@mentor.com>
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |    6 +-----
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |   11 +----------
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts  |    7 +------
 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts  |    7 +------
 4 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
index 3375c2a..4f7ee6d 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
@@ -252,11 +252,7 @@
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-			protected-sources = <
-			31 32 33 37 38 39       /* enet2 enet3 */
-			76 77 78 79 26 42	/* dma2 pci2 serial*/
-			0xe4 0xe5 0xe6 0xe7	/* msi */
-			>;
+			pic-no-reset;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
index e7b477f..62fd64f 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
@@ -178,16 +178,7 @@
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-			protected-sources = <
-			18 16 10 42 45 58	/* MEM L2 mdio serial crypto */
-			29 30 34 35 36 40	/* enet0 enet1 */
-			24 25 20 21 22 23	/* pci0 pci1 dma1 */
-			43			/* i2c */
-			0x1 0x2 0x3 0x4         /* pci slot */
-			0x9 0xa 0xb 0xc         /* usb */
-			0x6 0x7 0xe 0x5         /* Audio elgacy SATA */
-			0xe0 0xe1 0xe2 0xe3	/* msi */
-			>;
+			pic-no-reset;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
index 0fe93d0..f749cbb 100644
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
+++ b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
@@ -318,12 +318,7 @@
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-			protected-sources = <
-			42 76 77 78 79 /* serial1 , dma2 */
-			29 30 34 26 /* enet0, pci1 */
-			0xe0 0xe1 0xe2 0xe3 /* msi */
-			0xe4 0xe5 0xe6 0xe7
-			>;
+			pic-no-reset;
 		};
 
 		global-utilities@e0000 {
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
index e95a512..6ef2e64 100644
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
+++ b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
@@ -129,12 +129,7 @@
 			reg = <0x40000 0x40000>;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-			protected-sources = <
-			17 18 43 42 59 47 /*ecm, mem, i2c, serial0, spi,gpio */
-			16 20 21 22 23 28 	/* L2, dma1, USB */
-			03 35 36 40 31 32 33 	/* mdio, enet1, enet2 */
-			72 45 58 25 		/* sdhci, crypto , pci */
-			>;
+			pic-no-reset;
 		};
 
 		msi@41600 {
-- 
1.6.3.3
