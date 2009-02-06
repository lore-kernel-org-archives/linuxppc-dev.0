Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9A942DDEEB
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 05:06:58 +1100 (EST)
Date: Fri, 6 Feb 2009 21:06:55 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH 07/11] sdhci: Add quirk to suppress PIO interrupts during
	DMA transfers
Message-ID: <20090206180655.GG11548@oksana.dev.rtsoft.ru>
References: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
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

Some hosts (that is, FSL eSDHC) throw PIO interrupts during DMA
transfers, this causes tons of unneeded interrupts, and thus highly
degraded speed.

This patch adds SDHCI_QUIRK_PIO_IRQS_DURING_DMA quirk. When specified,
the sdhci driver will disable PIO interrupts during DMA transfers.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci.c |   32 ++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |    3 +++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9b43588..ede3790 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -167,6 +167,8 @@ static void sdhci_init(struct sdhci_host *host)
 
 	sdhci_writel(host, intmask, SDHCI_INT_ENABLE);
 	sdhci_writel(host, intmask, SDHCI_SIGNAL_ENABLE);
+
+	host->flags &= ~SDHCI_PIO_DISABLED;
 }
 
 static void sdhci_activate_led(struct sdhci_host *host)
@@ -594,6 +596,33 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_data *data)
 	return count;
 }
 
+static void sdhci_set_pio_irqs(struct sdhci_host *host, bool state)
+{
+	bool current_state = !(host->flags & SDHCI_PIO_DISABLED);
+	u32 ier;
+
+	/*
+	 * We only care about PIO IRQs if the host issues PIO IRQs during
+	 * DMA transfers. Otherwise we can keep the irqs always enabled.
+	 */
+	if (!(host->quirks & SDHCI_QUIRK_PIO_IRQS_DURING_DMA))
+		return;
+
+	if (current_state == state)
+		return;
+
+	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
+	if (state) {
+		ier |= SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL;
+		host->flags &= ~SDHCI_PIO_DISABLED;
+	} else {
+		ier &= ~(SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL);
+		host->flags |= SDHCI_PIO_DISABLED;
+	}
+	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+}
+
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 {
 	u8 count;
@@ -740,6 +769,9 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 		sg_miter_start(&host->sg_miter,
 			data->sg, data->sg_len, SG_MITER_ATOMIC);
 		host->blocks = data->blocks;
+		sdhci_set_pio_irqs(host, true);
+	} else {
+		sdhci_set_pio_irqs(host, false);
 	}
 
 	/* We do not handle DMA boundaries, so set it to max (512 KiB) */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c4edd52..2e8dfd1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -235,6 +235,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<17)
 /* Controller has all registers of 32 bit width */
 #define SDHCI_QUIRK_32BIT_REGISTERS			(1<<18)
+/* Controller issues PIO interrupts during DMA transfers */
+#define SDHCI_QUIRK_PIO_IRQS_DURING_DMA			(1<<19)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
@@ -256,6 +258,7 @@ struct sdhci_host {
 #define SDHCI_USE_ADMA		(1<<1)		/* Host is ADMA capable */
 #define SDHCI_REQ_USE_DMA	(1<<2)		/* Use DMA for this req. */
 #define SDHCI_DEVICE_DEAD	(1<<3)		/* Device unresponsive */
+#define SDHCI_PIO_DISABLED	(1<<4)		/* PIO IRQs disabled */
 
 	unsigned int		version;	/* SDHCI spec. version */
 
-- 
1.5.6.5
