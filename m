Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZSLD6SF8zF2Q7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 00:56:52 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id n9-v6so6481063pgq.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 07:56:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] tty: hvc: hvc_poll break hv read loop
Date: Tue,  1 May 2018 00:55:54 +1000
Message-Id: <20180430145558.4308-12-npiggin@gmail.com>
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avoid looping with the spinlock held while there is read data
being returned from the hv driver. Instead note if the entire
size returned by tty_buffer_request_room was read, and request
another read poll.

This limits the critical section lengths, and provides more
even service to other consoles in case there is a pathological
condition.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 88 ++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index fddb63322c67..745ac220fce8 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -592,7 +592,7 @@ static u32 timeout = MIN_TIMEOUT;
 int hvc_poll(struct hvc_struct *hp)
 {
 	struct tty_struct *tty;
-	int i, n, poll_mask = 0;
+	int i, n, count, poll_mask = 0;
 	char buf[N_INBUF] __ALIGNED__;
 	unsigned long flags;
 	int read_total = 0;
@@ -618,7 +618,7 @@ int hvc_poll(struct hvc_struct *hp)
 
 	/* Now check if we can get data (are we throttled ?) */
 	if (tty_throttled(tty))
-		goto throttled;
+		goto out;
 
 	/* If we aren't notifier driven and aren't throttled, we always
 	 * request a reschedule
@@ -627,56 +627,58 @@ int hvc_poll(struct hvc_struct *hp)
 		poll_mask |= HVC_POLL_READ;
 
 	/* Read data if any */
-	for (;;) {
-		int count = tty_buffer_request_room(&hp->port, N_INBUF);
 
-		/* If flip is full, just reschedule a later read */
-		if (count == 0) {
+	count = tty_buffer_request_room(&hp->port, N_INBUF);
+
+	/* If flip is full, just reschedule a later read */
+	if (count == 0) {
+		poll_mask |= HVC_POLL_READ;
+		goto out;
+	}
+
+	n = hp->ops->get_chars(hp->vtermno, buf, count);
+	if (n <= 0) {
+		/* Hangup the tty when disconnected from host */
+		if (n == -EPIPE) {
+			spin_unlock_irqrestore(&hp->lock, flags);
+			tty_hangup(tty);
+			spin_lock_irqsave(&hp->lock, flags);
+		} else if ( n == -EAGAIN ) {
+			/*
+			 * Some back-ends can only ensure a certain min
+			 * num of bytes read, which may be > 'count'.
+			 * Let the tty clear the flip buff to make room.
+			 */
 			poll_mask |= HVC_POLL_READ;
-			break;
 		}
+		goto out;
+	}
 
-		n = hp->ops->get_chars(hp->vtermno, buf, count);
-		if (n <= 0) {
-			/* Hangup the tty when disconnected from host */
-			if (n == -EPIPE) {
-				spin_unlock_irqrestore(&hp->lock, flags);
-				tty_hangup(tty);
-				spin_lock_irqsave(&hp->lock, flags);
-			} else if ( n == -EAGAIN ) {
-				/*
-				 * Some back-ends can only ensure a certain min
-				 * num of bytes read, which may be > 'count'.
-				 * Let the tty clear the flip buff to make room.
-				 */
-				poll_mask |= HVC_POLL_READ;
-			}
-			break;
-		}
-		for (i = 0; i < n; ++i) {
+	for (i = 0; i < n; ++i) {
 #ifdef CONFIG_MAGIC_SYSRQ
-			if (hp->index == hvc_console.index) {
-				/* Handle the SysRq Hack */
-				/* XXX should support a sequence */
-				if (buf[i] == '\x0f') {	/* ^O */
-					/* if ^O is pressed again, reset
-					 * sysrq_pressed and flip ^O char */
-					sysrq_pressed = !sysrq_pressed;
-					if (sysrq_pressed)
-						continue;
-				} else if (sysrq_pressed) {
-					handle_sysrq(buf[i]);
-					sysrq_pressed = 0;
+		if (hp->index == hvc_console.index) {
+			/* Handle the SysRq Hack */
+			/* XXX should support a sequence */
+			if (buf[i] == '\x0f') {	/* ^O */
+				/* if ^O is pressed again, reset
+				 * sysrq_pressed and flip ^O char */
+				sysrq_pressed = !sysrq_pressed;
+				if (sysrq_pressed)
 					continue;
-				}
+			} else if (sysrq_pressed) {
+				handle_sysrq(buf[i]);
+				sysrq_pressed = 0;
+				continue;
 			}
-#endif /* CONFIG_MAGIC_SYSRQ */
-			tty_insert_flip_char(&hp->port, buf[i], 0);
 		}
-
-		read_total += n;
+#endif /* CONFIG_MAGIC_SYSRQ */
+		tty_insert_flip_char(&hp->port, buf[i], 0);
 	}
- throttled:
+	if (n == count)
+		poll_mask |= HVC_POLL_READ;
+	read_total = n;
+
+ out:
 	/* Wakeup write queue if necessary */
 	if (hp->do_wakeup) {
 		hp->do_wakeup = 0;
-- 
2.17.0
