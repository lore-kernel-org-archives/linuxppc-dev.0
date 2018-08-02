Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41h2Vz4mZkzF1pk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 17:54:03 +1000 (AEST)
Message-Id: <314adac272f763d915252f72f30f258ee93aaab5.1533151550.git.christophe.leroy@c-s.fr>
In-Reply-To: <af8fe0a5bebd1745ceec07813fa55f1569930f2b.1533151550.git.christophe.leroy@c-s.fr>
References: <af8fe0a5bebd1745ceec07813fa55f1569930f2b.1533151550.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 2/3] powerpc/time: Only set CONFIG_ARCH_HAS_SCALED_CPUTIME
 on PPC64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  2 Aug 2018 07:53:59 +0000 (UTC)
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
(vtime_delta gets inlined inside the two functions)
000001d8 g     F .text	000000a0 vtime_account_system
00000278 g     F .text	00000038 vtime_account_idle

In terms of performance, we also get approximatly 7% improvement on
task switch. The following small benchmark app is run with perf stat:

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

 Performance counter stats for 'chrt -f 98 ./sched 100000' (50 runs):

       8228.476465      task-clock (msec)         #    0.954 CPUs utilized            ( +-  0.23% )
            200004      context-switches          #    0.024 M/sec                    ( +-  0.00% )

After the patch:

 Performance counter stats for 'chrt -f 98 ./sched 100000' (50 runs):

       7649.070444      task-clock (msec)         #    0.955 CPUs utilized            ( +-  0.27% )
            200004      context-switches          #    0.026 M/sec                    ( +-  0.00% )

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v5: New (previous patch splitted in two parts)

 arch/powerpc/Kconfig                  |  2 +-
 arch/powerpc/include/asm/accounting.h |  4 ++++
 arch/powerpc/include/asm/cputime.h    |  1 -
 arch/powerpc/kernel/time.c            | 12 ++++++++++--
 arch/powerpc/xmon/xmon.c              |  4 ++++
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5eb4d969afbf..1f5ce708a650 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -137,7 +137,7 @@ config PPC
 	select ARCH_HAS_PMEM_API                if PPC64
 	select ARCH_HAS_PTE_SPECIAL
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
index 133672744b2e..ae73dc8da2d4 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -61,7 +61,6 @@ static inline void arch_vtime_task_switch(struct task_struct *prev)
 	struct cpu_accounting_data *acct0 = get_accounting(prev);
 
 	acct->starttime = acct0->starttime;
-	acct->startspurr = acct0->startspurr;
 }
 #endif
 
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 6196bd7393a3..3b03731221c1 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -175,7 +175,7 @@ static void calc_cputime_factors(void)
  * Read the SPURR on systems that have it, otherwise the PURR,
  * or if that doesn't exist return the timebase value passed in.
  */
-static unsigned long read_spurr(unsigned long tb)
+static inline unsigned long read_spurr(unsigned long tb)
 {
 	if (cpu_has_feature(CPU_FTR_SPURR))
 		return mfspr(SPRN_SPURR);
@@ -284,7 +284,8 @@ static inline u64 calculate_stolen_time(u64 stop_tb)
 static unsigned long vtime_delta_scaled(struct cpu_accounting_data *acct,
 					unsigned long now, unsigned long stime)
 {
-	unsigned long stime_scaled;
+	unsigned long stime_scaled = 0;
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 	unsigned long nowscaled, deltascaled;
 	unsigned long utime, utime_scaled;
 
@@ -315,6 +316,7 @@ static unsigned long vtime_delta_scaled(struct cpu_accounting_data *acct,
 		}
 	}
 	acct->utime_scaled += utime_scaled;
+#endif
 
 	return stime_scaled;
 }
@@ -351,7 +353,9 @@ void vtime_account_system(struct task_struct *tsk)
 
 	if ((tsk->flags & PF_VCPU) && !irq_count()) {
 		acct->gtime += stime;
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 		acct->utime_scaled += stime_scaled;
+#endif
 	} else {
 		if (hardirq_count())
 			acct->hardirq_time += stime;
@@ -360,7 +364,9 @@ void vtime_account_system(struct task_struct *tsk)
 		else
 			acct->stime += stime;
 
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 		acct->stime_scaled += stime_scaled;
+#endif
 	}
 }
 EXPORT_SYMBOL_GPL(vtime_account_system);
@@ -377,6 +383,7 @@ void vtime_account_idle(struct task_struct *tsk)
 static void vtime_flush_scaled(struct task_struct *tsk,
 			       struct cpu_accounting_data *acct)
 {
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 	if (acct->utime_scaled)
 		tsk->utimescaled += cputime_to_nsecs(acct->utime_scaled);
 	if (acct->stime_scaled)
@@ -385,6 +392,7 @@ static void vtime_flush_scaled(struct task_struct *tsk,
 	acct->utime_scaled = 0;
 	acct->utime_sspurr = 0;
 	acct->stime_scaled = 0;
+#endif
 }
 
 /*
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index c7324e8469ee..cb7d1ce029c6 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2442,11 +2442,15 @@ static void dump_one_paca(int cpu)
 
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
