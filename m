Return-Path: <brking@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DFB872C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 07:07:59 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Wed, 22 May 2013 15:07:56 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5F6D719D8036
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 15:07:47 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4ML7ndx069424
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 15:07:49 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4ML7ndl006574
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 15:07:49 -0600
Message-Id: <201305222107.r4ML7lX4006324@d03av01.boulder.ibm.com>
Subject: [PATCHv2 1/1] powerpc: Force 32 bit MSIs on systems lacking firmware
 support
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Wed, 22 May 2013 16:07:46 -0500
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

 arch/powerpc/platforms/pseries/msi.c |   35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff -puN arch/powerpc/platforms/pseries/msi.c~powerpc_32bit_msi_hack_on_papr arch/powerpc/platforms/pseries/msi.c
--- linux/arch/powerpc/platforms/pseries/msi.c~powerpc_32bit_msi_hack_on_papr	2013-05-15 10:44:46.000000000 -0500
+++ linux-bjking1/arch/powerpc/platforms/pseries/msi.c	2013-05-22 10:51:17.000000000 -0500
@@ -401,6 +401,7 @@ static int rtas_setup_msi_irqs(struct pc
 	struct msi_desc *entry;
 	struct msi_msg msg;
 	int nvec = nvec_in;
+	int use_32bit_msi_hack = 0;
 
 	pdn = get_pdn(pdev);
 	if (!pdn)
@@ -428,15 +429,43 @@ static int rtas_setup_msi_irqs(struct pc
 	 */
 again:
 	if (type == PCI_CAP_ID_MSI) {
-		if (pdn->force_32bit_msi)
+		if (pdn->force_32bit_msi) {
 			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSI_FN, nvec);
-		else
+			if (rc < 0) {
+				/*
+				 * We only want to run the 32 bit MSI hack below if
+				 * the max bus speed is Gen2 speed
+				 */
+				if (pdev->bus->max_bus_speed != PCIE_SPEED_5_0GT)
+					return rc;
+
+				use_32bit_msi_hack = 1;
+			}
+		} else
+			rc = -1;
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
+			u32 addr_hi, addr_lo;
+
+			/*
+			 * We should only get in here for IODA1 configs. This is based on the
+			 * fact that we using RTAS for MSIs, we don't have the 32 bit MSI RTAS
+			 * support, and we are in a PCIe Gen2 slot.
+			 */
+			dev_info(&pdev->dev, "rtas_msi: No 32 bit MSI firmware support, forcing 32 bit MSI\n");
+			pci_read_config_dword(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI, &addr_hi);
+			addr_lo = 0xffff0000 | ((addr_hi >> (48 - 32)) << 4);
+			pci_write_config_dword(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO, addr_lo);
+			pci_write_config_dword(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI, 0);
+		}
 	} else
 		rc = rtas_change_msi(pdn, RTAS_CHANGE_MSIX_FN, nvec);
 
_
