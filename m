Return-Path: <liml@rtr.ca>
Received: from mail.rtr.ca (ottawa-hs-64-26-128-89.s-ip.magma.ca
	[64.26.128.89]) by ozlabs.org (Postfix) with ESMTP id 00B1FDDF15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 23:39:04 +1000 (EST)
Message-ID: <461E3677.6030104@rtr.ca>
Date: Thu, 12 Apr 2007 09:39:03 -0400
From: Mark Lord <liml@rtr.ca>
MIME-Version: 1.0
To: Michael <michaelzwrk@gmail.com>
Subject: Re: IDE driver in polling mode
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>	
	<461B9D04.2000109@ru.mvista.com>	
	<20070410171125.3aeed29d@the-village.bc.nu>	
	<461BB8C7.9050900@garzik.org>	
	<20070410172942.7f63d49c@the-village.bc.nu>	
	<1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com>	
	<20070411094702.74774d25@the-village.bc.nu>
	<1ea6be8e0704110810l205f5dc7gb831603455a883e2@mail.gmail.com>
In-Reply-To: <1ea6be8e0704110810l205f5dc7gb831603455a883e2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Michael,

Here is a patch to have drivers/ide use polling
for all operations, in addition to IRQs.

Patch is against 2.6.21, but should apply and work equally well
on earlier kernels (including 2.6.14).

This quick hack is *not* for general kernel inclusion.
It works for me.  I tested it using a CF card in a PC-CARD adapter.

Signed-off-by:  Mark Lord <mlord@pobox.com>

--- 2.6.21/drivers/ide/ide-probe.c	2007-04-11 00:18:51.000000000 -0400
+++ new/drivers/ide/ide-probe.c	2007-04-12 09:26:14.000000000 -0400
@@ -1014,6 +1014,27 @@
  * but anything else has led to problems on some machines.  We re-enable
  * interrupts as much as we can safely do in most places.
  */
+struct timer_list polling_timer;
+static void ide_polling (unsigned long data)
+{
+	ide_hwgroup_t *hwgroup = (void *)data;
+	ide_hwif_t *hwif;
+	int irq = 0;
+
+	if (hwgroup) {
+		hwif = hwgroup->hwif;
+		if (hwif)
+			irq = hwif->irq;
+	}
+
+	ide_intr(irq, hwgroup);
+	init_timer(&polling_timer);
+	polling_timer.expires = jiffies + 1;
+	polling_timer.function = &ide_polling;
+	polling_timer.data = (unsigned long) hwgroup;
+	add_timer(&polling_timer);
+}
+
 static int init_irq (ide_hwif_t *hwif)
 {
 	unsigned int index;
@@ -1110,9 +1131,12 @@
 		if (hwif->io_ports[IDE_CONTROL_OFFSET])
 			/* clear nIEN */
 			hwif->OUTB(0x08, hwif->io_ports[IDE_CONTROL_OFFSET]);
-
+#if 0
 		if (request_irq(hwif->irq,&ide_intr,sa,hwif->name,hwgroup))
 	       		goto out_unlink;
+#else
+		ide_polling((unsigned long)hwgroup);
+#endif
 	}
 
 	/*
@@ -1156,6 +1180,7 @@
 	printk("\n");
 	up(&ide_cfg_sem);
 	return 0;
+#if 0
 out_unlink:
 	spin_lock_irq(&ide_lock);
 	if (hwif->next == hwif) {
@@ -1176,6 +1201,7 @@
 		BUG_ON(hwgroup->hwif == hwif);
 	}
 	spin_unlock_irq(&ide_lock);
+#endif
 out_up:
 	up(&ide_cfg_sem);
 	return 1;
--- 2.6.21/drivers/ide/ide.c	2007-04-11 00:18:51.000000000 -0400
+++ new/drivers/ide/ide.c	2007-04-12 09:31:59.000000000 -0400
@@ -569,6 +569,8 @@
  *	This is raving bonkers.
  */
 
+extern struct timer_list polling_timer;
+
 void ide_unregister(unsigned int index)
 {
 	ide_drive_t *drive;
@@ -612,7 +614,11 @@
 		g = g->next;
 	} while (g != hwgroup->hwif);
 	if (irq_count == 1)
+#if 0
 		free_irq(hwif->irq, hwgroup);
+#else
+		del_timer(&polling_timer);
+#endif
 
 	spin_lock_irq(&ide_lock);
 	/*
