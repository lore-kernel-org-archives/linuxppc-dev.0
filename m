Return-Path: <SRS0=+0eX=E6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BE9C56201
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 06:24:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE312068D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 06:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE312068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CgDWQ3chfzDqNb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:24:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=107.174.27.60; helo=ozlabs.ru;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CgDNC5RhvzDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2020 17:18:03 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 894A2AE8024F;
 Tue, 24 Nov 2020 01:17:57 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH kernel v4 4/8] genirq: Free IRQ descriptor via embedded kobject
Date: Tue, 24 Nov 2020 17:17:16 +1100
Message-Id: <20201124061720.86766-5-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124061720.86766-1-aik@ozlabs.ru>
References: <20201124061720.86766-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Marc Zyngier <maz@kernel.org>,
 x86@kernel.org, linux-gpio@vger.kernel.org,
 Oliver O'Halloran <oohall@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

At the moment the IRQ descriptor is freed via the free_desc() helper.
We want to add reference counting to IRQ descriptors and there is already
kobj embedded into irq_desc which we want to reuse.

This shuffles free_desc()/etc to make it simply call kobject_put() and
moves all the cleanup into the kobject_release hook.

As a bonus, we do not need irq_sysfs_del() as kobj removes itself from
sysfs if it knows that it was added.

This should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 kernel/irq/irqdesc.c | 42 ++++++++++++------------------------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1a7723604399..75374b7944b5 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -295,18 +295,6 @@ static void irq_sysfs_add(int irq, struct irq_desc *desc)
 	}
 }
 
-static void irq_sysfs_del(struct irq_desc *desc)
-{
-	/*
-	 * If irq_sysfs_init() has not yet been invoked (early boot), then
-	 * irq_kobj_base is NULL and the descriptor was never added.
-	 * kobject_del() complains about a object with no parent, so make
-	 * it conditional.
-	 */
-	if (irq_kobj_base)
-		kobject_del(&desc->kobj);
-}
-
 static int __init irq_sysfs_init(void)
 {
 	struct irq_desc *desc;
@@ -337,7 +325,6 @@ static struct kobj_type irq_kobj_type = {
 };
 
 static void irq_sysfs_add(int irq, struct irq_desc *desc) {}
-static void irq_sysfs_del(struct irq_desc *desc) {}
 
 #endif /* CONFIG_SYSFS */
 
@@ -419,39 +406,34 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 	return NULL;
 }
 
-static void irq_kobj_release(struct kobject *kobj)
-{
-	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-
-	free_masks(desc);
-	free_percpu(desc->kstat_irqs);
-	kfree(desc);
-}
-
 static void delayed_free_desc(struct rcu_head *rhp)
 {
 	struct irq_desc *desc = container_of(rhp, struct irq_desc, rcu);
 
+	free_masks(desc);
+	free_percpu(desc->kstat_irqs);
+	kfree(desc);
+}
+
+static void free_desc(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
 	kobject_put(&desc->kobj);
 }
 
-static void free_desc(unsigned int irq)
+static void irq_kobj_release(struct kobject *kobj)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
+	unsigned int irq = desc->irq_data.irq;
 
 	irq_remove_debugfs_entry(desc);
 	unregister_irq_proc(irq, desc);
 
 	/*
-	 * sparse_irq_lock protects also show_interrupts() and
-	 * kstat_irq_usr(). Once we deleted the descriptor from the
-	 * sparse tree we can free it. Access in proc will fail to
-	 * lookup the descriptor.
-	 *
 	 * The sysfs entry must be serialized against a concurrent
 	 * irq_sysfs_init() as well.
 	 */
-	irq_sysfs_del(desc);
 	delete_irq_desc(irq);
 
 	/*
-- 
2.17.1

