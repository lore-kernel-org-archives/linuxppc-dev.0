Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E76AFB7240
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2012 10:50:09 +1100 (EST)
Message-ID: <1328485804.30631.10.camel@pasglop>
Subject: [PATCH] powerpc/wsp: Permanently enable PCI class code workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 06 Feb 2012 10:50:04 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jimi Xenidis <jimix@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It appears that on the Chroma card, the class code of the root
complex is still wrong even on DD2 or later chips. This could
be a firmware issue, but that breaks resource allocation so let's
unconditionally fix it up.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/wsp/wsp_pci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/wsp/wsp_pci.c b/arch/powerpc/platforms/wsp/wsp_pci.c
index e0262cd..d24b3ac 100644
--- a/arch/powerpc/platforms/wsp/wsp_pci.c
+++ b/arch/powerpc/platforms/wsp/wsp_pci.c
@@ -468,15 +468,15 @@ static void __init wsp_pcie_configure_hw(struct pci_controller *hose)
 #define DUMP_REG(x) \
 	pr_debug("%-30s : 0x%016llx\n", #x, in_be64(hose->cfg_data + x))
 
-#ifdef CONFIG_WSP_DD1_WORKAROUND_BAD_PCIE_CLASS
-	/* WSP DD1 has a bogus class code by default in the PCI-E
-	 * root complex's built-in P2P bridge */
+	/*
+	 * Some WSP variants  has a bogus class code by default in the PCI-E
+	 * root complex's built-in P2P bridge
+	 */
 	val = in_be64(hose->cfg_data + PCIE_REG_SYS_CFG1);
 	pr_debug("PCI-E SYS_CFG1 : 0x%llx\n", val);
 	out_be64(hose->cfg_data + PCIE_REG_SYS_CFG1,
 		 (val & ~PCIE_REG_SYS_CFG1_CLASS_CODE) | (PCI_CLASS_BRIDGE_PCI << 8));
 	pr_debug("PCI-E SYS_CFG1 : 0x%llx\n", in_be64(hose->cfg_data + PCIE_REG_SYS_CFG1));
-#endif /* CONFIG_WSP_DD1_WORKAROUND_BAD_PCIE_CLASS */
 
 #ifdef CONFIG_WSP_DD1_WORKAROUND_DD1_TCE_BUGS
 	/* XXX Disable TCE caching, it doesn't work on DD1 */
-- 
1.7.7.3
