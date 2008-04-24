Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC348DE312
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 23:19:03 +1000 (EST)
Date: Thu, 24 Apr 2008 08:15:01 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] Add IRQSTACKS support on ppc32
Message-ID: <Pine.LNX.4.64.0804240814280.29846@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Added allocation and initialization of the irq stacks.  We limit the
  stacks to be in lowmem for ppc32.
* Implemented ppc32 versions of call_do_softirq() and call_handle_irq()
  to switch the stack pointers
* Reworked how we do stack overflow detection.  We now keep around the
  limit of the stack in the thread_struct and compare against the limit
  to see if we've overflowed.  We can now use this on ppc64 if desired.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig.debug        |    1 -
 arch/powerpc/kernel/asm-offsets.c |    1 +
 arch/powerpc/kernel/entry_32.S    |    4 ++--
 arch/powerpc/kernel/irq.c         |   10 +++++++++-
 arch/powerpc/kernel/misc_32.S     |   25 +++++++++++++++++++++++++
 arch/powerpc/kernel/process.c     |    2 ++
 arch/powerpc/kernel/setup_32.c    |   21 +++++++++++++++++++++
 include/asm-powerpc/processor.h   |    6 ++++++
 8 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index a86d8d8..2cf72d2 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -118,7 +118,6 @@ config XMON_DISASSEMBLY

 config IRQSTACKS
 	bool "Use separate kernel stacks when processing interrupts"
-	depends on PPC64
 	help
 	  If you say Y here the kernel will use separate kernel stacks
 	  for handling hard and soft interrupts.  This can help avoid
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index adf1d09..0ef4d41 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -64,6 +64,7 @@ int main(void)
 #endif /* CONFIG_PPC64 */

 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
+	DEFINE(KSP_LIMIT, offsetof(struct thread_struct, ksp_limit));
 	DEFINE(PT_REGS, offsetof(struct thread_struct, regs));
 	DEFINE(THREAD_FPEXC_MODE, offsetof(struct thread_struct, fpexc_mode));
 	DEFINE(THREAD_FPR0, offsetof(struct thread_struct, fpr[0]));
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 84c8686..f33c1fe 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -137,8 +137,8 @@ transfer_to_handler:
 2:	/* if from kernel, check interrupted DOZE/NAP mode and
          * check for stack overflow
          */
-	lwz	r9,THREAD_INFO-THREAD(r12)
-	cmplw	r1,r9			/* if r1 <= current->thread_info */
+	lwz	r9,KSP_LIMIT(r12)
+	cmplw	r1,r9			/* if r1 <= ksp_limit */
 	ble-	stack_ovf		/* then the kernel stack overflowed */
 5:
 #ifdef CONFIG_6xx
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 425616f..7378c98 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -307,6 +307,7 @@ void do_IRQ(struct pt_regs *regs)
 		if (curtp != irqtp) {
 			struct irq_desc *desc = irq_desc + irq;
 			void *handler = desc->handle_irq;
+			unsigned long saved_sp_limit = current->thread.ksp_limit;
 			if (handler == NULL)
 				handler = &__do_IRQ;
 			irqtp->task = curtp->task;
@@ -319,7 +320,10 @@ void do_IRQ(struct pt_regs *regs)
 				(irqtp->preempt_count & ~SOFTIRQ_MASK) |
 				(curtp->preempt_count & SOFTIRQ_MASK);

+			current->thread.ksp_limit = (unsigned long)irqtp +
+				_ALIGN_UP(sizeof(struct thread_info), 16);
 			call_handle_irq(irq, desc, irqtp, handler);
+			current->thread.ksp_limit = saved_sp_limit;
 			irqtp->task = NULL;


@@ -352,7 +356,7 @@ void __init init_IRQ(void)
 {
 	if (ppc_md.init_IRQ)
 		ppc_md.init_IRQ();
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_IRQSTACKS
 	irq_ctx_init();
 #endif
 }
@@ -383,11 +387,15 @@ void irq_ctx_init(void)
 static inline void do_softirq_onstack(void)
 {
 	struct thread_info *curtp, *irqtp;
+	unsigned long saved_sp_limit = current->thread.ksp_limit;

 	curtp = current_thread_info();
 	irqtp = softirq_ctx[smp_processor_id()];
 	irqtp->task = curtp->task;
+	current->thread.ksp_limit = (unsigned long)irqtp +
+				    _ALIGN_UP(sizeof(struct thread_info), 16);
 	call_do_softirq(irqtp);
+	current->thread.ksp_limit = saved_sp_limit;
 	irqtp->task = NULL;
 }

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 92ccc6f..89aaaa6 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -32,6 +32,31 @@

 	.text

+#ifdef CONFIG_IRQSTACKS
+_GLOBAL(call_do_softirq)
+	mflr	r0
+	stw	r0,4(r1)
+	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r3)
+	mr	r1,r3
+	bl	__do_softirq
+	lwz	r1,0(r1)
+	lwz	r0,4(r1)
+	mtlr	r0
+	blr
+
+_GLOBAL(call_handle_irq)
+	mflr	r0
+	stw	r0,4(r1)
+	mtctr	r6
+	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r5)
+	mr	r1,r5
+	bctrl
+	lwz	r1,0(r1)
+	lwz	r0,4(r1)
+	mtlr	r0
+	blr
+#endif /* CONFIG_IRQSTACKS */
+
 /*
  * This returns the high 64 bits of the product of two 64-bit numbers.
  */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 6caad17..7de41c3 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -589,6 +589,8 @@ int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
 	kregs = (struct pt_regs *) sp;
 	sp -= STACK_FRAME_OVERHEAD;
 	p->thread.ksp = sp;
