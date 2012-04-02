Return-Path: <jirislaby@gmail.com>
Received: from smtp.pripojeni.net (mail.pripojeni.net [178.22.112.14])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A1B07B6FCA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2012 22:02:15 +1000 (EST)
From: Jiri Slaby <jslaby@suse.cz>
To: gregkh@linuxfoundation.org
Subject: [PATCH 44/69] TTY: hvsi, add tty_port
Date: Mon,  2 Apr 2012 13:54:28 +0200
Message-Id: <1333367693-3244-45-git-send-email-jslaby@suse.cz>
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

And use count from there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/hvc/hvsi.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index 4006aed..113a09a 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -69,6 +69,7 @@
 #define __ALIGNED__	__attribute__((__aligned__(sizeof(long))))
 
 struct hvsi_struct {
+	struct tty_port port;
 	struct delayed_work writer;
 	struct work_struct handshaker;
 	wait_queue_head_t emptyq; /* woken when outbuf is emptied */
@@ -76,7 +77,6 @@ struct hvsi_struct {
 	spinlock_t lock;
 	int index;
 	struct tty_struct *tty;
-	int count;
 	uint8_t throttle_buf[128];
 	uint8_t outbuf[N_OUTBUF]; /* to implement write_room and chars_in_buffer */
 	/* inbuf is for packet reassembly. leave a little room for leftovers. */
@@ -751,7 +751,7 @@ static int hvsi_open(struct tty_struct *tty, struct file *filp)
 
 	spin_lock_irqsave(&hp->lock, flags);
 	hp->tty = tty;
-	hp->count++;
+	hp->port.count++;
 	atomic_set(&hp->seqno, 0);
 	h_vio_signal(hp->vtermno, VIO_IRQ_ENABLE);
 	spin_unlock_irqrestore(&hp->lock, flags);
@@ -808,7 +808,7 @@ static void hvsi_close(struct tty_struct *tty, struct file *filp)
 
 	spin_lock_irqsave(&hp->lock, flags);
 
-	if (--hp->count == 0) {
+	if (--hp->port.count == 0) {
 		hp->tty = NULL;
 		hp->inbuf_end = hp->inbuf; /* discard remaining partial packets */
 
@@ -841,9 +841,9 @@ static void hvsi_close(struct tty_struct *tty, struct file *filp)
 
 			spin_lock_irqsave(&hp->lock, flags);
 		}
-	} else if (hp->count < 0)
+	} else if (hp->port.count < 0)
 		printk(KERN_ERR "hvsi_close %lu: oops, count is %d\n",
-		       hp - hvsi_ports, hp->count);
+		       hp - hvsi_ports, hp->port.count);
 
 	spin_unlock_irqrestore(&hp->lock, flags);
 }
@@ -857,7 +857,7 @@ static void hvsi_hangup(struct tty_struct *tty)
 
 	spin_lock_irqsave(&hp->lock, flags);
 
-	hp->count = 0;
+	hp->port.count = 0;
 	hp->n_outbuf = 0;
 	hp->tty = NULL;
 
@@ -1228,6 +1228,7 @@ static int __init hvsi_console_init(void)
 		init_waitqueue_head(&hp->emptyq);
 		init_waitqueue_head(&hp->stateq);
 		spin_lock_init(&hp->lock);
+		tty_port_init(&hp->port);
 		hp->index = hvsi_count;
 		hp->inbuf_end = hp->inbuf;
 		hp->state = HVSI_CLOSED;
-- 
1.7.9.2
