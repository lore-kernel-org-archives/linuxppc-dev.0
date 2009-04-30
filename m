Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3B065DE0B2
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 23:10:20 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/9] powerpc/pci: clean up direct access to sysdata by FSL
	platforms
Date: Thu, 30 Apr 2009 08:10:08 -0500
Message-Id: <1241097015-11208-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1241097015-11208-1-git-send-email-galak@kernel.crashing.org>
References: <1241097015-11208-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We shouldn't directly access sysdata to get the pci_controller.  Instead
use pci_bus_to_host() for this purpose.  In the future we might have
sysdata be a device_node to match ppc64 and unify the code between ppc32
& ppc64.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_pci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 78021d8..a364f80 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -188,7 +188,7 @@ static void __init setup_pci_pcsrbar(struct pci_controller *hose)
 
 void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	int i;
 
 	if ((bus->parent == hose->bus) &&
@@ -324,7 +324,7 @@ struct mpc83xx_pcie_priv {
 
 static int mpc83xx_pcie_exclude_device(struct pci_bus *bus, unsigned int devfn)
 {
-	struct pci_controller *hose = bus->sysdata;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 
 	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -350,7 +350,7 @@ static int mpc83xx_pcie_exclude_device(struct pci_bus *bus, unsigned int devfn)
 static void __iomem *mpc83xx_pcie_remap_cfg(struct pci_bus *bus,
 					    unsigned int devfn, int offset)
 {
-	struct pci_controller *hose = bus->sysdata;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct mpc83xx_pcie_priv *pcie = hose->dn->data;
 	u8 bus_no = bus->number - hose->first_busno;
 	u32 dev_base = bus_no << 24 | devfn << 16;
-- 
1.6.0.6
