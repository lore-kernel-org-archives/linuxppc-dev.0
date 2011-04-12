Return-Path: <R1AAHA@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 553ABB6F12
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Apr 2011 10:15:29 +1000 (EST)
Date: Mon, 11 Apr 2011 19:15:16 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/4] crypto: caam - handle interrupt lines shared across rings
Message-ID: <20110411191516.bae0454e.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Steve Cornelius <sec@pobox.com>, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- add IRQF_SHARED to request_irq flags to support parts such as
the p1023 that has one IRQ line per couple of rings.

- resetting a job ring triggers an interrupt, so move request_irq
prior to jr_reset to avoid 'got IRQ but nobody cared' messages.

- disable IRQs in h/w to avoid contention between reset and
interrupt status

- delete invalid comment - if there were incomplete jobs,
module would be in use, preventing an unload.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
this, and the remaining patches in this series, tested on p1023, p3041,
p4080, and 32- and 64-bit p5020.

 drivers/crypto/caam/jr.c |   46 ++++++++++++++++++++--------------------------
 1 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 68cb9af..340fa32 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -292,10 +292,10 @@ static int caam_reset_hw_jr(struct device *dev)
 	unsigned int timeout = 100000;
 
 	/*
-	 * FIXME: disabling IRQs here inhibits proper job completion
-	 * and error propagation
+	 * mask interrupts since we are going to poll
+	 * for reset completion status
 	 */
-	disable_irq(jrp->irq);
+	setbits32(&jrp->rregs->rconfig_lo, JRCFG_IMSK);
 
 	/* initiate flush (required prior to reset) */
 	wr_reg32(&jrp->rregs->jrcommand, JRCR_RESET);
@@ -320,7 +320,8 @@ static int caam_reset_hw_jr(struct device *dev)
 		return -EIO;
 	}
 
-	enable_irq(jrp->irq);
+	/* unmask interrupts */
+	clrbits32(&jrp->rregs->rconfig_lo, JRCFG_IMSK);
 
 	return 0;
 }
@@ -336,6 +337,21 @@ static int caam_jr_init(struct device *dev)
 
 	jrp = dev_get_drvdata(dev);
 
+	/* Connect job ring interrupt handler. */
+	for_each_possible_cpu(i)
+		tasklet_init(&jrp->irqtask[i], caam_jr_dequeue,
+			     (unsigned long)dev);
+
+	error = request_irq(jrp->irq, caam_jr_interrupt, IRQF_SHARED,
+			    "caam-jobr", dev);
+	if (error) {
+		dev_err(dev, "can't connect JobR %d interrupt (%d)\n",
+			jrp->ridx, jrp->irq);
+		irq_dispose_mapping(jrp->irq);
+		jrp->irq = 0;
+		return -EINVAL;
+	}
+
 	error = caam_reset_hw_jr(dev);
 	if (error)
 		return error;
@@ -404,28 +420,6 @@ static int caam_jr_init(struct device *dev)
 		  (JOBR_INTC_COUNT_THLD << JRCFG_ICDCT_SHIFT) |
 		  (JOBR_INTC_TIME_THLD << JRCFG_ICTT_SHIFT));
 
-	/* Connect job ring interrupt handler. */
-	for_each_possible_cpu(i)
-		tasklet_init(&jrp->irqtask[i], caam_jr_dequeue,
-			     (unsigned long)dev);
-
-	error = request_irq(jrp->irq, caam_jr_interrupt, 0,
-			    "caam-jobr", dev);
-	if (error) {
-		dev_err(dev, "can't connect JobR %d interrupt (%d)\n",
-			jrp->ridx, jrp->irq);
-		irq_dispose_mapping(jrp->irq);
-		jrp->irq = 0;
-		dma_unmap_single(dev, inpbusaddr, sizeof(u32 *) * JOBR_DEPTH,
-				 DMA_BIDIRECTIONAL);
-		dma_unmap_single(dev, outbusaddr, sizeof(u32 *) * JOBR_DEPTH,
-				 DMA_BIDIRECTIONAL);
-		kfree(jrp->inpring);
-		kfree(jrp->outring);
-		kfree(jrp->entinfo);
-		return -EINVAL;
-	}
-
 	jrp->assign = JOBR_UNASSIGNED;
 	return 0;
 }
-- 
1.7.4.3.dirty
