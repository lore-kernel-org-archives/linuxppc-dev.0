Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0FA61A0C74
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:56 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:13:56 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C8B142BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:54 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDWIX35913964
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:40 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDLP7030440
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:22 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 12/50] powerpc/powernv: Track M64 segment consumption
Date: Thu,  5 Nov 2015 00:12:12 +1100
Message-Id: <1446642770-4681-13-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As we track M32 segment consumption, this introduces an array to
the PHB to track the mapping between M64 segment and PE number.
The information is going to be used to find M64 segment from the
PE number during PCI unplugging time in subsequent patches.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++--
 arch/powerpc/platforms/powernv/pci.h      |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 4ab93f8..76ce694 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -315,6 +315,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
 		phb->ioda.total_pe_num) {
 		pe = &phb->ioda.pe_array[i];
 
+		phb->ioda.m64_segmap[pe->pe_number] = pe->pe_number;
 		if (!master_pe) {
 			pe->flags |= PNV_IODA_PE_MASTER;
 			INIT_LIST_HEAD(&pe->slaves);
@@ -3018,7 +3019,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 {
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
-	unsigned long size, m32map_off, pemap_off, iomap_off = 0;
+	unsigned long size, m64map_off, m32map_off, pemap_off, iomap_off = 0;
 	const __be64 *prop64;
 	const __be32 *prop32;
 	int i, len;
@@ -3103,6 +3104,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 
 	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
 	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
+	m64map_off = size;
+	size += phb->ioda.total_pe_num * sizeof(phb->ioda.m64_segmap[0]);
 	m32map_off = size;
 	size += phb->ioda.total_pe_num * sizeof(phb->ioda.m32_segmap[0]);
 	if (phb->type == PNV_PHB_IODA1) {
@@ -3113,9 +3116,12 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	size += phb->ioda.total_pe_num * sizeof(struct pnv_ioda_pe);
 	aux = memblock_virt_alloc(size, 0);
 	phb->ioda.pe_alloc = aux;
+	phb->ioda.m64_segmap = aux + m64map_off;
 	phb->ioda.m32_segmap = aux + m32map_off;
-	for (i = 0; i < phb->ioda.total_pe_num; i++)
+	for (i = 0; i < phb->ioda.total_pe_num; i++) {
+		phb->ioda.m64_segmap[i] = IODA_INVALID_PE;
 		phb->ioda.m32_segmap[i] = IODA_INVALID_PE;
+	}
 	if (phb->type == PNV_PHB_IODA1) {
 		phb->ioda.io_segmap = aux + iomap_off;
 		for (i = 0; i < phb->ioda.total_pe_num; i++)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 2e01edd..671fd13 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -147,7 +147,8 @@ struct pnv_phb {
 			unsigned long		*pe_alloc;
 			struct pnv_ioda_pe	*pe_array;
 
-			/* M32 & IO segment maps */
+			/* M64/M32/IO segment maps */
+			int			*m64_segmap;
 			int			*m32_segmap;
 			int			*io_segmap;
 
-- 
2.1.0
