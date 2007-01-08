Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97C9DDDDF9
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 00:55:03 +1100 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l08DswaX023531
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jan 2007 14:54:59 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l08Dsw3w023529
	for linuxppc-dev@ozlabs.org; Mon, 8 Jan 2007 14:54:58 +0100
Date: Mon, 8 Jan 2007 14:54:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: powerpc stacktrace and lockdep support
Message-ID: <20070108135458.GA23395@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I recently tried to work on lockdep for powerpc.  I have preliminary
version of the stacktrace code, but had to give up on trace irqflags
support because I'm not that knowledgeable on lowlevel ppc details.

Maybe someone more faimilar with the code wants to give it another try?

My stacktrace code is below:


Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig	2006-12-25 13:47:19.000000000 +0100
+++ linux-2.6/arch/powerpc/Kconfig	2006-12-25 13:47:53.000000000 +0100
@@ -34,6 +34,10 @@
 	bool
 	default y
 
+config STACKTRACE_SUPPORT
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
Index: linux-2.6/arch/powerpc/kernel/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/Makefile	2006-12-25 13:47:19.000000000 +0100
+++ linux-2.6/arch/powerpc/kernel/Makefile	2006-12-25 13:47:53.000000000 +0100
@@ -58,6 +58,7 @@
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
+obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 
 module-$(CONFIG_PPC64)		+= module_64.o
 obj-$(CONFIG_MODULES)		+= $(module-y)
Index: linux-2.6/arch/powerpc/kernel/stacktrace.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/powerpc/kernel/stacktrace.c	2006-12-25 13:51:06.000000000 +0100
@@ -0,0 +1,52 @@
+
+#include <linux/sched.h>
+#include <linux/stacktrace.h>
+
+
+#ifdef CONFIG_PPC64
+#define MIN_STACK_FRAME 112     /* same as STACK_FRAME_OVERHEAD, in fact */
+#define FRAME_LR_SAVE   2
+#define INT_FRAME_SIZE  (sizeof(struct pt_regs) + STACK_FRAME_OVERHEAD + 288)
+#define REGS_MARKER     0x7265677368657265ul
+#define FRAME_MARKER    12
+#else
+#define MIN_STACK_FRAME 16
+#define FRAME_LR_SAVE   1
+#define INT_FRAME_SIZE  (sizeof(struct pt_regs) + STACK_FRAME_OVERHEAD)
+#define REGS_MARKER     0x72656773ul
+#define FRAME_MARKER    2
+#endif
+
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
+ * If all_contexts is set, all contexts (hardirq, softirq and process)
+ * are saved. If not set then only the current context is saved.
+ */
+void save_stack_trace(struct stack_trace *trace)
+{
+	unsigned long sp;
+
+	asm("mr %0,1" : "=r" (sp));
+
+	for (;;) {
+		unsigned long *stack = (unsigned long *) sp;
+		unsigned long newsp, ip;
+
+		if (!validate_sp(sp, current, MIN_STACK_FRAME))
+			return;
+
+		newsp = stack[0];
+		ip = stack[FRAME_LR_SAVE];
+
+		if (!trace->skip)
+			trace->entries[trace->nr_entries++] = ip;
+		else
+			trace->skip--;
+
+		if (trace->nr_entries >= trace->max_entries)
+			return;
+
+		sp = newsp;
+	}
+}
