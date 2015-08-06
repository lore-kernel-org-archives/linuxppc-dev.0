Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61C021A1C10
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8BB272CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764D4lo44105862
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764Cbqt001250
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:12:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 06/42] powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
Date: Thu,  6 Aug 2015 14:11:11 +1000
Message-Id: <1438834307-26960-7-git-send-email-gwshan@linux.vnet.ibm.com>
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

The original implementation of pnv_ioda_setup_pe_seg() configures
IO and M32 segments by separate logics, which can be merged by
by caching @seg_bitmap, @seg_size, @win in advance. The patch
shouldn't cause any behavioural changes.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 68 ++++++++++++++-----------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 78b49a1..488a53e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2856,7 +2856,10 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 	struct pci_bus_region region;
 	struct resource *res;
 	int i, index;
-	int rc;
+	unsigned int segsize;
+	unsigned long *segmap, *pe_segmap;
+	uint16_t win;
+	int64_t rc;
 
 	/*
 	 * NOTE: We only care PCI bus based PE for now. For PCI
@@ -2873,25 +2876,10 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 		if (res->flags & IORESOURCE_IO) {
 			region.start = res->start - phb->ioda.io_pci_base;
 			region.end   = res->end - phb->ioda.io_pci_base;
-			index = region.start / phb->ioda.io_segsize;
-
-			while (index < phb->ioda.total_pe &&
-			       region.start <= region.end) {
-				set_bit(index, pe->io_segmap);
-				set_bit(index, phb->ioda.io_segmap);
-				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
-					pe->pe_number, OPAL_IO_WINDOW_TYPE,
-					0, index);
-				if (rc != OPAL_SUCCESS) {
-					pr_err("%s: OPAL error %d when mapping IO "
-					       "segment #%d to PE#%d\n",
-					       __func__, rc, index, pe->pe_number);
-					break;
-				}
-
-				region.start += phb->ioda.io_segsize;
-				index++;
-			}
+			segsize      = phb->ioda.io_segsize;
+			segmap       = phb->ioda.io_segmap;
+			pe_segmap    = pe->io_segmap;
+			win          = OPAL_IO_WINDOW_TYPE;
 		} else if ((res->flags & IORESOURCE_MEM) &&
 			   !pnv_pci_is_mem_pref_64(res->flags)) {
 			region.start = res->start -
@@ -2900,25 +2888,31 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 			region.end   = res->end -
 				       hose->mem_offset[0] -
 				       phb->ioda.m32_pci_base;
-			index = region.start / phb->ioda.m32_segsize;
-
-			while (index < phb->ioda.total_pe &&
-			       region.start <= region.end) {
-				set_bit(index, pe->m32_segmap);
-				set_bit(index, phb->ioda.m32_segmap);
-				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
-					pe->pe_number, OPAL_M32_WINDOW_TYPE,
-					0, index);
-				if (rc != OPAL_SUCCESS) {
-					pr_err("%s: OPAL error %d when mapping M32 "
-					       "segment#%d to PE#%d",
-					       __func__, rc, index, pe->pe_number);
-					break;
-				}
+			segsize      = phb->ioda.m32_segsize;
+			segmap       = phb->ioda.m32_segmap;
+			pe_segmap    = pe->m32_segmap;
+			win          = OPAL_M32_WINDOW_TYPE;
+		} else {
+			continue;
+		}
 
-				region.start += phb->ioda.m32_segsize;
-				index++;
+		index = region.start / phb->ioda.io_segsize;
+		while (index < phb->ioda.total_pe &&
+		       region.start <= region.end) {
+			set_bit(index, segmap);
+			set_bit(index, pe_segmap);
+			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+					pe->pe_number, win, 0, index);
+			if (rc != OPAL_SUCCESS) {
+				pr_warn("%s: Error %lld mapping (%d) seg#%d to PHB#%d-PE#%d\n",
+					__func__, rc, win, index,
+					pe->phb->hose->global_number,
+					pe->pe_number);
+				break;
 			}
+
+			region.start += segsize;
+			index++;
 		}
 	}
 }
-- 
2.1.0
