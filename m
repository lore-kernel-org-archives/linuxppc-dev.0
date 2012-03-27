Return-Path: <B16395@freescale.com>
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <Linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/4] powerpc/mpic: Move internal interrupt source vector
 allocation to a separate function.
Date: Tue, 27 Mar 2012 17:46:26 +0530
Message-ID: <1332850586-23610-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allocate vector numbers for MPIC internal interrupt sources (IPIs and Timers) in a 
separate function.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 arch/powerpc/include/asm/mpic.h |    7 +++++--
 arch/powerpc/sysdev/mpic.c      |   30 +++++++++++++++++-------------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index 30e3b29..3929b4b 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -118,6 +118,9 @@
 #define MPIC_MAX_CPUS		32
 #define MPIC_MAX_ISU		32
 
+#define MPIC_MAX_TIMER    8
+#define MPIC_MAX_IPI      4
+
 /*
  * Tsi108 implementation of MPIC has many differences from the original one
  */
@@ -284,8 +287,8 @@ struct mpic
 	unsigned int		senses_count;
 
 	/* vector numbers used for internal sources (ipi/timers) */
-	unsigned int		ipi_vecs[4];
-	unsigned int		timer_vecs[8];
+	unsigned int		ipi_vecs[MPIC_MAX_IPI];
+	unsigned int		timer_vecs[MPIC_MAX_TIMER];
 
 	/* Spurious vector to program into unused sources */
 	unsigned int		spurious_vec;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 33520dd..c4da1d5 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -996,7 +996,8 @@ static int mpic_host_map(struct irq_host *h, unsigned int virq,
 	}
 #endif /* CONFIG_SMP */
 
-	if (hw >= mpic->timer_vecs[0] && hw <= mpic->timer_vecs[7]) {
+	if (hw >= mpic->timer_vecs[0] &&
+	    hw <= mpic->timer_vecs[MPIC_MAX_TIMER - 1]) {
 		WARN_ON(mpic->flags & MPIC_SECONDARY);
 
 		DBG("mpic: mapping as timer\n");
@@ -1133,6 +1134,19 @@ static struct irq_host_ops mpic_host_ops = {
 	.xlate = mpic_host_xlate,
 };
 
+static void mpic_alloc_int_sources(struct mpic *mpic, int intvec_top)
+{
+	int i, intvec;
+
+	intvec = intvec_top;
+
+	for (i = MPIC_MAX_IPI - 1; i >= 0; i--)
+		mpic->ipi_vecs[i] = --intvec;
+
+	for (i = MPIC_MAX_TIMER - 1; i >= 0; i--)
+		mpic->timer_vecs[i] = --intvec;
+}
+
 /*
  * Exported functions
  */
@@ -1228,18 +1242,6 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	else
 		intvec_top = 255;
 
-	mpic->timer_vecs[0] = intvec_top - 12;
-	mpic->timer_vecs[1] = intvec_top - 11;
-	mpic->timer_vecs[2] = intvec_top - 10;
-	mpic->timer_vecs[3] = intvec_top - 9;
-	mpic->timer_vecs[4] = intvec_top - 8;
-	mpic->timer_vecs[5] = intvec_top - 7;
-	mpic->timer_vecs[6] = intvec_top - 6;
-	mpic->timer_vecs[7] = intvec_top - 5;
-	mpic->ipi_vecs[0]   = intvec_top - 4;
-	mpic->ipi_vecs[1]   = intvec_top - 3;
-	mpic->ipi_vecs[2]   = intvec_top - 2;
-	mpic->ipi_vecs[3]   = intvec_top - 1;
 	mpic->spurious_vec  = intvec_top;
 
 	/* Look for protected sources */
@@ -1365,6 +1367,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
 	mpic->isu_mask = (1 << mpic->isu_shift) - 1;
 
+	mpic_alloc_int_sources(mpic, intvec_top);
+
 	mpic->irqhost = irq_alloc_host(mpic->node, IRQ_HOST_MAP_LINEAR,
 				       last_irq + 1, &mpic_host_ops,
 				       intvec_top + 1);
-- 
1.7.2.2
