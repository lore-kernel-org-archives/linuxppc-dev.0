Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlNyy4qPPzDqBM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 22:53:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jikos@kernel.org, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH 4/5] powerpc/livepatch: Add livepatch stack to struct
 thread_info
Date: Wed, 13 Apr 2016 22:53:22 +1000
Message-Id: <1460552003-15409-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to support live patching we need to maintain an alternate
stack of TOC & LR values. We use the base of the stack for this, and
store the "live patch stack pointer" in struct thread_info.

Unlike the other fields of thread_info, we can not statically initialise
that value, so it must be done at run time.

This patch just adds the code to support that, it is not enabled until
the next patch which actually adds live patch support.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/livepatch.h   |  8 ++++++++
 arch/powerpc/include/asm/thread_info.h |  4 +++-
 arch/powerpc/kernel/irq.c              |  3 +++
 arch/powerpc/kernel/process.c          |  6 +++++-
 arch/powerpc/kernel/setup_64.c         | 17 ++++++++++-------
 5 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index ad36e8e34fa1..a402f7f94896 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -49,6 +49,14 @@ static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
 	 */
 	return ftrace_location_range(faddr, faddr + 16);
 }
+
+static inline void klp_init_thread_info(struct thread_info *ti)
+{
+	/* + 1 to account for STACK_END_MAGIC */
+	ti->livepatch_sp = (unsigned long *)(ti + 1) + 1;
+}
+#else
+static void klp_init_thread_info(struct thread_info *ti) { }
 #endif /* CONFIG_LIVEPATCH */
 
 #endif /* _ASM_POWERPC_LIVEPATCH_H */
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 7efee4a3240b..8febc3f66d53 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -43,7 +43,9 @@ struct thread_info {
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
 	unsigned long	local_flags;		/* private flags for thread */
-
+#ifdef CONFIG_LIVEPATCH
+	unsigned long *livepatch_sp;
+#endif
 	/* low level flags - has atomic operations done on it */
 	unsigned long	flags ____cacheline_aligned_in_smp;
 };
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 290559df1e8b..3cb46a3b1de7 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -66,6 +66,7 @@
 #include <asm/udbg.h>
 #include <asm/smp.h>
 #include <asm/debug.h>
+#include <asm/livepatch.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
@@ -607,10 +608,12 @@ void irq_ctx_init(void)
 		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
 		tp = softirq_ctx[i];
 		tp->cpu = i;
+		klp_init_thread_info(tp);
 
 		memset((void *)hardirq_ctx[i], 0, THREAD_SIZE);
 		tp = hardirq_ctx[i];
 		tp->cpu = i;
+		klp_init_thread_info(tp);
 	}
 }
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b8500b4ac7fe..2a9280b945e0 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -55,6 +55,8 @@
 #include <asm/firmware.h>
 #endif
 #include <asm/code-patching.h>
+#include <asm/livepatch.h>
+
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 
@@ -1400,13 +1402,15 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	extern void ret_from_kernel_thread(void);
 	void (*f)(void);
 	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
+	struct thread_info *ti = task_thread_info(p);
+
+	klp_init_thread_info(ti);
 
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) sp;
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		/* kernel thread */
-		struct thread_info *ti = (void *)task_stack_page(p);
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
 		/* function */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f98be8383a39..96d4a2b23d0f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -69,6 +69,7 @@
 #include <asm/kvm_ppc.h>
 #include <asm/hugetlb.h>
 #include <asm/epapr_hcalls.h>
+#include <asm/livepatch.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -667,16 +668,16 @@ static void __init emergency_stack_init(void)
 	limit = min(safe_stack_limit(), ppc64_rma_size);
 
 	for_each_possible_cpu(i) {
-		unsigned long sp;
-		sp  = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
-		sp += THREAD_SIZE;
-		paca[i].emergency_sp = __va(sp);
+		struct thread_info *ti;
+		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
+		klp_init_thread_info(ti);
+		paca[i].emergency_sp = (void *)ti + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for machine check exception handling. */
-		sp  = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
-		sp += THREAD_SIZE;
-		paca[i].mc_emergency_sp = __va(sp);
+		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
+		klp_init_thread_info(ti);
+		paca[i].mc_emergency_sp = (void *)ti + THREAD_SIZE;
 #endif
 	}
 }
@@ -700,6 +701,8 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.panic)
 		setup_panic();
 
+	klp_init_thread_info(&init_thread_info);
+
 	init_mm.start_code = (unsigned long)_stext;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
-- 
2.5.0
