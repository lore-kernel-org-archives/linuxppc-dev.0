Return-Path: <andrew@cesa.opbu.xerox.com>
Received: from wvmler2.mail.xerox.com (wvmler2.mail.xerox.com [13.8.138.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler2.mail.xerox.com",
	Issuer "AAA Certificate Services" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4B46DE059
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 07:04:04 +1100 (EST)
Received: from wvmlir2.mail.xerox.com (wvmlir2.mail.xerox.com [13.147.8.222])
	by wvmler2.mail.xerox.com (8.14.2/8.13.8) with ESMTP id
	n0EJmgdN004747
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 11:48:42 -0800
Received: from wvmlir2.mail.xerox.com (localhost [127.0.0.1])
	by wvmlir2.mail.xerox.com (8.14.2/8.13.6) with ESMTP id n0EJmXU5010132
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 11:48:33 -0800
Received: from hermes.opbu.xerox.com (hermes.opbu.xerox.com [13.62.6.81])
	by wvmlir2.mail.xerox.com (8.14.2/8.13.6) with ESMTP id n0EJmXnW010127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 11:48:33 -0800
Received: from pogo.cesa.opbu.xerox.com ([13.253.158.23])
	by hermes.opbu.xerox.com (8.13.8+Sun/8.13.8) with ESMTP id
	n0EJmXRa014581
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 11:48:33 -0800 (PST)
Received: from cesa.opbu.xerox.com (gto.cesa.opbu.xerox.com [13.62.136.98])
	by pogo.cesa.opbu.xerox.com (8.13.6+Sun/8.13.6) with ESMTP id
	n0EJmXH3002897
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 11:48:33 -0800 (PST)
Message-Id: <200901141948.n0EJmXH3002897@pogo.cesa.opbu.xerox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Restore PCI IO space behind Freescale pseudo-bridge
Date: Wed, 14 Jan 2009 11:48:33 -0800
From: Andrew Klossner <andrew@cesa.opbu.xerox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When I moved from 2.6.27 to 2.6.28, one of my devices didn't work
until I devised the attached patch.  The kernel disallowed PCI I/O
space resources behind the pseudo-bridge in the Freescale MPC8545
because that bridge's config-space registers incorrectly report that
it doesn't forward I/O space transactions.

Checking for a specific vendor ID is hacky, but it got my system going
again with only a few perturbed lines.  Is there a more correct way to
achieve this?

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f36936d..f9f0048 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -985,6 +985,7 @@ static int __devinit pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
 	struct pci_dev *dev = bus->self;
 	resource_size_t offset;
 	u16 command;
+	u16 vendor;
 	int i;
 
 	/* We don't do anything if PCI_PROBE_ONLY is set */
@@ -1030,7 +1031,16 @@ static int __devinit pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
 		 * starting at low addresses -is- valid. What we do instead if that
 		 * we consider as unassigned anything that doesn't have IO enabled
 		 * in the PCI command register, and that's it.
+		 * However, we don't do that if the bridge is internal to a Freescale
+		 * CPU, as such bridges break the rules by, for example, not populating
+		 * the PCI_COMMAND_IO bit.
 		 */
+		pci_read_config_word(dev, PCI_VENDOR_ID, &vendor);
+		if (vendor == PCI_VENDOR_ID_MOTOROLA ||
+		    vendor == PCI_VENDOR_ID_FREESCALE) {
+			return 0;
+		}
+
 		pci_read_config_word(dev, PCI_COMMAND, &command);
 		if (command & PCI_COMMAND_IO)
 			return 0;
