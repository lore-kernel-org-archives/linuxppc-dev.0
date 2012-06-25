Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 418481007D6
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2012 01:52:35 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 25 Jun 2012 09:52:31 -0600
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 2C083C90E19
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 11:44:17 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5PFiEvv19005478
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 11:44:15 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5PFhSRc003151
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 11:43:29 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/8] ppc/pnv: PE list based on creation order
Date: Mon, 25 Jun 2012 23:43:15 +0800
Message-Id: <1340639001-28152-3-git-send-email-shangw@linux.vnet.ibm.com>
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

The resource (I/O and MMIO) will be assigned on basis of PE from
top to bottom so that we can implement the trick here: the resource
that has been assigned to parent PE could be taken by child PE if
necessary.

The current implementation already has PE list per PHB basis, but
the list doesn't meet our requirment: tracing PE based on their
cration time from top to bottom. So the patch does rename for the
DMA based PE list and introduces the list to trace the PEs sequentially
based on their creation time.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   12 ++++++++----
 arch/powerpc/platforms/powernv/pci.h      |   10 ++++++++--
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1504795..6a7672e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -657,13 +657,13 @@ static void __devinit pnv_ioda_link_pe_by_weight(struct pnv_phb *phb,
 {
 	struct pnv_ioda_pe *lpe;
 
-	list_for_each_entry(lpe, &phb->ioda.pe_list, link) {
+	list_for_each_entry(lpe, &phb->ioda.pe_dma_list, dma_link) {
 		if (lpe->dma_weight < pe->dma_weight) {
-			list_add_tail(&pe->link, &lpe->link);
+			list_add_tail(&pe->dma_link, &lpe->dma_link);
 			return;
 		}
 	}
-	list_add_tail(&pe->link, &phb->ioda.pe_list);
+	list_add_tail(&pe->dma_link, &phb->ioda.pe_dma_list);
 }
 
 static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
@@ -830,6 +830,9 @@ static void __devinit pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 	/* Associate it with all child devices */
 	pnv_ioda_setup_same_PE(bus, pe);
 
+	/* Put PE to the list */
+	list_add_tail(&pe->list, &phb->ioda.pe_list);
+
 	/* Account for one DMA PE if at least one DMA capable device exist
 	 * below the bridge
 	 */
@@ -1013,7 +1016,7 @@ static void __devinit pnv_ioda_setup_dma(struct pnv_phb *phb)
 	remaining = phb->ioda.tce32_count;
 	tw = phb->ioda.dma_weight;
 	base = 0;
-	list_for_each_entry(pe, &phb->ioda.pe_list, link) {
+	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
 		if (!pe->dma_weight)
 			continue;
 		if (!remaining) {
@@ -1269,6 +1272,7 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	phb->ioda.pe_array = aux + pemap_off;
 	set_bit(0, phb->ioda.pe_alloc);
 
+	INIT_LIST_HEAD(&phb->ioda.pe_dma_list);
 	INIT_LIST_HEAD(&phb->ioda.pe_list);
 
 	/* Calculate how many 32-bit TCE segments we have */
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 0cb760c..b70720b 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -59,7 +59,8 @@ struct pnv_ioda_pe {
 	int			mve_number;
 
 	/* Link in list of PE#s */
-	struct list_head	link;
+	struct list_head	dma_link;
+	struct list_head	list;
 };
 
 struct pnv_phb {
@@ -107,6 +108,11 @@ struct pnv_phb {
 			unsigned int		*io_segmap;
 			struct pnv_ioda_pe	*pe_array;
 
+			/* Sorted list of used PE's based
+			 * on the sequence of creation
+			 */
+			struct list_head	pe_list;
+
 			/* Reverse map of PEs, will have to extend if
 			 * we are to support more than 256 PEs, indexed
 			 * bus { bus, devfn }
@@ -125,7 +131,7 @@ struct pnv_phb {
 			/* Sorted list of used PE's, sorted at
 			 * boot for resource allocation purposes
 			 */
-			struct list_head	pe_list;
+			struct list_head	pe_dma_list;
 		} ioda;
 	};
 
-- 
1.7.9.5
