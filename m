Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 1B498DE308
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 08:14:05 +1100 (EST)
Date: Tue, 17 Mar 2009 00:14:03 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH 10/11] sdhci: Add quirk for forcing maximum block size to
	2048 bytes
Message-ID: <20090316211403.GJ9375@oksana.dev.rtsoft.ru>
References: <20090316211306.GA1736@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090316211306.GA1736@oksana.dev.rtsoft.ru>
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FSL eSDHC controllers can support maximum block size up to 4096 bytes,
the MBL (Maximum Block Length) field in the capabilities register
extended by one bit, and is set to 0x3.

But the SDHCI core doesn't support blocks of 4096 bytes, and thus
forces blksz to the lowest value -- 512 bytes. With this patch we can
pin up the blksz to the maximum supported block size, i.e. 2048 bytes.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci.c |   20 +++++++++++++-------
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3a72fe2..30d8e3d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1777,13 +1777,19 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * Maximum block size. This varies from controller to controller and
 	 * is specified in the capabilities register.
 	 */
-	mmc->max_blk_size = (caps & SDHCI_MAX_BLOCK_MASK) >> SDHCI_MAX_BLOCK_SHIFT;
-	if (mmc->max_blk_size >= 3) {
-		printk(KERN_WARNING "%s: Invalid maximum block size, "
-			"assuming 512 bytes\n", mmc_hostname(mmc));
-		mmc->max_blk_size = 512;
-	} else
-		mmc->max_blk_size = 512 << mmc->max_blk_size;
+	if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048) {
+		mmc->max_blk_size = 2;
+	} else {
+		mmc->max_blk_size = (caps & SDHCI_MAX_BLOCK_MASK) >>
+				SDHCI_MAX_BLOCK_SHIFT;
+		if (mmc->max_blk_size >= 3) {
+			printk(KERN_WARNING "%s: Invalid maximum block size, "
+				"assuming 512 bytes\n", mmc_hostname(mmc));
+			mmc->max_blk_size = 0;
+		}
+	}
+
+	mmc->max_blk_size = 512 << mmc->max_blk_size;
 
 	/*
 	 * Maximum block count.
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 2962102..f20a834 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -224,6 +224,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
 /* Controller losing signal/interrupt enable states after reset */
 #define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<19)
+/* Controller has to be forced to use block size of 2048 bytes */
+#define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.5.6.5
