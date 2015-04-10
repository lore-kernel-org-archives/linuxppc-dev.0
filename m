Return-Path: <alistair.popple@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB39E1A1BCB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:26:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair.popple@au1.ibm.com>;
 Fri, 10 Apr 2015 18:26:03 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AAC403578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:26:00 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A8Pqbf47251600
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:26:00 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A8PRt3019014
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:25:27 +1000
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2 3/8] hvc: Convert to using interrupts instead of opal events
Date: Fri, 10 Apr 2015 18:24:49 +1000
Message-Id: <1428654294-9177-3-git-send-email-alistair@popple.id.au>
In-Reply-To: <1428654294-9177-1-git-send-email-alistair@popple.id.au>
References: <1428654294-9177-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert the opal hvc driver to use the new irqchip to register for
opal events. As older firmware versions may not have device tree
bindings for the interrupt parent we just use a hardcoded hwirq based
on the event number.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 drivers/tty/hvc/hvc_opal.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 071551b..71aac49 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/export.h>
+#include <linux/interrupt.h>
 
 #include <asm/hvconsole.h>
 #include <asm/prom.h>
@@ -162,27 +163,15 @@ static const struct hv_ops hvc_opal_hvsi_ops = {
 	.tiocmset = hvc_opal_hvsi_tiocmset,
 };
 
-static int hvc_opal_console_event(struct notifier_block *nb,
-				  unsigned long events, void *change)
-{
-	if (events & OPAL_EVENT_CONSOLE_INPUT)
-		hvc_kick();
-	return 0;
-}
-
-static struct notifier_block hvc_opal_console_nb = {
-	.notifier_call	= hvc_opal_console_event,
-};
-
 static int hvc_opal_probe(struct platform_device *dev)
 {
 	const struct hv_ops *ops;
 	struct hvc_struct *hp;
 	struct hvc_opal_priv *pv;
 	hv_protocol_t proto;
-	unsigned int termno, boot = 0;
+	unsigned int termno, irq, boot = 0;
 	const __be32 *reg;
-
+	int rc;
 
 	if (of_device_is_compatible(dev->dev.of_node, "ibm,opal-console-raw")) {
 		proto = HV_PROTOCOL_RAW;
@@ -227,18 +216,18 @@ static int hvc_opal_probe(struct platform_device *dev)
 		dev->dev.of_node->full_name,
 		boot ? " (boot console)" : "");
 
-	/* We don't do IRQ ... */
-	hp = hvc_alloc(termno, 0, ops, MAX_VIO_PUT_CHARS);
+	irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
+	if (!irq) {
+		pr_err("hvc_opal: Unable to map interrupt for device %s\n",
+			dev->dev.of_node->full_name);
+		return irq;
+	}
+
+	hp = hvc_alloc(termno, irq, ops, MAX_VIO_PUT_CHARS);
 	if (IS_ERR(hp))
 		return PTR_ERR(hp);
 	dev_set_drvdata(&dev->dev, hp);
 
-	/* ...  but we use OPAL event to kick the console */
-	if (!hvc_opal_event_registered) {
-		opal_notifier_register(&hvc_opal_console_nb);
-		hvc_opal_event_registered = true;
-	}
-
 	return 0;
 }
 
-- 
1.8.3.2
