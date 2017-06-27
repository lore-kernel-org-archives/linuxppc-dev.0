Return-Path: <palmer@dabbelt.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxYVR6k5DzDqjF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 14:54:06 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id z6so3107706pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 21:54:06 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
To: gregkh@linuxfoundation.org
To: jslaby@suse.com
To: linux-kernel@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] tty: New RISC-V SBI console driver
Date: Mon, 26 Jun 2017 21:53:21 -0700
Message-Id: <20170627045321.27621-1-palmer@dabbelt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RISC-V ISA defines a simple console that is availiable via SBI calls
on all systems.  This patch adds a driver for this console interface
that can act as both a target for early printk and as the system
console.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 drivers/tty/hvc/Kconfig   |  11 +++++
 drivers/tty/hvc/Makefile  |   1 +
 drivers/tty/hvc/hvc_sbi.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/tty/hvc/hvc_sbi.c

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 574da15fe618..ce610fd1982c 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -97,6 +97,17 @@ config HVC_BFIN_JTAG
 	 the HVC driver.  If you don't have JTAG, then you probably don't
 	 want this option.
 
+config HVC_SBI
+	bool "SBI console support"
+	depends on RISCV
+	select HVC_DRIVER
+	default y
+	help
+	  This enables support for console output via RISC-V SBI calls, which
+	  is normally used only during boot to output printk.
+
+	  If you don't know what do to here, say Y.
+
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
 	depends on PPC_PSERIES && HVC_CONSOLE
diff --git a/drivers/tty/hvc/Makefile b/drivers/tty/hvc/Makefile
index 6a2702be76d1..2d63bfe4a96b 100644
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_HVC_IUCV)		+= hvc_iucv.o
 obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
 obj-$(CONFIG_HVC_BFIN_JTAG)	+= hvc_bfin_jtag.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
+obj-$(CONFIG_HVC_SBI)		+= hvc_sbi.o
diff --git a/drivers/tty/hvc/hvc_sbi.c b/drivers/tty/hvc/hvc_sbi.c
new file mode 100644
index 000000000000..98114cbd85f1
--- /dev/null
+++ b/drivers/tty/hvc/hvc_sbi.c
@@ -0,0 +1,103 @@
+/*
+ * RISC-V SBI interface to hvc_console.c
+ *  based on drivers-tty/hvc/hvc_udbg.c
+ *
+ * Copyright (C) 2008 David Gibson, IBM Corporation
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
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
+#include <asm/sbi.h>
+
+#include "hvc_console.h"
+
+static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		sbi_console_putchar(buf[i]);
+
+	return i;
+}
+
+static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
+{
+	int i, c;
+
+	for (i = 0; i < count; i++) {
+		if ((c = sbi_console_getchar()) < 0)
+			break;
+		buf[i] = c;
+	}
+
+	return i;
+}
+
+static const struct hv_ops hvc_sbi_ops = {
+	.get_chars = hvc_sbi_tty_get,
+	.put_chars = hvc_sbi_tty_put,
+};
+
+static int __init hvc_sbi_init(void)
+{
+	return PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_ops, 16));
+}
+device_initcall(hvc_sbi_init);
+
+static int __init hvc_sbi_console_init(void)
+{
+	hvc_instantiate(0, 0, &hvc_sbi_ops);
+	add_preferred_console("hvc", 0, NULL);
+
+	return 0;
+}
+console_initcall(hvc_sbi_console_init);
+
+#ifdef CONFIG_EARLY_PRINTK
+static void sbi_console_write(struct console *co, const char *buf,
+			      unsigned int n)
+{
+	int i;
+
+	for (i = 0; i < n; ++i) {
+		if (buf[i] == '\n')
+			sbi_console_putchar('\r');
+		sbi_console_putchar(buf[i]);
+	}
+}
+
+static struct console early_console_dev __initdata = {
+	.name	= "early",
+	.write	= sbi_console_write,
+	.flags	= CON_PRINTBUFFER | CON_BOOT,
+	.index	= -1
+};
+
+static int __init setup_early_printk(char *str)
+{
+	if (early_console == NULL) {
+		early_console = &early_console_dev;
+		register_console(early_console);
+	}
+	return 0;
+}
+early_param("earlyprintk", setup_early_printk);
+#endif
-- 
2.13.0
