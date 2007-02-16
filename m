Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id F3CA9DDE29
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:50:50 +1100 (EST)
Date: Thu, 15 Feb 2007 20:50:06 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	jdl@jdl.com
Subject: [RFC 7/7] Unite all PCI-e on 85xx and 86xx under one codebase
Message-ID: <Pine.LNX.4.61.0702152046450.9034@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Skip the fake PCI bridge (FPGA)

modified: arch/powerpc/platforms/85xx/mpc85xx_cds.c
Deleted the exclude list. Implemented by class/PIR

modified: arch/powerpc/platforms/85xx/pci.c
PEX should not set primary since PCI1 sets already

modified: drivers/pci/probe.c
Changed child resources assignment when bridge is transparent
Identifid powerpc processor by class and fixed resources
Removed whitespace
Signed-off-by: York Sun <yorksun@freescale.com>
Acked-by: Andy Fleming <afleming@freescale.com>
---
There's a second patch at the end of the first one.  If it breaks this 
email, just delete the last patch, and apply the second patch by hand (or 
ignore the second patch for now.  There's no effect on functionality).

 arch/powerpc/kernel/pci_32.c              |   17 +++++++++++-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   13 +--------
 arch/powerpc/platforms/85xx/pci.c         |    5 +---
 drivers/pci/probe.c                       |   40 ++++++++++++++++++++++++----
 4 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index d8ef2e1..29243ed 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -81,7 +81,18 @@ fixup_cpc710_pci64(struct pci_dev* dev)
 	dev->resource[1].start = dev->resource[1].end = 0;
 	dev->resource[1].flags = 0;
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixup_cpc710_pci64);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_CPC710_PCI64, fixup_cpc710_pci64);
+
+static void __devinit skip_fake_bridge(struct pci_dev *dev)
+{
+	/* Make it an error to skip the fake bridge
+	 * in pci_setup_device() in probe.c */
+	dev->hdr_type = 0x7f;
+}
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x3fff, skip_fake_bridge);
+DECLARE_PCI_FIXUP_EARLY(0x3fff, 0x1957, skip_fake_bridge);
+DECLARE_PCI_FIXUP_EARLY(0xff3f, 0x5719, skip_fake_bridge);
+
 
 static void
 pcibios_fixup_resources(struct pci_dev *dev)
