Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <91cec5c64da4ca31a025fc7c45d9f1b93c8b98da.1255499081.git.michael@ellerman.id.au>
In-Reply-To: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 6/6] powerpc: Enable sparse irq_descs on powerpc
Date: Wed, 14 Oct 2009 16:45:03 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Defining CONFIG_SPARSE_IRQ enables generic code that gets rid of the
static irq_desc array, and replaces it with an array of pointers to
irq_descs.

It also allows node local allocation of irq_descs, however we
currently don't have the information available to do that, so we just
allocate them on all on node 0.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig            |   13 ++++++++++++
 arch/powerpc/include/asm/irq.h  |    3 ++
 arch/powerpc/kernel/irq.c       |   40 ++++++++++++++++++++++++++++++++------
 arch/powerpc/kernel/ppc_ksyms.c |    1 -
 arch/powerpc/kernel/setup_64.c  |    5 ----
 5 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2230e75..825d889 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -388,6 +388,19 @@ config IRQ_ALL_CPUS
 	  CPU.  Generally saying Y is safe, although some problems have been
 	  reported with SMP Power Macintoshes with this option enabled.
 
+config SPARSE_IRQ
+	bool "Support sparse irq numbering"
+	default y
+	help
+	  This enables support for sparse irqs. This is useful for distro
+	  kernels that want to define a high CONFIG_NR_CPUS value but still
+	  want to have low kernel memory footprint on smaller machines.
+
+	  ( Sparse IRQs can also be beneficial on NUMA boxes, as they spread
+	    out the irq_desc[] array in a more NUMA-friendly way. )
+
+	  If you don't know what to do here, say Y.
+
 config NUMA
 	bool "NUMA support"
 	depends on PPC64
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 03dc28c..c85a32f 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -38,6 +38,9 @@ extern atomic_t ppc_n_lost_interrupts;
 /* Number of irqs reserved for the legacy controller */
 #define NUM_ISA_INTERRUPTS	16
 
+/* Same thing, used by the generic IRQ code */
+#define NR_IRQS_LEGACY		NUM_ISA_INTERRUPTS
+
 /* This type is the placeholder for a hardware interrupt number. It has to
  * be big enough to enclose whatever representation is used by a given
  * platform.
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 63e27d5..eba5392 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -85,7 +85,10 @@ extern int tau_interrupts(int);
 #endif /* CONFIG_PPC32 */
 
 #ifdef CONFIG_PPC64
+
+#ifndef CONFIG_SPARSE_IRQ
 EXPORT_SYMBOL(irq_desc);
+#endif
 
 int distribute_irqs = 1;
 
@@ -613,8 +616,16 @@ void irq_set_virq_count(unsigned int count)
 static int irq_setup_virq(struct irq_host *host, unsigned int virq,
 			    irq_hw_number_t hwirq)
 {
+	struct irq_desc *desc;
+
+	desc = irq_to_desc_alloc_node(virq, 0);
+	if (!desc) {
+		pr_debug("irq: -> allocating desc failed\n");
+		goto error;
+	}
+
 	/* Clear IRQ_NOREQUEST flag */
-	irq_to_desc(virq)->status &= ~IRQ_NOREQUEST;
+	desc->status &= ~IRQ_NOREQUEST;
 
 	/* map it */
 	smp_wmb();
@@ -623,11 +634,14 @@ static int irq_setup_virq(struct irq_host *host, unsigned int virq,
 
 	if (host->ops->map(host, virq, hwirq)) {
 		pr_debug("irq: -> mapping failed, freeing\n");
-		irq_free_virt(virq, 1);
-		return -1;
+		goto error;
 	}
 
 	return 0;
+
+error:
+	irq_free_virt(virq, 1);
+	return -1;
 }
 
 unsigned int irq_create_direct_mapping(struct irq_host *host)
@@ -1008,12 +1022,24 @@ void irq_free_virt(unsigned int virq, unsigned int count)
 	spin_unlock_irqrestore(&irq_big_lock, flags);
 }
 
-void irq_early_init(void)
+int arch_early_irq_init(void)
 {
-	unsigned int i;
+	struct irq_desc *desc;
+	int i;
 
-	for (i = 0; i < NR_IRQS; i++)
-		irq_to_desc(i)->status |= IRQ_NOREQUEST;
+	for (i = 0; i < NR_IRQS; i++) {
+		desc = irq_to_desc(i);
+		if (desc)
+			desc->status |= IRQ_NOREQUEST;
+	}
+
+	return 0;
+}
+
+int arch_init_chip_data(struct irq_desc *desc, int node)
+{
+	desc->status |= IRQ_NOREQUEST;
+	return 0;
 }
 
 /* We need to create the radix trees late */
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index c8b27bb..07115d6 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -162,7 +162,6 @@ EXPORT_SYMBOL(screen_info);
 
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(timer_interrupt);
-EXPORT_SYMBOL(irq_desc);
 EXPORT_SYMBOL(tb_ticks_per_jiffy);
 EXPORT_SYMBOL(cacheable_memcpy);
 EXPORT_SYMBOL(cacheable_memzero);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 797ea95..8e5ec92 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -357,11 +357,6 @@ void __init setup_system(void)
 	 */
 	initialize_cache_info();
 
-	/*
-	 * Initialize irq remapping subsystem
-	 */
-	irq_early_init();
-
 #ifdef CONFIG_PPC_RTAS
 	/*
 	 * Initialize RTAS if available
-- 
1.6.2.1
