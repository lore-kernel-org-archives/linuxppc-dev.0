Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 733571A0BAB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:22 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 18:43:20 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7471F394005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 18:43:16 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDAD464946408
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:11 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DD8Uo013192
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:10 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 09/50] powerpc/powernv: Fix initial IO and M32 segmap
Date: Thu,  5 Nov 2015 00:12:09 +1100
Message-Id: <1446642770-4681-10-git-send-email-gwshan@linux.vnet.ibm.com>
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

There are two arrays for IO and M32 segment maps on every PHB.
The index of the arrays are segment number and the value stored
in the corresponding element is PE number, indicating the segment
is assigned to the PE. Initially, all elements in those two arrays
are zeroes, meaning all segments are assigned to PE#0. It's wrong.

This fixes the initial values in the elements of those two arrays
to IODA_INVALID_PE, meaning all segments aren't assigned to any
PE. In order to use IODA_INVALID_PE (-1) to represent invalid PE
number, the types of those two arrays are changed from "unsigned int"
to "int".

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++++++--
 arch/powerpc/platforms/powernv/pci.h      | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b4932c3..7ee7cfe 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3008,7 +3008,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	unsigned long size, m32map_off, pemap_off, iomap_off = 0;
 	const __be64 *prop64;
 	const __be32 *prop32;
-	int len;
+	int i, len;
 	u64 phb_id;
 	void *aux;
 	long rc;
@@ -3101,8 +3101,13 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	aux = memblock_virt_alloc(size, 0);
 	phb->ioda.pe_alloc = aux;
 	phb->ioda.m32_segmap = aux + m32map_off;
-	if (phb->type == PNV_PHB_IODA1)
+	for (i = 0; i < phb->ioda.total_pe_num; i++)
+		phb->ioda.m32_segmap[i] = IODA_INVALID_PE;
+	if (phb->type == PNV_PHB_IODA1) {
 		phb->ioda.io_segmap = aux + iomap_off;
+		for (i = 0; i < phb->ioda.total_pe_num; i++)
+			phb->ioda.io_segmap[i] = IODA_INVALID_PE;
+	}
 	phb->ioda.pe_array = aux + pemap_off;
 	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index d11f0a5..2e01edd 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -148,8 +148,8 @@ struct pnv_phb {
 			struct pnv_ioda_pe	*pe_array;
 
 			/* M32 & IO segment maps */
-			unsigned int		*m32_segmap;
-			unsigned int		*io_segmap;
+			int			*m32_segmap;
+			int			*io_segmap;
 
 			/* IRQ chip */
 			int			irq_chip_init;
-- 
2.1.0
