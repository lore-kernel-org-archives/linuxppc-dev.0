Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KK0t30z0zDrJx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:41:18 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id b6-v6so4481212pla.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:41:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/6] powerpc/powernv: Remove OPALv1 support from opal console
 driver
Date: Mon,  9 Apr 2018 15:40:53 +1000
Message-Id: <20180409054056.27292-4-npiggin@gmail.com>
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

opal_put_chars deals with partial writes because in OPALv1,
opal_console_write_buffer_space did not work correctly. That firmware
is not supported.

This reworks the opal_put_chars code to no longer deal with partial
writes and turn them into full writes. Partial write handling is still
supported in terms of what gets returned to the caller, but it may not
go to the console atomically. A warning message is printed in this
case.

This allows console flushing to be moved out of the opal_write_lock
spinlock. That could cause the lock to be held for long periods if the
console is busy (especially if it was being spammed by firmware),
which is dangerous because the lock is taken by xmon to debug the
system. Flushing outside the lock improves the situation a bit.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 86 +++++++++++++--------------
 1 file changed, 40 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index d54ac3736c34..a045c446a910 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -346,10 +346,10 @@ int opal_get_chars(uint32_t vtermno, char *buf, int count)
 
 int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 {
-	int written = 0;
-	__be64 olen;
-	s64 len, rc;
 	unsigned long flags;
+	int written;
+	__be64 olen;
+	s64 rc;
 
 	if (!opal.entry)
 		return -ENODEV;
@@ -357,62 +357,56 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	/* We want put_chars to be atomic to avoid mangling of hvsi
 	 * packets. To do that, we first test for room and return
 	 * -EAGAIN if there isn't enough.
-	 *
-	 * Unfortunately, opal_console_write_buffer_space() doesn't
-	 * appear to work on opal v1, so we just assume there is
-	 * enough room and be done with it
 	 */
 	spin_lock_irqsave(&opal_write_lock, flags);
 	rc = opal_console_write_buffer_space(vtermno, &olen);
-	len = be64_to_cpu(olen);
-	if (rc || len < total_len) {
-		spin_unlock_irqrestore(&opal_write_lock, flags);
+	if (rc || be64_to_cpu(olen) < total_len) {
 		/* Closed -> drop characters */
 		if (rc)
-			return total_len;
-		opal_flush_console(vtermno);
-		return -EAGAIN;
+			written = total_len;
+		else
+			written = -EAGAIN;
+		goto out;
 	}
 
-	/* We still try to handle partial completions, though they
-	 * should no longer happen.
-	 */
-
-	while (total_len > 0) {
-		olen = cpu_to_be64(total_len);
-
-		rc = OPAL_BUSY;
-		while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-			rc = opal_console_write(vtermno, &olen, data);
-			if (rc == OPAL_BUSY_EVENT) {
-				mdelay(OPAL_BUSY_DELAY_MS);
-				opal_poll_events(NULL);
-			} else if (rc == OPAL_BUSY) {
-				mdelay(OPAL_BUSY_DELAY_MS);
-			}
-		}
-
-		len = be64_to_cpu(olen);
-
-		/* Closed or other error drop */
-		if (rc != OPAL_SUCCESS) {
-			written += total_len; /* drop remaining chars */
-			break;
+	/* Should not get a partial write here because space is available. */
+	olen = cpu_to_be64(total_len);
+	rc = opal_console_write(vtermno, &olen, data);
+	if (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+		if (rc == OPAL_BUSY_EVENT) {
+			mdelay(OPAL_BUSY_DELAY_MS);
+			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY_EVENT) {
+			mdelay(OPAL_BUSY_DELAY_MS);
 		}
+		written = -EAGAIN;
+		goto out;
+	}
 
-		total_len -= len;
-		data += len;
-		written += len;
+	/* Closed or other error drop */
+	if (rc != OPAL_SUCCESS) {
+		written = opal_error_code(rc);
+		goto out;
+	}
 
-		/* This is a bit nasty but we need that for the console to
-		 * flush when there aren't any interrupts. We will clean
-		 * things a bit later to limit that to synchronous path
-		 * such as the kernel console and xmon/udbg
-		 */
-		opal_flush_console(vtermno);
+	written = be64_to_cpu(olen);
+	if (written < total_len) {
+		/* Should not happen */
+		pr_warn("atomic console write returned partial len=%d written=%d\n", total_len, written);
+		if (!written)
+			written = -EAGAIN;
 	}
+
+out:
 	spin_unlock_irqrestore(&opal_write_lock, flags);
 
+	/* This is a bit nasty but we need that for the console to
+	 * flush when there aren't any interrupts. We will clean
+	 * things a bit later to limit that to synchronous path
+	 * such as the kernel console and xmon/udbg
+	 */
+	opal_flush_console(vtermno);
+
 	return written;
 }
 
-- 
2.17.0
