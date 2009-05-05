Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A97EDDFAB
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 22:20:31 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pci: Remove redundant pcnet32 fixup
Date: Tue,  5 May 2009 07:20:09 -0500
Message-Id: <1241526009-18695-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1241526009-18695-1-git-send-email-galak@kernel.crashing.org>
References: <1241526009-18695-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The pcnet32 driver has had in its device id table for some time a match
against the "broken" vendor ID.  No need to fake out the vendor ID
with an explicit fixup.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_32.c |   11 -----------
 arch/powerpc/kernel/pci_64.c |   10 ----------
 2 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 529e677..3ae1c66 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -33,7 +33,6 @@ int pcibios_assign_bus_offset = 1;
 
 void pcibios_make_OF_bus_map(void);
 
-static void fixup_broken_pcnet32(struct pci_dev* dev);
 static void fixup_cpc710_pci64(struct pci_dev* dev);
 #ifdef CONFIG_PPC_OF
 static u8* pci_to_OF_bus_map;
@@ -72,16 +71,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_res
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl); 
 
 static void
-fixup_broken_pcnet32(struct pci_dev* dev)
-{
-	if ((dev->class>>8 == PCI_CLASS_NETWORK_ETHERNET)) {
-		dev->vendor = PCI_VENDOR_ID_AMD;
-		pci_write_config_word(dev, PCI_VENDOR_ID, PCI_VENDOR_ID_AMD);
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TRIDENT,	PCI_ANY_ID,			fixup_broken_pcnet32);
-
-static void
 fixup_cpc710_pci64(struct pci_dev* dev)
 {
 	/* Hide the PCI64 BARs from the kernel as their content doesn't
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index be574fc..fb9a0f8 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -43,16 +43,6 @@ unsigned long pci_probe_only = 1;
 unsigned long pci_io_base = ISA_IO_BASE;
 EXPORT_SYMBOL(pci_io_base);
 
-static void fixup_broken_pcnet32(struct pci_dev* dev)
-{
-	if ((dev->class>>8 == PCI_CLASS_NETWORK_ETHERNET)) {
-		dev->vendor = PCI_VENDOR_ID_AMD;
-		pci_write_config_word(dev, PCI_VENDOR_ID, PCI_VENDOR_ID_AMD);
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TRIDENT, PCI_ANY_ID, fixup_broken_pcnet32);
-
-
 static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
 {
 	const u32 *prop;
-- 
1.6.0.6
