Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C0351A0779
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 17:07:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: khandual@linux.vnet.ibm.com
Subject: [PATCH v2] powerpc/slb: Define an enum for the bolted indexes
Date: Thu, 13 Aug 2015 17:07:54 +1000
Message-Id: <1439449674-32191-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch defines macros for the three bolted SLB indexes we use.
Switch the functions that take the indexes as an argument to use the
enum.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

v2: Use index rather than slot as that's what the ISA docs call it.
    Use the enum in the function signatures.

 arch/powerpc/mm/slb.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 8a32a2be3c53..0c7115fd314b 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -25,6 +25,11 @@
 #include <asm/udbg.h>
 #include <asm/code-patching.h>
 
+enum slb_index {
+	LINEAR_INDEX	= 0, /* Kernel linear map  (0xc000000000000000) */
+	VMALLOC_INDEX	= 1, /* Kernel virtual map (0xd000000000000000) */
+	KSTACK_INDEX	= 2, /* Kernel stack map */
+};
 
 extern void slb_allocate_realmode(unsigned long ea);
 extern void slb_allocate_user(unsigned long ea);
@@ -41,9 +46,9 @@ static void slb_allocate(unsigned long ea)
 	(((ssize) == MMU_SEGSIZE_256M)? ESID_MASK: ESID_MASK_1T)
 
 static inline unsigned long mk_esid_data(unsigned long ea, int ssize,
-					 unsigned long entry)
+					 enum slb_index index)
 {
-	return (ea & slb_esid_mask(ssize)) | SLB_ESID_V | entry;
+	return (ea & slb_esid_mask(ssize)) | SLB_ESID_V | index;
 }
 
 static inline unsigned long mk_vsid_data(unsigned long ea, int ssize,
@@ -55,39 +60,39 @@ static inline unsigned long mk_vsid_data(unsigned long ea, int ssize,
 
 static inline void slb_shadow_update(unsigned long ea, int ssize,
 				     unsigned long flags,
-				     unsigned long entry)
+				     enum slb_index index)
 {
 	/*
 	 * Clear the ESID first so the entry is not valid while we are
 	 * updating it.  No write barriers are needed here, provided
 	 * we only update the current CPU's SLB shadow buffer.
 	 */
-	get_slb_shadow()->save_area[entry].esid = 0;
-	get_slb_shadow()->save_area[entry].vsid =
+	get_slb_shadow()->save_area[index].esid = 0;
+	get_slb_shadow()->save_area[index].vsid =
 				cpu_to_be64(mk_vsid_data(ea, ssize, flags));
-	get_slb_shadow()->save_area[entry].esid =
-				cpu_to_be64(mk_esid_data(ea, ssize, entry));
+	get_slb_shadow()->save_area[index].esid =
+				cpu_to_be64(mk_esid_data(ea, ssize, index));
 }
 
-static inline void slb_shadow_clear(unsigned long entry)
+static inline void slb_shadow_clear(enum slb_index index)
 {
-	get_slb_shadow()->save_area[entry].esid = 0;
+	get_slb_shadow()->save_area[index].esid = 0;
 }
 
 static inline void create_shadowed_slbe(unsigned long ea, int ssize,
 					unsigned long flags,
-					unsigned long entry)
+					enum slb_index index)
 {
 	/*
 	 * Updating the shadow buffer before writing the SLB ensures
 	 * we don't get a stale entry here if we get preempted by PHYP
 	 * between these two statements.
 	 */
-	slb_shadow_update(ea, ssize, flags, entry);
+	slb_shadow_update(ea, ssize, flags, index);
 
 	asm volatile("slbmte  %0,%1" :
 		     : "r" (mk_vsid_data(ea, ssize, flags)),
-		       "r" (mk_esid_data(ea, ssize, entry))
+		       "r" (mk_esid_data(ea, ssize, index))
 		     : "memory" );
 }
 
@@ -103,16 +108,16 @@ static void __slb_flush_and_rebolt(void)
 	lflags = SLB_VSID_KERNEL | linear_llp;
 	vflags = SLB_VSID_KERNEL | vmalloc_llp;
 
-	ksp_esid_data = mk_esid_data(get_paca()->kstack, mmu_kernel_ssize, 2);
+	ksp_esid_data = mk_esid_data(get_paca()->kstack, mmu_kernel_ssize, KSTACK_INDEX);
 	if ((ksp_esid_data & ~0xfffffffUL) <= PAGE_OFFSET) {
 		ksp_esid_data &= ~SLB_ESID_V;
 		ksp_vsid_data = 0;
-		slb_shadow_clear(2);
+		slb_shadow_clear(KSTACK_INDEX);
 	} else {
 		/* Update stack entry; others don't change */
-		slb_shadow_update(get_paca()->kstack, mmu_kernel_ssize, lflags, 2);
+		slb_shadow_update(get_paca()->kstack, mmu_kernel_ssize, lflags, KSTACK_INDEX);
 		ksp_vsid_data =
-			be64_to_cpu(get_slb_shadow()->save_area[2].vsid);
+			be64_to_cpu(get_slb_shadow()->save_area[KSTACK_INDEX].vsid);
 	}
 
 	/* We need to do this all in asm, so we're sure we don't touch
@@ -151,7 +156,7 @@ void slb_vmalloc_update(void)
 	unsigned long vflags;
 
 	vflags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmalloc_psize].sllp;
-	slb_shadow_update(VMALLOC_START, mmu_kernel_ssize, vflags, 1);
+	slb_shadow_update(VMALLOC_START, mmu_kernel_ssize, vflags, VMALLOC_INDEX);
 	slb_flush_and_rebolt();
 }
 
@@ -326,19 +331,19 @@ void slb_initialize(void)
 	asm volatile("isync":::"memory");
 	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
 	asm volatile("isync; slbia; isync":::"memory");
-	create_shadowed_slbe(PAGE_OFFSET, mmu_kernel_ssize, lflags, 0);
-	create_shadowed_slbe(VMALLOC_START, mmu_kernel_ssize, vflags, 1);
+	create_shadowed_slbe(PAGE_OFFSET, mmu_kernel_ssize, lflags, LINEAR_INDEX);
+	create_shadowed_slbe(VMALLOC_START, mmu_kernel_ssize, vflags, VMALLOC_INDEX);
 
 	/* For the boot cpu, we're running on the stack in init_thread_union,
 	 * which is in the first segment of the linear mapping, and also
 	 * get_paca()->kstack hasn't been initialized yet.
 	 * For secondary cpus, we need to bolt the kernel stack entry now.
 	 */
-	slb_shadow_clear(2);
+	slb_shadow_clear(KSTACK_INDEX);
 	if (raw_smp_processor_id() != boot_cpuid &&
 	    (get_paca()->kstack & slb_esid_mask(mmu_kernel_ssize)) > PAGE_OFFSET)
 		create_shadowed_slbe(get_paca()->kstack,
-				     mmu_kernel_ssize, lflags, 2);
+				     mmu_kernel_ssize, lflags, KSTACK_INDEX);
 
 	asm volatile("isync":::"memory");
 }
-- 
2.1.4
