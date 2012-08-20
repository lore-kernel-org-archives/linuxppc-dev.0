Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB2CB2C0521
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 23:50:41 +1000 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 20 Aug 2012 09:50:37 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 6496B6E8054
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 09:49:29 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7KDnTAZ115998
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 09:49:29 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7KDnS2B031250
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2012 09:49:29 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/8] ppc/pnv: skip check on PE if necessary
Date: Mon, 20 Aug 2012 21:49:18 +0800
Message-Id: <1345470561-17785-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1345470561-17785-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1345470561-17785-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: weiyang@linux.vnet.ibm.com, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While the device driver or PCI core tries to enable PCI device, the
platform dependent callback "ppc_md.pcibios_enable_device_hook" will
be called to check if there has one associated PE for the PCI device.
If we don't have the associated PE for the PCI device, it's not allowed
to enable the PCI device. Unfortunately, there might have some cases
we have to enable the PCI device (e.g. P2P bridge), but the PEs have
not been created yet.

The patch handles the unfortunate cases. Each PHB (struct pnv_phb)
has one field "initialized" to trace if the PEs have been created
and configured or not. When the PEs are not available, we won't check
the associated PE for the PCI device to be enabled.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   19 ++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.h      |    1 +
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 09deab2..adaef11 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1245,9 +1245,14 @@ static void __devinit pnv_pci_ioda_setup_seg(void)
 static void __devinit pnv_pci_ioda_setup_DMA(void)
 {
 	struct pci_controller *hose, *tmp;
+	struct pnv_phb *phb;
 
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		pnv_ioda_setup_dma(hose->private_data);
+
+		/* Mark the PHB initialization done */
+		phb = hose->private_data;
+		phb->initialized = 1;
 	}
 }
 
@@ -1300,10 +1305,22 @@ out:
  */
 static int __devinit pnv_pci_enable_device_hook(struct pci_dev *dev)
 {
-	struct pci_dn *pdn = pnv_ioda_get_pdn(dev);
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_dn *pdn;
 
+	/* The function is probably called while the PEs have
+	 * not be created yet. For example, resource reassignment
+	 * during PCI probe period. We just skip the check if
+	 * PEs isn't ready.
+	 */
+	if (!phb->initialized)
+		return 0;
+
+	pdn = pnv_ioda_get_pdn(dev);
 	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
 		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index b70720b..7cfb7c8 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -69,6 +69,7 @@ struct pnv_phb {
 	enum pnv_phb_model	model;
 	u64			opal_id;
 	void __iomem		*regs;
+	int			initialized;
 	spinlock_t		lock;
 
 #ifdef CONFIG_PCI_MSI
-- 
1.7.5.4
