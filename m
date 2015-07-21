Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47E291A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 16:59:07 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9A87A140E01
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:59:06 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 12:29:04 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 28642125806A
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:31:59 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6L6wwR256492170
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6L6wwPv007433
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:58 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, mpe@ellerman.id.au
Subject: [RFC 8/8] powerpc/xmon: Add some more elements to the existing PACA
 dump list
Date: Tue, 21 Jul 2015 12:28:46 +0530
Message-Id: <1437461926-8908-8-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>

This patch adds some more elements to the existing PACA dump list
inside a xmon session which can be listed here.

	- hmi_event_available
	- dscr_default
	- vmalloc_sllp
	- slb_cache_ptr
	- sprg_vdso
	- tm_scratch
	- core_idle_state_ptr
	- thread_idle_state
	- thread_mask

With this patch, a typical xmon PACA dump looks something like this.

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
 dscr_default         = 0x0               	(0x58)
 vmalloc_sllp         = 0x510             	(0x1b8)
 slb_cache_ptr        = 0x3               	(0x1ba)
 slb_cache[0]:        = 0x3f000
 slb_cache[1]:        = 0x1
 slb_cache[2]:        = 0x1000
 __current            = 0xc00000009ce96620	(0x290)
 kstack               = 0xc00000009cf2be30	(0x298)
 stab_rr              = 0x8               	(0x2a0)
 saved_r1             = 0xc00000009cf2b360	(0x2a8)
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

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 1798e21..bc42f6e 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2073,6 +2073,7 @@ static void xmon_rawdump (unsigned long adrs, long ndump)
 static void dump_one_paca(int cpu)
 {
 	struct paca_struct *p;
+	int i;
 
 	if (setjmp(bus_error_jmp) != 0) {
 		printf("*** Error dumping paca for cpu 0x%x!\n", cpu);
@@ -2086,12 +2087,12 @@ static void dump_one_paca(int cpu)
 
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
@@ -2103,11 +2104,17 @@ static void dump_one_paca(int cpu)
 #ifdef CONFIG_PPC_BOOK3S_64
 	DUMP(p, mc_emergency_sp, "p");
 	DUMP(p, in_mce, "x");
+	DUMP(p, hmi_event_available, "x");
 #endif
 	DUMP(p, data_offset, "lx");
 	DUMP(p, hw_cpu_id, "x");
 	DUMP(p, cpu_start, "x");
 	DUMP(p, kexec_state, "x");
+	DUMP(p, dscr_default, "llx");
+	DUMP(p, vmalloc_sllp, "x");
+	DUMP(p, slb_cache_ptr, "x");
+	for (i = 0; i < p->slb_cache_ptr; i++)
+		printf(" slb_cache[%d]:        = 0x%lx\n", i, p->slb_cache[i]);
 	DUMP(p, __current, "p");
 	DUMP(p, kstack, "lx");
 	DUMP(p, stab_rr, "lx");
@@ -2118,6 +2125,18 @@ static void dump_one_paca(int cpu)
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
 
 #undef DUMP
 
-- 
2.1.0
