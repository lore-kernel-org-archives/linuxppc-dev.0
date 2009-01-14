Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by ozlabs.org (Postfix) with ESMTP id CFF8ADDFD3
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 03:20:20 +1100 (EST)
Received: by ewy13 with SMTP id 13so855819ewy.9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 08:20:18 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: timur@freescale.com,
	dan.j.williams@intel.com,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] fsldma: check for NO_IRQ in fsl_dma_chan_remove()
Date: Wed, 14 Jan 2009 17:20:15 +0100
Message-Id: <1231950015-19584-1-git-send-email-jacmet@sunsite.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's no per-channel IRQ on mpc83xx, so only call free_irq if we have one.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/dma/fsldma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index ca70a21..f48c0e6 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -890,7 +890,8 @@ err_no_reg:
 
 static void fsl_dma_chan_remove(struct fsl_dma_chan *fchan)
 {
-	free_irq(fchan->irq, fchan);
+	if (fchan->irq != NO_IRQ)
+		free_irq(fchan->irq, fchan);
 	list_del(&fchan->common.device_node);
 	iounmap(fchan->reg_base);
 	kfree(fchan);
-- 
1.5.6.5
