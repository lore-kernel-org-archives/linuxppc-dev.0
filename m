Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v83h6ZkYzF1Rh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 19:42:24 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id z25-v6so1814507pgu.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 02:42:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 4/5] powerpc/64s/hash: Add SLB allocation bitmaps
Date: Mon, 20 Aug 2018 19:41:59 +1000
Message-Id: <20180820094200.13003-5-npiggin@gmail.com>
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

Add 32-entry bitmaps to track the allocation status of the first 32
SLB entries, and whether they are user or kernel entries. These are
used to prevent context switches rolling the SLB round robin allocator
and evicting important kernel SLBEs when there are obvious free
entries.
---
 arch/powerpc/include/asm/paca.h |  6 +++--
 arch/powerpc/mm/slb.c           | 42 +++++++++++++++++++++++----------
 arch/powerpc/xmon/xmon.c        |  2 +-
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 8c258a057207..bf7ab59be3b8 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -113,7 +113,10 @@ struct paca_struct {
  				 * on the linear mapping */
 	/* SLB related definitions */
 	u16 vmalloc_sllp;
-	u16 slb_cache_ptr;
+	u8 slb_cache_ptr;
+	u8 stab_rr;			/* stab/slb round-robin counter */
+	u32 slb_used_bitmap;		/* Bitmaps for first 32 SLB entries. */
+	u32 slb_kern_bitmap;
 	u32 slb_cache[SLB_CACHE_ENTRIES];
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
@@ -148,7 +151,6 @@ struct paca_struct {
 	 */
 	struct task_struct *__current;	/* Pointer to current */
 	u64 kstack;			/* Saved Kernel stack addr */
-	u64 stab_rr;			/* stab/slb round-robin counter */
 	u64 saved_r1;			/* r1 save for RTAS calls or PM or EE=0 */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 6e595d75d997..3de63598f7c4 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -267,6 +267,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 
 		get_paca()->slb_cache_ptr = 0;
 	}
+	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 
 	/*
 	 * preload some userspace segments into the SLB.
@@ -339,6 +340,8 @@ void slb_initialize(void)
 	}
 
 	get_paca()->stab_rr = SLB_NUM_BOLTED - 1;
+	get_paca()->slb_kern_bitmap |= (1U << SLB_NUM_BOLTED) - 1;
+	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 
 	lflags = SLB_VSID_KERNEL | linear_llp;
 
@@ -390,27 +393,42 @@ static void slb_cache_update(unsigned long esid_data)
 	}
 }
 
-static enum slb_index alloc_slb_index(void)
+static enum slb_index alloc_slb_index(bool kernel)
 {
 	enum slb_index index;
 
-	/* round-robin replacement of slb starting at SLB_NUM_BOLTED. */
-	index = get_paca()->stab_rr;
-	if (index < (mmu_slb_size - 1))
-		index++;
-	else
-		index = SLB_NUM_BOLTED;
-	get_paca()->stab_rr = index;
+	/*
+	 * SLBs beyond 32 entries are allocated with stab_rr only
+	 * POWER7/8/9 have 32 SLB entries, this could be expanded if a
+	 * future CPU has more.
+	 */
+	if (get_paca()->slb_used_bitmap != U32_MAX) {
+		index = ffz(get_paca()->slb_used_bitmap);
+		get_paca()->slb_used_bitmap |= 1U << index;
+		if (kernel)
+			get_paca()->slb_kern_bitmap |= 1U << index;
+	} else {
+		/* round-robin replacement of slb starting at SLB_NUM_BOLTED. */
+		index = get_paca()->stab_rr;
+		if (index < (mmu_slb_size - 1))
+			index++;
+		else
+			index = SLB_NUM_BOLTED;
+		get_paca()->stab_rr = index;
+		if (kernel && index < 32)
+			get_paca()->slb_kern_bitmap |= 1U << index;
+	}
+	BUG_ON(index < SLB_NUM_BOLTED);
 
 	return index;
 }
 
 static void slb_insert_entry(unsigned long ea, unsigned long context,
-				unsigned long flags, int ssize)
+				unsigned long flags, int ssize, bool kernel)
 {
 	unsigned long vsid;
 	unsigned long vsid_data, esid_data;
-	enum slb_index index = alloc_slb_index();
+	enum slb_index index = alloc_slb_index(kernel);
 
 	vsid = get_vsid(context, ea, ssize);
 	vsid_data = (vsid << slb_vsid_shift(ssize)) | flags |
@@ -454,7 +472,7 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
 
 	context = id - KERNEL_REGION_CONTEXT_OFFSET;
 
-	slb_insert_entry(ea, context, flags, ssize);
+	slb_insert_entry(ea, context, flags, ssize, true);
 
 	return 0;
 }
@@ -487,7 +505,7 @@ static long slb_allocate_user(struct mm_struct *mm, unsigned long ea)
 	bpsize = get_slice_psize(mm, ea);
 	flags = SLB_VSID_USER | mmu_psize_defs[bpsize].sllp;
 
-	slb_insert_entry(ea, context, flags, ssize);
+	slb_insert_entry(ea, context, flags, ssize, false);
 
 	return 0;
 }
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 8c1d8b4bf6d5..44e16675c7f9 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2415,7 +2415,7 @@ static void dump_one_paca(int cpu)
 	DUMP(p, __current, "%-*px");
 	DUMP(p, kstack, "%#-*llx");
 	printf(" %-*s = 0x%016llx\n", 25, "kstack_base", p->kstack & ~(THREAD_SIZE - 1));
-	DUMP(p, stab_rr, "%#-*llx");
+	DUMP(p, stab_rr, "%#-*x");
 	DUMP(p, saved_r1, "%#-*llx");
 	DUMP(p, trap_save, "%#-*x");
 	DUMP(p, irq_soft_mask, "%#-*x");
-- 
2.17.0
