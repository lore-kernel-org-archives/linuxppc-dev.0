Return-Path: <galak@freescale.com>
Date: Wed, 21 Sep 2005 16:52:55 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0509211652300.28009@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: merged hw_irq.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Merged hw_irq.h between ppc32 & ppc64.  Added support to use the Book-E
wrtee[i] instructions that allow modifying MSR[EE] atomically.
Additionally, added get_irq_desc() macros to ppc32 to allow mask_irq(),
unmask_irq(), and ack_irq() to be common between ppc32 & ppc64.

Note: because 64-bit Book-E implementations only have a 32-bit MSR the
macro's for Book-E need to come before the PPC64 macro's to ensure the
right thing happends for 64-bit Book-E processors.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 1da20f52e226c6d437107d03ff4b65b2006a0b38
tree ad911d369a3c7279ba82bb750287cff39b554474
parent 8be656b5000421a25f147e712bb19417bf677c2f
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 21 Sep 2005 16:39:21 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 21 Sep 2005 16:39:21 -0500

 include/asm-powerpc/hw_irq.h |  115 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/hw_irq.h     |   59 ----------------------
 include/asm-ppc/irq.h        |    6 ++
 include/asm-ppc64/hw_irq.h   |  104 --------------------------------------
 4 files changed, 121 insertions(+), 163 deletions(-)

