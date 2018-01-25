Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRqjV1w5DzDsQ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 16:05:18 +1100 (AEDT)
Date: Thu, 25 Jan 2018 16:05:12 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH] powerpc/powernv: Provide a way to force a core into SMT4
 mode
Message-ID: <20180125050512.GA18744@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 processors up to and including "Nimbus" v2.2 have hardware
bugs relating to transactional memory and thread reconfiguration.
One of these bugs has a workaround which is to get the core into
SMT4 state temporarily.  This workaround is only needed when
running bare-metal.

This patch provides a function which gets the core into SMT4 mode
by preventing threads from going to a stop state, and waking up
those which are already in a stop state.  Once at least 3 threads
are not in a stop state, the core will be in SMT4 and we can
continue.

To do this, we add a "dont_stop" flag to the paca to tell the
thread not to go into a stop state.  If this flag is set,
power9_idle_stop() just returns immediately with a return value
of 0.  The pnv_power9_force_smt4() function does the following:

1. Set the dont_stop flag for each thread in the core, except
   ourselves (in fact we use an atomic_inc() in case more than
   one thread is calling this function concurrently).
2. See how many threads are awake, indicated by their
   requested_psscr field in the paca being 0.  If this is at
   least 3, skip to step 5.
3. Send a doorbell interrupt to each thread that was seen as
   being in a stop state in step 2.
4. Until at least 3 threads are awake, scan the threads to which
   we sent a doorbell interrupt and check if they are awake now.
5. Clear (actually atomic_dec()) the dont_stop flag for each
   thread in the core, except for ourselves.

This relies on the following properties:

- Once dont_stop is non-zero, requested_psccr can't go from zero to
  non-zero, except transiently (and without the thread doing stop).
- requested_psscr being zero guarantees that the thread isn't in
  a state-losing stop state where thread reconfiguration could occur.
- Doing stop with a PSSCR value of 0 won't be a state-losing stop
  and thus won't allow thread reconfiguration.

This does add a sync to power9_idle_stop(), which is necessary to
provide the correct ordering between setting requested_psscr and
checking dont_stop.  The overhead of the sync should be unnoticeable
compared to the latency of going into and out of a stop state.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/paca.h       |  3 ++
 arch/powerpc/kernel/asm-offsets.c     |  1 +
 arch/powerpc/kernel/idle_book3s.S     | 15 +++++++++
 arch/powerpc/platforms/powernv/idle.c | 62 +++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 23ac7fc..71b5c34 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -32,6 +32,7 @@
 #include <asm/accounting.h>
 #include <asm/hmi.h>
 #include <asm/cpuidle.h>
+#include <asm/atomic.h>
 
 register struct paca_struct *local_paca asm("r13");
 
