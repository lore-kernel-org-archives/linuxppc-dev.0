Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8857DDDE39
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 15:48:40 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Don't try to allocate resources for a POWERPC PHB
Date: Wed, 25 Jul 2007 00:48:08 -0500
Message-Id: <11853424881167-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Freescale PCI PHBs actual report back values in the BAR registers
this causes issues in that we try to allocate resources for them
and will get error messages like the following on MPC8544 DS:

PCI: Failed to allocate mem resource #1:80000000@0 for 0000:00:00.0

To address this if we are class PCI_CLASS_PROCESSOR_POWERPC, a normal
header type, and the PHB don't try to assign resources.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_32.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 721a694..39f8cb1 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -508,6 +508,13 @@ pcibios_allocate_resources(int pass)
 	struct resource *r;
 
 	for_each_pci_dev(dev) {
+		int class = dev->class >> 8;
+
+		if ((class == PCI_CLASS_PROCESSOR_POWERPC) &&
+		    (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
+		    (dev->bus->parent == NULL))
+			continue;
+
 		pci_read_config_word(dev, PCI_COMMAND, &command);
 		for (idx = 0; idx < 6; idx++) {
 			r = &dev->resource[idx];
@@ -550,6 +557,10 @@ pcibios_assign_resources(void)
 		/* Don't touch classless devices and host bridges */
 		if (!class || class == PCI_CLASS_BRIDGE_HOST)
 			continue;
+		if ((class == PCI_CLASS_PROCESSOR_POWERPC) &&
+		    (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
+		    (dev->bus->parent == NULL))
+			continue;
 
 		for (idx = 0; idx < 6; idx++) {
 			r = &dev->resource[idx];
-- 
1.5.2.2
