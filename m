Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6476EDEA1E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 04:47:51 +1000 (EST)
Date: Wed, 21 May 2008 22:47:50 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: [PATCH 1/2] mmc: add support for card-detection polling
Message-ID: <20080521184750.GA32052@polina.dev.rtsoft.ru>
References: <20080521184713.GA30284@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080521184713.GA30284@polina.dev.rtsoft.ru>
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

Some hosts (and boards that use mmc_spi) do not use interrupts on the CD
line, so they can't trigger mmc_detect_change. We want to poll the card
and see if there was a change. 1 second poll interval seems resonable.

This patch also implements .get_cd() host operation, that could be used
by the hosts that are able to report card-detect status without need to
talk MMC.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/core/core.c  |   19 ++++++++++++++++---
 include/linux/mmc/host.h |    3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 01ced4c..e455ebd 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -631,6 +631,16 @@ void mmc_rescan(struct work_struct *work)
 
 	mmc_bus_get(host);
 
+	if (host->ops->get_cd) {
+		int old_cd_status = host->cd_status;
+
+		host->cd_status = !!host->ops->get_cd(host);
+		if (!(old_cd_status ^ host->cd_status)) {
+			mmc_bus_put(host);
+			goto out;
+		}
+	}
+
 	if (host->bus_ops == NULL) {
 		/*
 		 * Only we can add a new handler, so it's safe to
@@ -652,7 +662,7 @@ void mmc_rescan(struct work_struct *work)
 		if (!err) {
 			if (mmc_attach_sdio(host, ocr))
 				mmc_power_off(host);
-			return;
+			goto out;
 		}
 
 		/*
@@ -662,7 +672,7 @@ void mmc_rescan(struct work_struct *work)
 		if (!err) {
 			if (mmc_attach_sd(host, ocr))
 				mmc_power_off(host);
-			return;
+			goto out;
 		}
 
 		/*
@@ -672,7 +682,7 @@ void mmc_rescan(struct work_struct *work)
 		if (!err) {
 			if (mmc_attach_mmc(host, ocr))
 				mmc_power_off(host);
-			return;
+			goto out;
 		}
 
 		mmc_release_host(host);
@@ -683,6 +693,9 @@ void mmc_rescan(struct work_struct *work)
 
 		mmc_bus_put(host);
 	}
+out:
+	if (host->caps & MMC_CAP_NEEDS_POLL)
+		mmc_schedule_delayed_work(&host->detect, HZ);
 }
 
 void mmc_start_host(struct mmc_host *host)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7ab962f..05d03a4 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -53,6 +53,7 @@ struct mmc_host_ops {
 	void	(*request)(struct mmc_host *host, struct mmc_request *req);
 	void	(*set_ios)(struct mmc_host *host, struct mmc_ios *ios);
 	int	(*get_ro)(struct mmc_host *host);
+	int	(*get_cd)(struct mmc_host *host);
 	void	(*enable_sdio_irq)(struct mmc_host *host, int enable);
 };
 
@@ -94,6 +95,7 @@ struct mmc_host {
 #define MMC_CAP_SD_HIGHSPEED	(1 << 3)	/* Can do SD high-speed timing */
 #define MMC_CAP_SDIO_IRQ	(1 << 4)	/* Can signal pending SDIO IRQs */
 #define MMC_CAP_SPI		(1 << 5)	/* Talks only SPI protocols */
+#define MMC_CAP_NEEDS_POLL	(1 << 6)	/* Needs polling for card-detection */
 
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
@@ -114,6 +116,7 @@ struct mmc_host {
 	unsigned int		use_spi_crc:1;
 	unsigned int		claimed:1;	/* host exclusively claimed */
 	unsigned int		bus_dead:1;	/* bus has been released */
+	unsigned int		cd_status:1;	/* card-detect status */
 #ifdef CONFIG_MMC_DEBUG
 	unsigned int		removed:1;	/* host is being removed */
 #endif
-- 
1.5.5.1
