Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id D4B05DE72F
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:19:21 +1000 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP300IJRC6JZW60@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:18:19 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP300KOUC6I8N30@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Sep 2007 12:18:18 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP3002P0C6HGWW5@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:18:18 -0600 (MDT)
Date: Fri, 28 Sep 2007 12:18:27 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 17/18] Sysace: Move IRQ handler registration to occur after	FSM
	is initialized
In-reply-to: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070928181825.18608.76039.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
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
