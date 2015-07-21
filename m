Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 885171A0186
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 16:59:10 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5F013140E1A
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:59:08 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 12:29:07 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 12DA83940048
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:29:01 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6L6wwEq55246926
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6L6wwr1007395
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:58 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, mpe@ellerman.id.au
Subject: [RFC 2/8] powerpc/slb: Rename all the 'entry' occurrences to 'slot'
Date: Tue, 21 Jul 2015 12:28:40 +0530
Message-Id: <1437461926-8908-2-git-send-email-khandual@linux.vnet.ibm.com>
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

These are essentially SLB individual slots what we are dealing with
in these functions. Usage of both 'entry' and 'slot' synonyms makes
it real confusing sometimes. This patch makes it uniform across the
file by replacing all those 'entry's with 'slot's.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 62fafb3..3842a54 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -55,39 +55,39 @@ static inline unsigned long mk_vsid_data(unsigned long ea, int ssize,
 
 static inline void slb_shadow_update(unsigned long ea, int ssize,
 				     unsigned long flags,
-				     unsigned long entry)
+				     unsigned long slot)
 {
 	/*
-	 * Clear the ESID first so the entry is not valid while we are
+	 * Clear the ESID first so the slot is not valid while we are
 	 * updating it.  No write barriers are needed here, provided
 	 * we only update the current CPU's SLB shadow buffer.
 	 */
-	get_slb_shadow()->save_area[entry].esid = 0;
-	get_slb_shadow()->save_area[entry].vsid =
+	get_slb_shadow()->save_area[slot].esid = 0;
+	get_slb_shadow()->save_area[slot].vsid =
 				cpu_to_be64(mk_vsid_data(ea, ssize, flags));
-	get_slb_shadow()->save_area[entry].esid =
-				cpu_to_be64(mk_esid_data(ea, ssize, entry));
+	get_slb_shadow()->save_area[slot].esid =
+				cpu_to_be64(mk_esid_data(ea, ssize, slot));
 }
 
-static inline void slb_shadow_clear(unsigned long entry)
+static inline void slb_shadow_clear(unsigned long slot)
 {
-	get_slb_shadow()->save_area[entry].esid = 0;
+	get_slb_shadow()->save_area[slot].esid = 0;
 }
 
 static inline void create_shadowed_slbe(unsigned long ea, int ssize,
 					unsigned long flags,
-					unsigned long entry)
+					unsigned long slot)
 {
 	/*
 	 * Updating the shadow buffer before writing the SLB ensures
-	 * we don't get a stale entry here if we get preempted by PHYP
+	 * we don't get a stale slot here if we get preempted by PHYP
 	 * between these two statements.
 	 */
-	slb_shadow_update(ea, ssize, flags, entry);
+	slb_shadow_update(ea, ssize, flags, slot);
 
 	asm volatile("slbmte  %0,%1" :
 		     : "r" (mk_vsid_data(ea, ssize, flags)),
-		       "r" (mk_esid_data(ea, ssize, entry))
+		       "r" (mk_esid_data(ea, ssize, slot))
 		     : "memory" );
 }
 
@@ -109,7 +109,7 @@ static void __slb_flush_and_rebolt(void)
 		ksp_vsid_data = 0;
 		slb_shadow_clear(2);
 	} else {
-		/* Update stack entry; others don't change */
+		/* Update stack slot; others don't change */
 		slb_shadow_update(get_paca()->kstack, mmu_kernel_ssize, lflags, 2);
 		ksp_vsid_data =
 			be64_to_cpu(get_slb_shadow()->save_area[2].vsid);
@@ -313,13 +313,12 @@ void slb_initialize(void)
 	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
 	asm volatile("isync; slbia; isync":::"memory");
 	create_shadowed_slbe(PAGE_OFFSET, mmu_kernel_ssize, lflags, 0);
-
 	create_shadowed_slbe(VMALLOC_START, mmu_kernel_ssize, vflags, 1);
 
 	/* For the boot cpu, we're running on the stack in init_thread_union,
 	 * which is in the first segment of the linear mapping, and also
 	 * get_paca()->kstack hasn't been initialized yet.
-	 * For secondary cpus, we need to bolt the kernel stack entry now.
+	 * For secondary cpus, we need to bolt the kernel stack slot now.
 	 */
 	slb_shadow_clear(2);
 	if (raw_smp_processor_id() != boot_cpuid &&
-- 
2.1.0
