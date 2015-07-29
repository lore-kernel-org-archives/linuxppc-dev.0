Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DD261A1761
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 17:10:41 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DB878140E42
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:10:39 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 12:40:36 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4D84DE007E
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:44:19 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T7A9cG51314874
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:10 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T7A70J001277
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH 8/8] powerpc/xmon: Add some more elements to the existing PACA
 dump list
Date: Wed, 29 Jul 2015 12:40:05 +0530
Message-Id: <1438153805-31828-8-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a set of new elements to the existing PACA dump list
inside an xmon session which can be listed below improving the overall
xmon debug support.

(1) hmi_event_available
(2) dscr_default
(3) vmalloc_sllp
(4) slb_cache_ptr
(5) sprg_vdso
(6) tm_scratch
(7) core_idle_state_ptr
(8) thread_idle_state
(9) thread_mask
(10) slb_shadow
(11) pgd
(12) kernel_pgd
(13) tcd_ptr
(14) mc_kstack
(15) crit_kstack
(16) dbg_kstack
(17) user_time
(18) system_time
(19) user_time_scaled
(20) starttime
(21) starttime_user
(22) startspurr
(23) utime_sspurr
(24) stolen_time

With this patch, a typical xmon PACA dump looks something like this.

paca for cpu 0x0 @ c00000000fdc0000:
 possible             = yes
 present              = yes
 online               = yes
 lock_token           = 0x8000            	(0x8)
 paca_index           = 0x0               	(0xa)
 kernel_toc           = 0xc000000000e79300	(0x10)
 kernelbase           = 0xc000000000000000	(0x18)
 kernel_msr           = 0xb000000000001032	(0x20)
 emergency_sp         = 0xc00000003fff0000	(0x28)
 mc_emergency_sp      = 0xc00000003ffec000	(0x2e0)
 in_mce               = 0x0               	(0x2e8)
 hmi_event_available  = 0x0               	(0x2ea)
 data_offset          = 0xfa9f0000        	(0x30)
 hw_cpu_id            = 0x0               	(0x38)
 cpu_start            = 0x1               	(0x3a)
 kexec_state          = 0x0               	(0x3b)
 slb_shadow[0]:       = 0xc000000008000000 0x40016e7779000510
 slb_shadow[1]:       = 0xd000000008000001 0x400142add1000510
 dscr_default         = 0x0               	(0x58)
 vmalloc_sllp         = 0x510             	(0x1b8)
 slb_cache_ptr        = 0x3               	(0x1ba)
 slb_cache[0]:        = 0x3f000
 slb_cache[1]:        = 0x1
 slb_cache[2]:        = 0x1000
 __current            = 0xc0000000a7406b70	(0x290)
 kstack               = 0xc0000000a750fe30	(0x298)
 stab_rr              = 0x11              	(0x2a0)
 saved_r1             = 0xc0000000a750f360	(0x2a8)
 trap_save            = 0x0               	(0x2b8)
 soft_enabled         = 0x0               	(0x2ba)
 irq_happened         = 0x1               	(0x2bb)
 io_sync              = 0x0               	(0x2bc)
 irq_work_pending     = 0x0               	(0x2bd)
 nap_state_lost       = 0x0               	(0x2be)
 sprg_vdso            = 0x0               	(0x2c0)
 tm_scratch           = 0x800000010280f032	(0x2c8)
 core_idle_state_ptr  = (null)            	(0x2d0)
 thread_idle_state    = 0x0               	(0x2d8)
 thread_mask          = 0x0               	(0x2d9)
 subcore_sibling_mask = 0x0               	(0x2da)
 user_time            = 0x18895           	(0x2f0)
 system_time          = 0x11dc2           	(0x2f8)
 user_time_scaled     = 0x0               	(0x300)
 starttime            = 0xe64688b4688a    	(0x308)
 starttime_user       = 0xe64688b466d1    	(0x310)
 startspurr           = 0x1a79afea8       	(0x318)
 utime_sspurr         = 0x0               	(0x320)
 stolen_time          = 0x0               	(0x328)

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 57 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index bc1b066a..1e67c8b 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2073,6 +2073,9 @@ static void xmon_rawdump (unsigned long adrs, long ndump)
 static void dump_one_paca(int cpu)
 {
 	struct paca_struct *p;
+#ifdef CONFIG_PPC_STD_MMU_64
+	int i = 0;
+#endif
 
 	if (setjmp(bus_error_jmp) != 0) {
 		printf("*** Error dumping paca for cpu 0x%x!\n", cpu);
@@ -2086,12 +2089,12 @@ static void dump_one_paca(int cpu)
 
 	printf("paca for cpu 0x%x @ %p:\n", cpu, p);
 
-	printf(" %-*s = %s\n", 16, "possible", cpu_possible(cpu) ? "yes" : "no");
-	printf(" %-*s = %s\n", 16, "present", cpu_present(cpu) ? "yes" : "no");
-	printf(" %-*s = %s\n", 16, "online", cpu_online(cpu) ? "yes" : "no");
+	printf(" %-*s = %s\n", 20, "possible", cpu_possible(cpu) ? "yes" : "no");
+	printf(" %-*s = %s\n", 20, "present", cpu_present(cpu) ? "yes" : "no");
+	printf(" %-*s = %s\n", 20, "online", cpu_online(cpu) ? "yes" : "no");
 
 #define DUMP(paca, name, format) \
-	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 16, #name, 18, paca->name, \
+	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
 		offsetof(struct paca_struct, name));
 
 	DUMP(p, lock_token, "x");
@@ -2103,11 +2106,37 @@ static void dump_one_paca(int cpu)
 #ifdef CONFIG_PPC_BOOK3S_64
 	DUMP(p, mc_emergency_sp, "p");
 	DUMP(p, in_mce, "x");
+	DUMP(p, hmi_event_available, "x");
 #endif
 	DUMP(p, data_offset, "lx");
 	DUMP(p, hw_cpu_id, "x");
 	DUMP(p, cpu_start, "x");
 	DUMP(p, kexec_state, "x");
+#ifdef CONFIG_PPC_STD_MMU_64
+	for (i = 0; i < SLB_NUM_BOLTED; i++) {
+		if (p->slb_shadow_ptr->save_area[i].esid ||
+				p->slb_shadow_ptr->save_area[i].vsid) {
+			printf(" slb_shadow[%d]:       = 0x%lx 0x%lx\n", i,
+					p->slb_shadow_ptr->save_area[i].esid,
+					p->slb_shadow_ptr->save_area[i].vsid);
+		}
+	}
+#endif
+	DUMP(p, dscr_default, "llx");
+#ifdef CONFIG_PPC_STD_MMU_64
+	DUMP(p, vmalloc_sllp, "x");
+	DUMP(p, slb_cache_ptr, "x");
+	for (i = 0; i < p->slb_cache_ptr; i++)
+		printf(" slb_cache[%d]:        = 0x%lx\n", i, p->slb_cache[i]);
+#endif
+#ifdef CONFIG_PPC_BOOK3E
+	DUMP(p, pgd, "p");
+	DUMP(p, kernel_pgd, "p");
+	DUMP(p, tcd_ptr, "p");
+	DUMP(p, mc_kstack, "p");
+	DUMP(p, crit_kstack, "p");
+	DUMP(p, dbg_kstack, "p");
+#endif
 	DUMP(p, __current, "p");
 	DUMP(p, kstack, "lx");
 	DUMP(p, stab_rr, "lx");
@@ -2118,7 +2147,27 @@ static void dump_one_paca(int cpu)
 	DUMP(p, io_sync, "x");
 	DUMP(p, irq_work_pending, "x");
 	DUMP(p, nap_state_lost, "x");
+	DUMP(p, sprg_vdso, "llx");
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	DUMP(p, tm_scratch, "llx");
+#endif
+
+#ifdef CONFIG_PPC_POWERNV
+	DUMP(p, core_idle_state_ptr, "p");
+	DUMP(p, thread_idle_state, "x");
+	DUMP(p, thread_mask, "x");
+	DUMP(p, subcore_sibling_mask, "x");
+#endif
 
+	DUMP(p, user_time, "llx");
+	DUMP(p, system_time, "llx");
+	DUMP(p, user_time_scaled, "llx");
+	DUMP(p, starttime, "llx");
+	DUMP(p, starttime_user, "llx");
+	DUMP(p, startspurr, "llx");
+	DUMP(p, utime_sspurr, "llx");
+	DUMP(p, stolen_time, "llx");
 #undef DUMP
 
 	catch_memory_errors = 0;
-- 
2.1.0
