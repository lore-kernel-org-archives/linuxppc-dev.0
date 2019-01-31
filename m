Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C9C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:25:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C673E218AF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="l0Q6NOHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C673E218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qxG10BdBzDqby
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:25:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="l0Q6NOHt"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qwtk63KkzDqYK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 21:09:02 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qwtf4SvTz9tyxC;
 Thu, 31 Jan 2019 11:08:58 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=l0Q6NOHt; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id iSJUMae8a0Q5; Thu, 31 Jan 2019 11:08:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qwtf3N0Bz9tyx9;
 Thu, 31 Jan 2019 11:08:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548929338; bh=BrxqWtGRBEjxeTZuUHsbaJh4fnQw37xAfVlX4KyNBjY=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=l0Q6NOHtngj19Mp9BzBP7ViUgusKBxx15x4eesQWEtlB0HvCBJYoenzsAu8Xqo2PN
 dIKFRtxaNW0dWq1+eNfiqHEbKhSIx7dzz86/zuyJ0+R56RgX3omYF/Ky9ZxtSZG4c3
 XbMZDkIKHuImBaInPVIOwmNzofK30s5vYJ9MzkJ0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 947F98B814;
 Thu, 31 Jan 2019 11:08:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id pihg5yTIqQzO; Thu, 31 Jan 2019 11:08:59 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 326AA8B78D;
 Thu, 31 Jan 2019 11:08:59 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id BCF5672E14; Thu, 31 Jan 2019 10:08:58 +0000 (UTC)
Message-Id: <f0e5379d321d1b203243992998f25cfe3eeca73f.1548852243.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548852242.git.christophe.leroy@c-s.fr>
References: <cover.1548852242.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v15 08/13] powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 31 Jan 2019 10:08:58 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch activates CONFIG_THREAD_INFO_IN_TASK which
moves the thread_info into task_struct.

Moving thread_info into task_struct has the following advantages:
- It protects thread_info from corruption in the case of stack
overflows.
- Its address is harder to determine if stack addresses are
leaked, making a number of attacks more difficult.

This has the following consequences:
- thread_info is now located at the beginning of task_struct.
- The 'cpu' field is now in task_struct, and only exists when
CONFIG_SMP is active.
- thread_info doesn't have anymore the 'task' field.

This patch:
- Removes all recopy of thread_info struct when the stack changes.
- Changes the CURRENT_THREAD_INFO() macro to point to current.
- Selects CONFIG_THREAD_INFO_IN_TASK.
- Modifies raw_smp_processor_id() to get ->cpu from current without
including linux/sched.h to avoid circular inclusion and without
including asm/asm-offsets.h to avoid symbol names duplication
between ASM constants and C constants.
- Modifies klp_init_thread_info() to take a task_struct pointer
argument.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/Makefile                  |  7 +++
 arch/powerpc/include/asm/irq.h         |  4 --
 arch/powerpc/include/asm/livepatch.h   |  6 +--
 arch/powerpc/include/asm/ptrace.h      |  2 +-
 arch/powerpc/include/asm/smp.h         | 17 +++++++-
 arch/powerpc/include/asm/thread_info.h | 17 +-------
 arch/powerpc/kernel/asm-offsets.c      |  7 ++-
 arch/powerpc/kernel/entry_32.S         |  9 ++--
 arch/powerpc/kernel/exceptions-64e.S   | 11 -----
 arch/powerpc/kernel/head_32.S          |  6 +--
 arch/powerpc/kernel/head_44x.S         |  4 +-
 arch/powerpc/kernel/head_64.S          |  1 +
 arch/powerpc/kernel/head_booke.h       |  8 +---
 arch/powerpc/kernel/head_fsl_booke.S   |  7 ++-
 arch/powerpc/kernel/irq.c              | 79 +---------------------------------
 arch/powerpc/kernel/kgdb.c             | 28 ------------
 arch/powerpc/kernel/machine_kexec_64.c |  6 +--
 arch/powerpc/kernel/process.c          |  2 +-
 arch/powerpc/kernel/setup-common.c     |  2 +-
 arch/powerpc/kernel/setup_64.c         | 21 ---------
 arch/powerpc/kernel/smp.c              |  2 +-
 arch/powerpc/net/bpf_jit32.h           |  5 +--
 23 files changed, 57 insertions(+), 195 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36eb531..0a26e0075ce5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -241,6 +241,7 @@ config PPC
 	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
