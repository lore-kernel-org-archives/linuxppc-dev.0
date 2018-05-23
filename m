Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rW4c2k3jzF0wk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 21:48:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: malat@debian.org
Subject: [PATCH 1/2] powerpc/xmon: Specify the full format in DUMP() macro
Date: Wed, 23 May 2018 21:48:36 +1000
Message-Id: <20180523114837.6980-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In dump_one_paca() the DUMP macro unconditionally prepends '#' to the
printf format specifier. In most cases we're using either 'x' or 'lx'
etc. and that is OK. But for 'p' and other formats using '#' is
actually undefined, and once we enable printf() checking for
xmon_printf() we will get warnings from the compiler.

So just have each usage specify the full format, that way we can omit
'#' when it's inappropriate.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 102 +++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 064e70a59b47..a81aa3afd87e 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2349,27 +2349,27 @@ static void dump_one_paca(int cpu)
 	printf(" %-*s = %s\n", 20, "present", cpu_present(cpu) ? "yes" : "no");
 	printf(" %-*s = %s\n", 20, "online", cpu_online(cpu) ? "yes" : "no");
 
-#define DUMP(paca, name, format) \
-	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
+#define DUMP(paca, name, format)				\
+	printf(" %-*s = "format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
 		offsetof(struct paca_struct, name));
 
-	DUMP(p, lock_token, "x");
-	DUMP(p, paca_index, "x");
-	DUMP(p, kernel_toc, "llx");
-	DUMP(p, kernelbase, "llx");
-	DUMP(p, kernel_msr, "llx");
-	DUMP(p, emergency_sp, "px");
+	DUMP(p, lock_token, "%#-*x");
+	DUMP(p, paca_index, "%#-*x");
+	DUMP(p, kernel_toc, "%#-*llx");
+	DUMP(p, kernelbase, "%#-*llx");
+	DUMP(p, kernel_msr, "%#-*llx");
+	DUMP(p, emergency_sp, "%-*px");
 #ifdef CONFIG_PPC_BOOK3S_64
-	DUMP(p, nmi_emergency_sp, "px");
-	DUMP(p, mc_emergency_sp, "px");
-	DUMP(p, in_nmi, "x");
-	DUMP(p, in_mce, "x");
-	DUMP(p, hmi_event_available, "x");
+	DUMP(p, nmi_emergency_sp, "%-*px");
+	DUMP(p, mc_emergency_sp, "%-*px");
+	DUMP(p, in_nmi, "%#-*x");
+	DUMP(p, in_mce, "%#-*x");
+	DUMP(p, hmi_event_available, "%#-*x");
 #endif
-	DUMP(p, data_offset, "llx");
-	DUMP(p, hw_cpu_id, "x");
-	DUMP(p, cpu_start, "x");
-	DUMP(p, kexec_state, "x");
+	DUMP(p, data_offset, "%#-*llx");
+	DUMP(p, hw_cpu_id, "%#-*x");
+	DUMP(p, cpu_start, "%#-*x");
+	DUMP(p, kexec_state, "%#-*x");
 #ifdef CONFIG_PPC_BOOK3S_64
 	for (i = 0; i < SLB_NUM_BOLTED; i++) {
 		u64 esid, vsid;
@@ -2385,54 +2385,54 @@ static void dump_one_paca(int cpu)
 				i, esid, vsid);
 		}
 	}
-	DUMP(p, vmalloc_sllp, "x");
-	DUMP(p, slb_cache_ptr, "x");
+	DUMP(p, vmalloc_sllp, "%#-*x");
+	DUMP(p, slb_cache_ptr, "%#-*x");
 	for (i = 0; i < SLB_CACHE_ENTRIES; i++)
 		printf(" slb_cache[%d]:        = 0x%016x\n", i, p->slb_cache[i]);
 
-	DUMP(p, rfi_flush_fallback_area, "px");
+	DUMP(p, rfi_flush_fallback_area, "%-*px");
 #endif
