Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZSLX23MhzF2QP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 00:57:08 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id z9so6925959pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 07:57:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] powerpc/powernv: provide a console flush operation for
 opal hvc driver
Date: Tue,  1 May 2018 00:55:58 +1000
Message-Id: <20180430145558.4308-16-npiggin@gmail.com>
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

Provide the flush hv_op for the opal hvc driver. This will flush the
firmware console buffers without spinning with interrupts disabled.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/opal.h       |  1 +
 arch/powerpc/platforms/powernv/opal.c | 83 +++++++++++++++++----------
 drivers/tty/hvc/hvc_opal.c            |  2 +
 3 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 5d7072411561..a426d2caaf9f 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -304,6 +304,7 @@ extern void opal_configure_cores(void);
 extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
 extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
 extern int opal_put_chars_atomic(uint32_t vtermno, const char *buf, int total_len);
+extern int opal_flush_chars(uint32_t vtermno, bool wait);
 extern int opal_flush_console(uint32_t vtermno);
 
 extern void hvc_opal_init_early(void);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index bcdb90ada938..048bc09afc83 100644
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
 
@@ -429,40 +416,74 @@ int opal_put_chars_atomic(uint32_t vtermno, const char *data, int total_len)
 	return __opal_put_chars(vtermno, data, total_len, true);
 }
 
-int opal_flush_console(uint32_t vtermno)
+static s64 __opal_flush_console(uint32_t vtermno)
 {
 	s64 rc;
 
 	if (!opal_check_token(OPAL_CONSOLE_FLUSH)) {
 		__be64 evt;
 
-		WARN_ONCE(1, "opal: OPAL_CONSOLE_FLUSH missing.\n");
 		/*
 		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
 		 * the console can still be flushed by calling the polling
 		 * function while it has OPAL_EVENT_CONSOLE_OUTPUT events.
 		 */
-		do {
-			opal_poll_events(&evt);
-		} while (be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT);
+		WARN_ONCE(1, "opal: OPAL_CONSOLE_FLUSH missing.\n");
+
+		opal_poll_events(&evt);
+		if (!(be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT))
+			return OPAL_SUCCESS;
+		return OPAL_BUSY;
 
-		return OPAL_SUCCESS;
+	} else {
+		rc = opal_console_flush(vtermno);
+		if (rc == OPAL_BUSY_EVENT) {
+			opal_poll_events(NULL);
+			rc = OPAL_BUSY;
+		}
+		return rc;
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
+}
+
+/*
+ * opal_flush_console spins until the console is flushed
+ */
+int opal_flush_console(uint32_t vtermno)
+{
+	for (;;) {
+		s64 rc = __opal_flush_console(vtermno);
+
+		if (rc == OPAL_BUSY || rc == OPAL_PARTIAL) {
+			mdelay(1);
+			continue;
+		}
+
+		return opal_error_code(rc);
+	}
+}
+
+/*
+ * opal_flush_chars is an hvc interface that sleeps until the console is
+ * flushed if wait, otherwise it will return -EBUSY if the console has data,
+ * -EAGAIN if it has data and some of it was flushed.
+ */
+int opal_flush_chars(uint32_t vtermno, bool wait)
+{
+	for (;;) {
+		s64 rc = __opal_flush_console(vtermno);
+
+		if (rc == OPAL_BUSY || rc == OPAL_PARTIAL) {
+			if (wait) {
+				msleep(OPAL_BUSY_DELAY_MS);
+				continue;
 			}
+			if (rc == OPAL_PARTIAL)
+				return -EAGAIN;
 		}
-	} while (rc == OPAL_PARTIAL); /* More to flush */
 
-	return opal_error_code(rc);
+		return opal_error_code(rc);
+	}
 }
 
 static int opal_recover_mce(struct pt_regs *regs,
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 786e76a1e06d..fd306033f8d4 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -52,6 +52,7 @@ static u32 hvc_opal_boot_termno;
 static const struct hv_ops hvc_opal_raw_ops = {
 	.get_chars = opal_get_chars,
 	.put_chars = opal_put_chars,
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
