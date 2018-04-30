Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZSLS2QDhzF2QD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 00:57:04 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id k11-v6so5365009pgo.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 07:57:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] tty: hvc: introduce the hv_ops.flush operation for hvc
 drivers
Date: Tue,  1 May 2018 00:55:57 +1000
Message-Id: <20180430145558.4308-15-npiggin@gmail.com>
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

Use .flush to wait for drivers to flush their console outside of
the spinlock, to reduce lock/irq latencies.

Flush the hvc console driver after each write, which can help
messages make it out to the console after a crash.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 35 +++++++++++++++++++++++++++++++++--
 drivers/tty/hvc/hvc_console.h |  1 +
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 6131d5084c42..5414c4a87bea 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -110,6 +110,29 @@ static struct hvc_struct *hvc_get_by_index(int index)
 	return hp;
 }
 
+static int __hvc_flush(const struct hv_ops *ops, uint32_t vtermno, bool wait)
+{
+	if (wait)
+		might_sleep();
+
+	if (ops->flush)
+		return ops->flush(vtermno, wait);
+	return 0;
+}
+
+static int hvc_console_flush(const struct hv_ops *ops, uint32_t vtermno)
+{
+	return __hvc_flush(ops, vtermno, false);
+}
+
+/*
+ * Wait for the console to flush before writing more to it. This sleeps.
+ */
+static int hvc_flush(struct hvc_struct *hp)
+{
+	return __hvc_flush(hp->ops, hp->vtermno, true);
+}
+
 /*
  * Initial console vtermnos for console API usage prior to full console
  * initialization.  Any vty adapter outside this range will not have usable
@@ -155,8 +178,12 @@ static void hvc_console_print(struct console *co, const char *b,
 			if (r <= 0) {
 				/* throw away characters on error
 				 * but spin in case of -EAGAIN */
-				if (r != -EAGAIN)
+				if (r != -EAGAIN) {
 					i = 0;
+				} else {
+					hvc_console_flush(cons_ops[index],
+						      vtermnos[index]);
+				}
 			} else if (r > 0) {
 				i -= r;
 				if (i > 0)
@@ -164,6 +191,7 @@ static void hvc_console_print(struct console *co, const char *b,
 			}
 		}
 	}
+	hvc_console_flush(cons_ops[index], vtermnos[index]);
 }
 
 static struct tty_driver *hvc_console_device(struct console *c, int *index)
@@ -513,8 +541,11 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 
 		spin_unlock_irqrestore(&hp->lock, flags);
 
-		if (count)
+		if (count) {
+			if (hp->n_outbuf > 0)
+				hvc_flush(hp);
 			cond_resched();
+		}
 	}
 
 	/*
diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index ea63090e013f..e9319954c832 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -54,6 +54,7 @@ struct hvc_struct {
 struct hv_ops {
 	int (*get_chars)(uint32_t vtermno, char *buf, int count);
 	int (*put_chars)(uint32_t vtermno, const char *buf, int count);
+	int (*flush)(uint32_t vtermno, bool wait);
 
 	/* Callbacks for notification. Called in open, close and hangup */
 	int (*notifier_add)(struct hvc_struct *hp, int irq);
-- 
2.17.0
