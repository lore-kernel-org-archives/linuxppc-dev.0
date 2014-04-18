Return-Path: <Lijun.Pan@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BCD411400E0
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2014 03:20:59 +1000 (EST)
Received: from mail7-am1 (localhost [127.0.0.1])	by mail7-am1-R.bigfish.com
 (Postfix) with ESMTP id EC52B1C0266	for <linuxppc-dev@ozlabs.org>; Fri, 18
 Apr 2014 17:20:06 +0000 (UTC)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/mpc85xx: Remove P1023 RDS support
Date: Fri, 18 Apr 2014 12:18:00 -0500
Message-ID: <1397841480-2652-1-git-send-email-Lijun.Pan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lijun Pan <Lijun.Pan@freescale.com>, Emilian.Medve@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P1023RDS is no longer supported by Freescale while P1023RDB is still supported.

Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
---
 arch/powerpc/boot/dts/p1023rds.dts                 | 219 ---------------------
 arch/powerpc/configs/mpc85xx_defconfig             |   1 -
 arch/powerpc/configs/mpc85xx_smp_defconfig         |   1 -
 arch/powerpc/platforms/85xx/Kconfig                |   6 +-
 arch/powerpc/platforms/85xx/Makefile               |   2 +-
 .../platforms/85xx/{p1023_rds.c => p1023_rdb.c}    |  36 +---
 6 files changed, 10 insertions(+), 255 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/p1023rds.dts
 rename arch/powerpc/platforms/85xx/{p1023_rds.c => p1023_rdb.c} (75%)

