Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ddac4814a020b7d4248834f846d7a7afe1ce1567.1242968955.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/maple: Add a quirk to disable MSI for IPR on Bimini
Date: Fri, 22 May 2009 15:10:23 +1000 (EST)
Cc: James.Bottomley@HansenPartnership.com, brking@linux.vnet.ibm.com,
	wayneb@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/maple/pci.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)


It's getting late in the cycle, so until we can work out what's wrong
with IPR + MSI on Bimini, add a quirk to disable MSI for IPR.

diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 3018552..04296ff 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -592,3 +592,17 @@ int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
 	}
 	return irq;
 }
+
+static void __devinit quirk_ipr_msi(struct pci_dev *dev)
+{
+	/* Something prevents MSIs from the IPR from working on Bimini,
+	 * and the driver has no smarts to recover. So disable MSI
+	 * on it for now. */
+
+	if (machine_is(maple)) {
+		dev->no_msi = 1;
+		dev_info(&dev->dev, "Quirk disabled MSI\n");
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_OBSIDIAN,
+			quirk_ipr_msi);
-- 
1.6.2.1
