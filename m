Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 333E3DE25D
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 08:57:46 +1000 (EST)
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP7000EJEFYT9A0@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:57:34 -0600 (MDT)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
	by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP700HV7EFXCC00@pd2mr6so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 30 Sep 2007 16:57:34 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP700MZUEFX7R54@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:57:33 -0600 (MDT)
Date: Sun, 30 Sep 2007 16:57:33 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 5/6] Sysace: Move IRQ handler registration to occur after
	FSM is initialized
In-reply-to: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	axboe@kernel.dk
Message-id: <20070930225726.2476.44211.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The FSM needs to be initialized before it is safe to call the ISR

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/block/xsysace.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 10bb4e5..296d567 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -949,15 +949,6 @@ static int __devinit ace_setup(struct ace_device *ace)
 	if (!ace->baseaddr)
 		goto err_ioremap;
 
-	if (ace->irq != NO_IRQ) {
-		rc = request_irq(ace->irq, ace_interrupt, 0, "systemace", ace);
-		if (rc) {
-			/* Failure - fall back to polled mode */
-			dev_err(ace->dev, "request_irq failed\n");
-			ace->irq = NO_IRQ;
-		}
-	}
-
 	/*
 	 * Initialize the state machine tasklet and stall timer
 	 */
@@ -1015,6 +1006,16 @@ static int __devinit ace_setup(struct ace_device *ace)
 	val |= ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ;
 	ace_out(ace, ACE_CTRL, val);
 
+	/* Now we can hook up the irq handler */
+	if (ace->irq != NO_IRQ) {
+		rc = request_irq(ace->irq, ace_interrupt, 0, "systemace", ace);
+		if (rc) {
+			/* Failure - fall back to polled mode */
+			dev_err(ace->dev, "request_irq failed\n");
+			ace->irq = NO_IRQ;
+		}
+	}
+
 	/* Print the identification */
 	dev_info(ace->dev, "Xilinx SystemACE revision %i.%i.%i\n",
 		 (version >> 12) & 0xf, (version >> 8) & 0x0f, version & 0xff);
@@ -1035,8 +1036,6 @@ static int __devinit ace_setup(struct ace_device *ace)
 	blk_cleanup_queue(ace->queue);
       err_blk_initq:
 	iounmap(ace->baseaddr);
-	if (ace->irq != NO_IRQ)
-		free_irq(ace->irq, ace);
       err_ioremap:
 	dev_info(ace->dev, "xsysace: error initializing device at 0x%lx\n",
 	       ace->physaddr);
