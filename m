Return-Path: <alistair.popple@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC4CF1A0631
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:24:01 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair.popple@au1.ibm.com>;
 Thu, 2 Apr 2015 13:23:59 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 82A94357804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:23:54 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t323Nkkb50462872
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:23:54 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t323NLtx029871
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:23:21 +1100
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/8] hvc: Convert to using interrupts instead of opal events
Date: Thu,  2 Apr 2015 14:22:27 +1100
Message-Id: <1427944952-17452-3-git-send-email-alistair@popple.id.au>
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

Convert the opal hvc driver to use the new irqchip to register for
opal events. As older firmware version may not have device tree
bindings for the interrupt parent we just use a hardcoded hwirq based
on the event number.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 drivers/tty/hvc/hvc_opal.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 071551b..240283e 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/export.h>
+#include <linux/interrupt.h>
 
 #include <asm/hvconsole.h>
 #include <asm/prom.h>
@@ -162,27 +163,21 @@ static const struct hv_ops hvc_opal_hvsi_ops = {
 	.tiocmset = hvc_opal_hvsi_tiocmset,
 };
 
-static int hvc_opal_console_event(struct notifier_block *nb,
-				  unsigned long events, void *change)
+static irqreturn_t hvc_opal_console_event(int irq, void *data)
 {
-	if (events & OPAL_EVENT_CONSOLE_INPUT)
-		hvc_kick();
+	hvc_kick();
 	return 0;
 }
 
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
@@ -235,7 +230,19 @@ static int hvc_opal_probe(struct platform_device *dev)
 
 	/* ...  but we use OPAL event to kick the console */
 	if (!hvc_opal_event_registered) {
-		opal_notifier_register(&hvc_opal_console_nb);
+		irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
+		if (!irq) {
+			pr_err("hvc_opal: Unable to map interrupt for device %s\n",
+				dev->dev.of_node->full_name);
+			return irq;
+		}
+		rc = request_irq(irq, hvc_opal_console_event,
+				IRQ_TYPE_LEVEL_HIGH, "opal-hvc", NULL);
+		if (rc) {
+			pr_err("hvc_opal: Unable to request interrput for device %s\n",
+				dev->dev.of_node->full_name);
+			return rc;
+		}
 		hvc_opal_event_registered = true;
 	}
 
-- 
1.8.3.2
