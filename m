Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v83f4P4ZzF162
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 19:42:22 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id k21-v6so6479996pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 02:42:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 3/5] powerpc/64s/hash: remove the first vmalloc segment
 from the bolted SLB
Date: Mon, 20 Aug 2018 19:41:58 +1000
Message-Id: <20180820094200.13003-4-npiggin@gmail.com>
In-Reply-To: <20180820094200.13003-1-npiggin@gmail.com>
References: <20180820094200.13003-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the first vmalloc segment from bolted SLBEs. This is not
required to be bolted, and seems like it was added to help pre-load
the SLB on context switch. However there are now other segments like
the vmemmap segment that often take misses after a context switch, so
it is better to solve this a different way and save a bolted entry.
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
 arch/powerpc/mm/slb.c                         | 16 ++++------------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 39764214aef5..4c8d413ce99a 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -30,7 +30,7 @@
  * SLB
  */
 
-#define SLB_NUM_BOLTED		3
+#define SLB_NUM_BOLTED		2
 #define SLB_CACHE_ENTRIES	8
 #define SLB_MIN_SIZE		32
 
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 221d94b4f9cf..6e595d75d997 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -133,13 +133,11 @@ static void __slb_flush_and_rebolt(void)
 {
 	/* If you change this make sure you change SLB_NUM_BOLTED
 	 * and PR KVM appropriately too. */
-	unsigned long linear_llp, vmalloc_llp, lflags, vflags;
+	unsigned long linear_llp, lflags;
 	unsigned long ksp_esid_data, ksp_vsid_data;
 
 	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
-	vmalloc_llp = mmu_psize_defs[mmu_vmalloc_psize].sllp;
 	lflags = SLB_VSID_KERNEL | linear_llp;
-	vflags = SLB_VSID_KERNEL | vmalloc_llp;
 
 	ksp_esid_data = mk_esid_data(get_paca()->kstack, mmu_kernel_ssize, KSTACK_INDEX);
 	if ((ksp_esid_data & ~0xfffffffUL) <= PAGE_OFFSET) {
@@ -157,14 +155,10 @@ static void __slb_flush_and_rebolt(void)
 	 * the stack between the slbia and rebolting it. */
 	asm volatile("isync\n"
 		     "slbia\n"
-		     /* Slot 1 - first VMALLOC segment */
+		     /* Slot 1 - kernel stack */
 		     "slbmte	%0,%1\n"
-		     /* Slot 2 - kernel stack */
-		     "slbmte	%2,%3\n"
 		     "isync"
-		     :: "r"(mk_vsid_data(VMALLOC_START, mmu_kernel_ssize, vflags)),
-		        "r"(mk_esid_data(VMALLOC_START, mmu_kernel_ssize, VMALLOC_INDEX)),
-		        "r"(ksp_vsid_data),
+		     :: "r"(ksp_vsid_data),
 		        "r"(ksp_esid_data)
 		     : "memory");
 }
@@ -321,7 +315,7 @@ void core_flush_all_slbs(struct mm_struct *mm)
 void slb_initialize(void)
 {
 	unsigned long linear_llp, vmalloc_llp, io_llp;
-	unsigned long lflags, vflags;
+	unsigned long lflags;
 	static int slb_encoding_inited;
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	unsigned long vmemmap_llp;
@@ -347,14 +341,12 @@ void slb_initialize(void)
 	get_paca()->stab_rr = SLB_NUM_BOLTED - 1;
 
 	lflags = SLB_VSID_KERNEL | linear_llp;
-	vflags = SLB_VSID_KERNEL | vmalloc_llp;
 
 	/* Invalidate the entire SLB (even entry 0) & all the ERATS */
 	asm volatile("isync":::"memory");
 	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
 	asm volatile("isync; slbia; isync":::"memory");
 	create_shadowed_slbe(PAGE_OFFSET, mmu_kernel_ssize, lflags, LINEAR_INDEX);
-	create_shadowed_slbe(VMALLOC_START, mmu_kernel_ssize, vflags, VMALLOC_INDEX);
 
 	/* For the boot cpu, we're running on the stack in init_thread_union,
 	 * which is in the first segment of the linear mapping, and also
-- 
2.17.0
