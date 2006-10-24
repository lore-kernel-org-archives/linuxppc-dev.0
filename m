Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 24 Oct 2006 13:37:34 +1000
Subject: [PATCH] Make irq_dispose_mapping(NO_IRQ) a nop
Message-Id: <20061024033735.AF71B67B6D@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It makes for a friendlier API if irq_dispose_mapping(NO_IRQ) is a
nop, rather than triggering a WARN_ON.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/irq.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: git/arch/powerpc/kernel/irq.c
===================================================================
--- git.orig/arch/powerpc/kernel/irq.c
+++ git/arch/powerpc/kernel/irq.c
@@ -626,10 +626,14 @@ EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
 
 void irq_dispose_mapping(unsigned int virq)
 {
-	struct irq_host *host = irq_map[virq].host;
+	struct irq_host *host;
 	irq_hw_number_t hwirq;
 	unsigned long flags;
 
+	if (virq == NO_IRQ)
+		return;
+
+	host = irq_map[virq].host;
 	WARN_ON (host == NULL);
 	if (host == NULL)
 		return;
