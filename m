Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1126643920.11056.53.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 13 Sep 2005 15:38:40 -0500
Subject: PATCH powerpc: Merge asm-ppc*/hardirq.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a patch to merge asm-ppc*/hardirq.h.

Does anyone know of a problem in ppc64 land that
will be caused by having added the jiffy_stamp
field into this cacheline-aligned structure?

Also, of note here, I dodged the hard question
of what to do with SMP and preemption and stuff.
Lots more work will have to be resolved to really
answer those questions.  Let's start here for now...

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

diff --git a/include/asm-powerpc/hardirq.h b/include/asm-powerpc/hardirq.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/hardirq.h
@@ -0,0 +1,36 @@
+#ifndef _ASM_POWERPC_HARDIRQ_H
+#define _ASM_POWERPC_HARDIRQ_H
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/cache.h>
+
+#ifdef __powerpc64__
+#include <linux/preempt.h>
+#else
+#include <linux/smp_lock.h>
+#include <asm/irq.h>
+#endif
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
+#endif /* __KERNEL__ */
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
