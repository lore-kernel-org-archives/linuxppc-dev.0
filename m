Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KK0p0vJ9zDqfk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:41:13 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id o16so5223991pfk.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:41:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH 2/6] powerpc/powernv: Implement and use opal_flush_console
Date: Mon,  9 Apr 2018 15:40:52 +1000
Message-Id: <20180409054056.27292-3-npiggin@gmail.com>
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

A new console flushing firmware API was introduced to replace event
polling loops, and implemented in opal-kmsg with affddff69c55e
("powerpc/powernv: Add a kmsg_dumper that flushes console output on
panic"), to flush the console in the panic path.

The OPAL console driver has other situations where interrupts are off
and it needs to flush the console synchronously. These still use a
polling loop.

So move the opal-kmsg flush code to opal_flush_console, and use the
new function in opal-kmsg and opal_put_chars.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell Currey <ruscur@russell.cc>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/opal.h            |  1 +
 arch/powerpc/platforms/powernv/opal-kmsg.c | 35 ++----------------
 arch/powerpc/platforms/powernv/opal.c      | 42 +++++++++++++++++++---
 3 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 03e1a920491e..bbff49fab0e5 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -303,6 +303,7 @@ extern void opal_configure_cores(void);
 
 extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
 extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
+extern int opal_flush_console(uint32_t vtermno);
 
 extern void hvc_opal_init_early(void);
 
diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
index fd2bbf4fd6dc..55691950d981 100644
--- a/arch/powerpc/platforms/powernv/opal-kmsg.c
+++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/kmsg_dump.h>
-#include <linux/delay.h>
 
 #include <asm/opal.h>
 #include <asm/opal-api.h>
@@ -24,11 +23,9 @@
  * may not be completely printed.  This function does not actually dump the
  * message, it just ensures that OPAL completely flushes the console buffer.
  */
-static void force_opal_console_flush(struct kmsg_dumper *dumper,
+static void kmsg_dump_opal_console_flush(struct kmsg_dumper *dumper,
 				     enum kmsg_dump_reason reason)
 {
-	s64 rc;
-
 	/*
 	 * Outside of a panic context the pollers will continue to run,
 	 * so we don't need to do any special flushing.
@@ -36,37 +33,11 @@ static void force_opal_console_flush(struct kmsg_dumper *dumper,
 	if (reason != KMSG_DUMP_PANIC)
 		return;
 
-	if (opal_check_token(OPAL_CONSOLE_FLUSH)) {
-		do  {
-			rc = OPAL_BUSY;
-			while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-				rc = opal_console_flush(0);
-				if (rc == OPAL_BUSY_EVENT) {
-					mdelay(OPAL_BUSY_DELAY_MS);
-					opal_poll_events(NULL);
-				} else if (rc == OPAL_BUSY) {
-					mdelay(OPAL_BUSY_DELAY_MS);
-				}
-			}
-		} while (rc == OPAL_PARTIAL); /* More to flush */
-
-	} else {
-		__be64 evt;
-
-		WARN_ONCE(1, "opal: OPAL_CONSOLE_FLUSH missing.\n");
-		/*
-		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
-		 * the console can still be flushed by calling the polling
-		 * function while it has OPAL_EVENT_CONSOLE_OUTPUT events.
-		 */
-		do {
-			opal_poll_events(&evt);
-		} while (be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT);
-	}
+	opal_flush_console(0);
 }
 
 static struct kmsg_dumper opal_kmsg_dumper = {
-	.dump = force_opal_console_flush
+	.dump = kmsg_dump_opal_console_flush
 };
 
 void __init opal_kmsg_init(void)
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 0f03199a8664..d54ac3736c34 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -350,7 +350,6 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	__be64 olen;
 	s64 len, rc;
 	unsigned long flags;
-	__be64 evt;
 
 	if (!opal.entry)
 		return -ENODEV;
@@ -371,7 +370,7 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 		/* Closed -> drop characters */
 		if (rc)
 			return total_len;
-		opal_poll_events(NULL);
+		opal_flush_console(vtermno);
 		return -EAGAIN;
 	}
 
@@ -410,12 +409,47 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 		 * things a bit later to limit that to synchronous path
 		 * such as the kernel console and xmon/udbg
 		 */
+		opal_flush_console(vtermno);
+	}
+	spin_unlock_irqrestore(&opal_write_lock, flags);
+
+	return written;
+}
+
+int opal_flush_console(uint32_t vtermno)
+{
+	s64 rc;
+
+	if (!opal_check_token(OPAL_CONSOLE_FLUSH)) {
+		__be64 evt;
+
+		WARN_ONCE(1, "opal: OPAL_CONSOLE_FLUSH missing.\n");
+		/*
+		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
+		 * the console can still be flushed by calling the polling
+		 * function while it has OPAL_EVENT_CONSOLE_OUTPUT events.
+		 */
 		do {
 			opal_poll_events(&evt);
 		} while (be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT);
+
+		return OPAL_SUCCESS;
 	}
-	spin_unlock_irqrestore(&opal_write_lock, flags);
-	return written;
+
+	do  {
+		rc = OPAL_BUSY;
+		while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+			rc = opal_console_flush(vtermno);
+			if (rc == OPAL_BUSY_EVENT) {
+				mdelay(OPAL_BUSY_DELAY_MS);
+				opal_poll_events(NULL);
+			} else if (rc == OPAL_BUSY) {
+				mdelay(OPAL_BUSY_DELAY_MS);
+			}
+		}
+	} while (rc == OPAL_PARTIAL); /* More to flush */
+
+	return opal_error_code(rc);
 }
 
 static int opal_recover_mce(struct pt_regs *regs,
-- 
2.17.0
