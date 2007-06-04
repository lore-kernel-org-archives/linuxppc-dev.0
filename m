Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 06C1EDDFD2
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:30:32 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l54MURTV009233
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 15:30:28 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l54MURpB021943
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 17:30:27 -0500 (CDT)
Subject: [PATCH v2 9/9] Created quirk_mpc8641_transparent() to initialize
	bridge resources.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180996227.9632.77.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 17:30:27 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 8641 RC poses as a transparent bridge, but does not implement the
IO_BASE or IO_LIMIT registers in the config space.  This means that
the code which initializes the bridge resources ends up setting the
IO resources erroneously.

This change sets RC of mpc8641 to be a transparent bridge
for legacy I/O access and initializes the RC bridge resources
from the device tree.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

Incorporates review suggestions from Milton.

 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   76 ++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index a82da4b..83a2c28 100644
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
@@ -325,6 +326,75 @@ static void __devinit quirk_uli5229(struct pci_dev *dev)
 	pci_write_config_word(dev, 0x4a, temp);
 }
 
+static void __devinit quirk_mpc8641_transparent(struct pci_dev *dev)
+{
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
+	dev->transparent = 1;
+
+	/*
+	 * parse ranges property
+	 * Ensure IO resource is placed in the PCI_BRIDGE_RESOURCES entry.
+	 * PCI #address-cells == 3 and #size-cells == 2 always
+	 */
+	hose = pci_bus_to_hose(dev->bus->number);
+	if (!hose) {
+		printk(KERN_ERR "Can't find hose for bus %d\n",
+		       dev->bus->number);
+		return;
+	}
+	node = hose->arch_data;
+
+	ranges = of_get_property(node, "ranges", &len);
+	if (ranges == NULL) {
+		printk(KERN_DEBUG "Can't get ranges for PCI-PCI bridge %s\n",
+		       node->full_name);
+		return;
+	}
+
+	/*
+	 * Each PCI range is 3 words of PCI address, 1 word
+	 * of CPU address, 2 words of size:
+	 * one range is  < [pci_addr]  [CPU]  [size] >
+	 */
+	i = PCI_BRIDGE_RESOURCES + 1;
+	for (; len >= 24; len -= 24, ranges += 6) {
+		flags = of_bus_pci_get_flags(&ranges[0]);
+		size = of_read_number(&ranges[4], 2);
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
+		res->start = of_read_number(&ranges[1], 2);
+		res->end = res->start + size - 1;
+		res->flags = flags;
+	}
+}
+
 static void __devinit early_uli5249(struct pci_dev *dev)
 {
 	unsigned char temp;
@@ -339,6 +409,12 @@ static void __devinit early_uli5249(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FREESCALE,
+			PCI_DEVICE_ID_8641_PCI_HOST_BRIDGE,
+			quirk_mpc8641_transparent);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FREESCALE,
+			PCI_DEVICE_ID_8641D_PCI_HOST_BRIDGE,
+			quirk_mpc8641_transparent);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
 #endif /* CONFIG_PCI */
 
-- 
1.5.0.3
