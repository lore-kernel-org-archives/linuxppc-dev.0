Return-Path: <alistair.popple@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 114DE1A0E1D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 13:17:56 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair.popple@au1.ibm.com>;
 Thu, 7 May 2015 13:17:54 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F119D2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 13:17:51 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t473Hivx5177582
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 13:17:52 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t473HJSk029156
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 13:17:19 +1000
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v3 6/8] powernv/elog: Convert elog to opal irq domain
Date: Thu,  7 May 2015 13:16:16 +1000
Message-Id: <1430968578-23527-6-git-send-email-alistair@popple.id.au>
In-Reply-To: <1430968578-23527-1-git-send-email-alistair@popple.id.au>
References: <1430968578-23527-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch converts the elog code to use the opal irq domain instead
of notifier events.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/opal-elog.c | 32 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 38ce757..4949ef0 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -10,6 +10,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -276,24 +277,15 @@ static void elog_work_fn(struct work_struct *work)
 
 static DECLARE_WORK(elog_work, elog_work_fn);
 
-static int elog_event(struct notifier_block *nb,
-				unsigned long events, void *change)
+static irqreturn_t elog_event(int irq, void *data)
 {
-	/* check for error log event */
-	if (events & OPAL_EVENT_ERROR_LOG_AVAIL)
-		schedule_work(&elog_work);
-	return 0;
+	schedule_work(&elog_work);
+	return IRQ_HANDLED;
 }
 
-static struct notifier_block elog_nb = {
-	.notifier_call  = elog_event,
-	.next           = NULL,
-	.priority       = 0
-};
-
 int __init opal_elog_init(void)
 {
-	int rc = 0;
+	int rc = 0, irq;
 
 	/* ELOG not supported by firmware */
 	if (!opal_check_token(OPAL_ELOG_READ))
@@ -305,10 +297,18 @@ int __init opal_elog_init(void)
 		return -1;
 	}
 
-	rc = opal_notifier_register(&elog_nb);
+	irq = opal_event_request(ilog2(OPAL_EVENT_ERROR_LOG_AVAIL));
+	if (!irq) {
+		pr_err("%s: Can't register OPAL event irq (%d)\n",
+		       __func__, irq);
+		return irq;
+	}
+
+	rc = request_irq(irq, elog_event,
+			IRQ_TYPE_LEVEL_HIGH, "opal-elog", NULL);
 	if (rc) {
-		pr_err("%s: Can't register OPAL event notifier (%d)\n",
-		__func__, rc);
+		pr_err("%s: Can't request OPAL event irq (%d)\n",
+		       __func__, rc);
 		return rc;
 	}
 
-- 
1.8.3.2
