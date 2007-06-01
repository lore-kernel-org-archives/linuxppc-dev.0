Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4BB53DE29B
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 03:49:08 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l51Hn3fQ003595
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 10:49:03 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l51Hn2L3021577
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 12:49:03 -0500 (CDT)
Subject: [PATCH 8/8] Wrote quirk_mpc8641_transparent() to initialize bridge
	resources.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180720142.14219.68.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 01 Jun 2007 12:49:02 -0500
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

Note: The 0x7010 is the device ID of host bridge for MPC8641
      and 0x7011 is the device ID of host bridge fro MPC8641D.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

This patch combines the original function from Zheng Wei
and my followup rewrite of it to include resource allocation
as per list comments.

 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   66 ++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index a82da4b..94e3c50 100644
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
@@ -325,6 +326,69 @@ static void __devinit quirk_uli5229(struct pci_dev *dev)
 	pci_write_config_word(dev, 0x4a, temp);
 }
 
+#define GET_64BIT(prop, i)	((((u64) (prop)[(i)]) << 32) | (prop)[(i)+1])
+
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
+}
+
 static void __devinit early_uli5249(struct pci_dev *dev)
 {
 	unsigned char temp;
@@ -339,6 +403,8 @@ static void __devinit early_uli5249(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7010, quirk_mpc8641_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7011, quirk_mpc8641_transparent);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
 #endif /* CONFIG_PCI */
 
-- 
1.5.0.3
