Return-Path: <anton@ozlabs.org>
Date: Mon, 1 Feb 2010 17:30:23 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 1/7] powerpc: Reduce footprint of irq_stat
Message-ID: <20100201063023.GT2996@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
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
--- linux-cpumask.orig/arch/powerpc/include/asm/hardirq.h	2010-01-31 22:07:21.037211728 +1100
+++ linux-cpumask/arch/powerpc/include/asm/hardirq.h	2010-02-01 17:28:56.990963256 +1100
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
--- linux-cpumask.orig/arch/powerpc/kernel/irq.c	2010-01-31 22:07:21.027213106 +1100
+++ linux-cpumask/arch/powerpc/kernel/irq.c	2010-02-01 17:28:56.880963661 +1100
@@ -73,6 +73,9 @@
 #define CREATE_TRACE_POINTS
 #include <asm/trace.h>
 
+DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+EXPORT_PER_CPU_SYMBOL(irq_stat);
+
 int __irq_offset_value;
 static int ppc_spurious_interrupts;
 
