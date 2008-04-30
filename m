Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F93ADE053
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 19:01:56 +1000 (EST)
Date: Wed, 30 Apr 2008 03:57:31 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] Move to runtime allocated exception stacks
Message-ID: <Pine.LNX.4.64.0804300355030.27673@blarg.am.freescale.net>
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

For the additonal exception levels (critical, debug, machine check) on
40x/book-e we were using "static" allocations of the stack in the
associated head.S.

Move to a runtime allocation to make the code a bit easier to read as
we mimic how we handle IRQ stacks.  Its also a bit easier to setup the
stack with a "dummy" thread_info in C code.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Josh, can you test this on 40x and 44x.  (make sure gdb single step still
functions).

This is the first in a sequence of patches towards fixing up the exception
level stack functionality.  I'm posting them in pieces to get review and
make it easier to bisect if the patches introduce issues in the future.

- k

 arch/powerpc/kernel/head_40x.S       |   14 ++------------
 arch/powerpc/kernel/head_44x.S       |    9 ---------
 arch/powerpc/kernel/head_booke.h     |   27 ++++++++++-----------------
 arch/powerpc/kernel/head_fsl_booke.S |    9 ---------
 arch/powerpc/kernel/irq.c            |   33 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/setup_32.c       |   24 ++++++++++++++++++++++++
 include/asm-powerpc/irq.h            |   13 +++++++++++++
 7 files changed, 82 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 8552e67..ca75eaf 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -148,8 +148,8 @@ _ENTRY(crit_r11)
 	mfcr	r10;			/* save CR in r10 for now	   */\
 	mfspr	r11,SPRN_SRR3;		/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
-	lis	r11,critical_stack_top@h;				     \
-	ori	r11,r11,critical_stack_top@l;				     \
+	lis	r11,critirq_ctx@ha;					     \
+	lwz	r11,critirq_ctx@l(r11);					     \
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
 	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
@@ -996,16 +996,6 @@ empty_zero_page:
 swapper_pg_dir:
 	.space	PGD_TABLE_SIZE

-
-/* Stack for handling critical exceptions from kernel mode */
-	.section .bss
-        .align 12
-exception_stack_bottom:
-	.space	4096
-critical_stack_top:
-	.globl	exception_stack_top
-exception_stack_top:
-
 /* Room for two PTE pointers, usually the kernel and current user pointers
  * to their respective root page table.
  */
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index b84ec6a..2041248 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -730,15 +730,6 @@ empty_zero_page:
 swapper_pg_dir:
 	.space	PGD_TABLE_SIZE

-/* Reserved 4k for the critical exception stack & 4k for the machine
- * check stack per CPU for kernel mode exceptions */
-	.section .bss
-        .align 12
-exception_stack_bottom:
-	.space	BOOKE_EXCEPTION_STACK_SIZE
-	.globl	exception_stack_top
-exception_stack_top:
-
 /*
  * Room for two PTE pointers, usually the kernel and current user pointers
  * to their respective root page table.
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index aefafc6..d647e05 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -43,9 +43,7 @@
 	SAVE_2GPRS(7, r11)

 /* To handle the additional exception priority levels on 40x and Book-E
- * processors we allocate a 4k stack per additional priority level. The various
- * head_xxx.S files allocate space (exception_stack_top) for each priority's
- * stack times the number of CPUs
+ * processors we allocate a stack per additional priority level.
  *
  * On 40x critical is the only additional level
  * On 44x/e500 we have critical and machine check
@@ -61,36 +59,31 @@
  * going to critical or their own debug level we aren't currently
  * providing configurations that micro-optimize space usage.
  */
-#ifdef CONFIG_44x
-#define NUM_EXCEPTION_LVLS	2
-#else
-#define NUM_EXCEPTION_LVLS	3
-#endif
-#define BOOKE_EXCEPTION_STACK_SIZE	(4096 * NUM_EXCEPTION_LVLS)

 /* CRIT_SPRG only used in critical exception handling */
 #define CRIT_SPRG	SPRN_SPRG2
 /* MCHECK_SPRG only used in machine check exception handling */
 #define MCHECK_SPRG	SPRN_SPRG6W

-#define MCHECK_STACK_TOP	(exception_stack_top - 4096)
-#define CRIT_STACK_TOP		(exception_stack_top)
+#define MCHECK_STACK_TOP	mcheckirq_ctx
+#define CRIT_STACK_TOP		critirq_ctx

 /* only on e200 for now */
-#define DEBUG_STACK_TOP		(exception_stack_top - 8192)
+#define DEBUG_STACK_TOP		dbgirq_ctx
 #define DEBUG_SPRG		SPRN_SPRG6W

 #ifdef CONFIG_SMP
 #define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
 	mfspr	r8,SPRN_PIR;				\
