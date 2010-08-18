Return-Path: <shaggy@linux.vnet.ibm.com>
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: [PATCH 3/4] powerpc/4xx: Index interrupt stacks by physical cpu
Date: Wed, 18 Aug 2010 11:44:25 -0500
Message-Id: <1282149866-4710-4-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1282149866-4710-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1282149866-4710-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The interrupt stacks need to be indexed by the physical cpu since the
critical, debug and machine check handlers use the contents of SPRN_PIR to
index the critirq_ctx, dbgirq_ctx, and mcheckirq_ctx arrays.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/irq.c      |   15 ++++++++-------
 arch/powerpc/kernel/setup_32.c |    9 +++++----
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index d3ce67c..52e9c95 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -446,22 +446,23 @@ struct thread_info *mcheckirq_ctx[NR_CPUS] __read_mostly;
 void exc_lvl_ctx_init(void)
 {
 	struct thread_info *tp;
-	int i;
+	int i, hw_cpu;
 
 	for_each_possible_cpu(i) {
-		memset((void *)critirq_ctx[i], 0, THREAD_SIZE);
-		tp = critirq_ctx[i];
+		hw_cpu = get_hard_smp_processor_id(i);
+		memset((void *)critirq_ctx[hw_cpu], 0, THREAD_SIZE);
+		tp = critirq_ctx[hw_cpu];
 		tp->cpu = i;
 		tp->preempt_count = 0;
 
 #ifdef CONFIG_BOOKE
-		memset((void *)dbgirq_ctx[i], 0, THREAD_SIZE);
-		tp = dbgirq_ctx[i];
+		memset((void *)dbgirq_ctx[hw_cpu], 0, THREAD_SIZE);
+		tp = dbgirq_ctx[hw_cpu];
 		tp->cpu = i;
 		tp->preempt_count = 0;
 
-		memset((void *)mcheckirq_ctx[i], 0, THREAD_SIZE);
-		tp = mcheckirq_ctx[i];
+		memset((void *)mcheckirq_ctx[hw_cpu], 0, THREAD_SIZE);
+		tp = mcheckirq_ctx[hw_cpu];
 		tp->cpu = i;
 		tp->preempt_count = HARDIRQ_OFFSET;
 #endif
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a10ffc8..93666f9 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -258,17 +258,18 @@ static void __init irqstack_early_init(void)
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 static void __init exc_lvl_early_init(void)
 {
-	unsigned int i;
+	unsigned int i, hw_cpu;
 
 	/* interrupt stacks must be in lowmem, we get that for free on ppc32
 	 * as the memblock is limited to lowmem by MEMBLOCK_REAL_LIMIT */
 	for_each_possible_cpu(i) {
-		critirq_ctx[i] = (struct thread_info *)
+		hw_cpu = get_hard_smp_processor_id(i);
+		critirq_ctx[hw_cpu] = (struct thread_info *)
 			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
 #ifdef CONFIG_BOOKE
-		dbgirq_ctx[i] = (struct thread_info *)
+		dbgirq_ctx[hw_cpu] = (struct thread_info *)
 			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
-		mcheckirq_ctx[i] = (struct thread_info *)
+		mcheckirq_ctx[hw_cpu] = (struct thread_info *)
 			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
 #endif
 	}
-- 
1.7.1
