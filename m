Return-Path: <alistair.popple@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27DEA1A104F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 13:17:53 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair.popple@au1.ibm.com>;
 Thu, 7 May 2015 13:17:53 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 089492BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 13:17:52 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t473HhTF23724106
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 13:17:51 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t473HJDN021921
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 13:17:19 +1000
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v3 7/8] powernv/opal-dump: Convert to irq domain
Date: Thu,  7 May 2015 13:16:17 +1000
Message-Id: <1430968578-23527-7-git-send-email-alistair@popple.id.au>
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

Convert the opal dump driver to the new opal irq domain.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/opal-dump.c | 56 +++++++++---------------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 5aa9c1c..2ee9643 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 
 #include <asm/opal.h>
 
@@ -60,7 +61,7 @@ static ssize_t dump_type_show(struct dump_obj *dump_obj,
 			      struct dump_attribute *attr,
 			      char *buf)
 {
-	
+
 	return sprintf(buf, "0x%x %s\n", dump_obj->type,
 		       dump_type_to_string(dump_obj->type));
 }
@@ -363,7 +364,7 @@ static struct dump_obj *create_dump_obj(uint32_t id, size_t size,
 	return dump;
 }
 
-static int process_dump(void)
+static irqreturn_t process_dump(int irq, void *data)
 {
 	int rc;
 	uint32_t dump_id, dump_size, dump_type;
@@ -387,45 +388,13 @@ static int process_dump(void)
 	if (!dump)
 		return -1;
 
-	return 0;
-}
-
-static void dump_work_fn(struct work_struct *work)
-{
-	process_dump();
+	return IRQ_HANDLED;
 }
 
-static DECLARE_WORK(dump_work, dump_work_fn);
-
-static void schedule_process_dump(void)
-{
-	schedule_work(&dump_work);
-}
-
-/*
- * New dump available notification
- *
- * Once we get notification, we add sysfs entries for it.
- * We only fetch the dump on demand, and create sysfs asynchronously.
- */
-static int dump_event(struct notifier_block *nb,
-		      unsigned long events, void *change)
-{
-	if (events & OPAL_EVENT_DUMP_AVAIL)
-		schedule_process_dump();
-
-	return 0;
-}
-
-static struct notifier_block dump_nb = {
-	.notifier_call  = dump_event,
-	.next           = NULL,
-	.priority       = 0
-};
-
 void __init opal_platform_dump_init(void)
 {
 	int rc;
+	int dump_irq;
 
 	/* ELOG not supported by firmware */
 	if (!opal_check_token(OPAL_DUMP_READ))
@@ -445,10 +414,19 @@ void __init opal_platform_dump_init(void)
 		return;
 	}
 
-	rc = opal_notifier_register(&dump_nb);
+	dump_irq = opal_event_request(ilog2(OPAL_EVENT_DUMP_AVAIL));
+	if (!dump_irq) {
+		pr_err("%s: Can't register OPAL event irq (%d)\n",
+		       __func__, dump_irq);
+		return;
+	}
+
+	rc = request_threaded_irq(dump_irq, NULL, process_dump,
+				IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+				"opal-dump", NULL);
 	if (rc) {
-		pr_warn("%s: Can't register OPAL event notifier (%d)\n",
-			__func__, rc);
+		pr_err("%s: Can't request OPAL event irq (%d)\n",
+		       __func__, rc);
 		return;
 	}
 
-- 
1.8.3.2
