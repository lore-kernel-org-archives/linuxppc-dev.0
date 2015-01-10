Return-Path: <robherring2@gmail.com>
Received: from mail-ob0-x22a.google.com (mail-ob0-x22a.google.com
 [IPv6:2607:f8b0:4003:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4CC51A0FA8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jan 2015 13:35:47 +1100 (AEDT)
Received: by mail-ob0-f170.google.com with SMTP id wp18so15935055obc.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Jan 2015 18:35:45 -0800 (PST)
Sender: Rob Herring <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/16] powerpc: fsl_pci: convert PCI to use generic config
 accesses
Date: Fri,  9 Jan 2015 20:34:44 -0600
Message-Id: <1420857290-8373-11-git-send-email-robh@kernel.org>
In-Reply-To: <1420857290-8373-1-git-send-email-robh@kernel.org>
References: <1420857290-8373-1-git-send-email-robh@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert the fsl_pci driver to use the generic config access functions.

This changes accesses from (in|out)_(8|le16|le32) to readX/writeX
variants. I believe these should be equivalent for PCI config space
accesses, but confirmation would be nice.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/sysdev/fsl_pci.c | 46 +++----------------------------------------
 1 file changed, 3 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 6455c1e..271b67e 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -645,61 +645,21 @@ mapped:
 	return pcie->cfg_type1 + offset;
 }
 
-static int mpc83xx_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
-				    int offset, int len, u32 *val)
-{
-	void __iomem *cfg_addr;
-
-	cfg_addr = mpc83xx_pcie_remap_cfg(bus, devfn, offset);
-	if (!cfg_addr)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	switch (len) {
-	case 1:
-		*val = in_8(cfg_addr);
-		break;
-	case 2:
-		*val = in_le16(cfg_addr);
-		break;
-	default:
-		*val = in_le32(cfg_addr);
-		break;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
 static int mpc83xx_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
 				     int offset, int len, u32 val)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
-	void __iomem *cfg_addr;
-
-	cfg_addr = mpc83xx_pcie_remap_cfg(bus, devfn, offset);
-	if (!cfg_addr)
-		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS */
 	if (offset == PCI_PRIMARY_BUS && bus->number == hose->first_busno)
 		val &= 0xffffff00;
 
-	switch (len) {
-	case 1:
-		out_8(cfg_addr, val);
-		break;
-	case 2:
-		out_le16(cfg_addr, val);
-		break;
-	default:
-		out_le32(cfg_addr, val);
-		break;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
+	return pci_generic_config_write(bus, devfn, offset, len, val);
 }
 
 static struct pci_ops mpc83xx_pcie_ops = {
-	.read = mpc83xx_pcie_read_config,
+	.map_bus = mpc83xx_pcie_remap_cfg,
+	.read = pci_generic_config_read,
 	.write = mpc83xx_pcie_write_config,
 };
 
-- 
2.1.0
