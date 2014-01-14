Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8E27E2C007A
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 15:26:25 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 14 Jan 2014 14:26:23 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 20B162BB0053
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 15:26:22 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0E47JmA12255316
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 15:07:19 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0E4QKwB019805
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 15:26:20 +1100
Subject: [PATCH] Move precessing of MCE queued event out from syscall exit
 path.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 09:56:11 +0530
Message-ID: <20140114042611.13145.6551.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Hugh Dickins <hughd@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Huge Dickins reported an issue that b5ff4211a829
"powerpc/book3s: Queue up and process delayed MCE events" breaks the
PowerMac G5 boot. This patch fixes it by moving the mce even processing
away from syscall exit, which was wrong to do that in first place, and
implements a different mechanism to deal with it using a paca flag and
decrementer interrupt to process the event.

Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h  |    3 +++
 arch/powerpc/include/asm/paca.h |    3 +++
 arch/powerpc/kernel/entry_64.S  |    5 -----
 arch/powerpc/kernel/irq.c       |   11 ++++++++++-
 arch/powerpc/kernel/mce.c       |    7 +++++++
 arch/powerpc/kernel/time.c      |    9 +++++++++
 6 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 2257d1e..225e678 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -186,6 +186,9 @@ struct mce_error_info {
 #define MCE_EVENT_RELEASE	true
 #define MCE_EVENT_DONTRELEASE	false
 
+/* MCE bit flags (paca.mce_flags) */
+#define MCE_EVENT_PENDING	0x0001
+
 extern void save_mce_event(struct pt_regs *regs, long handled,
 			   struct mce_error_info *mce_err, uint64_t nip,
 			   uint64_t addr);
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index c3523d1..f9aa521 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -141,6 +141,9 @@ struct paca_struct {
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
 	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
+#ifdef CONFIG_PPC_BOOK3S_64
+	u8 mce_flags;			/* MCE bit flags. */
+#endif
 	u64 sprg3;			/* Saved user-visible sprg */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	u64 tm_scratch;                 /* TM scratch area for reclaim */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 770d6d6..bbfb029 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -184,11 +184,6 @@ syscall_exit:
 	bl	.do_show_syscall_exit
 	ld	r3,RESULT(r1)
 #endif
-#ifdef CONFIG_PPC_BOOK3S_64
-BEGIN_FTR_SECTION
-	bl	.machine_check_process_queued_event
-END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
-#endif
 	CURRENT_THREAD_INFO(r12, r1)
 
 	ld	r8,_MSR(r1)
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ba01656..e22f591 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -67,6 +67,7 @@
 #include <asm/udbg.h>
 #include <asm/smp.h>
 #include <asm/debug.h>
+#include <asm/mce.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
@@ -158,9 +159,17 @@ notrace unsigned int __check_irq_replay(void)
 	 * We may have missed a decrementer interrupt. We check the
 	 * decrementer itself rather than the paca irq_happened field
 	 * in case we also had a rollover while hard disabled
+	 * Also check if any MCE event is queued up that requires
+	 * processing. Machine check handler would set paca->mce_flags
+	 * and then call set_dec(1) to trigger a decrementer interrupt
+	 * from NMI.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_DEC;
-	if ((happened & PACA_IRQ_DEC) || decrementer_check_overflow())
+	if ((happened & PACA_IRQ_DEC) || decrementer_check_overflow()
+#ifdef CONFIG_PPC_BOOK3S_64
+		|| local_paca->mce_flags & MCE_EVENT_PENDING
+#endif
+		)
 		return 0x900;
 
 	/* Finally check if an external interrupt happened */
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index d6edf2b..7bab827 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -185,6 +185,13 @@ void machine_check_queue_event(void)
 		return;
 	}
 	__get_cpu_var(mce_event_queue[index]) = evt;
+
+	/*
+	 * Set the event pending flag and raise an decrementer interrupt
+	 * to process the queued event later.
+	 */
+	local_paca->mce_flags |= MCE_EVENT_PENDING;
+	set_dec(1);
 }
 
 /*
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index b3b1441..87ccf92 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -69,6 +69,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/firmware.h>
 #include <asm/cputime.h>
+#include <asm/mce.h>
 
 /* powerpc clocksource/clockevent code */
 
@@ -505,6 +506,14 @@ void timer_interrupt(struct pt_regs * regs)
 		return;
 	}
 
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* Check if we have MCE event pending for processing. */
+	if (local_paca->mce_flags & MCE_EVENT_PENDING) {
+		local_paca->mce_flags &= ~MCE_EVENT_PENDING;
+		machine_check_process_queued_event();
+	}
+#endif
+
 	/* Conditionally hard-enable interrupts now that the DEC has been
 	 * bumped to its maximum value
 	 */