@@ -1362,7 +1373,9 @@ void __init pcibios_fixup_bus(struct pci
 				continue;
 			if (!res->flags)
 				continue;
-			if (io_offset && (res->flags & IORESOURCE_IO)) {
+			if (!bus->self->transparent
+					&& io_offset
+					&& (res->flags & IORESOURCE_IO)) {
 				res->start += io_offset;
 				res->end += io_offset;
 			} else if (hose->pci_mem_offset
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 2027855..dc8ddde 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -65,18 +65,7 @@ extern int mpc85xx_pci2_busno;
 
 static int mpc85xx_exclude_device(u_char bus, u_char devfn)
 {
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	if (mpc85xx_pci2_busno)
-		if (bus == (mpc85xx_pci2_busno) && PCI_SLOT(devfn) == 0)
-			return PCIBIOS_DEVICE_NOT_FOUND;
-	/* We explicitly do not go past the Tundra 320 Bridge */
-	if ((bus == 1) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	if ((bus == 0) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	else
-		return PCIBIOS_SUCCESSFUL;
+	return PCIBIOS_SUCCESSFUL;
 }
 
 void __init
diff --git a/arch/powerpc/platforms/85xx/pci.c b/arch/powerpc/platforms/85xx/pci.c
index 5c70797..8afb74f 100644
--- a/arch/powerpc/platforms/85xx/pci.c
+++ b/arch/powerpc/platforms/85xx/pci.c
@@ -137,7 +137,6 @@ int __init add_bridge(struct device_node
 	struct pci_controller *hose;
 	struct resource rsrc;
 	const int *bus_range;
-	unsigned int temp;
 	int primary = 1, has_address = 0;
 	phys_addr_t immr = get_immrbase();
 
@@ -177,12 +176,10 @@ int __init add_bridge(struct device_node
 	if ((rsrc.start & 0xfffff) == 0xa000) {
 		setup_indirect_pcie(hose, immr + 0xa000, immr + 0xa004);
 		mpc85xx_setup_pcie(hose);
-		primary = 1;
+		primary = 0;
 		hose->bus_offset = hose->first_busno;
 		/* Setup PEX window registers */
 		setup_pcie_atmu(hose, &rsrc);
-		early_read_config_dword(hose, 0, 0, 0x404, &temp);
-		printk("Reg 0x404 is 0x%x\n",temp);
 	}
 
 	printk(KERN_INFO "Found MPC85xx PCI host bridge at 0x%016llx. "
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2fe1d69..9276040 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -289,8 +289,10 @@ void __devinit pci_read_bridge_bases(str
 
 	if (dev->transparent) {
 		printk(KERN_INFO "PCI: Transparent bridge - %s\n", pci_name(dev));
-		for(i = 3; i < PCI_BUS_NUM_RESOURCES; i++)
-			child->resource[i] = child->parent->resource[i - 3];
+		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
+			child->resource[i] = child->parent->resource[i];
+
+		return;
 	}
 
 	for(i=0; i<3; i++)
@@ -720,11 +722,26 @@ static int pci_setup_device(struct pci_d
 	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
 		if (class == PCI_CLASS_BRIDGE_PCI)
 			goto bad;
-		pci_read_irq(dev);
-		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
-		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
-		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
 
+		if (class == PCI_CLASS_PROCESSOR_POWERPC) {
+			u8 progif;
+			pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
+			if ((progif & 1) == 0) { /* host */
+				dev->resource[0].flags=IORESOURCE_UNSET;
+				dev->resource[1].flags=IORESOURCE_UNSET;
+				dev->resource[2].flags=IORESOURCE_UNSET;
+				dev->resource[3].flags=IORESOURCE_UNSET;
+				dev->resource[4].flags=IORESOURCE_UNSET;
+				dev->resource[5].flags=IORESOURCE_UNSET;
+			}
+		} else {
+			pci_read_irq(dev);
+			pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
+			pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID,
+					&dev->subsystem_vendor);
+			pci_read_config_word(dev, PCI_SUBSYSTEM_ID,
+					&dev->subsystem_device);
+		}
 		/*
 		 *	Do the ugly legacy mode stuff here rather than broken chip
 		 *	quirk code. Legacy mode ATA controllers have fixed
@@ -754,6 +771,17 @@ static int pci_setup_device(struct pci_d
 		break;
 
 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
+		if (class == PCI_CLASS_PROCESSOR_POWERPC) {
+			u8 progif;
+			pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
+			if ((progif & 1) == 0) { /* rc */
+				dev->transparent = 1;
+				dev->resource[0].flags=IORESOURCE_UNSET;
+				dev->resource[1].flags=IORESOURCE_UNSET;
+				break;
+			}
+		}
+		else if (class != PCI_CLASS_BRIDGE_PCI)
 		if (class != PCI_CLASS_BRIDGE_PCI)
 			goto bad;
 		/* The PCI-to-PCI bridge spec requires that subtractive
-- 
1.4.4

Removed an extraneous "if" clause that ended up in the pci code

due to human error
---
 drivers/pci/probe.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9276040..47a1793 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -782,7 +782,6 @@ static int pci_setup_device(struct pci_d
 			}
 		}
 		else if (class != PCI_CLASS_BRIDGE_PCI)
-		if (class != PCI_CLASS_BRIDGE_PCI)
 			goto bad;
 		/* The PCI-to-PCI bridge spec requires that subtractive
 		   decoding (i.e. transparent) bridge must have programming
-- 
1.4.4
