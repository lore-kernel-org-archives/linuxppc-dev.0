Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsTvV64ZkzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 23:58:14 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y7so23273684pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 06:58:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 akpm@linux-foundation.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] powerpc/64: Initialise thread_info for emergency stacks
Date: Tue, 20 Jun 2017 23:58:01 +1000
Message-Id: <20170620135801.13272-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Emergency stacks have their thread_info mostly uninitialised, which in
particular means garbage preempt_count values.

Emergency stack code runs with interrupts disabled entirely, and is
used very rarely, so this has been unnoticed so far. It was found by a
proposed new powerpc watchdog that takes a soft-NMI directly from the
masked_interrupt handler and using the emergency stack. That crashed at
BUG_ON(in_nmi()) in nmi_enter(). preempt_count()s were found to be
garbage.

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

FYI, this bug looks to be breaking linux-next on some powerpc
boxes due to interaction with a proposed new powerpc watchdog
driver Andrew has in his tree:

http://marc.info/?l=linuxppc-embedded&m=149794320519941&w=2

 arch/powerpc/include/asm/thread_info.h | 19 +++++++++++++++++++
 arch/powerpc/kernel/setup_64.c         |  6 +++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index a941cc6fc3e9..5995e4b2996d 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -54,6 +54,7 @@ struct thread_info {
 	.task =		&tsk,			\
 	.cpu =		0,			\
 	.preempt_count = INIT_PREEMPT_COUNT,	\
+	.local_flags =	0,			\
 	.flags =	0,			\
 }
 
@@ -62,6 +63,24 @@ struct thread_info {
 
 #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
 
+/*
+ * Emergency stacks are used for a range of things, from asynchronous
+ * NMIs (system reset, machine check) to synchronous, process context.
+ * Set HARDIRQ_OFFSET because we don't know exactly what context we
+ * come from or if it had a valid stack, which is about the best we
+ * can do.
+ * TODO: what to do with accounting?
+ */
+#define emstack_init_thread_info(ti, c)		\
+do {						\
+	(ti)->task = NULL;			\
+	(ti)->cpu = (c);			\
+	(ti)->preempt_count = HARDIRQ_OFFSET;	\
+	(ti)->local_flags = 0;			\
+	(ti)->flags = 0;			\
+	klp_init_thread_info(ti);		\
+} while (0)
+
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f35ff9dea4fb..54c4336655f8 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -639,18 +639,18 @@ void __init emergency_stack_init(void)
 	for_each_possible_cpu(i) {
 		struct thread_info *ti;
 		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
-		klp_init_thread_info(ti);
+		emstack_init_thread_info(ti, i);
 		paca[i].emergency_sp = (void *)ti + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for NMI exception handling. */
 		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
-		klp_init_thread_info(ti);
+		emstack_init_thread_info(ti, i);
 		paca[i].nmi_emergency_sp = (void *)ti + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
 		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
-		klp_init_thread_info(ti);
+		emstack_init_thread_info(ti, i);
 		paca[i].mc_emergency_sp = (void *)ti + THREAD_SIZE;
 #endif
 	}
-- 
2.11.0
