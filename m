Return-Path: <r61911@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B30F7B71BB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Jul 2011 13:40:57 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: <linux-mmc@vger.kernel.org>
Subject: [PATCH 3/3] eSDHC: fix incorrect default value of the capabilities
	register on P4080
Date: Tue, 5 Jul 2011 12:19:03 +0800
Message-ID: <1309839543-6031-3-git-send-email-tie-fei.zang@freescale.com>
In-Reply-To: <1309839543-6031-2-git-send-email-tie-fei.zang@freescale.com>
References: <1309839543-6031-1-git-send-email-tie-fei.zang@freescale.com>
	<1309839543-6031-2-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P4080 eSDHC errata 12 describes incorrect default value of the
the host controller capabilities register.

The default value of the VS18 and VS30 fields in the host controller
capabilities register (HOSTCAPBLT) are incorrect. The default of these bits
should be zero instead of one in the eSDHC logic.

This patch adds the workaround for these errata.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 drivers/mmc/host/sdhci-of-core.c |    3 +++
 drivers/mmc/host/sdhci.c         |    6 ++++++
 include/linux/mmc/sdhci.h        |    4 ++++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index fede43d..9bdd30d 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -182,6 +182,9 @@ static int __devinit sdhci_of_probe(struct platform_device *ofdev)
 	if (of_device_is_compatible(np, "fsl,esdhc"))
 		host->quirks |= SDHCI_QUIRK_QORIQ_PROCTL_WEIRD;
 
+	if (of_device_is_compatible(np, "fsl,p4080-esdhc"))
+		host->quirks |= SDHCI_QUIRK_QORIQ_HOSTCAPBLT_ONLY_VS33;
+
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
 		of_host->clock = be32_to_cpup(clk);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 77174e5..7e0b4cd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2396,6 +2396,12 @@ int sdhci_add_host(struct sdhci_host *host)
 	caps[1] = (host->version >= SDHCI_SPEC_300) ?
 		sdhci_readl(host, SDHCI_CAPABILITIES_1) : 0;
 
+	 /* Make sure clean the VS18 and VS30 bit. P4080 incorrectly
+	  * set the voltage capability bits
+	  */
+	if (host->quirks & SDHCI_QUIRK_QORIQ_HOSTCAPBLT_ONLY_VS33)
+		caps[0] &= ~(SDHCI_CAN_VDD_180 | SDHCI_CAN_VDD_300);
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index d87abc7..7ffd458 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -89,6 +89,10 @@ struct sdhci_host {
 #define SDHCI_QUIRK_UNSTABLE_RO_DETECT			(1U<<31)
 /* Controller has weird bit setting for Protocol Control Register */
 #define SDHCI_QUIRK_QORIQ_PROCTL_WEIRD			(0x100000000U)
+/* Controller can only supports 3.3V, but the capabilities register
+ * has incorrect set 1.8V and 3.0V
+ */
+#define SDHCI_QUIRK_QORIQ_HOSTCAPBLT_ONLY_VS33		(0x200000000U)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.6.0.6
