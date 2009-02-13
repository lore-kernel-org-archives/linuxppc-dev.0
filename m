Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 127C3DDEE1
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 01:47:37 +1100 (EST)
Date: Fri, 13 Feb 2009 17:47:35 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH 10/13] sdhci: Add quirk for controllers that need small
	delays for PIO
Message-ID: <20090213144735.GJ23889@oksana.dev.rtsoft.ru>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
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

Small udelay is needed to make eSDHC work in PIO mode. Without
the delay reading causes endless interrupt storm, and writing
corrupts data. The first guess would be that we must wait for
some bit in some register, but I didn't find any reliable bits
that change before and after the delay.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci.c |    3 +++
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f63db25..eff615d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -391,6 +391,9 @@ static void sdhci_transfer_pio(struct sdhci_host *host)
 		mask = ~0;
 
 	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
+		if (host->quirks & SDHCI_QUIRK_PIO_NEEDS_DELAY)
+			udelay(100);
+
 		if (host->data->flags & MMC_DATA_READ)
 			sdhci_read_block_pio(host);
 		else
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 63b436a..44c820a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -227,6 +227,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_32BIT_REGISTERS			(1<<18)
 /* Controller has nonstandard clock management */
 #define SDHCI_QUIRK_NONSTANDARD_CLOCK			(1<<19)
+/* Controller does not like fast PIO transfers */
+#define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<20)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.5.6.5
