Return-Path: <anton@samba.org>
Date: Wed, 13 Jul 2011 15:44:05 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, jason.wessel@windriver.com
Subject: [PATCH] hvc_console: Add kdb support
Message-ID: <20110713154405.297f828d@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kgdb-bugreport@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add poll_get_char and poll_put_char for kdb. Enable kdb at boot with:

kgdboc=hvc0

or at runtime with:

echo hvc0 > /sys/module/kgdboc/parameters/kgdboc

Signed-off-by: Anton Blanchard <anton@samba.org>
---

A couple of things:

- I needed to enable CONFIG_KGDB_SERIAL_CONSOLE in order to
  enable CONFIG_CONSOLE_POLL. It's somewhat confusing and I wonder
  if we should always enable CONFIG_CONSOLE_POLL when CONFIG_KGDB
  is enabled.

- I had to pull in linux/serial_core.h to get NO_POLL_CHAR, we
  might want to move it somewhere more generic.

- Things are a little bit awkward because poll_get_char and
  poll_put_char take a struct tty_driver instead of a struct tty,
  I just grab the first entry in the ttys[] list.

FYI: This patch also needs "powerpc/pseries: Fix hvterm_raw_get_chars
to accept < 16 chars, fixing xmon" to be applied:

http://patchwork.ozlabs.org/patch/104475/

Index: linux-powerpc/drivers/tty/hvc/hvc_console.c
===================================================================
--- linux-powerpc.orig/drivers/tty/hvc/hvc_console.c	2011-07-13 15:08:15.853817380 +1000
+++ linux-powerpc/drivers/tty/hvc/hvc_console.c	2011-07-13 15:10:16.555874550 +1000
@@ -39,6 +39,7 @@
 #include <linux/delay.h>
 #include <linux/freezer.h>
 #include <linux/slab.h>
+#include <linux/serial_core.h>
 
 #include <asm/uaccess.h>
 
@@ -766,6 +767,39 @@ static int hvc_tiocmset(struct tty_struc
 	return hp->ops->tiocmset(hp, set, clear);
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+int hvc_poll_init(struct tty_driver *driver, int line, char *options)
+{
+	return 0;
+}
+
+static int hvc_poll_get_char(struct tty_driver *driver, int line)
+{
+	struct tty_struct *tty = driver->ttys[0];
+	struct hvc_struct *hp = tty->driver_data;
+	int n;
+	char ch;
+
+	n = hp->ops->get_chars(hp->vtermno, &ch, 1);
+
+	if (n == 0)
+		return NO_POLL_CHAR;
+
+	return ch;
+}
+
+static void hvc_poll_put_char(struct tty_driver *driver, int line, char ch)
+{
+	struct tty_struct *tty = driver->ttys[0];
+	struct hvc_struct *hp = tty->driver_data;
+	int n;
+
+	do {
+		n = hp->ops->put_chars(hp->vtermno, &ch, 1);
+	} while (n <= 0);
+}
+#endif
+
 static const struct tty_operations hvc_ops = {
 	.open = hvc_open,
 	.close = hvc_close,
@@ -776,6 +810,11 @@ static const struct tty_operations hvc_o
 	.chars_in_buffer = hvc_chars_in_buffer,
 	.tiocmget = hvc_tiocmget,
 	.tiocmset = hvc_tiocmset,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_init = hvc_poll_init,
+	.poll_get_char = hvc_poll_get_char,
+	.poll_put_char = hvc_poll_put_char,
+#endif
 };
 
 struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
