Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 17557B6EF3
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jul 2010 04:55:34 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o69ImSBY007769
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 12:48:29 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o69It5uE118310
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 12:55:07 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o69IwIvV020163
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 12:58:19 -0600
Subject: [PATCH, RT, RFC]  Hacks allowing -rt to run on POWER7 / Powerpc.
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Jul 2010 13:55:01 -0500
Message-ID: <1278701701.24737.19.camel@lexx>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Darren Hart <dvhltc@us.ibm.com>,
	will_schmidt <will_schmidt@vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH, RT, RFC]  Hacks allowing -rt to run on POWER7 / Powerpc.

We've been seeing some issues with userspace randomly SIGSEGV'ing while
running the -RT kernels on POWER7 based systems.   After lots of
debugging, head scratching, and experimental changes to the code, the
problem has been narrowed down such that we can avoid the problems by
disabling the TLB batching.

After some input from Ben and further debug, we've found that the
restoration of the batch->active value near the end of __switch_to()
seems to be the key.    ( The -RT related  changes within
arch/powerpc/kernel/processor.c __switch_to()  do the equivalent of a
arch_leave_lazy_mmu_mode() before calling _switch, use a hadbatch flag
to indicate if batching was active, and then restore that batch->active
value on the way out after the call to _switch_to.    That particular
code is in the -RT branch, and not found in mainline  )

Deferring to Ben (or others in the know) for whether this is the proper
solution or if there is something deeper, but.. 
IF the right answer is to simply disable the restoration of
batch->active, the rest of the CONFIG_PREEMPT_RT changes in
__switch_to() should then be replaceable with a single call to
arch_leave_lazy_mmu_mode().

The patch here is what I am currently running with, on both POWER6 and
POWER7 systems, successfully.


Signed-off-by:   Will Schmidt <will_schmidt@vnet.ibm.com>
CC:    Ben Herrenschmidt  <benh@kernel.crashing.org>
CC:    Thomas Gleixner <tglx@linutronix.de>

---
diff -aurp linux-2.6.33.5-rt23.orig/arch/powerpc/kernel/process.c linux-2.6.33.5-rt23.exp/arch/powerpc/kernel/process.c
--- linux-2.6.33.5-rt23.orig/arch/powerpc/kernel/process.c	2010-06-21 11:41:34.402513904 -0500
+++ linux-2.6.33.5-rt23.exp/arch/powerpc/kernel/process.c	2010-07-09 13:15:13.533269904 -0500
@@ -304,10 +304,6 @@ struct task_struct *__switch_to(struct t
 	struct thread_struct *new_thread, *old_thread;
 	unsigned long flags;
 	struct task_struct *last;
-#if defined(CONFIG_PPC64) && defined (CONFIG_PREEMPT_RT)
-	struct ppc64_tlb_batch *batch;
-	int hadbatch;
-#endif
 
 #ifdef CONFIG_SMP
 	/* avoid complexity of lazy save/restore of fpu
@@ -401,16 +397,6 @@ struct task_struct *__switch_to(struct t
 		new_thread->start_tb = current_tb;
 	}
 
-#ifdef CONFIG_PREEMPT_RT
-	batch = &__get_cpu_var(ppc64_tlb_batch);
-	if (batch->active) {
-		hadbatch = 1;
-		if (batch->index) {
-			__flush_tlb_pending(batch);
-		}
-		batch->active = 0;
-	}
-#endif /* #ifdef CONFIG_PREEMPT_RT */
 #endif
 
 	local_irq_save(flags);
@@ -425,16 +411,13 @@ struct task_struct *__switch_to(struct t
 	 * of sync. Hard disable here.
 	 */
 	hard_irq_disable();
-	last = _switch(old_thread, new_thread);
-
-	local_irq_restore(flags);
 
 #if defined(CONFIG_PPC64) && defined(CONFIG_PREEMPT_RT)
-	if (hadbatch) {
-		batch = &__get_cpu_var(ppc64_tlb_batch);
-		batch->active = 1;
-	}
+	arch_leave_lazy_mmu_mode();
 #endif
+	last = _switch(old_thread, new_thread);
+
+	local_irq_restore(flags);
 
 	return last;
 }
