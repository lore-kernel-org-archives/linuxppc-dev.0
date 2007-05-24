Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] fix stolen time for SMT without LPAR
Date: Thu, 24 May 2007 23:33:22 +1000
Message-ID: <12635.1180013602@neuling.org>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For POWERPC, stolen time accounts for cycles lost to the hypervisor or
PURR cycles attributed to the other SMT thread.  Hence, when a PURR is
available, we should still calculate stolen time, irrespective of being
virtualised.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Kudos to sfr for realizing the problem here.

 arch/powerpc/kernel/time.c |    6 ++++--
 include/asm-powerpc/time.h |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/time.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/time.c
@@ -244,7 +244,8 @@ void snapshot_timebases(void)
 {
 	int cpu;
 
-	if (!cpu_has_feature(CPU_FTR_PURR))
+	if (!cpu_has_feature(CPU_FTR_PURR) &&
+	    !firmware_has_feature(FW_FEATURE_SPLPAR))
 		return;
 	for_each_possible_cpu(cpu)
 		spin_lock_init(&per_cpu(cpu_purr_data, cpu).lock);
@@ -257,7 +258,8 @@ void calculate_steal_time(void)
 	s64 stolen;
 	struct cpu_purr_data *pme;
 
-	if (!cpu_has_feature(CPU_FTR_PURR))
+	if (!cpu_has_feature(CPU_FTR_PURR) &&
+	    !firmware_has_feature(FW_FEATURE_SPLPAR))
 		return;
 	pme = &per_cpu(cpu_purr_data, smp_processor_id());
 	if (!pme->initialized)
Index: linux-2.6-ozlabs/include/asm-powerpc/time.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/time.h
+++ linux-2.6-ozlabs/include/asm-powerpc/time.h
@@ -232,7 +232,7 @@ extern void account_process_vtime(struct
 #define account_process_vtime(tsk)		do { } while (0)
 #endif
 
-#if defined(CONFIG_VIRT_CPU_ACCOUNTING) && defined(CONFIG_PPC_SPLPAR)
+#if defined(CONFIG_VIRT_CPU_ACCOUNTING)
 extern void calculate_steal_time(void);
 extern void snapshot_timebases(void);
 #else
