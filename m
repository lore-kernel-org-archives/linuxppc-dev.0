Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6D1FDE0CC
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 12:17:42 +1100 (EST)
Date: Fri, 12 Jan 2007 10:17:36 +0900 (JST)
Message-Id: <200701120117.l0C1HbGR010830@toshiba.co.jp>
Subject: [PATCH 17/19] powerpc: hypervisor console driver for Celleb
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds hypervisor console driver for Celleb platform.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/drivers/char/Kconfig
diff -u linux-powerpc-git/drivers/char/Kconfig:1.1.1.2 linux-powerpc-git/drivers/char/Kconfig:1.3
--- linux-powerpc-git/drivers/char/Kconfig:1.1.1.2	Tue Dec 26 18:06:45 2006
+++ linux-powerpc-git/drivers/char/Kconfig	Tue Dec 26 19:56:46 2006
@@ -610,6 +610,13 @@
 	help
 	  IBM Console device driver which makes use of RTAS
 
+config HVC_BEAT
+	bool "Toshiba's Beat Hypervisor Console support"
+	depends on PPC_CELLEB
+	select HVC_DRIVER
+	help
+	  Toshiba's Cell Reference Set Beat Console device driver
+
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
 	depends on PPC_PSERIES
Index: linux-powerpc-git/drivers/char/Makefile
diff -u linux-powerpc-git/drivers/char/Makefile:1.1.1.2 linux-powerpc-git/drivers/char/Makefile:1.3
--- linux-powerpc-git/drivers/char/Makefile:1.1.1.2	Tue Dec 26 18:06:45 2006
+++ linux-powerpc-git/drivers/char/Makefile	Tue Dec 26 19:56:46 2006
@@ -45,6 +45,7 @@
 obj-$(CONFIG_HVC_CONSOLE)	+= hvc_vio.o hvsi.o
 obj-$(CONFIG_HVC_ISERIES)	+= hvc_iseries.o
 obj-$(CONFIG_HVC_RTAS)		+= hvc_rtas.o
+obj-$(CONFIG_HVC_BEAT)		+= hvc_beat.o
 obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
Index: linux-powerpc-git/drivers/char/hvc_beat.c
diff -u /dev/null linux-powerpc-git/drivers/char/hvc_beat.c:1.2
--- /dev/null	Thu Jan 11 22:03:29 2007
+++ linux-powerpc-git/drivers/char/hvc_beat.c	Tue Dec 19 15:50:36 2006
@@ -0,0 +1,130 @@
+/*
+ * Beat hypervisor console driver
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This code is based on drivers/char/hvc_rtas.c:
+ * (C) Copyright IBM Corporation 2001-2005
+ * (C) Copyright Red Hat, Inc. 2005
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <linux/console.h>
+#include <asm/prom.h>
+#include <asm/hvconsole.h>
+
+#include "hvc_console.h"
+
+extern int64_t beat_get_term_char(uint64_t, uint64_t *, uint64_t *, uint64_t *);
+extern int64_t beat_put_term_char(uint64_t, uint64_t, uint64_t, uint64_t);
+
+struct hvc_struct *hvc_beat_dev = NULL;
+
+/* bug: only one queue is available regardless of vtermno */
+static int hvc_beat_get_chars(uint32_t vtermno, char *buf, int cnt)
+{
+	static unsigned char q[sizeof(unsigned long) * 2]
+		__attribute__((aligned(sizeof(unsigned long))));
+	static int qlen = 0;
+	unsigned long got;
+
+again:
+	if (qlen) {
+		if (qlen > cnt) {
+			memcpy(buf, q, cnt);
+			qlen -= cnt;
+			memmove(q + cnt, q, qlen);
+			return cnt;
+		} else {	/* qlen <= cnt */
+			int	r;
+
+			memcpy(buf, q, qlen);
+			r = qlen;
+			qlen = 0;
+			return r;
+		}
+	}
+	if (beat_get_term_char(vtermno, &got,
+		((unsigned long *)q), ((unsigned long *)q) + 1) == 0) {
+		qlen = got;
+		goto again;
+	}
+	return 0;
+}
+
+static int hvc_beat_put_chars(uint32_t vtermno, const char *buf, int cnt)
+{
+	unsigned long kb[2];
+	int rest, nlen;
+
+	for (rest = cnt; rest > 0; rest -= nlen) {
+		nlen = (rest > 16) ? 16 : rest;
+		memcpy(kb, buf, nlen);
+		beat_put_term_char(vtermno, rest, kb[0], kb[1]);
+		rest -= nlen;
+	}
+	return cnt;
+}
+
+static struct hv_ops hvc_beat_get_put_ops = {
+	.get_chars = hvc_beat_get_chars,
+	.put_chars = hvc_beat_put_chars,
+};
+
+static int hvc_beat_useit = 1;
+
+static int hvc_beat_config(char *p)
+{
+	hvc_beat_useit = simple_strtoul(p, NULL, 0);
+	return 0;
+}
+
+static int hvc_beat_console_init(void)
+{
+	if (hvc_beat_useit && machine_is_compatible("Beat")) {
+		hvc_instantiate(0, 0, &hvc_beat_get_put_ops);
+	}
+	return 0;
+}
+
+/* temp */
+static int hvc_beat_init(void)
+{
+	struct hvc_struct *hp;
+
+	hp = hvc_alloc(0, NO_IRQ, &hvc_beat_get_put_ops, 16);
+	if (IS_ERR(hp))
+		return PTR_ERR(hp);
+	hvc_beat_dev = hp;
+	return 0;
+}
+
+static void __exit hvc_beat_exit(void)
+{
+	if (hvc_beat_dev)
+		hvc_remove(hvc_beat_dev);
+}
+
+module_init(hvc_beat_init);
+module_exit(hvc_beat_exit);
+
+__setup("hvc_beat=", hvc_beat_config);
+
+console_initcall(hvc_beat_console_init);
