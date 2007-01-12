Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5337CDDE01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 11:58:44 +1100 (EST)
Date: Fri, 12 Jan 2007 09:58:39 +0900 (JST)
Message-Id: <200701120058.l0C0wdqV023874@toshiba.co.jp>
Subject: [PATCH 5/19] powerpc: add IRQ remapping hook
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds irq remapping hook. On interrupt mechanism on Beat,
when an irq outlet who has an id which is formerly used is created,
remapping the irq is required.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-powerpc-git/include/asm-powerpc/irq.h
diff -u linux-powerpc-git/include/asm-powerpc/irq.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/irq.h:1.2
--- linux-powerpc-git/include/asm-powerpc/irq.h:1.1.1.1	Wed Dec  6 08:24:04 2006
+++ linux-powerpc-git/include/asm-powerpc/irq.h	Wed Dec  6 08:43:16 2006
@@ -89,6 +89,9 @@
 	/* Dispose of such a mapping */
 	void (*unmap)(struct irq_host *h, unsigned int virq);
 
+	/* Update of such a mapping  */
+	void (*remap)(struct irq_host *h, unsigned int virq, irq_hw_number_t hw);
+
 	/* Translate device-tree interrupt specifier from raw format coming
 	 * from the firmware to a irq_hw_number_t (interrupt line number) and
 	 * type (sense) that can be passed to set_irq_type(). In the absence
Index: linux-powerpc-git/arch/powerpc/kernel/irq.c
diff -u linux-powerpc-git/arch/powerpc/kernel/irq.c:1.1.1.1 linux-powerpc-git/arch/powerpc/kernel/irq.c:1.2
--- linux-powerpc-git/arch/powerpc/kernel/irq.c:1.1.1.1	Wed Dec  6 08:25:43 2006
+++ linux-powerpc-git/arch/powerpc/kernel/irq.c	Wed Dec  6 08:43:14 2006
@@ -604,6 +604,8 @@
 	 */
 	virq = irq_find_mapping(host, hwirq);
 	if (virq != IRQ_NONE) {
+		if (host->ops->remap)
+			host->ops->remap(host, virq, hwirq);
 		pr_debug("irq: -> existing mapping on virq %d\n", virq);
 		return virq;
 	}
