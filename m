Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 76DFFDE24A
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 04:23:31 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4TINQdI005678
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 11:23:26 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4TINPEs023201
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 13:23:25 -0500 (CDT)
Subject: [PATCH 3/3] Modified quirk_mpc8641_transparent() to initialize
	bridge resources.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180463004.13106.65.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 29 May 2007 13:23:24 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jon Loeliger <jdl@freescale.com>

The 8641 RC poses as a transparent bridge, but does not implement the
IO_BASE or IO_LIMIT registers in the config space.  This means that
the code which initializes the bridge resources ends up setting the
IO resources erroneously.

This change initializes the RC bridge resources from the device tree.

Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   63 +++++++++++++++++++++++++++-
 1 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 7034bca..94e3c50 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -318,6 +318,7 @@ static void __devinit quirk_uli5288(struct pci_dev *dev)
 static void __devinit quirk_uli5229(struct pci_dev *dev)
 {
 	unsigned short temp;
+
 	pci_write_config_word(dev, 0x04, 0x0405);
 	dev->class &= ~0x5;
 	pci_read_config_word(dev, 0x4a, &temp);
@@ -325,9 +326,67 @@ static void __devinit quirk_uli5229(struct pci_dev *dev)
 	pci_write_config_word(dev, 0x4a, temp);
 }
 
+#define GET_64BIT(prop, i)	((((u64) (prop)[(i)]) << 32) | (prop)[(i)+1])
+
 static void __devinit quirk_mpc8641_transparent(struct pci_dev *dev)
 {
+	const u32 *ranges;
+	struct resource *res;
+	int len;
+	int i;
+	unsigned int flags;
+	u64 size;
+	struct device_node *node;
+	struct pci_controller *hose;
+
+	/*
+	 * Make the bridge be transparent.
+	 */
 	dev->transparent = 1;
+
+	/*
+	 * parse ranges property
+	 * Ensure IO resource is placed in the PCI_BRIDGE_RESOURCES entry.
+	 * PCI #address-cells == 3 and #size-cells == 2 always
+	 */
+	node = pci_device_to_OF_node(dev);
+
+	hose = pci_bus_to_hose(dev->bus->number);
+	node = hose->arch_data;
+
+	ranges = of_get_property(node, "ranges", &len);
+	if (ranges == NULL) {
+		printk(KERN_DEBUG "Can't get ranges for PCI-PCI bridge %s\n",
+		       node->full_name);
+		return;
+	}
+
+	i = PCI_BRIDGE_RESOURCES + 1;
+	for (; len >= 24; len -= 24, ranges += 6) {
+		flags = of_bus_pci_get_flags(&ranges[0]);
+		size = GET_64BIT(ranges, 4);
+		if (flags == 0 || size == 0)
+			continue;
+		if (flags & IORESOURCE_IO) {
+			res = &dev->resource[PCI_BRIDGE_RESOURCES];
+			if (res->flags) {
+				printk(KERN_ERR "PCI: ignoring extra I/O range"
+				       " for bridge %s\n", node->full_name);
+				continue;
+			}
+		} else {
+			if (i >= PCI_NUM_RESOURCES) {
+				printk(KERN_ERR "PCI: too many memory ranges"
+				       " for bridge %s\n", node->full_name);
+				continue;
+			}
+			res = &dev->resource[i];
+			++i;
+		}
+		res->start = GET_64BIT(ranges, 1);
+		res->end = res->start + size - 1;
+		res->flags = flags;
+	}
 }
 
 static void __devinit early_uli5249(struct pci_dev *dev)
@@ -344,8 +403,8 @@ static void __devinit early_uli5249(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
-DECLARE_PCI_FIXUP_HEADER(0x1957, 0x7010, quirk_mpc8641_transparent);
-DECLARE_PCI_FIXUP_HEADER(0x1957, 0x7011, quirk_mpc8641_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7010, quirk_mpc8641_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7011, quirk_mpc8641_transparent);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
 #endif /* CONFIG_PCI */
 
