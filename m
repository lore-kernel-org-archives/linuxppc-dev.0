Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41nZdJ5TVVzDr5r
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2018 18:18:44 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id p12-v6so5554891pfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2018 01:18:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64s/hash: Use POWER9 SLBIA IH=3 variant in switch_mm
Date: Sat, 11 Aug 2018 18:18:33 +1000
Message-Id: <20180811081833.6330-1-npiggin@gmail.com>
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

Process context switching rate is improved about 2.2% for a
small process (that hits the slb cache).

Signed-of-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb.c     | 56 +++++++++++++++++++++++++--------------
 arch/powerpc/mm/slb_low.S |  9 ++++---
 arch/powerpc/xmon/xmon.c  | 11 +++++---
 3 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 0b095fa54049..8f8e3df5cfb0 100644
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
+		 * SLBIA IH=3 invalidates all Class=1 SLBEs and thir
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
@@ -424,6 +437,9 @@ static void insert_slb_entry(unsigned long vsid, unsigned long ea,
 	asm volatile("slbmte %0, %1" : : "r" (vsid_data), "r" (esid_data)
 		     : "memory");
 
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		return; /* ISAv3.0B and later does not use slb_cache */
+
 	/*
 	 * Now update slb cache entries
 	 */
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 4ac5057ad439..dbbb7a59eaf8 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -285,11 +285,14 @@ slb_compare_rr_to_size:
 	 */
 	slbmte	r11,r10
 
-	/* we're done for kernel addresses */
 	crclr	4*cr0+eq		/* set result to "success" */
-	bgelr	cr7
+BEGIN_FTR_SECTION
+	blr				/* No SLB cache, see switch_slb */
+FTR_SECTION_ELSE
+	bgelr	cr7			/* we're done for kernel addresses */
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 
-	/* Update the slb cache */
+	/* Update the slb cache for user addresses */
 	lhz	r9,PACASLBCACHEPTR(r13)	/* offset = paca->slb_cache_ptr */
 	cmpldi	r9,SLB_CACHE_ENTRIES
 	bge	1f
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 81f84b7a3ebb..0d9033462e67 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2391,10 +2391,13 @@ static void dump_one_paca(int cpu)
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
2.17.0
