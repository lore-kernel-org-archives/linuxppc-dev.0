Return-Path: <rsiemsen@rossvideo.com>
Received: from server06.rossvideo.com (unknown [209.87.241.202])
	by ozlabs.org (Postfix) with ESMTP id EFE3467A6F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jan 2005 08:06:27 +1100 (EST)
Message-ID: <41F01A79.7090201@rossvideo.com>
Date: Thu, 20 Jan 2005 15:54:17 -0500
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="------------030607050801030601040100"
Subject: [PATCH] ibm_emac missed fix
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030607050801030601040100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The following minor fix was posted here some months ago but hasn't found 
its way in to 2.6.10 or current bk.

Signed-off-by: Ralph Siemsen <ralphs@netwinder.org>

--------------030607050801030601040100
Content-Type: text/plain;
 name="emac.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emac.patch"

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
 

--------------030607050801030601040100--
