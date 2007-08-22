Return-Path: <fernando@oss.ntt.co.jp>
Received: from serv1.oss.ntt.co.jp (serv1.oss.ntt.co.jp [222.151.198.98])
	by ozlabs.org (Postfix) with ESMTP id 2F35ADDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 18:24:10 +1000 (EST)
Subject: [PATCH] ppc: remove unused sys_request_irq
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 22 Aug 2007 17:24:07 +0900
Message-Id: <1187771047.25624.25.camel@sebastian.kern.oss.ntt.co.jp>
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

sys_request_irq is never used, so delete it.

Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
---

diff -urNp linux-2.6.23-rc3-orig/arch/ppc/amiga/ints.c linux-2.6.23-rc3/arch/ppc/amiga/ints.c
--- linux-2.6.23-rc3-orig/arch/ppc/amiga/ints.c	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.23-rc3/arch/ppc/amiga/ints.c	2007-08-22 17:12:48.000000000 +0900
@@ -75,38 +75,6 @@ irq_node_t *new_irq_node(void)
 	return NULL;
 }
 
-int sys_request_irq(unsigned int irq,
-                    void (*handler)(int, void *, struct pt_regs *),
-                    unsigned long flags, const char *devname, void *dev_id)
-{
-	if (irq < IRQ1 || irq > IRQ7) {
-		printk("%s: Incorrect IRQ %d from %s\n",
-		       __FUNCTION__, irq, devname);
-		return -ENXIO;
-	}
-
-#if 0
-	if (!(irq_list[irq].flags & IRQ_FLG_STD)) {
-		if (irq_list[irq].flags & IRQ_FLG_LOCK) {
-			printk("%s: IRQ %d from %s is not replaceable\n",
-			       __FUNCTION__, irq, irq_list[irq].devname);
-			return -EBUSY;
-		}
-		if (!(flags & IRQ_FLG_REPLACE)) {
-			printk("%s: %s can't replace IRQ %d from %s\n",
-			       __FUNCTION__, devname, irq, irq_list[irq].devname);
-			return -EBUSY;
-		}
-	}
-#endif
-
-	irq_list[irq].handler = handler;
-	irq_list[irq].flags   = flags;
-	irq_list[irq].dev_id  = dev_id;
-	irq_list[irq].devname = devname;
-	return 0;
-}
-
 void sys_free_irq(unsigned int irq, void *dev_id)
 {
 	if (irq < IRQ1 || irq > IRQ7) {