+	select THREAD_INFO_IN_TASK
 	select VIRT_TO_BUS			if !PPC64
 	#
 	# Please keep this list sorted alphabetically.
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ac033341ed55..53ffe935f3b0 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -427,6 +427,13 @@ else
 endif
 endif
 
+ifdef CONFIG_SMP
+prepare: task_cpu_prepare
+
+task_cpu_prepare: prepare0
+	$(eval KBUILD_CFLAGS += -D_TASK_CPU=$(shell awk '{if ($$2 == "TI_CPU") print $$3;}' include/generated/asm-offsets.h))
+endif
+
 # Check toolchain versions:
 # - gcc-4.6 is the minimum kernel-wide version so nothing required.
 checkbin:
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 2efbae8d93be..28a7ace0a1b9 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -51,9 +51,6 @@ struct pt_regs;
 extern struct thread_info *critirq_ctx[NR_CPUS];
 extern struct thread_info *dbgirq_ctx[NR_CPUS];
 extern struct thread_info *mcheckirq_ctx[NR_CPUS];
-extern void exc_lvl_ctx_init(void);
-#else
-#define exc_lvl_ctx_init()
 #endif
 
 /*
@@ -62,7 +59,6 @@ extern void exc_lvl_ctx_init(void);
 extern struct thread_info *hardirq_ctx[NR_CPUS];
 extern struct thread_info *softirq_ctx[NR_CPUS];
 
-extern void irq_ctx_init(void);
 void call_do_softirq(void *sp);
 void call_do_irq(struct pt_regs *regs, void *sp);
 extern void do_IRQ(struct pt_regs *regs);
diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index 47a03b9b528b..7cb514865a28 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -43,13 +43,13 @@ static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
 	return ftrace_location_range(faddr, faddr + 16);
 }
 
-static inline void klp_init_thread_info(struct thread_info *ti)
+static inline void klp_init_thread_info(struct task_struct *p)
 {
 	/* + 1 to account for STACK_END_MAGIC */
-	ti->livepatch_sp = (unsigned long *)(ti + 1) + 1;
+	task_thread_info(p)->livepatch_sp = end_of_stack(p) + 1;
 }
 #else
-static void klp_init_thread_info(struct thread_info *ti) { }
+static inline void klp_init_thread_info(struct task_struct *p) { }
 #endif /* CONFIG_LIVEPATCH */
 
 #endif /* _ASM_POWERPC_LIVEPATCH_H */
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 0b8a735b6d85..64271e562fed 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -157,7 +157,7 @@ extern int ptrace_put_reg(struct task_struct *task, int regno,
 			  unsigned long data);
 
 #define current_pt_regs() \
