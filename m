Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 839C7DDF60
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 16:24:23 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so1747205pyi.27
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 23:24:21 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/mpc5200: Fix locking on mpc52xx_spi driver
To: dwalker@mvista.com, spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
Date: Sat, 26 Jul 2008 02:24:18 -0400
Message-ID: <20080726062226.10506.65539.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Locking was incorrect for the state machine processing since there are
conditions where both the work queue and the IRQ can be active.  This
patch fixes the handling to ensure the spin lock is held whenever the
state machine is being processed.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Hi Daniel,

Here is the incremental change to the mpc52xx_spi driver to fix up the
locking.  It should be safe and unambiguous now.

Cheers,
g.

 drivers/spi/mpc52xx_spi.c |   44 +++++++++++++++++++++++++-------------------
 1 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
index a4afc56..ab7be43 100644
--- a/drivers/spi/mpc52xx_spi.c
+++ b/drivers/spi/mpc52xx_spi.c
@@ -149,17 +149,10 @@ mpc52xx_spi_fsmstate_idle(int irq, struct mpc52xx_spi *ms, u8 status, u8 data)
 		dev_err(&ms->master->dev, "spurious irq, status=0x%.2x\n",
 			status);
 
-	/* Check if there is another transfer waiting.  It is safe to do
-	 * this here without holding the spinlock because this is the only
-	 * function where messages are dequeued and this function will
-	 * only get called by the IRQ or by the workqueue.  The IRQ and
-	 * the workqueue will not be enabled at the same time. */
+	/* Check if there is another transfer waiting. */
 	if (list_empty(&ms->queue))
 		return FSM_STOP;
 
-	/* Get the next message */
-	spin_lock(&ms->lock);
-
 	/* Call the pre-message hook with a pointer to the next
 	 * message.  The pre-message hook may enqueue a new message for
 	 * changing the chip select value to the head of the queue */
@@ -168,10 +161,9 @@ mpc52xx_spi_fsmstate_idle(int irq, struct mpc52xx_spi *ms, u8 status, u8 data)
 		ms->premessage(m, ms->premessage_context);
 
 	/* reget the head of the queue (the premessage hook may have enqueued
-	 * something before it.) and drop the spinlock */
+	 * something before it.) */
 	ms->message = list_first_entry(&ms->queue, struct spi_message, queue);
 	list_del_init(&ms->message->queue);
-	spin_unlock(&ms->lock);
 
 	/* Setup the controller parameters */
 	ctrl1 = SPI_CTRL1_SPIE | SPI_CTRL1_SPE | SPI_CTRL1_MSTR;
@@ -326,36 +318,50 @@ mpc52xx_spi_fsmstate_wait(int irq, struct mpc52xx_spi *ms, u8 status, u8 data)
 	return FSM_CONTINUE;
 }
 
-/*
- * IRQ handler
+/**
+ * mpc52xx_spi_fsm_process - Finite State Machine iteration function
+ * @irq: irq number that triggered the FSM; NO_IRQ for workqueue polling
+ * @ms: pointer to mpc52xx_spi driver data
  */
-static irqreturn_t mpc52xx_spi_irq(int irq, void *_ms)
+static void mpc52xx_spi_fsm_process(int irq, struct mpc52xx_spi *ms)
 {
-	struct mpc52xx_spi *ms = _ms;
 	int rc = FSM_CONTINUE;
 	u8 status, data;
 
 	while (rc == FSM_CONTINUE) {
 		/* Interrupt cleared by read of STATUS followed by
-		 * read of DATA registers*/
+		 * read of DATA registers */
 		status = readb(ms->regs + SPI_STATUS);
-		data = readb(ms->regs + SPI_DATA); /* clear status */
+		data = readb(ms->regs + SPI_DATA);
 		rc = ms->state(irq, ms, status, data);
 	}
 
 	if (rc == FSM_POLL)
 		schedule_work(&ms->work);
+}
 
+/**
+ * mpc52xx_spi_irq - IRQ handler
+ */
+static irqreturn_t mpc52xx_spi_irq(int irq, void *_ms)
+{
+	struct mpc52xx_spi *ms = _ms;
+	spin_lock(&ms->lock);
+	mpc52xx_spi_fsm_process(irq, ms);
+	spin_unlock(&ms->lock);
 	return IRQ_HANDLED;
 }
 
-/*
- * Workqueue method of running the state machine
+/**
+ * mpc52xx_spi_wq - Workqueue function for polling the state machine
  */
 static void mpc52xx_spi_wq(struct work_struct *work)
 {
 	struct mpc52xx_spi *ms = container_of(work, struct mpc52xx_spi, work);
-	mpc52xx_spi_irq(NO_IRQ, ms);
+	unsigned long flags;
+	spin_lock_irqsave(&ms->lock, flags);
+	mpc52xx_spi_fsm_process(NO_IRQ, ms);
+	spin_unlock_irqrestore(&ms->lock, flags);
 }
 
 /*
