Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82E5EDE0F9
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 07:28:01 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n4CLRgnR015386
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 16:27:47 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl: Support unique MSI addresses per PCIe Root
	Complex
Date: Tue, 12 May 2009 16:27:34 -0500
Message-Id: <1242163655-880-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1242163655-880-1-git-send-email-galak@kernel.crashing.org>
References: <1242163655-880-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Its feasible based on how the PCI address map is setup that the region
of PCI address space used for MSIs differs for each PHB on the same SoC.

Instead of assuming that the address mappes to CCSRBAR 1:1 we read
PEXCSRBAR (BAR0) for the PHB that the given pci_dev is on.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_msi.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index f25ce81..da38a1f 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -113,8 +113,13 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 				  struct msi_msg *msg)
 {
 	struct fsl_msi *msi_data = fsl_msi;
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	u32 base = 0;
 
-	msg->address_lo = msi_data->msi_addr_lo;
+	pci_bus_read_config_dword(hose->bus,
+		PCI_DEVFN(0, 0), PCI_BASE_ADDRESS_0, &base);
+
+	msg->address_lo = msi_data->msi_addr_lo + base;
 	msg->address_hi = msi_data->msi_addr_hi;
 	msg->data = hwirq;
 
@@ -271,7 +276,7 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 	msi->irqhost->host_data = msi;
 
 	msi->msi_addr_hi = 0x0;
-	msi->msi_addr_lo = res.start + features->msiir_offset;
+	msi->msi_addr_lo = features->msiir_offset + (res.start & 0xfffff);
 
 	rc = fsl_msi_init_allocator(msi);
 	if (rc) {
-- 
1.6.0.6