diff --git a/include/asm-powerpc/hw_irq.h b/include/asm-powerpc/hw_irq.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/hw_irq.h
@@ -0,0 +1,115 @@
+/*
+ * Copyright (C) 1999 Cort Dougan <cort@cs.nmt.edu>
+ */
+#ifndef _ASM_POWERPC_HW_IRQ_H
+#define _ASM_POWERPC_HW_IRQ_H
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <asm/ptrace.h>
+#include <asm/processor.h>
+#include <asm/irq.h>
+
+extern void timer_interrupt(struct pt_regs *);
+extern void ppc_irq_dispatch_handler(struct pt_regs *regs, int irq);
+
+#ifdef CONFIG_PPC_ISERIES
+
+extern unsigned long local_get_flags(void);
+extern unsigned long local_irq_disable(void);
+extern void local_irq_restore(unsigned long);
+
+#define local_irq_enable()	local_irq_restore(1)
+#define local_save_flags(flags)	((flags) = local_get_flags())
+#define local_irq_save(flags)	((flags) = local_irq_disable())
+
+#define irqs_disabled()		(local_get_flags() == 0)
+
+#else
+
+#if defined(CONFIG_BOOKE)
+#define SET_MSR_EE(x)	mtmsr(x)
+#define local_irq_restore(flags)	__asm__ __volatile__("wrtee %0" : : "r" (flags) : "memory")
+#elif defined(__powerpc64__)
+#define SET_MSR_EE(x)	__mtmsrd(x, 1)
+#define local_irq_restore(flags) do { \
+	__asm__ __volatile__("": : :"memory"); \
+	__mtmsrd((flags), 1); \
+} while(0)
+#else
+#define SET_MSR_EE(x)	mtmsr(x)
+#define local_irq_restore(flags)	mtmsr(flags)
+#endif
+
+static inline void local_irq_disable(void)
+{
+#ifdef CONFIG_BOOKE
+	__asm__ __volatile__("wrteei 0": : :"memory");
+#else
+	unsigned long msr;
+	__asm__ __volatile__("": : :"memory");
+	msr = mfmsr();
+	SET_MSR_EE(msr & ~MSR_EE);
+#endif
+}
+
+static inline void local_irq_enable(void)
+{
+#ifdef CONFIG_BOOKE
+	__asm__ __volatile__("wrteei 1": : :"memory");
+#else
+	unsigned long msr;
+	__asm__ __volatile__("": : :"memory");
+	msr = mfmsr();
+	SET_MSR_EE(msr | MSR_EE);
+#endif
+}
+
+static inline void local_irq_save_ptr(unsigned long *flags)
+{
+	unsigned long msr;
+	msr = mfmsr();
+	*flags = msr;
+#ifdef CONFIG_BOOKE
+	__asm__ __volatile__("wrteei 0": : :"memory");
+#else
+	SET_MSR_EE(msr & ~MSR_EE);
+#endif
+	__asm__ __volatile__("": : :"memory");
+}
+
+#define local_save_flags(flags)	((flags) = mfmsr())
+#define local_irq_save(flags)	local_irq_save_ptr(&flags)
+#define irqs_disabled()		((mfmsr() & MSR_EE) == 0)
+
+#endif /* CONFIG_PPC_ISERIES */
+
+#define mask_irq(irq)						\
+	({							\
+	 	irq_desc_t *desc = get_irq_desc(irq);		\
+		if (desc->handler && desc->handler->disable)	\
+			desc->handler->disable(irq);		\
+	})
+#define unmask_irq(irq)						\
+	({							\
+	 	irq_desc_t *desc = get_irq_desc(irq);		\
+		if (desc->handler && desc->handler->enable)	\
+			desc->handler->enable(irq);		\
+	})
+#define ack_irq(irq)						\
+	({							\
+	 	irq_desc_t *desc = get_irq_desc(irq);		\
+		if (desc->handler && desc->handler->ack)	\
+			desc->handler->ack(irq);		\
+	})
+
+/* Should we handle this via lost interrupts and IPIs or should we don't care like
+ * we do now ? --BenH.
+ */
+struct hw_interrupt_type;
+static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
+
+#endif	/* __KERNEL__ */
+#endif	/* _ASM_POWERPC_HW_IRQ_H */
diff --git a/include/asm-ppc/hw_irq.h b/include/asm-ppc/hw_irq.h
deleted file mode 100644
--- a/include/asm-ppc/hw_irq.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Copyright (C) 1999 Cort Dougan <cort@cs.nmt.edu>
- */
-#ifdef __KERNEL__
-#ifndef _PPC_HW_IRQ_H
-#define _PPC_HW_IRQ_H
-
-#include <asm/ptrace.h>
-#include <asm/reg.h>
-#include <asm/irq.h>
-
-extern void timer_interrupt(struct pt_regs *);
-
-#define irqs_disabled()	((mfmsr() & MSR_EE) == 0)
-
-static inline void local_irq_disable(void)
-{
-	unsigned long msr;
-	msr = mfmsr();
-	mtmsr(msr & ~MSR_EE);
-	__asm__ __volatile__("": : :"memory");
-}
-
-static inline void local_irq_enable(void)
-{
-	unsigned long msr;
-	__asm__ __volatile__("": : :"memory");
-	msr = mfmsr();
-	mtmsr(msr | MSR_EE);
-}
-
-static inline void local_irq_save_ptr(unsigned long *flags)
-{
-	unsigned long msr;
-	msr = mfmsr();
-	*flags = msr;
-	mtmsr(msr & ~MSR_EE);
-	__asm__ __volatile__("": : :"memory");
-}
-
-#define local_save_flags(flags)		((flags) = mfmsr())
-#define local_irq_save(flags)		local_irq_save_ptr(&flags)
-#define local_irq_restore(flags)	mtmsr(flags)
-
-extern void do_lost_interrupts(unsigned long);
-
-#define mask_irq(irq) ({if (irq_desc[irq].handler && irq_desc[irq].handler->disable) irq_desc[irq].handler->disable(irq);})
-#define unmask_irq(irq) ({if (irq_desc[irq].handler && irq_desc[irq].handler->enable) irq_desc[irq].handler->enable(irq);})
-#define ack_irq(irq) ({if (irq_desc[irq].handler && irq_desc[irq].handler->ack) irq_desc[irq].handler->ack(irq);})
-
-/* Should we handle this via lost interrupts and IPIs or should we don't care like
- * we do now ? --BenH.
- */
-struct hw_interrupt_type;
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
-
-
-#endif /* _PPC_HW_IRQ_H */
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/irq.h b/include/asm-ppc/irq.h
--- a/include/asm-ppc/irq.h
+++ b/include/asm-ppc/irq.h
@@ -24,6 +24,12 @@
  */
 #define ARCH_HAS_IRQ_PER_CPU
 
