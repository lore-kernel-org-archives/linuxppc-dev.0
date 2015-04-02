Return-Path: <alistair.popple@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AAD561A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:24:01 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair.popple@au1.ibm.com>;
 Thu, 2 Apr 2015 13:23:59 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DFBEE2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:23:54 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t323Nk7N46792764
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:23:54 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t323NL6g016738
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:23:21 +1100
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/8] powernv/opal: Convert opal message events to opal irq
 domain
Date: Thu,  2 Apr 2015 14:22:29 +1100
Message-Id: <1427944952-17452-5-git-send-email-alistair@popple.id.au>
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

This patch converts the opal message event to use the new opal irq
domain.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/opal.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 1d73b85..b37f0fc 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -356,33 +356,34 @@ static void opal_handle_message(void)
 	opal_message_do_notify(type, (void *)&msg);
 }
 
-static int opal_message_notify(struct notifier_block *nb,
-			  unsigned long events, void *change)
+static irqreturn_t opal_message_notify(int irq, void *data)
 {
-	if (events & OPAL_EVENT_MSG_PENDING)
-		opal_handle_message();
-	return 0;
+	opal_handle_message();
+	return IRQ_HANDLED;
 }
 
-static struct notifier_block opal_message_nb = {
-	.notifier_call	= opal_message_notify,
-	.next		= NULL,
-	.priority	= 0,
-};
-
 static int __init opal_message_init(void)
 {
-	int ret, i;
+	int ret, i, irq;
 
 	for (i = 0; i < OPAL_MSG_TYPE_MAX; i++)
 		ATOMIC_INIT_NOTIFIER_HEAD(&opal_msg_notifier_head[i]);
 
-	ret = opal_notifier_register(&opal_message_nb);
+	irq = opal_event_request(ilog2(OPAL_EVENT_MSG_PENDING));
+	if (!irq) {
+		pr_err("%s: Can't register OPAL event irq (%d)\n",
+		       __func__, irq);
+		return irq;
+	}
+
+	ret = request_irq(irq, opal_message_notify,
+			IRQ_TYPE_LEVEL_HIGH, "opal-msg", NULL);
 	if (ret) {
-		pr_err("%s: Can't register OPAL event notifier (%d)\n",
+		pr_err("%s: Can't request OPAL event irq (%d)\n",
 		       __func__, ret);
 		return ret;
 	}
+
 	return 0;
 }
 machine_early_initcall(powernv, opal_message_init);
-- 
1.8.3.2
