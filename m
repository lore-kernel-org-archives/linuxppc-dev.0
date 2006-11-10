Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 6E95F67F0D
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 07:02:00 +1100 (EST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8/Sony) with ESMTP id kAAK1wXG026223
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:01:59 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail2.sony.co.jp (R8/Sony) with SMTP id kAAK1wqY026209
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:01:58 +0900 (JST)
Message-ID: <4554DAB1.6050903@am.sony.com>
Date: Fri, 10 Nov 2006 12:01:53 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/16] powerpc: add virq_to_hw accessor routine
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds an accessor routine virq_to_hw() to the
virq routines which hides the implementation details
of the virq to hwirq map.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 include/asm-powerpc/irq.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: cell--common--6/include/asm-powerpc/irq.h
===================================================================
--- cell--common--6.orig/include/asm-powerpc/irq.h
+++ cell--common--6/include/asm-powerpc/irq.h
@@ -135,6 +135,10 @@
 
 extern struct irq_map_entry irq_map[NR_IRQS];
 
+static inline irq_hw_number_t virq_to_hw(unsigned int virq)
+{
+	return irq_map[virq].hwirq;
+}
 
 /**
  * irq_alloc_host - Allocate a new irq_host data structure
