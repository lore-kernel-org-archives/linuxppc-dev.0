Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C26D21007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Sep 2011 15:57:10 +1000 (EST)
Subject: powerpc: Fix device-tree matching for Apple U4 bridge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Sep 2011 15:57:01 +1000
Message-ID: <1317275821.29415.176.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Apple Quad G5 has some oddity in it's device-tree which causes the new
generic matching code to fail to relate nodes for PCI-E devices below
U4 with their respective struct pci_dev. This breaks graphics on those
machines among others.

This fixes it using a quirk which copies the node pointer from the host
bridge for the root complex, which makes the generic code work for the
children afterward.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Linus, please apply, this is a 3.1 regression. Thanks !
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index abe8d7e..8635694 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -561,6 +561,20 @@ static struct pci_ops u4_pcie_pci_ops =
 	.write = u4_pcie_write_config,
 };
 
+static void __devinit pmac_pci_fixup_u4_of_node(struct pci_dev *dev)
+{
+	/* Apple's device-tree "hides" the root complex virtual P2P bridge
+	 * on U4. However, Linux sees it, causing the PCI <-> OF matching
+	 * code to fail to properly match devices below it. This works around
+	 * it by setting the node of the bridge to point to the PHB node,
+	 * which is not entirely correct but fixes the matching code and
+	 * doesn't break anything else. It's also the simplest possible fix.
+	 */
+	if (dev->dev.of_node == NULL)
+		dev->dev.of_node = pcibios_get_phb_of_node(dev->bus);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, 0x5b, pmac_pci_fixup_u4_of_node);
+
 #endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_PPC32
