Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 083ECB6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Mar 2011 05:28:39 +1100 (EST)
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH 2/2] powerpc: xics: use hwirq for xics domain irq number
To: linuxppc-dev@lists.ozlabs.org
Message-id: <xics-mask-irq-hwirq@mdm.bga.com>
In-Reply-To: <patches-for-39-rc1@mdm.bga.com>
References: <patches-for-39-rc1@mdm.bga.com>
Date: Mon, 21 Mar 2011 12:12:13 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To try to avoid future confusion, rename irq to hwirq when it refers
to a xics domain number instead of a linux irq number.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: next.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/xics.c	2011-03-19 23:21:21.775085058 -0500
+++ next.git/arch/powerpc/platforms/pseries/xics.c	2011-03-20 00:57:33.144560092 -0500
@@ -204,33 +204,33 @@ static int get_irq_server(unsigned int v
 
 static void xics_unmask_irq(struct irq_data *d)
 {
-	unsigned int irq;
+	unsigned int hwirq;
 	int call_status;
 	int server;
 
 	pr_devel("xics: unmask virq %d\n", d->irq);
 
-	irq = (unsigned int)irq_map[d->irq].hwirq;
-	pr_devel(" -> map to hwirq 0x%x\n", irq);
-	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
+	hwirq = (unsigned int)irq_map[d->irq].hwirq;
+	pr_devel(" -> map to hwirq 0x%x\n", hwirq);
+	if (hwirq == XICS_IPI || hwirq == XICS_IRQ_SPURIOUS)
 		return;
 
 	server = get_irq_server(d->irq, d->affinity, 0);
 
-	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
+	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, hwirq, server,
 				DEFAULT_PRIORITY);
 	if (call_status != 0) {
 		printk(KERN_ERR
 			"%s: ibm_set_xive irq %u server %x returned %d\n",
-			__func__, irq, server, call_status);
+			__func__, hwirq, server, call_status);
 		return;
 	}
 
 	/* Now unmask the interrupt (often a no-op) */
-	call_status = rtas_call(ibm_int_on, 1, 1, NULL, irq);
+	call_status = rtas_call(ibm_int_on, 1, 1, NULL, hwirq);
 	if (call_status != 0) {
 		printk(KERN_ERR "%s: ibm_int_on irq=%u returned %d\n",
-			__func__, irq, call_status);
+			__func__, hwirq, call_status);
 		return;
 	}
 }
@@ -276,14 +276,14 @@ static void xics_mask_real_irq(unsigned 
 
 static void xics_mask_irq(struct irq_data *d)
 {
-	unsigned int irq;
+	unsigned int hwirq;
 
 	pr_devel("xics: mask virq %d\n", d->irq);
 
-	irq = (unsigned int)irq_map[d->irq].hwirq;
-	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
+	hwirq = (unsigned int)irq_map[d->irq].hwirq;
+	if (hwirq == XICS_IPI || hwirq == XICS_IRQ_SPURIOUS)
 		return;
-	xics_mask_real_irq(irq);
+	xics_mask_real_irq(hwirq);
 }
 
 static void xics_mask_unknown_vec(unsigned int vec)
@@ -373,37 +373,37 @@ static unsigned char pop_cppr(void)
 
 static void xics_eoi_direct(struct irq_data *d)
 {
-	unsigned int irq = (unsigned int)irq_map[d->irq].hwirq;
+	unsigned int hwirq = (unsigned int)irq_map[d->irq].hwirq;
 
 	iosync();
-	direct_xirr_info_set((pop_cppr() << 24) | irq);
+	direct_xirr_info_set((pop_cppr() << 24) | hwirq);
 }
 
 static void xics_eoi_lpar(struct irq_data *d)
 {
-	unsigned int irq = (unsigned int)irq_map[d->irq].hwirq;
+	unsigned int hwirq = (unsigned int)irq_map[d->irq].hwirq;
 
 	iosync();
-	lpar_xirr_info_set((pop_cppr() << 24) | irq);
+	lpar_xirr_info_set((pop_cppr() << 24) | hwirq);
 }
 
 static int
 xics_set_affinity(struct irq_data *d, const struct cpumask *cpumask, bool force)
 {
-	unsigned int irq;
+	unsigned int hwirq;
 	int status;
 	int xics_status[2];
 	int irq_server;
 
-	irq = (unsigned int)irq_map[d->irq].hwirq;
-	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
+	hwirq = (unsigned int)irq_map[d->irq].hwirq;
+	if (hwirq == XICS_IPI || hwirq == XICS_IRQ_SPURIOUS)
 		return -1;
 
-	status = rtas_call(ibm_get_xive, 1, 3, xics_status, irq);
+	status = rtas_call(ibm_get_xive, 1, 3, xics_status, hwirq);
 
 	if (status) {
 		printk(KERN_ERR "%s: ibm,get-xive irq=%u returns %d\n",
-			__func__, irq, status);
+			__func__, hwirq, status);
 		return -1;
 	}
 
@@ -418,11 +418,11 @@ xics_set_affinity(struct irq_data *d, co
 	}
 
 	status = rtas_call(ibm_set_xive, 3, 1, NULL,
-				irq, irq_server, xics_status[1]);
+				hwirq, irq_server, xics_status[1]);
 
 	if (status) {
 		printk(KERN_ERR "%s: ibm,set-xive irq=%u returns %d\n",
-			__func__, irq, status);
+			__func__, hwirq, status);
 		return -1;
 	}
 
@@ -874,7 +874,7 @@ void xics_kexec_teardown_cpu(int seconda
 void xics_migrate_irqs_away(void)
 {
 	int cpu = smp_processor_id(), hw_cpu = hard_smp_processor_id();
-	unsigned int irq, virq;
+	int virq;
 
 	/* If we used to be the default server, move to the new "boot_cpuid" */
 	if (hw_cpu == default_server)
@@ -892,6 +892,7 @@ void xics_migrate_irqs_away(void)
 	for_each_irq(virq) {
 		struct irq_desc *desc;
 		struct irq_chip *chip;
+		unsigned int hwirq;
 		int xics_status[2];
 		int status;
 		unsigned long flags;
@@ -901,9 +902,9 @@ void xics_migrate_irqs_away(void)
 			continue;
 		if (irq_map[virq].host != xics_host)
 			continue;
-		irq = (unsigned int)irq_map[virq].hwirq;
+		hwirq = (unsigned int)irq_map[virq].hwirq;
 		/* We need to get IPIs still. */
-		if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
+		if (hwirq == XICS_IPI || hwirq == XICS_IRQ_SPURIOUS)
 			continue;
 
 		desc = irq_to_desc(virq);
@@ -918,10 +919,10 @@ void xics_migrate_irqs_away(void)
 
 		raw_spin_lock_irqsave(&desc->lock, flags);
 
-		status = rtas_call(ibm_get_xive, 1, 3, xics_status, irq);
+		status = rtas_call(ibm_get_xive, 1, 3, xics_status, hwirq);
 		if (status) {
 			printk(KERN_ERR "%s: ibm,get-xive irq=%u returns %d\n",
-					__func__, irq, status);
+					__func__, hwirq, status);
 			goto unlock;
 		}
 
