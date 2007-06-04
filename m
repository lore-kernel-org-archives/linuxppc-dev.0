Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 10B34DDE03
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 14:41:04 +1000 (EST)
Date: Sun, 3 Jun 2007 23:47:04 -0500
To: paulus@samba.org
Subject: [PATCH] [2.6.22] powerpc: uninline and export virq_to_hw()
Message-ID: <20070604044704.GA27581@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Uninline virq_to_hw and export it so modules can use it. The alternative
would be to export the irq_map array instead, but it's an infrequently
called function, and keeping the array unexported seems considerably
cleaner.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 068377a..0df86cc 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -412,6 +412,12 @@ struct irq_map_entry irq_map[NR_IRQS];
 static unsigned int irq_virq_count = NR_IRQS;
 static struct irq_host *irq_default_host;
 
+irq_hw_number_t virq_to_hw(unsigned int virq)
+{
+	return irq_map[virq].hwirq;
+}
+EXPORT_SYMBOL_GPL(virq_to_hw);
+
 struct irq_host *irq_alloc_host(unsigned int revmap_type,
 				unsigned int revmap_arg,
 				struct irq_host_ops *ops,
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 4734cc1..05dd5a3 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -138,10 +138,7 @@ struct irq_map_entry {
 
 extern struct irq_map_entry irq_map[NR_IRQS];
 
-static inline irq_hw_number_t virq_to_hw(unsigned int virq)
-{
-	return irq_map[virq].hwirq;
-}
+extern irq_hw_number_t virq_to_hw(unsigned int virq);
 
 /**
  * irq_alloc_host - Allocate a new irq_host data structure
