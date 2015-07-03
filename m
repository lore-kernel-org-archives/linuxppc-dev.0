Return-Path: <apopple@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F41C81A0456
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 17:40:16 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BFF8E140777
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2015 17:40:16 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <apopple@au1.ibm.com>;
 Fri, 3 Jul 2015 17:40:15 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 01FC63578052
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2015 17:40:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t637e3fE31719554
 for <linuxppc-dev@ozlabs.org>; Fri, 3 Jul 2015 17:40:13 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t637dc0h017786
 for <linuxppc-dev@ozlabs.org>; Fri, 3 Jul 2015 17:39:39 +1000
From: Alistair Popple <alistair@popple.id.au>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, shreyas@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] opal-elog: Fix opal-elog interrupt handler
Date: Fri,  3 Jul 2015 17:39:12 +1000
Message-Id: <1435909152-18891-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The conversion of opal events to a proper irqchip means that handlers
are called until the relevant opal event has been cleared by
processing it. Events that queue work should therefore use a threaded
handler to mask the event until processing is complete.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/opal-elog.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 4949ef0..37f959b 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -237,7 +237,7 @@ static struct elog_obj *create_elog_obj(uint64_t id, size_t size, uint64_t type)
 	return elog;
 }
 
-static void elog_work_fn(struct work_struct *work)
+static irqreturn_t elog_event(int irq, void *data)
 {
 	__be64 size;
 	__be64 id;
@@ -251,7 +251,7 @@ static void elog_work_fn(struct work_struct *work)
 	rc = opal_get_elog_size(&id, &size, &type);
 	if (rc != OPAL_SUCCESS) {
 		pr_err("ELOG: OPAL log info read failed\n");
-		return;
+		return IRQ_HANDLED;
 	}
 
 	elog_size = be64_to_cpu(size);
@@ -270,16 +270,10 @@ static void elog_work_fn(struct work_struct *work)
 	 * entries.
 	 */
 	if (kset_find_obj(elog_kset, name))
-		return;
+		return IRQ_HANDLED;
 
 	create_elog_obj(log_id, elog_size, elog_type);
-}
-
-static DECLARE_WORK(elog_work, elog_work_fn);
 
-static irqreturn_t elog_event(int irq, void *data)
-{
-	schedule_work(&elog_work);
 	return IRQ_HANDLED;
 }
 
@@ -304,8 +298,8 @@ int __init opal_elog_init(void)
 		return irq;
 	}
 
-	rc = request_irq(irq, elog_event,
-			IRQ_TYPE_LEVEL_HIGH, "opal-elog", NULL);
+	rc = request_threaded_irq(irq, NULL, elog_event,
+			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "opal-elog", NULL);
 	if (rc) {
 		pr_err("%s: Can't request OPAL event irq (%d)\n",
 		       __func__, rc);
-- 
2.1.4
