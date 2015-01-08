Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE9251A0FAB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 16:42:38 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 8 Jan 2015 15:42:36 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E62292BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 16:42:34 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t085gYkh52756652
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jan 2015 16:42:34 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t085gYDZ031402
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jan 2015 16:42:34 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Don't alloc IRQ map if necessary
Date: Thu,  8 Jan 2015 16:42:32 +1100
Message-Id: <1420695752-924-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platform, the OPAL interrupts are exported by firmware
through device-node property (/ibm,opal::opal-interrupts). Under
some extreme circumstances (e.g. simulator), we don't have this
property found from the device tree. For that case, we shouldn't
allocate the interrupt map. Otherwise, slab complains allocating
zero sized memory chunk.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f10b9ec..e61cefe 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -726,11 +726,14 @@ static int __init opal_init(void)
 
 	/* Find all OPAL interrupts and request them */
 	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
+	opal_irq_count = irqs ? (irqlen / 4) : 0;
+	if (opal_irq_count)
+		opal_irqs = kzalloc(opal_irq_count * sizeof(unsigned int),
+				    GFP_KERNEL);
 	pr_debug("opal: Found %d interrupts reserved for OPAL\n",
-		 irqs ? (irqlen / 4) : 0);
-	opal_irq_count = irqlen / 4;
-	opal_irqs = kzalloc(opal_irq_count * sizeof(unsigned int), GFP_KERNEL);
-	for (i = 0; irqs && i < (irqlen / 4); i++, irqs++) {
+		 opal_irq_count);
+
+	for (i = 0; opal_irqs && i < opal_irq_count; i++, irqs++) {
 		unsigned int hwirq = be32_to_cpup(irqs);
 		unsigned int irq = irq_create_mapping(NULL, hwirq);
 		if (irq == NO_IRQ) {
@@ -775,7 +778,7 @@ void opal_shutdown(void)
 	long rc = OPAL_BUSY;
 
 	/* First free interrupts, which will also mask them */
-	for (i = 0; i < opal_irq_count; i++) {
+	for (i = 0; opal_irqs && i < opal_irq_count; i++) {
 		if (opal_irqs[i])
 			free_irq(opal_irqs[i], NULL);
 		opal_irqs[i] = 0;
-- 
1.8.3.2
