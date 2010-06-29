Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Peter Zijlstra <peterz@infradead.org>
MIME-Version: 1.0
Subject: [PATCH] sched: fix spelling of sibling
Date: Tue, 29 Jun 2010 12:02:01 +1000
Message-ID: <15249.1277776921@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No logic changes, only spelling.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/process.c |    2 +-
 include/linux/topology.h      |    2 +-
 kernel/sched_fair.c           |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-tip/arch/powerpc/kernel/process.c
===================================================================
--- linux-tip.orig/arch/powerpc/kernel/process.c
+++ linux-tip/arch/powerpc/kernel/process.c
@@ -1270,7 +1270,7 @@ unsigned long randomize_et_dyn(unsigned 
 }
 
 #ifdef CONFIG_SMP
-int arch_sd_sibiling_asym_packing(void)
+int arch_sd_sibling_asym_packing(void)
 {
 	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
 		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
Index: linux-tip/include/linux/topology.h
===================================================================
--- linux-tip.orig/include/linux/topology.h
+++ linux-tip/include/linux/topology.h
@@ -103,7 +103,7 @@ int arch_update_cpu_topology(void);
 				| 1*SD_SHARE_PKG_RESOURCES		\
 				| 0*SD_SERIALIZE			\
 				| 0*SD_PREFER_SIBLING			\
-				| arch_sd_sibiling_asym_packing()	\
+				| arch_sd_sibling_asym_packing()	\
 				,					\
 	.last_balance		= jiffies,				\
 	.balance_interval	= 1,					\
Index: linux-tip/kernel/sched_fair.c
===================================================================
--- linux-tip.orig/kernel/sched_fair.c
+++ linux-tip/kernel/sched_fair.c
@@ -2567,7 +2567,7 @@ static inline void update_sd_lb_stats(st
 	} while (sg != sd->groups);
 }
 
-int __weak arch_sd_sibiling_asym_packing(void)
+int __weak arch_sd_sibling_asym_packing(void)
 {
        return 0*SD_ASYM_PACKING;
 }
