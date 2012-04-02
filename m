Return-Path: <jirislaby@gmail.com>
Received: from smtp.pripojeni.net (mail.pripojeni.net [178.22.112.14])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 159CAB6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2012 22:02:11 +1000 (EST)
From: Jiri Slaby <jslaby@suse.cz>
To: gregkh@linuxfoundation.org
Subject: [PATCH 46/69] TTY: hvsi, use tty from tty_port
Date: Mon,  2 Apr 2012 13:54:30 +0200
Message-Id: <1333367693-3244-47-git-send-email-jslaby@suse.cz>
In-Reply-To: <1333367693-3244-1-git-send-email-jslaby@suse.cz>
References: <1333367693-3244-1-git-send-email-jslaby@suse.cz>
Cc: jirislaby@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now, we switch to the refcounted model and do not need hp->lock to
protect hp->tty anymore.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/hvc/hvsi.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index 68b729b..6f5bc49 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -76,7 +76,6 @@ struct hvsi_struct {
 	wait_queue_head_t stateq; /* woken when HVSI state changes */
 	spinlock_t lock;
 	int index;
-	struct tty_struct *tty;
 	uint8_t throttle_buf[128];
 	uint8_t outbuf[N_OUTBUF]; /* to implement write_room and chars_in_buffer */
 	/* inbuf is for packet reassembly. leave a little room for leftovers. */
@@ -492,14 +491,17 @@ static irqreturn_t hvsi_interrupt(int irq, void *arg)
 {
 	struct hvsi_struct *hp = (struct hvsi_struct *)arg;
 	struct hvsi_struct *handshake;
+	struct tty_struct *tty;
 	unsigned long flags;
 	int again = 1;
 
 	pr_debug("%s\n", __func__);
 
+	tty = tty_port_tty_get(&hp->port);
+
 	while (again) {
 		spin_lock_irqsave(&hp->lock, flags);
-		again = hvsi_load_chunk(hp, hp->tty, &handshake);
+		again = hvsi_load_chunk(hp, tty, &handshake);
 		spin_unlock_irqrestore(&hp->lock, flags);
 
 		if (handshake) {
@@ -509,15 +511,16 @@ static irqreturn_t hvsi_interrupt(int irq, void *arg)
 	}
 
 	spin_lock_irqsave(&hp->lock, flags);
-	if (hp->tty && hp->n_throttle
-			&& (!test_bit(TTY_THROTTLED, &hp->tty->flags))) {
-		/* we weren't hung up and we weren't throttled, so we can deliver the
-		 * rest now */
-		hvsi_send_overflow(hp, hp->tty);
-		tty_flip_buffer_push(hp->tty);
+	if (tty && hp->n_throttle && !test_bit(TTY_THROTTLED, &tty->flags)) {
+		/* we weren't hung up and we weren't throttled, so we can
+		 * deliver the rest now */
+		hvsi_send_overflow(hp, tty);
+		tty_flip_buffer_push(tty);
 	}
 	spin_unlock_irqrestore(&hp->lock, flags);
 
+	tty_kref_put(tty);
+
 	return IRQ_HANDLED;
 }
 
@@ -724,8 +727,8 @@ static int hvsi_open(struct tty_struct *tty, struct file *filp)
 	if (hp->state == HVSI_FSP_DIED)
 		return -EIO;
 
+	tty_port_tty_set(&hp->port, tty);
 	spin_lock_irqsave(&hp->lock, flags);
-	hp->tty = tty;
 	hp->port.count++;
 	atomic_set(&hp->seqno, 0);
 	h_vio_signal(hp->vtermno, VIO_IRQ_ENABLE);
@@ -784,7 +787,7 @@ static void hvsi_close(struct tty_struct *tty, struct file *filp)
 	spin_lock_irqsave(&hp->lock, flags);
 
 	if (--hp->port.count == 0) {
-		hp->tty = NULL;
+		tty_port_tty_set(&hp->port, NULL);
 		hp->inbuf_end = hp->inbuf; /* discard remaining partial packets */
 
 		/* only close down connection if it is not the console */
@@ -830,12 +833,11 @@ static void hvsi_hangup(struct tty_struct *tty)
 
 	pr_debug("%s\n", __func__);
 
-	spin_lock_irqsave(&hp->lock, flags);
+	tty_port_tty_set(&hp->port, NULL);
 
+	spin_lock_irqsave(&hp->lock, flags);
 	hp->port.count = 0;
 	hp->n_outbuf = 0;
-	hp->tty = NULL;
-
 	spin_unlock_irqrestore(&hp->lock, flags);
 }
 
@@ -863,6 +865,7 @@ static void hvsi_write_worker(struct work_struct *work)
 {
 	struct hvsi_struct *hp =
 		container_of(work, struct hvsi_struct, writer.work);
+	struct tty_struct *tty;
 	unsigned long flags;
 #ifdef DEBUG
 	static long start_j = 0;
@@ -896,7 +899,11 @@ static void hvsi_write_worker(struct work_struct *work)
 		start_j = 0;
 #endif /* DEBUG */
 		wake_up_all(&hp->emptyq);
-		tty_wakeup(hp->tty);
+		tty = tty_port_tty_get(&hp->port);
+		if (tty) {
+			tty_wakeup(tty);
+			tty_kref_put(tty);
+		}
 	}
 
 out:
-- 
1.7.9.2
