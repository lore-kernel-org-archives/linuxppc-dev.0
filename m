Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14819B7D1F
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jun 2010 18:35:54 +1000 (EST)
Date: Thu, 3 Jun 2010 10:24:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: unconditionally enabled irq stacks
Message-ID: <20100603082426.GA6110@lst.de>
Mime-Version: 1.0
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

Irq stacks provide an essential protection from stack overflows through
external interrupts, at the cost of two additionals stacks per CPU.

Enable them unconditionally to simplify the kernel build and prevent
people from accidentally disabling them.

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/Kconfig.debug
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig.debug	2010-05-26 13:38:58.839003980 +0200
+++ linux-2.6/arch/powerpc/Kconfig.debug	2010-06-03 10:20:08.965273921 +0200
@@ -135,13 +135,6 @@ config DEBUGGER
 	depends on KGDB || XMON
 	default y
 
-config IRQSTACKS
-	bool "Use separate kernel stacks when processing interrupts"
-	help
-	  If you say Y here the kernel will use separate kernel stacks
-	  for handling hard and soft interrupts.  This can help avoid
-	  overflowing the process kernel stacks.
-
 config VIRQ_DEBUG
 	bool "Expose hardware/virtual IRQ mapping via debugfs"
 	depends on DEBUG_FS
Index: linux-2.6/arch/powerpc/include/asm/irq.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/irq.h	2010-05-25 19:27:32.731003980 +0200
+++ linux-2.6/arch/powerpc/include/asm/irq.h	2010-06-03 10:20:08.965273921 +0200
@@ -358,7 +358,6 @@ extern void exc_lvl_ctx_init(void);
 #define exc_lvl_ctx_init()
 #endif
 
-#ifdef CONFIG_IRQSTACKS
 /*
  * Per-cpu stacks for handling hard and soft interrupts.
  */
@@ -369,11 +368,6 @@ extern void irq_ctx_init(void);
 extern void call_do_softirq(struct thread_info *tp);
 extern int call_handle_irq(int irq, void *p1,
 			   struct thread_info *tp, void *func);
-#else
-#define irq_ctx_init()
-
-#endif /* CONFIG_IRQSTACKS */
-
 extern void do_IRQ(struct pt_regs *regs);
 
 #endif /* _ASM_IRQ_H */
Index: linux-2.6/arch/powerpc/kernel/irq.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/irq.c	2010-05-26 13:38:58.958005865 +0200
+++ linux-2.6/arch/powerpc/kernel/irq.c	2010-06-03 10:20:08.971003841 +0200
@@ -317,7 +317,6 @@ void fixup_irqs(const struct cpumask *ma
 }
 #endif
 
-#ifdef CONFIG_IRQSTACKS
 static inline void handle_one_irq(unsigned int irq)
 {
 	struct thread_info *curtp, *irqtp;
@@ -358,12 +357,6 @@ static inline void handle_one_irq(unsign
 	if (irqtp->flags)
 		set_bits(irqtp->flags, &curtp->flags);
 }
-#else
-static inline void handle_one_irq(unsigned int irq)
-{
-	generic_handle_irq(irq);
-}
-#endif
 
 static inline void check_stack_overflow(void)
 {
@@ -455,7 +448,6 @@ void exc_lvl_ctx_init(void)
 }
 #endif
 
-#ifdef CONFIG_IRQSTACKS
 struct thread_info *softirq_ctx[NR_CPUS] __read_mostly;
 struct thread_info *hardirq_ctx[NR_CPUS] __read_mostly;
 
@@ -492,10 +484,6 @@ static inline void do_softirq_onstack(vo
 	irqtp->task = NULL;
 }
 
-#else
-#define do_softirq_onstack()	__do_softirq()
-#endif /* CONFIG_IRQSTACKS */
-
 void do_softirq(void)
 {
 	unsigned long flags;
Index: linux-2.6/arch/powerpc/kernel/misc_32.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/misc_32.S	2010-06-02 09:26:40.048004190 +0200
+++ linux-2.6/arch/powerpc/kernel/misc_32.S	2010-06-03 10:20:08.977033804 +0200
@@ -33,7 +33,6 @@
 
 	.text
 
-#ifdef CONFIG_IRQSTACKS
 _GLOBAL(call_do_softirq)
 	mflr	r0
 	stw	r0,4(r1)
@@ -56,7 +55,6 @@ _GLOBAL(call_handle_irq)
 	lwz	r0,4(r1)
 	mtlr	r0
 	blr
-#endif /* CONFIG_IRQSTACKS */
 
 /*
  * This returns the high 64 bits of the product of two 64-bit numbers.
Index: linux-2.6/arch/powerpc/kernel/misc_64.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/misc_64.S	2010-05-26 13:38:58.963008170 +0200
+++ linux-2.6/arch/powerpc/kernel/misc_64.S	2010-06-03 10:20:08.985033594 +0200
@@ -28,7 +28,6 @@
 
 	.text
 
-#ifdef CONFIG_IRQSTACKS
 _GLOBAL(call_do_softirq)
 	mflr	r0
 	std	r0,16(r1)
@@ -52,7 +51,6 @@ _GLOBAL(call_handle_irq)
 	ld	r0,16(r1)
 	mtlr	r0
 	blr
-#endif /* CONFIG_IRQSTACKS */
 
 	.section	".toc","aw"
 PPC64_CACHES:
Index: linux-2.6/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/process.c	2010-05-26 13:38:58.969003561 +0200
+++ linux-2.6/arch/powerpc/kernel/process.c	2010-06-03 10:20:08.992032756 +0200
@@ -1005,7 +1005,6 @@ out:
 	return error;
 }
 
-#ifdef CONFIG_IRQSTACKS
 static inline int valid_irq_stack(unsigned long sp, struct task_struct *p,
 				  unsigned long nbytes)
 {
@@ -1030,10 +1029,6 @@ static inline int valid_irq_stack(unsign
 	return 0;
 }
 
-#else
-#define valid_irq_stack(sp, p, nb)	0
-#endif /* CONFIG_IRQSTACKS */
-
 int validate_sp(unsigned long sp, struct task_struct *p,
 		       unsigned long nbytes)
 {
Index: linux-2.6/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/setup_32.c	2010-05-25 19:27:32.767003492 +0200
+++ linux-2.6/arch/powerpc/kernel/setup_32.c	2010-06-03 10:20:08.998034153 +0200
@@ -241,7 +241,6 @@ int __init ppc_init(void)
 
 arch_initcall(ppc_init);
 
-#ifdef CONFIG_IRQSTACKS
 static void __init irqstack_early_init(void)
 {
 	unsigned int i;
@@ -255,9 +254,6 @@ static void __init irqstack_early_init(v
 			__va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
 	}
 }
-#else
-#define irqstack_early_init()
-#endif
 
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 static void __init exc_lvl_early_init(void)
Index: linux-2.6/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/setup_64.c	2010-05-26 13:38:58.987005796 +0200
+++ linux-2.6/arch/powerpc/kernel/setup_64.c	2010-06-03 10:20:09.003255762 +0200
@@ -432,7 +432,6 @@ static u64 slb0_limit(void)
 	return 1UL << SID_SHIFT;
 }
 
-#ifdef CONFIG_IRQSTACKS
 static void __init irqstack_early_init(void)
 {
 	u64 limit = slb0_limit();
@@ -451,9 +450,6 @@ static void __init irqstack_early_init(v
 					    THREAD_SIZE, limit));
 	}
 }
-#else
-#define irqstack_early_init()
-#endif
 
 #ifdef CONFIG_PPC_BOOK3E
 static void __init exc_lvl_early_init(void)
