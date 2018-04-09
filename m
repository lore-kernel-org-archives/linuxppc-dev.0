Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x231.google.com (mail-pl0-x231.google.com
 [IPv6:2607:f8b0:400e:c01::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KSTz3hpmzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 21:18:30 +1000 (AEST)
Received: by mail-pl0-x231.google.com with SMTP id v5-v6so4907919plo.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Apr 2018 04:18:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH RFC] hvc: provide a flush operation, implement for opal console,
 and use in hvc console
Date: Mon,  9 Apr 2018 21:18:18 +1000
Message-Id: <20180409111818.15465-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is not quite polished and needs to be split out, but the
idea is to move busy waits in hvc console drivers out from under locks
and into the main hvc driver where it can sleep.

The flush op allows for a 0 timeout which reverts to spin wait
behaviour to cater for polling cases. A default operation is
used for drivers that don't supply one, and they should get
some benefit too just from sleeping outside locks.

This applies on top of the recent series of opal console patches.

Before this patch it is possible to see large interrupts off delays
caused by hvc_push->opal_put_chars_nonatomic->opal_flush_console
despite the previous series moved the flush from under the opal
driver's output lock, because hvc_push is called with the hvc lock.

This is an irqsoff trace collected after running `dmesg` from the
OpenBMC console:

   dmesg-8334   12d...    0us : _raw_spin_lock_irqsave
   dmesg-8334   12d...    0us : hvc_push <-hvc_write
   dmesg-8334   12d...    1us : opal_put_chars_nonatomic <-hvc_push
   dmesg-8334   12d...    1us : __opal_put_chars <-hvc_push
   dmesg-8334   12d...    2us : opal_flush_console <-__opal_put_chars
   dmesg-8334   12d...    4us!: udelay <-opal_flush_console
   dmesg-8334   12d...  787us : soft_nmi_interrupt <-soft_nmi_common
   dmesg-8334   12d...  787us : printk_nmi_enter <-soft_nmi_interrupt
   dmesg-8334   12d.Z.  788us : rcu_nmi_enter <-soft_nmi_interrupt
   dmesg-8334   12d.Z.  788us : rcu_nmi_exit <-soft_nmi_interrupt
   dmesg-8334   12d...  788us#: printk_nmi_exit <-soft_nmi_interrupt
   dmesg-8334   12d... 10005us*: udelay <-opal_flush_console
   dmesg-8334   12d... 20007us*: udelay <-opal_flush_console
   dmesg-8334   12d... 30020us*: udelay <-opal_flush_console
   dmesg-8334   12d... 40022us*: udelay <-opal_flush_console
   dmesg-8334   12d... 50023us*: udelay <-opal_flush_console
   dmesg-8334   12d... 60024us : opal_error_code <-opal_flush_console
   dmesg-8334   12d... 60025us : _raw_spin_unlock_irqrestore <-hvc_write
   dmesg-8334   12d... 60025us : _raw_spin_unlock_irqrestore
   dmesg-8334   12d... 60025us : trace_hardirqs_on <-_raw_spin_unlock_irqrestore
   dmesg-8334   12d... 60027us : <stack trace>

After this patch, the same operation does not show latency above
the noise of an idle system (~400us).

Impossible to tell the responsiveness difference with my ping 200-400ms
to the BMC. It's not noticably worse.

---
 arch/powerpc/include/asm/opal.h       |   1 +
 arch/powerpc/platforms/powernv/opal.c |  74 ++++++++++--------
 drivers/tty/hvc/hvc_console.c         | 106 ++++++++++++++++++++------
 drivers/tty/hvc/hvc_console.h         |   1 +
 drivers/tty/hvc/hvc_opal.c            |   2 +
 5 files changed, 129 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 66954d671831..115c8a5a0bfd 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -304,6 +304,7 @@ extern void opal_configure_cores(void);
 extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
 extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
 extern int opal_put_chars_nonatomic(uint32_t vtermno, const char *buf, int total_len);
+extern int opal_flush_chars(uint32_t vtermno, long timeout);
 extern int opal_flush_console(uint32_t vtermno);
 
 extern void hvc_opal_init_early(void);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 5e0f6b1bb4ba..fe71dee729ea 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -370,12 +370,8 @@ static int __opal_put_chars(uint32_t vtermno, const char *data, int total_len, b
 	olen = cpu_to_be64(total_len);
 	rc = opal_console_write(vtermno, &olen, data);
 	if (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-		if (rc == OPAL_BUSY_EVENT) {
-			mdelay(OPAL_BUSY_DELAY_MS);
+		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
-		} else if (rc == OPAL_BUSY_EVENT) {
-			mdelay(OPAL_BUSY_DELAY_MS);
-		}
 		written = -EAGAIN;
 		goto out;
 	}
@@ -401,15 +397,6 @@ static int __opal_put_chars(uint32_t vtermno, const char *data, int total_len, b
 	if (atomic)
 		spin_unlock_irqrestore(&opal_write_lock, flags);
 
-	/* In the -EAGAIN case, callers loop, so we have to flush the console
-	 * here in case they have interrupts off (and we don't want to wait
-	 * for async flushing if we can make immediate progress here). If
-	 * necessary the API could be made entirely non-flushing if the
-	 * callers had a ->flush API to use.
-	 */
-	if (written == -EAGAIN)
-		opal_flush_console(vtermno);
-
 	return written;
 }
 
@@ -427,40 +414,63 @@ int opal_put_chars_nonatomic(uint32_t vtermno, const char *data, int total_len)
 	return __opal_put_chars(vtermno, data, total_len, false);
 }
 
-int opal_flush_console(uint32_t vtermno)
+static int __opal_flush_console(uint32_t vtermno, long timeout)
 {
 	s64 rc;
+	unsigned long end = jiffies + msecs_to_jiffies(timeout);
 
 	if (!opal_check_token(OPAL_CONSOLE_FLUSH)) {
-		__be64 evt;
-
 		WARN_ONCE(1, "opal: OPAL_CONSOLE_FLUSH missing.\n");
 		/*
 		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
 		 * the console can still be flushed by calling the polling
 		 * function while it has OPAL_EVENT_CONSOLE_OUTPUT events.
 		 */
-		do {
-			opal_poll_events(&evt);
-		} while (be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT);
+		for (;;) {
+			__be64 evt;
 
-		return OPAL_SUCCESS;
+			opal_poll_events(&evt);
+			if (!(be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT))
+				return OPAL_SUCCESS;
+
+			if (timeout) {
+				if ((timeout != -1) && time_after(jiffies, end))
+					return OPAL_BUSY;
+				schedule_timeout(msecs_to_jiffies(OPAL_BUSY_DELAY_MS));
+			} else {
+				mdelay(1);
+			}
+		}
 	}
 
-	do  {
-		rc = OPAL_BUSY;
-		while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-			rc = opal_console_flush(vtermno);
-			if (rc == OPAL_BUSY_EVENT) {
-				mdelay(OPAL_BUSY_DELAY_MS);
-				opal_poll_events(NULL);
-			} else if (rc == OPAL_BUSY) {
-				mdelay(OPAL_BUSY_DELAY_MS);
+	for (;;) {
+		rc = opal_console_flush(vtermno);
+		if (rc == OPAL_BUSY_EVENT || rc == OPAL_BUSY || rc == OPAL_PARTIAL) {
+			if (timeout) {
+				if ((timeout != -1) && time_after(jiffies, end))
+					return OPAL_BUSY;
+				schedule_timeout(msecs_to_jiffies(OPAL_BUSY_DELAY_MS));
+			} else {
+				mdelay(1);
 			}
+			if (rc == OPAL_BUSY_EVENT)
+				opal_poll_events(NULL);
+
+		} else {
+			return opal_error_code(rc);
 		}
-	} while (rc == OPAL_PARTIAL); /* More to flush */
+	}
+
+}
 
-	return opal_error_code(rc);
+int opal_flush_console(uint32_t vtermno)
+{
+	return __opal_flush_console(vtermno, 0);
+}
+
+int opal_flush_chars(uint32_t vtermno, long timeout)
+{
+	return __opal_flush_console(vtermno, timeout);
 }
 
 static int opal_recover_mce(struct pt_regs *regs,
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 7709fcc707f4..8b283d77f691 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -110,6 +110,23 @@ static struct hvc_struct *hvc_get_by_index(int index)
 	return hp;
 }
 
+static int hvc_flush_default(uint32_t vtermno, long timeout)
+{
+	if (timeout)
+		msleep(1);
+	else
+		mdelay(1);
+
+	return 0;
+}
+
+static int do_hvc_flush_op(const struct hv_ops *ops, uint32_t vtermno, long timeout)
+{
+	if (ops->flush)
+		return ops->flush(vtermno, timeout);
+	else
+		return hvc_flush_default(vtermno, timeout);
+}
 
 /*
  * Initial console vtermnos for console API usage prior to full console
@@ -153,11 +170,14 @@ static void hvc_console_print(struct console *co, const char *b,
 			}
 		} else {
 			r = cons_ops[index]->put_chars(vtermnos[index], c, i);
-			if (r <= 0) {
-				/* throw away characters on error
-				 * but spin in case of -EAGAIN */
-				if (r != -EAGAIN)
+			if (r == 0 || r == -EAGAIN) {
+				r = do_hvc_flush_op(cons_ops[index],
+						     vtermnos[index], 0);
+				if (r)
 					i = 0;
+			} else if (r < 0) {
+				/* throw away characters on error */
+				i = 0;
 			} else if (r > 0) {
 				i -= r;
 				if (i > 0)
@@ -480,6 +500,15 @@ static int hvc_push(struct hvc_struct *hp)
 	return n;
 }
 
+/*
+ * Wait for the console to flush before writing more to it. This sleeps.
+ */
+static int hvc_flush(struct hvc_struct *hp)
+{
+	might_sleep();
+	return do_hvc_flush_op(hp->ops, hp->vtermno, -1);
+}
+
 static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
 	struct hvc_struct *hp = tty->driver_data;
@@ -494,23 +523,37 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 	if (hp->port.count <= 0)
 		return -EIO;
 
-	spin_lock_irqsave(&hp->lock, flags);
+	while (count > 0) {
+		cond_resched();
 
-	/* Push pending writes */
-	if (hp->n_outbuf > 0)
-		hvc_push(hp);
-
-	while (count > 0 && (rsize = hp->outbuf_size - hp->n_outbuf) > 0) {
-		if (rsize > count)
-			rsize = count;
-		memcpy(hp->outbuf + hp->n_outbuf, buf, rsize);
-		count -= rsize;
-		buf += rsize;
-		hp->n_outbuf += rsize;
-		written += rsize;
-		hvc_push(hp);
+		spin_lock_irqsave(&hp->lock, flags);
+
+		rsize = hp->outbuf_size - hp->n_outbuf;
+		if (hp->n_outbuf && rsize < count) {
+			/* Push pending writes */
+			hvc_push(hp);
+			rsize = hp->outbuf_size - hp->n_outbuf;
+		}
+
+		if (rsize) {
+			if (rsize > count)
+				rsize = count;
+			memcpy(hp->outbuf + hp->n_outbuf, buf, rsize);
+			count -= rsize;
+			buf += rsize;
+			hp->n_outbuf += rsize;
+			written += rsize;
+
+			hvc_push(hp);
+		}
+
+		spin_unlock_irqrestore(&hp->lock, flags);
+
+		if (count) {
+			/* Flush the console and try again */
+			hvc_flush(hp);
+		}
 	}
-	spin_unlock_irqrestore(&hp->lock, flags);
 
 	/*
 	 * Racy, but harmless, kick thread if there is still pending data.
@@ -612,6 +655,12 @@ int hvc_poll(struct hvc_struct *hp)
 		timeout = (written_total) ? 0 : MIN_TIMEOUT;
 	}
 
+	spin_unlock_irqrestore(&hp->lock, flags);
+
+	cond_resched();
+
+	spin_lock_irqsave(&hp->lock, flags);
+
 	/* No tty attached, just skip */
 	tty = tty_port_tty_get(&hp->port);
 	if (tty == NULL)
@@ -810,11 +859,22 @@ static void hvc_poll_put_char(struct tty_driver *driver, int line, char ch)
 {
 	struct tty_struct *tty = driver->ttys[0];
 	struct hvc_struct *hp = tty->driver_data;
-	int n;
 
-	do {
-		n = hp->ops->put_chars(hp->vtermno, &ch, 1);
-	} while (n <= 0);
+	/*
+	 * Can't do much error handling, just drop characters.
+	 */
+	for (;;) {
+		int rc;
+
+		rc = hp->ops->put_chars(hp->vtermno, &ch, 1);
+		if (rc == 0 || rc == -EAGAIN) {
+			rc = do_hvc_flush_op(hp->ops, hp->vtermno, 0);
+			if (rc)
+				break;
+			continue;
+		}
+		break;
+	}
 }
 #endif
 
diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index ea63090e013f..6ae9e0c3b06f 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -54,6 +54,7 @@ struct hvc_struct {
 struct hv_ops {
 	int (*get_chars)(uint32_t vtermno, char *buf, int count);
 	int (*put_chars)(uint32_t vtermno, const char *buf, int count);
+	int (*flush)(uint32_t vtermno, long timeout);
 
 	/* Callbacks for notification. Called in open, close and hangup */
 	int (*notifier_add)(struct hvc_struct *hp, int irq);
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 436b98258e60..782895c659d7 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -52,6 +52,7 @@ static u32 hvc_opal_boot_termno;
 static const struct hv_ops hvc_opal_raw_ops = {
 	.get_chars = opal_get_chars,
 	.put_chars = opal_put_chars_nonatomic,
+	.flush = opal_flush_chars,
 	.notifier_add = notifier_add_irq,
 	.notifier_del = notifier_del_irq,
 	.notifier_hangup = notifier_hangup_irq,
@@ -141,6 +142,7 @@ static int hvc_opal_hvsi_tiocmset(struct hvc_struct *hp, unsigned int set,
 static const struct hv_ops hvc_opal_hvsi_ops = {
 	.get_chars = hvc_opal_hvsi_get_chars,
 	.put_chars = hvc_opal_hvsi_put_chars,
+	.flush = opal_flush_chars,
 	.notifier_add = hvc_opal_hvsi_open,
 	.notifier_del = hvc_opal_hvsi_close,
 	.notifier_hangup = hvc_opal_hvsi_hangup,
-- 
2.17.0
