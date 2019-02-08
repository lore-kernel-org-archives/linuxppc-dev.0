Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20326C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:04:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608FC20844
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nC1RJUx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608FC20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wwP41P0VzDqX8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 00:04:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="nC1RJUx7"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ww7X0bwVzDqWt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 23:52:23 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43ww7Q0S3hz9v0dK;
 Fri,  8 Feb 2019 13:52:18 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=nC1RJUx7; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 4zzGE7dgxmkg; Fri,  8 Feb 2019 13:52:17 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43ww7P5x2Hz9v0dJ;
 Fri,  8 Feb 2019 13:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549630337; bh=iwc7pYBBiAokOzlBWkH1/pZqu45LYd/oYTGMkWGNI8Y=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=nC1RJUx76gO9rPxnLSUFoN7rTgOxgiK54SdEJH4kGNQROt6XUnAhlnwXMYSY60SSB
 p7+EqTgFbDpMMHV+ZFtPvdny1Dx892nrs9XKRLQGAtMI3Uoe9Z/vaXTTE0CA0dI2Ds
 npZUDY7QVaNqUMLw0tlBOAxtveb9ZvOR54oIxjV8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 293BE8B8D7;
 Fri,  8 Feb 2019 13:52:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 72b4rul_VrhD; Fri,  8 Feb 2019 13:52:19 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0049B8B756;
 Fri,  8 Feb 2019 13:52:18 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id E8D33653E8; Fri,  8 Feb 2019 12:52:18 +0000 (UTC)
Message-Id: <4d0205ad4809a31a49a6586cc35a04ca4f2da4ab.1549630193.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1549630193.git.christophe.leroy@c-s.fr>
References: <cover.1549630193.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 01/16] powerpc: CONFIG_THREAD_INFO_IN_TASK series
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri,  8 Feb 2019 12:52:18 +0000 (UTC)
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

This patch is a squashed version of the
CONFIG_THREAD_INFO_IN_TASK series to make building robots
happy until that serie appears in powerpc/next.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                           |   1 +
 arch/powerpc/Makefile                          |   7 ++
 arch/powerpc/include/asm/asm-prototypes.h      |   4 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h  |   2 +-
 arch/powerpc/include/asm/exception-64s.h       |   4 +-
 arch/powerpc/include/asm/irq.h                 |  18 ++--
 arch/powerpc/include/asm/livepatch.h           |   7 +-
 arch/powerpc/include/asm/processor.h           | 105 ++---------------------
 arch/powerpc/include/asm/ptrace.h              |   2 +-
 arch/powerpc/include/asm/reg.h                 |   2 +-
 arch/powerpc/include/asm/smp.h                 |  17 +++-
 arch/powerpc/include/asm/task_size_32.h        |  21 +++++
 arch/powerpc/include/asm/task_size_64.h        |  79 +++++++++++++++++
 arch/powerpc/include/asm/thread_info.h         |  19 -----
 arch/powerpc/kernel/asm-offsets.c              |  12 ++-
 arch/powerpc/kernel/entry_32.S                 |  80 ++++++-----------
 arch/powerpc/kernel/entry_64.S                 |  12 +--
 arch/powerpc/kernel/epapr_hcalls.S             |   5 +-
 arch/powerpc/kernel/exceptions-64e.S           |  13 +--
 arch/powerpc/kernel/exceptions-64s.S           |   2 +-
 arch/powerpc/kernel/head_32.S                  |  14 +--
 arch/powerpc/kernel/head_40x.S                 |   4 +-
 arch/powerpc/kernel/head_44x.S                 |   8 +-
 arch/powerpc/kernel/head_64.S                  |   1 +
 arch/powerpc/kernel/head_8xx.S                 |   2 +-
 arch/powerpc/kernel/head_booke.h               |  12 +--
 arch/powerpc/kernel/head_fsl_booke.S           |  16 ++--
 arch/powerpc/kernel/idle_6xx.S                 |   8 +-
 arch/powerpc/kernel/idle_book3e.S              |   2 +-
 arch/powerpc/kernel/idle_e500.S                |   8 +-
 arch/powerpc/kernel/idle_power4.S              |   2 +-
 arch/powerpc/kernel/irq.c                      | 114 +++----------------------
 arch/powerpc/kernel/kgdb.c                     |  28 ------
 arch/powerpc/kernel/machine_kexec_64.c         |   6 +-
 arch/powerpc/kernel/misc_32.S                  |  17 ++--
 arch/powerpc/kernel/process.c                  |  63 ++++++++------
 arch/powerpc/kernel/setup-common.c             |   2 +-
 arch/powerpc/kernel/setup_32.c                 |  26 +++---
 arch/powerpc/kernel/setup_64.c                 |  51 +++--------
 arch/powerpc/kernel/smp.c                      |  16 ++--
 arch/powerpc/kernel/stacktrace.c               |  29 ++++++-
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   6 +-
 arch/powerpc/kvm/book3s_hv_hmi.c               |   1 +
 arch/powerpc/mm/hash_low_32.S                  |  14 ++-
 arch/powerpc/net/bpf_jit32.h                   |   5 +-
 arch/powerpc/sysdev/6xx-suspend.S              |   5 +-
 arch/powerpc/xmon/xmon.c                       |   2 +-
 47 files changed, 367 insertions(+), 507 deletions(-)
 create mode 100644 arch/powerpc/include/asm/task_size_32.h
 create mode 100644 arch/powerpc/include/asm/task_size_64.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 08908219fba9..3f237ffa0649 100644
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
index ac033341ed55..7de49889bd5d 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -427,6 +427,13 @@ else
 endif
 endif
 
+ifdef CONFIG_SMP
+prepare: task_cpu_prepare
+
+task_cpu_prepare: prepare0
+	$(eval KBUILD_CFLAGS += -D_TASK_CPU=$(shell awk '{if ($$2 == "TASK_CPU") print $$3;}' include/generated/asm-offsets.h))
+endif
+
 # Check toolchain versions:
 # - gcc-4.6 is the minimum kernel-wide version so nothing required.
 checkbin:
diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 1d911f68a23b..1484df6779ab 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -23,8 +23,8 @@
 #include <uapi/asm/ucontext.h>
 
 /* SMP */
-extern struct thread_info *current_set[NR_CPUS];
-extern struct thread_info *secondary_ti;
+extern struct task_struct *current_set[NR_CPUS];
+extern struct task_struct *secondary_current;
 void start_secondary(void *unused);
 
 /* kexec */
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 12e522807f9f..a28a28079edb 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -23,7 +23,7 @@
  */
 #include <asm/book3s/64/pgtable.h>
 #include <asm/bug.h>
-#include <asm/processor.h>
+#include <asm/task_size_64.h>
 #include <asm/cpu_has_feature.h>
 
 /*
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 3b4767ed3ec5..f0f0ff192e87 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -671,7 +671,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define RUNLATCH_ON				\
 BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r3, r1);		\
+	ld	r3, PACA_CURRENT_TI(r13);	\
 	ld	r4,TI_LOCAL_FLAGS(r3);		\
 	andi.	r0,r4,_TLF_RUNLATCH;		\
 	beql	ppc64_runlatch_on_trampoline;	\
@@ -721,7 +721,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 #ifdef CONFIG_PPC_970_NAP
 #define FINISH_NAP				\
 BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r11, r1);		\
+	ld	r11, PACA_CURRENT_TI(r13);	\
 	ld	r9,TI_LOCAL_FLAGS(r11);		\
 	andi.	r10,r9,_TLF_NAPPING;		\
 	bnel	power4_fixup_nap;		\
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index ee39ce56b2a2..c91a60cda4fa 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -48,23 +48,19 @@ struct pt_regs;
  * Per-cpu stacks for handling critical, debug and machine check
  * level interrupts.
  */
-extern struct thread_info *critirq_ctx[NR_CPUS];
-extern struct thread_info *dbgirq_ctx[NR_CPUS];
-extern struct thread_info *mcheckirq_ctx[NR_CPUS];
-extern void exc_lvl_ctx_init(void);
-#else
-#define exc_lvl_ctx_init()
+extern void *critirq_ctx[NR_CPUS];
+extern void *dbgirq_ctx[NR_CPUS];
+extern void *mcheckirq_ctx[NR_CPUS];
 #endif
 
 /*
  * Per-cpu stacks for handling hard and soft interrupts.
  */
