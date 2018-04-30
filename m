Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZSKb3vBDzF2QD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 00:56:19 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id e9so2941605pfi.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 07:56:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] powerpc/powernv: Fix OPAL console driver OPAL_BUSY loops
Date: Tue,  1 May 2018 00:55:45 +1000
Message-Id: <20180430145558.4308-3-npiggin@gmail.com>
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

The OPAL console driver does not delay in case it gets OPAL_BUSY or
OPAL_BUSY_EVENT from firmware.

It can't yet be made to sleep because it is called under spinlock,
but it can be changed to the standard OPAL_BUSY loop form, and a
delay added to keep it from hitting the firmware too frequently.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 38 ++++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index e695b836fd49..6b621d47ac29 100644
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
