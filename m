Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DFAD3B6EE8
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 21:08:46 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] booke/kprobe: make program exception to use one dedicated
	exception stack
Date: Fri, 8 Jul 2011 18:05:23 +0800
Message-ID: <1310119524-19672-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When kprobe these operations such as store-and-update-word for SP(r1),

stwu r1, -A(r1)

The program exception is triggered, and PPC always allocate an exception frame
as shown as the follows:

old r1 ----------
         ...
         nip
         gpr[2] ~ gpr[31]
         gpr[1] <--------- old r1 is stored.
         gpr[0]
       -------- <--------- pr_regs @offset 16 bytes
       padding
       STACK_FRAME_REGS_MARKER
       LR
       back chain
new r1 ----------
Then emulate_step() will emulate this instruction, 'stwu'. Actually its
equivalent to:
1> Update pr_regs->gpr[1] = mem[old r1 + (-A)]
2> stw [old r1], mem[old r1 + (-A)]

Please notice the stack based on new r1 may be covered with mem[old r1
+(-A)] when addr[old r1 + (-A)] < addr[old r1 + sizeof(an exception frame0].
So the above 2# operation will overwirte something to break this exception
frame then unexpected kernel problem will be issued.

So looks we have to implement independed interrupt stack for PPC program
exception when CONFIG_BOOKE is enabled. Here we can use
EXC_LEVEL_EXCEPTION_PROLOG to replace original NORMAL_EXCEPTION_PROLOG
for program exception if CONFIG_BOOKE. Then its always safe for kprobe
with independed exc stack from one pre-allocated and dedicated thread_info.
Actually this is just waht we did for critical/machine check exceptions
on PPC.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/include/asm/irq.h   |    3 +++
 arch/powerpc/include/asm/reg.h   |    4 ++++
 arch/powerpc/kernel/head_booke.h |   12 +++++++++++-
 arch/powerpc/kernel/irq.c        |   11 +++++++++++
 arch/powerpc/kernel/setup_32.c   |    4 ++++
 5 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 1bff591..6d12169 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -313,6 +313,9 @@ struct pt_regs;
 extern struct thread_info *critirq_ctx[NR_CPUS];
 extern struct thread_info *dbgirq_ctx[NR_CPUS];
 extern struct thread_info *mcheckirq_ctx[NR_CPUS];
+#if defined(CONFIG_KPROBES) && defined(CONFIG_BOOKE)
+extern struct thread_info *pgirq_ctx[NR_CPUS];
+#endif
 extern void exc_lvl_ctx_init(void);
 #else
 #define exc_lvl_ctx_init()
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c5cae0d..34d6178 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -885,6 +885,10 @@
 #endif
 #define SPRN_SPRG_RVCPU		SPRN_SPRG1
 #define SPRN_SPRG_WVCPU		SPRN_SPRG1
+#ifdef	CONFIG_KPROBES
+#define	SPRN_SPRG_RSCRATCH_PG	SPRN_SPRG0
+#define	SPRN_SPRG_WSCRATCH_PG	SPRN_SPRG0
+#endif
 #endif
 
 #ifdef CONFIG_8xx
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index a0bf158..cf6cb1e 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -79,6 +79,10 @@
 /* only on e500mc/e200 */
 #define DBG_STACK_BASE		dbgirq_ctx
 
+#if defined(CONFIG_KPROBES)
+#define PG_STACK_BASE		pgirq_ctx
+#endif
+
 #define EXC_LVL_FRAME_OVERHEAD	(THREAD_SIZE - INT_FRAME_SIZE - EXC_LVL_SIZE)
 
 #ifdef CONFIG_SMP
@@ -158,6 +162,12 @@
 		EXC_LEVEL_EXCEPTION_PROLOG(DBG, SPRN_DSRR0, SPRN_DSRR1)
 #define MCHECK_EXCEPTION_PROLOG \
 		EXC_LEVEL_EXCEPTION_PROLOG(MC, SPRN_MCSRR0, SPRN_MCSRR1)
+#if defined(CONFIG_KPROBES)
+#define	PROGRAM_EXCEPTION_PROLOG \
+		EXC_LEVEL_EXCEPTION_PROLOG(PG, SPRN_SRR0, SPRN_SRR1)
+#else
+#define	PROGRAM_EXCEPTION_PROLOG	NORMAL_EXCEPTION_PROLOG
+#endif
 
 /*
  * Exception vectors.
@@ -370,7 +380,7 @@ label:
 
 #define PROGRAM_EXCEPTION						      \
 	START_EXCEPTION(Program)					      \
-	NORMAL_EXCEPTION_PROLOG;					      \
+	PROGRAM_EXCEPTION_PROLOG;					      \
 	mfspr	r4,SPRN_ESR;		/* Grab the ESR and save it */	      \
 	stw	r4,_ESR(r11);						      \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5b428e3..ff5b8dd 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -397,6 +397,10 @@ struct thread_info   *critirq_ctx[NR_CPUS] __read_mostly;
 struct thread_info    *dbgirq_ctx[NR_CPUS] __read_mostly;
 struct thread_info *mcheckirq_ctx[NR_CPUS] __read_mostly;
 
+#if defined(CONFIG_KPROBES) && defined(CONFIG_BOOKE)
+struct thread_info    *pgirq_ctx[NR_CPUS] __read_mostly;
+#endif
+
 void exc_lvl_ctx_init(void)
 {
 	struct thread_info *tp;
@@ -423,6 +427,13 @@ void exc_lvl_ctx_init(void)
 		tp = mcheckirq_ctx[cpu_nr];
 		tp->cpu = cpu_nr;
 		tp->preempt_count = HARDIRQ_OFFSET;
+
+#if defined(CONFIG_KPROBES)
+		memset((void *)pgirq_ctx[i], 0, THREAD_SIZE);
+		tp = pgirq_ctx[i];
+		tp->cpu = i;
+		tp->preempt_count = 0;
+#endif
 #endif
 	}
 }
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 620d792..f0c62ae 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -272,6 +272,10 @@ static void __init exc_lvl_early_init(void)
 			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
 		mcheckirq_ctx[hw_cpu] = (struct thread_info *)
 			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+#ifdef CONFIG_KPROBES
+		pgirq_ctx[i] = (struct thread_info *)
+			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+#endif
 #endif
 	}
 }
-- 
1.5.6