-	((struct pt_regs *)((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
+	((struct pt_regs *)((unsigned long)task_stack_page(current) + THREAD_SIZE) - 1)
 /*
  * We use the least-significant bit of the trap field to indicate
  * whether we have saved the full set of registers, or only a
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 41695745032c..0de717e16dd6 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -83,7 +83,22 @@ int is_cpu_dead(unsigned int cpu);
 /* 32-bit */
 extern int smp_hw_index[];
 
-#define raw_smp_processor_id()	(current_thread_info()->cpu)
+/*
+ * This is particularly ugly: it appears we can't actually get the definition
+ * of task_struct here, but we need access to the CPU this task is running on.
+ * Instead of using task_struct we're using _TASK_CPU which is extracted from
+ * asm-offsets.h by kbuild to get the current processor ID.
+ *
+ * This also needs to be safeguarded when building asm-offsets.s because at
+ * that time _TASK_CPU is not defined yet. It could have been guarded by
+ * _TASK_CPU itself, but we want the build to fail if _TASK_CPU is missing
+ * when building something else than asm-offsets.s
+ */
+#ifdef GENERATING_ASM_OFFSETS
+#define raw_smp_processor_id()		(0)
+#else
+#define raw_smp_processor_id()		(*(unsigned int *)((void *)current + _TASK_CPU))
+#endif
 #define hard_smp_processor_id() 	(smp_hw_index[smp_processor_id()])
 
 static inline int get_hard_smp_processor_id(int cpu)
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 544cac0474cb..d91523c2c7d8 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -18,9 +18,9 @@
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
 #ifdef CONFIG_PPC64
-#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(clrrdi dest, sp, THREAD_SHIFT)
+#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(ld dest, PACACURRENT(r13))
 #else
-#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(rlwinm dest, sp, 0, 0, 31-THREAD_SHIFT)
+#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(mr dest, r2)
 #endif
 
 #ifndef __ASSEMBLY__
@@ -34,8 +34,6 @@
  * low level task data.
  */
 struct thread_info {
-	struct task_struct *task;		/* main task structure */
-	int		cpu;			/* cpu we're on */
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
 	unsigned long	local_flags;		/* private flags for thread */
@@ -58,8 +56,6 @@ struct thread_info {
  */
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.task =		&tsk,			\
-	.cpu =		0,			\
 	.preempt_count = INIT_PREEMPT_COUNT,	\
 	.flags =	0,			\
 }
@@ -67,15 +63,6 @@ struct thread_info {
 #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
 
 /* how to get the thread information struct from C */
-static inline struct thread_info *current_thread_info(void)
-{
-	unsigned long val;
-
-	asm (CURRENT_THREAD_INFO(%0,1) : "=r" (val));
-
-	return (struct thread_info *)val;
-}
-
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b2b52e002a76..1fb52206c106 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -13,6 +13,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#define GENERATING_ASM_OFFSETS	/* asm/smp.h */
+
 #include <linux/compat.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -94,6 +96,9 @@ int main(void)
 	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
 #endif /* CONFIG_PPC64 */
 	OFFSET(TASK_STACK, task_struct, stack);
+#ifdef CONFIG_SMP
+	OFFSET(TI_CPU, task_struct, cpu);
+#endif
 
 #ifdef CONFIG_LIVEPATCH
 	OFFSET(TI_livepatch_sp, thread_info, livepatch_sp);
@@ -161,8 +166,6 @@ int main(void)
 	OFFSET(TI_FLAGS, thread_info, flags);
 	OFFSET(TI_LOCAL_FLAGS, thread_info, local_flags);
 	OFFSET(TI_PREEMPT, thread_info, preempt_count);
-	OFFSET(TI_TASK, thread_info, task);
-	OFFSET(TI_CPU, thread_info, cpu);
 
 #ifdef CONFIG_PPC64
 	OFFSET(DCACHEL1BLOCKSIZE, ppc64_caches, l1d.block_size);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index f1646d845404..3255c0840beb 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1168,10 +1168,6 @@ ret_from_debug_exc:
 	mfspr	r9,SPRN_SPRG_THREAD
 	lwz	r10,SAVED_KSP_LIMIT(r1)
 	stw	r10,KSP_LIMIT(r9)
-	lwz	r9,TASK_STACK-THREAD(r9)
-	CURRENT_THREAD_INFO(r10, r1)
-	lwz	r10,TI_PREEMPT(r10)
-	stw	r10,TI_PREEMPT(r9)
 	RESTORE_xSRR(SRR0,SRR1);
 	RESTORE_xSRR(CSRR0,CSRR1);
 	RESTORE_MMU_REGS;
@@ -1294,10 +1290,13 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_601)
 	lwz	r3,_TRAP(r1)
 	andi.	r0,r3,1
-	beq	4f
+	beq	5f
 	SAVE_NVGPRS(r1)
 	rlwinm	r3,r3,0,0,30
 	stw	r3,_TRAP(r1)
+5:	mfspr	r2,SPRN_SPRG_THREAD
+	addi	r2,r2,-THREAD
+	tovirt(r2,r2)			/* set back r2 to current */
 4:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	unrecoverable_exception
 	/* shouldn't return */
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index afb638778f44..20f14996281d 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -77,17 +77,6 @@ special_reg_save:
 	andi.	r3,r3,MSR_PR
 	bnelr
 
-	/* Copy info into temporary exception thread info */
-	ld	r11,PACAKSAVE(r13)
-	CURRENT_THREAD_INFO(r11, r11)
-	CURRENT_THREAD_INFO(r12, r1)
-	ld	r10,TI_FLAGS(r11)
-	std	r10,TI_FLAGS(r12)
-	ld	r10,TI_PREEMPT(r11)
-	std	r10,TI_PREEMPT(r12)
-	ld	r10,TI_TASK(r11)
-	std	r10,TI_TASK(r12)
-
 	/*
 	 * Advance to the next TLB exception frame for handler
 	 * types that don't do it automatically.
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 8282d25948ae..309a45779ad5 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -848,9 +848,9 @@ __secondary_start:
 	/* get current's stack and current */
 	lis	r1,secondary_ti@ha
 	tophys(r1,r1)
-	lwz	r1,secondary_ti@l(r1)
-	tophys(r2,r1)
-	lwz	r2,TI_TASK(r2)
+	lwz	r2,secondary_ti@l(r1)
+	tophys(r1,r2)
+	lwz	r1,TASK_STACK(r1)
 
 	/* stack */
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 4e8c8bf50413..f94a93b6c2f2 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -1021,8 +1021,8 @@ _GLOBAL(start_secondary_47x)
 
 	/* Get current's stack and current */
 	lis	r1,secondary_ti@ha
-	lwz	r1,secondary_ti@l(r1)
-	lwz	r2,TI_TASK(r1)
+	lwz	r2,secondary_ti@l(r1)
+	lwz	r1,TASK_STACK(r2)
 
 	/* Current stack pointer */
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4898e9491a1c..c6a9bf7b34bf 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -805,6 +805,7 @@ __secondary_start:
 	LOAD_REG_ADDR(r3, current_set)
 	sldi	r28,r24,3		/* get current_set[cpu#]	 */
 	ldx	r14,r3,r28
+	ld	r14,TASK_STACK(r14)
 	addi	r14,r14,THREAD_SIZE-STACK_FRAME_OVERHEAD
 	std	r14,PACAKSAVE(r13)
 
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 69e80e6d0d16..1b22a8dea399 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -155,13 +155,7 @@ END_BTB_FLUSH_SECTION
 	stw	r10,GPR11(r11);						     \
 	b	2f;							     \
 	/* COMING FROM PRIV MODE */					     \
-1:	lwz	r9,TI_FLAGS-EXC_LVL_FRAME_OVERHEAD(r11);		     \
-	lwz	r10,TI_PREEMPT-EXC_LVL_FRAME_OVERHEAD(r11);		     \
-	stw	r9,TI_FLAGS-EXC_LVL_FRAME_OVERHEAD(r8);			     \
-	stw	r10,TI_PREEMPT-EXC_LVL_FRAME_OVERHEAD(r8);		     \
-	lwz	r9,TI_TASK-EXC_LVL_FRAME_OVERHEAD(r11);			     \
-	stw	r9,TI_TASK-EXC_LVL_FRAME_OVERHEAD(r8);			     \
-	mr	r11,r8;							     \
+1:	mr	r11, r8;							     \
 2:	mfspr	r8,SPRN_SPRG_RSCRATCH_##exc_level;			     \
 	stw	r12,GPR12(r11);		/* save various registers	   */\
 	mflr	r10;							     \
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 6301bb24889a..11f38adbe020 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -719,8 +719,7 @@ finish_tlb_load:
 
 	/* Get the next_tlbcam_idx percpu var */
 #ifdef CONFIG_SMP
-	lwz	r12, TASK_STACK-THREAD(r12)
-	lwz	r15, TI_CPU(r12)
+	lwz	r15, TI_CPU-THREAD(r12)
 	lis     r14, __per_cpu_offset@h
 	ori     r14, r14, __per_cpu_offset@l
 	rlwinm  r15, r15, 2, 0, 29
@@ -1093,8 +1092,8 @@ __secondary_start:
 
 	/* get current's stack and current */
 	lis	r1,secondary_ti@ha
-	lwz	r1,secondary_ti@l(r1)
-	lwz	r2,TI_TASK(r1)
+	lwz	r2,secondary_ti@l(r1)
+	lwz	r1,TASK_STACK(r2)
 
 	/* stack */
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 531e9ef153c0..85c48911938a 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -673,24 +673,9 @@ void do_IRQ(struct pt_regs *regs)
 		set_irq_regs(old_regs);
 		return;
 	}
-
-	/* Prepare the thread_info in the irq stack */
-	irqtp->task = curtp->task;
-	irqtp->flags = 0;
-
-	/* Copy the preempt_count so that the [soft]irq checks work. */
-	irqtp->preempt_count = curtp->preempt_count;
-
 	/* Switch stack and call */
 	call_do_irq(regs, irqtp);
 
-	/* Restore stack limit */
-	irqtp->task = NULL;
-
-	/* Copy back updates to the thread_info */
-	if (irqtp->flags)
-		set_bits(irqtp->flags, &curtp->flags);
-
 	set_irq_regs(old_regs);
 }
 
@@ -698,85 +683,23 @@ void __init init_IRQ(void)
 {
 	if (ppc_md.init_IRQ)
 		ppc_md.init_IRQ();
-
-	exc_lvl_ctx_init();
-
-	irq_ctx_init();
 }
 
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 struct thread_info   *critirq_ctx[NR_CPUS] __read_mostly;
 struct thread_info    *dbgirq_ctx[NR_CPUS] __read_mostly;
 struct thread_info *mcheckirq_ctx[NR_CPUS] __read_mostly;
-
-void exc_lvl_ctx_init(void)
-{
-	struct thread_info *tp;
-	int i, cpu_nr;
-
-	for_each_possible_cpu(i) {
-#ifdef CONFIG_PPC64
-		cpu_nr = i;
-#else
-#ifdef CONFIG_SMP
-		cpu_nr = get_hard_smp_processor_id(i);
-#else
-		cpu_nr = 0;
-#endif
-#endif
-
-		tp = critirq_ctx[cpu_nr];
-		tp->cpu = cpu_nr;
-		tp->preempt_count = 0;
-
-#ifdef CONFIG_BOOKE
-		tp = dbgirq_ctx[cpu_nr];
-		tp->cpu = cpu_nr;
-		tp->preempt_count = 0;
-
-		tp = mcheckirq_ctx[cpu_nr];
-		tp->cpu = cpu_nr;
-		tp->preempt_count = HARDIRQ_OFFSET;
-#endif
-	}
-}
 #endif
 
 struct thread_info *softirq_ctx[NR_CPUS] __read_mostly;
 struct thread_info *hardirq_ctx[NR_CPUS] __read_mostly;
 
-void irq_ctx_init(void)
-{
-	struct thread_info *tp;
-	int i;
-
-	for_each_possible_cpu(i) {
-		tp = softirq_ctx[i];
-		tp->cpu = i;
-		klp_init_thread_info(tp);
-
-		tp = hardirq_ctx[i];
-		tp->cpu = i;
-		klp_init_thread_info(tp);
-	}
-}
-
 void do_softirq_own_stack(void)
 {
-	struct thread_info *curtp, *irqtp;
+	struct thread_info *irqtp;
 
-	curtp = current_thread_info();
 	irqtp = softirq_ctx[smp_processor_id()];
-	irqtp->task = curtp->task;
-	irqtp->flags = 0;
 	call_do_softirq(irqtp);
-	irqtp->task = NULL;
-
-	/* Set any flag that may have been set on the
-	 * alternate stack
-	 */
-	if (irqtp->flags)
-		set_bits(irqtp->flags, &curtp->flags);
 }
 
 irq_hw_number_t virq_to_hw(unsigned int virq)
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index e1865565f0ae..7dd55eb1259d 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -151,41 +151,13 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
 	return 1;
 }
 
-static DEFINE_PER_CPU(struct thread_info, kgdb_thread_info);
 static int kgdb_singlestep(struct pt_regs *regs)
 {
-	struct thread_info *thread_info, *exception_thread_info;
-	struct thread_info *backup_current_thread_info =
-		this_cpu_ptr(&kgdb_thread_info);
-
 	if (user_mode(regs))
 		return 0;
 
-	/*
-	 * On Book E and perhaps other processors, singlestep is handled on
-	 * the critical exception stack.  This causes current_thread_info()
-	 * to fail, since it it locates the thread_info by masking off
-	 * the low bits of the current stack pointer.  We work around
-	 * this issue by copying the thread_info from the kernel stack
-	 * before calling kgdb_handle_exception, and copying it back
-	 * afterwards.  On most processors the copy is avoided since
-	 * exception_thread_info == thread_info.
-	 */
-	thread_info = (struct thread_info *)(regs->gpr[1] & ~(THREAD_SIZE-1));
-	exception_thread_info = current_thread_info();
-
-	if (thread_info != exception_thread_info) {
-		/* Save the original current_thread_info. */
-		memcpy(backup_current_thread_info, exception_thread_info, sizeof *thread_info);
-		memcpy(exception_thread_info, thread_info, sizeof *thread_info);
-	}
-
 	kgdb_handle_exception(0, SIGTRAP, 0, regs);
 
-	if (thread_info != exception_thread_info)
-		/* Restore current_thread_info lastly. */
-		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
-
 	return 1;
 }
 
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index a0f6f45005bd..75692c327ba0 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -317,10 +317,8 @@ void default_machine_kexec(struct kimage *image)
 	 * We setup preempt_count to avoid using VMX in memcpy.
 	 * XXX: the task struct will likely be invalid once we do the copy!
 	 */
-	kexec_stack.thread_info.task = current_thread_info()->task;
-	kexec_stack.thread_info.flags = 0;
-	kexec_stack.thread_info.preempt_count = HARDIRQ_OFFSET;
-	kexec_stack.thread_info.cpu = current_thread_info()->cpu;
+	current_thread_info()->flags = 0;
+	current_thread_info()->preempt_count = HARDIRQ_OFFSET;
 
 	/* We need a static PACA, too; copy this CPU's PACA over and switch to
 	 * it. Also poison per_cpu_offset and NULL lppaca to catch anyone using
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 21c1e11a06de..d3c8af4c3a61 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1634,7 +1634,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 	struct thread_info *ti = task_thread_info(p);
 
-	klp_init_thread_info(ti);
+	klp_init_thread_info(p);
 
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index ca00fbb97cf8..3d0dab1647fe 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -938,7 +938,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Reserve large chunks of memory for use by CMA for KVM. */
 	kvm_cma_reserve();
 
-	klp_init_thread_info(&init_thread_info);
+	klp_init_thread_info(&init_task);
 
 	init_mm.start_code = (unsigned long)_stext;
 	init_mm.end_code = (unsigned long) _etext;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 080dd515d587..0912948a8ea6 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -690,24 +690,6 @@ void __init exc_lvl_early_init(void)
 #endif
 
 /*
- * Emergency stacks are used for a range of things, from asynchronous
- * NMIs (system reset, machine check) to synchronous, process context.
- * We set preempt_count to zero, even though that isn't necessarily correct. To
- * get the right value we'd need to copy it from the previous thread_info, but
- * doing that might fault causing more problems.
- * TODO: what to do with accounting?
- */
-static void emerg_stack_init_thread_info(struct thread_info *ti, int cpu)
-{
-	ti->task = NULL;
-	ti->cpu = cpu;
-	ti->preempt_count = 0;
-	ti->local_flags = 0;
-	ti->flags = 0;
-	klp_init_thread_info(ti);
-}
-
-/*
  * Stack space used when we detect a bad kernel stack pointer, and
  * early in SMP boots before relocation is enabled. Exclusive emergency
  * stack for machine checks.
@@ -737,18 +719,15 @@ void __init emergency_stack_init(void)
 		struct thread_info *ti;
 
 		ti = alloc_stack(limit, i);
-		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->emergency_sp = (void *)ti + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for NMI exception handling. */
 		ti = alloc_stack(limit, i);
-		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->nmi_emergency_sp = (void *)ti + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
 		ti = alloc_stack(limit, i);
-		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->mc_emergency_sp = (void *)ti + THREAD_SIZE;
 #endif
 	}
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 1d3e7cb6704d..aa4517686f90 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1021,7 +1021,7 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 	paca_ptrs[cpu]->kstack = (unsigned long)task_stack_page(idle) +
 				 THREAD_SIZE - STACK_FRAME_OVERHEAD;
 #endif
-	ti->cpu = cpu;
+	idle->cpu = cpu;
 	secondary_ti = current_set[cpu] = ti;
 }
 
diff --git a/arch/powerpc/net/bpf_jit32.h b/arch/powerpc/net/bpf_jit32.h
index 6f4daacad296..dc50a8d4b3b9 100644
--- a/arch/powerpc/net/bpf_jit32.h
+++ b/arch/powerpc/net/bpf_jit32.h
@@ -106,9 +106,8 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 	} while (0)
 #else
 #define PPC_BPF_LOAD_CPU(r)     \
-	do { BUILD_BUG_ON(FIELD_SIZEOF(struct thread_info, cpu) != 4);		\
-		PPC_LHZ_OFFS(r, (1 & ~(THREAD_SIZE - 1)),			\
-				offsetof(struct thread_info, cpu));		\
+	do { BUILD_BUG_ON(FIELD_SIZEOF(struct task_struct, cpu) != 4);		\
+		PPC_LHZ_OFFS(r, 2, offsetof(struct task_struct, cpu));		\
 	} while(0)
 #endif
 #else
-- 
2.13.3

