Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 8C58E67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Feb 2005 16:44:05 +1100 (EST)
Date: Tue, 8 Feb 2005 22:43:45 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: jgarzik@pobox.com
Message-ID: <20050208224345.B12821@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@oss.sgi.com, linuxppc-embedded@ozlabs.org
Subject: [PATCH] emac: fix mdio delay
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fixes MDIO delay. Please apply.

Signed-off-by: Ralph Siemsen <ralphs@netwinder.org>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

--- linux-2.6.10-orig/drivers/net/ibm_emac/ibm_emac_core.c	2005-01-20 15:45:28.576226303 -0500
+++ linux-2.6.10/drivers/net/ibm_emac/ibm_emac_core.c	2005-01-20 15:25:10.430674655 -0500
@@ -475,8 +479,9 @@
 
 	out_be32(&emacp->em0stacr, stacr);
 
-	while (((stacr = in_be32(&emacp->em0stacr) & EMAC_STACR_OC) == 0)
-					&& (count++ < 5000))
+	count = 0;
+	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
+					&& (count++ < MDIO_DELAY))
 		udelay(1);
 	MDIO_DEBUG((" (count was %d)\n", count));
