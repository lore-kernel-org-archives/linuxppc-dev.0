Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405rpf1WbkzF1p0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 00:52:40 +1100 (AEDT)
Message-Id: <d253b71638e2af1cac9eb804c935810d0e021841.1521639065.git.christophe.leroy@c-s.fr>
In-Reply-To: <fbbdc0bcff276190ea8619b3070d971f2ca76abd.1521639065.git.christophe.leroy@c-s.fr>
References: <fbbdc0bcff276190ea8619b3070d971f2ca76abd.1521639065.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  2/2] powerpc/time: Only set ARCH_HAS_SCALED_CPUTIME on PPC64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 21 Mar 2018 14:52:36 +0100 (CET)
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
00000114 l     F .text	000000a8 vtime_delta
000004c0 g     F .text	00000100 vtime_account_system
000005c0 g     F .text	00000048 vtime_account_idle

After:
(vtime_delta gets inlined in the two functions)
00000418 g     F .text	000000a0 vtime_account_system
000004b8 g     F .text	00000054 vtime_account_idle

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                  |  2 +-
 arch/powerpc/include/asm/accounting.h |  4 ++++
 arch/powerpc/include/asm/cputime.h    |  2 ++
 arch/powerpc/kernel/time.c            | 29 +++++++++++++++++++++++------
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0c76d93d5da5..8c9f54779ff1 100644
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
index 3abcf98ed2e0..f1096d4cc658 100644
--- a/arch/powerpc/include/asm/accounting.h
+++ b/arch/powerpc/include/asm/accounting.h
@@ -15,8 +15,10 @@ struct cpu_accounting_data {
 	/* Accumulated cputime values to flush on ticks*/
 	unsigned long utime;
 	unsigned long stime;
+#ifdef ARCH_HAS_SCALED_CPUTIME
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
+#ifdef ARCH_HAS_SCALED_CPUTIME
 	unsigned long startspurr;	/* SPURR value snapshot */
 	unsigned long utime_sspurr;	/* ->user_time when ->startspurr set */
+#endif
 };
 
 #endif
diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 36345341dd70..c11d4fd27028 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -61,7 +61,9 @@ static inline void arch_vtime_task_switch(struct task_struct *prev)
 	struct cpu_accounting_data *acct = get_accounting(current);
 
 	acct->starttime = get_accounting(prev)->starttime;
+#ifdef ARCH_HAS_SCALED_CPUTIME
 	acct->startspurr = get_accounting(prev)->startspurr;
+#endif
 }
 #endif
 
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index aa6aa5d4a60c..09e5eb9f0e81 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -175,6 +175,7 @@ static void calc_cputime_factors(void)
  * Read the SPURR on systems that have it, otherwise the PURR,
  * or if that doesn't exist return the timebase value passed in.
  */
+#ifdef ARCH_HAS_SCALED_CPUTIME
 static unsigned long read_spurr(unsigned long tb)
 {
 	if (cpu_has_feature(CPU_FTR_SPURR))
@@ -183,6 +184,7 @@ static unsigned long read_spurr(unsigned long tb)
 		return mfspr(SPRN_PURR);
 	return tb;
 }
+#endif
 
 #ifdef CONFIG_PPC_SPLPAR
 
@@ -282,22 +284,28 @@ static unsigned long vtime_delta(struct task_struct *tsk,
 				 unsigned long *stime_scaled,
 				 unsigned long *steal_time)
 {
-	unsigned long now, nowscaled, deltascaled;
+	unsigned long now;
 	unsigned long stime;
+#ifdef ARCH_HAS_SCALED_CPUTIME
+	unsigned long nowscaled, deltascaled;
 	unsigned long utime, utime_scaled;
+#endif
 	struct cpu_accounting_data *acct = get_accounting(tsk);
 
 	WARN_ON_ONCE(!irqs_disabled());
 
 	now = mftb();
+#ifdef ARCH_HAS_SCALED_CPUTIME
 	nowscaled = read_spurr(now);
+#endif
 	stime = now - acct->starttime;
 	acct->starttime = now;
-	deltascaled = nowscaled - acct->startspurr;
-	acct->startspurr = nowscaled;
 
 	*steal_time = calculate_stolen_time(now);
 
+#ifdef ARCH_HAS_SCALED_CPUTIME
+	deltascaled = nowscaled - acct->startspurr;
+	acct->startspurr = nowscaled;
 	utime = acct->utime - acct->utime_sspurr;
 	acct->utime_sspurr = acct->utime;
 
@@ -322,6 +330,7 @@ static unsigned long vtime_delta(struct task_struct *tsk,
 		}
 	}
 	acct->utime_scaled += utime_scaled;
+#endif
 
 	return stime;
 }
@@ -338,7 +347,9 @@ void vtime_account_system(struct task_struct *tsk)
 
 	if ((tsk->flags & PF_VCPU) && !irq_count()) {
 		acct->gtime += stime;
+#ifdef ARCH_HAS_SCALED_CPUTIME
 		acct->utime_scaled += stime_scaled;
+#endif
 	} else {
 		if (hardirq_count())
 			acct->hardirq_time += stime;
@@ -347,7 +358,9 @@ void vtime_account_system(struct task_struct *tsk)
 		else
 			acct->stime += stime;
 
+#ifdef ARCH_HAS_SCALED_CPUTIME
 		acct->stime_scaled += stime_scaled;
+#endif
 	}
 }
 EXPORT_SYMBOL_GPL(vtime_account_system);
@@ -375,8 +388,12 @@ void vtime_flush(struct task_struct *tsk)
 	if (acct->utime)
 		account_user_time(tsk, cputime_to_nsecs(acct->utime));
 
+#ifdef ARCH_HAS_SCALED_CPUTIME
 	if (acct->utime_scaled)
 		tsk->utimescaled += cputime_to_nsecs(acct->utime_scaled);
+	if (acct->stime_scaled)
+		tsk->stimescaled += cputime_to_nsecs(acct->stime_scaled);
+#endif
 
 	if (acct->gtime)
 		account_guest_time(tsk, cputime_to_nsecs(acct->gtime));
@@ -390,8 +407,6 @@ void vtime_flush(struct task_struct *tsk)
 	if (acct->stime)
 		account_system_index_time(tsk, cputime_to_nsecs(acct->stime),
 					  CPUTIME_SYSTEM);
-	if (acct->stime_scaled)
-		tsk->stimescaled += cputime_to_nsecs(acct->stime_scaled);
 
 	if (acct->hardirq_time)
 		account_system_index_time(tsk, cputime_to_nsecs(acct->hardirq_time),
@@ -401,13 +416,15 @@ void vtime_flush(struct task_struct *tsk)
 					  CPUTIME_SOFTIRQ);
 
 	acct->utime = 0;
+#ifdef ARCH_HAS_SCALED_CPUTIME
 	acct->utime_scaled = 0;
 	acct->utime_sspurr = 0;
+	acct->stime_scaled = 0;
+#endif
 	acct->gtime = 0;
 	acct->steal_time = 0;
 	acct->idle_time = 0;
 	acct->stime = 0;
-	acct->stime_scaled = 0;
 	acct->hardirq_time = 0;
 	acct->softirq_time = 0;
 }
-- 
2.13.3