-extern struct thread_info *hardirq_ctx[NR_CPUS];
-extern struct thread_info *softirq_ctx[NR_CPUS];
+extern void *hardirq_ctx[NR_CPUS];
+extern void *softirq_ctx[NR_CPUS];
 
-extern void irq_ctx_init(void);
-extern void call_do_softirq(struct thread_info *tp);
-extern void call_do_irq(struct pt_regs *regs, struct thread_info *tp);
+void call_do_softirq(void *sp);
+void call_do_irq(struct pt_regs *regs, void *sp);
 extern void do_IRQ(struct pt_regs *regs);
 extern void __init init_IRQ(void);
 extern void __do_irq(struct pt_regs *regs);
diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index 47a03b9b528b..5070df19d463 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -21,6 +21,7 @@
 
 #include <linux/module.h>
 #include <linux/ftrace.h>
+#include <linux/sched/task_stack.h>
 
 #ifdef CONFIG_LIVEPATCH
 static inline int klp_check_compiler_support(void)
@@ -43,13 +44,13 @@ static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
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
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ee58526cb6c2..ba2f0bc680e4 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -40,7 +40,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
-#include <asm/thread_info.h>
+#include <linux/thread_info.h>
 #include <asm/ptrace.h>
 #include <asm/hw_breakpoint.h>
 
@@ -77,105 +77,15 @@ extern int _chrp_type;
 
 #ifdef __KERNEL__
 
-struct task_struct;
-void start_thread(struct pt_regs *regs, unsigned long fdptr, unsigned long sp);
-void release_thread(struct task_struct *);
-
-#ifdef CONFIG_PPC32
-
-#if CONFIG_TASK_SIZE > CONFIG_KERNEL_START
-#error User TASK_SIZE overlaps with KERNEL_START address
-#endif
-#define TASK_SIZE	(CONFIG_TASK_SIZE)
-
-/* This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
- */
-#define TASK_UNMAPPED_BASE	(TASK_SIZE / 8 * 3)
-#endif
-
 #ifdef CONFIG_PPC64
-/*
- * 64-bit user address space can have multiple limits
- * For now supported values are:
- */
-#define TASK_SIZE_64TB  (0x0000400000000000UL)
-#define TASK_SIZE_128TB (0x0000800000000000UL)
-#define TASK_SIZE_512TB (0x0002000000000000UL)
-#define TASK_SIZE_1PB   (0x0004000000000000UL)
-#define TASK_SIZE_2PB   (0x0008000000000000UL)
-/*
- * With 52 bits in the address we can support
- * upto 4PB of range.
- */
-#define TASK_SIZE_4PB   (0x0010000000000000UL)
-
-/*
- * For now 512TB is only supported with book3s and 64K linux page size.
- */
-#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
-/*
- * Max value currently used:
- */
-#define TASK_SIZE_USER64		TASK_SIZE_4PB
-#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
-#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
-#else
-#define TASK_SIZE_USER64		TASK_SIZE_64TB
-#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
-/*
- * We don't need to allocate extended context ids for 4K page size, because
- * we limit the max effective address on this config to 64TB.
- */
-#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
-#endif
-
-/*
- * 32-bit user address space is 4GB - 1 page
- * (this 1 page is needed so referencing of 0xFFFFFFFF generates EFAULT
- */
-#define TASK_SIZE_USER32 (0x0000000100000000UL - (1*PAGE_SIZE))
-
-#define TASK_SIZE_OF(tsk) (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
-		TASK_SIZE_USER32 : TASK_SIZE_USER64)
-#define TASK_SIZE	  TASK_SIZE_OF(current)
-/* This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
- */
-#define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
-#define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(DEFAULT_MAP_WINDOW_USER64 / 4))
-
-#define TASK_UNMAPPED_BASE ((is_32bit_task()) ? \
-		TASK_UNMAPPED_BASE_USER32 : TASK_UNMAPPED_BASE_USER64 )
-#endif
-
-/*
- * Initial task size value for user applications. For book3s 64 we start
- * with 128TB and conditionally enable upto 512TB
- */
-#ifdef CONFIG_PPC_BOOK3S_64
-#define DEFAULT_MAP_WINDOW	((is_32bit_task()) ?			\
-				 TASK_SIZE_USER32 : DEFAULT_MAP_WINDOW_USER64)
+#include <asm/task_size_64.h>
 #else
-#define DEFAULT_MAP_WINDOW	TASK_SIZE
+#include <asm/task_size_32.h>
 #endif
 
