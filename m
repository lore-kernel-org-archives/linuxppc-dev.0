Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e0347e8cf1b0c69031cc32f217dbd4adf953f678.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 11/15] powerpc: Index crit/dbg/mcheck stacks using cpu number
	on 64bit
Date: Fri, 15 Apr 2011 18:32:04 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org,
	kumar.gala@freescale.com, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

In exc_lvl_ctx_init() we index into the crit/dbg/mcheck stacks using
the hard cpu id, but that assumes the hard cpu id is zero based and
contiguous. That is not the case on A2.

The root of the problem is that the 32bit code has no equivalent of the
paca to allow it to do the hard->soft mapping in assembler. Until the
32bit code is updated to handle that, index the stacks using the soft
cpu ids on 64bit and hard on 32 bit.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ac32ba1..4f5d6e7 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -397,24 +397,28 @@ struct thread_info *mcheckirq_ctx[NR_CPUS] __read_mostly;
 void exc_lvl_ctx_init(void)
 {
 	struct thread_info *tp;
-	int i, hw_cpu;
+	int i, cpu_nr;
 
 	for_each_possible_cpu(i) {
-		hw_cpu = get_hard_smp_processor_id(i);
-		memset((void *)critirq_ctx[hw_cpu], 0, THREAD_SIZE);
-		tp = critirq_ctx[hw_cpu];
-		tp->cpu = i;
+#ifdef CONFIG_PPC64
+		cpu_nr = i;
+#else
+		cpu_nr = get_hard_smp_processor_id(i);
+#endif
+		memset((void *)critirq_ctx[cpu_nr], 0, THREAD_SIZE);
+		tp = critirq_ctx[cpu_nr];
+		tp->cpu = cpu_nr;
 		tp->preempt_count = 0;
 
 #ifdef CONFIG_BOOKE
-		memset((void *)dbgirq_ctx[hw_cpu], 0, THREAD_SIZE);
-		tp = dbgirq_ctx[hw_cpu];
-		tp->cpu = i;
+		memset((void *)dbgirq_ctx[cpu_nr], 0, THREAD_SIZE);
+		tp = dbgirq_ctx[cpu_nr];
+		tp->cpu = cpu_nr;
 		tp->preempt_count = 0;
 
-		memset((void *)mcheckirq_ctx[hw_cpu], 0, THREAD_SIZE);
-		tp = mcheckirq_ctx[hw_cpu];
-		tp->cpu = i;
+		memset((void *)mcheckirq_ctx[cpu_nr], 0, THREAD_SIZE);
+		tp = mcheckirq_ctx[cpu_nr];
+		tp->cpu = cpu_nr;
 		tp->preempt_count = HARDIRQ_OFFSET;
 #endif
 	}
-- 
1.7.1