+#define get_irq_desc(irq) (&irq_desc[(irq)])
+
+/* Define a way to iterate across irqs. */
+#define for_each_irq(i) \
+	for ((i) = 0; (i) < NR_IRQS; ++(i))
+
 #if defined(CONFIG_40x)
 #include <asm/ibm4xx.h>
 
diff --git a/include/asm-ppc64/hw_irq.h b/include/asm-ppc64/hw_irq.h
deleted file mode 100644
--- a/include/asm-ppc64/hw_irq.h
+++ /dev/null
@@ -1,104 +0,0 @@
-/*
- * Copyright (C) 1999 Cort Dougan <cort@cs.nmt.edu>
- *
- * Use inline IRQs where possible - Anton Blanchard <anton@au.ibm.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#ifdef __KERNEL__
-#ifndef _PPC64_HW_IRQ_H
-#define _PPC64_HW_IRQ_H
-
-#include <linux/config.h>
-#include <linux/errno.h>
-#include <asm/irq.h>
-
-extern void timer_interrupt(struct pt_regs *);
-extern void ppc_irq_dispatch_handler(struct pt_regs *regs, int irq);
-
-#ifdef CONFIG_PPC_ISERIES
-
-extern unsigned long local_get_flags(void);
-extern unsigned long local_irq_disable(void);
-extern void local_irq_restore(unsigned long);
-
-#define local_irq_enable()	local_irq_restore(1)
-#define local_save_flags(flags)	((flags) = local_get_flags())
-#define local_irq_save(flags)	((flags) = local_irq_disable())
-
-#define irqs_disabled()		(local_get_flags() == 0)
-
-#else
-
-#define local_save_flags(flags)	((flags) = mfmsr())
-#define local_irq_restore(flags) do { \
-	__asm__ __volatile__("": : :"memory"); \
-	__mtmsrd((flags), 1); \
-} while(0)
-
-static inline void local_irq_disable(void)
-{
-	unsigned long msr;
-	msr = mfmsr();
-	__mtmsrd(msr & ~MSR_EE, 1);
-	__asm__ __volatile__("": : :"memory");
-}
-
-static inline void local_irq_enable(void)
-{
-	unsigned long msr;
-	__asm__ __volatile__("": : :"memory");
-	msr = mfmsr();
-	__mtmsrd(msr | MSR_EE, 1);
-}
-
-static inline void __do_save_and_cli(unsigned long *flags)
-{
-	unsigned long msr;
-	msr = mfmsr();
-	*flags = msr;
-	__mtmsrd(msr & ~MSR_EE, 1);
-	__asm__ __volatile__("": : :"memory");
-}
-
-#define local_irq_save(flags)          __do_save_and_cli(&flags)
-
-#define irqs_disabled()				\
-({						\
-	unsigned long flags;			\
-	local_save_flags(flags);		\
-	!(flags & MSR_EE);			\
-})
-
-#endif /* CONFIG_PPC_ISERIES */
-
-#define mask_irq(irq)						\
-	({							\
-	 	irq_desc_t *desc = get_irq_desc(irq);		\
-		if (desc->handler && desc->handler->disable)	\
-			desc->handler->disable(irq);		\
-	})
-#define unmask_irq(irq)						\
-	({							\
-	 	irq_desc_t *desc = get_irq_desc(irq);		\
-		if (desc->handler && desc->handler->enable)	\
-			desc->handler->enable(irq);		\
-	})
-#define ack_irq(irq)						\
-	({							\
-	 	irq_desc_t *desc = get_irq_desc(irq);		\
-		if (desc->handler && desc->handler->ack)	\
-			desc->handler->ack(irq);		\
-	})
-
-/* Should we handle this via lost interrupts and IPIs or should we don't care like
- * we do now ? --BenH.
- */
-struct hw_interrupt_type;
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
- 
-#endif /* _PPC64_HW_IRQ_H */
-#endif /* __KERNEL__ */
