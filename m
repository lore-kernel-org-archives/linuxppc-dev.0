Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE4281A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 16:59:07 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3FD2E140E01
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:59:07 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 12:29:05 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 04A941258066
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:31:59 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6L6wwkB13762738
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6L6wwid007399
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:58 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, mpe@ellerman.id.au
Subject: [RFC 3/8] powerpc/slb: Define macros for the bolted slots
Date: Tue, 21 Jul 2015 12:28:41 +0530
Message-Id: <1437461926-8908-3-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch defines macros for all the three bolted SLB slots. This also
renames the 'create_shadowed_slb' function as 'new_shadowed_slb'.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 3842a54..cbeaaa2 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -25,6 +25,9 @@
 #include <asm/udbg.h>
 #include <asm/code-patching.h>
 
+#define SLOT_KLINR  0	/* kernel linear map  (0xc00000000) */
+#define SLOT_KVIRT  1	/* kernel virtual map (0xd00000000) */
+#define SLOT_KSTACK 2	/* kernel stack map   (0xf00000000) */
 
 extern void slb_allocate_realmode(unsigned long ea);
 extern void slb_allocate_user(unsigned long ea);
@@ -74,7 +77,7 @@ static inline void slb_shadow_clear(unsigned long slot)
 	get_slb_shadow()->save_area[slot].esid = 0;
 }
 
-static inline void create_shadowed_slbe(unsigned long ea, int ssize,
+static inline void new_shadowed_slbe(unsigned long ea, int ssize,
 					unsigned long flags,
 					unsigned long slot)
 {
@@ -103,16 +106,16 @@ static void __slb_flush_and_rebolt(void)
 	lflags = SLB_VSID_KERNEL | linear_llp;
 	vflags = SLB_VSID_KERNEL | vmalloc_llp;
 
-	ksp_esid_data = mk_esid_data(get_paca()->kstack, mmu_kernel_ssize, 2);
+	ksp_esid_data = mk_esid_data(get_paca()->kstack, mmu_kernel_ssize, SLOT_KSTACK);
 	if ((ksp_esid_data & ~0xfffffffUL) <= PAGE_OFFSET) {
 		ksp_esid_data &= ~SLB_ESID_V;
 		ksp_vsid_data = 0;
-		slb_shadow_clear(2);
+		slb_shadow_clear(SLOT_KSTACK);
 	} else {
 		/* Update stack slot; others don't change */
-		slb_shadow_update(get_paca()->kstack, mmu_kernel_ssize, lflags, 2);
+		slb_shadow_update(get_paca()->kstack, mmu_kernel_ssize, lflags, SLOT_KSTACK);
 		ksp_vsid_data =
-			be64_to_cpu(get_slb_shadow()->save_area[2].vsid);
+			be64_to_cpu(get_slb_shadow()->save_area[SLOT_KSTACK].vsid);
 	}
 
 	/* We need to do this all in asm, so we're sure we don't touch
@@ -125,7 +128,7 @@ static void __slb_flush_and_rebolt(void)
 		     "slbmte	%2,%3\n"
 		     "isync"
 		     :: "r"(mk_vsid_data(VMALLOC_START, mmu_kernel_ssize, vflags)),
-		        "r"(mk_esid_data(VMALLOC_START, mmu_kernel_ssize, 1)),
+		        "r"(mk_esid_data(VMALLOC_START, mmu_kernel_ssize, SLOT_KVIRT)),
 		        "r"(ksp_vsid_data),
 		        "r"(ksp_esid_data)
 		     : "memory");
@@ -151,7 +154,7 @@ void slb_vmalloc_update(void)
 	unsigned long vflags;
 
 	vflags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmalloc_psize].sllp;
-	slb_shadow_update(VMALLOC_START, mmu_kernel_ssize, vflags, 1);
+	slb_shadow_update(VMALLOC_START, mmu_kernel_ssize, vflags, SLOT_KVIRT);
 	slb_flush_and_rebolt();
 }
 
@@ -312,19 +315,19 @@ void slb_initialize(void)
 	asm volatile("isync":::"memory");
 	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
 	asm volatile("isync; slbia; isync":::"memory");
-	create_shadowed_slbe(PAGE_OFFSET, mmu_kernel_ssize, lflags, 0);
-	create_shadowed_slbe(VMALLOC_START, mmu_kernel_ssize, vflags, 1);
+	new_shadowed_slbe(PAGE_OFFSET, mmu_kernel_ssize, lflags, SLOT_KLINR);
+	new_shadowed_slbe(VMALLOC_START, mmu_kernel_ssize, vflags, SLOT_KVIRT);
 
 	/* For the boot cpu, we're running on the stack in init_thread_union,
 	 * which is in the first segment of the linear mapping, and also
 	 * get_paca()->kstack hasn't been initialized yet.
 	 * For secondary cpus, we need to bolt the kernel stack slot now.
 	 */
-	slb_shadow_clear(2);
+	slb_shadow_clear(SLOT_KSTACK);
 	if (raw_smp_processor_id() != boot_cpuid &&
 	    (get_paca()->kstack & slb_esid_mask(mmu_kernel_ssize)) > PAGE_OFFSET)
-		create_shadowed_slbe(get_paca()->kstack,
-				     mmu_kernel_ssize, lflags, 2);
+		new_shadowed_slbe(get_paca()->kstack,
+				     mmu_kernel_ssize, lflags, SLOT_KSTACK);
 
 	asm volatile("isync":::"memory");
 }
-- 
2.1.0
