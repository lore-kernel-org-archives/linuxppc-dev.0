Return-Path: <SRS0=lOLd=5O=de.ibm.com=abergman@srs.kundenserver.de>
Message-Id: <20060323203521.100452000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Thu, 23 Mar 2006 00:00:02 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 02/13] powerpc: add hvc backend for rtas
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Current Cell hardware is using the console through a set
of rtas calls. This driver is needed to get console
output on those boards.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linus-2.6/drivers/char/hvc_rtas.c
===================================================================
--- /dev/null
+++ linus-2.6/drivers/char/hvc_rtas.c
@@ -0,0 +1,138 @@
+/*
+ * IBM RTAS driver interface to hvc_console.c
+ *
+ * (C) Copyright IBM Corporation 2001-2005
+ * (C) Copyright Red Hat, Inc. 2005
+ *
+ * Author(s): Maximino Augilar <IBM STI Design Center>
+ *	    : Ryan S. Arnold <rsa@us.ibm.com>
+ *	    : Utz Bacher <utz.bacher@de.ibm.com>
+ *	    : David Woodhouse <dwmw2@infradead.org>
+ *
+ *    inspired by drivers/char/hvc_console.c
+ *    written by Anton Blanchard and Paul Mackerras
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
+
+#include <asm/irq.h>
+#include <asm/rtas.h>
+#include "hvc_console.h"
+
+#define hvc_rtas_cookie 0x67781e15
+struct hvc_struct *hvc_rtas_dev;
+
+#define RTASCONS_PUT_ATTEMPTS  16
+
+static int rtascons_put_char_token = RTAS_UNKNOWN_SERVICE;
+static int rtascons_get_char_token = RTAS_UNKNOWN_SERVICE;
+static int rtascons_put_delay = 100;
+module_param_named(put_delay, rtascons_put_delay, int, 0644);
+
+static inline int hvc_rtas_write_console(uint32_t vtermno, const char *buf, int count)
+{
+	int done;
+
+	/* if there is more than one character to be displayed, wait a bit */
+	for (done = 0; done < count; done++) {
+		int result;
+		result = rtas_call(rtascons_put_char_token, 1, 1, NULL, buf[done]);
+		if (result)
+			break;
+	}
+	/* the calling routine expects to receive the number of bytes sent */
+	return done;
+}
+
+static int hvc_rtas_read_console(uint32_t vtermno, char *buf, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		int c, err;
+
+		err = rtas_call(rtascons_get_char_token, 0, 2, &c);
+		if (err)
+			break;
+
+		buf[i] = c;
+	}
+
+	return i;
+}
+
+static struct hv_ops hvc_rtas_get_put_ops = {
+	.get_chars = hvc_rtas_read_console,
+	.put_chars = hvc_rtas_write_console,
+};
+
+static int hvc_rtas_init(void)
+{
+	struct hvc_struct *hp;
+
+	if (rtascons_put_char_token == RTAS_UNKNOWN_SERVICE)
+		rtascons_put_char_token = rtas_token("put-term-char");
+	if (rtascons_put_char_token == RTAS_UNKNOWN_SERVICE)
+		return -EIO;
+
+	if (rtascons_get_char_token == RTAS_UNKNOWN_SERVICE)
+		rtascons_get_char_token = rtas_token("get-term-char");
+	if (rtascons_get_char_token == RTAS_UNKNOWN_SERVICE)
+		return -EIO;
+
+	BUG_ON(hvc_rtas_dev);
+
+	/* Allocate an hvc_struct for the console device we instantiated
+	 * earlier.  Save off hp so that we can return it on exit */
+	hp = hvc_alloc(hvc_rtas_cookie, NO_IRQ, &hvc_rtas_get_put_ops);
+	if (IS_ERR(hp))
+		return PTR_ERR(hp);
+	hvc_rtas_dev = hp;
+	return 0;
+}
+module_init(hvc_rtas_init);
+
+/* This will tear down the tty portion of the driver */
+static void __exit hvc_rtas_exit(void)
+{
+	/* Really the fun isn't over until the worker thread breaks down and the
+	 * tty cleans up */
+	if (hvc_rtas_dev)
+		hvc_remove(hvc_rtas_dev);
+}
+module_exit(hvc_rtas_exit); /* before drivers/char/hvc_console.c */
+
+/* This will happen prior to module init.  There is no tty at this time? */
+static int hvc_rtas_console_init(void)
+{
+	rtascons_put_char_token = rtas_token("put-term-char");
+	if (rtascons_put_char_token == RTAS_UNKNOWN_SERVICE)
+		return -EIO;
+	rtascons_get_char_token = rtas_token("get-term-char");
+	if (rtascons_get_char_token == RTAS_UNKNOWN_SERVICE)
+		return -EIO;
+
+	hvc_instantiate(hvc_rtas_cookie, 0, &hvc_rtas_get_put_ops );
+	add_preferred_console("hvc", 0, NULL);
+	return 0;
+}
+console_initcall(hvc_rtas_console_init);
Index: linus-2.6/drivers/char/Makefile
===================================================================
--- linus-2.6.orig/drivers/char/Makefile
+++ linus-2.6/drivers/char/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_SX)		+= sx.o generic_serial
 obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
 obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
 obj-$(CONFIG_HVC_CONSOLE)	+= hvc_vio.o hvsi.o
+obj-$(CONFIG_HVC_RTAS)		+= hvc_rtas.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
 obj-$(CONFIG_MMTIMER)		+= mmtimer.o
Index: linus-2.6/drivers/char/Kconfig
===================================================================
--- linus-2.6.orig/drivers/char/Kconfig
+++ linus-2.6/drivers/char/Kconfig
@@ -578,6 +578,13 @@ config HVC_CONSOLE
 	  console. This driver allows each pSeries partition to have a console
 	  which is accessed via the HMC.
 
+config HVC_RTAS
+	bool "IBM RTAS Console support"
+	depends on PPC_RTAS
+	select HVC_DRIVER
+	help
+	  IBM Console device driver which makes use of RTAS
+
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
 	depends on PPC_PSERIES

--
