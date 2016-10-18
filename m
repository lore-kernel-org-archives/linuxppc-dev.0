Return-Path: <Paul.Burton@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp02.imgtec.com [217.156.133.132])
 by lists.ozlabs.org (Postfix) with ESMTP id 3syqgP1Xn9zDt2X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 20:35:29 +1100 (AEDT)
From: Paul Burton <paul.burton@imgtec.com>
To: <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>
CC: Paul Burton <paul.burton@imgtec.com>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, "Sergey
 Senozhatsky" <sergey.senozhatsky@gmail.com>, Borislav Petkov <bp@suse.de>,
 Tejun Heo <tj@kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] console: use first console if stdout-path device doesn't
 appear
Date: Tue, 18 Oct 2016 10:18:52 +0100
Message-ID: <20161018091852.14776-1-paul.burton@imgtec.com>
In-Reply-To: <87oa2ij2mq.fsf@linux-m68k.org>
References: <87oa2ij2mq.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a device tree specified a preferred device for kernel console output
via the stdout-path or linux,stdout-path chosen node properties there's
no guarantee that it will have specified a device for which we have a
driver. It may also be the case that we do have a driver but it doesn't
call of_console_check() to register as a preferred console (eg. offb
driver as used on powermac systems). In these cases try to ensure that
we provide some console output by enabling the first console in the
console_drivers list.

As I don't have access to an affected system this has only been build
tested - testing would be most appreciated.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 05fd007e4629 ("console: don't prefer first registered if DT specifies stdout-path")
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
---
A potential alternative to this might be to have the affected offb
driver call of_check_console(), and perhaps that should happen anyway,
but doing so seems non-trivial since the offb driver doesn't know the
index of the framebuffer console device it may be about to register &
the fbdev core doesn't know the associated device tree node. This also
wouldn't catch the case of us not having a driver for the device
specified by stdout-path, so this fallback seems worthwhile anyway.
---
 kernel/printk/printk.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d5e3973..7091e2f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2835,10 +2835,45 @@ EXPORT_SYMBOL(unregister_console);
  * intersects with the init section. Note that code exists elsewhere to get
  * rid of the boot console as soon as the proper console shows up, so there
  * won't be side-effects from postponing the removal.
+ *
+ * Additionally we may be using a device tree which specifies valid
+ * stdout-path referencing a device for which we don't have a driver, or for
+ * which we have a driver that doesn't register itself as preferred console
+ * using of_console_check(). In these cases we attempt here to enable the
+ * first registered console.
  */
 static int __init printk_late_init(void)
 {
-	struct console *con;
+	struct console *con, *enabled;
+
+	if (of_specified_console) {
+		console_lock();
+
+		/* Find the enabled console, if there is one */
+		enabled = NULL;
+		for_each_console(con) {
+			if (!(con->flags & CON_ENABLED))
+				continue;
+
+			enabled = con;
+			break;
+		}
+
+		/* Enable the first console if none were already enabled */
+		con = console_drivers;
+		if (!enabled && con) {
+			if (con->index < 0)
+				con->index = 0;
+			if (con->setup == NULL ||
+			    con->setup(con, NULL) == 0) {
+				con->flags |= CON_ENABLED;
+				if (con->device)
+					con->flags |= CON_CONSDEV;
+			}
+		}
+
+		console_unlock();
+	}
 
 	for_each_console(con) {
 		if (!keep_bootcon && con->flags & CON_BOOT) {
-- 
2.10.0
