Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 5E194B7BBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 08:11:56 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 2/3] i2c/cpm: drop NO_IRQ
Date: Thu, 22 Oct 2009 23:11:27 +0200
Message-Id: <1256245888-25210-3-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1256245888-25210-2-git-send-email-w.sang@pengutronix.de>
References: <1256245888-25210-1-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-2-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop NO_IRQ as 0 is the preferred way to describe 'no irq'
(http://lkml.org/lkml/2005/11/21/221). This change is safe, as the driver is
only used on powerpc, where NO_IRQ is 0 anyhow.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Jochen Friedrich <jochen@scram.de>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/i2c/busses/i2c-cpm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 9c2e100..16948db 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -441,7 +441,7 @@ static int __devinit cpm_i2c_setup(struct cpm_i2c *cpm)
 	init_waitqueue_head(&cpm->i2c_wait);
 
 	cpm->irq = of_irq_to_resource(ofdev->node, 0, NULL);
-	if (cpm->irq == NO_IRQ)
+	if (!cpm->irq)
 		return -EINVAL;
 
 	/* Install interrupt handler. */
-- 
1.6.5
