Return-Path: <dgibson@ozlabs.org>
Date: Fri, 24 Oct 2008 14:54:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: benh@yookeroo.seuss, Paul Mackerras <paulus@samba.org>
Subject: powerpc: udbg based backend for hvc_console
Message-ID: <20081024035434.GF4267@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a new backend for the hvc console based on the
low-level udbg callbacks.  This effectively implements a working
runtime console in terms of the simple udbg primitives.  This is kind
of a hack - since udbg isn't something you really want to be using
routinely - but it's really useful during bringup.

This can be used to quickly implement a userspace usable console while
you're working on a proper driver for whatever console I/O device the
hardware has.  Or, it can be used to avoid writing a full blown
tty/console driver entirely for quick-and-dirty I/O hardware that will
later be replaced by something else.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/drivers/char/Kconfig
===================================================================
--- working-2.6.orig/drivers/char/Kconfig	2008-10-22 16:01:39.000000000 +1100
+++ working-2.6/drivers/char/Kconfig	2008-10-24 14:22:59.000000000 +1100
@@ -631,6 +631,12 @@ config HVC_XEN
 	help
 	  Xen virtual console device driver
 
+config HVC_UDBG
+       bool "udbg based fake hypervisor console"
+       depends on EXPERIMENTAL
+       select HVC_DRIVER
+       default n
+
 config VIRTIO_CONSOLE
 	tristate "Virtio console"
 	depends on VIRTIO
Index: working-2.6/drivers/char/Makefile
===================================================================
--- working-2.6.orig/drivers/char/Makefile	2008-10-22 15:50:59.000000000 +1100
+++ working-2.6/drivers/char/Makefile	2008-10-24 14:22:59.000000000 +1100
@@ -50,6 +50,7 @@ obj-$(CONFIG_HVC_BEAT)		+= hvc_beat.o
 obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
 obj-$(CONFIG_HVC_IRQ)		+= hvc_irq.o
 obj-$(CONFIG_HVC_XEN)		+= hvc_xen.o
+obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
 obj-$(CONFIG_VIRTIO_CONSOLE)	+= virtio_console.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
Index: working-2.6/drivers/char/hvc_udbg.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/drivers/char/hvc_udbg.c	2008-10-24 14:38:55.000000000 +1100
@@ -0,0 +1,96 @@
+/*
+ * udbg interface to hvc_console.c
+ *
+ * (C) Copyright David Gibson, IBM Corporation 2008.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/irq.h>
+
+#include <asm/udbg.h>
+
+#include "hvc_console.h"
+
+struct hvc_struct *hvc_udbg_dev;
+
+static int hvc_udbg_put(uint32_t vtermno, const char *buf, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		udbg_putc(buf[i]);
+
+	return i;
+}
+
+static int hvc_udbg_get(uint32_t vtermno, char *buf, int count)
+{
+	int i, c;
+
+	if (!udbg_getc_poll)
+		return 0;
+
+	for (i = 0; i < count; i++) {
+		if ((c = udbg_getc_poll()) == -1)
+			break;
+		buf[i] = c;
+	}
+
+	return i;
+}
+
+static struct hv_ops hvc_udbg_ops = {
+	.get_chars = hvc_udbg_get,
+	.put_chars = hvc_udbg_put,
+};
+
+static int __init hvc_udbg_init(void)
+{
+	struct hvc_struct *hp;
+
+	BUG_ON(hvc_udbg_dev);
+
+	hp = hvc_alloc(0, NO_IRQ, &hvc_udbg_ops, 16);
+	if (IS_ERR(hp))
+		return PTR_ERR(hp);
+
+	hvc_udbg_dev = hp;
+
+	return 0;
+}
+module_init(hvc_udbg_init);
+
+static void __exit hvc_udbg_exit(void)
+{
+	if (hvc_udbg_dev)
+		hvc_remove(hvc_udbg_dev);
+}
+module_exit(hvc_udbg_exit);
+
+static int __init hvc_udbg_console_init(void)
+{
+	hvc_instantiate(0, 0, &hvc_udbg_ops);
+	add_preferred_console("hvc", 0, NULL);
+
+	return 0;
+}
+console_initcall(hvc_udbg_console_init);


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
