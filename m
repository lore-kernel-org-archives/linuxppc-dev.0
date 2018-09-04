Return-Path: <jgg@mellanox.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00050.outbound.protection.outlook.com [40.107.0.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424Z7g3yWtzF38t
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 03:48:27 +1000 (AEST)
Date: Tue, 4 Sep 2018 11:48:08 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Leon Romanovsky <leonro@mellanox.com>
Subject: Regression from patch 'tty: hvc: hvc_poll() break hv read loop'
Message-ID: <20180904174808.GS335@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicholas,

I am testing 4.19-rc2 and I see bad behavior with my qemu hvc0
console..

Running interactive with qemu (qemu-2.11.2-1.fc28) on the console
providing hvc0, using options like:

        -nographic
        -chardev stdio,id=stdio,mux=on,signal=off
        -mon chardev=stdio
	-device isa-serial,chardev=stdio
        -device virtio-serial-pci
	-device virtconsole,chardev=stdio

I see the hvc0 console hang regularly, ie doing something like 'up
arrow' in bash causes the hvc0 console to hang. Prior kernels worked
OK.

Any ideas? I'm not familiar with this code.. Thanks!

git bisect says this patch is to blame:

# bad: [5b394b2ddf0347bef56e50c69a58773c94343ff3] Linux 4.19-rc1
# good: [845b397a7771f2d3504beff5521f452be0d22eec] IB/ucm: fix UCM link error
# bad: [60c1f89241d49bacf71035470684a8d7b4bb46ea] Merge tag 'dma-mapping-4.19-2' of git://git.infradead.org/users/hch/dma-mapping
# bad: [1290290c922fdcefbce8984e6e44b8f4e3a169b5] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
# bad: [6eaac34ff30e189fda28110298ca9fbfb2f51e28] Merge tag 'linux-watchdog-4.19-rc1' of git://www.linux-watchdog.org/linux-watchdog
# good: [e4f6a44c4aeca9eda153302abb0c14d053914f72] staging:rtl8192u: Remove unused macro definitions - Style
# bad: [5695d5d1970f975de059bb6dec76941440f62488] Merge tag 'usb-4.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
# bad: [f80a71b0c4111e26433744721ad68f05c169ad39] Merge tag 'drm-next-2018-08-17' of git://anongit.freedesktop.org/drm/drm
# good: [cf175dc315f90185128fb061dc05b6fbb211aa2f] powerpc/64: Disable the speculation barrier from the command line
# bad: [a2dc009afa9ae8b92305be7728676562a104cb40] powerpc/mm/book3s/radix: Add mapping statistics
# good: [d6690b1a9b0dd95a6fbd166d9657e0cc80afbf99] powerpc: Allow CPU selection of e300core variants
# good: [f2c6d0d1092e3da2bd36c768777e883fa3908548] powerpc/32: Include setup.h header file to fix warnings
# good: [b3124ec2f9970c7374d34b00843d9791fca66afc] Merge branch 'fixes' into next
# bad: [70b5c4ee8e3bf7ce107d6926d9c7d8ebb68578c2] Merge branch 'topic/hvc' into next
# bad: [cfb5946b55f1dfd19e042feae1fbff6041e25a98] tty: hvc: hvc_poll() may sleep
# bad: [ec97eaad1383ab2500fcf9a07ade6044fbcc67f5] tty: hvc: hvc_poll() break hv read loop
# good: [a9bf5c8a271b9a954709b7ada1bd258f5cadf7ff] tty: hvc: use mutex instead of spinlock for hvc_structs lock
# first bad commit: [ec97eaad1383ab2500fcf9a07ade6044fbcc67f5] tty: hvc: hvc_poll() break hv read loop

>From ec97eaad1383ab2500fcf9a07ade6044fbcc67f5 Mon Sep 17 00:00:00 2001
From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 1 May 2018 00:55:54 +1000
Subject: [PATCH] tty: hvc: hvc_poll() break hv read loop

Avoid looping with the spinlock held while there is read data
being returned from the hv driver. Instead note if the entire
size returned by tty_buffer_request_room was read, and request
another read poll.

This limits the critical section lengths, and provides more
even service to other consoles in case there is a pathological
condition.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/tty/hvc/hvc_console.c | 88 ++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index fddb63322c6786..745ac220fce84c 100644
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
2.18.0