-#ifdef __powerpc64__
-
-#define STACK_TOP_USER64 DEFAULT_MAP_WINDOW_USER64
-#define STACK_TOP_USER32 TASK_SIZE_USER32
-
-#define STACK_TOP (is_32bit_task() ? \
-		   STACK_TOP_USER32 : STACK_TOP_USER64)
-
-#define STACK_TOP_MAX TASK_SIZE_USER64
-
-#else /* __powerpc64__ */
-
-#define STACK_TOP TASK_SIZE
-#define STACK_TOP_MAX	STACK_TOP
-
-#endif /* __powerpc64__ */
+struct task_struct;
+void start_thread(struct pt_regs *regs, unsigned long fdptr, unsigned long sp);
+void release_thread(struct task_struct *);
 
 typedef struct {
 	unsigned long seg;
@@ -357,8 +267,7 @@ struct thread_struct {
 #define ARCH_MIN_TASKALIGN 16
 
 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
-#define INIT_SP_LIMIT \
-	(_ALIGN_UP(sizeof(init_thread_info), 16) + (unsigned long) &init_stack)
+#define INIT_SP_LIMIT	((unsigned long)&init_stack)
 
 #ifdef CONFIG_SPE
 #define SPEFSCR_INIT \
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
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1c98ef1f2d5b..581e61db2dcf 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1062,7 +1062,7 @@
  *	- SPRG9 debug exception scratch
  *
  * All 32-bit:
- *	- SPRG3 current thread_info pointer
+ *	- SPRG3 current thread_struct physical addr pointer
  *        (virtual on BookE, physical on others)
  *
  * 32-bit classic:
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
diff --git a/arch/powerpc/include/asm/task_size_32.h b/arch/powerpc/include/asm/task_size_32.h
new file mode 100644
index 000000000000..de7290ee770f
--- /dev/null
+++ b/arch/powerpc/include/asm/task_size_32.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_TASK_SIZE_32_H
+#define _ASM_POWERPC_TASK_SIZE_32_H
+
+#if CONFIG_TASK_SIZE > CONFIG_KERNEL_START
+#error User TASK_SIZE overlaps with KERNEL_START address
+#endif
+
+#define TASK_SIZE (CONFIG_TASK_SIZE)
+
+/*
+ * This decides where the kernel will search for a free chunk of vm space during
+ * mmap's.
+ */
+#define TASK_UNMAPPED_BASE (TASK_SIZE / 8 * 3)
+
+#define DEFAULT_MAP_WINDOW TASK_SIZE
+#define STACK_TOP TASK_SIZE
+#define STACK_TOP_MAX STACK_TOP
+
+#endif /* _ASM_POWERPC_TASK_SIZE_32_H */
diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
new file mode 100644
index 000000000000..eab4779f6b84
--- /dev/null
+++ b/arch/powerpc/include/asm/task_size_64.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_TASK_SIZE_64_H
+#define _ASM_POWERPC_TASK_SIZE_64_H
+
+/*
+ * 64-bit user address space can have multiple limits
+ * For now supported values are:
+ */
+#define TASK_SIZE_64TB  (0x0000400000000000UL)
+#define TASK_SIZE_128TB (0x0000800000000000UL)
+#define TASK_SIZE_512TB (0x0002000000000000UL)
+#define TASK_SIZE_1PB   (0x0004000000000000UL)
+#define TASK_SIZE_2PB   (0x0008000000000000UL)
+
+/*
+ * With 52 bits in the address we can support up to 4PB of range.
+ */
+#define TASK_SIZE_4PB   (0x0010000000000000UL)
+
+/*
+ * For now 512TB is only supported with book3s and 64K linux page size.
+ */
+#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
+/*
+ * Max value currently used:
+ */
+#define TASK_SIZE_USER64		TASK_SIZE_4PB
+#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
+#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
+#else
+#define TASK_SIZE_USER64		TASK_SIZE_64TB
+#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
+
+/*
+ * We don't need to allocate extended context ids for 4K page size, because we
+ * limit the max effective address on this config to 64TB.
+ */
+#define TASK_CONTEXT_SIZE TASK_SIZE_64TB
+#endif
+
+/*
+ * 32-bit user address space is 4GB - 1 page
+ * (this 1 page is needed so referencing of 0xFFFFFFFF generates EFAULT
+ */
+#define TASK_SIZE_USER32 (0x0000000100000000UL - (1 * PAGE_SIZE))
+
+#define TASK_SIZE_OF(tsk)						\
+	(test_tsk_thread_flag(tsk, TIF_32BIT) ? TASK_SIZE_USER32 :	\
+						TASK_SIZE_USER64)
+
+#define TASK_SIZE TASK_SIZE_OF(current)
+
+#define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
+#define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(DEFAULT_MAP_WINDOW_USER64 / 4))
+
+/*
+ * This decides where the kernel will search for a free chunk of vm space during
+ * mmap's.
+ */
+#define TASK_UNMAPPED_BASE	\
+	((is_32bit_task()) ? TASK_UNMAPPED_BASE_USER32 : TASK_UNMAPPED_BASE_USER64)
+
+/*
+ * Initial task size value for user applications. For book3s 64 we start
+ * with 128TB and conditionally enable upto 512TB
+ */
+#ifdef CONFIG_PPC_BOOK3S_64
+#define DEFAULT_MAP_WINDOW	\
+	((is_32bit_task()) ? TASK_SIZE_USER32 : DEFAULT_MAP_WINDOW_USER64)
+#else
+#define DEFAULT_MAP_WINDOW	TASK_SIZE
+#endif
+
+#define STACK_TOP_USER64 DEFAULT_MAP_WINDOW_USER64
+#define STACK_TOP_USER32 TASK_SIZE_USER32
+#define STACK_TOP_MAX TASK_SIZE_USER64
+#define STACK_TOP (is_32bit_task() ? STACK_TOP_USER32 : STACK_TOP_USER64)
+
+#endif /* _ASM_POWERPC_TASK_SIZE_64_H */
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 544cac0474cb..8e1d0195ac36 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -17,12 +17,6 @@
 
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
-#ifdef CONFIG_PPC64
-#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(clrrdi dest, sp, THREAD_SHIFT)
-#else
-#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(rlwinm dest, sp, 0, 0, 31-THREAD_SHIFT)
-#endif
-
 #ifndef __ASSEMBLY__
 #include <linux/cache.h>
 #include <asm/processor.h>
@@ -34,8 +28,6 @@
  * low level task data.
  */
 struct thread_info {
-	struct task_struct *task;		/* main task structure */
-	int		cpu;			/* cpu we're on */
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
 	unsigned long	local_flags;		/* private flags for thread */
@@ -58,8 +50,6 @@ struct thread_info {
  */
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.task =		&tsk,			\
-	.cpu =		0,			\
 	.preempt_count = INIT_PREEMPT_COUNT,	\
 	.flags =	0,			\
 }
@@ -67,15 +57,6 @@ struct thread_info {
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
index 9ffc72ded73a..7a1b93c5af63 100644
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
@@ -90,10 +92,12 @@ int main(void)
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
 #else
-	OFFSET(THREAD_INFO, task_struct, stack);
-	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
 	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
 #endif /* CONFIG_PPC64 */
+	OFFSET(TASK_STACK, task_struct, stack);
+#ifdef CONFIG_SMP
+	OFFSET(TASK_CPU, task_struct, cpu);
+#endif
 
 #ifdef CONFIG_LIVEPATCH
 	OFFSET(TI_livepatch_sp, thread_info, livepatch_sp);
@@ -161,8 +165,6 @@ int main(void)
 	OFFSET(TI_FLAGS, thread_info, flags);
 	OFFSET(TI_LOCAL_FLAGS, thread_info, local_flags);
 	OFFSET(TI_PREEMPT, thread_info, preempt_count);
-	OFFSET(TI_TASK, thread_info, task);
-	OFFSET(TI_CPU, thread_info, cpu);
 
 #ifdef CONFIG_PPC64
 	OFFSET(DCACHEL1BLOCKSIZE, ppc64_caches, l1d.block_size);
@@ -177,6 +179,8 @@ int main(void)
 	OFFSET(PACAPROCSTART, paca_struct, cpu_start);
 	OFFSET(PACAKSAVE, paca_struct, kstack);
 	OFFSET(PACACURRENT, paca_struct, __current);
+	DEFINE(PACA_CURRENT_TI, offsetof(struct paca_struct, __current) +
+				offsetof(struct task_struct, thread_info));
 	OFFSET(PACASAVEDMSR, paca_struct, saved_msr);
 	OFFSET(PACAR1, paca_struct, saved_r1);
 	OFFSET(PACATOC, paca_struct, kernel_toc);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0768dfd8a64e..a5e2d5585dcb 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -97,14 +97,11 @@ crit_transfer_to_handler:
 	mfspr	r0,SPRN_SRR1
 	stw	r0,_SRR1(r11)
 
-	/* set the stack limit to the current stack
-	 * and set the limit to protect the thread_info
-	 * struct
-	 */
+	/* set the stack limit to the current stack */
 	mfspr	r8,SPRN_SPRG_THREAD
 	lwz	r0,KSP_LIMIT(r8)
 	stw	r0,SAVED_KSP_LIMIT(r11)
-	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
+	rlwinm	r0,r1,0,0,(31 - THREAD_SHIFT)
 	stw	r0,KSP_LIMIT(r8)
 	/* fall through */
 #endif
@@ -121,14 +118,11 @@ crit_transfer_to_handler:
 	mfspr	r0,SPRN_SRR1
 	stw	r0,crit_srr1@l(0)
 
-	/* set the stack limit to the current stack
-	 * and set the limit to protect the thread_info
-	 * struct
-	 */
+	/* set the stack limit to the current stack */
 	mfspr	r8,SPRN_SPRG_THREAD
 	lwz	r0,KSP_LIMIT(r8)
 	stw	r0,saved_ksp_limit@l(0)
-	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
+	rlwinm	r0,r1,0,0,(31 - THREAD_SHIFT)
 	stw	r0,KSP_LIMIT(r8)
 	/* fall through */
 #endif
@@ -157,7 +151,6 @@ transfer_to_handler:
 	stw	r2,_XER(r11)
 	mfspr	r12,SPRN_SPRG_THREAD
 	addi	r2,r12,-THREAD
-	tovirt(r2,r2)			/* set r2 to current */
 	beq	2f			/* if from user, fix up THREAD.regs */
 	addi	r11,r1,STACK_FRAME_OVERHEAD
 	stw	r11,PT_REGS(r12)
@@ -166,6 +159,9 @@ transfer_to_handler:
 	   internal debug mode bit to do this. */
 	lwz	r12,THREAD_DBCR0(r12)
 	andis.	r12,r12,DBCR0_IDM@h
+#endif
+	ACCOUNT_CPU_USER_ENTRY(r2, r11, r12)
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 	beq+	3f
 	/* From user and task is ptraced - load up global dbcr0 */
 	li	r12,-1			/* clear all pending debug events */
@@ -174,8 +170,7 @@ transfer_to_handler:
 	tophys(r11,r11)
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r9,TI_CPU(r9)
+	lwz	r9,TASK_CPU(r2)
 	slwi	r9,r9,3
 	add	r11,r11,r9
 #endif
@@ -185,11 +180,6 @@ transfer_to_handler:
 	addi	r12,r12,-1
 	stw	r12,4(r11)
 #endif
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-	CURRENT_THREAD_INFO(r9, r1)
-	tophys(r9, r9)
-	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
-#endif
 
 	b	3f
 
@@ -201,9 +191,7 @@ transfer_to_handler:
 	ble-	stack_ovf		/* then the kernel stack overflowed */
 5:
 #if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
-	CURRENT_THREAD_INFO(r9, r1)
-	tophys(r9,r9)			/* check local flags */
-	lwz	r12,TI_LOCAL_FLAGS(r9)
+	lwz	r12,TI_LOCAL_FLAGS(r2)
 	mtcrf	0x01,r12
 	bt-	31-TLF_NAPPING,4f
 	bt-	31-TLF_SLEEPING,7f
@@ -212,6 +200,7 @@ transfer_to_handler:
 transfer_to_handler_cont:
 3:
 	mflr	r9
+	tovirt(r2, r2)			/* set r2 to current */
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
@@ -275,11 +264,11 @@ reenable_mmu:				/* re-enable mmu so we can */
 
 #if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
 4:	rlwinm	r12,r12,0,~_TLF_NAPPING
-	stw	r12,TI_LOCAL_FLAGS(r9)
+	stw	r12,TI_LOCAL_FLAGS(r2)
 	b	power_save_ppc32_restore
 
 7:	rlwinm	r12,r12,0,~_TLF_SLEEPING
-	stw	r12,TI_LOCAL_FLAGS(r9)
+	stw	r12,TI_LOCAL_FLAGS(r2)
 	lwz	r9,_MSR(r11)		/* if sleeping, clear MSR.EE */
 	rlwinm	r9,r9,0,~MSR_EE
 	lwz	r12,_LINK(r11)		/* and return to address in LR */
@@ -351,8 +340,7 @@ _GLOBAL(DoSyscall)
 	mtmsr	r11
 1:
 #endif /* CONFIG_TRACE_IRQFLAGS */
-	CURRENT_THREAD_INFO(r10, r1)
-	lwz	r11,TI_FLAGS(r10)
+	lwz	r11,TI_FLAGS(r2)
 	andi.	r11,r11,_TIF_SYSCALL_DOTRACE
 	bne-	syscall_dotrace
 syscall_dotrace_cont:
@@ -385,13 +373,12 @@ ret_from_syscall:
 	lwz	r3,GPR3(r1)
 #endif
 	mr	r6,r3
-	CURRENT_THREAD_INFO(r12, r1)
 	/* disable interrupts so current_thread_info()->flags can't change */
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
 	/* Note: We don't bother telling lockdep about it */
 	SYNC
 	MTMSRD(r10)
-	lwz	r9,TI_FLAGS(r12)
+	lwz	r9,TI_FLAGS(r2)
 	li	r8,-MAX_ERRNO
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
 	bne-	syscall_exit_work
@@ -438,8 +425,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	andi.	r4,r8,MSR_PR
 	beq	3f
-	CURRENT_THREAD_INFO(r4, r1)
-	ACCOUNT_CPU_USER_EXIT(r4, r5, r7)
+	ACCOUNT_CPU_USER_EXIT(r2, r5, r7)
 3:
 #endif
 	lwz	r4,_LINK(r1)
@@ -532,7 +518,7 @@ syscall_exit_work:
 	/* Clear per-syscall TIF flags if any are set.  */
 
 	li	r11,_TIF_PERSYSCALL_MASK
-	addi	r12,r12,TI_FLAGS
+	addi	r12,r2,TI_FLAGS
 3:	lwarx	r8,0,r12
 	andc	r8,r8,r11
 #ifdef CONFIG_IBM405_ERR77
@@ -540,7 +526,6 @@ syscall_exit_work:
 #endif
 	stwcx.	r8,0,r12
 	bne-	3b
-	subi	r12,r12,TI_FLAGS
 	
 4:	/* Anything which requires enabling interrupts? */
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP)
@@ -819,8 +804,7 @@ ret_from_except:
 
 user_exc_return:		/* r10 contains MSR_KERNEL here */
 	/* Check current_thread_info()->flags */
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r9,TI_FLAGS(r9)
+	lwz	r9,TI_FLAGS(r2)
 	andi.	r0,r9,_TIF_USER_WORK_MASK
 	bne	do_work
 
@@ -832,18 +816,14 @@ restore_user:
 	andis.	r10,r0,DBCR0_IDM@h
 	bnel-	load_dbcr0
 #endif
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-	CURRENT_THREAD_INFO(r9, r1)
-	ACCOUNT_CPU_USER_EXIT(r9, r10, r11)
-#endif
+	ACCOUNT_CPU_USER_EXIT(r2, r10, r11)
 
 	b	restore
 
 /* N.B. the only way to get here is from the beq following ret_from_except. */
 resume_kernel:
 	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r8,TI_FLAGS(r9)
+	lwz	r8,TI_FLAGS(r2)
 	andis.	r0,r8,_TIF_EMULATE_STACK_STORE@h
 	beq+	1f
 
@@ -869,7 +849,7 @@ resume_kernel:
 
 	/* Clear _TIF_EMULATE_STACK_STORE flag */
 	lis	r11,_TIF_EMULATE_STACK_STORE@h
-	addi	r5,r9,TI_FLAGS
+	addi	r5,r2,TI_FLAGS
 0:	lwarx	r8,0,r5
 	andc	r8,r8,r11
 #ifdef CONFIG_IBM405_ERR77
@@ -881,7 +861,7 @@ resume_kernel:
 
 #ifdef CONFIG_PREEMPT
 	/* check current_thread_info->preempt_count */
-	lwz	r0,TI_PREEMPT(r9)
+	lwz	r0,TI_PREEMPT(r2)
 	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
 	bne	restore
 	andi.	r8,r8,_TIF_NEED_RESCHED
@@ -897,8 +877,7 @@ resume_kernel:
 	bl	trace_hardirqs_off
 #endif
 1:	bl	preempt_schedule_irq
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r3,TI_FLAGS(r9)
+	lwz	r3,TI_FLAGS(r2)
 	andi.	r0,r3,_TIF_NEED_RESCHED
 	bne-	1b
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -1166,10 +1145,6 @@ ret_from_debug_exc:
 	mfspr	r9,SPRN_SPRG_THREAD
 	lwz	r10,SAVED_KSP_LIMIT(r1)
 	stw	r10,KSP_LIMIT(r9)
-	lwz	r9,THREAD_INFO-THREAD(r9)
-	CURRENT_THREAD_INFO(r10, r1)
-	lwz	r10,TI_PREEMPT(r10)
-	stw	r10,TI_PREEMPT(r9)
 	RESTORE_xSRR(SRR0,SRR1);
 	RESTORE_xSRR(CSRR0,CSRR1);
 	RESTORE_MMU_REGS;
@@ -1201,8 +1176,7 @@ load_dbcr0:
 	lis	r11,global_dbcr0@ha
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r9,TI_CPU(r9)
+	lwz	r9,TASK_CPU(r2)
 	slwi	r9,r9,3
 	add	r11,r11,r9
 #endif
@@ -1242,8 +1216,7 @@ recheck:
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r9,TI_FLAGS(r9)
+	lwz	r9,TI_FLAGS(r2)
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	bne-	do_resched
 	andi.	r0,r9,_TIF_USER_WORK_MASK
@@ -1292,10 +1265,13 @@ BEGIN_FTR_SECTION
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
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index a2c168b395d2..56e95ed9b0ab 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -166,7 +166,7 @@ system_call:			/* label this so stack traces look sane */
 	li	r10,IRQS_ENABLED
 	std	r10,SOFTE(r1)
 
-	CURRENT_THREAD_INFO(r11, r1)
+	ld	r11, PACA_CURRENT_TI(r13)
 	ld	r10,TI_FLAGS(r11)
 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
 	bne	.Lsyscall_dotrace		/* does not return */
@@ -213,7 +213,7 @@ system_call:			/* label this so stack traces look sane */
 	ld	r3,RESULT(r1)
 #endif
 
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACA_CURRENT_TI(r13)
 
 	ld	r8,_MSR(r1)
 #ifdef CONFIG_PPC_BOOK3S
@@ -348,7 +348,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 	/* Repopulate r9 and r10 for the syscall path */
 	addi	r9,r1,STACK_FRAME_OVERHEAD
-	CURRENT_THREAD_INFO(r10, r1)
+	ld	r10, PACA_CURRENT_TI(r13)
 	ld	r10,TI_FLAGS(r10)
 
 	cmpldi	r0,NR_syscalls
@@ -695,7 +695,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 2:
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
-	CURRENT_THREAD_INFO(r7, r8)  /* base of new stack */
+	clrrdi	r7, r8, THREAD_SHIFT	/* base of new stack */
 	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
 	   because we don't need to leave the 288-byte ABI gap at the
 	   top of the kernel stack. */
@@ -746,7 +746,7 @@ _GLOBAL(ret_from_except_lite)
 	mtmsrd	r10,1		  /* Update machine state */
 #endif /* CONFIG_PPC_BOOK3E */
 
-	CURRENT_THREAD_INFO(r9, r1)
+	ld	r9, PACA_CURRENT_TI(r13)
 	ld	r3,_MSR(r1)
 #ifdef CONFIG_PPC_BOOK3E
 	ld	r10,PACACURRENT(r13)
@@ -860,7 +860,7 @@ resume_kernel:
 1:	bl	preempt_schedule_irq
 
 	/* Re-test flags and eventually loop */
-	CURRENT_THREAD_INFO(r9, r1)
+	ld	r9, PACA_CURRENT_TI(r13)
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne	1b
diff --git a/arch/powerpc/kernel/epapr_hcalls.S b/arch/powerpc/kernel/epapr_hcalls.S
index 52ca2471ee1a..d252f4663a23 100644
--- a/arch/powerpc/kernel/epapr_hcalls.S
+++ b/arch/powerpc/kernel/epapr_hcalls.S
@@ -21,10 +21,9 @@
 #ifndef CONFIG_PPC64
 /* epapr_ev_idle() was derived from e500_idle() */
 _GLOBAL(epapr_ev_idle)
-	CURRENT_THREAD_INFO(r3, r1)
-	PPC_LL	r4, TI_LOCAL_FLAGS(r3)	/* set napping bit */
+	PPC_LL	r4, TI_LOCAL_FLAGS(r2)	/* set napping bit */
 	ori	r4, r4,_TLF_NAPPING	/* so when we take an exception */
-	PPC_STL	r4, TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
+	PPC_STL	r4, TI_LOCAL_FLAGS(r2)	/* it will return to our caller */
 
 	wrteei	1
 
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index afb638778f44..92d5ded2b290 100644
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
@@ -504,7 +493,7 @@ exc_##n##_bad_stack:							    \
  * interrupts happen before the wait instruction.
  */
 #define CHECK_NAPPING()							\
-	CURRENT_THREAD_INFO(r11, r1);					\
+	ld	r11, PACA_CURRENT_TI(r13);				\
 	ld	r10,TI_LOCAL_FLAGS(r11);				\
 	andi.	r9,r10,_TLF_NAPPING;					\
 	beq+	1f;							\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9e253ce27e08..83be18d478b8 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1629,7 +1629,7 @@ do_hash_page:
 	ori	r0,r0,DSISR_BAD_FAULT_64S@l
 	and.	r0,r4,r0		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
-	CURRENT_THREAD_INFO(r11, r1)
+	ld	r11, PACA_CURRENT_TI(r13)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
 	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
 	bne	77f			/* then don't call hash_page now */
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 05b08db3901d..146385b1c2da 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -261,7 +261,7 @@ __secondary_hold_acknowledge:
 	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
 	beq	1f;		\
 	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,THREAD_INFO-THREAD(r11);	\
+	lwz	r11,TASK_STACK-THREAD(r11);	\
 	addi	r11,r11,THREAD_SIZE;	\
 	tophys(r11,r11);	\
 1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
@@ -845,12 +845,12 @@ __secondary_start:
 	bl	init_idle_6xx
 #endif /* CONFIG_PPC_BOOK3S_32 */
 
-	/* get current_thread_info and current */
-	lis	r1,secondary_ti@ha
-	tophys(r1,r1)
-	lwz	r1,secondary_ti@l(r1)
-	tophys(r2,r1)
-	lwz	r2,TI_TASK(r2)
+	/* get current's stack and current */
+	lis	r2,secondary_current@ha
+	tophys(r2,r2)
+	lwz	r2,secondary_current@l(r2)
+	tophys(r1,r2)
+	lwz	r1,TASK_STACK(r1)
 
 	/* stack */
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index b19d78410511..3088c9f29f5e 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -115,7 +115,7 @@ _ENTRY(saved_ksp_limit)
 	andi.	r11,r11,MSR_PR;						     \
 	beq	1f;							     \
 	mfspr	r1,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
+	lwz	r1,TASK_STACK-THREAD(r1); /* this thread's kernel stack   */\
 	addi	r1,r1,THREAD_SIZE;					     \
 1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	tophys(r11,r1);							     \
@@ -158,7 +158,7 @@ _ENTRY(saved_ksp_limit)
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
+	lwz	r11,TASK_STACK-THREAD(r11); /* this thread's kernel stack */\
 1:	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE; /* Alloc an excpt frm  */\
 	tophys(r11,r11);						     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index bf23c19c92d6..37117ab11584 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -1019,10 +1019,10 @@ _GLOBAL(start_secondary_47x)
 
 	/* Now we can get our task struct and real stack pointer */
 
-	/* Get current_thread_info and current */
-	lis	r1,secondary_ti@ha
-	lwz	r1,secondary_ti@l(r1)
-	lwz	r2,TI_TASK(r1)
+	/* Get current's stack and current */
+	lis	r2,secondary_current@ha
+	lwz	r2,secondary_current@l(r2)
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
 
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 20cc816b3508..ca9207013579 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -142,7 +142,7 @@ instruction_counter:
 	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
 	beq	1f;		\
 	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,THREAD_INFO-THREAD(r11);	\
+	lwz	r11,TASK_STACK-THREAD(r11);	\
 	addi	r11,r11,THREAD_SIZE;	\
 	tophys(r11,r11);	\
 1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 306e26c073a0..1b22a8dea399 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -55,7 +55,7 @@ END_BTB_FLUSH_SECTION
 	beq	1f;							     \
 	BOOKE_CLEAR_BTB(r11)						\
 	/* if from user, start at top of this thread's kernel stack */       \
-	lwz	r11, THREAD_INFO-THREAD(r10);				     \
+	lwz	r11, TASK_STACK - THREAD(r10);				     \
 	ALLOC_STACK_FRAME(r11, THREAD_SIZE);				     \
 1 :	subi	r11, r11, INT_FRAME_SIZE; /* Allocate exception frame */     \
 	stw	r13, _CCR(r11);		/* save various registers */	     \
@@ -142,7 +142,7 @@ END_BTB_FLUSH_SECTION
 	BOOKE_CLEAR_BTB(r10)						\
 	andi.	r11,r11,MSR_PR;						     \
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
+	lwz	r11, TASK_STACK - THREAD(r11); /* this thread's kernel stack */\
 	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
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
index 2386ce2a9c6e..1881127682e9 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -243,8 +243,9 @@ set_ivor:
 	li	r0,0
 	stwu	r0,THREAD_SIZE-STACK_FRAME_OVERHEAD(r1)
 
-	CURRENT_THREAD_INFO(r22, r1)
-	stw	r24, TI_CPU(r22)
+#ifdef CONFIG_SMP
+	stw	r24, TASK_CPU(r2)
+#endif
 
 	bl	early_init
 
@@ -717,8 +718,7 @@ finish_tlb_load:
 
 	/* Get the next_tlbcam_idx percpu var */
 #ifdef CONFIG_SMP
-	lwz	r12, THREAD_INFO-THREAD(r12)
-	lwz	r15, TI_CPU(r12)
+	lwz	r15, TASK_CPU-THREAD(r12)
 	lis     r14, __per_cpu_offset@h
 	ori     r14, r14, __per_cpu_offset@l
 	rlwinm  r15, r15, 2, 0, 29
@@ -1089,10 +1089,10 @@ __secondary_start:
 	mr	r4,r24		/* Why? */
 	bl	call_setup_cpu
 
-	/* get current_thread_info and current */
-	lis	r1,secondary_ti@ha
-	lwz	r1,secondary_ti@l(r1)
-	lwz	r2,TI_TASK(r1)
+	/* get current's stack and current */
+	lis	r2,secondary_current@ha
+	lwz	r2,secondary_current@l(r2)
+	lwz	r1,TASK_STACK(r2)
 
 	/* stack */
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index ff026c9d3cab..5afd2e236990 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -136,10 +136,9 @@ BEGIN_FTR_SECTION
 	DSSALL
 	sync
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
+	lwz	r8,TI_LOCAL_FLAGS(r2)	/* set napping bit */
 	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
-	stw	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
+	stw	r8,TI_LOCAL_FLAGS(r2)	/* it will return to our caller */
 	mfmsr	r7
 	ori	r7,r7,MSR_EE
 	oris	r7,r7,MSR_POW@h
@@ -159,8 +158,7 @@ _GLOBAL(power_save_ppc32_restore)
 	stw	r9,_NIP(r11)		/* make it do a blr */
 
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r12, r11)
-	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
+	lwz	r11,TASK_CPU(r2)		/* get cpu number * 4 */
 	slwi	r11,r11,2
 #else
 	li	r11,0
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index 4e0d94d02030..31e732c378ad 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -63,7 +63,7 @@ _GLOBAL(\name)
 1:	/* Let's set the _TLF_NAPPING flag so interrupts make us return
 	 * to the right spot
 	*/
-	CURRENT_THREAD_INFO(r11, r1)
+	ld	r11, PACACURRENT(r13)
 	ld	r10,TI_LOCAL_FLAGS(r11)
 	ori	r10,r10,_TLF_NAPPING
 	std	r10,TI_LOCAL_FLAGS(r11)
diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 583e55ac7d26..69dfcd2ca011 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -22,10 +22,9 @@
 	.text
 
 _GLOBAL(e500_idle)
-	CURRENT_THREAD_INFO(r3, r1)
-	lwz	r4,TI_LOCAL_FLAGS(r3)	/* set napping bit */
+	lwz	r4,TI_LOCAL_FLAGS(r2)	/* set napping bit */
 	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
-	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
+	stw	r4,TI_LOCAL_FLAGS(r2)	/* it will return to our caller */
 
 #ifdef CONFIG_PPC_E500MC
 	wrteei	1
@@ -88,8 +87,7 @@ _GLOBAL(power_save_ppc32_restore)
 	stw	r9,_NIP(r11)		/* make it do a blr */
 
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r12, r1)
-	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
+	lwz	r11,TASK_CPU(r2)		/* get cpu number * 4 */
 	slwi	r11,r11,2
 #else
 	li	r11,0
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index a09b3c7ca176..b4c849f9f0e2 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -68,7 +68,7 @@ BEGIN_FTR_SECTION
 	DSSALL
 	sync
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	CURRENT_THREAD_INFO(r9, r1)
+	ld	r9, PACA_CURRENT_TI(r13)
 	ld	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
 	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
 	std	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index bb299613a462..8a936723c791 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -618,9 +618,8 @@ static inline void check_stack_overflow(void)
 	sp = current_stack_pointer() & (THREAD_SIZE-1);
 
 	/* check for stack overflow: is there less than 2KB free? */
-	if (unlikely(sp < (sizeof(struct thread_info) + 2048))) {
-		pr_err("do_IRQ: stack overflow: %ld\n",
-			sp - sizeof(struct thread_info));
+	if (unlikely(sp < 2048)) {
+		pr_err("do_IRQ: stack overflow: %ld\n", sp);
 		dump_stack();
 	}
 #endif
@@ -660,36 +659,21 @@ void __do_irq(struct pt_regs *regs)
 void do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	struct thread_info *curtp, *irqtp, *sirqtp;
+	void *cursp, *irqsp, *sirqsp;
 
 	/* Switch to the irq stack to handle this */
-	curtp = current_thread_info();
-	irqtp = hardirq_ctx[raw_smp_processor_id()];
-	sirqtp = softirq_ctx[raw_smp_processor_id()];
+	cursp = (void *)(current_stack_pointer() & ~(THREAD_SIZE - 1));
+	irqsp = hardirq_ctx[raw_smp_processor_id()];
+	sirqsp = softirq_ctx[raw_smp_processor_id()];
 
 	/* Already there ? */
-	if (unlikely(curtp == irqtp || curtp == sirqtp)) {
+	if (unlikely(cursp == irqsp || cursp == sirqsp)) {
 		__do_irq(regs);
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
-	call_do_irq(regs, irqtp);
-
-	/* Restore stack limit */
-	irqtp->task = NULL;
-
-	/* Copy back updates to the thread_info */
-	if (irqtp->flags)
-		set_bits(irqtp->flags, &curtp->flags);
+	call_do_irq(regs, irqsp);
 
 	set_irq_regs(old_regs);
 }
@@ -698,90 +682,20 @@ void __init init_IRQ(void)
 {
 	if (ppc_md.init_IRQ)
 		ppc_md.init_IRQ();
-
-	exc_lvl_ctx_init();
-
-	irq_ctx_init();
 }
 
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
-struct thread_info   *critirq_ctx[NR_CPUS] __read_mostly;
-struct thread_info    *dbgirq_ctx[NR_CPUS] __read_mostly;
-struct thread_info *mcheckirq_ctx[NR_CPUS] __read_mostly;
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
+void   *critirq_ctx[NR_CPUS] __read_mostly;
+void    *dbgirq_ctx[NR_CPUS] __read_mostly;
+void *mcheckirq_ctx[NR_CPUS] __read_mostly;
 #endif
 
-		memset((void *)critirq_ctx[cpu_nr], 0, THREAD_SIZE);
-		tp = critirq_ctx[cpu_nr];
-		tp->cpu = cpu_nr;
-		tp->preempt_count = 0;
-
-#ifdef CONFIG_BOOKE
-		memset((void *)dbgirq_ctx[cpu_nr], 0, THREAD_SIZE);
-		tp = dbgirq_ctx[cpu_nr];
-		tp->cpu = cpu_nr;
-		tp->preempt_count = 0;
-
-		memset((void *)mcheckirq_ctx[cpu_nr], 0, THREAD_SIZE);
-		tp = mcheckirq_ctx[cpu_nr];
-		tp->cpu = cpu_nr;
-		tp->preempt_count = HARDIRQ_OFFSET;
-#endif
-	}
-}
-#endif
-
-struct thread_info *softirq_ctx[NR_CPUS] __read_mostly;
-struct thread_info *hardirq_ctx[NR_CPUS] __read_mostly;
-
-void irq_ctx_init(void)
-{
-	struct thread_info *tp;
-	int i;
-
-	for_each_possible_cpu(i) {
-		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
-		tp = softirq_ctx[i];
-		tp->cpu = i;
-		klp_init_thread_info(tp);
-
-		memset((void *)hardirq_ctx[i], 0, THREAD_SIZE);
-		tp = hardirq_ctx[i];
-		tp->cpu = i;
-		klp_init_thread_info(tp);
-	}
-}
+void *softirq_ctx[NR_CPUS] __read_mostly;
+void *hardirq_ctx[NR_CPUS] __read_mostly;
 
 void do_softirq_own_stack(void)
 {
-	struct thread_info *curtp, *irqtp;
-
-	curtp = current_thread_info();
-	irqtp = softirq_ctx[smp_processor_id()];
-	irqtp->task = curtp->task;
-	irqtp->flags = 0;
-	call_do_softirq(irqtp);
-	irqtp->task = NULL;
-
-	/* Set any flag that may have been set on the
-	 * alternate stack
-	 */
-	if (irqtp->flags)
-		set_bits(irqtp->flags, &curtp->flags);
+	call_do_softirq(softirq_ctx[smp_processor_id()]);
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
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 57d2ffb2d45c..0dda4f8e3d7a 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -46,11 +46,10 @@ _GLOBAL(call_do_softirq)
 	mflr	r0
 	stw	r0,4(r1)
 	lwz	r10,THREAD+KSP_LIMIT(r2)
-	addi	r11,r3,THREAD_INFO_GAP
+	stw	r3, THREAD+KSP_LIMIT(r2)
 	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r3)
 	mr	r1,r3
 	stw	r10,8(r1)
-	stw	r11,THREAD+KSP_LIMIT(r2)
 	bl	__do_softirq
 	lwz	r10,8(r1)
 	lwz	r1,0(r1)
@@ -60,17 +59,16 @@ _GLOBAL(call_do_softirq)
 	blr
 
 /*
- * void call_do_irq(struct pt_regs *regs, struct thread_info *irqtp);
+ * void call_do_irq(struct pt_regs *regs, void *sp);
  */
 _GLOBAL(call_do_irq)
 	mflr	r0
 	stw	r0,4(r1)
 	lwz	r10,THREAD+KSP_LIMIT(r2)
-	addi	r11,r4,THREAD_INFO_GAP
+	stw	r4, THREAD+KSP_LIMIT(r2)
 	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r4)
 	mr	r1,r4
 	stw	r10,8(r1)