+	p->thread.ksp_limit = (unsigned long)task_stack_page(p) +
+				_ALIGN_UP(sizeof(struct thread_info), 16);

 #ifdef CONFIG_PPC64
 	if (cpu_has_feature(CPU_FTR_SLB)) {
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 36f6779..5112a4a 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -16,6 +16,7 @@
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/console.h>
+#include <linux/lmb.h>

 #include <asm/io.h>
 #include <asm/prom.h>
@@ -229,6 +230,24 @@ int __init ppc_init(void)

 arch_initcall(ppc_init);

+#ifdef CONFIG_IRQSTACKS
+static void __init irqstack_early_init(void)
+{
+	unsigned int i;
+
+	/* interrupt stacks must be in lowmem, we get that for free on ppc32
+	 * as the lmb is limited to lowmem by LMB_REAL_LIMIT */
+	for_each_possible_cpu(i) {
+		softirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
+		hardirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
+	}
+}
+#else
+#define irqstack_early_init()
+#endif
+
 /* Warning, IO base is not yet inited */
 void __init setup_arch(char **cmdline_p)
 {
@@ -286,6 +305,8 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;

+	irqstack_early_init();
+
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: bootmem", 0x3eab);
diff --git a/include/asm-powerpc/processor.h b/include/asm-powerpc/processor.h
index fd98ca9..cf83f2d 100644
--- a/include/asm-powerpc/processor.h
+++ b/include/asm-powerpc/processor.h
@@ -138,6 +138,8 @@ typedef struct {

 struct thread_struct {
 	unsigned long	ksp;		/* Kernel stack pointer */
+	unsigned long	ksp_limit;	/* if ksp <= ksp_limit stack overflow */
+
 #ifdef CONFIG_PPC64
 	unsigned long	ksp_vsid;
 #endif
@@ -182,11 +184,14 @@ struct thread_struct {
 #define ARCH_MIN_TASKALIGN 16

 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
+#define INIT_SP_LIMIT \
+	(_ALIGN_UP(sizeof(init_thread_info), 16) + (unsigned long) &init_stack)


 #ifdef CONFIG_PPC32
 #define INIT_THREAD { \
 	.ksp = INIT_SP, \
+	.ksp_limit = INIT_SP_LIMIT, \
 	.fs = KERNEL_DS, \
 	.pgdir = swapper_pg_dir, \
 	.fpexc_mode = MSR_FE0 | MSR_FE1, \
@@ -194,6 +199,7 @@ struct thread_struct {
 #else
 #define INIT_THREAD  { \
 	.ksp = INIT_SP, \
+	.ksp_limit = INIT_SP_LIMIT, \
 	.regs = (struct pt_regs *)INIT_SP - 1, /* XXX bogus, I think */ \
 	.fs = KERNEL_DS, \
 	.fpr = {0}, \
-- 
1.5.4.1
