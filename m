Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 798B82C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 19:50:37 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <B07421@freescale.com>
Subject: [PATCH V2 3/6] powerpc/fsl-pci: Determine primary bus by looking for
 ISA node
Date: Wed, 25 Jul 2012 17:26:58 +0800
Message-ID: <1343208421-5552-3-git-send-email-B38951@freescale.com>
In-Reply-To: <1343208421-5552-1-git-send-email-B38951@freescale.com>
References: <1343208421-5552-1-git-send-email-B38951@freescale.com>
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
index c473206..babeec6 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -453,6 +453,7 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+	hose->is_primary = is_primary;
 
 	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
 		PPC_INDIRECT_TYPE_BIG_ENDIAN);
@@ -933,18 +934,34 @@ void pci_check_swiotlb(void)
 }
 #endif
 
-int primary_phb_addr;
+/*
+ * Recursively scan all the children nodes of parent and find out if there
+ * is "isa" node. Return 1 if parent has isa node otherwise return 0.
+ */
+int has_isa_node(struct device_node *parent)
+{
+	static int result;
+	struct device_node *cur_child;
+
+	cur_child = NULL;
+	result = 0;
+	while (!result && (cur_child = of_get_next_child(parent, cur_child))) {
+		/* Get "isa" node and return 1 */
+		if (of_node_cmp(cur_child->type, "isa") == 0)
+			return result = 1;
+		has_isa_node(cur_child);
+	}
+
+	return result;
+}
+
 static int __devinit fsl_pci_probe(struct platform_device *pdev)
 {
-	struct pci_controller *hose;
 	bool is_primary;
+	is_primary = has_isa_node(pdev->dev.of_node);
 
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
index c2c1de5..abbc09d 100644
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