-	stw	r11,THREAD+KSP_LIMIT(r2)
 	bl	__do_irq
 	lwz	r10,8(r1)
 	lwz	r1,0(r1)
@@ -183,10 +181,13 @@ _GLOBAL(low_choose_750fx_pll)
 	or	r4,r4,r5
 	mtspr	SPRN_HID1,r4
 
+#ifdef CONFIG_SMP
 	/* Store new HID1 image */
-	CURRENT_THREAD_INFO(r6, r1)
-	lwz	r6,TI_CPU(r6)
+	lwz	r6,TASK_CPU(r2)
 	slwi	r6,r6,2
+#else
+	li	r6, 0
+#endif
 	addis	r6,r6,nap_save_hid1@ha
 	stw	r4,nap_save_hid1@l(r6)
 
@@ -599,7 +600,7 @@ EXPORT_SYMBOL(__bswapdi2)
 #ifdef CONFIG_SMP
 _GLOBAL(start_secondary_resume)
 	/* Reset stack */
-	CURRENT_THREAD_INFO(r1, r1)
+	rlwinm	r1, r1, 0, 0, 31 - THREAD_SHIFT
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
 	li	r3,0
 	stw	r3,0(r1)		/* Zero the stack frame pointer	*/
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ce393df243aa..da82ab5dd743 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1231,8 +1231,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		batch->active = 1;
 	}
 
