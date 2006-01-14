Return-Path: <SRS0+0ced42e87c3290b50e75+874+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F73A68A29
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 11:15:32 +1100 (EST)
Subject: [PATCH] macio-adb build fix
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Sat, 14 Jan 2006 00:15:19 +0000
Message-Id: <1137197719.3621.37.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes macio-adb.c build again. Entirely untested.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- drivers/macintosh/macio-adb.c~	2006-01-03 03:21:10.000000000 +0000
+++ drivers/macintosh/macio-adb.c	2006-01-14 00:13:43.000000000 +0000
@@ -17,6 +17,7 @@
 #include <asm/irq.h>
 #include <asm/system.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 
 struct preg {
 	unsigned char r;
@@ -88,24 +89,26 @@ int macio_probe(void)
 int macio_init(void)
 {
 	struct device_node *adbs;
+	struct resource r;
 
 	adbs = find_compatible_devices("adb", "chrp,adb0");
 	if (adbs == 0)
 		return -ENXIO;
 
 #if 0
-	{ int i;
+	{ int i = 0;
 
 	printk("macio_adb_init: node = %p, addrs =", adbs->node);
-	for (i = 0; i < adbs->n_addrs; ++i)
-		printk(" %x(%x)", adbs->addrs[i].address, adbs->addrs[i].size);
+	while(!of_address_to_resource(adbs, i, &r))
+		printk(" %x(%x)", r.start, r.end - r.start);
 	printk(", intrs =");
 	for (i = 0; i < adbs->n_intrs; ++i)
 		printk(" %x", adbs->intrs[i].line);
 	printk("\n"); }
 #endif
-	
-	adb = ioremap(adbs->addrs->address, sizeof(struct adb_regs));
+	if (of_address_to_resource(adbs, 0, &r))
+		return -ENXIO;
+	adb = ioremap(r.start, sizeof(struct adb_regs));
 
 	out_8(&adb->ctrl.r, 0);
 	out_8(&adb->intr.r, 0);

-- 
dwmw2
