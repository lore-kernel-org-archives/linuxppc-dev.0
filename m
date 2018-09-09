Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427KkK2t6qzF3Bh
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2018 15:39:37 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id 2-v6so8879178pgo.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Sep 2018 22:39:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Jiri Slaby <jslaby@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Matteo Croce <mcroce@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Leon Romanovsky <leonro@mellanox.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: [PATCH v2 2/3] tty: hvc: hvc_poll() fix read loop batching
Date: Sun,  9 Sep 2018 15:39:15 +1000
Message-Id: <20180909053916.14139-3-npiggin@gmail.com>
In-Reply-To: <20180909053916.14139-1-npiggin@gmail.com>
References: <20180909053916.14139-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit ec97eaad1383 ("tty: hvc: hvc_poll() break hv read loop")
removes get_chars batching entirely, which slows down large console
operations like paste -- virtio console "feels worse than a 9600 baud
serial line," reports Matteo.

This adds back batching in a more latency friendly way. If the caller
can sleep then we try to fill the entire flip buffer, releasing the
lock and scheduling between each iteration. If it can not sleep, then
batches are limited to 128 bytes. Matteo confirms this fixes the
performance problem.

Latency testing the powerpc OPAL console with OpenBMC UART with a
large paste shows about 0.25ms latency, which seems reasonable. 10ms
latencies were typical for this case before the latency breaking work,
so we still see most of the benefit.

  kopald-1204    0d.h.    5us : hvc_poll <-hvc_handle_interrupt
  kopald-1204    0d.h.    5us : __hvc_poll <-hvc_handle_interrupt
  kopald-1204    0d.h.    5us : _raw_spin_lock_irqsave <-__hvc_poll
  kopald-1204    0d.h.    5us : tty_port_tty_get <-__hvc_poll
  kopald-1204    0d.h.    6us : _raw_spin_lock_irqsave <-tty_port_tty_get
  kopald-1204    0d.h.    6us : _raw_spin_unlock_irqrestore <-tty_port_tty_get
  kopald-1204    0d.h.    6us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.    7us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.    7us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.   36us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.   36us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.   36us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.   65us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.   65us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.   66us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.   94us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.   95us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.   95us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.  124us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  124us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  125us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.  154us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  154us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  154us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.  183us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  184us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  184us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.  213us : tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  213us : __tty_buffer_request_room <-__hvc_poll
  kopald-1204    0d.h.  213us+: opal_get_chars <-__hvc_poll
  kopald-1204    0d.h.  242us : _raw_spin_unlock_irqrestore <-__hvc_poll
  kopald-1204    0d.h.  242us : tty_flip_buffer_push <-__hvc_poll
  kopald-1204    0d.h.  243us : queue_work_on <-tty_flip_buffer_push
  kopald-1204    0d.h.  243us : tty_kref_put <-__hvc_poll
  kopald-1204    0d.h.  243us : hvc_kick <-hvc_handle_interrupt
  kopald-1204    0d.h.  243us : wake_up_process <-hvc_kick
  kopald-1204    0d.h.  244us : try_to_wake_up <-hvc_kick
  kopald-1204    0d.h.  244us : _raw_spin_lock_irqsave <-try_to_wake_up
  kopald-1204    0d.h.  244us : _raw_spin_unlock_irqrestore <-try_to_wake_up

Reported-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index c917749708d2..bacf9b73ec98 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -623,6 +623,15 @@ static int hvc_chars_in_buffer(struct tty_struct *tty)
 #define MAX_TIMEOUT		(2000)
 static u32 timeout = MIN_TIMEOUT;
 
+/*
+ * Maximum number of bytes to get from the console driver if hvc_poll is
+ * called from driver (and can't sleep). Any more than this and we break
+ * and start polling with khvcd. This value was derived from from an OpenBMC
+ * console with the OPAL driver that results in about 0.25ms interrupts off
+ * latency.
+ */
+#define HVC_ATOMIC_READ_MAX	128
+
 #define HVC_POLL_READ	0x00000001
 #define HVC_POLL_WRITE	0x00000002
 
@@ -669,8 +678,8 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 	if (!hp->irq_requested)
 		poll_mask |= HVC_POLL_READ;
 
+ read_again:
 	/* Read data if any */
-
 	count = tty_buffer_request_room(&hp->port, N_INBUF);
 
 	/* If flip is full, just reschedule a later read */
@@ -717,7 +726,18 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 #endif /* CONFIG_MAGIC_SYSRQ */
 		tty_insert_flip_char(&hp->port, buf[i], 0);
 	}
-	read_total = n;
+	read_total += n;
+
+	if (may_sleep) {
+		/* Keep going until the flip is full */
+		spin_unlock_irqrestore(&hp->lock, flags);
+		cond_resched();
+		spin_lock_irqsave(&hp->lock, flags);
+		goto read_again;
+	} else if (read_total < HVC_ATOMIC_READ_MAX) {
+		/* Break and defer if it's a large read in atomic */
+		goto read_again;
+	}
 
 	/*
 	 * Latency break, schedule another poll immediately.
-- 
2.18.0
