Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@ozlabs.org>
Date: Wed, 02 Apr 2008 18:52:10 +1100
Subject: [PATCH 2/4] [POWERPC] lockdep stacktrace support
In-Reply-To: <1207122728.672673.111194574046.qpush@grosgo>
Message-Id: <20080402075254.24539DDEDD@ozlabs.org>
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
 arch/powerpc/kernel/stacktrace.c |   52 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

--- linux-work.orig/arch/powerpc/Kconfig	2008-04-02 15:46:07.000000000 +1100
+++ linux-work/arch/powerpc/Kconfig	2008-04-02 16:47:46.000000000 +1100
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
--- linux-work.orig/arch/powerpc/kernel/Makefile	2008-04-02 15:46:07.000000000 +1100
+++ linux-work/arch/powerpc/kernel/Makefile	2008-04-02 16:46:07.000000000 +1100
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
+++ linux-work/arch/powerpc/kernel/stacktrace.c	2008-04-02 16:46:07.000000000 +1100
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
