Return-Path: <qiang.zhao@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe40::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQjZ34D25zDqp4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 13:24:27 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <tglx@linutronix.de>
CC: <oss@buserror.net>, <xiaobo.xie@nxp.com>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v10 3/4] irqchip/qeic: merge qeic_of_init into qe_ic_init
Date: Mon, 7 Aug 2017 11:07:15 +0800
Message-ID: <1502075236-24078-4-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1502075236-24078-1-git-send-email-qiang.zhao@nxp.com>
References: <1502075236-24078-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

qeic_of_init just get device_node of qeic from dtb and call qe_ic_init,
pass the device_node to qe_ic_init.
So merge qeic_of_init into qe_ic_init to get the qeic node in
qe_ic_init.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 drivers/irqchip/irq-qeic.c | 90 ++++++++++++++++++++--------------------------
 include/soc/fsl/qe/qe_ic.h |  7 ----
 2 files changed, 39 insertions(+), 58 deletions(-)

diff --git a/drivers/irqchip/irq-qeic.c b/drivers/irqchip/irq-qeic.c
index 8287c22..a2d8084 100644
--- a/drivers/irqchip/irq-qeic.c
+++ b/drivers/irqchip/irq-qeic.c
@@ -407,27 +407,33 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-void __init qe_ic_init(struct device_node *node, unsigned int flags,
-		       void (*low_handler)(struct irq_desc *desc),
-		       void (*high_handler)(struct irq_desc *desc))
+static int __init qe_ic_init(struct device_node *node, unsigned int flags)
 {
 	struct qe_ic *qe_ic;
 	struct resource res;
-	u32 temp = 0, ret, high_active = 0;
+	u32 temp = 0, high_active = 0;
+	int ret = 0;
+
+	if (!node)
+		return -ENODEV;
 
 	ret = of_address_to_resource(node, 0, &res);
-	if (ret)
-		return;
+	if (ret) {
+		ret = -ENODEV;
+		goto err_put_node;
+	}
 
 	qe_ic = kzalloc(sizeof(*qe_ic), GFP_KERNEL);
-	if (qe_ic == NULL)
-		return;
+	if (qe_ic == NULL) {
+		ret = -ENOMEM;
+		goto err_put_node;
+	}
 
 	qe_ic->irqhost = irq_domain_add_linear(node, NR_QE_IC_INTS,
 					       &qe_ic_host_ops, qe_ic);
 	if (qe_ic->irqhost == NULL) {
-		kfree(qe_ic);
-		return;
+		ret = -ENOMEM;
+		goto err_free_qe_ic;
 	}
 
 	qe_ic->regs = ioremap(res.start, resource_size(&res));
@@ -438,9 +444,9 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 	qe_ic->virq_low = irq_of_parse_and_map(node, 1);
 
 	if (qe_ic->virq_low == NO_IRQ) {
-		printk(KERN_ERR "Failed to map QE_IC low IRQ\n");
-		kfree(qe_ic);
-		return;
+		pr_err("Failed to map QE_IC low IRQ\n");
+		ret = -ENOMEM;
+		goto err_domain_remove;
 	}
 
 	/* default priority scheme is grouped. If spread mode is    */
@@ -467,13 +473,24 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
 
 	irq_set_handler_data(qe_ic->virq_low, qe_ic);
-	irq_set_chained_handler(qe_ic->virq_low, low_handler);
+	irq_set_chained_handler(qe_ic->virq_low, qe_ic_cascade_low_mpic);
 
 	if (qe_ic->virq_high != NO_IRQ &&
 			qe_ic->virq_high != qe_ic->virq_low) {
 		irq_set_handler_data(qe_ic->virq_high, qe_ic);
-		irq_set_chained_handler(qe_ic->virq_high, high_handler);
+		irq_set_chained_handler(qe_ic->virq_high,
+					qe_ic_cascade_high_mpic);
 	}
+	of_node_put(node);
+	return 0;
+
+err_domain_remove:
+	irq_domain_remove(qe_ic->irqhost);
+err_free_qe_ic:
+	kfree(qe_ic);
+err_put_node:
+	of_node_put(node);
+	return ret;
 }
 
 void qe_ic_set_highest_priority(unsigned int virq, int high)
@@ -570,45 +587,16 @@ int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
 	return 0;
 }
 
-static struct bus_type qe_ic_subsys = {
-	.name = "qe_ic",
-	.dev_name = "qe_ic",
-};
-
-static struct device device_qe_ic = {
-	.id = 0,
-	.bus = &qe_ic_subsys,
-};
-
-static int __init init_qe_ic_sysfs(void)
+static int __init init_qe_ic(struct device_node *node,
+			     struct device_node *parent)
 {
-	int rc;
-
-	printk(KERN_DEBUG "Registering qe_ic with sysfs...\n");
+	int ret;
 
-	rc = subsys_system_register(&qe_ic_subsys, NULL);
-	if (rc) {
-		printk(KERN_ERR "Failed registering qe_ic sys class\n");
-		return -ENODEV;
-	}
-	rc = device_register(&device_qe_ic);
-	if (rc) {
-		printk(KERN_ERR "Failed registering qe_ic sys device\n");
-		return -ENODEV;
-	}
-	return 0;
-}
+	ret = qe_ic_init(node, 0);
+	if (ret)
+		return ret;
 
-static int __init qeic_of_init(struct device_node *node,
-			       struct device_node *parent)
-{
-	if (!node)
-		return -ENODEV;
-	qe_ic_init(node, 0, qe_ic_cascade_low_mpic,
-		   qe_ic_cascade_high_mpic);
-	of_node_put(node);
 	return 0;
 }
 
-IRQCHIP_DECLARE(qeic, "fsl,qe-ic", qeic_of_init);
-subsys_initcall(init_qe_ic_sysfs);
+IRQCHIP_DECLARE(qeic, "fsl,qe-ic", init_qe_ic);
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index 1e155ca..6113699 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -58,16 +58,9 @@ enum qe_ic_grp_id {
 };
 
 #ifdef CONFIG_QUICC_ENGINE
-void qe_ic_init(struct device_node *node, unsigned int flags,
-		void (*low_handler)(struct irq_desc *desc),
-		void (*high_handler)(struct irq_desc *desc));
 unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic);
 unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic);
 #else
-static inline void qe_ic_init(struct device_node *node, unsigned int flags,
-		void (*low_handler)(struct irq_desc *desc),
-		void (*high_handler)(struct irq_desc *desc))
-{}
 static inline unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 { return 0; }
 static inline unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
-- 
2.1.0.27.g96db324
