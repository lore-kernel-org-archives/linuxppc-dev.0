Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 17 Apr 2008 14:35:00 +1000
Subject: [PATCH 2/3] [POWERPC] lockdep stacktrace support
Message-Id: <20080417043608.9B12CDE1F9@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christoph Hellwig <hch@lst.de>

I recently tried to work on lockdep for powerpc.  I have preliminary
version of the stacktrace code, but had to give up on trace irqflags
support because I'm not that knowledgeable on lowlevel ppc details.

Maybe someone more faimilar with the code wants to give it another try?

My stacktrace code is below:

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 arch/powerpc/Kconfig             |    4 +++
 arch/powerpc/kernel/Makefile     |    1 
 arch/powerpc/kernel/stacktrace.c |   47 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

--- linux-work.orig/arch/powerpc/Kconfig	2008-04-17 13:17:06.000000000 +1000
+++ linux-work/arch/powerpc/Kconfig	2008-04-17 13:24:30.000000000 +1000
@@ -49,6 +49,10 @@ config IRQ_PER_CPU
 	bool
 	default y
 
+config STACKTRACE_SUPPORT
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
Index: linux-work/arch/powerpc/kernel/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/kernel/Makefile	2008-04-17 13:17:06.000000000 +1000
+++ linux-work/arch/powerpc/kernel/Makefile	2008-04-17 13:24:31.000000000 +1000
@@ -67,6 +67,7 @@ obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
+obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 
 pci64-$(CONFIG_PPC64)		+= pci_dn.o isa-bridge.o
 obj-$(CONFIG_PCI)		+= pci_$(CONFIG_WORD_SIZE).o $(pci64-y) \
Index: linux-work/arch/powerpc/kernel/stacktrace.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/kernel/stacktrace.c	2008-04-17 13:24:47.000000000 +1000
@@ -0,0 +1,47 @@
+/*
+ * Stack trace utility
+ *
+ * Copyright 2008 Christoph Hellwig, IBM Corp.
+ *
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sched.h>
+#include <linux/stacktrace.h>
+#include <asm/ptrace.h>
+#include <asm/asm-offsets.h>
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
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
+		if (!validate_sp(sp, current, STACK_FRAME_OVERHEAD))
+			return;
+
+		newsp = stack[0];
+		ip = stack[STACK_FRAME_LR_SAVE];
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
