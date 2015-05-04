Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 1EAEB1A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 02:39:20 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] sdhci-of-esdhc: Pre divider starts at 1
Date: Mon,  4 May 2015 18:31:32 +0200
Message-Id: <1430757092-15847-2-git-send-email-joakim.tjernlund@transmode.se>
In-Reply-To: <1430757092-15847-1-git-send-email-joakim.tjernlund@transmode.se>
References: <1430757092-15847-1-git-send-email-joakim.tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For PowerPC esdhc pre divider starts at 1, fixing this increases
the actual clock from 40 MHz to 50 MHz.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 7130130..ffd5625 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -207,7 +207,7 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 
 static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	int pre_div = 2;
+	int pre_div = 1;
 	int div = 1;
 	u32 temp;
 
@@ -237,7 +237,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
 		clock, host->max_clk / pre_div / div);
-
+	host->mmc->actual_clock = host->max_clk / pre_div / div;
 	pre_div >>= 1;
 	div--;
 
-- 
2.3.6
