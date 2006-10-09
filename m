Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2FA12679F0
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Oct 2006 13:28:22 +1000 (EST)
Subject: [PATCH] powerpc: Fix Maple secondary IDE interrupt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 13:27:28 +1000
Message-Id: <1160364448.14601.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The IDE driver will pick up the PCI IRQ for both channels on Maple
despite the fact that it's in legacy mode. This works around it by
"hiding" the PCI IRQ of the AMD8111 IDE controller when it's configured
in legacy mode on the Maple platform, thus causing the driver to call
pci_get_legacy_ide_irq() which will return the correct interrupts for
both channels.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-work/arch/powerpc/platforms/maple/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/maple/pci.c	2006-10-09 11:50:35.000000000 +1000
+++ linux-work/arch/powerpc/platforms/maple/pci.c	2006-10-09 12:02:06.000000000 +1000
@@ -516,8 +516,21 @@ void __init maple_pcibios_fixup(void)
 			dev->irq = irq_create_mapping(NULL, 1);
 			if (dev->irq != NO_IRQ)
 				set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
-		} else
-			pci_read_irq_line(dev);
+			continue;
+		}
+
+		/* Hide AMD8111 IDE interrupt when in legacy mode so
+		 * the driver calls pci_get_legacy_ide_irq()
+		 */
+		if (dev->vendor == PCI_VENDOR_ID_AMD &&
+		    dev->device == PCI_DEVICE_ID_AMD_8111_IDE &&
+		    (dev->class & 5) != 5) {
+			dev->irq = NO_IRQ;
+			continue;
+		}
+
+		/* For all others, map the interrupt from the device-tree */
+		pci_read_irq_line(dev);
 	}
 
 	DBG(" <- maple_pcibios_fixup\n");
