Return-Path: <alistair.popple@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD1401A0A16
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:24:22 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair.popple@au1.ibm.com>;
 Thu, 2 Apr 2015 13:24:22 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 219FF2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:24:19 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t323OAZ528770526
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:24:19 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t323NiDC017887
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:23:45 +1100
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/8] powernv/opal-dump: Convert to irq domain
Date: Thu,  2 Apr 2015 14:22:31 +1100
Message-Id: <1427944952-17452-7-git-send-email-alistair@popple.id.au>
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

Convert the opal dump driver to the new opal irq domain.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/opal-dump.c | 33 +++++++++++++++---------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 23260f7..812f168 100644
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
@@ -408,24 +409,16 @@ static void schedule_process_dump(void)
  * Once we get notification, we add sysfs entries for it.
  * We only fetch the dump on demand, and create sysfs asynchronously.
  */
-static int dump_event(struct notifier_block *nb,
-		      unsigned long events, void *change)
+static irqreturn_t dump_event(int irq, void *data)
 {
-	if (events & OPAL_EVENT_DUMP_AVAIL)
-		schedule_process_dump();
+	schedule_process_dump();
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
-static struct notifier_block dump_nb = {
-	.notifier_call  = dump_event,
-	.next           = NULL,
-	.priority       = 0
-};
-
 void __init opal_platform_dump_init(void)
 {
-	int rc;
+	int rc, irq;
 
 	/* ELOG not supported by firmware */
 	if (!opal_check_token(OPAL_DUMP_READ))
@@ -445,10 +438,18 @@ void __init opal_platform_dump_init(void)
 		return;
 	}
 
-	rc = opal_notifier_register(&dump_nb);
+	irq = opal_event_request(ilog2(OPAL_EVENT_DUMP_AVAIL));
+	if (!irq) {
+		pr_err("%s: Can't register OPAL event irq (%d)\n",
+		       __func__, irq);
+		return;
+	}
+
+	rc = request_irq(irq, dump_event,
+			IRQ_TYPE_LEVEL_HIGH, "opal-dump", NULL);
 	if (rc) {
-		pr_warn("%s: Can't register OPAL event notifier (%d)\n",
-			__func__, rc);
+		pr_err("%s: Can't request OPAL event irq (%d)\n",
+		       __func__, rc);
 		return;
 	}
 
-- 
1.8.3.2
