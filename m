Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4519C67A3F
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 01:03:13 +1000 (EST)
Message-ID: <44F305AA.5020101@am.sony.com>
Date: Mon, 28 Aug 2006 08:03:06 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc virq: new routine virq_to_hw
References: <44EF818B.9080301@am.sony.com>
	<1156728139.8433.413.camel@localhost.localdomain>
In-Reply-To: <1156728139.8433.413.camel@localhost.localdomain>
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

Benjamin Herrenschmidt wrote:
> I'd much prefer:
> 
> static inline irq_hw_number_t virq_to_hw (unsigned int virq)
> {
> 	return irq_map[virq].hwirq;
> }

Here is an updated version.

-Geoff


This adds an accessor routine virq_to_hw() to the
virq routines which hides the implementation details
of the virq to hwirq map.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
Index: cell--common--4/include/asm-powerpc/irq.h
===================================================================
--- cell--common--4.orig/include/asm-powerpc/irq.h
+++ cell--common--4/include/asm-powerpc/irq.h
@@ -136,6 +136,10 @@
 
 extern struct irq_map_entry irq_map[NR_IRQS];
 
+static inline irq_hw_number_t virq_to_hw(unsigned int virq)
+{
+	return irq_map[virq].hwirq;
+}
 
 /**
  * irq_alloc_host - Allocate a new irq_host data structure
