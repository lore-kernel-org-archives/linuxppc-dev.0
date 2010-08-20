Return-Path: <timur@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144]) by ozlabs.org (Postfix) with ESMTP id EA3F8B70E0
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Aug 2010 04:46:01 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	benh@kernel.crashing.org, kumar.gala@freescale.com, amit.shah@redhat.com
Subject: [PATCH] hvc_console: fix dropping of characters when output byte
	channel is full
Date: Fri, 20 Aug 2010 13:45:21 -0500
Message-ID: <1282329921-24394-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hvc_console_print() calls the HVC client driver's put_chars() callback
to write some characters to the console.  If the callback returns 0, that
indicates that no characters were written (perhaps the output buffer is
full), but hvc_console_print() treats that as an error and discards the
rest of the buffer.

So change hvc_console_print() to just loop and call put_chars() again if it
returns a 0 return code.

This change makes hvc_console_print() behave more like hvc_push(), which
does check for a 0 return code and re-schedules itself.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/char/hvc_console.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index fa27d16..b4deffd 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2001 Paul Mackerras <paulus@au.ibm.com>, IBM
  * Copyright (C) 2004 Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
  * Copyright (C) 2004 IBM Corporation
+ * Copyright 2009 Freescale Semiconductor, Inc.
  *
  * Additional Author(s):
  *  Ryan S. Arnold <rsa@us.ibm.com>
@@ -141,6 +142,7 @@ static void hvc_console_print(struct console *co, const char *b,
 	char c[N_OUTBUF] __ALIGNED__;
 	unsigned i = 0, n = 0;
 	int r, donecr = 0, index = co->index;
+	unsigned int timeout = 1000000; /* Keep trying for up to one second */
 
 	/* Console access attempt outside of acceptable console range. */
 	if (index >= MAX_NR_HVC_CONSOLES)
@@ -152,6 +154,10 @@ static void hvc_console_print(struct console *co, const char *b,
 
 	while (count > 0 || i > 0) {
 		if (count > 0 && i < sizeof(c)) {
+			/* If the local buffer (c) is not full, then copy some
+			 * bytes from the input buffer to it. We stop when the
+			 * local buffer is full. \n is converted to \r\n.
+			 */
 			if (b[n] == '\n' && !donecr) {
 				c[i++] = '\r';
 				donecr = 1;
@@ -162,14 +168,25 @@ static void hvc_console_print(struct console *co, const char *b,
 			}
 		} else {
 			r = cons_ops[index]->put_chars(vtermnos[index], c, i);
-			if (r <= 0) {
+			if (r < 0) {
 				/* throw away chars on error */
 				i = 0;
 			} else if (r > 0) {
 				i -= r;
 				if (i > 0)
 					memmove(c, c+r, i);
+			} else {
+				/* If r == 0, then the client driver didn't do
+				 * anything, so wait 1us and try again.  If we
+				 * time out, then just exit.
+				 */
+				if (!--timeout)
+					return;
+				udelay(1);
+				continue;
 			}
+			/* Reset the timeout */
+			timeout = 1000000;
 		}
 	}
 }
-- 
1.7.0.1
