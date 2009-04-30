Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 16301DE77E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 09:48:32 +1000 (EST)
Date: Fri, 1 May 2009 03:48:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 7/9] spi_mpc83xx: Remove dead code
Message-ID: <20090430234830.GG7901@oksana.dev.rtsoft.ru>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes #if 0'ed code, and spi_mpc83xx->busy variable that
is used by that dead snippet only.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/spi_mpc83xx.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 50112a5..4192ce4 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -98,8 +98,6 @@ struct mpc83xx_spi {
 
 	bool qe_mode;
 
-	u8 busy;
-
 	struct workqueue_struct *workqueue;
 	struct work_struct work;
 
@@ -411,7 +409,6 @@ static void mpc83xx_spi_work(struct work_struct *work)
 						       work);
 
 	spin_lock_irq(&mpc83xx_spi->lock);
-	mpc83xx_spi->busy = 1;
 	while (!list_empty(&mpc83xx_spi->queue)) {
 		struct spi_message *m = container_of(mpc83xx_spi->queue.next,
 						   struct spi_message, queue);
@@ -423,7 +420,6 @@ static void mpc83xx_spi_work(struct work_struct *work)
 
 		spin_lock_irq(&mpc83xx_spi->lock);
 	}
-	mpc83xx_spi->busy = 0;
 	spin_unlock_irq(&mpc83xx_spi->lock);
 }
 
@@ -482,18 +478,6 @@ static int mpc83xx_spi_setup(struct spi_device *spi)
 	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u Hz\n",
 		__func__, spi->mode & (SPI_CPOL | SPI_CPHA),
 		spi->bits_per_word, spi->max_speed_hz);
-#if 0 /* Don't think this is needed */
-	/* NOTE we _need_ to call chipselect() early, ideally with adapter
-	 * setup, unless the hardware defaults cooperate to avoid confusion
-	 * between normal (active low) and inverted chipselects.
-	 */
-
-	/* deselect chip (low or high) */
-	spin_lock(&mpc83xx_spi->lock);
-	if (!mpc83xx_spi->busy)
-		mpc83xx_spi_chipselect(spi, BITBANG_CS_INACTIVE);
-	spin_unlock(&mpc83xx_spi->lock);
-#endif
 	return 0;
 }
 
-- 
1.6.2.2
