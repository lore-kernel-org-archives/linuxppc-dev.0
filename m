Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BC7E4DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Dec 2008 03:40:35 +1100 (EST)
Date: Mon, 29 Dec 2008 19:40:32 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc/fsl_pci: Fix sparse warnings
Message-ID: <20081229164032.GA8215@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Tony Li <tony.li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes following sparse warnings:

  CHECK   fsl_pci.c
fsl_pci.c:32:13: warning: symbol 'setup_pci_atmu' was not declared. Should it be static?
fsl_pci.c:89:13: warning: symbol 'setup_pci_cmd' was not declared. Should it be static?
fsl_pci.c:133:12: warning: symbol 'fsl_pcie_check_link' was not declared. Should it be static?

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/fsl_pci.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index d5f9ae0..f611d03 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -29,7 +29,8 @@
 
 #if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
 /* atmu setup for fsl pci/pcie controller */
-void __init setup_pci_atmu(struct pci_controller *hose, struct resource *rsrc)
+static void __init setup_pci_atmu(struct pci_controller *hose,
+				  struct resource *rsrc)
 {
 	struct ccsr_pci __iomem *pci;
 	int i;
@@ -86,7 +87,7 @@ void __init setup_pci_atmu(struct pci_controller *hose, struct resource *rsrc)
 	out_be32(&pci->piw[2].piwar, PIWAR_2G);
 }
 
-void __init setup_pci_cmd(struct pci_controller *hose)
+static void __init setup_pci_cmd(struct pci_controller *hose)
 {
 	u16 cmd;
 	int cap_x;
@@ -130,7 +131,7 @@ static void __init quirk_fsl_pcie_header(struct pci_dev *dev)
 	return ;
 }
 
-int __init fsl_pcie_check_link(struct pci_controller *hose)
+static int __init fsl_pcie_check_link(struct pci_controller *hose)
 {
 	u32 val;
 	early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
-- 
1.5.6.5
