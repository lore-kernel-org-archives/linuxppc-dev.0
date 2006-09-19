Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B17E567B63
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 22:23:53 +1000 (EST)
Date: Tue, 19 Sep 2006 22:23:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] convert string i/o operations to C
Message-Id: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This produces essentially the same code and will make the iSeries i/o
consolidation easier.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/Makefile    |    2 -
 arch/powerpc/kernel/io.c        |  125 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/misc.S      |   95 ------------------------------
 arch/powerpc/kernel/ppc_ksyms.c |    7 --
 4 files changed, 126 insertions(+), 103 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 8b3f4fa..8b133af 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -51,7 +51,7 @@ extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds
 
 obj-y				+= time.o prom.o traps.o setup-common.o \
-				   udbg.o misc.o
+				   udbg.o misc.o io.o
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
 obj-$(CONFIG_PPC64)		+= misc_64.o dma_64.o iommu.o
 obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
diff --git a/arch/powerpc/kernel/io.c b/arch/powerpc/kernel/io.c
new file mode 100644
index 0000000..c83970d
--- /dev/null
+++ b/arch/powerpc/kernel/io.c
@@ -0,0 +1,125 @@
+/*
+ * I/O string operations
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *    Copyright (C) 2006 IBM Corporation
+ *
+ * Largely rewritten by Cort Dougan (cort@cs.nmt.edu)
+ * and Paul Mackerras.
+ *
+ * Adapted for iSeries by Mike Corrigan (mikejc@us.ibm.com)
+ * PPC64 updates by Dave Engebretsen (engebret@us.ibm.com)
+ *
+ * Rewritten in C by Stephen Rothwell.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+
+#include <asm/io.h>
+
+void _insb(volatile u8 __iomem *port, void *buf, int ns)
+{
+	asm volatile("sync");
+	if (ns <= 0)
+		return;
+	asm volatile(
+		"mtctr	%2\n"
+		"subi	%1,%1,1\n"
+		"0:	lbz	%2,0(%0)\n"
+		"eieio\n"
+		"stbu	%2,1(%1)\n"
+		"bdnz	0b\n"
+		"twi	0,%2,0\n"
+		"isync\n"
+	: : "r" (port), "r" (buf), "r" (ns));
+}
+EXPORT_SYMBOL(_insb);
+
+void _outsb(volatile u8 __iomem *port, const void *buf, int ns)
+{
+	if (ns <= 0)
+		return;
+	asm volatile(
+		"mtctr	%2\n"
+		"subi	%1,%1,1\n"
+		"sync\n"
+		"0:	lbzu	%2,1(%1)\n"
+		"stb	%2,0(%0)\n"
+		"bdnz	0b\n"
+		"sync\n"
+	: : "r" (port), "r" (buf), "r" (ns));
+}
+EXPORT_SYMBOL(_outsb);
+
+void _insw_ns(volatile u16 __iomem *port, void *buf, int ns)
+{
+	asm volatile("sync");
+	if (ns <= 0)
+		return;
+	asm volatile(
+		"mtctr	%2\n"
+		"subi	%1,%1,2\n"
+		"0:	lhz	%2,0(%0)\n"
+		"eieio\n"
+		"sthu	%2,2(%1)\n"
+		"bdnz	0b\n"
+		"twi	0,%2,0\n"
+		"isync\n"
+	: : "r" (port), "r" (buf), "r" (ns));
+}
+EXPORT_SYMBOL(_insw_ns);
+
+void _outsw_ns(volatile u16 __iomem *port, const void *buf, int ns)
+{
+	if (ns <= 0)
+		return;
+	asm volatile(
+		"mtctr	%2\n"
+		"subi	%1,%1,2\n"
+		"sync\n"
+		"0:	lhzu	%2,2(%1)\n"
+		"sth	%2,0(%0)\n"
+		"bdnz	0b\n"
+		"sync\n"
+	: : "r" (port), "r" (buf), "r" (ns));
+}
+EXPORT_SYMBOL(_outsw_ns);
+
+void _insl_ns(volatile u32 __iomem *port, void *buf, int nl)
+{
+	asm volatile("sync");
+	if (nl <= 0)
+		return;
+	asm volatile(
+		"mtctr	%2\n"
+		"subi	%1,%1,4\n"
+		"0:	lwz	%2,0(%0)\n"
+		"eieio\n"
+		"stwu	%2,4(%1)\n"
+		"bdnz	0b\n"
+		"twi	0,%2,0\n"
+		"isync\n"
+	: : "r" (port), "r" (buf), "r" (nl));
+}
+EXPORT_SYMBOL(_insl_ns);
+
+void _outsl_ns(volatile u32 __iomem *port, const void *buf, int nl)
+{
+	if (nl <= 0)
+		return;
+	asm volatile(
+		"mtctr	%2\n"
+		"subi	%1,%1,4\n"
+		"sync\n"
+		"0:	lwzu	%2,4(%1)\n"
+		"stw	%2,0(%0)\n"
+		"bdnz	0b\n"
+		"sync\n"
+	: : "r" (port), "r" (buf), "r" (nl));
+}
+EXPORT_SYMBOL(_outsl_ns);
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 6feb391..330c9dc 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -43,98 +43,3 @@ _GLOBAL(add_reloc_offset)
 	add	r3,r3,r5
 	mtlr	r0
 	blr
-
-/*
- * I/O string operations
- *
- * insb(port, buf, len)
- * outsb(port, buf, len)
- * insw(port, buf, len)
- * outsw(port, buf, len)
- * insl(port, buf, len)
- * outsl(port, buf, len)
- * insw_ns(port, buf, len)
- * outsw_ns(port, buf, len)
- * insl_ns(port, buf, len)
- * outsl_ns(port, buf, len)
- *
- * The *_ns versions don't do byte-swapping.
- */
-_GLOBAL(_insb)
-	sync
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,1
-	blelr-
-00:	lbz	r5,0(r3)
-	eieio
-	stbu	r5,1(r4)
-	bdnz	00b
-	twi	0,r5,0
-	isync
-	blr
-
-_GLOBAL(_outsb)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,1
-	blelr-
-	sync
-00:	lbzu	r5,1(r4)
-	stb	r5,0(r3)
-	bdnz	00b
-	sync
-	blr
-
-_GLOBAL(_insw_ns)
-	sync
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-00:	lhz	r5,0(r3)
-	eieio
-	sthu	r5,2(r4)
-	bdnz	00b
-	twi	0,r5,0
-	isync
-	blr
-
-_GLOBAL(_outsw_ns)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-	sync
-00:	lhzu	r5,2(r4)
-	sth	r5,0(r3)
-	bdnz	00b
-	sync
-	blr
-
-_GLOBAL(_insl_ns)
-	sync
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-00:	lwz	r5,0(r3)
-	eieio
-	stwu	r5,4(r4)
-	bdnz	00b
-	twi	0,r5,0
-	isync
-	blr
-
-_GLOBAL(_outsl_ns)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-	sync
-00:	lwzu	r5,4(r4)
-	stw	r5,0(r3)
-	bdnz	00b
-	sync
-	blr
-
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 75429e5..807193a 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -95,13 +95,6 @@ #ifdef CONFIG_PPC64
 EXPORT_SYMBOL(copy_4K_page);
 #endif
 
-EXPORT_SYMBOL(_insb);
-EXPORT_SYMBOL(_outsb);
-EXPORT_SYMBOL(_insw_ns);
-EXPORT_SYMBOL(_outsw_ns);
-EXPORT_SYMBOL(_insl_ns);
-EXPORT_SYMBOL(_outsl_ns);
-
 #if defined(CONFIG_PPC32) && (defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE))
 EXPORT_SYMBOL(ppc_ide_md);
 #endif
-- 
1.4.2.1
