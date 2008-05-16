Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 13AB0DE3AB
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 02:50:59 +1000 (EST)
Date: Fri, 16 May 2008 20:50:57 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: [PATCH 3/4] [MMC] mmc_spi: add polling support for the card detect
	line
Message-ID: <20080516165057.GC24196@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some boards do not use interrupts on the CD line, so we want to poll
the CD and see if there was a change. 1 second poll interval seems
resonable.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/mmc_spi.c  |   51 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/mmc_spi.h |   10 ++++++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 3550858..a3b46b1 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -31,6 +31,7 @@
 #include <linux/crc7.h>
 #include <linux/crc-itu-t.h>
 #include <linux/scatterlist.h>
+#include <linux/workqueue.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>		/* for R1_SPI_* bit values */
@@ -122,6 +123,11 @@ struct mmc_spi_host {
 
 	struct mmc_spi_platform_data	*pdata;
 
+	/* stores last Card-Detect status (when polling) */
+	int			cd_status;
+	struct workqueue_struct	*cd_poll_wqueue;
+	struct delayed_work	cd_poll_work;
+
 	/* for bulk data transfers */
 	struct spi_transfer	token, t, crc, early_status;
 	struct spi_message	m;
@@ -1155,6 +1161,26 @@ mmc_spi_detect_irq(int irq, void *mmc)
 	return IRQ_HANDLED;
 }
 
+static void mmc_spi_cd_poll_work(struct work_struct *work)
+{
+	struct mmc_spi_host *host = container_of(work, struct mmc_spi_host,
+						 cd_poll_work.work);
+	struct mmc_host *mmc = host->mmc;
+	int old_cd;
+
+	dev_dbg(&host->spi->dev, "polling for card detect...\n");
+
+	old_cd = host->cd_status;
+	host->cd_status = host->pdata->get_cd(mmc->parent);
+	if (old_cd != host->cd_status) {
+		/* ugh... this is ugly, but better than code duplication */
+		mmc_spi_detect_irq(NO_IRQ, mmc);
+	}
+
+	queue_delayed_work(host->cd_poll_wqueue, &host->cd_poll_work,
+			   MMC_SPI_POLL_INT);
+}
+
 struct count_children {
 	unsigned	n;
 	struct bus_type	*bus;
@@ -1323,13 +1349,28 @@ static int mmc_spi_probe(struct spi_device *spi)
 	if (status != 0)
 		goto fail_add_host;
 
-	dev_info(&spi->dev, "SD/MMC host %s%s%s%s\n",
+	if (host->pdata && host->pdata->get_cd) {
+		host->cd_status = host->pdata->get_cd(mmc->parent);
+		INIT_DELAYED_WORK(&host->cd_poll_work, mmc_spi_cd_poll_work);
+		host->cd_poll_wqueue = create_singlethread_workqueue(
+						mmc->class_dev.bus_id);
+		if (!host->cd_poll_wqueue) {
+			status = -ENOMEM;
+			goto fail_add_host;
+		}
+		queue_delayed_work(host->cd_poll_wqueue, &host->cd_poll_work,
+				   MMC_SPI_POLL_INT);
+	}
+
+	dev_info(&spi->dev, "SD/MMC host %s%s%s%s%s\n",
 			mmc->class_dev.bus_id,
 			host->dma_dev ? "" : ", no DMA",
 			(host->pdata && host->pdata->get_ro)
 				? "" : ", no WP",
 			(host->pdata && host->pdata->setpower)
-				? "" : ", no poweroff");
+				? "" : ", no poweroff",
+			(host->pdata && host->pdata->get_cd)
+				? ", cd polling" : "");
 	return 0;
 
 fail_add_host:
@@ -1362,6 +1403,12 @@ static int __devexit mmc_spi_remove(struct spi_device *spi)
 		if (host->pdata && host->pdata->exit)
 			host->pdata->exit(&spi->dev, mmc);
 
+		if (host->pdata && host->pdata->get_cd) {
+			cancel_rearming_delayed_workqueue(
+				host->cd_poll_wqueue, &host->cd_poll_work);
+			destroy_workqueue(host->cd_poll_wqueue);
+		}
+
 		mmc_remove_host(mmc);
 
 		if (host->dma_dev) {
diff --git a/include/linux/spi/mmc_spi.h b/include/linux/spi/mmc_spi.h
index e9bbe3e..6ed6ee9 100644
--- a/include/linux/spi/mmc_spi.h
+++ b/include/linux/spi/mmc_spi.h
@@ -1,6 +1,10 @@
 #ifndef __LINUX_SPI_MMC_SPI_H
 #define __LINUX_SPI_MMC_SPI_H
 
+#include <asm/param.h> /* for HZ */
+
+#define MMC_SPI_POLL_INT HZ
+
 struct device;
 struct mmc_host;
 
@@ -21,6 +25,12 @@ struct mmc_spi_platform_data {
 	/* sense switch on sd cards */
 	int (*get_ro)(struct device *);
 
+	/*
+	 * if board does not use CD interrupts, driver can poll the CD
+	 * line using this function.
+	 */
+	int (*get_cd)(struct device *);
+
 	/* how long to debounce card detect, in msecs */
 	u16 detect_delay;
 
-- 
1.5.5.1
