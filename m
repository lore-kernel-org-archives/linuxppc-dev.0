Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 18E5CDE611
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 00:57:29 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id A8FCB8810
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 19:57:27 +0500 (SAMST)
Date: Wed, 22 Aug 2007 18:57:41 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 2/2] [POWERPC] MPC832x_RDB: update dts to use SPI1 in
	QE, register mmc_spi stub
Message-ID: <20070822145741.GB22686@localhost.localdomain>
References: <20070822145415.GA22595@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070822145415.GA22595@localhost.localdomain>
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
with "mmc_spi".

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc832x_rdb.dts     |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |   50 +++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index e9c332f..1ac0025 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -211,7 +211,7 @@
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
-			mode = "cpu";
+			mode = "cpu-qe";
 		};
 
 		spi@500 {
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index e021b08..305ec7d 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/spi/spi.h>
 
 #include <asm/of_platform.h>
 #include <asm/time.h>
@@ -22,6 +23,7 @@
 #include <asm/udbg.h>
 #include <asm/qe.h>
 #include <asm/qe_ic.h>
+#include <sysdev/fsl_soc.h>
 
 #include "mpc83xx.h"
 
@@ -32,6 +34,54 @@
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
+	.bus_num = 0x4c0,
+	.chip_select = 0,
+	.max_speed_hz = 50000000,
+	/*
+	 * XXX: This is spidev (spi in userspace) stub, should
+	 * be replaced by "mmc_spi" when mmc_spi will hit mainline.
+	 */
+	.modalias = "spidev",
+};
+
+static int __init mpc832x_spi_init(void)
+{
+	if (!machine_is(mpc832x_rdb))
+		return 0;
+
+	par_io_config_pin(3,  0, 3, 0, 1, 0); /* SPI1 MOSI, I/O */
+	par_io_config_pin(3,  1, 3, 0, 1, 0); /* SPI1 MISO, I/O */
+	par_io_config_pin(3,  2, 3, 0, 1, 0); /* SPI1 CLK,  I/O */
+	par_io_config_pin(3,  3, 2, 0, 1, 0); /* SPI1 SEL,  I   */
+
+	par_io_config_pin(3, 13, 1, 0, 0, 0); /* !SD_CS,    O */
+	par_io_config_pin(3, 14, 2, 0, 0, 0); /* SD_INSERT, I */
+	par_io_config_pin(3, 15, 2, 0, 0, 0); /* SD_PROTECT,I */
+
+	return fsl_spi_init(&mpc832x_spi_boardinfo, 1,
+			    mpc83xx_spi_activate_cs,
+			    mpc83xx_spi_deactivate_cs);
+}
+
+device_initcall(mpc832x_spi_init);
+
 /* ************************************************************************
  *
  * Setup the architecture
-- 
1.5.0.6