-	if (current_thread_info()->task->thread.regs) {
-		restore_math(current_thread_info()->task->thread.regs);
+	if (current->thread.regs) {
+		restore_math(current->thread.regs);
 
 		/*
 		 * The copy-paste buffer can only store into foreign real
@@ -1242,7 +1242,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		 * mappings, we must issue a cp_abort to clear any state and
 		 * prevent snooping, corruption or a covert channel.
 		 */
-		if (current_thread_info()->task->thread.used_vas)
+		if (current->thread.used_vas)
 			asm volatile(PPC_CP_ABORT);
 	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
@@ -1634,7 +1634,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 	struct thread_info *ti = task_thread_info(p);
 
-	klp_init_thread_info(ti);
+	klp_init_thread_info(p);
 
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
@@ -1691,8 +1691,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	sp -= STACK_FRAME_OVERHEAD;
 	p->thread.ksp = sp;
 #ifdef CONFIG_PPC32
-	p->thread.ksp_limit = (unsigned long)task_stack_page(p) +
-				_ALIGN_UP(sizeof(struct thread_info), 16);
+	p->thread.ksp_limit = (unsigned long)end_of_stack(p);
 #endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	p->thread.ptrace_bps[0] = NULL;
@@ -1995,21 +1994,14 @@ static inline int valid_irq_stack(unsigned long sp, struct task_struct *p,
 	unsigned long stack_page;
 	unsigned long cpu = task_cpu(p);
 
-	/*
-	 * Avoid crashing if the stack has overflowed and corrupted
-	 * task_cpu(p), which is in the thread_info struct.
-	 */
-	if (cpu < NR_CPUS && cpu_possible(cpu)) {
-		stack_page = (unsigned long) hardirq_ctx[cpu];
-		if (sp >= stack_page + sizeof(struct thread_struct)
-		    && sp <= stack_page + THREAD_SIZE - nbytes)
-			return 1;
-
-		stack_page = (unsigned long) softirq_ctx[cpu];
-		if (sp >= stack_page + sizeof(struct thread_struct)
-		    && sp <= stack_page + THREAD_SIZE - nbytes)
-			return 1;
-	}
+	stack_page = (unsigned long)hardirq_ctx[cpu];
+	if (sp >= stack_page && sp <= stack_page + THREAD_SIZE - nbytes)
+		return 1;
+
+	stack_page = (unsigned long)softirq_ctx[cpu];
+	if (sp >= stack_page && sp <= stack_page + THREAD_SIZE - nbytes)
+		return 1;
+
 	return 0;
 }
 
@@ -2018,8 +2010,10 @@ int validate_sp(unsigned long sp, struct task_struct *p,
 {
 	unsigned long stack_page = (unsigned long)task_stack_page(p);
 
-	if (sp >= stack_page + sizeof(struct thread_struct)
-	    && sp <= stack_page + THREAD_SIZE - nbytes)
+	if (sp < THREAD_SIZE)
+		return 0;
+
+	if (sp >= stack_page && sp <= stack_page + THREAD_SIZE - nbytes)
 		return 1;
 
 	return valid_irq_stack(sp, p, nbytes);
@@ -2027,7 +2021,7 @@ int validate_sp(unsigned long sp, struct task_struct *p,
 
 EXPORT_SYMBOL(validate_sp);
 
-unsigned long get_wchan(struct task_struct *p)
+static unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
 	int count = 0;
@@ -2053,6 +2047,20 @@ unsigned long get_wchan(struct task_struct *p)
 	return 0;
 }
 
+unsigned long get_wchan(struct task_struct *p)
+{
+	unsigned long ret;
+
+	if (!try_get_task_stack(p))
+		return 0;
+
+	ret = __get_wchan(p);
+
+	put_task_stack(p);
+
+	return ret;
+}
+
 static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
 void show_stack(struct task_struct *tsk, unsigned long *stack)
@@ -2067,6 +2075,9 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	int curr_frame = 0;
 #endif
 
+	if (!try_get_task_stack(tsk))
+		return;
+
 	sp = (unsigned long) stack;
 	if (tsk == NULL)
 		tsk = current;
@@ -2081,7 +2092,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	printk("Call Trace:\n");
 	do {
 		if (!validate_sp(sp, tsk, STACK_FRAME_OVERHEAD))
-			return;
+			break;
 
 		stack = (unsigned long *) sp;
 		newsp = stack[0];
@@ -2121,6 +2132,8 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 
 		sp = newsp;
 	} while (count++ < kstack_depth_to_print);
+
+	put_task_stack(tsk);
 }
 
 #ifdef CONFIG_PPC64
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
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 947f904688b0..1f0b7629c1a6 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -196,6 +196,17 @@ static int __init ppc_init(void)
 }
 arch_initcall(ppc_init);
 
+static void *__init alloc_stack(void)
+{
+	void *ptr = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
+
+	if (!ptr)
+		panic("cannot allocate %d bytes for stack at %pS\n",
+		      THREAD_SIZE, (void *)_RET_IP_);
+
+	return ptr;
+}
+
 void __init irqstack_early_init(void)
 {
 	unsigned int i;
@@ -203,10 +214,8 @@ void __init irqstack_early_init(void)
 	/* interrupt stacks must be in lowmem, we get that for free on ppc32
 	 * as the memblock is limited to lowmem by default */
 	for_each_possible_cpu(i) {
-		softirq_ctx[i] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
-		hardirq_ctx[i] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
+		softirq_ctx[i] = alloc_stack();
+		hardirq_ctx[i] = alloc_stack();
 	}
 }
 
@@ -224,13 +233,10 @@ void __init exc_lvl_early_init(void)
 		hw_cpu = 0;
 #endif
 
-		critirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
+		critirq_ctx[hw_cpu] = alloc_stack();
 #ifdef CONFIG_BOOKE
-		dbgirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
-		mcheckirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
+		dbgirq_ctx[hw_cpu] = alloc_stack();
+		mcheckirq_ctx[hw_cpu] = alloc_stack();
 #endif
 	}
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 236c1151a3a7..daa361fc6a24 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -634,19 +634,17 @@ __init u64 ppc64_bolted_size(void)
 
 static void *__init alloc_stack(unsigned long limit, int cpu)
 {
-	unsigned long pa;
+	void *ptr;
 
 	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
 
-	pa = memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
-					early_cpu_to_node(cpu), MEMBLOCK_NONE);
-	if (!pa) {
-		pa = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
-		if (!pa)
-			panic("cannot allocate stacks");
-	}
+	ptr = memblock_alloc_try_nid(THREAD_SIZE, THREAD_SIZE,
+				     MEMBLOCK_LOW_LIMIT, limit,
+				     early_cpu_to_node(cpu));
+	if (!ptr)
+		panic("cannot allocate stacks");
 
-	return __va(pa);
+	return ptr;
 }
 
 void __init irqstack_early_init(void)
