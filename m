Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id AA6FADE05D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 01:44:48 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id d26so70099eyd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 06:44:46 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: timur@freescale.com,
	dan.j.williams@intel.com,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] fsldma: print correct IRQ on mpc83xx
Date: Wed, 14 Jan 2009 15:44:44 +0100
Message-Id: <1231944284-18296-1-git-send-email-jacmet@sunsite.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mpc83xx variant uses a shared IRQ for all channels, so the individual
channel nodes don't have an interrupt property. Fix the code to print the
controller IRQ instead if there isn't any for the channel.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/dma/fsldma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index ca70a21..61b6e08 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -875,7 +875,8 @@ static int __devinit fsl_dma_chan_probe(struct fsl_dma_device *fdev,
 	}
 
 	dev_info(fdev->dev, "#%d (%s), irq %d\n", new_fsl_chan->id,
-				compatible, new_fsl_chan->irq);
+		 compatible,
+		 new_fsl_chan->irq != NO_IRQ ? new_fsl_chan->irq : fdev->irq);
 
 	return 0;
 
-- 
1.5.6.5
