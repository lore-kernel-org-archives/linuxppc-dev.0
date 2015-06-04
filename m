Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 164E81A0D29
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:39 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:43:38 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4BA1F2BB0068
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hRfV52887700
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546h1gC005358
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 15/42] powerpc/powernv: Reserve PE# for root bus
Date: Thu,  4 Jun 2015 16:41:44 +1000
Message-Id: <1433400131-18429-16-git-send-email-gwshan@linux.vnet.ibm.com>
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

pcibios_setup_bridge(), called to update PCI bridge windows, will
allocate PE for PCI buses. The function isn't called for root bus
that doesn't have upstream bridge. The patch reserves PE# for root
bus in advance so that we can setup it in next patch.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from [PATCH v5 v4 06/21]
  * Replace "strip of" with "strip off" in comments
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 31 ++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.h      |  1 +
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0d6539a..2eb8baa 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -230,6 +230,13 @@ static int pnv_ioda1_init_m64(struct pnv_phb *phb)
 		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
 			phb->ioda.reserved_pe);
 
+	/* Strip off the segment used by PE for PCI root bus,
+	 * which is last supported PE#, or one next to the
+	 * reserved PE#
+	 */
+	if (phb->ioda.root_pe != IODA_INVALID_PE)
+		r->end -= phb->ioda.m64_segsize;
+
 	return 0;
 
 fail:
@@ -287,6 +294,13 @@ static int pnv_ioda2_init_m64(struct pnv_phb *phb)
 		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
 			phb->ioda.reserved_pe);
 
+	/* Strip off the segment used by PE for PCI root bus,
+	 * which is last supported PE#, or one next to the
+	 * reserved PE#
+	 */
+	if (phb->ioda.root_pe != IODA_INVALID_PE)
+		r->end -= phb->ioda.m64_segsize;
+
 	return 0;
 
 fail:
@@ -3331,7 +3345,22 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	aux = memblock_virt_alloc(size, 0);
 	phb->ioda.pe_alloc = aux;
 	phb->ioda.pe_array = aux + pemap_off;
-	set_bit(phb->ioda.reserved_pe, phb->ioda.pe_alloc);
+
+	/* Choose number of PE for root bus, which shouldn't consume
+	 * any M64 resource. So we avoid picking low-end PE#, which
+	 * is usually binding with 64-bits prefetchable memory resources
+	 * closely.
+	 */
+	pnv_ioda_reserve_pe(phb, phb->ioda.reserved_pe);
+	if (phb->ioda.reserved_pe == 0) {
+		phb->ioda.root_pe = phb->ioda.total_pe - 1;
+		pnv_ioda_reserve_pe(phb, phb->ioda.root_pe);
+	} else if (phb->ioda.reserved_pe == (phb->ioda.total_pe - 1)) {
+		phb->ioda.root_pe = phb->ioda.reserved_pe - 1;
+		pnv_ioda_reserve_pe(phb, phb->ioda.root_pe);
+	} else {
+		phb->ioda.root_pe = IODA_INVALID_PE;
+	}
 
 	INIT_LIST_HEAD(&phb->ioda.pe_dma_list);
 	INIT_LIST_HEAD(&phb->ioda.pe_list);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 590f778..e372b9f 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -133,6 +133,7 @@ struct pnv_phb {
 		struct {
 			/* Global bridge info */
 			unsigned int		total_pe;
+			unsigned int		root_pe;
 			unsigned int		reserved_pe;
 
 			/* 32-bit MMIO window */
-- 
2.1.0
