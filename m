Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E7A02DDDD6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 04:03:06 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 9402D8810
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 21:03:05 +0400 (SAMT)
Date: Tue, 13 Nov 2007 20:00:11 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] [POWERPC] mpc832x_rdb: remove spidev stub, use mmc_spi
Message-ID: <20071113170011.GA23979@localhost.localdomain>
References: <20071113165825.GA23739@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071113165825.GA23739@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mmc_spi has hit the mainline, so we can start using it.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index fbca336..d4bd040 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -15,7 +15,10 @@
  */
 
 #include <linux/pci.h>
+#include <linux/interrupt.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/mmc_spi.h>
+#include <linux/mmc/host.h>
 
 #include <asm/of_platform.h>
 #include <asm/time.h>
@@ -46,15 +49,16 @@ static void mpc83xx_spi_deactivate_cs(u8 cs, u8 polarity)
 	par_io_data_set(3, 13, !polarity);
 }
 
+static struct mmc_spi_platform_data mpc832x_mmc_pdata = {
+	.ocr_mask = MMC_VDD_33_34,
+};
+
 static struct spi_board_info mpc832x_spi_boardinfo = {
 	.bus_num = 0x4c0,
 	.chip_select = 0,
 	.max_speed_hz = 50000000,
-	/*
-	 * XXX: This is spidev (spi in userspace) stub, should
-	 * be replaced by "mmc_spi" when mmc_spi will hit mainline.
-	 */
-	.modalias = "spidev",
+	.modalias = "mmc_spi",
+	.platform_data = &mpc832x_mmc_pdata,
 };
 
 static int __init mpc832x_spi_init(void)
-- 
1.5.2.2
