Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6ABD01A000C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:02:23 +1100 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B49891400B2
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2014 16:02:22 +1100 (EST)
Message-ID: <1412656708.30859.123.camel@pasglop>
Subject: [PATCH v3 5/7] powerpc/powernv: Honor the generic "no_64bit_msi" flag
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 07 Oct 2014 15:38:28 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Anton Blanchard <anton@au1.ibm.com>,
 Yijing Wang <wangyijing@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of the arch specific quirk which we are deprecating
and that drivers don't understand.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 +--
 arch/powerpc/platforms/powernv/pci.c      | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index df241b1..a188bb8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1311,7 +1311,6 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 				  unsigned int is_64, struct msi_msg *msg)
 {
 	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(dev);
-	struct pci_dn *pdn = pci_get_pdn(dev);
 	struct irq_data *idata;
 	struct irq_chip *ichip;
 	unsigned int xive_num = hwirq - phb->msi_base;
@@ -1327,7 +1326,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 		return -ENXIO;
 
 	/* Force 32-bit MSI on some broken devices */
-	if (pdn && pdn->force_32bit_msi)
+	if (dev->no_64bit_msi)
 		is_64 = 0;
 
 	/* Assign XIVE to PE */
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b854b57..89c6608 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -50,9 +50,8 @@ static int pnv_msi_check_device(struct pci_dev* pdev, int nvec, int type)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
-	struct pci_dn *pdn = pci_get_pdn(pdev);
 
-	if (pdn && pdn->force_32bit_msi && !phb->msi32_support)
+	if (pdev->no_64bit_msi && !phb->msi32_support)
 		return -ENODEV;
 
 	return (phb && phb->msi_bmp.bitmap) ? 0 : -ENODEV;
