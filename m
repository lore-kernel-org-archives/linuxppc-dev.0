Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 91F41B7BBF
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 20:49:33 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] spi/mpc52xx: replace printk with dev_err
Date: Wed,  4 Nov 2009 10:49:20 +0100
Message-Id: <1257328160-24955-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <fa686aa40910311803m43504167s1ad802aecd2b4344@mail.gmail.com>
References: <fa686aa40910311803m43504167s1ad802aecd2b4344@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To easily identify which device has problems.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/mpc52xx_psc_spi.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index e268437..6fb6b3b 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -471,7 +471,7 @@ static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
 
 	regaddr_p = of_get_address(op->node, 0, &size64, NULL);
 	if (!regaddr_p) {
-		printk(KERN_ERR "Invalid PSC address\n");
+		dev_err(&op->dev, "Invalid PSC address\n");
 		return -EINVAL;
 	}
 	regaddr64 = of_translate_address(op->node, regaddr_p);
@@ -482,8 +482,7 @@ static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
 
 		psc_nump = of_get_property(op->node, "cell-index", NULL);
 		if (!psc_nump || *psc_nump > 5) {
-			printk(KERN_ERR "mpc52xx_psc_spi: Device node %s has invalid "
-					"cell-index property\n", op->node->full_name);
+			dev_err(&op->dev, "Invalid cell-index property\n");
 			return -EINVAL;
 		}
 		id = *psc_nump + 1;
-- 
1.6.3.3