-	mulli	r8,r8,BOOKE_EXCEPTION_STACK_SIZE;	\
-	neg	r8,r8;					\
+	slwi	r8,r8,2;				\
 	addis	r8,r8,level##_STACK_TOP@ha;		\
-	addi	r8,r8,level##_STACK_TOP@l
+	lwz	r8,level##_STACK_TOP@l(r8);		\
+	addi	r8,r8,THREAD_SIZE;
 #else
 #define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
-	lis	r8,level##_STACK_TOP@h;			\
-	ori	r8,r8,level##_STACK_TOP@l
+	lis	r8,level##_STACK_TOP@ha;		\
+	lwz	r8,level##_STACK_TOP@l(r8);		\
+	addi	r8,r8,THREAD_SIZE;
 #endif

 /*
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index e581524..503f860 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1080,15 +1080,6 @@ empty_zero_page:
 swapper_pg_dir:
 	.space	PGD_TABLE_SIZE

-/* Reserved 4k for the critical exception stack & 4k for the machine
- * check stack per CPU for kernel mode exceptions */
-	.section .bss
-	.align 12
-exception_stack_bottom:
-	.space	BOOKE_EXCEPTION_STACK_SIZE * NR_CPUS
-	.globl	exception_stack_top
-exception_stack_top:
-
 /*
  * Room for two PTE pointers, usually the kernel and current user pointers
  * to their respective root page table.
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2f73f70..b519975 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -356,9 +356,42 @@ void __init init_IRQ(void)
 {
 	if (ppc_md.init_IRQ)
 		ppc_md.init_IRQ();
+
+	exc_lvl_ctx_init();
+
 	irq_ctx_init();
 }

+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+struct thread_info   *critirq_ctx[NR_CPUS] __read_mostly;
+struct thread_info    *dbgirq_ctx[NR_CPUS] __read_mostly;
+struct thread_info *mcheckirq_ctx[NR_CPUS] __read_mostly;
+
+void exc_lvl_ctx_init(void)
+{
+	struct thread_info *tp;
+	int i;
+
+	for_each_possible_cpu(i) {
+		memset((void *)critirq_ctx[i], 0, THREAD_SIZE);
+		tp = critirq_ctx[i];
+		tp->cpu = i;
+		tp->preempt_count = 0;
+
+#ifdef CONFIG_BOOKE
+		memset((void *)dbgirq_ctx[i], 0, THREAD_SIZE);
+		tp = dbgirq_ctx[i];
+		tp->cpu = i;
+		tp->preempt_count = 0;
+
+		memset((void *)mcheckirq_ctx[i], 0, THREAD_SIZE);
+		tp = mcheckirq_ctx[i];
+		tp->cpu = i;
+		tp->preempt_count = HARDIRQ_OFFSET;
+#endif
+	}
+}
+#endif

 #ifdef CONFIG_IRQSTACKS
 struct thread_info *softirq_ctx[NR_CPUS] __read_mostly;
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 5112a4a..bef0be3 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -248,6 +248,28 @@ static void __init irqstack_early_init(void)
 #define irqstack_early_init()
 #endif

+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+static void __init exc_lvl_early_init(void)
+{
+	unsigned int i;
+
+	/* interrupt stacks must be in lowmem, we get that for free on ppc32
+	 * as the lmb is limited to lowmem by LMB_REAL_LIMIT */
+	for_each_possible_cpu(i) {
+		critirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
+#ifdef CONFIG_BOOKE
+		dbgirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
+		mcheckirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
+#endif
+	}
+}
+#else
+#define exc_lvl_early_init()
+#endif
+
 /* Warning, IO base is not yet inited */
 void __init setup_arch(char **cmdline_p)
 {
@@ -305,6 +327,8 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;

+	exc_lvl_early_init();
+
 	irqstack_early_init();

 	/* set up the bootmem stuff with available memory */
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index b5c0312..8892066 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -621,6 +621,19 @@ struct pt_regs;

 extern void __do_softirq(void);

+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+/*
+ * Per-cpu stacks for handling critical, debug and machine check
+ * level interrupts.
+ */
+extern struct thread_info *critirq_ctx[NR_CPUS];
+extern struct thread_info *dbgirq_ctx[NR_CPUS];
+extern struct thread_info *mcheckirq_ctx[NR_CPUS];
+extern void exc_lvl_ctx_init(void);
+#else
+#define exc_lvl_ctx_init()
+#endif
+
 #ifdef CONFIG_IRQSTACKS
 /*
  * Per-cpu stacks for handling hard and soft interrupts.
-- 
1.5.4.1
