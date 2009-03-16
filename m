Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 970F3DE2E5
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 08:14:03 +1100 (EST)
Date: Tue, 17 Mar 2009 00:14:02 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH 09/11] sdhci: Add quirk for controllers that need IRQ
	re-init after reset
Message-ID: <20090316211402.GI9375@oksana.dev.rtsoft.ru>
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

FSL eSDHC controllers losing signal/interrupt enable states after
reset, so we should re-enable them.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci.c |    7 +++++++
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cd6dab3..3a72fe2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -134,6 +134,7 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
 static void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	unsigned long timeout;
+	u32 uninitialized_var(ier);
 
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
 		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
@@ -141,6 +142,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 			return;
 	}
 
+	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
+		ier = sdhci_readl(host, SDHCI_INT_ENABLE);
+
 	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
 
 	if (mask & SDHCI_RESET_ALL)
@@ -160,6 +164,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 		timeout--;
 		mdelay(1);
 	}
+
+	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
+		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
 }
 
 static void sdhci_init(struct sdhci_host *host)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c5ce9ee..2962102 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -222,6 +222,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NONSTANDARD_CLOCK			(1<<17)
 /* Controller does not like fast PIO transfers */
 #define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
+/* Controller losing signal/interrupt enable states after reset */
+#define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<19)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.5.6.5
