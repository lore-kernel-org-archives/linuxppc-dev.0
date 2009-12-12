Return-Path: <albert_herranz@yahoo.es>
Received: from smtp104.mail.ukl.yahoo.com (smtp104.mail.ukl.yahoo.com
	[77.238.184.36]) by ozlabs.org (Postfix) with SMTP id 338B8B7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Dec 2009 03:32:04 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 01/22] powerpc: gamecube/wii: usbgecko bootwrapper console
	support
Date: Sat, 12 Dec 2009 17:31:34 +0100
Message-Id: <1260635515-7478-2-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1260635515-7478-1-git-send-email-albert_herranz@yahoo.es>
References: <1260635515-7478-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for using the USB Gecko adapter as a bootwrapper console on
the Nintendo GameCube and Wii video game consoles.
The USB Gecko is a 3rd party memory card interface adapter that provides
a EXI (External Interface) to USB serial converter.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/boot/Makefile |    2 +-
 arch/powerpc/boot/ugecon.c |  147 ++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/ugecon.h |   24 +++++++
 3 files changed, 172 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/ugecon.c
 create mode 100644 arch/powerpc/boot/ugecon.h

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 7bfc8ad..44bce21 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -66,7 +66,7 @@ src-wlib := string.S crt0.S crtsavres.S stdio.c main.c \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
 		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
-		fsl-soc.c mpc8xx.c pq2.c
+		fsl-soc.c mpc8xx.c pq2.c ugecon.c
 src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c cuboot-hotfoot.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
diff --git a/arch/powerpc/boot/ugecon.c b/arch/powerpc/boot/ugecon.c
new file mode 100644
index 0000000..50609ea
--- /dev/null
+++ b/arch/powerpc/boot/ugecon.c
@@ -0,0 +1,147 @@
+/*
+ * arch/powerpc/boot/ugecon.c
+ *
+ * USB Gecko bootwrapper console.
+ * Copyright (C) 2008-2009 The GameCube Linux Team
+ * Copyright (C) 2008,2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+
+#include <stddef.h>
+#include "stdio.h"
+#include "types.h"
+#include "io.h"
+#include "ops.h"
+
+
+#define EXI_CLK_32MHZ           5
+
+#define EXI_CSR                 0x00
+#define   EXI_CSR_CLKMASK       (0x7<<4)
+#define     EXI_CSR_CLK_32MHZ   (EXI_CLK_32MHZ<<4)
+#define   EXI_CSR_CSMASK        (0x7<<7)
+#define     EXI_CSR_CS_0        (0x1<<7)  /* Chip Select 001 */
+
+#define EXI_CR                  0x0c
+#define   EXI_CR_TSTART         (1<<0)
+#define   EXI_CR_WRITE		(1<<2)
+#define   EXI_CR_READ_WRITE     (2<<2)
+#define   EXI_CR_TLEN(len)      (((len)-1)<<4)
+
+#define EXI_DATA                0x10
+
+
+/* virtual address base for input/output, retrieved from device tree */
+static void *ug_io_base;
+
+
+static u32 ug_io_transaction(u32 in)
+{
+	u32 *csr_reg = ug_io_base + EXI_CSR;
+	u32 *data_reg = ug_io_base + EXI_DATA;
+	u32 *cr_reg = ug_io_base + EXI_CR;
+	u32 csr, data, cr;
+
+	/* select */
+	csr = EXI_CSR_CLK_32MHZ | EXI_CSR_CS_0;
+	out_be32(csr_reg, csr);
+
+	/* read/write */
+	data = in;
+	out_be32(data_reg, data);
+	cr = EXI_CR_TLEN(2) | EXI_CR_READ_WRITE | EXI_CR_TSTART;
+	out_be32(cr_reg, cr);
+
+	while (in_be32(cr_reg) & EXI_CR_TSTART)
+		barrier();
+
+	/* deselect */
+	out_be32(csr_reg, 0);
+
+	data = in_be32(data_reg);
+	return data;
+}
+
+static int ug_is_txfifo_ready(void)
+{
+	return ug_io_transaction(0xc0000000) & 0x04000000;
+}
+
+static void ug_raw_putc(char ch)
+{
+	ug_io_transaction(0xb0000000 | (ch << 20));
+}
+
+static void ug_putc(char ch)
+{
+	int count = 16;
+
+	if (!ug_io_base)
+		return;
+
+	while (!ug_is_txfifo_ready() && count--)
+		barrier();
+	if (count)
+		ug_raw_putc(ch);
+}
+
+void ug_console_write(const char *buf, int len)
+{
+	char *b = (char *)buf;
+
+	while (len--) {
+		if (*b == '\n')
+			ug_putc('\r');
+		ug_putc(*b++);
+	}
+}
+
+static int ug_is_adapter_present(void)
+{
+	if (!ug_io_base)
+		return 0;
+	return ug_io_transaction(0x90000000) == 0x04700000;
+}
+
+static void *ug_grab_exi_io_base(void)
+{
+	u32 v;
+	void *devp;
+
+	devp = find_node_by_compatible(NULL, "nintendo,flipper-exi");
+	if (devp == NULL)
+		goto err_out;
+	if (getprop(devp, "virtual-reg", &v, sizeof(v)) != sizeof(v))
+		goto err_out;
+
+	return (void *)v;
+
+err_out:
+	return NULL;
+}
+
+void *ug_probe(void)
+{
+	void *exi_io_base;
+	int i;
+
+	exi_io_base = ug_grab_exi_io_base();
+	if (!exi_io_base)
+		return NULL;
+
+	/* look for a usbgecko on memcard slots A and B */
+	for (i = 0; i < 2; i++) {
+		ug_io_base = exi_io_base + 0x14 * i;
+		if (ug_is_adapter_present())
+			break;
+	}
+	if (i == 2)
+		ug_io_base = NULL;
+	return ug_io_base;
+}
+
diff --git a/arch/powerpc/boot/ugecon.h b/arch/powerpc/boot/ugecon.h
new file mode 100644
index 0000000..4373753
--- /dev/null
+++ b/arch/powerpc/boot/ugecon.h
@@ -0,0 +1,24 @@
+/*
+ * arch/powerpc/boot/ugecon.h
+ *
+ * USB Gecko early bootwrapper console.
+ * Copyright (C) 2008-2009 The GameCube Linux Team
+ * Copyright (C) 2008,2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+
+#ifndef __UGECON_H
+#define __UGECON_H
+
+extern void *ug_probe(void);
+
+extern void ug_putc(char ch);
+extern void ug_console_write(const char *buf, int len);
+
+#endif /* __UGECON_H */
+
-- 
1.6.3.3
