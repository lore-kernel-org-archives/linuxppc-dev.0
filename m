Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2EEA5474C7
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 13:00:32 +1100 (EST)
Date: Thu, 22 Jan 2009 05:00:26 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH 04/10] sdhci: Add support for hosts reporting inverted
	write-protect state
Message-ID: <20090122020026.GD11492@oksana.dev.rtsoft.ru>
References: <20090122015649.GA6835@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090122015649.GA6835@oksana.dev.rtsoft.ru>
Cc: sdhci-devel@list.drzeus.cx, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, Liu Dave <DaveLiu@freescale.com>,
	Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>,
	linuxppc-dev@ozlabs.org, Konjin Lai <Konjin.Lai@freescale.com>,
	Ben Dooks <ben-linux@fluff.org>, Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds SDHCI_QUIRK_INVERTED_WRITE_PROTECT quirk. When
specified, the sdhci driver will invert WP state.

p.s. Actually, the quirk is more board-specific than
     controller-specific.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci.c |    2 ++
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5a7a584..63809f5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1114,6 +1114,8 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
+	if (host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT)
+		return !!(present & SDHCI_WRITE_PROTECT);
 	return !(present & SDHCI_WRITE_PROTECT);
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f357722..9cd2b78 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -215,6 +215,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NO_BUSY_IRQ				(1<<15)
 /* Controller has unreliable card detection */
 #define SDHCI_QUIRK_BROKEN_CARD_DETECTION		(1<<16)
+/* Controller reports inverted write-protect state */
+#define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<17)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.5.6.5
