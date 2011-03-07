Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39018B72C5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:49 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:45 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/28] powerpc: platforms/pseries irq_data conversion.
Message-ID: <20110307235945.GS16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1299541392.git.buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/powerpc/platforms/pseries/setup.c |    5 ++-
 arch/powerpc/platforms/pseries/xics.c  |   89 +++++++++++++++++---------------
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index d345bfd..2a0089a 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -114,10 +114,13 @@ static void __init fwnmi_init(void)
 
 static void pseries_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
+
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static void __init pseries_setup_i8259_cascade(void)
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 7b96e5a..01fea46 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -202,20 +202,20 @@ static int get_irq_server(unsigned int virq, const struct cpumask *cpumask,
 #define get_irq_server(virq, cpumask, strict_check) (default_server)
 #endif
 
-static void xics_unmask_irq(unsigned int virq)
+static void xics_unmask_irq(struct irq_data *d)
 {
 	unsigned int irq;
 	int call_status;
 	int server;
 
-	pr_devel("xics: unmask virq %d\n", virq);
+	pr_devel("xics: unmask virq %d\n", d->irq);
 
-	irq = (unsigned int)irq_map[virq].hwirq;
+	irq = (unsigned int)irq_map[d->irq].hwirq;
 	pr_devel(" -> map to hwirq 0x%x\n", irq);
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = get_irq_server(virq, irq_to_desc(virq)->affinity, 0);
+	server = get_irq_server(d->irq, d->affinity, 0);
 
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
 				DEFAULT_PRIORITY);
@@ -235,61 +235,61 @@ static void xics_unmask_irq(unsigned int virq)
 	}
 }
 
-static unsigned int xics_startup(unsigned int virq)
+static unsigned int xics_startup(struct irq_data *d)
 {
 	/*
 	 * The generic MSI code returns with the interrupt disabled on the
 	 * card, using the MSI mask bits. Firmware doesn't appear to unmask
 	 * at that level, so we do it here by hand.
 	 */
-	if (irq_to_desc(virq)->msi_desc)
-		unmask_msi_irq(irq_get_irq_data(virq));
+	if (d->msi_desc)
+		unmask_msi_irq(d);
 
 	/* unmask it */
-	xics_unmask_irq(virq);
+	xics_unmask_irq(d);
 	return 0;
 }
 
-static void xics_mask_real_irq(unsigned int irq)
+static void xics_mask_real_irq(struct irq_data *d)
 {
 	int call_status;
 
-	if (irq == XICS_IPI)
+	if (d->irq == XICS_IPI)
 		return;
 
-	call_status = rtas_call(ibm_int_off, 1, 1, NULL, irq);
+	call_status = rtas_call(ibm_int_off, 1, 1, NULL, d->irq);
 	if (call_status != 0) {
 		printk(KERN_ERR "%s: ibm_int_off irq=%u returned %d\n",
-			__func__, irq, call_status);
+			__func__, d->irq, call_status);
 		return;
 	}
 
 	/* Have to set XIVE to 0xff to be able to remove a slot */
-	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq,
+	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, d->irq,
 				default_server, 0xff);
 	if (call_status != 0) {
 		printk(KERN_ERR "%s: ibm_set_xive(0xff) irq=%u returned %d\n",
-			__func__, irq, call_status);
+			__func__, d->irq, call_status);
 		return;
 	}
 }
 
-static void xics_mask_irq(unsigned int virq)
+static void xics_mask_irq(struct irq_data *d)
 {
 	unsigned int irq;
 
-	pr_devel("xics: mask virq %d\n", virq);
+	pr_devel("xics: mask virq %d\n", d->irq);
 
-	irq = (unsigned int)irq_map[virq].hwirq;
+	irq = (unsigned int)irq_map[d->irq].hwirq;
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return;
-	xics_mask_real_irq(irq);
+	xics_mask_real_irq(d);
 }
 
 static void xics_mask_unknown_vec(unsigned int vec)
 {
 	printk(KERN_ERR "Interrupt %u (real) is invalid, disabling it.\n", vec);
-	xics_mask_real_irq(vec);
+	xics_mask_real_irq(irq_get_irq_data(vec));
 }
 
 static inline unsigned int xics_xirr_vector(unsigned int xirr)
@@ -371,30 +371,31 @@ static unsigned char pop_cppr(void)
 	return os_cppr->stack[--os_cppr->index];
 }
 
