Return-Path: <fernando@oss.ntt.co.jp>
Received: from serv1.oss.ntt.co.jp (ns.oss.ntt.co.jp [222.151.198.98])
	by ozlabs.org (Postfix) with ESMTP id 2FBA5DDEBD
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 17:52:11 +1000 (EST)
Subject: [PATCH] ppc: remove unused amiga_request_irq and mach_request_irq
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 22 Aug 2007 16:20:37 +0900
Message-Id: <1187767237.25624.11.camel@sebastian.kern.oss.ntt.co.jp>
Mime-Version: 1.0
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

amiga_request_irq and mach_request_irq are never used, so delete them.

Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
---

diff -urNp linux-2.6.23-rc3-orig/arch/ppc/amiga/config.c linux-2.6.23-rc3/arch/ppc/amiga/config.c
--- linux-2.6.23-rc3-orig/arch/ppc/amiga/config.c	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.23-rc3/arch/ppc/amiga/config.c	2007-08-22 15:45:51.000000000 +0900
@@ -72,10 +72,6 @@ static void amiga_sched_init(irqreturn_t
 /* amiga specific irq functions */
 extern void amiga_init_IRQ (void);
 extern void (*amiga_default_handler[]) (int, void *, struct pt_regs *);
-extern int amiga_request_irq (unsigned int irq,
-			      void (*handler)(int, void *, struct pt_regs *),
-                              unsigned long flags, const char *devname,
-			      void *dev_id);
 extern void amiga_free_irq (unsigned int irq, void *dev_id);
 extern void amiga_enable_irq (unsigned int);
 extern void amiga_disable_irq (unsigned int);
@@ -382,7 +378,6 @@ void __init config_amiga(void)
   mach_init_IRQ        = amiga_init_IRQ;
 #ifndef CONFIG_APUS
   mach_default_handler = &amiga_default_handler;
-  mach_request_irq     = amiga_request_irq;
   mach_free_irq        = amiga_free_irq;
   enable_irq           = amiga_enable_irq;
   disable_irq          = amiga_disable_irq;
