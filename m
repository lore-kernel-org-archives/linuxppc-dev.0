Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420FLM1HKdzDrtm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 02:57:46 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id k19-v6so993860pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 09:57:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/3] powerpc/64s/hash: Use POWER9 SLBIA IH=3 variant in
 switch_mm
Date: Wed, 29 Aug 2018 02:57:30 +1000
Message-Id: <20180828165731.24320-3-npiggin@gmail.com>
In-Reply-To: <20180828165731.24320-1-npiggin@gmail.com>
References: <20180828165731.24320-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 introduces SLBIA IH=3, which invalidates all SLB entries
and associated lookaside information that have a class value of
1, which Linux assigns to user addresses. This matches what
switch_slb wants, and allows a simple fast implementation that
avoids the slb_cache complexity.

As a side-effect, the POWER5 < DD2.1 SLB invalidation workaround
is avoided on POWER9.

Process context switching rate is improved about 2.2% for a
small process (that hits the slb cache).

Signed-of-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb.c    | 56 ++++++++++++++++++++++++++--------------
 arch/powerpc/xmon/xmon.c | 11 +++++---
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 2f162c6e52d4..51afed85cfc3 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -238,29 +238,42 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	 * which would update the slb_cache/slb_cache_ptr fields in the PACA.
 	 */
 	hard_irq_disable();
-	offset = get_paca()->slb_cache_ptr;
-	if (!mmu_has_feature(MMU_FTR_NO_SLBIE_B) &&
-	    offset <= SLB_CACHE_ENTRIES) {
-		int i;
-		asm volatile("isync" : : : "memory");
-		for (i = 0; i < offset; i++) {
-			slbie_data = (unsigned long)get_paca()->slb_cache[i]
-				<< SID_SHIFT; /* EA */
-			slbie_data |= user_segment_size(slbie_data)
-				<< SLBIE_SSIZE_SHIFT;
-			slbie_data |= SLBIE_C; /* C set for user addresses */
-			asm volatile("slbie %0" : : "r" (slbie_data));
-		}
-		asm volatile("isync" : : : "memory");
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		/*
+		 * SLBIA IH=3 invalidates all Class=1 SLBEs and their
+		 * associated lookaside structures, which matches what
+		 * switch_slb wants. So ARCH_300 does not use the slb
+		 * cache.
+		 */
+		asm volatile("isync ; " PPC_SLBIA(3)" ; isync");
 	} else {
-		__slb_flush_and_rebolt();
-	}
+		offset = get_paca()->slb_cache_ptr;
+		if (!mmu_has_feature(MMU_FTR_NO_SLBIE_B) &&
+		    offset <= SLB_CACHE_ENTRIES) {
+			int i;
+			asm volatile("isync" : : : "memory");
+			for (i = 0; i < offset; i++) {
+				/* EA */
+				slbie_data = (unsigned long)
+					get_paca()->slb_cache[i] << SID_SHIFT;
+				slbie_data |= user_segment_size(slbie_data)
+						<< SLBIE_SSIZE_SHIFT;
+				slbie_data |= SLBIE_C; /* user slbs have C=1 */
+				asm volatile("slbie %0" : : "r" (slbie_data));
+			}
+			asm volatile("isync" : : : "memory");
+		} else {
+			__slb_flush_and_rebolt();
+		}
 
-	/* Workaround POWER5 < DD2.1 issue */
-	if (offset == 1 || offset > SLB_CACHE_ENTRIES)
-		asm volatile("slbie %0" : : "r" (slbie_data));
+		/* Workaround POWER5 < DD2.1 issue */
+		if (offset == 1 || offset > SLB_CACHE_ENTRIES)
+			asm volatile("slbie %0" : : "r" (slbie_data));
+
+		get_paca()->slb_cache_ptr = 0;
+	}
 
-	get_paca()->slb_cache_ptr = 0;
 	copy_mm_to_paca(mm);
 
 	/*
@@ -388,6 +401,9 @@ static void insert_slb_entry(unsigned long vsid, unsigned long ea,
 	enum slb_index index;
 	int slb_cache_index;
 
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		return; /* ISAv3.0B and later does not use slb_cache */
+
 	/*
 	 * We are irq disabled, hence should be safe to access PACA.
 	 */
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 379ae7222099..8c1d8b4bf6d5 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2393,10 +2393,13 @@ static void dump_one_paca(int cpu)
 		}
 	}
 	DUMP(p, vmalloc_sllp, "%#-*x");
-	DUMP(p, slb_cache_ptr, "%#-*x");
-	for (i = 0; i < SLB_CACHE_ENTRIES; i++)
-		printf(" %-*s[%d] = 0x%016x\n",
-		       22, "slb_cache", i, p->slb_cache[i]);
+
+	if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
+		DUMP(p, slb_cache_ptr, "%#-*x");
+		for (i = 0; i < SLB_CACHE_ENTRIES; i++)
+			printf(" %-*s[%d] = 0x%016x\n",
+			       22, "slb_cache", i, p->slb_cache[i]);
+	}
 
 	DUMP(p, rfi_flush_fallback_area, "%-*px");
 #endif
-- 
2.18.0
