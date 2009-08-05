Return-Path: <hch@lst.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EF162B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 08:34:49 +1000 (EST)
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C9DDDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 08:34:48 +1000 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id
	n75MOjVL030991
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 00:24:45 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-7.2) id n75MOjiZ030990
	for linuxppc-dev@ozlabs.org; Thu, 6 Aug 2009 00:24:45 +0200
Date: Thu, 6 Aug 2009 00:24:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: switch to asm-generic/hardirq.h
Message-ID: <20090805222445.GB30900@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hardirq.h on powerpc defines a __last_jiffy_stamp field, but it's not
actually used anywhere.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/include/asm/hardirq.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/hardirq.h	2009-08-05 19:19:57.391342973 -0300
+++ linux-2.6/arch/powerpc/include/asm/hardirq.h	2009-08-05 19:20:38.658365423 -0300
@@ -1,29 +1 @@
-#ifndef _ASM_POWERPC_HARDIRQ_H
-#define _ASM_POWERPC_HARDIRQ_H
-#ifdef __KERNEL__
-
-#include <asm/irq.h>
-#include <asm/bug.h>
-
-/* The __last_jiffy_stamp field is needed to ensure that no decrementer
- * interrupt is lost on SMP machines. Since on most CPUs it is in the same
- * cache line as local_irq_count, it is cheap to access and is also used on UP
- * for uniformity.
- */
-typedef struct {
-	unsigned int __softirq_pending;	/* set_bit is used on this */
-	unsigned int __last_jiffy_stamp;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
-#define last_jiffy_stamp(cpu) __IRQ_STAT((cpu), __last_jiffy_stamp)
-
-static inline void ack_bad_irq(int irq)
-{
-	printk(KERN_CRIT "illegal vector %d received!\n", irq);
-	BUG();
-}
-
-#endif /* __KERNEL__ */
-#endif /* _ASM_POWERPC_HARDIRQ_H */
+#include <asm-generic/hardirq.h>
