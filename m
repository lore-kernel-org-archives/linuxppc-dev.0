Return-Path: <mware@elphinstone.net>
Received: from ipmail03.adl2.internode.on.net (ipmail03.adl2.internode.on.net
	[203.16.214.135]) by ozlabs.org (Postfix) with ESMTP id 059A81007D9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 13:15:32 +1100 (EST)
Message-ID: <4B0C9342.1000807@elphinstone.net>
Date: Wed, 25 Nov 2009 13:15:30 +1100
From: Mark Ware <mware@elphinstone.net>
MIME-Version: 1.0
To: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Subject: [PATCH] cpm2_pic: Allow correct flow_types for port C interrupts
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CPM2 Port C interrupts can be either falling edge, or either edge.
Other external interrupts are either falling edge or active low.

Signed-Off-By: Mark Ware <mware@elphinstone.net>
---
 arch/powerpc/sysdev/cpm2_pic.c |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index 78f1f7c..179822c 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -141,13 +141,28 @@ static int cpm2_set_irq_type(unsigned int virq, unsigned int flow_type)
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
+		if (flow_type & ~IRQ_TYPE_EDGE_BOTH) {
+			printk(KERN_ERR "CPM2 PIC: sense type 0x%x not supported\n",
+				flow_type);
+			return -EINVAL;
+		}
+	} else {
+		if (flow_type == IRQ_TYPE_NONE)
+			flow_type = IRQ_TYPE_LEVEL_LOW;
+
+		if (flow_type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH)) {
+			printk(KERN_ERR "CPM2 PIC: sense type 0x%x not supported\n",
+				flow_type);
+			return -EINVAL;
+		}
 	}
 
 	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
-- 
1.5.6.5
