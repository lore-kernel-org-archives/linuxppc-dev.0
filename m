Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 80F7267DA2
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 14:41:51 +1100 (EST)
Received: from mail6.sony.co.jp (localhost [127.0.0.1])
	by mail6.sony.co.jp (R8/Sony) with ESMTP id kAH3fjKL019522
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:41:45 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail6.sony.co.jp (R8/Sony) with SMTP id kAH3fjcs019505
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:41:45 +0900 (JST)
Message-ID: <455D2F73.9090900@am.sony.com>
Date: Thu, 16 Nov 2006 19:41:39 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/16] powerpc: add virq_to_hw accessor routine
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subject: powerpc: add virq_to_hw accessor routine

From: Geoff Levand <geoffrey.levand@am.sony.com>
This adds an accessor routine virq_to_hw() to the
virq routines which hides the implementation details
of the virq to hwirq map.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
 include/asm-powerpc/irq.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6/include/asm-powerpc/irq.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/irq.h
+++ linux-2.6/include/asm-powerpc/irq.h
@@ -135,6 +135,10 @@ struct irq_map_entry {
 
 extern struct irq_map_entry irq_map[NR_IRQS];
 
+static inline irq_hw_number_t virq_to_hw(unsigned int virq)
+{
+	return irq_map[virq].hwirq;
+}
 
 /**
  * irq_alloc_host - Allocate a new irq_host data structure