@@ -692,24 +690,6 @@ void __init exc_lvl_early_init(void)
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
@@ -736,25 +716,14 @@ void __init emergency_stack_init(void)
 	limit = min(ppc64_bolted_size(), ppc64_rma_size);
 
 	for_each_possible_cpu(i) {
-		struct thread_info *ti;
-
-		ti = alloc_stack(limit, i);
-		memset(ti, 0, THREAD_SIZE);
-		emerg_stack_init_thread_info(ti, i);
-		paca_ptrs[i]->emergency_sp = (void *)ti + THREAD_SIZE;
+		paca_ptrs[i]->emergency_sp = alloc_stack(limit, i) + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for NMI exception handling. */
-		ti = alloc_stack(limit, i);
-		memset(ti, 0, THREAD_SIZE);
-		emerg_stack_init_thread_info(ti, i);
-		paca_ptrs[i]->nmi_emergency_sp = (void *)ti + THREAD_SIZE;
+		paca_ptrs[i]->nmi_emergency_sp = alloc_stack(limit, i) + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
-		ti = alloc_stack(limit, i);
-		memset(ti, 0, THREAD_SIZE);
-		emerg_stack_init_thread_info(ti, i);
-		paca_ptrs[i]->mc_emergency_sp = (void *)ti + THREAD_SIZE;
+		paca_ptrs[i]->mc_emergency_sp = alloc_stack(limit, i) + THREAD_SIZE;
 #endif
 	}
 }
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3f15edf25a0d..a41fa8924004 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/task_stack.h>
 #include <linux/sched/topology.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
