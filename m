Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KJfw3jkszDrqP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:25:44 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id s10-v6so4482725plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:25:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 4/9] powerpc/powernv: OPAL console standardise OPAL_BUSY
 loops
Date: Mon,  9 Apr 2018 15:24:26 +1000
Message-Id: <20180409052431.26405-5-npiggin@gmail.com>
In-Reply-To: <20180409052431.26405-1-npiggin@gmail.com>
References: <20180409052431.26405-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert to using the standard delay poll/delay form.

The console code:

- Did not previously delay or sleep in its busy loop.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 38 ++++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 87d4c0aa7f64..473c8ce14a34 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -378,33 +378,41 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	/* We still try to handle partial completions, though they
 	 * should no longer happen.
 	 */
-	rc = OPAL_BUSY;
-	while(total_len > 0 && (rc == OPAL_BUSY ||
-				rc == OPAL_BUSY_EVENT || rc == OPAL_SUCCESS)) {
+
+	while (total_len > 0) {
 		olen = cpu_to_be64(total_len);
-		rc = opal_console_write(vtermno, &olen, data);
+
+		rc = OPAL_BUSY;
+		while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+			rc = opal_console_write(vtermno, &olen, data);
+			if (rc == OPAL_BUSY_EVENT) {
+				mdelay(OPAL_BUSY_DELAY_MS);
+				opal_poll_events(NULL);
+			} else if (rc == OPAL_BUSY) {
+				mdelay(OPAL_BUSY_DELAY_MS);
+			}
+		}
+
 		len = be64_to_cpu(olen);
 
 		/* Closed or other error drop */
-		if (rc != OPAL_SUCCESS && rc != OPAL_BUSY &&
-		    rc != OPAL_BUSY_EVENT) {
-			written += total_len;
+		if (rc != OPAL_SUCCESS) {
+			written += total_len; /* drop remaining chars */
 			break;
 		}
-		if (rc == OPAL_SUCCESS) {
-			total_len -= len;
-			data += len;
-			written += len;
-		}
+
+		total_len -= len;
+		data += len;
+		written += len;
+
 		/* This is a bit nasty but we need that for the console to
 		 * flush when there aren't any interrupts. We will clean
 		 * things a bit later to limit that to synchronous path
 		 * such as the kernel console and xmon/udbg
 		 */
-		do
+		do {
 			opal_poll_events(&evt);
-		while(rc == OPAL_SUCCESS &&
-			(be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT));
+		} while (be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT);
 	}
 	spin_unlock_irqrestore(&opal_write_lock, flags);
 	return written;
-- 
2.17.0
