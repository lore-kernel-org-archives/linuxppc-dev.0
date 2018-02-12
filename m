Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgBwK6SzpzF0pF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 04:09:05 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id f6so7898997pgs.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 09:09:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 11/12] powerpc/64: allocate per-cpu stacks node-local if
 possible
Date: Tue, 13 Feb 2018 03:08:21 +1000
Message-Id: <20180212170822.14612-12-npiggin@gmail.com>
In-Reply-To: <20180212170822.14612-1-npiggin@gmail.com>
References: <20180212170822.14612-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/setup_64.c | 51 ++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 02fa358982e6..16ea71fa1ead 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -611,6 +611,21 @@ __init u64 ppc64_bolted_size(void)
 #endif
 }
 
+static void *__init alloc_stack(unsigned long limit, int cpu)
+{
+	unsigned long pa;
+
+	pa = memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
+					early_cpu_to_node(cpu), MEMBLOCK_NONE);
+	if (!pa) {
+		pa = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
+		if (!pa)
+			panic("cannot allocate stacks");
+	}
+
+	return __va(pa);
+}
+
 void __init irqstack_early_init(void)
 {
 	u64 limit = ppc64_bolted_size();
@@ -622,12 +637,8 @@ void __init irqstack_early_init(void)
 	 * accessed in realmode.
 	 */
 	for_each_possible_cpu(i) {
-		softirq_ctx[i] = (struct thread_info *)
-			__va(memblock_alloc_base(THREAD_SIZE,
-					    THREAD_SIZE, limit));
-		hardirq_ctx[i] = (struct thread_info *)
-			__va(memblock_alloc_base(THREAD_SIZE,
-					    THREAD_SIZE, limit));
+		softirq_ctx[i] = alloc_stack(limit, i);
+		hardirq_ctx[i] = alloc_stack(limit, i);
 	}
 }
 
@@ -635,20 +646,21 @@ void __init irqstack_early_init(void)
 void __init exc_lvl_early_init(void)
 {
 	unsigned int i;
-	unsigned long sp;
 
 	for_each_possible_cpu(i) {
-		sp = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
-		critirq_ctx[i] = (struct thread_info *)__va(sp);
-		paca_ptrs[i]->crit_kstack = __va(sp + THREAD_SIZE);
+		void *sp;
 
-		sp = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
-		dbgirq_ctx[i] = (struct thread_info *)__va(sp);
-		paca_ptrs[i]->dbg_kstack = __va(sp + THREAD_SIZE);
+		sp = alloc_stack(ULONG_MAX, i);
+		critirq_ctx[i] = sp;
+		paca_ptrs[i]->crit_kstack = sp + THREAD_SIZE;
 
-		sp = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
-		mcheckirq_ctx[i] = (struct thread_info *)__va(sp);
-		paca_ptrs[i]->mc_kstack = __va(sp + THREAD_SIZE);
+		sp = alloc_stack(ULONG_MAX, i);
+		dbgirq_ctx[i] = sp;
+		paca_ptrs[i]->dbg_kstack = sp + THREAD_SIZE;
+
+		sp = alloc_stack(ULONG_MAX, i);
+		mcheckirq_ctx[i] = sp;
+		paca_ptrs[i]->mc_kstack = sp + THREAD_SIZE;
 	}
 
 	if (cpu_has_feature(CPU_FTR_DEBUG_LVL_EXC))
@@ -702,20 +714,21 @@ void __init emergency_stack_init(void)
 
 	for_each_possible_cpu(i) {
 		struct thread_info *ti;
-		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
+
+		ti = alloc_stack(limit, i);
 		memset(ti, 0, THREAD_SIZE);
 		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->emergency_sp = (void *)ti + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for NMI exception handling. */
-		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
+		ti = alloc_stack(limit, i);
 		memset(ti, 0, THREAD_SIZE);
 		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->nmi_emergency_sp = (void *)ti + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
-		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
+		ti = alloc_stack(limit, i);
 		memset(ti, 0, THREAD_SIZE);
 		emerg_stack_init_thread_info(ti, i);
 		paca_ptrs[i]->mc_emergency_sp = (void *)ti + THREAD_SIZE;
-- 
2.16.1
