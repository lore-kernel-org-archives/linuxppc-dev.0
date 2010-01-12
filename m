Return-Path: <anton@ozlabs.org>
Date: Tue, 12 Jan 2010 21:56:42 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Reduce footprint of irq_stat
Message-ID: <20100112105642.GI12666@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


PowerPC is currently using asm-generic/hardirq.h which statically allocates an
NR_CPUS irq_stat array. Switch to an arch specific implementation which uses
per cpu data:

On a kernel with NR_CPUS=1024, this saves quite a lot of memory:

   text    data     bss      dec         hex    filename
8767938 2944132 1636796 13348866         cbb002 vmlinux.baseline
8767779 2944260 1505724 13217763         c9afe3 vmlinux.irq_cpustat

A saving of around 128kB.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/include/asm/hardirq.h
===================================================================
--- linux-cpumask.orig/arch/powerpc/include/asm/hardirq.h	2010-01-06 16:24:31.220084536 +1100
+++ linux-cpumask/arch/powerpc/include/asm/hardirq.h	2010-01-06 17:45:25.219563704 +1100
@@ -1 +1,22 @@
-#include <asm-generic/hardirq.h>
+#ifndef _ASM_POWERPC_HARDIRQ_H
+#define _ASM_POWERPC_HARDIRQ_H
+
+#include <linux/threads.h>
+#include <linux/irq.h>
+
+typedef struct {
+	unsigned int __softirq_pending;
+} ____cacheline_aligned irq_cpustat_t;
+
+DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+
+#define __ARCH_IRQ_STAT
+
+#define local_softirq_pending()	__get_cpu_var(irq_stat).__softirq_pending
+
+static inline void ack_bad_irq(unsigned int irq)
+{
+	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
+}
+
+#endif /* _ASM_POWERPC_HARDIRQ_H */
Index: linux-cpumask/arch/powerpc/kernel/irq.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/irq.c	2010-01-06 16:29:31.370083802 +1100
+++ linux-cpumask/arch/powerpc/kernel/irq.c	2010-01-06 16:48:04.210086075 +1100
@@ -73,6 +73,9 @@
 #define CREATE_TRACE_POINTS
 #include <asm/trace.h>
 
+DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+EXPORT_PER_CPU_SYMBOL(irq_stat);
+
 int __irq_offset_value;
 static int ppc_spurious_interrupts;
 
