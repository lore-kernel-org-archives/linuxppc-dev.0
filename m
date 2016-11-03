Return-Path: <Paul.Burton@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 3t8lRy4zDzzDvQZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 23:59:58 +1100 (AEDT)
From: Paul Burton <paul.burton@imgtec.com>
To: Larry Finger <Larry.Finger@lwfinger.net>, Michael Ellerman
 <mpe@ellerman.id.au>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
CC: Paul Burton <paul.burton@imgtec.com>, Andreas Schwab
 <schwab@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Borislav
 Petkov <bp@suse.de>, Petr Mladek <pmladek@suse.com>, Tejun Heo
 <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3] console: use first console if stdout-path device doesn't
 appear
Date: Thu, 3 Nov 2016 12:57:58 +0000
Message-ID: <20161103125758.3415-1-paul.burton@imgtec.com>
In-Reply-To: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
References: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
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
driver as used on powermac systems).

In these cases try to ensure that we provide some console output by
enabling the first usable registered console, which we keep track of
with the of_fallback_console variable. Affected systems will enable
their console later than they did prior to commit 05fd007e4629
("console: don't prefer first registered if DT specifies stdout-path")
but should otherwise produce the same output.

Tested in QEMU with a PowerPC pseries_defconfig kernel.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 05fd007e4629 ("console: don't prefer first registered if DT specifies stdout-path")
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org

---

Changes in v3:
- Be less invasive by simply calling register_console() again rather than splitting it.
- Check for CON_CONSDEV on the first console driver rather than for CON_ENABLED on any.
- Clean up the tracking of the fallback console.

Changes in v2:
- Split enable_console() out of register_console() & call in the fallback case.
- Track the console we would have enabled as of_fallback_console.

 kernel/printk/printk.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index de08fc9..c86e6d0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -260,10 +260,18 @@ void console_set_by_of(void)
 {
 	of_specified_console = true;
 }
+
+static void clear_of_specified_console(void)
+{
+	of_specified_console = false;
+}
 #else
 # define of_specified_console false
+static void clear_of_specified_console(void) { }
 #endif
 
+struct console *of_fallback_console;
+
 /* Flag: console code may call schedule() */
 static int console_may_schedule;
 
@@ -2657,10 +2665,26 @@ void register_console(struct console *newcon)
 	 *	didn't select a console we take the first one
 	 *	that registers here.
 	 */
-	if (preferred_console < 0 && !of_specified_console) {
+	if (preferred_console < 0) {
 		if (newcon->index < 0)
 			newcon->index = 0;
-		if (newcon->setup == NULL ||
+		if (of_specified_console) {
+			/*
+			 * The device tree stdout-path chosen node property was
+			 * specified so we don't want to enable the first
+			 * registered console just now in order to give the
+			 * device indicated by stdout-path a chance to be
+			 * registered first. Do however keep track of the
+			 * first console we see so that we can fall back to
+			 * using it if we don't see the desired device, either
+			 * because stdout-path isn't valid, or because we have
+			 * no driver for the device or our driver doesn't call
+			 * of_console_check(). See printk_late_init() for this
+			 * fallback.
+			 */
+			if (!of_fallback_console)
+				of_fallback_console = newcon;
+		} else if (newcon->setup == NULL ||
 		    newcon->setup(newcon, NULL) == 0) {
 			newcon->flags |= CON_ENABLED;
 			if (newcon->device) {
@@ -2844,6 +2868,22 @@ static int __init printk_late_init(void)
 {
 	struct console *con;
 
+	if (of_specified_console && of_fallback_console &&
+	    (!console_drivers || !(console_drivers->flags & CON_CONSDEV))) {
+		/*
+		 * The system has a device tree which specified stdout-path,
+		 * but we haven't seen a console associated with the device
+		 * specified by the stdout-path chosen node property.
+		 *
+		 * We do however know which console would have been used
+		 * if stdout-path weren't specified at all, so in an attempt
+		 * to provide some output we'll re-register that console
+		 * pretending that we never saw stdout-path.
+		 */
+		clear_of_specified_console();
+		register_console(of_fallback_console);
+	}
+
 	for_each_console(con) {
 		if (!keep_bootcon && con->flags & CON_BOOT) {
 			/*
-- 
2.10.2