@@ -75,7 +76,7 @@
 static DEFINE_PER_CPU(int, cpu_state) = { 0 };
 #endif
 
-struct thread_info *secondary_ti;
+struct task_struct *secondary_current;
 bool has_big_cores;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
@@ -663,7 +664,7 @@ void smp_send_stop(void)
 }
 #endif /* CONFIG_NMI_IPI */
 
-struct thread_info *current_set[NR_CPUS];
+struct task_struct *current_set[NR_CPUS];
 
 static void smp_store_cpu_info(int id)
 {
@@ -928,7 +929,7 @@ void smp_prepare_boot_cpu(void)
 	paca_ptrs[boot_cpuid]->__current = current;
 #endif
 	set_numa_node(numa_cpu_lookup_table[boot_cpuid]);
-	current_set[boot_cpuid] = task_thread_info(current);
+	current_set[boot_cpuid] = current;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1013,14 +1014,13 @@ static bool secondaries_inhibited(void)
 
 static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 {
-	struct thread_info *ti = task_thread_info(idle);
-
 #ifdef CONFIG_PPC64
 	paca_ptrs[cpu]->__current = idle;
-	paca_ptrs[cpu]->kstack = (unsigned long)ti + THREAD_SIZE - STACK_FRAME_OVERHEAD;
+	paca_ptrs[cpu]->kstack = (unsigned long)task_stack_page(idle) +
+				 THREAD_SIZE - STACK_FRAME_OVERHEAD;
 #endif
-	ti->cpu = cpu;
-	secondary_ti = current_set[cpu] = ti;
+	idle->cpu = cpu;
+	secondary_current = current_set[cpu] = idle;
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index cf31ce6c1f53..f958f3bcba04 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -67,12 +67,17 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
 	unsigned long sp;
 
+	if (!try_get_task_stack(tsk))
+		return;
+
 	if (tsk == current)
 		sp = current_stack_pointer();
 	else
 		sp = tsk->thread.ksp;
 
 	save_context_stack(trace, sp, tsk, 0);
+
+	put_task_stack(tsk);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
@@ -90,9 +95,8 @@ EXPORT_SYMBOL_GPL(save_stack_trace_regs);
  *
  * If the task is not 'current', the caller *must* ensure the task is inactive.
  */
-int
-save_stack_trace_tsk_reliable(struct task_struct *tsk,
-				struct stack_trace *trace)
+static int __save_stack_trace_tsk_reliable(struct task_struct *tsk,
+					   struct stack_trace *trace)
 {
 	unsigned long sp;
 	unsigned long newsp;
@@ -197,6 +201,25 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 	}
 	return 0;
 }
+
+int save_stack_trace_tsk_reliable(struct task_struct *tsk,
+				  struct stack_trace *trace)
+{
+	int ret;
+
+	/*
+	 * If the task doesn't have a stack (e.g., a zombie), the stack is
+	 * "reliably" empty.
+	 */
+	if (!try_get_task_stack(tsk))
+		return 0;
+
+	ret = __save_stack_trace_tsk_reliable(tsk, trace);
+
+	put_task_stack(tsk);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk_reliable);
 #endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
 
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 32476a6e4e9c..17ec02cb2f58 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -229,7 +229,7 @@ ftrace_call:
 	 *  - r0, r11 & r12 are free
 	 */
 livepatch_handler:
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACA_CURRENT_TI(r13)
 
 	/* Allocate 3 x 8 bytes */
 	ld	r11, TI_livepatch_sp(r12)
@@ -256,7 +256,7 @@ livepatch_handler:
 	 * restore it.
 	 */
 
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACA_CURRENT_TI(r13)
 
 	ld	r11, TI_livepatch_sp(r12)
 
@@ -273,7 +273,7 @@ livepatch_handler:
 	ld	r2,  -24(r11)
 
 	/* Pop livepatch stack frame */
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACA_CURRENT_TI(r13)
 	subi	r11, r11, 24
 	std	r11, TI_livepatch_sp(r12)
 
diff --git a/arch/powerpc/kvm/book3s_hv_hmi.c b/arch/powerpc/kvm/book3s_hv_hmi.c
index e3f738eb1cac..64b5011475c7 100644
--- a/arch/powerpc/kvm/book3s_hv_hmi.c
+++ b/arch/powerpc/kvm/book3s_hv_hmi.c
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 #include <asm/paca.h>
 #include <asm/hmi.h>
+#include <asm/processor.h>
 
 void wait_for_subcore_guest_exit(void)
 {
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 1e2df3e9f9ea..5bee2d982959 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -186,8 +186,7 @@ _GLOBAL(add_hash_page)
 	add	r3,r3,r0		/* note create_hpte trims to 24 bits */
 
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r8, r1)	/* use cpu number to make tag */
-	lwz	r8,TI_CPU(r8)		/* to go in mmu_hash_lock */
+	lwz	r8,TASK_CPU(r2)		/* to go in mmu_hash_lock */
 	oris	r8,r8,12
 #endif /* CONFIG_SMP */
 
@@ -549,9 +548,8 @@ _GLOBAL(flush_hash_pages)
 #ifdef CONFIG_SMP
 	addis	r9,r7,mmu_hash_lock@ha
 	addi	r9,r9,mmu_hash_lock@l
-	CURRENT_THREAD_INFO(r8, r1)
-	add	r8,r8,r7
-	lwz	r8,TI_CPU(r8)
+	add	r8,r2,r7
+	lwz	r8,TASK_CPU(r8)
 	oris	r8,r8,9
 10:	lwarx	r0,0,r9
 	cmpi	0,r0,0
@@ -646,8 +644,7 @@ EXPORT_SYMBOL(flush_hash_pages)
  */
 _GLOBAL(_tlbie)
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r8, r1)
-	lwz	r8,TI_CPU(r8)
+	lwz	r8,TASK_CPU(r2)
 	oris	r8,r8,11
 	mfmsr	r10
 	SYNC
