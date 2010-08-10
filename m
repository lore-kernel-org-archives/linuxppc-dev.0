Return-Path: <tie-fei.zang@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by ozlabs.org (Postfix) with ESMTP id 13446B70ED
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 20:03:46 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Subject: [PATCH 2/2] mmc: some nip clean up for the sdhci driver
Date: Tue, 10 Aug 2010 17:47:12 +0800
Message-ID: <1281433632-18758-2-git-send-email-tie-fei.zang@freescale.com>
In-Reply-To: <1281433632-18758-1-git-send-email-tie-fei.zang@freescale.com>
References: <1281433632-18758-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, mirqus@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

remove the extra line and rewrite the if condition line.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 drivers/mmc/host/sdhci-of-core.c |    1 -
 drivers/mmc/host/sdhci.c         |    5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index d059805..732cffd 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -157,7 +157,6 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
 		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_AUTO_CMD12;
 
-
 	if (of_get_property(np, "sdhci,1-bit-only", NULL))
 		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4b7b2d5..a1e6269 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -818,10 +818,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
 	mode = SDHCI_TRNS_BLK_CNT_EN;
 	if (data->blocks > 1) {
+		mode |= SDHCI_TRNS_MULTI;
 		if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_AUTO_CMD12)
-			mode |= SDHCI_TRNS_MULTI | SDHCI_TRNS_AUTO_CMD12;
-		else
-			mode |= SDHCI_TRNS_MULTI;
+			mode |= SDHCI_TRNS_AUTO_CMD12;
 	}
 	if (data->flags & MMC_DATA_READ)
 		mode |= SDHCI_TRNS_READ;
-- 
1.5.6.5