diff --git a/arch/powerpc/boot/dts/p1023rds.dts b/arch/powerpc/boot/dts/p1023rds.dts
deleted file mode 100644
index beb6cb1..0000000
--- a/arch/powerpc/boot/dts/p1023rds.dts
+++ /dev/null
@@ -1,219 +0,0 @@
-/*
- * P1023 RDS Device Tree Source
- *
- * Copyright 2010-2011 Freescale Semiconductor Inc.
- *
- * Author: Roy Zang <tie-fei.zang@freescale.com>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-/include/ "fsl/p1023si-pre.dtsi"
-
-/ {
-	model = "fsl,P1023";
-	compatible = "fsl,P1023RDS";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	memory {
-		device_type = "memory";
-	};
-
-	soc: soc@ff600000 {
-		ranges = <0x0 0x0 0xff600000 0x200000>;
-
-		i2c@3000 {
-			rtc@68 {
-				compatible = "dallas,ds1374";
-				reg = <0x68>;
-			};
-		};
-
-		spi@7000 {
-			fsl_dataflash@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "atmel,at45db081d";
-				reg = <0>;
-				spi-max-frequency = <40000000>; /* input clock */
-				partition@u-boot {
-					/* 512KB for u-boot Bootloader Image */
-					label = "u-boot-spi";
-					reg = <0x00000000 0x00080000>;
-					read-only;
-				};
-				partition@dtb {
-					/* 512KB for DTB Image */
-					label = "dtb-spi";
-					reg = <0x00080000 0x00080000>;
-					read-only;
-				};
-			};
-		};
-
-		usb@22000 {
-			dr_mode = "host";
-			phy_type = "ulpi";
-		};
-	};
-
-	lbc: localbus@ff605000 {
-		reg = <0 0xff605000 0 0x1000>;
-
-		/* NOR Flash, BCSR */
-		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
-			  0x1 0x0 0x0 0xe0000000 0x00008000>;
-
-		nor@0,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "cfi-flash";
-			reg = <0x0 0x0 0x02000000>;
-			bank-width = <2>;
-			device-width = <1>;
-			partition@0 {
-				label = "ramdisk";
-				reg = <0x00000000 0x01c00000>;
-			};
-			partition@1c00000 {
-				label = "kernel";
-				reg = <0x01c00000 0x002e0000>;
-			};
-			partiton@1ee0000 {
-				label = "dtb";
-				reg = <0x01ee0000 0x00020000>;
-			};
-			partition@1f00000 {
-				label = "firmware";
-				reg = <0x01f00000 0x00080000>;
-				read-only;
-			};
-			partition@1f80000 {
-				label = "u-boot";
-				reg = <0x01f80000 0x00080000>;
-				read-only;
-			};
-		};
-
-		fpga@1,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,p1023rds-fpga";
-			reg = <1 0 0x8000>;
-			ranges = <0 1 0 0x8000>;
-
-			bcsr@20 {
-				compatible = "fsl,p1023rds-bcsr";
-				reg = <0x20 0x20>;
-			};
-		};
-	};
-
-	pci0: pcie@ff60a000 {
-		reg = <0 0xff60a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
-		pcie@0 {
-			/* IRQ[0:3] are pulled up on board, set to active-low */
-			interrupt-map-mask = <0xf800 0 0 7>;
-			interrupt-map = <
-				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 0 1 0 0
-				0000 0 0 2 &mpic 1 1 0 0
-				0000 0 0 3 &mpic 2 1 0 0
-				0000 0 0 4 &mpic 3 1 0 0
-				>;
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
-
-	board_pci1: pci1: pcie@ff609000 {
-		reg = <0 0xff609000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		pcie@0 {
-			/*
-			 * IRQ[4:6] only for PCIe, set to active-high,
-			 * IRQ[7] is pulled up on board, set to active-low
-			 */
-			interrupt-map-mask = <0xf800 0 0 7>;
-			interrupt-map = <
-				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 4 2 0 0
-				0000 0 0 2 &mpic 5 2 0 0
-				0000 0 0 3 &mpic 6 2 0 0
-				0000 0 0 4 &mpic 7 1 0 0
-				>;
-			ranges = <0x2000000 0x0 0xa0000000
-				  0x2000000 0x0 0xa0000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
-
-	pci2: pcie@ff60b000 {
-		reg = <0 0xff60b000 0 0x1000>;
-		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
-		pcie@0 {
-			/*
-			 * IRQ[8:10] are pulled up on board, set to active-low
-			 * IRQ[11] only for PCIe, set to active-high,
-			 */
-			interrupt-map-mask = <0xf800 0 0 7>;
-			interrupt-map = <
-				/* IDSEL 0x0 */
-				0000 0 0 1 &mpic 8 1 0 0
-				0000 0 0 2 &mpic 9 1 0 0
-				0000 0 0 3 &mpic 10 1 0 0
-				0000 0 0 4 &mpic 11 2 0 0
-				>;
-			ranges = <0x2000000 0x0 0x80000000
-				  0x2000000 0x0 0x80000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
-};
-
-/include/ "fsl/p1023si-post.dtsi"
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 19f0fbe..55765c8 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -32,7 +32,6 @@ CONFIG_P1010_RDB=y
 CONFIG_P1022_DS=y
 CONFIG_P1022_RDK=y
 CONFIG_P1023_RDB=y
-CONFIG_P1023_RDS=y
 CONFIG_SOCRATES=y
 CONFIG_KSI8560=y
 CONFIG_XES_MPC85xx=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 062312e..5c6ecdc 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -35,7 +35,6 @@ CONFIG_P1010_RDB=y
 CONFIG_P1022_DS=y
 CONFIG_P1022_RDK=y
 CONFIG_P1023_RDB=y
-CONFIG_P1023_RDS=y
 CONFIG_SOCRATES=y
 CONFIG_KSI8560=y
 CONFIG_XES_MPC85xx=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index c17aae8..f049c2a 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -117,11 +117,11 @@ config P1022_RDK
 	  This option enables support for the Freescale / iVeia P1022RDK
 	  reference board.
 
-config P1023_RDS
-	bool "Freescale P1023 RDS/RDB"
+config P1023_RDB
+	bool "Freescale P1023 RDB"
 	select DEFAULT_UIMAGE
 	help
-	  This option enables support for the P1023 RDS and RDB boards
+	  This option enables support for the P1023 RDB board.
 
 config TWR_P102x
 	bool "Freescale TWR-P102x"
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 25cebe7..822103e 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o
 obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P1022_RDK)   += p1022_rdk.o
-obj-$(CONFIG_P1023_RDS)   += p1023_rds.o
+obj-$(CONFIG_P1023_RDB)   += p1023_rdb.o
 obj-$(CONFIG_TWR_P102x)   += twr_p102x.o
 obj-$(CONFIG_CORENET_GENERIC)   += corenet_generic.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rdb.c
similarity index 75%
rename from arch/powerpc/platforms/85xx/p1023_rds.c
rename to arch/powerpc/platforms/85xx/p1023_rdb.c
index 0e61400..d5b7509 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rdb.c
@@ -4,7 +4,7 @@
  * Author: Roy Zang <tie-fei.zang@freescale.com>
  *
  * Description:
- * P1023 RDS Board Setup
+ * P1023 RDB Board Setup
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -41,12 +41,12 @@
  * Setup the architecture
  *
  */
-static void __init mpc85xx_rds_setup_arch(void)
+static void __init mpc85xx_rdb_setup_arch(void)
 {
 	struct device_node *np;
 
 	if (ppc_md.progress)
-		ppc_md.progress("p1023_rds_setup_arch()", 0);
+		ppc_md.progress("p1023_rdb_setup_arch()", 0);
 
 	/* Map BCSR area */
 	np = of_find_node_by_name(NULL, "bcsr");
@@ -85,10 +85,9 @@ static void __init mpc85xx_rds_setup_arch(void)
 	fsl_pci_assign_primary();
 }
 
-machine_arch_initcall(p1023_rds, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1023_rdb, mpc85xx_common_publish_devices);
 
-static void __init mpc85xx_rds_pic_init(void)
+static void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
 		MPIC_SINGLE_DEST_CPU,
@@ -99,14 +98,6 @@ static void __init mpc85xx_rds_pic_init(void)
 	mpic_init(mpic);
 }
 
-static int __init p1023_rds_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,P1023RDS");
-
-}
-
 static int __init p1023_rdb_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
@@ -115,26 +106,11 @@ static int __init p1023_rdb_probe(void)
 
 }
 
-define_machine(p1023_rds) {
-	.name			= "P1023 RDS",
-	.probe			= p1023_rds_probe,
-	.setup_arch		= mpc85xx_rds_setup_arch,
-	.init_IRQ		= mpc85xx_rds_pic_init,
-	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
-#endif
-};
-
 define_machine(p1023_rdb) {
 	.name			= "P1023 RDB",
 	.probe			= p1023_rdb_probe,
-	.setup_arch		= mpc85xx_rds_setup_arch,
-	.init_IRQ		= mpc85xx_rds_pic_init,
+	.setup_arch		= mpc85xx_rdb_setup_arch,
+	.init_IRQ		= mpc85xx_rdb_pic_init,
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
-- 
1.8.5.3
