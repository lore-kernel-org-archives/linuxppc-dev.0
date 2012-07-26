Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D1652C00D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 22:54:12 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <B07421@freescale.com>
Subject: [PATCH V3 2/5] powerpc/fsl-pci: Determine primary bus by looking for
 ISA node
Date: Thu, 26 Jul 2012 20:30:24 +0800
Message-ID: <1343305827-26734-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1343305827-26734-1-git-send-email-B38951@freescale.com>
References: <1343305827-26734-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PCI host bridge is primary bus if it contains an ISA node. But not all boards
fit this rule. Device tree should be updated for all these boards.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
Changed for V3:
- Using non-recursive function to find ISA under PCI

 arch/powerpc/include/asm/pci-bridge.h |    1 +
 arch/powerpc/sysdev/fsl_pci.c         |   31 ++++++++++++++++++++++++-------
 arch/powerpc/sysdev/fsl_pci.h         |   12 +++++++++++-
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index ac39e6a..b48fa7f 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -20,6 +20,7 @@ struct device_node;
 struct pci_controller {
 	struct pci_bus *bus;
 	char is_dynamic;
+	int is_primary;
 #ifdef CONFIG_PPC64
 	int node;
 #endif
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 5228b6b..97557c5 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -453,6 +453,7 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+	hose->is_primary = is_primary;
 
 	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
 		PPC_INDIRECT_TYPE_BIG_ENDIAN);
@@ -933,18 +934,34 @@ void pci_determine_swiotlb(void)
 }
 #endif
 
-int primary_phb_addr;
+/* Checkout if PCI contains ISA node (Only scan the children of PCI) */
+static int of_pci_has_isa(struct device_node *pci_node)
+{
+	struct device_node *np;
+
+	read_lock(&devtree_lock);
+	if (!pci_node)
+		return 0;
+	np = pci_node->allnext;
+	for (; np != pci_node->sibling; np = np->allnext) {
+		if (np->type && (of_node_cmp(np->type, "isa") == 0)
+		    && of_node_get(np)) {
+			of_node_put(pci_node);
+			return 1;
+		}
+	}
+	of_node_put(pci_node);
+	read_unlock(&devtree_lock);
+	return 0;
+}
+
 static int __devinit fsl_pci_probe(struct platform_device *pdev)
 {
-	struct pci_controller *hose;
 	bool is_primary;
+	is_primary = of_pci_has_isa(pdev->dev.of_node);
 
-	if (of_match_node(pci_ids, pdev->dev.of_node)) {
-		struct resource rsrc;
-		of_address_to_resource(pdev->dev.of_node, 0, &rsrc);
-		is_primary = ((rsrc.start & 0xfffff) == primary_phb_addr);
+	if (of_match_node(pci_ids, pdev->dev.of_node))
 		fsl_add_bridge(pdev->dev.of_node, is_primary);
-	}
 
 	return 0;
 }
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index 095392d..c884e06 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -88,7 +88,17 @@ struct ccsr_pci {
 	__be32	pex_err_cap_r3;		/* 0x.e34 - PCIE error capture register 0 */
 };
 
-extern int primary_phb_addr;
+
+#ifdef CONFIG_SUSPEND
+struct fsl_pci_private_data {
+	int inbound_num;
+	struct pci_outbound_window_regs __iomem *pci_pow;
+	struct pci_inbound_window_regs __iomem *pci_piw;
+	void *saved_regs;
+};
+#endif
+
+extern int is_has_isa_node(struct device_node *parent);
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
-- 
1.7.5.1
