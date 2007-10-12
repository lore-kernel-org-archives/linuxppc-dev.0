Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CAEEADDE09
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 23:05:58 +1000 (EST)
Date: Fri, 12 Oct 2007 17:04:45 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] NEW EMAC Fix RGMII build error: use of_device_is_compatible
Message-ID: <20071012130445.GA14704@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix build RGMII error: use of_device_is_compatible()
insteadof now deprecated device_is_compatible() function.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/net/ibm_newemac/rgmii.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -pruN linux-2.6.orig/drivers/net/ibm_newemac/rgmii.c linux-2.6/drivers/net/ibm_newemac/rgmii.c
--- linux-2.6.orig/drivers/net/ibm_newemac/rgmii.c	2007-10-12 16:02:41.000000000 +0400
+++ linux-2.6/drivers/net/ibm_newemac/rgmii.c	2007-10-12 16:49:07.000000000 +0400
@@ -251,7 +251,7 @@ static int __devinit rgmii_probe(struct 
 	}
 
 	/* Check for RGMII type */
-	if (device_is_compatible(ofdev->node, "ibm,rgmii-axon"))
+	if (of_device_is_compatible(ofdev->node, "ibm,rgmii-axon"))
 		dev->type = RGMII_AXON;
 	else
 		dev->type = RGMII_STANDARD;
