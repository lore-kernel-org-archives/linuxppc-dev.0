Return-Path: <jdl@jdl.com>
From: linuxppc@jdl.com
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Date: Mon, 19 Sep 2005 09:32:07 -0500
Message-Id: <E1EHMgh-000228-N7@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: PATCH powerpc: Revised merge asm-ppc*/hardirq.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a revised patch to merge asm-ppc*/hardirq.h.
It removes some unnecessary #includes, but then requires
the addition of #include <asm/irq.h> in PPC32's hw_irq.h
much like ppc64 already does.  Furthermore, several
unnecessary #includes were removed from some ppc32 boards
in order to break resulting bad #include cycles.

Builds pSeries_defconfig and all ppc32 platforms except
the already b0rken bseip.


Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---


 arch/ppc/platforms/83xx/mpc834x_sys.h        |    1 -
 arch/ppc/platforms/85xx/mpc85xx_ads_common.h |    1 -
 arch/ppc/platforms/85xx/stx_gp3.h            |    1 -
 include/asm-powerpc/hardirq.h                |   24 ++++++++++++++++++++
 include/asm-ppc/hardirq.h                    |   31 --------------------------
 include/asm-ppc/hw_irq.h                     |    1 +
 include/asm-ppc64/hardirq.h                  |   27 -----------------------
 7 files changed, 25 insertions(+), 61 deletions(-)


diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.h b/arch/ppc/platforms/83xx/mpc834x_sys.h
--- a/arch/ppc/platforms/83xx/mpc834x_sys.h
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.h
@@ -19,7 +19,6 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
-#include <linux/seq_file.h>
 #include <syslib/ppc83xx_setup.h>
 #include <asm/ppcboot.h>
 
diff --git a/arch/ppc/platforms/85xx/mpc85xx_ads_common.h b/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
@@ -19,7 +19,6 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
-#include <linux/seq_file.h>
 #include <asm/ppcboot.h>
 
 #define BOARD_CCSRBAR		((uint)0xe0000000)
diff --git a/arch/ppc/platforms/85xx/stx_gp3.h b/arch/ppc/platforms/85xx/stx_gp3.h
--- a/arch/ppc/platforms/85xx/stx_gp3.h
+++ b/arch/ppc/platforms/85xx/stx_gp3.h
@@ -21,7 +21,6 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
-#include <linux/seq_file.h>
 #include <asm/ppcboot.h>
 
 #define BOARD_CCSRBAR		((uint)0xe0000000)
diff --git a/include/asm-powerpc/hardirq.h b/include/asm-powerpc/hardirq.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/hardirq.h
@@ -0,0 +1,24 @@
+#ifndef _ASM_POWERPC_HARDIRQ_H
+#define _ASM_POWERPC_HARDIRQ_H
+
+/* The __last_jiffy_stamp field is needed to ensure that no decrementer
+ * interrupt is lost on SMP machines. Since on most CPUs it is in the same
+ * cache line as local_irq_count, it is cheap to access and is also used on UP
+ * for uniformity.
+ */
+typedef struct {
+	unsigned int __softirq_pending;	/* set_bit is used on this */
+	unsigned int __last_jiffy_stamp;
+} ____cacheline_aligned irq_cpustat_t;
+
+#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+
+#define last_jiffy_stamp(cpu) __IRQ_STAT((cpu), __last_jiffy_stamp)
+
+static inline void ack_bad_irq(int irq)
+{
+	printk(KERN_CRIT "illegal vector %d received!\n", irq);
+	BUG();
+}
+
+#endif /* _ASM_POWERPC_HARDIRQ_H */
diff --git a/include/asm-ppc/hardirq.h b/include/asm-ppc/hardirq.h
deleted file mode 100644
--- a/include/asm-ppc/hardirq.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifdef __KERNEL__
-#ifndef __ASM_HARDIRQ_H
-#define __ASM_HARDIRQ_H
-
-#include <linux/config.h>
-#include <linux/cache.h>
-#include <linux/smp_lock.h>
-#include <asm/irq.h>
-
-/* The __last_jiffy_stamp field is needed to ensure that no decrementer
- * interrupt is lost on SMP machines. Since on most CPUs it is in the same
- * cache line as local_irq_count, it is cheap to access and is also used on UP
- * for uniformity.
- */
-typedef struct {
-	unsigned long __softirq_pending;	/* set_bit is used on this */
-	unsigned int __last_jiffy_stamp;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
-#define last_jiffy_stamp(cpu) __IRQ_STAT((cpu), __last_jiffy_stamp)
-
-static inline void ack_bad_irq(int irq)
-{
-	printk(KERN_CRIT "illegal vector %d received!\n", irq);
-	BUG();
-}
-
-#endif /* __ASM_HARDIRQ_H */
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/hw_irq.h b/include/asm-ppc/hw_irq.h
--- a/include/asm-ppc/hw_irq.h
+++ b/include/asm-ppc/hw_irq.h
@@ -7,6 +7,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/reg.h>
+#include <asm/irq.h>
 
 extern void timer_interrupt(struct pt_regs *);
 
diff --git a/include/asm-ppc64/hardirq.h b/include/asm-ppc64/hardirq.h
deleted file mode 100644
--- a/include/asm-ppc64/hardirq.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef __ASM_HARDIRQ_H
-#define __ASM_HARDIRQ_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/config.h>
-#include <linux/cache.h>
-#include <linux/preempt.h>
-
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
-static inline void ack_bad_irq(int irq)
-{
-	printk(KERN_CRIT "illegal vector %d received!\n", irq);
-	BUG();
-}
-
-#endif /* __ASM_HARDIRQ_H */
