Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50BBEDDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:50:56 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 10/25] [POWERPC] Fixup resources on pci_bus for PCIe PHB when
	no device is connected
Date: Mon, 23 Jul 2007 15:49:57 -0500
Message-Id: <11852238271141-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238253550-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
	<11852238253550-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On the 85xx/86xx PCIe controllers if there is no device connected to the
PHB we will still allocate a pci_bus for downstream bus of the virtual
P2P bridge. However the resources allocated to the downstream bus are not
correct and so we just mimic the resources from the upstream pci_bus.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c  |    1 +
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
 arch/powerpc/sysdev/fsl_pci.c              |   14 ++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h              |    1 +
 4 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 2539bb5..9b559eb 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -272,4 +272,5 @@ define_machine(mpc85xx_cds) {
 	.restart	= mpc85xx_restart,
 	.calibrate_decr = generic_calibrate_decr,
 	.progress	= udbg_progress,
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 };
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index e67e10d..e9eaa07 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -431,7 +431,6 @@ mpc86xx_time_init(void)
 	return 0;
 }
 
-
 define_machine(mpc86xx_hpcn) {
 	.name			= "MPC86xx HPCN",
 	.probe			= mpc86xx_hpcn_probe,
@@ -443,4 +442,5 @@ define_machine(mpc86xx_hpcn) {
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 };
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 2eefcde..faafae6 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -142,6 +142,20 @@ int __init fsl_pcie_check_link(struct pci_controller *hose)
 	return 0;
 }
 
+void fsl_pcibios_fixup_bus(struct pci_bus *bus)
+{
+	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
+	int i;
+
+	/* deal with bogus pci_bus when we don't have anything connected on PCIe */
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
+		if (bus->parent) {
+			for (i = 0; i < 4; ++i)
+				bus->resource[i] = bus->parent->resource[i];
+		}
+	}
+}
+
 int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 {
 	int len;
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index 700d478..37b04ad 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -82,6 +82,7 @@ struct ccsr_pci {
 };
 
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
+extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 
 #endif /* __POWERPC_FSL_PCI_H */
 #endif /* __KERNEL__ */
-- 
1.5.2.2
