Return-Path: <brking@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E22B22C009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 07:54:12 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Tue, 21 May 2013 17:54:08 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6AE2D38C8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 17:54:06 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4LLs6cv323478
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 17:54:06 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4LLs6HD026221
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 18:54:06 -0300
Message-Id: <201305212154.r4LLs4Zu026123@d01av03.pok.ibm.com>
Subject: [PATCH 1/1] powerpc: Force 32 bit MSIs on systems lacking firmware
 support
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Tue, 21 May 2013 16:54:04 -0500
Cc: klebers@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Recent commit e61133dda480062d221f09e4fc18f66763f8ecd0 added support
for a new firmware feature to force an adapter to use 32 bit MSIs.
However, this firmware is not available for all systems. The hack below
allows devices needing 32 bit MSIs to work on these systems as well.
It is careful to only enable this on Gen2 slots, which should limit
this to configurations where this hack is needed and tested to work.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/pseries/msi.c |   31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff -puN arch/powerpc/platforms/pseries/msi.c~powerpc_32bit_msi_hack_on_papr arch/powerpc/platforms/pseries/msi.c
--- linux/arch/powerpc/platforms/pseries/msi.c~powerpc_32bit_msi_hack_on_papr	2013-05-15 10:44:46.000000000 -0500
+++ linux-bjking1/arch/powerpc/platforms/pseries/msi.c	2013-05-20 15:24:52.000000000 -0500
@@ -397,10 +397,11 @@ static int check_msix_entries(struct pci
 static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
 {
 	struct pci_dn *pdn;
-	int hwirq, virq, i, rc;
+	int hwirq, virq, i, rc = -1;
 	struct msi_desc *entry;
 	struct msi_msg msg;
 	int nvec = nvec_in;
+	int use_32bit_msi_hack = 0;
 
 	pdn = get_pdn(pdev);
 	if (!pdn)
@@ -428,15 +429,37 @@ static int rtas_setup_msi_irqs(struct pc
 	 */
 again:
 	if (type == PCI_CAP_ID_MSI) {
-		if (pdn->force_32bit_msi)
+		if (pdn->force_32bit_msi) {
 			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSI_FN, nvec);
-		else
+			if (rc < 0) {
+				/* We only want to run the 32 bit MSI hack below if
+				 the max bus speed is Gen2 speed. */
+				if (pdev->bus->max_bus_speed != PCIE_SPEED_5_0GT)
+					return rc;
+
+				use_32bit_msi_hack = 1;
+			}
+		}
+
+		if (rc < 0)
 			rc = rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, nvec);
 
-		if (rc < 0 && !pdn->force_32bit_msi) {
+		if (rc < 0) {
 			pr_debug("rtas_msi: trying the old firmware call.\n");
 			rc = rtas_change_msi(pdn, RTAS_CHANGE_FN, nvec);
 		}
+
+		if (use_32bit_msi_hack && rc > 0) {
+			int pos;
+			u32 addr_hi, addr_lo;
+
+			dev_info(&pdev->dev, "rtas_msi: No 32 bit MSI firmware support, forcing 32 bit MSI\n");
+			pos = pci_find_capability(pdev, PCI_CAP_ID_MSI);
+			pci_read_config_dword(pdev, pos + PCI_MSI_ADDRESS_HI, &addr_hi);
+			addr_lo = 0xffff0000 | ((addr_hi >> (48 - 32)) << 4);
+			pci_write_config_dword(pdev, pos + PCI_MSI_ADDRESS_LO, addr_lo);
+			pci_write_config_dword(pdev, pos + PCI_MSI_ADDRESS_HI, 0);
+		}
 	} else
 		rc = rtas_change_msi(pdn, RTAS_CHANGE_MSIX_FN, nvec);
 
_