@@ -684,8 +681,7 @@ _GLOBAL(_tlbie)
  */
 _GLOBAL(_tlbia)
 #if defined(CONFIG_SMP)
-	CURRENT_THREAD_INFO(r8, r1)
-	lwz	r8,TI_CPU(r8)
+	lwz	r8,TASK_CPU(r2)
 	oris	r8,r8,10
 	mfmsr	r10
 	SYNC
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
diff --git a/arch/powerpc/sysdev/6xx-suspend.S b/arch/powerpc/sysdev/6xx-suspend.S
index cf48e9cb2575..6c4aec25c4ba 100644
--- a/arch/powerpc/sysdev/6xx-suspend.S
+++ b/arch/powerpc/sysdev/6xx-suspend.S
@@ -29,10 +29,9 @@ _GLOBAL(mpc6xx_enter_standby)
 	ori	r5, r5, ret_from_standby@l
 	mtlr	r5
 
-	CURRENT_THREAD_INFO(r5, r1)
-	lwz	r6, TI_LOCAL_FLAGS(r5)
+	lwz	r6, TI_LOCAL_FLAGS(r2)
 	ori	r6, r6, _TLF_SLEEPING
-	stw	r6, TI_LOCAL_FLAGS(r5)
+	stw	r6, TI_LOCAL_FLAGS(r2)
 
 	mfmsr	r5
 	ori	r5, r5, MSR_EE
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 757b8499aba2..a0f44f992360 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2997,7 +2997,7 @@ static void show_task(struct task_struct *tsk)
 	printf("%px %016lx %6d %6d %c %2d %s\n", tsk,
 		tsk->thread.ksp,
 		tsk->pid, rcu_dereference(tsk->parent)->pid,
-		state, task_thread_info(tsk)->cpu,
+		state, task_cpu(tsk),
 		tsk->comm);
 }
 
-- 
2.13.3

