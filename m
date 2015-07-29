Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F09A31A1A3B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 17:10:39 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 28FDA140DFC
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:10:38 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 12:40:36 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 92DFAE007F
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:44:19 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T7A8Q944892242
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:10 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T7A6Ci001162
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH 3/8] powerpc/slb: Define macros for the bolted slots
Date: Wed, 29 Jul 2015 12:40:00 +0530
Message-Id: <1438153805-31828-3-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch defines macros for all the three bolted SLB slots. This also
renames the 'create_shadowed_slb' function as 'new_shadowed_slb'.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index faf9f0c..701a57f 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -25,6 +25,11 @@
 #include <asm/udbg.h>
 #include <asm/code-patching.h>
 
+enum slb_slots {
+	LINEAR_SLOT	= 0, /* Kernel linear map  (0xc000000000000000) */
+	VMALLOC_SLOT	= 1, /* Kernel virtual map (0xd000000000000000) */
+	KSTACK_SLOT	= 2, /* Kernel stack map */
+};
 
 extern void slb_allocate_realmode(unsigned long ea);
 extern void slb_allocate_user(unsigned long ea);
@@ -74,7 +79,7 @@ static inline void slb_shadow_clear(unsigned long entry)
 	get_slb_shadow()->save_area[entry].esid = 0;
 }
 
-static inline void create_shadowed_slbe(unsigned long ea, int ssize,
+static inline void new_shadowed_slbe(unsigned long ea, int ssize,
 					unsigned long flags,
 					unsigned long entry)
 {
@@ -103,16 +108,16 @@ static void __slb_flush_and_rebolt(void)
 	lflags = SLB_VSID_KERNEL | linear_llp;
 	vflags = SLB_VSID_KERNEL | vmalloc_llp;
 
-	ksp_esid_data = mk_esid_data(get_paca()->kstack, mmu_kernel_ssize, 2);
+	ksp_esid_data = mk_esid_data(get_paca()->kstack, mmu_kernel_ssize, KSTACK_SLOT);
 	if ((ksp_esid_data & ~0xfffffffUL) <= PAGE_OFFSET) {
 		ksp_esid_data &= ~SLB_ESID_V;
 		ksp_vsid_data = 0;
-		slb_shadow_clear(2);
+		slb_shadow_clear(KSTACK_SLOT);
 	} else {
 		/* Update stack entry; others don't change */
-		slb_shadow_update(get_paca()->kstack, mmu_kernel_ssize, lflags, 2);
+		slb_shadow_update(get_paca()->kstack, mmu_kernel_ssize, lflags, KSTACK_SLOT);
 		ksp_vsid_data =
-			be64_to_cpu(get_slb_shadow()->save_area[2].vsid);
+			be64_to_cpu(get_slb_shadow()->save_area[KSTACK_SLOT].vsid);
 	}
 
 	/* We need to do this all in asm, so we're sure we don't touch
@@ -125,7 +130,7 @@ static void __slb_flush_and_rebolt(void)
 		     "slbmte	%2,%3\n"
 		     "isync"
 		     :: "r"(mk_vsid_data(VMALLOC_START, mmu_kernel_ssize, vflags)),
-		        "r"(mk_esid_data(VMALLOC_START, mmu_kernel_ssize, 1)),
+		        "r"(mk_esid_data(VMALLOC_START, mmu_kernel_ssize, VMALLOC_SLOT)),
 		        "r"(ksp_vsid_data),
 		        "r"(ksp_esid_data)
 		     : "memory");
@@ -151,7 +156,7 @@ void slb_vmalloc_update(void)
 	unsigned long vflags;
 
 	vflags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmalloc_psize].sllp;
-	slb_shadow_update(VMALLOC_START, mmu_kernel_ssize, vflags, 1);
+	slb_shadow_update(VMALLOC_START, mmu_kernel_ssize, vflags, VMALLOC_SLOT);
 	slb_flush_and_rebolt();
 }
 
@@ -312,19 +317,19 @@ void slb_initialize(void)
 	asm volatile("isync":::"memory");
 	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
 	asm volatile("isync; slbia; isync":::"memory");
-	create_shadowed_slbe(PAGE_OFFSET, mmu_kernel_ssize, lflags, 0);
-	create_shadowed_slbe(VMALLOC_START, mmu_kernel_ssize, vflags, 1);
+	new_shadowed_slbe(PAGE_OFFSET, mmu_kernel_ssize, lflags, LINEAR_SLOT);
+	new_shadowed_slbe(VMALLOC_START, mmu_kernel_ssize, vflags, VMALLOC_SLOT);
 
 	/* For the boot cpu, we're running on the stack in init_thread_union,
 	 * which is in the first segment of the linear mapping, and also
 	 * get_paca()->kstack hasn't been initialized yet.
 	 * For secondary cpus, we need to bolt the kernel stack entry now.
 	 */
-	slb_shadow_clear(2);
+	slb_shadow_clear(KSTACK_SLOT);
 	if (raw_smp_processor_id() != boot_cpuid &&
 	    (get_paca()->kstack & slb_esid_mask(mmu_kernel_ssize)) > PAGE_OFFSET)
-		create_shadowed_slbe(get_paca()->kstack,
-				     mmu_kernel_ssize, lflags, 2);
+		new_shadowed_slbe(get_paca()->kstack,
+				     mmu_kernel_ssize, lflags, KSTACK_SLOT);
 
 	asm volatile("isync":::"memory");
 }
-- 
2.1.0
