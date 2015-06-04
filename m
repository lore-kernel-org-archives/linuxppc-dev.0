Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DA871A08B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:39 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:43:38 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 39AAC2BB005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hR3b22610102
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546h1wG005336
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:02 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 04/42] powerpc/powernv: Trace consumed IO and M32 segments
 by PE
Date: Thu,  4 Jun 2015 16:41:33 +1000
Message-Id: <1433400131-18429-5-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch introduces two bitmaps to trace the IO and M32 segments
consumed by one particular PE, which can be released once the PE
is destroyed during PCI unplugging time. Also, we're using fixed
quantity of bits to trace the used IO and M32 segments by PEs in
one particular PHB. Besides, @pe_array is put to the location
adjacent to @pe_alloc on account of their close relation.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from PATCH[v4 04/21]
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 17 +++++------------
 arch/powerpc/platforms/powernv/pci.h      | 11 ++++++-----
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 71afb38..53d0efd 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2992,7 +2992,8 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 
 			while (index < phb->ioda.total_pe &&
 			       region.start <= region.end) {
-				phb->ioda.io_segmap[index] = pe->pe_number;
+				set_bit(index, phb->ioda.io_segmap);
+				set_bit(index, pe->io_segmap);
 				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
 					pe->pe_number, OPAL_IO_WINDOW_TYPE, 0, index);
 				if (rc != OPAL_SUCCESS) {
@@ -3017,7 +3018,8 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 
 			while (index < phb->ioda.total_pe &&
 			       region.start <= region.end) {
-				phb->ioda.m32_segmap[index] = pe->pe_number;
+				set_bit(index, phb->ioda.m32_segmap);
+				set_bit(index, pe->m32_segmap);
 				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
 					pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
 				if (rc != OPAL_SUCCESS) {
@@ -3196,7 +3198,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 {
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
-	unsigned long size, m32map_off, pemap_off, iomap_off = 0;
+	unsigned long size, pemap_off;
 	const __be64 *prop64;
 	const __be32 *prop32;
 	int len;
@@ -3281,19 +3283,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 
 	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
 	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
-	m32map_off = size;
-	size += phb->ioda.total_pe * sizeof(phb->ioda.m32_segmap[0]);
-	if (phb->type == PNV_PHB_IODA1) {
-		iomap_off = size;
-		size += phb->ioda.total_pe * sizeof(phb->ioda.io_segmap[0]);
-	}
 	pemap_off = size;
 	size += phb->ioda.total_pe * sizeof(struct pnv_ioda_pe);
 	aux = memblock_virt_alloc(size, 0);
 	phb->ioda.pe_alloc = aux;
-	phb->ioda.m32_segmap = aux + m32map_off;
-	if (phb->type == PNV_PHB_IODA1)
-		phb->ioda.io_segmap = aux + iomap_off;
 	phb->ioda.pe_array = aux + pemap_off;
 	set_bit(phb->ioda.reserved_pe, phb->ioda.pe_alloc);
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 54657f4..0a8cecb 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -54,6 +54,8 @@ struct pnv_ioda_pe {
 	 * by slave PEs will be contributed to the master PE. One
 	 * PE can own multiple IO and M32 segments.
 	 */
+	unsigned long		io_segmap[8];
+	unsigned long		m32_segmap[8];
 	unsigned long		m64_segmap[8];
 
 	/* "Weight" assigned to the PE for the sake of DMA resource
@@ -154,16 +156,15 @@ struct pnv_phb {
 			unsigned int		io_segsize;
 			unsigned int		io_pci_base;
 
-			/* PE allocation bitmap */
+			/* PE allocation */
 			unsigned long		*pe_alloc;
-			/* PE allocation mutex */
+			struct pnv_ioda_pe	*pe_array;
 			struct mutex		pe_alloc_mutex;
 
 			/* M32 & IO segment maps */
+			unsigned long		io_segmap[8];
+			unsigned long		m32_segmap[8];
 			unsigned long		m64_segmap[8];
-			unsigned int		*m32_segmap;
-			unsigned int		*io_segmap;
-			struct pnv_ioda_pe	*pe_array;
 
 			/* IRQ chip */
 			int			irq_chip_init;
-- 
2.1.0
