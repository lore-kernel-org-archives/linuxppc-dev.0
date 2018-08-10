Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mwYM1N7pzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 16:43:02 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id l9-v6so4047429pff.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Aug 2018 23:43:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] powerpc/64s: move machine check SLB flushing to
 mm/slb.c
Date: Fri, 10 Aug 2018 16:42:48 +1000
Message-Id: <20180810064249.13724-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The machine check code that flushes and restores bolted segments in
real mode belongs in mm/slb.c. This will also be used by pseries
machine check and idle code in future changes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Since v1:
- Restore the test for slb_shadow (mpe)
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  3 ++
 arch/powerpc/kernel/mce_power.c               | 26 +++++--------
 arch/powerpc/mm/slb.c                         | 39 +++++++++++++++++++
 3 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 2f74bdc805e0..d4e398185b3a 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -497,6 +497,9 @@ extern void hpte_init_native(void);
 
 extern void slb_initialize(void);
 extern void slb_flush_and_rebolt(void);
+extern void slb_flush_all_realmode(void);
+extern void __slb_restore_bolted_realmode(void);
+extern void slb_restore_bolted_realmode(void);
 
 extern void slb_vmalloc_update(void);
 extern void slb_set_size(u16 size);
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index d6756af6ec78..3497c8329c1d 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -62,11 +62,8 @@ static unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 #ifdef CONFIG_PPC_BOOK3S_64
 static void flush_and_reload_slb(void)
 {
-	struct slb_shadow *slb;
-	unsigned long i, n;
-
 	/* Invalidate all SLBs */
-	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
+	slb_flush_all_realmode();
 
 #ifdef CONFIG_KVM_BOOK3S_HANDLER
 	/*
@@ -76,22 +73,17 @@ static void flush_and_reload_slb(void)
 	if (get_paca()->kvm_hstate.in_guest)
 		return;
 #endif
-
-	/* For host kernel, reload the SLBs from shadow SLB buffer. */
-	slb = get_slb_shadow();
-	if (!slb)
+	if (early_radix_enabled())
 		return;
 
-	n = min_t(u32, be32_to_cpu(slb->persistent), SLB_MIN_SIZE);
-
-	/* Load up the SLB entries from shadow SLB */
-	for (i = 0; i < n; i++) {
-		unsigned long rb = be64_to_cpu(slb->save_area[i].esid);
-		unsigned long rs = be64_to_cpu(slb->save_area[i].vsid);
+	/*
+	 * This probably shouldn't happen, but it may be possible it's
+	 * called in early boot before SLB shadows are allocated.
+	 */
+	if (!get_slb_shadow())
+		return;
 
-		rb = (rb & ~0xFFFul) | i;
-		asm volatile("slbmte %0,%1" : : "r" (rs), "r" (rb));
-	}
+	slb_restore_bolted_realmode();
 }
 #endif
 
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index cb796724a6fc..0b095fa54049 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -90,6 +90,45 @@ static inline void create_shadowed_slbe(unsigned long ea, int ssize,
 		     : "memory" );
 }
 
+/*
+ * Insert bolted entries into SLB (which may not be empty, so don't clear
+ * slb_cache_ptr).
+ */
+void __slb_restore_bolted_realmode(void)
+{
+	struct slb_shadow *p = get_slb_shadow();
+	enum slb_index index;
+
+	 /* No isync needed because realmode. */
+	for (index = 0; index < SLB_NUM_BOLTED; index++) {
+		asm volatile("slbmte  %0,%1" :
+		     : "r" (be64_to_cpu(p->save_area[index].vsid)),
+		       "r" (be64_to_cpu(p->save_area[index].esid)));
+	}
+}
+
+/*
+ * Insert the bolted entries into an empty SLB.
+ * This is not the same as rebolt because the bolted segments are not
+ * changed, just loaded from the shadow area.
+ */
+void slb_restore_bolted_realmode(void)
+{
+	__slb_restore_bolted_realmode();
+	get_paca()->slb_cache_ptr = 0;
+}
+
+/*
+ * This flushes all SLB entries including 0, so it must be realmode.
+ */
+void slb_flush_all_realmode(void)
+{
+	/*
+	 * This flushes all SLB entries including 0, so it must be realmode.
+	 */
+	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
+}
+
 static void __slb_flush_and_rebolt(void)
 {
 	/* If you change this make sure you change SLB_NUM_BOLTED
-- 
2.17.0
