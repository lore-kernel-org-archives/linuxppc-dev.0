Return-Path: <geert@linux-m68k.org>
Received: from monty.telenet-ops.be (monty.telenet-ops.be [195.130.132.56])
	by ozlabs.org (Postfix) with ESMTP id 85FA9DDEB8
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 02:49:20 +1100 (EST)
Date: Sun, 3 Feb 2008 16:49:09 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] ADB: Add missing #include <linux/platform_device.h>
Message-ID: <Pine.LNX.4.64.0802031647560.27760@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/m68k <linux-m68k@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ADB: Add missing #include <linux/platform_device.h>

Commit c9f6d3d5c6d4f4cd3a53549a69c92951180e2a76

    [POWERPC] adb: Replace sleep notifier with platform driver suspend/resume hooks

introduced compile errors on m68k because <linux/platform_device.h> is not
explicitly included.  On powerpc, it's pulled in through <asm/prom.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/macintosh/adb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -36,6 +36,7 @@
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/kthread.h>
+#include <linux/platform_device.h>
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
