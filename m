Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 32E18B723B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 06:14:46 +1000 (EST)
Date: Thu, 18 Jun 2009 00:14:08 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <pierre@ossman.eu>
Subject: [PATCH v2] sdhci: Add support for hosts that are only capable of
	1-bit transfers
Message-ID: <20090617201408.GA17909@oksana.dev.rtsoft.ru>
References: <20090611201545.GA15942@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090611201545.GA15942@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	sdhci-devel@lists.ossman.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some hosts (hardware configurations, or particular SD/MMC slots) may
not support 4-bit bus. For example, on MPC8569E-MDS boards we can
switch between serial (1-bit only) and nibble (4-bit) modes, thought
we have to disable more peripherals to work in 4-bit mode.

Along with some small core changes, this patch modifies sdhci-of
driver, so that now it looks for "sdhci,1-bit-only" property in the
device-tree, and if specified we enable a proper quirk.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Pierre,

As promised, here is a version with a quirk.
Also incorporated suggestions by Grant Likely.


Thanks,

 Documentation/powerpc/dts-bindings/fsl/esdhc.txt |    2 ++
 drivers/mmc/host/sdhci-of.c                      |    3 +++
 drivers/mmc/host/sdhci.c                         |    5 ++++-
 drivers/mmc/host/sdhci.h                         |    2 ++
 4 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
index 5093ddf..3ed3797 100644
--- a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
@@ -10,6 +10,8 @@ Required properties:
   - interrupts : should contain eSDHC interrupt.
   - interrupt-parent : interrupt source phandle.
   - clock-frequency : specifies eSDHC base clock frequency.
+  - sdhci,1-bit-only : (optional) specifies that a controller can
+    only handle 1-bit data transfers.
 
 Example:
 
diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 09cc597..dd65f84 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -244,6 +244,9 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 		host->ops = &sdhci_of_data->ops;
 	}
 
+	if (of_get_property(np, "sdhci,1-bit-only", NULL))
+		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
+
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
 		of_host->clock = *clk;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9234be2..f28f94a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1721,7 +1721,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->ops = &sdhci_ops;
 	mmc->f_min = host->max_clk / 256;
 	mmc->f_max = host->max_clk;
-	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
+	mmc->caps = MMC_CAP_SDIO_IRQ;
+
+	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
+		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 65c6f99..834f877 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -226,6 +226,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<19)
 /* Controller has to be forced to use block size of 2048 bytes */
 #define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
+/* Controller can only handle 1-bit data transfers */
+#define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<21)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.6.3.1
