Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KK0y5W9GzDrLj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:41:22 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id v5-v6so4482643plo.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:41:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/6] powerpc/powernv: implement opal_put_chars_nonatomic
Date: Mon,  9 Apr 2018 15:40:55 +1000
Message-Id: <20180409054056.27292-6-npiggin@gmail.com>
In-Reply-To: <20180409054056.27292-1-npiggin@gmail.com>
References: <20180409054056.27292-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RAW console does not need writes to be atomic, so implement a
_nonatomic variant which does not take a spinlock. This API is used
in xmon, so the less locking thta's used, the better chance there is
that a crash can be debugged.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/opal.h       |  1 +
 arch/powerpc/platforms/powernv/opal.c | 35 +++++++++++++++++++--------
 drivers/tty/hvc/hvc_opal.c            |  4 +--
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index bbff49fab0e5..66954d671831 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -303,6 +303,7 @@ extern void opal_configure_cores(void);
 
 extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
 extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
+extern int opal_put_chars_nonatomic(uint32_t vtermno, const char *buf, int total_len);
 extern int opal_flush_console(uint32_t vtermno);
 
 extern void hvc_opal_init_early(void);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index b05500a70f58..dc77fc57d1e9 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -344,9 +344,9 @@ int opal_get_chars(uint32_t vtermno, char *buf, int count)
 	return 0;
 }
 
-int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
+static int __opal_put_chars(uint32_t vtermno, const char *data, int total_len, bool atomic)
 {
-	unsigned long flags;
+	unsigned long flags = 0 /* shut up gcc */;
 	int written;
 	__be64 olen;
 	s64 rc;
@@ -354,11 +354,8 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	if (!opal.entry)
 		return -ENODEV;
 
-	/* We want put_chars to be atomic to avoid mangling of hvsi
-	 * packets. To do that, we first test for room and return
-	 * -EAGAIN if there isn't enough.
-	 */
-	spin_lock_irqsave(&opal_write_lock, flags);
+	if (atomic)
+		spin_lock_irqsave(&opal_write_lock, flags);
 	rc = opal_console_write_buffer_space(vtermno, &olen);
 	if (rc || be64_to_cpu(olen) < total_len) {
 		/* Closed -> drop characters */
@@ -391,14 +388,18 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 
 	written = be64_to_cpu(olen);
 	if (written < total_len) {
-		/* Should not happen */
-		pr_warn("atomic console write returned partial len=%d written=%d\n", total_len, written);
+		if (atomic) {
+			/* Should not happen */
+			pr_warn("atomic console write returned partial "
+				"len=%d written=%d\n", total_len, written);
+		}
 		if (!written)
 			written = -EAGAIN;
 	}
 
 out:
-	spin_unlock_irqrestore(&opal_write_lock, flags);
+	if (atomic)
+		spin_unlock_irqrestore(&opal_write_lock, flags);
 
 	/* In the -EAGAIN case, callers loop, so we have to flush the console
 	 * here in case they have interrupts off (and we don't want to wait
@@ -412,6 +413,20 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	return written;
 }
 
+int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
+{
+	/* We want put_chars to be atomic to avoid mangling of hvsi
+	 * packets. To do that, we first test for room and return
+	 * -EAGAIN if there isn't enough.
+	 */
+	return __opal_put_chars(vtermno, data, total_len, true);
+}
+
+int opal_put_chars_nonatomic(uint32_t vtermno, const char *data, int total_len)
+{
+	return __opal_put_chars(vtermno, data, total_len, false);
+}
+
 int opal_flush_console(uint32_t vtermno)
 {
 	s64 rc;
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index af122ad7f06d..e151cfacf2a7 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -51,7 +51,7 @@ static u32 hvc_opal_boot_termno;
 
 static const struct hv_ops hvc_opal_raw_ops = {
 	.get_chars = opal_get_chars,
-	.put_chars = opal_put_chars,
+	.put_chars = opal_put_chars_nonatomic,
 	.notifier_add = notifier_add_irq,
 	.notifier_del = notifier_del_irq,
 	.notifier_hangup = notifier_hangup_irq,
@@ -269,7 +269,7 @@ static void udbg_opal_putc(char c)
 	do {
 		switch(hvc_opal_boot_priv.proto) {
 		case HV_PROTOCOL_RAW:
-			count = opal_put_chars(termno, &c, 1);
+			count = opal_put_chars_nonatomic(termno, &c, 1);
 			break;
 		case HV_PROTOCOL_HVSI:
 			count = hvc_opal_hvsi_put_chars(termno, &c, 1);
-- 
2.17.0
