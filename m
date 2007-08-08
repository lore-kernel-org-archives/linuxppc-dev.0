Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1B33DDDEBC
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 03:07:42 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id A1D2C8810
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 22:07:40 +0500 (SAMST)
Date: Wed, 8 Aug 2007 21:09:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 1/2] [POWERPC] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Message-ID: <20070808170921.GA21487@localhost.localdomain>
References: <20070808170728.GA21118@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070808170728.GA21118@localhost.localdomain>
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
 arch/powerpc/boot/dts/mpc832x_rdb.dts     |    4 ++-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |   52 +++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index e9c332f..664dd16 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -207,15 +207,17 @@
 
 		spi@4c0 {
 			device_type = "spi";
+			fsl,device-id = <1>;
 			compatible = "fsl_spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
-			mode = "cpu";
+			mode = "cpu-qe";
 		};
 
 		spi@500 {
 			device_type = "spi";
+			fsl,device-id = <2>;
 			compatible = "fsl_spi";
 			reg = <500 40>;
 			interrupts = <1>;
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 93ba957..89cc039 100644
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
@@ -32,6 +34,56 @@
 #define DBG(fmt...)
 #endif
 
+extern int par_io_data_set(u8 port, u8 pin, u8 val);
+extern int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
+			     int assignment, int has_irq);
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
+	.chip_select = 0,
+	.max_speed_hz = 50000000,
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
+	par_io_config_pin(3,  0, 3, 0, 1, 0); /* SPI1 MOSI, I/O */
+	par_io_config_pin(3,  1, 3, 0, 1, 0); /* SPI1 MISO, I/O */
+	par_io_config_pin(3,  2, 3, 0, 1, 0); /* SPI1 CLK,  I/O */
+	par_io_config_pin(3,  3, 2, 0, 1, 0); /* SPI1 SEL,  I   */
+
+	par_io_config_pin(3, 13, 1, 0, 0, 0); /* !SD_CS,    O */
+	par_io_config_pin(3, 14, 2, 0, 0, 0); /* SD_INSERT, I */
+	par_io_config_pin(3, 15, 2, 0, 0, 0); /* SD_PROTECT,I */
+
+	return fsl_spi_init(&fsl_spi_board_info);
+}
+
+device_initcall(mpc832x_spi_init);
+
 /* ************************************************************************
  *
  * Setup the architecture
-- 
1.5.0.6
