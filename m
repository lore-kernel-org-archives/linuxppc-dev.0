Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DE167B7FA1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 05:58:13 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 1C4CFDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 05:58:13 +1000 (EST)
Date: Fri, 7 Aug 2009 23:58:11 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/7] sdhci-of: Don't hard-code inverted write-protect quirk
Message-ID: <20090807195811.GE2735@oksana.dev.rtsoft.ru>
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

MPC85xx SOCs have normal write-protect state reporting, so we shouldn't
hard-code the quirk.

Instead, look for "sdhci,wp-inverted" property, plus check for
mpc837x_{rdb,mds} machines since older device trees don't specify the
new property.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci-of.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 004f24d..87aaf4b 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/mmc/host.h>
+#include <asm/machdep.h>
 #include "sdhci.h"
 
 struct sdhci_of_data {
@@ -175,7 +176,6 @@ static unsigned int esdhc_get_min_clock(struct sdhci_host *host)
 static struct sdhci_of_data sdhci_esdhc = {
 	.quirks = SDHCI_QUIRK_FORCE_BLK_SZ_2048 |
 		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
-		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
 		  SDHCI_QUIRK_NO_BUSY_IRQ |
 		  SDHCI_QUIRK_NONSTANDARD_CLOCK |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
@@ -219,6 +219,15 @@ static int sdhci_of_resume(struct of_device *ofdev)
 
 #endif
 
+static bool __devinit sdhci_of_wp_inverted(struct device_node *np)
+{
+	if (of_get_property(np, "sdhci,wp-inverted", NULL))
+		return true;
+
+	/* Old device trees don't have the wp-inverted property. */
+	return machine_is(mpc837x_rdb) || machine_is(mpc837x_mds);
+}
+
 static int __devinit sdhci_of_probe(struct of_device *ofdev,
 				 const struct of_device_id *match)
 {
@@ -261,6 +270,9 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 	if (of_get_property(np, "sdhci,1-bit-only", NULL))
 		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
+	if (sdhci_of_wp_inverted(np))
+		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
+
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
 		of_host->clock = *clk;
-- 
1.6.3.3
