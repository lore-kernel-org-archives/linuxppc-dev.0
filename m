Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 074A1DDEB7
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:51:18 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 25/25] [POWERPC] 85xx: Added needed MPC85xx PCI device IDs
Date: Mon, 23 Jul 2007 15:50:12 -0500
Message-Id: <11852238502986-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238481049-git-send-email-galak@kernel.crashing.org>
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
	<11852238271141-git-send-email-galak@kernel.crashing.org>
	<11852238283648-git-send-email-galak@kernel.crashing.org>
	<1185223830411-git-send-email-galak@kernel.crashing.org>
	<11852238322319-git-send-email-galak@kernel.crashing.org>
	<11852238333649-git-send-email-galak@kernel.crashing.org>
	<11852238353292-git-send-email-galak@kernel.crashing.org>
	<11852238362041-git-send-email-galak@kernel.crashing.org>
	<11852238383453-git-send-email-galak@kernel.crashing.org>
	<11852238392809-git-send-email-galak@kernel.crashing.org>
	<11852238411823-git-send-email-galak@kernel.crashing.org>
	<11852238421611-git-send-email-galak@kernel.crashing.org>
	<11852238432011-git-send-email-galak@kernel.crashing.org>
	<11852238452609-git-send-email-galak@kernel.crashing.org>
	<11852238472931-git-send-email-galak@kernel.crashing.org>
	<11852238481049-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added the MPC85xx PCI device IDs that we need for the quirks we have.

Also, fixed the MPC8567E, MPC8567 device IDs which had the wrong value.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_pci.c |   26 +++++++++++++-------------
 include/linux/pci_ids.h       |   13 +++++++++++++
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 267edbd..9298da8 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -240,18 +240,18 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	return 0;
 }
 
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0012, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0013, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0014, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0015, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0018, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0019, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x001a, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0020, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0021, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0024, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0025, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0030, quirk_fsl_pcie_transparent);
-DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0031, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8548E, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8548, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8543E, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8543, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8547E, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8545E, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8545, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8568E, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8568, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8567E, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8567, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8544E, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8544, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8641, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_transparent);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 3c870f1..c086a70 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2076,6 +2076,19 @@
 #define PCI_DEVICE_ID_TDI_EHCI          0x0101
 
 #define PCI_VENDOR_ID_FREESCALE		0x1957
+#define PCI_DEVICE_ID_MPC8548E		0x0012
+#define PCI_DEVICE_ID_MPC8548		0x0013
+#define PCI_DEVICE_ID_MPC8543E		0x0014
+#define PCI_DEVICE_ID_MPC8543		0x0015
+#define PCI_DEVICE_ID_MPC8547E		0x0018
+#define PCI_DEVICE_ID_MPC8545E		0x0019
+#define PCI_DEVICE_ID_MPC8545		0x001a
+#define PCI_DEVICE_ID_MPC8568E		0x0020
+#define PCI_DEVICE_ID_MPC8568		0x0021
+#define PCI_DEVICE_ID_MPC8567E		0x0022
+#define PCI_DEVICE_ID_MPC8567		0x0023
+#define PCI_DEVICE_ID_MPC8544E		0x0030
+#define PCI_DEVICE_ID_MPC8544		0x0031
 #define PCI_DEVICE_ID_MPC8641		0x7010
 #define PCI_DEVICE_ID_MPC8641D		0x7011
 
-- 
1.5.2.2
