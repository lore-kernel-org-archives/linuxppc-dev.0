Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2504B67A3E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 13:35:42 +1000 (EST)
Date: Wed, 20 Sep 2006 13:35:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] convert string i/o operations to C
Message-Id: <20060920133532.ce818ab7.sfr@canb.auug.org.au>
In-Reply-To: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
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

The count parameter is changed to long since that will produce the same
(better) code on 32 and 64 bit builds.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/Makefile    |    2 -
 arch/powerpc/kernel/io.c        |  117 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/misc.S      |   95 --------------------------------
 arch/powerpc/kernel/ppc_ksyms.c |    7 --
 include/asm-powerpc/io.h        |   12 ++--
 include/asm-ppc/io.h            |   12 ++--
 6 files changed, 130 insertions(+), 115 deletions(-)

This version has lots more C code.  Paulus also said that the "sync"s
could go after the check for count <= 0.

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
index 0000000..80a3209
--- /dev/null
+++ b/arch/powerpc/kernel/io.c
@@ -0,0 +1,117 @@
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
+#include <linux/compiler.h>
+#include <linux/module.h>
+
+#include <asm/io.h>
+
+void _insb(volatile u8 __iomem *port, void *buf, long count)
+{
+	u8 *tbuf = buf;
+	u8 tmp;
+
+	if (unlikely(count <= 0))
+		return;
+	asm volatile("sync");
+	do {
+		tmp = *port;
+		asm volatile("eieio");
+		*tbuf++ = tmp;
+	} while (--count != 0);
+	asm volatile("twi 0,%0,0; isync" : : "r" (tmp));
+}
+EXPORT_SYMBOL(_insb);
+
+void _outsb(volatile u8 __iomem *port, const void *buf, long count)
+{
+	const u8 *tbuf = buf;
+
+	if (unlikely(count <= 0))
+		return;
+	asm volatile("sync");
+	do {
+		*port = *tbuf++;
+	} while (--count != 0);
+	asm volatile("sync");
+}
+EXPORT_SYMBOL(_outsb);
+
+void _insw_ns(volatile u16 __iomem *port, void *buf, long count)
+{
+	u16 *tbuf = buf;
+	u16 tmp;
+
+	if (unlikely(count <= 0))
+		return;
+	asm volatile("sync");
+	do {
+		tmp = *port;
+		asm volatile("eieio");
+		*tbuf++ = tmp;
+	} while (--count != 0);
+	asm volatile("twi 0,%0,0; isync" : : "r" (tmp));
+}
+EXPORT_SYMBOL(_insw_ns);
+
+void _outsw_ns(volatile u16 __iomem *port, const void *buf, long count)
+{
+	const u16 *tbuf = buf;
+
+	if (unlikely(count <= 0))
+		return;
+	asm volatile("sync");
+	do {
+		*port = *tbuf++;
+	} while (--count != 0);
+	asm volatile("sync");
+}
+EXPORT_SYMBOL(_outsw_ns);
+
+void _insl_ns(volatile u32 __iomem *port, void *buf, long count)
+{
+	u32 *tbuf = buf;
+	u32 tmp;
+
+	if (unlikely(count <= 0))
+		return;
+	asm volatile("sync");
+	do {
+		tmp = *port;
+		asm volatile("eieio");
+		*tbuf++ = tmp;
+	} while (--count != 0);
+	asm volatile("twi 0,%0,0; isync" : : "r" (tmp));
+}
+EXPORT_SYMBOL(_insl_ns);
+
+void _outsl_ns(volatile u32 __iomem *port, const void *buf, long count)
+{
+	const u32 *tbuf = buf;
+
+	if (unlikely(count <= 0))
+		return;
+	asm volatile("sync");
+	do {
+		*port = *tbuf++;
+	} while (--count != 0);
+	asm volatile("sync");
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
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 51a5987..57e7d14 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -143,12 +143,12 @@ #define readw_relaxed(addr) readw(addr)
 #define readl_relaxed(addr) readl(addr)
 #define readq_relaxed(addr) readq(addr)
 
-extern void _insb(volatile u8 __iomem *port, void *buf, int ns);
-extern void _outsb(volatile u8 __iomem *port, const void *buf, int ns);
-extern void _insw_ns(volatile u16 __iomem *port, void *buf, int ns);
-extern void _outsw_ns(volatile u16 __iomem *port, const void *buf, int ns);
-extern void _insl_ns(volatile u32 __iomem *port, void *buf, int nl);
-extern void _outsl_ns(volatile u32 __iomem *port, const void *buf, int nl);
+extern void _insb(volatile u8 __iomem *port, void *buf, long count);
+extern void _outsb(volatile u8 __iomem *port, const void *buf, long count);
+extern void _insw_ns(volatile u16 __iomem *port, void *buf, long count);
+extern void _outsw_ns(volatile u16 __iomem *port, const void *buf, long count);
+extern void _insl_ns(volatile u32 __iomem *port, void *buf, long count);
+extern void _outsl_ns(volatile u32 __iomem *port, const void *buf, long count);
 
 static inline void mmiowb(void)
 {
diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
index 9fac420..3d9a9e6 100644
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -327,12 +327,12 @@ #define outw_p(val, port)	outw((val), (p
 #define inl_p(port)		inl((port))
 #define outl_p(val, port)	outl((val), (port))
 
-extern void _insb(volatile u8 __iomem *port, void *buf, int ns);
-extern void _outsb(volatile u8 __iomem *port, const void *buf, int ns);
-extern void _insw_ns(volatile u16 __iomem *port, void *buf, int ns);
-extern void _outsw_ns(volatile u16 __iomem *port, const void *buf, int ns);
-extern void _insl_ns(volatile u32 __iomem *port, void *buf, int nl);
-extern void _outsl_ns(volatile u32 __iomem *port, const void *buf, int nl);
+extern void _insb(volatile u8 __iomem *port, void *buf, long count);
+extern void _outsb(volatile u8 __iomem *port, const void *buf, long count);
+extern void _insw_ns(volatile u16 __iomem *port, void *buf, long count);
+extern void _outsw_ns(volatile u16 __iomem *port, const void *buf, long count);
+extern void _insl_ns(volatile u32 __iomem *port, void *buf, long count);
+extern void _outsl_ns(volatile u32 __iomem *port, const void *buf, long count);
 
 
 #define IO_SPACE_LIMIT ~0
-- 
1.4.2.1
