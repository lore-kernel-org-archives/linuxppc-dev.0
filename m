Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14D4A67D22
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 21:18:41 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id kAFAIcTg022272
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 19:18:38 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id kAFAId3j019115
	for linuxppc-dev@ozlabs.org; Wed, 15 Nov 2006 19:18:39 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id kAFAIbMY006570
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 19:18:38 +0900 (JST)
Date: Wed, 15 Nov 2006 19:18:36 +0900 (JST)
Message-Id: <200611151018.kAFAIb3o028137@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/16] add IRQ remapping
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds irq remapping.
On interrupt mechanism on Beat, when an irq outlet who has an id
hich is formerly used is created, remapping the irq is required.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-2.6.19/arch/powerpc/kernel/irq.c
diff -u linux-2.6.19/arch/powerpc/kernel/irq.c:1.1.1.2 linux-2.6.19/arch/powerpc/kernel/irq.c:1.4
--- linux-2.6.19/arch/powerpc/kernel/irq.c:1.1.1.2	Tue Oct 17 08:40:57 2006
+++ linux-2.6.19/arch/powerpc/kernel/irq.c	Mon Nov  6 22:04:23 2006
@@ -534,6 +534,8 @@
 	 */
 	virq = irq_find_mapping(host, hwirq);
 	if (virq != IRQ_NONE) {
+		if (host->ops->remap)
+			host->ops->remap(host, virq, hwirq);
 		pr_debug("irq: -> existing mapping on virq %d\n", virq);
 		return virq;
 	}
Index: linux-2.6.19/include/asm-powerpc/irq.h
diff -u linux-2.6.19/include/asm-powerpc/irq.h:1.1.1.2 linux-2.6.19/include/asm-powerpc/irq.h:1.3
--- linux-2.6.19/include/asm-powerpc/irq.h:1.1.1.2	Tue Oct 17 08:44:31 2006
+++ linux-2.6.19/include/asm-powerpc/irq.h	Tue Oct 17 13:22:53 2006
@@ -89,6 +89,9 @@
 	/* Dispose of such a mapping */
 	void (*unmap)(struct irq_host *h, unsigned int virq);
 
+	/* Update of such a mapping  */
+	void (*remap)(struct irq_host *h, unsigned int virq, irq_hw_number_t hw);
+
 	/* Translate device-tree interrupt specifier from raw format coming
 	 * from the firmware to a irq_hw_number_t (interrupt line number) and
 	 * type (sense) that can be passed to set_irq_type(). In the absence
