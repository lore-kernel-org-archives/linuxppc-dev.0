Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B00FB67A62
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 11:55:19 +1000 (EST)
Subject: [PATCH] powermac: Fix some 64b resource damage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 11:55:03 +1000
Message-Id: <1151805303.19419.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Greg Kroah-Hartman <gregkh@suse.de>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 64 bits resource patches did a bit of damage on PowerMac causing a
buffer overflow in macio_asic and a warning in a sound driver. The
former is fixed by reverting the sprintf of the bus_id to %08x as it was
before. The bus_id used for macio devices is always a 32 bits value
(macio always sits in 32 bits space) and since it's exposed to userland,
the format of the string shouldn't be changed like that anyway. The
second by using the proper type for printk.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Linus, please apply asap since right now, PowerMac overflows kobject
buffers on boot, pretty bad.


Index: linux-irq-work/drivers/macintosh/macio_asic.c
===================================================================
--- linux-irq-work.orig/drivers/macintosh/macio_asic.c	2006-07-02 11:46:53.000000000 +1000
+++ linux-irq-work/drivers/macintosh/macio_asic.c	2006-07-02 11:47:37.000000000 +1000
@@ -427,10 +427,10 @@
 
 	/* MacIO itself has a different reg, we use it's PCI base */
 	if (np == chip->of_node) {
-		sprintf(dev->ofdev.dev.bus_id, "%1d.%016llx:%.*s",
+		sprintf(dev->ofdev.dev.bus_id, "%1d.%08x:%.*s",
 			chip->lbus.index,
 #ifdef CONFIG_PCI
-			(unsigned long long)pci_resource_start(chip->lbus.pdev, 0),
+			(unsigned int)pci_resource_start(chip->lbus.pdev, 0),
 #else
 			0, /* NuBus may want to do something better here */
 #endif
Index: linux-irq-work/sound/ppc/pmac.c
===================================================================
--- linux-irq-work.orig/sound/ppc/pmac.c	2006-07-02 11:46:53.000000000 +1000
+++ linux-irq-work/sound/ppc/pmac.c	2006-07-02 11:48:40.000000000 +1000
@@ -1170,7 +1170,7 @@
 					       chip->rsrc[i].start + 1,
 					       rnames[i]) == NULL) {
 				printk(KERN_ERR "snd: can't request rsrc "
-				       " %d (%s: 0x%016lx:%016lx)\n",
+				       " %d (%s: 0x%016llx:%016llx)\n",
 				       i, rnames[i],
 				       (unsigned long long)chip->rsrc[i].start,
 				       (unsigned long long)chip->rsrc[i].end);
