Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1B04EDDE0C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 23:58:00 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id BB8FC8814
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:57:58 +0500 (SAMST)
Date: Thu, 26 Jul 2007 17:57:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] MPC832x_RDB: update dts to use spi, register mmc_spi stub
Message-ID: <20070726135738.GB5643@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mmc_spi already tested to work. When it will hit mainline
the only change that would be needed is replacing "spidev"
by "mmc_spi", and adding trivial platform data to mmc_spi
driver.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc832x_rdb.dts     |   33 ++++++++++++++++++++-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |   46 +++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 7c4beff..5dcbdd3 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -183,6 +183,21 @@
 					1  c  1  0  1  0 	/* TX_EN */
 					1  d  2  0  1  0>;      /* CRS */
 			};
+			spi1pio:spi_pin@01 {
+				pio-map = <
+			/* port  pin  dir  open_drain  assignment  has_irq    */
+					3  0  3  0  1  0	/* SPI1 MOSI, I/O */
+					3  1  3  0  1  0	/* SPI1 MISO, I/O */
+					3  2  3  0  1  0	/* SPI1 CLK,  I/O */
+					3  3  2  0  1  0>;	/* SPI1 SEL,  I   */
+			};
+			mmc1pio:mmc_pin@01 {
+				pio-map = <
+			/* port  pin  dir  open_drain  assignment  has_irq    */
+					3  d  1  0  0  0	/* !SD_CS     */
+					3  e  2  0  0  0	/* SD_INSERT  */
+					3  f  2  0  0  0>;	/* SD_PROTECT */
+			};
 		};
 	};
 
@@ -207,20 +222,36 @@
 
 		spi@4c0 {
 			device_type = "spi";
+			device-id = <1>;
 			compatible = "fsl_spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
-			mode = "cpu";
+			mode = "qe";
+			sysclk = <5f5e100>; /* 100000000 Hz */
+			max-chipselect = <1>;
+			pio-handle = <&spi1pio>;
+
+			mmc@01 {
+				device_type = "mmc";
+				compatible = "mmc-spi";
+				device-id = <1>;
+				max-speed-hz = <bebc20>; /* 12500000 Hz */
+				chip-select = <0>;
+				pio-handle = <&mmc1pio>;
+			};
 		};
 
 		spi@500 {
 			device_type = "spi";
+			device-id = <2>;
 			compatible = "fsl_spi";
 			reg = <500 40>;
 			interrupts = <1>;
 			interrupt-parent = <&qeic>;
 			mode = "cpu";
+			sysclk = <5f5e100>; /* 100000000 Hz */
+			max_chipselect = <1>;
 		};
 
 		ucc@3000 {
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index b2b28a4..c5463c7 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/spi/spi.h>
 
 #include <asm/of_platform.h>
 #include <asm/time.h>
@@ -24,6 +25,7 @@
 #include <asm/qe_ic.h>
 
 #include "mpc83xx.h"
+#include "../../sysdev/fsl_soc.h"
 
 #undef DEBUG
 #ifdef DEBUG
@@ -32,6 +34,43 @@
 #define DBG(fmt...)
 #endif
 
+extern int par_io_data_set(u8 port, u8 pin, u8 val);
+
+static void mpc83xx_spi_activate_cs(u8 cs, u8 polarity)
+{
+	pr_debug("%s %d %d\n", __func__, cs, polarity);
+	par_io_data_set(3, 13, polarity);
+}
+
+static void mpc83xx_spi_deactivate_cs(u8 cs, u8 polarity)
+{
+	pr_debug("%s %d %d\n", __func__, cs, polarity);
+	par_io_data_set(3, 13, !polarity);
+}
+
+static int __init mpc83xx_spi_devices_init(void)
+{
+	struct spi_board_info spi_bi = {
+		.bus_num = 1,
+		/*
+		 * XXX: This is spidev (spi in userspace) stub, should
+		 * be replaced by "mmc_spi" when mmc_spi will hit mainline.
+		 */
+		.modalias = "spidev",
+	};
+	struct device_node *np = NULL;
+
+	np = of_find_compatible_node(np, "mmc", "mmc-spi");
+	if (!np)
+		return 0;
+
+	spi_bi.max_speed_hz = *((u32 *)of_get_property(np, "max-speed-hz", NULL));
+	spi_bi.chip_select = *((u32 *)of_get_property(np, "chip-select", NULL));
+
+	return spi_register_board_info(&spi_bi, 1);
+}
+device_initcall(mpc83xx_spi_devices_init);
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -62,8 +101,15 @@ static void __init mpc832x_rdb_setup_arch(void)
 
 		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
 			par_io_of_config(np);
+		for (np = NULL; (np = of_find_node_by_name(np, "spi")) != NULL;)
+			par_io_of_config(np);
+		for (np = NULL; (np = of_find_node_by_name(np, "mmc")) != NULL;)
+			par_io_of_config(np);
 	}
 #endif				/* CONFIG_QUICC_ENGINE */
+
+	fsl_spi_activate_cs = mpc83xx_spi_activate_cs;
+	fsl_spi_deactivate_cs = mpc83xx_spi_deactivate_cs;
 }
 
 static struct of_device_id mpc832x_ids[] = {
-- 
1.5.0.6
