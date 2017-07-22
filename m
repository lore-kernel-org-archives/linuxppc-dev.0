Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDqWf3GnfzDqy0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 11:18:06 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id z1so6524365pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 18:18:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 04/11] powerpc/64s: Relax PACA address limitations
Date: Sat, 22 Jul 2017 11:17:34 +1000
Message-Id: <20170722011741.13942-5-npiggin@gmail.com>
In-Reply-To: <20170722011741.13942-1-npiggin@gmail.com>
References: <20170722011741.13942-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Book3S radix-mode has no SLB interrupt limitation, and hash-mode has
a 1T limitation on modern CPUs.

Update the paca alloation limits to match the stack allocation. Book3E
still needs a look.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/paca.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 8d63627e067f..fd7deb79110a 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -194,22 +194,39 @@ void setup_paca(struct paca_struct *new_paca)
 
 static int __initdata paca_size;
 
-void __init allocate_pacas(void)
+static __init unsigned long safe_paca_limit(void)
 {
-	u64 limit;
-	int cpu;
+	unsigned long limit = ULONG_MAX;
 
-	limit = ppc64_rma_size;
-
-#ifdef CONFIG_PPC_BOOK3S_64
 	/*
-	 * We can't take SLB misses on the paca, and we want to access them
-	 * in real mode, so allocate them within the RMA and also within
-	 * the first segment.
+	 * We access pacas in real mode, so allocate them within real mode
+	 * constraints.
 	 */
-	limit = min(0x10000000ULL, limit);
+	limit = min((unsigned long)ppc64_rma_size, limit);
+
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (!early_radix_enabled()) {
+		/*
+		 * We can't take SLB misses on the paca, so allocate them
+		 * within the first segment.
+		 */
+		if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
+			limit = min(1UL << SID_SHIFT_1T, limit);
+		else
+			limit = min(1UL << SID_SHIFT, limit);
+	}
 #endif
 
+	/* XXX: what about Book3E? (e.g., see safe_stack_limit) */
+
+	return limit;
+}
+
+void __init allocate_pacas(void)
+{
+	unsigned long limit = safe_paca_limit();
+	int cpu;
+
 	paca_size = PAGE_ALIGN(sizeof(struct paca_struct) * nr_cpu_ids);
 
 	paca = __va(memblock_alloc_base(paca_size, PAGE_SIZE, limit));
-- 
2.11.0
