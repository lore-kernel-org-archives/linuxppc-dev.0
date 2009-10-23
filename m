Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 2B2B6B7BBB
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Oct 2009 22:26:12 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH] spi/mpc52xx: check for invalid PSC usage
Date: Fri, 23 Oct 2009 13:25:57 +0200
Message-Id: <1256297157-28246-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add checks to allow only PSCs capable of SPI.
Also turn printk to dev_err while we are here.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: David Brownell <dbrownell@users.sourceforge.net>
---

Grant, if the patch is OK, maybe it can also go via your tree?

 drivers/spi/mpc52xx_psc_spi.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 1b74d5c..1d11a6d 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -467,19 +467,18 @@ static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
 
 	regaddr_p = of_get_address(op->node, 0, &size64, NULL);
 	if (!regaddr_p) {
-		printk(KERN_ERR "Invalid PSC address\n");
+		dev_err(&op->dev, "Invalid PSC address\n");
 		return -EINVAL;
 	}
 	regaddr64 = of_translate_address(op->node, regaddr_p);
 
-	/* get PSC id (1..6, used by port_config) */
+	/* get PSC id (only 1,2,3,6 can do SPI) */
 	if (op->dev.platform_data == NULL) {
 		const u32 *psc_nump;
 
 		psc_nump = of_get_property(op->node, "cell-index", NULL);
-		if (!psc_nump || *psc_nump > 5) {
-			printk(KERN_ERR "mpc52xx_psc_spi: Device node %s has invalid "
-					"cell-index property\n", op->node->full_name);
+		if (!psc_nump || (*psc_nump > 2 && *psc_nump != 5)) {
+			dev_err(&op->dev, "PSC can't do SPI\n");
 			return -EINVAL;
 		}
 		id = *psc_nump + 1;
-- 
1.6.3.3
