Return-Path: <npiggin@gmail.com>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bfcq2n6szF3XC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 01:31:23 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id f66-v6so4372239plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 08:31:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 06/12] powerpc/64s/hash: Use POWER9 SLBIA IH=3 variant in
 switch_slb
Date: Sat, 15 Sep 2018 01:30:50 +1000
Message-Id: <20180914153056.3644-7-npiggin@gmail.com>
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

POWER9 introduces SLBIA IH=3, which invalidates all SLB entries and
associated lookaside information that have a class value of 1, which
Linux assigns to user addresses. This matches what switch_slb wants,
and allows a simple fast implementation that avoids the slb_cache
complexity.

As a side-effect, the POWER5 < DD2.1 SLB invalidation workaround is
also avoided on POWER9.

Process context switching rate is improved about 2.2% for a small
process that hits the slb cache which is the best case for the current
code.

Signed-of-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb.c    | 86 +++++++++++++++++++++++-----------------
 arch/powerpc/xmon/xmon.c | 11 +++--
 2 files changed, 57 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 03fa1c663ccf..319c772f7cbd 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -209,7 +209,6 @@ static inline int esids_match(unsigned long addr1, unsigned long addr2)
 /* Flush all user entries from the segment table of the current processor. */
 void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 {
-	unsigned long offset;
 	unsigned long pc = KSTK_EIP(tsk);
 	unsigned long stack = KSTK_ESP(tsk);
 	unsigned long exec_base;
@@ -221,45 +220,57 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	 * which would update the slb_cache/slb_cache_ptr fields in the PACA.
 	 */
 	hard_irq_disable();
-	offset = get_paca()->slb_cache_ptr;
-	if (!mmu_has_feature(MMU_FTR_NO_SLBIE_B) &&
-	    offset <= SLB_CACHE_ENTRIES) {
-		unsigned long slbie_data;
-		int i;
-
-		asm volatile("isync" : : : "memory");
-		for (i = 0; i < offset; i++) {
-			slbie_data = (unsigned long)get_paca()->slb_cache[i]
-				<< SID_SHIFT; /* EA */
-			slbie_data |= user_segment_size(slbie_data)
-				<< SLBIE_SSIZE_SHIFT;
-			slbie_data |= SLBIE_C; /* C set for user addresses */
-			asm volatile("slbie %0" : : "r" (slbie_data));
-		}
-
-		/* Workaround POWER5 < DD2.1 issue */
-		if (!cpu_has_feature(CPU_FTR_ARCH_207S) && offset == 1)
-			asm volatile("slbie %0" : : "r" (slbie_data));
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		/*
+		 * SLBIA IH=3 invalidates all Class=1 SLBEs and their
+		 * associated lookaside structures, which matches what
+		 * switch_slb wants. So ARCH_300 does not use the slb
+		 * cache.
+		 */
+		asm volatile("isync ; " PPC_SLBIA(3)" ; isync");
 
-		asm volatile("isync" : : : "memory");
 	} else {
-		struct slb_shadow *p = get_slb_shadow();
-		unsigned long ksp_esid_data =
-			be64_to_cpu(p->save_area[KSTACK_INDEX].esid);
-		unsigned long ksp_vsid_data =
-			be64_to_cpu(p->save_area[KSTACK_INDEX].vsid);
-
-		asm volatile("isync\n"
-			     PPC_SLBIA(1) "\n"
-			     "slbmte	%0,%1\n"
-			     "isync"
-			     :: "r"(ksp_vsid_data),
-				"r"(ksp_esid_data));
-
-		asm volatile("isync" : : : "memory");
+		unsigned long offset = get_paca()->slb_cache_ptr;
+
+		if (!mmu_has_feature(MMU_FTR_NO_SLBIE_B) &&
+		    offset <= SLB_CACHE_ENTRIES) {
+			unsigned long slbie_data;
+			int i;
+
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
+
+			/* Workaround POWER5 < DD2.1 issue */
+			if (!cpu_has_feature(CPU_FTR_ARCH_207S) && offset == 1)
+				asm volatile("slbie %0" : : "r" (slbie_data));
+
+			asm volatile("isync" : : : "memory");
+		} else {
+			struct slb_shadow *p = get_slb_shadow();
+			unsigned long ksp_esid_data =
+				be64_to_cpu(p->save_area[KSTACK_INDEX].esid);
+			unsigned long ksp_vsid_data =
+				be64_to_cpu(p->save_area[KSTACK_INDEX].vsid);
+
+			asm volatile("isync\n"
+				     PPC_SLBIA(1) "\n"
+				     "slbmte	%0,%1\n"
+				     "isync"
+				     :: "r"(ksp_vsid_data),
+					"r"(ksp_esid_data));
+		}
+
+		get_paca()->slb_cache_ptr = 0;
 	}
 
-	get_paca()->slb_cache_ptr = 0;
 	copy_mm_to_paca(mm);
 
 	/*
@@ -385,6 +396,9 @@ static void insert_slb_entry(unsigned long vsid, unsigned long ea,
 	enum slb_index index;
 	int slb_cache_index;
 
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		return; /* ISAv3.0B and later does not use slb_cache */
+
 	/*
 	 * We are irq disabled, hence should be safe to access PACA.
 	 */
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 129dcf7e3d9c..eb2e0d472eb1 100644
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
+	if (!early_cpu_has_feature(CPU_FTR_ARCH_300)) {
+		DUMP(p, slb_cache_ptr, "%#-*x");
+		for (i = 0; i < SLB_CACHE_ENTRIES; i++)
+			printf(" %-*s[%d] = 0x%016x\n",
+			       22, "slb_cache", i, p->slb_cache[i]);
+	}
 
 	DUMP(p, rfi_flush_fallback_area, "%-*px");
 #endif
-- 
2.18.0
