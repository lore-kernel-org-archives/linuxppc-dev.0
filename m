Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E947D1A0655
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:16 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:16 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 410AD3578060
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:12 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764D48050069656
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:12 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764CbDw026474
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:12:39 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 19/42] powerpc/powernv: Reserve PE# for root bus
Date: Thu,  6 Aug 2015 14:11:24 +1000
Message-Id: <1438834307-26960-20-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pcibios_setup_bridge() is normally called to update PCI bridge
windows. It allocates PE for PCI buses. However it is not called
on a root bus which does not have an upstream bridge.

This reserves PE# for a root bus in advance. This will be used in
the subsequent patch to do setup.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 30 +++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.h      |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1c950e8..8aa6ab8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -236,6 +236,13 @@ static int pnv_ioda1_init_m64(struct pnv_phb *phb)
 		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
 			phb->ioda.reserved_pe_idx);
 
+	/* Strip off the M64 segment corresponding to the PE#
+	 * for PCI root bus, which is last supported PE# or
+	 * (reserved PE# - 1).
+	 */
+	if (phb->ioda.root_pe_idx != IODA_INVALID_PE)
+		r->end -= phb->ioda.m64_segsize;
+
 	return 0;
 
 fail:
@@ -293,6 +300,13 @@ static int pnv_ioda2_init_m64(struct pnv_phb *phb)
 		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
 			phb->ioda.reserved_pe_idx);
 
+	/* Strip off the M64 segment corresponding to the PE#
+	 * for PCI root bus, which is last supported PE# or
+	 * (reserved PE# - 1).
+	 */
+	if (phb->ioda.root_pe_idx != IODA_INVALID_PE)
+		r->end -= phb->ioda.m64_segsize;
+
 	return 0;
 
 fail:
@@ -3237,7 +3251,21 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	aux = memblock_virt_alloc(size, 0);
 	phb->ioda.pe_alloc = aux;
 	phb->ioda.pe_array = aux + pemap_off;
-	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
+
+	/* Choose number of PE for root bus, which shouldn't consume
+	 * any M64 resource. So we avoid picking low-end PE#, which
+	 * is usually bound with M64 resources closely.
+	 */
+	pnv_ioda_reserve_pe(phb, phb->ioda.reserved_pe_idx);
+	if (phb->ioda.reserved_pe_idx == 0) {
+		phb->ioda.root_pe_idx = phb->ioda.total_pe_num - 1;
+		pnv_ioda_reserve_pe(phb, phb->ioda.root_pe_idx);
+	} else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1)) {
+		phb->ioda.root_pe_idx = phb->ioda.reserved_pe_idx - 1;
+		pnv_ioda_reserve_pe(phb, phb->ioda.root_pe_idx);
+	} else {
+		phb->ioda.root_pe_idx = IODA_INVALID_PE;
+	}
 
 	INIT_LIST_HEAD(&phb->ioda.pe_dma_list);
 	INIT_LIST_HEAD(&phb->ioda.pe_list);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index fc899cd..e93a489 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -135,6 +135,7 @@ struct pnv_phb {
 		struct {
 			/* Global bridge info */
 			unsigned int		total_pe_num;
+			unsigned int		root_pe_idx;
 			unsigned int		reserved_pe_idx;
 
 			/* 32-bit MMIO window */
-- 
2.1.0
