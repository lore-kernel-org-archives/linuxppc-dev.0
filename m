Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9240DDEF8
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:51:07 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 18/25] [POWERPC] FSL: Add support for PCI-X controllers
Date: Mon, 23 Jul 2007 15:50:05 -0500
Message-Id: <11852238392809-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238383453-git-send-email-galak@kernel.crashing.org>
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
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some set of 85xx platforms have PCI-X controllers.  The old arch/ppc
code setup these controllers and we haven't moved it over to arch/powerpc.

We use the PCI-X Capabilties to know if we are in PCI-X mode instead
of the Global Utilities PORDEVSR.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_pci.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index fc3e13e..06a2a9b 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -89,11 +89,22 @@ void __init setup_pci_atmu(struct pci_controller *hose, struct resource *rsrc)
 void __init setup_pci_cmd(struct pci_controller *hose)
 {
 	u16 cmd;
+	int cap_x;
+
 	early_read_config_word(hose, 0, 0, PCI_COMMAND, &cmd);
 	cmd |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
 		| PCI_COMMAND_IO;
 	early_write_config_word(hose, 0, 0, PCI_COMMAND, cmd);
-	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
+
+	cap_x = early_find_capability(hose, 0, 0, PCI_CAP_ID_PCIX);
+	if (cap_x) {
+		int pci_x_cmd = cap_x + PCI_X_CMD;
+		cmd = PCI_X_CMD_MAX_SPLIT | PCI_X_CMD_MAX_READ
+			| PCI_X_CMD_ERO | PCI_X_CMD_DPERR_E;
+		early_write_config_word(hose, 0, 0, pci_x_cmd, cmd);
+	} else {
+		early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
+	}
 }
 
 static void __devinit quirk_fsl_pcie_transparent(struct pci_dev *dev)
-- 
1.5.2.2
