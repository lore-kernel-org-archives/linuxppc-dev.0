Return-Path: <peter@hurleysoftware.com>
Received: from mail-qg0-f47.google.com (mail-qg0-f47.google.com
 [209.85.192.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 973251A060A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2015 07:01:25 +1100 (AEDT)
Received: by qgx61 with SMTP id 61so94627719qgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 13:01:23 -0700 (PDT)
From: Peter Hurley <peter@hurleysoftware.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>,
 David Laight <David.Laight@aculab.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
 Peter Hurley <peter@hurleysoftware.com>,
 Karsten Keil <isdn@linux-pingi.de>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/7] tty: Remove tty_wait_until_sent_from_close()
Date: Sat, 10 Oct 2015 16:00:51 -0400
Message-Id: <1444507257-7513-2-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1444507257-7513-1-git-send-email-peter@hurleysoftware.com>
References: <1444507257-7513-1-git-send-email-peter@hurleysoftware.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tty_wait_until_sent_from_close() drops the tty lock while waiting
for the tty driver to finish sending previously accepted data (ie.,
data remaining in its write buffer and transmit fifo).

tty_wait_until_sent_from_close() was added by commit a57a7bf3fc7e
("TTY: define tty_wait_until_sent_from_close") to prevent the entire
tty subsystem from being unable to open new ttys while waiting for
one tty to close while output drained.

However, since commit 0911261d4cb6 ("tty: Don't take tty_mutex for tty
count changes"), holding a tty lock while closing does not prevent other
ttys from being opened/closed/hung up, but only prevents lifetime event
changes for the tty under lock.

Holding the tty lock while waiting for output to drain does prevent
parallel non-blocking opens (O_NONBLOCK) from advancing or returning
while the tty lock is held. However, all parallel opens _already_
block even if the tty lock is dropped while closing and the parallel
open advances. Blocking in open has been in mainline since at least 2.6.29
(see tty_port_block_til_ready(); note the test for O_NONBLOCK is _after_
the wait while ASYNC_CLOSING).

IOW, before this patch a non-blocking open will sleep anyway for the
_entire_ duration of a parallel hardware shutdown, and when it wakes, the
error return will cause a release of its tty, and it will restart with
a fresh attempt to open. Similarly with a blocking open that is already
waiting; when it's woken, the hardware shutdown has already completed
to ASYNC_INITIALIZED is not set, which forces a release and restart as
well.

So, holding the tty lock across the _entire_ close (which is what this
patch does), even while waiting for output to drain, is equivalent to
the current outcome wrt parallel opens.

Cc: Alan Cox <alan@linux.intel.com>
Cc: David Laight <David.Laight@aculab.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Karsten Keil <isdn@linux-pingi.de>
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/isdn/i4l/isdn_tty.c   |  2 +-
 drivers/tty/hvc/hvc_console.c |  2 +-
 drivers/tty/hvc/hvcs.c        |  2 +-
 drivers/tty/tty_port.c        | 11 ++---------
 include/linux/tty.h           | 18 ------------------
 5 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index bc91261..2175225 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1582,7 +1582,7 @@ isdn_tty_close(struct tty_struct *tty, struct file *filp)
 	 * line status register.
 	 */
 	if (port->flags & ASYNC_INITIALIZED) {
-		tty_wait_until_sent_from_close(tty, 3000);	/* 30 seconds timeout */
+		tty_wait_until_sent(tty, 3000);	/* 30 seconds timeout */
 		/*
 		 * Before we drop DTR, make sure the UART transmitter
 		 * has completely drained; this is especially
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 9c30f67..e46d628 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -418,7 +418,7 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 		 * there is no buffered data otherwise sleeps on a wait queue
 		 * waking periodically to check chars_in_buffer().
 		 */
-		tty_wait_until_sent_from_close(tty, HVC_CLOSE_WAIT);
+		tty_wait_until_sent(tty, HVC_CLOSE_WAIT);
 	} else {
 		if (hp->port.count < 0)
 			printk(KERN_ERR "hvc_close %X: oops, count is %d\n",
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index f7ff97c..5997b17 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1230,7 +1230,7 @@ static void hvcs_close(struct tty_struct *tty, struct file *filp)
 		irq = hvcsd->vdev->irq;
 		spin_unlock_irqrestore(&hvcsd->lock, flags);
 
-		tty_wait_until_sent_from_close(tty, HVCS_CLOSE_WAIT);
+		tty_wait_until_sent(tty, HVCS_CLOSE_WAIT);
 
 		/*
 		 * This line is important because it tells hvcs_open that this
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 40b3183..d7d9f9c 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -463,10 +463,7 @@ static void tty_port_drain_delay(struct tty_port *port, struct tty_struct *tty)
 	schedule_timeout_interruptible(timeout);
 }
 
-/* Caller holds tty lock.
- * NB: may drop and reacquire tty lock (in tty_wait_until_sent_from_close())
- * so tty and tty port may have changed state (but not hung up or reopened).
- */
+/* Caller holds tty lock. */
 int tty_port_close_start(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp)
 {
@@ -502,7 +499,7 @@ int tty_port_close_start(struct tty_port *port,
 		if (tty->flow_stopped)
 			tty_driver_flush_buffer(tty);
 		if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-			tty_wait_until_sent_from_close(tty, port->closing_wait);
+			tty_wait_until_sent(tty, port->closing_wait);
 		if (port->drain_delay)
 			tty_port_drain_delay(port, tty);
 	}
@@ -543,10 +540,6 @@ EXPORT_SYMBOL(tty_port_close_end);
  * tty_port_close
  *
  * Caller holds tty lock
- *
- * NB: may drop and reacquire tty lock (in tty_port_close_start()->
- * tty_wait_until_sent_from_close()) so tty and tty_port may have changed
- * state (but not hung up or reopened).
  */
 void tty_port_close(struct tty_port *port, struct tty_struct *tty,
 							struct file *filp)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index d072ded..614c822 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -657,24 +657,6 @@ extern void __lockfunc tty_lock_slave(struct tty_struct *tty);
 extern void __lockfunc tty_unlock_slave(struct tty_struct *tty);
 extern void tty_set_lock_subclass(struct tty_struct *tty);
 /*
- * this shall be called only from where BTM is held (like close)
- *
- * We need this to ensure nobody waits for us to finish while we are waiting.
- * Without this we were encountering system stalls.
- *
- * This should be indeed removed with BTM removal later.
- *
- * Locking: BTM required. Nobody is allowed to hold port->mutex.
- */
-static inline void tty_wait_until_sent_from_close(struct tty_struct *tty,
-		long timeout)
-{
-	tty_unlock(tty); /* tty->ops->close holds the BTM, drop it while waiting */
-	tty_wait_until_sent(tty, timeout);
-	tty_lock(tty);
-}
-
-/*
  * wait_event_interruptible_tty -- wait for a condition with the tty lock held
  *
  * The condition we are waiting for might take a long time to
-- 
2.6.1
