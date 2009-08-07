Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 34406B8097
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 05:58:15 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 69884DDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 05:58:14 +1000 (EST)
Date: Fri, 7 Aug 2009 23:58:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6/7] sdhci-of: Cleanup eSDHC's set_clock() a little bit
Message-ID: <20090807195813.GF2735@oksana.dev.rtsoft.ru>
References: <20090807195724.GA24020@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090807195724.GA24020@oksana.dev.rtsoft.ru>
Cc: Ben Dooks <ben@fluff.org>, sdhci-devel@lists.ossman.eu,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Pierre Ossman <pierre@ossman.eu>, David Vrabel <david.vrabel@csr.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Get rid of incomprehensible "if { for { if } }" construction for the
  exponential divisor calculation. The first if statement isn't correct
  at all, since it should check for "host->max_clk / pre_div / 16 >
  clock". The error doesn't cause any bugs because the check in the for
  loop does the right thing, and so the outer check becomes useless;

- For the linear divisor do the same: a single while statement is more
  readable than for + if construction;

- Add dev_dbg() that prints desired and actual clock frequency.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci-of.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 87aaf4b..048bc01 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -121,8 +121,8 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
 
 static void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	int div;
 	int pre_div = 2;
+	int div = 1;
 
 	clrbits32(host->ioaddr + ESDHC_SYSTEM_CONTROL, ESDHC_CLOCK_IPGEN |
 		  ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN | ESDHC_CLOCK_MASK);
@@ -130,17 +130,14 @@ static void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == 0)
 		goto out;
 
-	if (host->max_clk / 16 > clock) {
-		for (; pre_div < 256; pre_div *= 2) {
-			if (host->max_clk / pre_div < clock * 16)
-				break;
-		}
-	}
+	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
+		pre_div *= 2;
 
-	for (div = 1; div <= 16; div++) {
-		if (host->max_clk / (div * pre_div) <= clock)
-			break;
-	}
+	while (host->max_clk / pre_div / div > clock && div < 16)
+		div++;
+
+	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
+		clock, host->max_clk / pre_div / div);
 
 	pre_div >>= 1;
 	div--;
-- 
1.6.3.3
