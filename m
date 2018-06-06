Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4119p56vVtzF31L
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 00:21:13 +1000 (AEST)
Message-Id: <d9ac8da98f53debb4758b98d0227979aca9196f7.1528292284.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 1/2] powerpc/time: Only set CONFIG_ARCH_HAS_SCALED_CPUTIME
 on PPC64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Frederic Weisbecker <fweisbec@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  6 Jun 2018 14:21:08 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

scaled cputime is only meaningfull when the processor has
SPURR and/or PURR, which means only on PPC64.

Removing it on PPC32 significantly reduces the size of
vtime_account_system() and vtime_account_idle() on an 8xx:

Before:
00000000 l     F .text	000000a8 vtime_delta
00000280 g     F .text	0000010c vtime_account_system
0000038c g     F .text	00000048 vtime_account_idle

After:
(vtime_delta gets inlined in the two functions)
000001d8 g     F .text	000000a0 vtime_account_system
00000278 g     F .text	00000038 vtime_account_idle

In terms of performance, we also get approximatly 5% improvement on task switch:
The following small benchmark app is run with perf stat:

void *thread(void *arg)
{
	int i;

	for (i = 0; i < atoi((char*)arg); i++)
		pthread_yield();
}

int main(int argc, char **argv)
{
	pthread_t th1, th2;

	pthread_create(&th1, NULL, thread, argv[1]);
	pthread_create(&th2, NULL, thread, argv[1]);
	pthread_join(th1, NULL);
	pthread_join(th2, NULL);

	return 0;
}

Before the patch:

~# perf stat chrt -f 98 ./sched 100000

 Performance counter stats for 'chrt -f 98 ./sched 100000':

       8622.166272      task-clock (msec)         #    0.955 CPUs utilized
            200027      context-switches          #    0.023 M/sec

After the patch:

~# perf stat chrt -f 98 ./sched 100000

 Performance counter stats for 'chrt -f 98 ./sched 100000':

       8207.090048      task-clock (msec)         #    0.958 CPUs utilized
            200025      context-switches          #    0.024 M/sec

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v4:
  - Using the correct symbol CONFIG_ARCH_HAS_SCALED_CPUTIME instead of ARCH_HAS_SCALED_CPUTIME
  - Grouped CONFIG_ARCH_HAS_SCALED_CPUTIME related code in dedicated functions to reduce the number of #ifdefs
  - Integrated read_spurr() directly into the related function.
 v3: Rebased following modifications in xmon.c
 v2: added ifdefs in xmon to fix compilation error

 arch/powerpc/Kconfig                  |   2 +-
 arch/powerpc/include/asm/accounting.h |   4 ++
 arch/powerpc/include/asm/cputime.h    |   1 -
 arch/powerpc/kernel/time.c            | 111 +++++++++++++++++++++-------------
 arch/powerpc/xmon/xmon.c              |   4 ++
 5 files changed, 77 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b62a16e2c7cc..735398fd390d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -142,7 +142,7 @@ config PPC
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PMEM_API                if PPC64
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
-	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
+	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC64
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/powerpc/include/asm/accounting.h b/arch/powerpc/include/asm/accounting.h
index 3abcf98ed2e0..c607c5d835cc 100644
--- a/arch/powerpc/include/asm/accounting.h
+++ b/arch/powerpc/include/asm/accounting.h
@@ -15,8 +15,10 @@ struct cpu_accounting_data {
 	/* Accumulated cputime values to flush on ticks*/
 	unsigned long utime;
 	unsigned long stime;
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 	unsigned long utime_scaled;
 	unsigned long stime_scaled;
+#endif
 	unsigned long gtime;
 	unsigned long hardirq_time;
 	unsigned long softirq_time;
@@ -25,8 +27,10 @@ struct cpu_accounting_data {
 	/* Internal counters */
 	unsigned long starttime;	/* TB value snapshot */
 	unsigned long starttime_user;	/* TB value on exit to usermode */
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 	unsigned long startspurr;	/* SPURR value snapshot */
 	unsigned long utime_sspurr;	/* ->user_time when ->startspurr set */
+#endif
 };
 
 #endif
diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index bc4903badb3f..a48c7b5e5cf9 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -62,7 +62,6 @@ static inline void arch_vtime_task_switch(struct task_struct *prev)
 	struct cpu_accounting_data *acct0 = get_accounting(prev);
 
 	acct->starttime = acct0->starttime;
-	acct->startspurr = acct0->startspurr;
 }
 #endif
 
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 70f145e02487..7a9f4e2f22c8 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -171,19 +171,6 @@ static void calc_cputime_factors(void)
 	__cputime_usec_factor = res.result_low;
 }
 