-	DUMP(p, dscr_default, "llx");
+	DUMP(p, dscr_default, "%#-*llx");
 #ifdef CONFIG_PPC_BOOK3E
-	DUMP(p, pgd, "px");
-	DUMP(p, kernel_pgd, "px");
-	DUMP(p, tcd_ptr, "px");
-	DUMP(p, mc_kstack, "px");
-	DUMP(p, crit_kstack, "px");
-	DUMP(p, dbg_kstack, "px");
+	DUMP(p, pgd, "%-*px");
+	DUMP(p, kernel_pgd, "%-*px");
+	DUMP(p, tcd_ptr, "%-*px");
+	DUMP(p, mc_kstack, "%-*px");
+	DUMP(p, crit_kstack, "%-*px");
+	DUMP(p, dbg_kstack, "%-*px");
 #endif
-	DUMP(p, __current, "px");
-	DUMP(p, kstack, "llx");
+	DUMP(p, __current, "%-*px");
+	DUMP(p, kstack, "%#-*llx");
 	printf(" kstack_base          = 0x%016llx\n", p->kstack & ~(THREAD_SIZE - 1));
-	DUMP(p, stab_rr, "llx");
-	DUMP(p, saved_r1, "llx");
-	DUMP(p, trap_save, "x");
-	DUMP(p, irq_soft_mask, "x");
-	DUMP(p, irq_happened, "x");
-	DUMP(p, io_sync, "x");
-	DUMP(p, irq_work_pending, "x");
-	DUMP(p, nap_state_lost, "x");
-	DUMP(p, sprg_vdso, "llx");
+	DUMP(p, stab_rr, "%#-*llx");
+	DUMP(p, saved_r1, "%#-*llx");
+	DUMP(p, trap_save, "%#-*x");
+	DUMP(p, irq_soft_mask, "%#-*x");
+	DUMP(p, irq_happened, "%#-*x");
+	DUMP(p, io_sync, "%#-*x");
+	DUMP(p, irq_work_pending, "%#-*x");
+	DUMP(p, nap_state_lost, "%#-*x");
+	DUMP(p, sprg_vdso, "%#-*llx");
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	DUMP(p, tm_scratch, "llx");
+	DUMP(p, tm_scratch, "%#-*llx");
 #endif
 
 #ifdef CONFIG_PPC_POWERNV
-	DUMP(p, core_idle_state_ptr, "px");
-	DUMP(p, thread_idle_state, "x");
-	DUMP(p, thread_mask, "x");
-	DUMP(p, subcore_sibling_mask, "x");
+	DUMP(p, core_idle_state_ptr, "%-*px");
+	DUMP(p, thread_idle_state, "%#-*x");
+	DUMP(p, thread_mask, "%#-*x");
+	DUMP(p, subcore_sibling_mask, "%#-*x");
 #endif
 
-	DUMP(p, accounting.utime, "lx");
-	DUMP(p, accounting.stime, "lx");
-	DUMP(p, accounting.utime_scaled, "lx");
-	DUMP(p, accounting.starttime, "lx");
-	DUMP(p, accounting.starttime_user, "lx");
-	DUMP(p, accounting.startspurr, "lx");
-	DUMP(p, accounting.utime_sspurr, "lx");
-	DUMP(p, accounting.steal_time, "lx");
+	DUMP(p, accounting.utime, "%#-*lx");
+	DUMP(p, accounting.stime, "%#-*lx");
+	DUMP(p, accounting.utime_scaled, "%#-*lx");
+	DUMP(p, accounting.starttime, "%#-*lx");
+	DUMP(p, accounting.starttime_user, "%#-*lx");
+	DUMP(p, accounting.startspurr, "%#-*lx");
+	DUMP(p, accounting.utime_sspurr, "%#-*lx");
+	DUMP(p, accounting.steal_time, "%#-*lx");
 #undef DUMP
 
 	catch_memory_errors = 0;
-- 
2.14.1
