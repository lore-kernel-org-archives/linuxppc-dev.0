Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 943F9DDF3C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 12:12:13 +1100 (EST)
Date: Fri, 12 Jan 2007 10:12:06 +0900 (JST)
Message-Id: <200701120112.l0C1C7vp006378@toshiba.co.jp>
Subject: [PATCH 12/19] powerpc: setup sio in SCC for Celleb
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

This patch setup serial interfaces in SCC to work with serial_txx9
driver.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc_sio.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/scc_sio.c:1.5
--- /dev/null	Thu Jan 11 22:03:27 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc_sio.c	Wed Jan 10 17:48:12 2007
@@ -0,0 +1,101 @@
+/*
+ * setup serial port in SCC
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
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/console.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+
+/* sio irq0=0xb00010022 irq0=0xb00010023 irq2=0xb00010024
+    mmio=0xfff000-0x1000,0xff2000-0x1000 */
+static int txx9_serial_bitmap = 0;
+
+static struct {
+	uint32_t offset;
+	uint32_t index;
+} txx9_scc_tab[3] = {
+	{ 0x300, 0 },	/* 0xFFF300 */
+	{ 0x400, 0 },	/* 0xFFF400 */
+	{ 0x800, 1 }	/* 0xFF2800 */
+};
+
+static int txx9_serial_init(void)
+{
+	extern int early_serial_txx9_setup(struct uart_port *port);
+	struct device_node *node;
+	int i;
+	struct uart_port req;
+	struct of_irq irq;
+	struct resource res;
+
+	node = of_find_node_by_path("/ioif1/sio");
+	if (!node)
+		return 0;
+
+	for(i = 0; i < sizeof(txx9_scc_tab)/sizeof(txx9_scc_tab[0]); i++) {
+		if (!(txx9_serial_bitmap & (1<<i)))
+			continue;
+
+		if (of_irq_map_one(node, i, &irq))
+			continue;
+		if (of_address_to_resource(node, txx9_scc_tab[i].index, &res))
+			continue;
+
+		memset(&req, 0, sizeof(req));
+		req.line = i;
+		req.iotype = UPIO_MEM;
+		req.mapbase = res.start + txx9_scc_tab[i].offset;
+#ifdef CONFIG_SERIAL_TXX9_CONSOLE
+		req.membase = ioremap(req.mapbase, 0x24);
+#endif
+		req.irq = irq_create_of_mapping(irq.controller,
+			irq.specifier, irq.size);
+		req.flags |= UPF_IOREMAP | UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
+		req.uartclk = 83300000;
+		early_serial_txx9_setup(&req);
+	}
+
+	of_node_put(node);
+	return 0;
+}
+
+static int txx9_serial_config(char *ptr)
+{
+	int	i;
+
+	for (;;) {
+		switch(get_option(&ptr, &i)) {
+		default:
+			return 0;
+		case 2:
+			txx9_serial_bitmap |= 1 << i;
+			break;
+		case 1:
+			txx9_serial_bitmap |= 1 << i;
+			return 0;
+		}
+	}
+}
+__setup("txx9_serial=", txx9_serial_config);
+
+console_initcall(txx9_serial_init);
