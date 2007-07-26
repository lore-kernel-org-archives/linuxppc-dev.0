Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2D0FFDE1D9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 23:14:53 +1000 (EST)
Date: Thu, 26 Jul 2007 17:14:31 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH 4/4] [POWERPC][SPI] spi_mpc83xx: fix LSB mode shifts
Message-ID: <20070726131431.GD3417@localhost.localdomain>
References: <20070726131134.GA3309@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070726131134.GA3309@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

spi_mpc83xx should use other shifts when running in QE+LSB mode.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/spi_mpc83xx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 7e17c8b..458075a 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -237,6 +237,14 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	} else
 		return -EINVAL;
 
+	if (mpc83xx_spi->qe_mode && spi->mode & SPI_LSB_FIRST) {
+		mpc83xx_spi->tx_shift = 0;
+		if (bits_per_word <= 8)
+			mpc83xx_spi->rx_shift = 8;
+		else
+			mpc83xx_spi->rx_shift = 0;
+	}
+
 	/* nsecs = (clock period)/2 */
 	if (!hz)
 		hz = spi->max_speed_hz;
-- 
1.5.0.6
