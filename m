Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2BBCDE033
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:47 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 22/22] [POWERPC] MPC832x_RDB: Update dts to use SPI1 in QE,
	register mmc_spi stub
Date: Thu, 13 Sep 2007 16:08:00 -0500
Message-Id: <11897177143496-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11897177132273-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
	<1189717687832-git-send-email-galak@kernel.crashing.org>
	<11897176884163-git-send-email-galak@kernel.crashing.org>
	<1189717690413-git-send-email-galak@kernel.crashing.org>
	<1189717691261-git-send-email-galak@kernel.crashing.org>
	<11897176931664-git-send-email-galak@kernel.crashing.org>
	<118971769498-git-send-email-galak@kernel.crashing.org>
	<11897176964013-git-send-email-galak@kernel.crashing.org>
	<11897176992010-git-send-email-galak@kernel.crashing.org>
	<11897177013875-git-send-email-galak@kernel.crashing.org>
	<11897177032288-git-send-email-galak@kernel.crashing.org>
	<11897177042582-git-send-email-galak@kernel.crashing.org>
	<11897177052448-git-send-email-galak@kernel.crashing.org>
	<11897177071168-git-send-email-galak@kernel.crashing.org>
	<11897177091972-git-send-email-galak@kernel.crashing.org>
	<11897177102281-git-send-email-galak@kernel.crashing.org>
	<1189717711656-git-send-email-galak@kernel.crashing.org>
	<11897177132273-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>

mmc_spi already tested to work. When it will hit mainline
the only change that will be needed is replacing "spidev"
with "mmc_spi".

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc832x_rdb.dts     |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |   46 +++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index cdc4a94..388c8a7 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -175,7 +175,7 @@
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
-			mode = "cpu";
+			mode = "cpu-qe";
 		};
 
 		spi@500 {
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index e6c1760..24a790c 100644
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
 
@@ -32,6 +34,50 @@
 #define DBG(fmt...)
 #endif
 
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
1.5.2.4
