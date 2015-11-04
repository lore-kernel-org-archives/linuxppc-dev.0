Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C1EF1A0C1D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 02:40:10 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 21:10:07 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3D5533940064
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 21:10:03 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4Fa02X983382
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 21:09:58 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDI4a032379
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:19 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 25/50] powerpc/powernv: Reserve PE for root bus
Date: Thu,  5 Nov 2015 00:12:25 +1100
Message-Id: <1446642770-4681-26-git-send-email-gwshan@linux.vnet.ibm.com>
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

We're going to reserve/assign PEs when pcibios_setup_bridge() is
called. The function won't be called for root bus as it doesn't
have parent bridge. However, the root bus still needs a PE to be
covered.

This reserves PE numbers that are adjacent to the reserved one
for root buses.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 33 ++++++++++++++++++++++---------
 arch/powerpc/platforms/powernv/pci.h      |  1 +
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index eea1c96..5e6745f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -207,14 +207,14 @@ static int pnv_ioda2_init_m64(struct pnv_phb *phb)
 	set_bit(phb->ioda.m64_bar_idx, &phb->ioda.m64_bar_alloc);
 
 	/*
-	 * Strip off the segment used by the reserved PE, which is
-	 * expected to be 0 or last one of PE capabicity.
+	 * Exclude the segments for reserved and root bus PE, which
+	 * are first or last two PEs.
 	 */
 	r = &phb->hose->mem_resources[1];
 	if (phb->ioda.reserved_pe_idx == 0)
-		r->start += phb->ioda.m64_segsize;
+		r->start += (2 * phb->ioda.m64_segsize);
 	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
-		r->end -= phb->ioda.m64_segsize;
+		r->end -= (2 * phb->ioda.m64_segsize);
 	else
 		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
 			phb->ioda.reserved_pe_idx);
@@ -294,14 +294,14 @@ static int pnv_ioda1_init_m64(struct pnv_phb *phb)
 	}
 
 	/*
-	 * Exclude the segment used by the reserved PE, which
-	 * is expected to be 0 or last supported PE#.
+	 * Exclude the segments for reserved and root bus PE, which
+	 * are first or last two PEs.
 	 */
 	r = &phb->hose->mem_resources[1];
 	if (phb->ioda.reserved_pe_idx == 0)
-		r->start += phb->ioda.m64_segsize;
+		r->start += (2 * phb->ioda.m64_segsize);
 	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
-		r->end -= phb->ioda.m64_segsize;
+		r->end -= (2 * phb->ioda.m64_segsize);
 	else
 		pr_warn("  Cannot cut M64 segment for reserved PE#%d\n",
 			phb->ioda.reserved_pe_idx);
@@ -3231,7 +3231,22 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 			phb->ioda.dma32_segmap[i] = IODA_INVALID_PE;
 	}
 	phb->ioda.pe_array = aux + pemap_off;
-	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
+
+	/*
+	 * Choose PE number for root bus, which shouldn't have
+	 * M64 resources consumed by its child devices. To pick
+	 * the PE number adjacent to the reserved one if possible.
+	 */
+	pnv_ioda_reserve_pe(phb, phb->ioda.reserved_pe_idx);
+	if (phb->ioda.reserved_pe_idx == 0) {
+		phb->ioda.root_pe_idx = 1;
+		pnv_ioda_reserve_pe(phb, phb->ioda.root_pe_idx);
+	} else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1)) {
+		phb->ioda.root_pe_idx = phb->ioda.reserved_pe_idx - 1;
+		pnv_ioda_reserve_pe(phb, phb->ioda.root_pe_idx);
+	} else {
+		phb->ioda.root_pe_idx = IODA_INVALID_PE;
+	}
 
 	INIT_LIST_HEAD(&phb->ioda.pe_list);
 	mutex_init(&phb->ioda.pe_list_mutex);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index e55ab0e..a8ba97f 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -120,6 +120,7 @@ struct pnv_phb {
 			/* Global bridge info */
 			unsigned int		total_pe_num;
 			unsigned int		reserved_pe_idx;
+			unsigned int		root_pe_idx;
 
 			/* 32-bit MMIO window */
 			unsigned int		m32_size;
-- 
2.1.0
