Return-Path: <SRS0=voBx=EC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26460C388F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 09:11:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE0820747
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 09:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE0820747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CL5YF6y5SzDqRY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 20:11:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=107.174.27.60; helo=ozlabs.ru;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CL5T56895zDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2020 20:07:53 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 088B8AE8025F;
 Tue, 27 Oct 2020 05:06:36 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH kernel 1/2] irq: Add reference counting to IRQ mappings
Date: Tue, 27 Oct 2020 20:06:54 +1100
Message-Id: <20201027090655.14118-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027090655.14118-1-aik@ozlabs.ru>
References: <20201027090655.14118-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 Qian Cai <cai@lca.pw>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PCI devices share 4 legacy INTx interrupts from the same PCI host bridge.
Device drivers map/unmap hardware interrupts via irq_create_mapping()/
irq_dispose_mapping(). The problem with that these interrupts are
shared and when performing hot unplug, we need to unmap the interrupt
only when the last device is released.

This reuses already existing irq_desc::kobj for this purpose.
The refcounter is naturally 1 when the descriptor is allocated already;
this adds kobject_get() in places where already existing mapped virq
is returned.

This reorganizes irq_dispose_mapping() to release the kobj and let
the release callback do the cleanup.

If some driver or platform does its own reference counting, this expects
those parties to call irq_find_mapping() and call irq_dispose_mapping()
for every irq_create_fwspec_mapping()/irq_create_mapping().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 kernel/irq/irqdesc.c   | 35 +++++++++++++++++++++++------------
 kernel/irq/irqdomain.c | 27 +++++++++++++--------------
 2 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1a7723604399..dae096238500 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -419,20 +419,39 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 	return NULL;
 }
 
+static void delayed_free_desc(struct rcu_head *rhp);
 static void irq_kobj_release(struct kobject *kobj)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
+	struct irq_domain *domain;
+	unsigned int virq = desc->irq_data.irq;
 
-	free_masks(desc);
-	free_percpu(desc->kstat_irqs);
-	kfree(desc);
+	domain = desc->irq_data.domain;
+	if (domain) {
+		if (irq_domain_is_hierarchy(domain)) {
+			irq_domain_free_irqs(virq, 1);
+		} else {
+			irq_domain_disassociate(domain, virq);
+			irq_free_desc(virq);
+		}
+	}
+
+	/*
+	 * We free the descriptor, masks and stat fields via RCU. That
+	 * allows demultiplex interrupts to do rcu based management of
+	 * the child interrupts.
+	 * This also allows us to use rcu in kstat_irqs_usr().
+	 */
+	call_rcu(&desc->rcu, delayed_free_desc);
 }
 
 static void delayed_free_desc(struct rcu_head *rhp)
 {
 	struct irq_desc *desc = container_of(rhp, struct irq_desc, rcu);
 
-	kobject_put(&desc->kobj);
+	free_masks(desc);
+	free_percpu(desc->kstat_irqs);
+	kfree(desc);
 }
 
 static void free_desc(unsigned int irq)
@@ -453,14 +472,6 @@ static void free_desc(unsigned int irq)
 	 */
 	irq_sysfs_del(desc);
 	delete_irq_desc(irq);
-
-	/*
-	 * We free the descriptor, masks and stat fields via RCU. That
-	 * allows demultiplex interrupts to do rcu based management of
-	 * the child interrupts.
-	 * This also allows us to use rcu in kstat_irqs_usr().
-	 */
-	call_rcu(&desc->rcu, delayed_free_desc);
 }
 
 static int alloc_descs(unsigned int start, unsigned int cnt, int node,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf8b374b892d..02733ddc321f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -638,6 +638,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 {
 	struct device_node *of_node;
 	int virq;
+	struct irq_desc *desc;
 
 	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
 
@@ -655,7 +656,9 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 	/* Check if mapping already exists */
 	virq = irq_find_mapping(domain, hwirq);
 	if (virq) {
+		desc = irq_to_desc(virq);
 		pr_debug("-> existing mapping on virq %d\n", virq);
+		kobject_get(&desc->kobj);
 		return virq;
 	}
 
@@ -751,6 +754,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
 	int virq;
+	struct irq_desc *desc;
 
 	if (fwspec->fwnode) {
 		domain = irq_find_matching_fwspec(fwspec, DOMAIN_BUS_WIRED);
@@ -787,8 +791,11 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 		 * current trigger type then we are done so return the
 		 * interrupt number.
 		 */
-		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
+		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq)) {
+			desc = irq_to_desc(virq);
+			kobject_get(&desc->kobj);
 			return virq;
+		}
 
 		/*
 		 * If the trigger type has not been set yet, then set
@@ -800,6 +807,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 				return 0;
 
 			irqd_set_trigger_type(irq_data, type);
+			desc = irq_to_desc(virq);
+			kobject_get(&desc->kobj);
 			return virq;
 		}
 
@@ -852,22 +861,12 @@ EXPORT_SYMBOL_GPL(irq_create_of_mapping);
  */
 void irq_dispose_mapping(unsigned int virq)
 {
-	struct irq_data *irq_data = irq_get_irq_data(virq);
-	struct irq_domain *domain;
+	struct irq_desc *desc = irq_to_desc(virq);
 
-	if (!virq || !irq_data)
+	if (!virq || !desc)
 		return;
 
-	domain = irq_data->domain;
-	if (WARN_ON(domain == NULL))
-		return;
-
-	if (irq_domain_is_hierarchy(domain)) {
-		irq_domain_free_irqs(virq, 1);
-	} else {
-		irq_domain_disassociate(domain, virq);
-		irq_free_desc(virq);
-	}
+	kobject_put(&desc->kobj);
 }
 EXPORT_SYMBOL_GPL(irq_dispose_mapping);
 
-- 
2.17.1

