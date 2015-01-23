Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DAE4B1A0DF0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:26:09 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 23 Jan 2015 13:26:08 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EFC7E357804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:26:05 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0N3Pvn446334178
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:26:05 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0N3PWPa001178
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:25:32 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] powerpc/powernv: Don't alloc IRQ map if necessary
Date: Fri, 23 Jan 2015 14:25:06 +1100
Message-Id: <1421983506-17034-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1421983506-17034-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1421983506-17034-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
v2: rebased on seperate function for OPAL IRQ setup
---
 arch/powerpc/platforms/powernv/opal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 411975c..b3a2c66 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -702,11 +702,12 @@ static void __init opal_irq_init(struct device_node *dn)
 
 	/* Get interrupt property */
 	irqs = of_get_property(opal_node, "opal-interrupts", &irqlen);
-	pr_debug("opal: Found %d interrupts reserved for OPAL\n",
-		 irqs ? (irqlen / 4) : 0);
+	opal_irq_count = irqs ? (irqlen / 4) : 0;
+	pr_debug("opal: Found %d interrupts reserved for OPAL\n", opal_irq_count);
+	if (!opal_irq_count)
+		return;
 
 	/* Install interrupt handlers */
-	opal_irq_count = irqlen / 4;
 	opal_irqs = kzalloc(opal_irq_count * sizeof(unsigned int), GFP_KERNEL);
 	for (i = 0; irqs && i < opal_irq_count; i++, irqs++) {
 		unsigned int irq, virq;
-- 
1.8.3.2
