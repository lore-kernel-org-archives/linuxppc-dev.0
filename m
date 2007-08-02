Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5933DDDDFB
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 03:36:48 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id D772C8810
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 22:36:46 +0500 (SAMST)
Date: Thu, 2 Aug 2007 21:35:36 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/2] [RFC][POWERPC] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Message-ID: <20070802173536.GA25643@localhost.localdomain>
References: <20070802173335.GA25369@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070802173335.GA25369@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mmc_spi already tested to work. When it will hit mainline
the only change that will be needed is replacing "spidev"
by "mmc_spi".

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc832x_rdb.dts     |   27 +++++++++++++-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |   55 +++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index e9c332f..5ed92ca 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -183,6 +183,21 @@
 					1  c  1  0  1  0 	/* TX_EN */
 					1  d  2  0  1  0>;      /* CRS */
 			};
+			spi1pio: spi_pin@1 {
+				pio-map = <
+			/* port  pin  dir  open_drain  assignment  has_irq    */
+					3  0  3  0  1  0	/* SPI1 MOSI, I/O */
+					3  1  3  0  1  0	/* SPI1 MISO, I/O */
+					3  2  3  0  1  0	/* SPI1 CLK,  I/O */
+					3  3  2  0  1  0>;	/* SPI1 SEL,  I   */
+			};
+			mmc0pio: mmc_pin@0 {
+				pio-map = <
+			/* port  pin  dir  open_drain  assignment  has_irq    */
+					3  d  1  0  0  0	/* !SD_CS     */
+					3  e  2  0  0  0	/* SD_INSERT  */
+					3  f  2  0  0  0>;	/* SD_PROTECT */
+			};
 		};
 	};
 
@@ -206,16 +221,26 @@
 		};
 
 		spi@4c0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "spi";
+			fsl,device-id = <1>;
 			compatible = "fsl_spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
-			mode = "cpu";
+			mode = "cpu-qe";
+			pio-handle = <&spi1pio>;
+
+			mmc@0 {
+				reg = <0>;
+				pio-handle = <&mmc0pio>;
+			};
 		};
 
 		spi@500 {
 			device_type = "spi";
+			fsl,device-id = <2>;
 			compatible = "fsl_spi";
 			reg = <500 40>;
 			interrupts = <1>;
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 93ba957..4cc938f 100644
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
@@ -32,6 +34,55 @@
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
+static struct spi_board_info mpc832x_spi_boardinfo = {
+	.bus_num = 1,
+	/*
+	 * XXX: This is spidev (spi in userspace) stub, should
+	 * be replaced by "mmc_spi" when mmc_spi will hit mainline.
+	 */
+	.modalias = "spidev",
+};
+
+static struct fsl_spi_board_info fsl_spi_board_info = {
+	.activate_cs = mpc83xx_spi_activate_cs,
+	.deactivate_cs = mpc83xx_spi_deactivate_cs,
+	.board_infos = &mpc832x_spi_boardinfo,
+	.num_board_infos = 1,
+};
+
+static int __init mpc832x_spi_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_name(NULL, "mmc");
+	if (!np) {
+		printk(KERN_ERR "%s: could not find mmc node\n", __func__);
+		return -ENODEV;
+	}
+
+	mpc832x_spi_boardinfo.chip_select = *((u32 *)of_get_property(np,
+								"reg", NULL));
+	mpc832x_spi_boardinfo.max_speed_hz = 50000000;
+
+	return fsl_spi_init(&fsl_spi_board_info);
+}
+
+device_initcall(mpc832x_spi_init);
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -62,6 +113,10 @@ static void __init mpc832x_rdb_setup_arch(void)
 
 		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
 			par_io_of_config(np);
+		for (np = NULL; (np = of_find_node_by_name(np, "spi")) != NULL;)
+			par_io_of_config(np);
+		for (np = NULL; (np = of_find_node_by_name(np, "mmc")) != NULL;)
+			par_io_of_config(np);
 	}
 #endif				/* CONFIG_QUICC_ENGINE */
 }
-- 
1.5.0.6
