Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id AB2EFDDE3D
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 08:20:23 +1000 (EST)
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP7000M1CPYTI80@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:20:22 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP700GKRCPXW510@pd2mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 30 Sep 2007 16:20:22 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP700CXMCPWJKU2@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:20:20 -0600 (MDT)
Date: Sun, 30 Sep 2007 16:20:20 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCHv2 1/4] Virtex: Add uartlite bootwrapper driver
In-reply-to: <20070930221613.583.252.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20070930222011.583.17160.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070930221613.583.252.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Allows the bootwrapper to use the uartlite device for console output.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/Makefile   |    2 +
 arch/powerpc/boot/ops.h      |    1 +
 arch/powerpc/boot/serial.c   |    2 +
 arch/powerpc/boot/uartlite.c |   64 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index c1582b6..371fbc6 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -45,7 +45,7 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
-		cpm-serial.c stdlib.c
+		cpm-serial.c stdlib.c uartlite.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 703255b..4ef30e4 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -84,6 +84,7 @@ int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 int mpsc_console_init(void *devp, struct serial_console_data *scdp);
 int cpm_console_init(void *devp, struct serial_console_data *scdp);
+int uartlite_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, unsigned long heap_size,
 			unsigned long granularity, unsigned long max_allocs);
 extern void flush_cache(void *, unsigned long);
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index d47f8e0..70f36bf 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -126,6 +126,8 @@ int serial_console_init(void)
 	         dt_is_compatible(devp, "fsl,cpm2-scc-uart") ||
 	         dt_is_compatible(devp, "fsl,cpm2-smc-uart"))
 		rc = cpm_console_init(devp, &serial_cd);
+	else if (dt_is_compatible(devp, "xilinx,uartlite"))
+		rc = uartlite_console_init(devp, &serial_cd);
 
 	/* Add other serial console driver calls here */
 
diff --git a/arch/powerpc/boot/uartlite.c b/arch/powerpc/boot/uartlite.c
new file mode 100644
index 0000000..f4249a7
--- /dev/null
+++ b/arch/powerpc/boot/uartlite.c
@@ -0,0 +1,64 @@
+/*
+ * Xilinx UARTLITE bootloader driver
+ *
+ * Copyright (C) 2007 Secret Lab Technologies Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "string.h"
+#include "stdio.h"
+#include "io.h"
+#include "ops.h"
+
+static void * reg_base;
+
+static int uartlite_open(void)
+{
+	/* Clear the RX FIFO */
+	out_be32(reg_base + 0x0C, 0x2);
+	return 0;
+}
+
+static void uartlite_putc(unsigned char c)
+{
+	while ((in_be32(reg_base + 0x8) & 0x08) != 0); /* spin */
+	out_be32(reg_base + 0x4, c);
+}
+
+static unsigned char uartlite_getc(void)
+{
+	while ((in_be32(reg_base + 0x8) & 0x01) == 0); /* spin */
+	return in_be32(reg_base);
+}
+
+static u8 uartlite_tstc(void)
+{
+	return ((in_be32(reg_base + 0x8) & 0x01) != 0);
+}
+
+int uartlite_console_init(void *devp, struct serial_console_data *scdp)
+{
+	int n;
+	unsigned long reg_phys;
+
+	n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
+	if (n != sizeof(reg_base)) {
+		if (!dt_xlate_reg(devp, 0, &reg_phys, NULL))
+			return -1;
+
+		reg_base = (void *)reg_phys;
+	}
+
+	scdp->open = uartlite_open;
+	scdp->putc = uartlite_putc;
+	scdp->getc = uartlite_getc;
+	scdp->tstc = uartlite_tstc;
+	scdp->close = NULL;
+	return 0;
+}
