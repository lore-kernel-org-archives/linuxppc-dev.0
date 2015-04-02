Return-Path: <alistair.popple@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D5281A0748
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:23:59 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair.popple@au1.ibm.com>;
 Thu, 2 Apr 2015 13:23:57 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4767E2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:23:54 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t323Nkrl43188358
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:23:54 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t323NK0p016709
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:23:21 +1100
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/8] ipmi/powernv: Convert to irq event interface
Date: Thu,  2 Apr 2015 14:22:26 +1100
Message-Id: <1427944952-17452-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1427944952-17452-1-git-send-email-alistair@popple.id.au>
References: <1427944952-17452-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert the opal ipmi driver to use the new irq interface for events.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 drivers/char/ipmi/ipmi_powernv.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
index 79524ed..b3a2224 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -15,6 +15,8 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/interrupt.h>
 
 #include <asm/opal.h>
 
@@ -23,8 +25,7 @@ struct ipmi_smi_powernv {
 	u64			interface_id;
 	struct ipmi_device_id	ipmi_id;
 	ipmi_smi_t		intf;
-	u64			event;
-	struct notifier_block	event_nb;
+	unsigned int		irq;
 
 	/**
 	 * We assume that there can only be one outstanding request, so
@@ -196,15 +197,12 @@ static struct ipmi_smi_handlers ipmi_powernv_smi_handlers = {
 	.poll			= ipmi_powernv_poll,
 };
 
-static int ipmi_opal_event(struct notifier_block *nb,
-			  unsigned long events, void *change)
+static irqreturn_t ipmi_opal_event(int irq, void *data)
 {
-	struct ipmi_smi_powernv *smi = container_of(nb,
-					struct ipmi_smi_powernv, event_nb);
+	struct ipmi_smi_powernv *smi = data;
 
-	if (events & smi->event)
-		ipmi_powernv_recv(smi);
-	return 0;
+	ipmi_powernv_recv(smi);
+	return IRQ_HANDLED;
 }
 
 static int ipmi_powernv_probe(struct platform_device *pdev)
@@ -239,13 +237,16 @@ static int ipmi_powernv_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
-	ipmi->event = 1ull << prop;
-	ipmi->event_nb.notifier_call = ipmi_opal_event;
+	ipmi->irq = irq_of_parse_and_map(dev->of_node, 0);
+	if (!ipmi->irq) {
+		dev_info(dev, "Unable to map irq from device tree\n");
+		ipmi->irq = opal_event_request(prop);
+	}
 
-	rc = opal_notifier_register(&ipmi->event_nb);
-	if (rc) {
-		dev_warn(dev, "OPAL notifier registration failed (%d)\n", rc);
-		goto err_free;
+	if (request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
+				"opal-ipmi", ipmi)) {
+		dev_warn(dev, "Unable to request irq\n");
+		goto err_dispose;
 	}
 
 	ipmi->opal_msg = devm_kmalloc(dev,
@@ -270,7 +271,9 @@ static int ipmi_powernv_probe(struct platform_device *pdev)
 err_free_msg:
 	devm_kfree(dev, ipmi->opal_msg);
 err_unregister:
-	opal_notifier_unregister(&ipmi->event_nb);
+	free_irq(ipmi->irq, ipmi);
+err_dispose:
+	irq_dispose_mapping(ipmi->irq);
 err_free:
 	devm_kfree(dev, ipmi);
 	return rc;
@@ -281,7 +284,9 @@ static int ipmi_powernv_remove(struct platform_device *pdev)
 	struct ipmi_smi_powernv *smi = dev_get_drvdata(&pdev->dev);
 
 	ipmi_unregister_smi(smi->intf);
-	opal_notifier_unregister(&smi->event_nb);
+	free_irq(smi->irq, smi);
+	irq_dispose_mapping(smi->irq);
+
 	return 0;
 }
 
-- 
1.8.3.2
