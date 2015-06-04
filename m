Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B774D1A0D94
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:53 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:44:52 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DAA8D3578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:49 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hRol49807586
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546h10D005375
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 20/42] powerpc/powernv: Rename pnv_ioda_get_pe() to
 pnv_ioda_dev_to_pe()
Date: Thu,  4 Jun 2015 16:41:49 +1000
Message-Id: <1433400131-18429-21-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pnv_ioda_get_pe() indicates it's increasing refcount to the given
PE instance from the name. However, it gets the instance of the
PE, which contains the indicated PCI device. The patch renames it
to pnv_ioda_dev_to_pe() to reflect its purpose.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from PATCH[v4 07/21]
  * Fixed "do not use assignment in if condition" from checkpatch.pl
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0447534..e9165fa 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -702,7 +702,7 @@ static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
  * but in the meantime, we need to protect them to avoid warnings
  */
 #ifdef CONFIG_PCI_MSI
-static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
+static struct pnv_ioda_pe *pnv_ioda_dev_to_pe(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -2671,7 +2671,7 @@ int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode)
 	struct pnv_ioda_pe *pe;
 	int rc;
 
-	pe = pnv_ioda_get_pe(dev);
+	pe = pnv_ioda_dev_to_pe(dev);
 	if (!pe)
 		return -ENODEV;
 
@@ -2787,7 +2787,8 @@ int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 	struct pnv_ioda_pe *pe;
 	int rc;
 
-	if (!(pe = pnv_ioda_get_pe(dev)))
+	pe = pnv_ioda_dev_to_pe(dev);
+	if (!pe)
 		return -ENODEV;
 
 	/* Assign XIVE to PE */
@@ -2809,7 +2810,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 				  unsigned int hwirq, unsigned int virq,
 				  unsigned int is_64, struct msi_msg *msg)
 {
-	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(dev);
+	struct pnv_ioda_pe *pe = pnv_ioda_dev_to_pe(dev);
 	unsigned int xive_num = hwirq - phb->msi_base;
 	__be32 data;
 	int rc;
-- 
2.1.0