-/*
- * Read the SPURR on systems that have it, otherwise the PURR,
- * or if that doesn't exist return the timebase value passed in.
- */
-static unsigned long read_spurr(unsigned long tb)
-{
-	if (cpu_has_feature(CPU_FTR_SPURR))
-		return mfspr(SPRN_SPURR);
-	if (cpu_has_feature(CPU_FTR_PURR))
-		return mfspr(SPRN_PURR);
-	return tb;
-}
-
 #ifdef CONFIG_PPC_SPLPAR
 
 /*
@@ -277,30 +264,27 @@ static inline u64 calculate_stolen_time(u64 stop_tb)
 
 #endif /* CONFIG_PPC_SPLPAR */
 
-/*
- * Account time for a transition between system, hard irq
- * or soft irq state.
- */
-static unsigned long vtime_delta(struct task_struct *tsk,
-				 unsigned long *stime_scaled,
-				 unsigned long *steal_time)
+static unsigned long vtime_delta_scaled(struct cpu_accounting_data *acct,
+					unsigned long now, unsigned long stime)
 {
-	unsigned long now, nowscaled, deltascaled;
-	unsigned long stime;
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
+	unsigned long nowscaled, deltascaled;
 	unsigned long utime, utime_scaled;
-	struct cpu_accounting_data *acct = get_accounting(tsk);
+	unsigned long stime_scaled;
 
-	WARN_ON_ONCE(!irqs_disabled());
+	/*
+	 * Read the SPURR on systems that have it, otherwise the PURR,
+	 * or if that doesn't exist user the timebase value passed in.
+	 */
+	if (cpu_has_feature(CPU_FTR_SPURR))
+		nowscaled = mfspr(SPRN_SPURR);
+	else if (cpu_has_feature(CPU_FTR_PURR))
+		nowscaled = mfspr(SPRN_PURR);
+	else
+		nowscaled = now;
 
-	now = mftb();
-	nowscaled = read_spurr(now);
-	stime = now - acct->starttime;
-	acct->starttime = now;
 	deltascaled = nowscaled - acct->startspurr;
 	acct->startspurr = nowscaled;
-
-	*steal_time = calculate_stolen_time(now);
-
 	utime = acct->utime - acct->utime_sspurr;
 	acct->utime_sspurr = acct->utime;
 
@@ -314,18 +298,46 @@ static unsigned long vtime_delta(struct task_struct *tsk,
 	 * the user ticks get saved up in paca->user_time_scaled to be
 	 * used by account_process_tick.
 	 */
-	*stime_scaled = stime;
+	stime_scaled = stime;
 	utime_scaled = utime;
 	if (deltascaled != stime + utime) {
 		if (utime) {
-			*stime_scaled = deltascaled * stime / (stime + utime);
-			utime_scaled = deltascaled - *stime_scaled;
+			stime_scaled = deltascaled * stime / (stime + utime);
+			utime_scaled = deltascaled - stime_scaled;
 		} else {
-			*stime_scaled = deltascaled;
+			stime_scaled = deltascaled;
 		}
 	}
 	acct->utime_scaled += utime_scaled;
 
+	return stime_scaled;
+#else
+	return 0;
+#endif
+}
+
+/*
+ * Account time for a transition between system, hard irq
+ * or soft irq state.
+ */
+static unsigned long vtime_delta(struct task_struct *tsk,
+				 unsigned long *stime_scaled,
+				 unsigned long *steal_time)
+{
+	unsigned long now;
+	unsigned long stime;
+	struct cpu_accounting_data *acct = get_accounting(tsk);
+
+	WARN_ON_ONCE(!irqs_disabled());
+
+	now = mftb();
+	stime = now - acct->starttime;
+	acct->starttime = now;
+
+	*stime_scaled = vtime_delta_scaled(acct, now, stime);
+
+	*steal_time = calculate_stolen_time(now);
+
 	return stime;
 }
 
@@ -341,7 +353,9 @@ void vtime_account_system(struct task_struct *tsk)
 
 	if ((tsk->flags & PF_VCPU) && !irq_count()) {
 		acct->gtime += stime;
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 		acct->utime_scaled += stime_scaled;
+#endif
 	} else {
 		if (hardirq_count())
 			acct->hardirq_time += stime;
@@ -350,7 +364,9 @@ void vtime_account_system(struct task_struct *tsk)
 		else
 			acct->stime += stime;
 
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 		acct->stime_scaled += stime_scaled;
+#endif
 	}
 }
 EXPORT_SYMBOL_GPL(vtime_account_system);
