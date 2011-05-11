Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id F34F4100966
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:38 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <63f9cdf070cbd291413224b6e2c0ab42d6c51801.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:22 -0500
Subject: [PATCH 31/37] powerpc: psurge: create a irq_host for secondary cpus
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create a dummy irq_host using the generic dummy irq chip for the secondary
cpus to use.  Create a direct irq mapping for the ipi and register the
ipi action handler against it.  If for some unlikely reason part of this
fails then don't detect the secondary cpus.

This removes another instance of NO_IRQ_IGNORE, records the ipi stats
for the secondary cpus, and runs the ipi on the interrupt stack.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
---
 arch/powerpc/platforms/powermac/pic.c  |    9 ++----
 arch/powerpc/platforms/powermac/pmac.h |    1 +
 arch/powerpc/platforms/powermac/smp.c  |   49 +++++++++++++++++++++++++++----
 3 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index b706cb3..360260d 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -240,12 +240,9 @@ static unsigned int pmac_pic_get_irq(void)
 	unsigned long flags;
 
 #ifdef CONFIG_PPC_PMAC32_PSURGE
-	void psurge_smp_message_recv(void);
-
-       	/* IPI's are a hack on the powersurge -- Cort */
-       	if ( smp_processor_id() != 0 ) {
-		psurge_smp_message_recv();
-		return NO_IRQ_IGNORE;	/* ignore, already handled */
+	/* IPI's are a hack on the powersurge -- Cort */
+	if (smp_processor_id() != 0) {
+		return  psurge_secondary_virq;
         }
 #endif /* CONFIG_PPC_PMAC32_PSURGE */
 	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
index 20468f4..8327cce 100644
--- a/arch/powerpc/platforms/powermac/pmac.h
+++ b/arch/powerpc/platforms/powermac/pmac.h
@@ -33,6 +33,7 @@ extern void pmac_setup_pci_dma(void);
 extern void pmac_check_ht_link(void);
 
 extern void pmac_setup_smp(void);
+extern int psurge_secondary_virq;
 extern void low_cpu_die(void) __attribute__((noreturn));
 
 extern int pmac_nvram_init(void);
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 67b6e14..db092d7 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -124,6 +124,10 @@ static volatile u32 __iomem *psurge_start;
 /* what sort of powersurge board we have */
 static int psurge_type = PSURGE_NONE;
 
+/* irq for secondary cpus to report */
+static struct irq_host *psurge_host;
+int psurge_secondary_virq;
+
 /*
  * Set and clear IPIs for powersurge.
  */
@@ -159,15 +163,11 @@ static inline void psurge_clr_ipi(int cpu)
  * use the generic demux helpers
  *  -- paulus.
  */
-void psurge_smp_message_recv(void)
+static irqreturn_t psurge_ipi_intr(int irq, void *d)
 {
 	psurge_clr_ipi(smp_processor_id());
 	smp_ipi_demux();
-}
 
-irqreturn_t psurge_primary_intr(int irq, void *d)
-{
-	psurge_smp_message_recv();
 	return IRQ_HANDLED;
 }
 
@@ -176,6 +176,38 @@ static void smp_psurge_cause_ipi(int cpu, unsigned long data)
 	psurge_set_ipi(cpu);
 }
 
+static int psurge_host_map(struct irq_host *h, unsigned int virq,
+			 irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_percpu_irq);
+
+	return 0;
+}
+
+struct irq_host_ops psurge_host_ops = {
+	.map	= psurge_host_map,
+};
+
+static int psurge_secondary_ipi_init(void)
+{
+	int rc = -ENOMEM;
+
+	psurge_host = irq_alloc_host(NULL, IRQ_HOST_MAP_NOMAP, 0,
+		&psurge_host_ops, 0);
+
+	if (psurge_host)
+		psurge_secondary_virq = irq_create_direct_mapping(psurge_host);
+
+	if (psurge_secondary_virq)
+		rc = request_irq(psurge_secondary_virq, psurge_ipi_intr,
+			IRQF_DISABLED|IRQF_PERCPU, "IPI", NULL);
+
+	if (rc)
+		pr_err("Failed to setup secondary cpu IPI\n");
+
+	return rc;
+}
+
 /*
  * Determine a quad card presence. We read the board ID register, we
  * force the data bus to change to something else, and we read it again.
@@ -284,6 +316,9 @@ static int __init smp_psurge_probe(void)
 		ncpus = 2;
 	}
 
+	if (psurge_secondary_ipi_init())
+		return 1;
+
 	psurge_start = ioremap(PSURGE_START, 4);
 	psurge_pri_intr = ioremap(PSURGE_PRI_INTR, 4);
 
@@ -372,8 +407,8 @@ static int __init smp_psurge_kick_cpu(int nr)
 }
 
 static struct irqaction psurge_irqaction = {
-	.handler = psurge_primary_intr,
-	.flags = IRQF_DISABLED,
+	.handler = psurge_ipi_intr,
+	.flags = IRQF_DISABLED|IRQF_PERCPU,
 	.name = "primary IPI",
 };
 
-- 
1.7.0.4
