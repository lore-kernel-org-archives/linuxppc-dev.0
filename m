Return-Path: <fernando@oss.ntt.co.jp>
Received: from serv1.oss.ntt.co.jp (ns.oss.ntt.co.jp [222.151.198.98])
	by ozlabs.org (Postfix) with ESMTP id CA856DDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 18:24:11 +1000 (EST)
Subject: [PATCH] ppc: remove unused sys_free_irq
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 22 Aug 2007 17:24:09 +0900
Message-Id: <1187771049.25624.26.camel@sebastian.kern.oss.ntt.co.jp>
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

sys_free_irq is never used, so delete it.

Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
---

diff -urNp linux-2.6.23-rc3-orig/arch/ppc/amiga/ints.c linux-2.6.23-rc3/arch/ppc/amiga/ints.c
--- linux-2.6.23-rc3-orig/arch/ppc/amiga/ints.c	2007-08-22 17:14:32.000000000 +0900
+++ linux-2.6.23-rc3/arch/ppc/amiga/ints.c	2007-08-22 17:15:27.000000000 +0900
@@ -75,23 +75,6 @@ irq_node_t *new_irq_node(void)
 	return NULL;
 }
 
-void sys_free_irq(unsigned int irq, void *dev_id)
-{
-	if (irq < IRQ1 || irq > IRQ7) {
-		printk("%s: Incorrect IRQ %d\n", __FUNCTION__, irq);
-		return;
-	}
-
-	if (irq_list[irq].dev_id != dev_id)
-		printk("%s: Removing probably wrong IRQ %d from %s\n",
-		       __FUNCTION__, irq, irq_list[irq].devname);
-
-	irq_list[irq].handler = (*mach_default_handler)[irq];
-	irq_list[irq].flags   = 0;
-	irq_list[irq].dev_id  = NULL;
-	irq_list[irq].devname = default_names[irq];
-}
-
 asmlinkage void process_int(unsigned long vec, struct pt_regs *fp)
 {
 	if (vec >= VEC_INT1 && vec <= VEC_INT7 && !MACH_IS_BVME6000) {
