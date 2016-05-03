Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVSx6ysVzDqF4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:13 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:43:12 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 31058357806D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:10 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435h2b59175136
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:43:10 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435gb7K007543
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 12/26] powerpc/powernv/ioda1: M64 support on P7IOC
Date: Tue,  3 May 2016 15:41:31 +1000
Message-Id: <1462254105-24128-13-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables M64 window on P7IOC, which has been enabled on PHB3.
Different from PHB3 where 16 M64 BARs are supported and each of
them can be owned by one particular PE# exclusively or divided
evenly to 256 segments, every P7IOC PHB has 16 M64 BARs and each
of them are divided to 8 segments. So every P7IOC PHB supports
128 M64 segments in total. P7IOC has M64DT, which helps mapping
one particular M64 segment# to arbitrary PE#. PHB3 doesn't have
M64DT, indicating that one M64 segment can only be pinned to the
fixed PE#.

In order to unified M64 support M64 on P7IOC and PHB3, we just
provide 128 M64 segments on every P7IOC PHB and each of them is
pinned to the fixed PE# by bypassing the function of M64DT. In
turn, we just need different phb->init_m64() for P7IOC and PHB3
and maps M64 segment in pnv_ioda_reserve_m64_pe() for P7IOC, most
of the code are shared by them.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 89 +++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 37f22b0..a1b74ec 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -48,6 +48,9 @@
 #include "powernv.h"
 #include "pci.h"
 
+#define PNV_IODA1_M64_NUM	16	/* Number of M64 BARs	*/
+#define PNV_IODA1_M64_SEGS	8	/* Segments per M64 BAR	*/
+
 /* 256M DMA window, 4K TCE pages, 8 bytes TCE */
 #define TCE32_TABLE_SIZE	((0x10000000 / 0x1000) * 8)
 
@@ -246,6 +249,64 @@ static void pnv_ioda_reserve_dev_m64_pe(struct pci_dev *pdev,
 	}
 }
 
+static int pnv_ioda1_init_m64(struct pnv_phb *phb)
+{
+	struct resource *r;
+	int index;
+
+	/*
+	 * There are 16 M64 BARs, each of which has 8 segments. So
+	 * there are as many M64 segments as the maximum number of
+	 * PEs, which is 128.
+	 */
+	for (index = 0; index < PNV_IODA1_M64_NUM; index++) {
+		unsigned long base, segsz = phb->ioda.m64_segsize;
+		int64_t rc;
+
+		base = phb->ioda.m64_base +
+		       index * PNV_IODA1_M64_SEGS * segsz;
+		rc = opal_pci_set_phb_mem_window(phb->opal_id,
+				OPAL_M64_WINDOW_TYPE, index, base, 0,
+				PNV_IODA1_M64_SEGS * segsz);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("  Error %lld setting M64 PHB#%d-BAR#%d\n",
+				rc, phb->hose->global_number, index);
+			goto fail;
+		}
+
+		rc = opal_pci_phb_mmio_enable(phb->opal_id,
+				OPAL_M64_WINDOW_TYPE, index,
+				OPAL_ENABLE_M64_SPLIT);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("  Error %lld enabling M64 PHB#%d-BAR#%d\n",
+				rc, phb->hose->global_number, index);
+			goto fail;
+		}
+	}
+
+	/*
+	 * Exclude the segment used by the reserved PE, which
+	 * is expected to be 0 or last supported PE#.
+	 */
+	r = &phb->hose->mem_resources[1];
+	if (phb->ioda.reserved_pe_idx == 0)
+		r->start += phb->ioda.m64_segsize;
+	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
+		r->end -= phb->ioda.m64_segsize;
+	else
+		pr_warn("  Cannot cut M64 segment for reserved PE#%d\n",
+			phb->ioda.reserved_pe_idx);
+
+	return 0;
+
+fail:
+	for ( ; index >= 0; index--)
+		opal_pci_phb_mmio_enable(phb->opal_id,
+			OPAL_M64_WINDOW_TYPE, index, OPAL_DISABLE_M64);
+
+	return -EIO;
+}
+
 static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
 				    unsigned long *pe_bitmap,
 				    bool all)
@@ -315,6 +376,26 @@ static unsigned int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 			pe->master = master_pe;
 			list_add_tail(&pe->list, &master_pe->slaves);
 		}
+
+		/*
+		 * P7IOC supports M64DT, which helps mapping M64 segment
+		 * to one particular PE#. However, PHB3 has fixed mapping
+		 * between M64 segment and PE#. In order to have same logic
+		 * for P7IOC and PHB3, we enforce fixed mapping between M64
+		 * segment and PE# on P7IOC.
+		 */
+		if (phb->type == PNV_PHB_IODA1) {
+			int64_t rc;
+
+			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+					pe->pe_number, OPAL_M64_WINDOW_TYPE,
+					pe->pe_number / PNV_IODA1_M64_SEGS,
+					pe->pe_number % PNV_IODA1_M64_SEGS);
+			if (rc != OPAL_SUCCESS)
+				pr_warn("%s: Error %lld mapping M64 for PHB#%d-PE#%d\n",
+					__func__, rc, phb->hose->global_number,
+					pe->pe_number);
+		}
 	}
 
 	kfree(pe_alloc);
@@ -329,8 +410,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	const u32 *r;
 	u64 pci_addr;
 
-	/* FIXME: Support M64 for P7IOC */
-	if (phb->type != PNV_PHB_IODA2) {
+	if (phb->type != PNV_PHB_IODA1 && phb->type != PNV_PHB_IODA2) {
 		pr_info("  Not support M64 window\n");
 		return;
 	}
@@ -364,7 +444,10 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 
 	/* Use last M64 BAR to cover M64 window */
 	phb->ioda.m64_bar_idx = 15;
-	phb->init_m64 = pnv_ioda2_init_m64;
+	if (phb->type == PNV_PHB_IODA1)
+		phb->init_m64 = pnv_ioda1_init_m64;
+	else
+		phb->init_m64 = pnv_ioda2_init_m64;
 	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
 	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
 }
-- 
2.1.0
