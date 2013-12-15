Return-Path: <cengelma@gmx.at>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2AF562C009D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 05:44:38 +1100 (EST)
Received: from spike ([81.217.122.98]) by mail.gmx.com (mrgmx103) with ESMTPSA
 (Nemesis) id 0MKYpv-1VrQz21bhH-001y4I for
 <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2013 19:39:27 +0100
Date: Sun, 15 Dec 2013 19:39:26 +0100
From: Christian Engelmayer <cengelma@gmx.at>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/sysdev: Fix a pci section mismatch for Book E
Message-ID: <20131215193926.73ff4596@spike>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Moved the following functions out of the __init section:

   arch/powerpc/sysdev/fsl_pci.c      : fsl_add_bridge()
   arch/powerpc/sysdev/indirect_pci.c : setup_indirect_pci()

Those are referenced by arch/powerpc/sysdev/fsl_pci.c : fsl_pci_probe() when
compiling for Book E support.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
 arch/powerpc/sysdev/fsl_pci.c      | 2 +-
 arch/powerpc/sysdev/indirect_pci.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4dfd61d..2b66425 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -454,7 +454,7 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-int __init fsl_add_bridge(struct platform_device *pdev, int is_primary)
+int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 {
 	int len;
 	struct pci_controller *hose;
diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index c6c8b52..f434995 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -152,10 +152,8 @@ static struct pci_ops indirect_pci_ops =
 	.write = indirect_write_config,
 };
 
-void __init
-setup_indirect_pci(struct pci_controller* hose,
-		   resource_size_t cfg_addr,
-		   resource_size_t cfg_data, u32 flags)
+void setup_indirect_pci(struct pci_controller *hose, resource_size_t cfg_addr,
+			resource_size_t cfg_data, u32 flags)
 {
 	resource_size_t base = cfg_addr & PAGE_MASK;
 	void __iomem *mbase;
-- 
1.8.3.2
