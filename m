Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D85CE67E90
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 13:47:28 +1100 (EST)
Date: Thu, 14 Dec 2006 11:47:24 +0900 (JST)
Message-Id: <200612140247.kBE2lP3t029472@toshiba.co.jp>
Subject: [PATCH 16/19] powerpc: udbg supports for Celleb
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

This patch adds udbg support for Celleb platform.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/kernel/udbg.c
diff -u linux-powerpc-git/arch/powerpc/kernel/udbg.c:1.1.1.1 linux-powerpc-git/arch/powerpc/kernel/udbg.c:1.2
--- linux-powerpc-git/arch/powerpc/kernel/udbg.c:1.1.1.1	Wed Dec  6 08:25:43 2006
+++ linux-powerpc-git/arch/powerpc/kernel/udbg.c	Wed Dec  6 08:43:15 2006
@@ -45,6 +45,8 @@
 #elif defined(CONFIG_PPC_EARLY_DEBUG_ISERIES)
 	/* For iSeries - hit Ctrl-x Ctrl-x to see the output */
 	udbg_init_iseries();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_BEAT)
+	udbg_init_debug_beat();
 #endif
 }
 
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/udbg_beat.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/udbg_beat.c:1.4
--- /dev/null	Wed Dec 13 21:32:05 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/udbg_beat.c	Wed Dec 13 18:19:14 2006
@@ -0,0 +1,98 @@
+/*
+ * udbg function for Beat
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
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
+#include <linux/kernel.h>
+#include <linux/console.h>
+
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+
+#include "beat.h"
+
+int	celleb_vtermno;
+
+static void udbg_putc_beat(char c)
+{
+	unsigned long rc;
+
+	if (c == '\n')
+		udbg_putc_beat('\r');
+
+	rc = beat_put_term_char(celleb_vtermno, 1, (uint64_t)c << 56, 0);
+}
+
+/* Buffered chars getc */
+static long inbuflen;
+static long inbuf[2];	/* must be 2 longs */
+
+static int udbg_getc_poll_beat(void)
+{
+	/* The interface is tricky because it may return up to 16 chars.
+	 * We save them statically for future calls to udbg_getc().
+	 */
+	char ch, *buf = (char *)inbuf;
+	int i;
+	long rc;
+	if (inbuflen == 0) {
+		/* get some more chars. */
+		inbuflen = 0;
+		rc = beat_get_term_char(celleb_vtermno, &inbuflen, inbuf+0, inbuf+1);
+		if (rc != 0)
+			inbuflen = 0;	/* otherwise inbuflen is garbage */
+	}
+	if (inbuflen <= 0 || inbuflen > 16) {
+		/* Catch error case as well as other oddities (corruption) */
+		inbuflen = 0;
+		return -1;
+	}
+	ch = buf[0];
+	for (i = 1; i < inbuflen; i++)	/* shuffle them down. */
+		buf[i-1] = buf[i];
+	inbuflen--;
+	return ch;
+}
+
+static int udbg_getc_beat(void)
+{
+	int ch;
+	for (;;) {
+		ch = udbg_getc_poll_beat();
+		if (ch == -1) {
+			/* This shouldn't be needed...but... */
+			volatile unsigned long delay;
+			for (delay=0; delay < 2000000; delay++)
+				;
+		} else {
+			return ch;
+		}
+	}
+}
+
+/* call this from early_init() for a working debug console on
+ * vterm capable LPAR machines
+ */
+void __init udbg_init_debug_beat(void)
+{
+	celleb_vtermno = 0;
+	udbg_putc = udbg_putc_beat;
+	udbg_getc = udbg_getc_beat;
+	udbg_getc_poll = udbg_getc_poll_beat;
+}
Index: linux-powerpc-git/include/asm-powerpc/udbg.h
diff -u linux-powerpc-git/include/asm-powerpc/udbg.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/udbg.h:1.2
--- linux-powerpc-git/include/asm-powerpc/udbg.h:1.1.1.1	Wed Dec  6 08:24:04 2006
+++ linux-powerpc-git/include/asm-powerpc/udbg.h	Wed Dec  6 08:43:16 2006
@@ -44,6 +44,7 @@
 extern void __init udbg_init_iseries(void);
 extern void __init udbg_init_rtas_panel(void);
 extern void __init udbg_init_rtas_console(void);
+extern void __init udbg_init_debug_beat(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