@@ -177,6 +178,8 @@ struct paca_struct {
 	u8 thread_mask;
 	/* Mask to denote subcore sibling threads */
 	u8 subcore_sibling_mask;
+	/* Flag to request this thread not to stop */
+	atomic_t dont_stop;
 	/*
 	 * Pointer to an array which contains pointer
 	 * to the sibling threads' paca.
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ff6ce2f..91cb8df 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -758,6 +758,7 @@ int main(void)
 	OFFSET(PACA_SUBCORE_SIBLING_MASK, paca_struct, subcore_sibling_mask);
 	OFFSET(PACA_SIBLING_PACA_PTRS, paca_struct, thread_sibling_pacas);
 	OFFSET(PACA_REQ_PSSCR, paca_struct, requested_psscr);
+	OFFSET(PACA_DONT_STOP, paca_struct, dont_stop);
 #define STOP_SPR(x, f)	OFFSET(x, paca_struct, stop_sprs.f)
 	STOP_SPR(STOP_PID, pid);
 	STOP_SPR(STOP_LDBAR, ldbar);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 01e1c19..4a7f88c 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -430,10 +430,23 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
  */
 _GLOBAL(power9_idle_stop)
 	std	r3, PACA_REQ_PSSCR(r13)
+	sync
+	lwz	r5, PACA_DONT_STOP(r13)
+	cmpwi	r5, 0
+	bne	1f
 	mtspr 	SPRN_PSSCR,r3
 	LOAD_REG_ADDR(r4,power_enter_stop)
 	b	pnv_powersave_common
 	/* No return */
+1:
+	/*
+	 * We get here when TM / thread reconfiguration bug workaround
+	 * code wants to get the CPU into SMT4 mode, and therefore
+	 * we are being asked not to stop.
+	 */
+	li	r3, 0
+	std	r3, PACA_REQ_PSSCR(r13)
+	blr		/* return 0 for wakeup cause / SRR1 value */
 
 /*
  * On waking up from stop 0,1,2 with ESL=1 on POWER9 DD1,
@@ -584,6 +597,8 @@ FTR_SECTION_ELSE_NESTED(71)
 	mfspr	r5, SPRN_PSSCR
 	rldicl  r5,r5,4,60
 ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_POWER9_DD1, 71)
+	li	r0, 0		/* clear requested_psscr to say we're awake */
+	std	r0, PACA_REQ_PSSCR(r13)
 	cmpd	cr4,r5,r4
 	bge	cr4,pnv_wakeup_tb_loss /* returns to caller */
 
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 443d5ca..72d5a85 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -24,6 +24,7 @@
 #include <asm/code-patching.h>
 #include <asm/smp.h>
 #include <asm/runlatch.h>
+#include <asm/dbell.h>
 
 #include "powernv.h"
 #include "subcore.h"
@@ -387,6 +388,67 @@ void power9_idle(void)
 	power9_idle_type(pnv_default_stop_val, pnv_default_stop_mask);
 }
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+/*
+ * This is used in working around bugs in thread reconfiguration
+ * on POWER9 (at least up to Nimbus DD2.2) relating to transactional
+ * memory and the way that XER[SO] is checkpointed.
+ * This function forces the core into SMT4 in order by asking
+ * all other threads not to stop, and sending a message to any
+ * that are in a stop state.
+ * Must be called with preemption disabled.
+ */
+void pnv_power9_force_smt4(void)
+{
+	int cpu, cpu0, thr;
+	struct paca_struct *tpaca;
+	int awake_threads = 1;		/* this thread is awake */
+	int poke_threads = 0;
+
+	cpu = smp_processor_id();
+	cpu0 = cpu & ~(threads_per_core - 1);
+	tpaca = &paca[cpu0];
+	for (thr = 0; thr < threads_per_core; ++thr) {
+		if (cpu != cpu0 + thr)
+			atomic_inc(&tpaca[thr].dont_stop);
+	}
+	/* order setting dont_stop vs testing requested_psscr */
+	mb();
+	for (thr = 0; thr < threads_per_core; ++thr) {
+		if (!tpaca[thr].requested_psscr)
+			++awake_threads;
+		else
+			poke_threads |= (1 << thr);
+	}
+
+	/* If at least 3 threads are awake, the core is in SMT4 already */
+	if (awake_threads < threads_per_core - 1) {
+		/* We have to wake some threads; we'll use msgsnd */
+		for (thr = 0; thr < threads_per_core; ++thr) {
+			if (poke_threads & (1 << thr))
+				ppc_msgsnd(PPC_DBELL_MSGTYPE, 0,
+					   tpaca[thr].hw_cpu_id);
+		}
+		/* now spin until at least 3 threads are awake */
+		do {
+			for (thr = 0; thr < threads_per_core; ++thr) {
+				if ((poke_threads & (1 << thr)) &&
+				    !tpaca[thr].requested_psscr) {
+					++awake_threads;
+					poke_threads &= ~(1 << thr);
+				}
+			}
+		} while (awake_threads < threads_per_core - 1);
+	}
+	/* clear all the dont_stop flags */
+	for (thr = 0; thr < threads_per_core; ++thr) {
+		if (cpu != cpu0 + thr)
+			atomic_dec(&tpaca[thr].dont_stop);
+	}
+}
+EXPORT_SYMBOL_GPL(pnv_power9_force_smt4);
+#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
+
 #ifdef CONFIG_HOTPLUG_CPU
 static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
 {
-- 
2.7.4
