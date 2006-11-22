Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail96-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2CD2F67C4D
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 15:19:52 +1100 (EST)
Message-ID: <4563CFE1.5050700@am.sony.com>
Date: Tue, 21 Nov 2006 20:19:45 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/14] powerpc: add virq_to_hw accessor routine
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

Subject: powerpc: add virq_to_hw accessor routine

From: Geoff Levand <geoffrey.levand@am.sony.com>

This adds an accessor routine virq_to_hw() to the
virq routines which hides the implementation details
of the virq to hwirq map.


Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 include/asm-powerpc/irq.h |    4 ++++
 1 files changed, 4 insertions(+)

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
