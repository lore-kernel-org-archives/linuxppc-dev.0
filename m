Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 136F3B6FA9
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2012 02:14:33 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 25 Jun 2012 10:14:31 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 945CE19D94D7
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 15:43:50 +0000 (WET)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5PFhc5J170692
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 09:43:42 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5PFhWRn021091
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 09:43:33 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/8] ppc/pnv: skip check on PE if necessary
Date: Mon, 25 Jun 2012 23:43:18 +0800
Message-Id: <1340639001-28152-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340639001-28152-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340639001-28152-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
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
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f0ae647..052a50f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1246,9 +1246,14 @@ static void __devinit pnv_pci_ioda_setup_seg(void)
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
 
@@ -1264,10 +1269,22 @@ static void __devinit pnv_pci_ioda_fixup(void)
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
1.7.9.5
