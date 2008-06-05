Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2BB0BDDFF2
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 00:07:16 +1000 (EST)
Date: Thu, 5 Jun 2008 17:36:38 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC 44x: small warp-nand fix
Message-ID: <20080605133638.GA18021@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sr@denx.de, smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The "ndfc-chip" device doesn't need any resources. All resources
are handled by the "ndfc-nand" device. Registering the same memory
resource twice causes "cat /proc/iomem" to go into an infinite loop
displaying NDFC memory addresses.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/platforms/44x/warp-nand.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.orig/arch/powerpc/platforms/44x/warp-nand.c	2008-04-25 22:04:50.000000000 +0400
+++ linux-2.6/arch/powerpc/platforms/44x/warp-nand.c	2008-06-05 17:24:06.000000000 +0400
@@ -86,8 +86,7 @@ static struct platform_nand_chip warp_na
 static struct platform_device warp_nand_device = {
 	.name = "ndfc-chip",
 	.id = 0,
-	.num_resources = 1,
-	.resource = &warp_ndfc,
+	.num_resources = 0,
 	.dev = {
 		.platform_data = &warp_nand_chip0,
 		.parent = &warp_ndfc_device.dev,