-static void xics_eoi_direct(unsigned int virq)
+static void xics_eoi_direct(struct irq_data *d)
 {
-	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
+	unsigned int irq = (unsigned int)irq_map[d->irq].hwirq;
 
 	iosync();
 	direct_xirr_info_set((pop_cppr() << 24) | irq);
 }
 
-static void xics_eoi_lpar(unsigned int virq)
+static void xics_eoi_lpar(struct irq_data *d)
 {
-	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
+	unsigned int irq = (unsigned int)irq_map[d->irq].hwirq;
 
 	iosync();
 	lpar_xirr_info_set((pop_cppr() << 24) | irq);
 }
 
-static int xics_set_affinity(unsigned int virq, const struct cpumask *cpumask)
+static int
+xics_set_affinity(struct irq_data *d, const struct cpumask *cpumask, bool force)
 {
 	unsigned int irq;
 	int status;
 	int xics_status[2];
 	int irq_server;
 
-	irq = (unsigned int)irq_map[virq].hwirq;
+	irq = (unsigned int)irq_map[d->irq].hwirq;
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return -1;
 
@@ -406,13 +407,13 @@ static int xics_set_affinity(unsigned int virq, const struct cpumask *cpumask)
 		return -1;
 	}
 
-	irq_server = get_irq_server(virq, cpumask, 1);
+	irq_server = get_irq_server(d->irq, cpumask, 1);
 	if (irq_server == -1) {
 		char cpulist[128];
 		cpumask_scnprintf(cpulist, sizeof(cpulist), cpumask);
 		printk(KERN_WARNING
 			"%s: No online cpus in the mask %s for irq %d\n",
-			__func__, cpulist, virq);
+			__func__, cpulist, d->irq);
 		return -1;
 	}
 
@@ -430,20 +431,20 @@ static int xics_set_affinity(unsigned int virq, const struct cpumask *cpumask)
 
 static struct irq_chip xics_pic_direct = {
 	.name = "XICS",
-	.startup = xics_startup,
-	.mask = xics_mask_irq,
-	.unmask = xics_unmask_irq,
-	.eoi = xics_eoi_direct,
-	.set_affinity = xics_set_affinity
+	.irq_startup = xics_startup,
+	.irq_mask = xics_mask_irq,
+	.irq_unmask = xics_unmask_irq,
+	.irq_eoi = xics_eoi_direct,
+	.irq_set_affinity = xics_set_affinity
 };
 
 static struct irq_chip xics_pic_lpar = {
 	.name = "XICS",
-	.startup = xics_startup,
-	.mask = xics_mask_irq,
-	.unmask = xics_unmask_irq,
-	.eoi = xics_eoi_lpar,
-	.set_affinity = xics_set_affinity
+	.irq_startup = xics_startup,
+	.irq_mask = xics_mask_irq,
+	.irq_unmask = xics_unmask_irq,
+	.irq_eoi = xics_eoi_lpar,
+	.irq_set_affinity = xics_set_affinity
 };
 
 
@@ -890,6 +891,7 @@ void xics_migrate_irqs_away(void)
 
 	for_each_irq(virq) {
 		struct irq_desc *desc;
+		struct irq_chip *chip;
 		int xics_status[2];
 		int status;
 		unsigned long flags;
@@ -903,12 +905,15 @@ void xics_migrate_irqs_away(void)
 		/* We need to get IPIs still. */
 		if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 			continue;
+
 		desc = irq_to_desc(virq);
 
 		/* We only need to migrate enabled IRQS */
-		if (desc == NULL || desc->chip == NULL
-		    || desc->action == NULL
-		    || desc->chip->set_affinity == NULL)
+		if (desc == NULL || desc->action == NULL)
+			continue;
+
+		chip = get_irq_desc_chip(desc);
+		if (chip == NULL || chip->irq_set_affinity == NULL)
 			continue;
 
 		raw_spin_lock_irqsave(&desc->lock, flags);
@@ -934,8 +939,8 @@ void xics_migrate_irqs_away(void)
 			       virq, cpu);
 
 		/* Reset affinity to all cpus */
-		cpumask_setall(irq_to_desc(virq)->affinity);
-		desc->chip->set_affinity(virq, cpu_all_mask);
+		cpumask_setall(desc->irq_data.affinity);
+		chip->irq_set_affinity(&desc->irq_data, cpu_all_mask, true);
 unlock:
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
-- 
1.7.4
