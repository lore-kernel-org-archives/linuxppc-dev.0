Return-Path: <npiggin@gmail.com>
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bfck2STRzF3XP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 01:31:18 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id u11-v6so4374152plq.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 08:31:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 04/12] powerpc/64s/hash: remove the vmalloc segment from the
 bolted SLB
Date: Sat, 15 Sep 2018 01:30:48 +1000
Message-Id: <20180914153056.3644-5-npiggin@gmail.com>
In-Reply-To: <20180914153056.3644-1-npiggin@gmail.com>
References: <20180914153056.3644-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the vmalloc segment from bolted SLBEs. This is not required to
be bolted, and seems like it was added to help pre-load the SLB on
context switch. However there are now other segments like the vmemmap
segment and non-zero node memory that often take misses after a context
switch, so it is better to solve this in a more general way.

A subsequent change will track free SLB entries and uses those rather
than round-robin overwrite valid entries, which makes it far less
likely for kernel SLBEs to be evicted after they are installed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
 arch/powerpc/mm/slb.c                         | 23 ++++---------------
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index b3520b549cba..20d9ca736bbd 100644
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
index d952ece3abf7..a5e58f11d676 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -30,8 +30,7 @@
 
 enum slb_index {
 	LINEAR_INDEX	= 0, /* Kernel linear map  (0xc000000000000000) */
-	VMALLOC_INDEX	= 1, /* Kernel virtual map (0xd000000000000000) */
-	KSTACK_INDEX	= 2, /* Kernel stack map */
+	KSTACK_INDEX	= 1, /* Kernel stack map */
 };
 
 extern void slb_allocate(unsigned long ea);
@@ -133,13 +132,11 @@ static void __slb_flush_and_rebolt(void)
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
@@ -157,14 +154,10 @@ static void __slb_flush_and_rebolt(void)
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
@@ -186,10 +179,6 @@ void slb_flush_and_rebolt(void)
 
 void slb_vmalloc_update(void)
 {
-	unsigned long vflags;
-
-	vflags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmalloc_psize].sllp;
-	slb_shadow_update(VMALLOC_START, mmu_kernel_ssize, vflags, VMALLOC_INDEX);
 	slb_flush_and_rebolt();
 }
 
@@ -324,7 +313,7 @@ void slb_set_size(u16 size)
 void slb_initialize(void)
 {
 	unsigned long linear_llp, vmalloc_llp, io_llp;
-	unsigned long lflags, vflags;
+	unsigned long lflags;
 	static int slb_encoding_inited;
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	unsigned long vmemmap_llp;
@@ -360,14 +349,12 @@ void slb_initialize(void)
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
2.18.0
