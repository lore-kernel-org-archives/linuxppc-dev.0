Return-Path: <mware@elphinstone.net>
Received: from ipmail02.adl6.internode.on.net (ipmail02.adl6.internode.on.net
	[203.16.214.140]) by ozlabs.org (Postfix) with ESMTP id 78F89B6F19
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 22:14:35 +1100 (EST)
Message-ID: <4B20D81A.7010503@elphinstone.net>
Date: Thu, 10 Dec 2009 22:14:34 +1100
From: Mark Ware <mware@elphinstone.net>
MIME-Version: 1.0
To: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Subject: [PATCH v3] cpm2_pic: Allow correct flow_types for port C interrupts
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Port C interrupts can be either falling edge, or either edge.
Other external interrupts are either falling edge or active low.
Tested on a custom 8280 based board.

Signed-off-by: Mark Ware <mware@elphinstone.net>
---
Changed in v3:
- Cosmetic improvements as suggested by Anton and Scott
- Added tested note to changelog

 arch/powerpc/sysdev/cpm2_pic.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index 78f1f7c..b1e9206 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -141,13 +141,23 @@ static int cpm2_set_irq_type(unsigned int virq, unsigned int flow_type)
 	struct irq_desc *desc = get_irq_desc(virq);
 	unsigned int vold, vnew, edibit;
 
-	if (flow_type == IRQ_TYPE_NONE)
-		flow_type = IRQ_TYPE_LEVEL_LOW;
-
-	if (flow_type & IRQ_TYPE_EDGE_RISING) {
-		printk(KERN_ERR "CPM2 PIC: sense type 0x%x not supported\n",
-			flow_type);
-		return -EINVAL;
+	/* Port C interrupts are either IRQ_TYPE_EDGE_FALLING or
+	 * IRQ_TYPE_EDGE_BOTH (default).  All others are IRQ_TYPE_EDGE_FALLING
+	 * or IRQ_TYPE_LEVEL_LOW (default)
+	 */
+	if (src >= CPM2_IRQ_PORTC15 && src <= CPM2_IRQ_PORTC0) {
+		if (flow_type == IRQ_TYPE_NONE)
+			flow_type = IRQ_TYPE_EDGE_BOTH;
+
+		if (flow_type != IRQ_TYPE_EDGE_BOTH &&
+		    flow_type != IRQ_TYPE_EDGE_FALLING)
+			goto err_sense;
+	} else {
+		if (flow_type == IRQ_TYPE_NONE)
+			flow_type = IRQ_TYPE_LEVEL_LOW;
+
+		if (flow_type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH))
+			goto err_sense;
 	}
 
 	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
@@ -179,6 +189,10 @@ static int cpm2_set_irq_type(unsigned int virq, unsigned int flow_type)
 	if (vold != vnew)
 		out_be32(&cpm2_intctl->ic_siexr, vnew);
 	return 0;
+
+err_sense:
+	pr_err("CPM2 PIC: sense type 0x%x not supported\n", flow_type);
+	return -EINVAL;
 }
 
 static struct irq_chip cpm2_pic = {
-- 
1.5.6.5
