Return-Path: <benh@ozlabs.org>
To: <jgarzik@pobox.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 05 Dec 2007 11:14:32 +1100
Subject: [PATCH 10/11] ibm_newemac: Call dev_set_drvdata() before tah_reset()
Message-Id: <20071205001541.F2D69DE109@ozlabs.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Valentine Barshak <vbarshak@ru.mvista.com>

The patch moves dev_set_drvdata(&ofdev->dev, dev) up before tah_reset(ofdev)
is called to avoid a NULL pointer dereference, since tah_reset uses drvdata.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff -pruN linux-2.6.orig/drivers/net/ibm_newemac/tah.c linux-2.6/drivers/net/ibm_newemac/tah.c
--- linux-2.6.orig/drivers/net/ibm_newemac/tah.c	2007-11-23 21:27:57.000000000 +0300
+++ linux-2.6/drivers/net/ibm_newemac/tah.c	2007-11-23 21:35:12.000000000 +0300
@@ -116,13 +116,14 @@ static int __devinit tah_probe(struct of
 		goto err_free;
 	}
 
+	dev_set_drvdata(&ofdev->dev, dev);
+
 	/* Initialize TAH and enable IPv4 checksum verification, no TSO yet */
 	tah_reset(ofdev);
 
 	printk(KERN_INFO
 	       "TAH %s initialized\n", ofdev->node->full_name);
 	wmb();
-	dev_set_drvdata(&ofdev->dev, dev);
 
 	return 0;
 
