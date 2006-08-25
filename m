Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5745667BFA
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Aug 2006 09:03:17 +1000 (EST)
Message-ID: <44EF8182.2000401@am.sony.com>
Date: Fri, 25 Aug 2006 16:02:26 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: powerpc virq: minor cleanups
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

Please consider these cleanups.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
Index: cell--common--4/arch/powerpc/kernel/irq.c
===================================================================
--- cell--common--4.orig/arch/powerpc/kernel/irq.c
+++ cell--common--4/arch/powerpc/kernel/irq.c
@@ -678,7 +680,7 @@
 }
 EXPORT_SYMBOL_GPL(irq_dispose_mapping);
 
-unsigned int irq_find_mapping(struct irq_host *host,
+unsigned int irq_find_mapping(const struct irq_host *host,
 			      irq_hw_number_t hwirq)
 {
 	unsigned int i;
Index: cell--common--4/include/asm-powerpc/irq.h
===================================================================
--- cell--common--4.orig/include/asm-powerpc/irq.h
+++ cell--common--4/include/asm-powerpc/irq.h
@@ -28,10 +28,10 @@
 
 #ifdef CONFIG_PPC_MERGE
 
-/* This number is used when no interrupt has been assigned */
+/* This number is used when no virq has been assigned */
 #define NO_IRQ			(0)
 
-/* This is a special irq number to return from get_irq() to tell that
+/* This is a special virq number to return from get_irq() to tell that
  * no interrupt happened _and_ ignore it (don't count it as bad). Some
  * platforms like iSeries rely on that.
  */
@@ -217,7 +222,7 @@
  * irq controller implementation directly calls the appropriate low level
  * mapping function.
  */
-extern unsigned int irq_find_mapping(struct irq_host *host,
+extern unsigned int irq_find_mapping(const struct irq_host *host,
 				     irq_hw_number_t hwirq);
 
 
