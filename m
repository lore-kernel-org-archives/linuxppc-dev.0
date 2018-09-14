Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bfcz2DTbzF3XQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 01:31:31 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id h79-v6so4471315pfk.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 08:31:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 09/12] powerpc/64s/hash: SLB allocation status bitmaps
Date: Sat, 15 Sep 2018 01:30:53 +1000
Message-Id: <20180914153056.3644-10-npiggin@gmail.com>
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

Add 32-entry bitmaps to track the allocation status of the first 32
SLB entries, and whether they are user or kernel entries. These are
used to allocate free SLB entries first, before resorting to the round
robin allocator.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/paca.h   |  6 ++-
 arch/powerpc/kernel/asm-offsets.c |  2 +-
 arch/powerpc/mm/slb.c             | 62 +++++++++++++++++++++++++------
 arch/powerpc/xmon/xmon.c          |  4 +-
 4 files changed, 58 insertions(+), 16 deletions(-)

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
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 43b67ead5b97..1f79cbf3da62 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -173,7 +173,6 @@ int main(void)
 	OFFSET(PACAKSAVE, paca_struct, kstack);
 	OFFSET(PACACURRENT, paca_struct, __current);
 	OFFSET(PACASAVEDMSR, paca_struct, saved_msr);
-	OFFSET(PACASTABRR, paca_struct, stab_rr);
 	OFFSET(PACAR1, paca_struct, saved_r1);
 	OFFSET(PACATOC, paca_struct, kernel_toc);
 	OFFSET(PACAKBASE, paca_struct, kernelbase);
@@ -203,6 +202,7 @@ int main(void)
 #ifdef CONFIG_PPC_BOOK3S_64
 	OFFSET(PACASLBCACHE, paca_struct, slb_cache);
 	OFFSET(PACASLBCACHEPTR, paca_struct, slb_cache_ptr);
+	OFFSET(PACASTABRR, paca_struct, stab_rr);
 	OFFSET(PACAVMALLOCSLLP, paca_struct, vmalloc_sllp);
 #ifdef CONFIG_PPC_MM_SLICES
 	OFFSET(MMUPSIZESLLP, mmu_psize_def, sllp);
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index d782a70d4a5d..98521fec3536 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -122,6 +122,9 @@ void slb_restore_bolted_realmode(void)
 {
 	__slb_restore_bolted_realmode();
 	get_paca()->slb_cache_ptr = 0;
+
+	get_paca()->slb_kern_bitmap = (1U << SLB_NUM_BOLTED) - 1;
+	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 }
 
 /*
@@ -129,9 +132,6 @@ void slb_restore_bolted_realmode(void)
  */
 void slb_flush_all_realmode(void)
 {
-	/*
-	 * This flushes all SLB entries including 0, so it must be realmode.
-	 */
 	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
 }
 
@@ -177,6 +177,9 @@ void slb_flush_and_rebolt(void)
 		     : "memory");
 
 	get_paca()->slb_cache_ptr = 0;
+
+	get_paca()->slb_kern_bitmap = (1U << SLB_NUM_BOLTED) - 1;
+	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 }
 
 void slb_vmalloc_update(void)
@@ -273,10 +276,13 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 				     "isync"
 				     :: "r"(ksp_vsid_data),
 					"r"(ksp_esid_data));
+
+			get_paca()->slb_kern_bitmap = (1U << SLB_NUM_BOLTED) - 1;
 		}
 
 		get_paca()->slb_cache_ptr = 0;
 	}
+	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 
 	/*
 	 * preload some userspace segments into the SLB.
@@ -349,6 +355,8 @@ void slb_initialize(void)
 	}
 
 	get_paca()->stab_rr = SLB_NUM_BOLTED - 1;
+	get_paca()->slb_kern_bitmap = (1U << SLB_NUM_BOLTED) - 1;
+	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 
 	lflags = SLB_VSID_KERNEL | linear_llp;
 
@@ -400,17 +408,47 @@ static void slb_cache_update(unsigned long esid_data)
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
+	 * The allocation bitmaps can become out of synch with the SLB
+	 * when the _switch code does slbie when bolting a new stack
+	 * segment and it must not be anywhere else in the SLB. This leaves
+	 * a kernel allocated entry that is unused in the SLB. With very
+	 * large systems or small segment sizes, the bitmaps could slowly
+	 * fill with these entries. They will eventually be cleared out
+	 * by the round robin allocator in that case, so it's probably not
+	 * worth accounting for.
+	 */
+
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
+		if (index < 32) {
+			if (kernel)
+				get_paca()->slb_kern_bitmap |= 1U << index;
+			else
+				get_paca()->slb_kern_bitmap &= ~(1U << index);
+		}
+	}
+	BUG_ON(index < SLB_NUM_BOLTED);
 
 	return index;
 }
@@ -426,7 +464,7 @@ static long slb_insert_entry(unsigned long ea, unsigned long context,
 	if (!vsid)
 		return -EFAULT;
 
-	index = alloc_slb_index();
+	index = alloc_slb_index(kernel);
 
 	vsid_data = __mk_vsid_data(vsid, ssize, flags);
 	esid_data = mk_esid_data(ea, ssize, index);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index eb2e0d472eb1..323aac8321fa 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2393,6 +2393,9 @@ static void dump_one_paca(int cpu)
 		}
 	}
 	DUMP(p, vmalloc_sllp, "%#-*x");
+	DUMP(p, stab_rr, "%#-*x");
+	DUMP(p, slb_used_bitmap, "%#-*x");
+	DUMP(p, slb_kern_bitmap, "%#-*x");
 
 	if (!early_cpu_has_feature(CPU_FTR_ARCH_300)) {
 		DUMP(p, slb_cache_ptr, "%#-*x");
@@ -2415,7 +2418,6 @@ static void dump_one_paca(int cpu)
 	DUMP(p, __current, "%-*px");
 	DUMP(p, kstack, "%#-*llx");
 	printf(" %-*s = 0x%016llx\n", 25, "kstack_base", p->kstack & ~(THREAD_SIZE - 1));
-	DUMP(p, stab_rr, "%#-*llx");
 	DUMP(p, saved_r1, "%#-*llx");
 	DUMP(p, trap_save, "%#-*x");
 	DUMP(p, irq_soft_mask, "%#-*x");
-- 
2.18.0