@@ -364,6 +380,21 @@ void vtime_account_idle(struct task_struct *tsk)
 	acct->idle_time += stime + steal_time;
 }
 
+static void vtime_flush_scaled(struct task_struct *tsk,
+			       struct cpu_accounting_data *acct)
+{
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
+	if (acct->utime_scaled)
+		tsk->utimescaled += cputime_to_nsecs(acct->utime_scaled);
+	if (acct->stime_scaled)
+		tsk->stimescaled += cputime_to_nsecs(acct->stime_scaled);
+
+	acct->utime_scaled = 0;
+	acct->utime_sspurr = 0;
+	acct->stime_scaled = 0;
+#endif
+}
+
 /*
  * Account the whole cputime accumulated in the paca
  * Must be called with interrupts disabled.
@@ -378,9 +409,6 @@ void vtime_flush(struct task_struct *tsk)
 	if (acct->utime)
 		account_user_time(tsk, cputime_to_nsecs(acct->utime));
 
-	if (acct->utime_scaled)
-		tsk->utimescaled += cputime_to_nsecs(acct->utime_scaled);
-
 	if (acct->gtime)
 		account_guest_time(tsk, cputime_to_nsecs(acct->gtime));
 
@@ -393,8 +421,6 @@ void vtime_flush(struct task_struct *tsk)
 	if (acct->stime)
 		account_system_index_time(tsk, cputime_to_nsecs(acct->stime),
 					  CPUTIME_SYSTEM);
-	if (acct->stime_scaled)
-		tsk->stimescaled += cputime_to_nsecs(acct->stime_scaled);
 
 	if (acct->hardirq_time)
 		account_system_index_time(tsk, cputime_to_nsecs(acct->hardirq_time),
@@ -404,15 +430,14 @@ void vtime_flush(struct task_struct *tsk)
 					  CPUTIME_SOFTIRQ);
 
 	acct->utime = 0;
-	acct->utime_scaled = 0;
-	acct->utime_sspurr = 0;
 	acct->gtime = 0;
 	acct->steal_time = 0;
 	acct->idle_time = 0;
 	acct->stime = 0;
-	acct->stime_scaled = 0;
 	acct->hardirq_time = 0;
 	acct->softirq_time = 0;
+
+	vtime_flush_scaled(tsk, acct);
 }
 
 #else /* ! CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 47166ad2a669..b1e551d40ee1 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2443,11 +2443,15 @@ static void dump_one_paca(int cpu)
 
 	DUMP(p, accounting.utime, "%#-*lx");
 	DUMP(p, accounting.stime, "%#-*lx");
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 	DUMP(p, accounting.utime_scaled, "%#-*lx");
+#endif
 	DUMP(p, accounting.starttime, "%#-*lx");
 	DUMP(p, accounting.starttime_user, "%#-*lx");
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 	DUMP(p, accounting.startspurr, "%#-*lx");
 	DUMP(p, accounting.utime_sspurr, "%#-*lx");
+#endif
 	DUMP(p, accounting.steal_time, "%#-*lx");
 #undef DUMP
 
-- 
2.13.3
