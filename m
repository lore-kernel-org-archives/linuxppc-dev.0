Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 280E5DDDF7
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 16:04:20 +1100 (EST)
Message-Id: <20070202045509.170129000@lixom.net>>
References: <20070202045448.145851000@lixom.net>>
Date: Thu, 01 Feb 2007 22:54:55 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [7/9] pasemi: Configure DMA controller interrupts
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The DMA controller on PWRficient is somewhat special -- has a PCI header
so it looks like it's on the root PCI (-Express) root bus, but it uses
more than the default number of interrupts (and they are hardwired).

We need to wire up all interrupts for the DMA controller. The generic
IRQ code will only map the primary interrupt from the PCI header (128),
so add 129->211 by hand.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: merge/arch/powerpc/platforms/pasemi/pci.c
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/pci.c
+++ merge/arch/powerpc/platforms/pasemi/pci.c
@@ -163,6 +163,19 @@ static void __init pas_fixup_phb_resourc
 }
 
 
+void __devinit pas_pci_irq_fixup(struct pci_dev *dev)
+{
+	/* DMA is special, 84 interrupts (128 -> 211), all but 128
+	 * need to be mapped by hand here.
+	 */
+	if (dev->vendor == 0x1959 && dev->device == 0xa007) {
+		int i;
+		for (i = 129; i < 212; i++)
+			irq_create_mapping(NULL, i);
+	}
+}
+
+
 void __init pas_pci_init(void)
 {
 	struct device_node *np, *root;
Index: merge/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/setup.c
+++ merge/arch/powerpc/platforms/pasemi/setup.c
@@ -242,4 +242,5 @@ define_machine(pas) {
 	.check_legacy_ioport    = pas_check_legacy_ioport,
 	.progress		= pas_progress,
 	.machine_check_exception = pas_machine_check_handler,
+	.pci_irq_fixup		= pas_pci_irq_fixup,
 };
Index: merge/arch/powerpc/platforms/pasemi/pasemi.h
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/pasemi.h
+++ merge/arch/powerpc/platforms/pasemi/pasemi.h
@@ -3,6 +3,7 @@
 
 extern unsigned long pas_get_boot_time(void);
 extern void pas_pci_init(void);
+extern void __devinit pas_pci_irq_fixup(struct pci_dev *dev);
 
 extern void __init pasemi_idle_init(void);
 

--
