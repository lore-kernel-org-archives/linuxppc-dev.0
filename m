Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD4901A0D59
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:53 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:44:53 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8C8682BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:50 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hRFl4850108
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546h19x005337
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:02 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 05/42] powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
Date: Thu,  4 Jun 2015 16:41:34 +1000
Message-Id: <1433400131-18429-6-git-send-email-gwshan@linux.vnet.ibm.com>
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

The original implementation of pnv_ioda_setup_pe_seg() configures
IO and M32 segments by separate logics, which can be merged by
by caching @seg_bitmap, @seg_size, @win in advance. The patch
shouldn't cause any behavioural changes.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from PATCH[v4 04/21]
  * Fixed coding style complained by checkpatch.pl
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 67 +++++++++++++++----------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 53d0efd..3bb4ce8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2971,7 +2971,10 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
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
@@ -2988,50 +2991,44 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 		if (res->flags & IORESOURCE_IO) {
 			region.start = res->start - phb->ioda.io_pci_base;
 			region.end   = res->end - phb->ioda.io_pci_base;
-			index = region.start / phb->ioda.io_segsize;
-
-			while (index < phb->ioda.total_pe &&
-			       region.start <= region.end) {
-				set_bit(index, phb->ioda.io_segmap);
-				set_bit(index, pe->io_segmap);
-				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
-					pe->pe_number, OPAL_IO_WINDOW_TYPE, 0, index);
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
-			   !pnv_pci_is_mem_pref_64(res->flags)) {
+			    !pnv_pci_is_mem_pref_64(res->flags)) {
 			region.start = res->start -
 				       hose->mem_offset[0] -
 				       phb->ioda.m32_pci_base;
 			region.end   = res->end -
 				       hose->mem_offset[0] -
 				       phb->ioda.m32_pci_base;
-			index = region.start / phb->ioda.m32_segsize;
+			segsize      = phb->ioda.m32_segsize;
+			segmap       = phb->ioda.m32_segmap;
+			pe_segmap    = pe->m32_segmap;
+			win          = OPAL_M32_WINDOW_TYPE;
+		} else {
+			continue;
+		}
 
-			while (index < phb->ioda.total_pe &&
-			       region.start <= region.end) {
-				set_bit(index, phb->ioda.m32_segmap);
-				set_bit(index, pe->m32_segmap);
-				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
-					pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
-				if (rc != OPAL_SUCCESS) {
-					pr_err("%s: OPAL error %d when mapping M32 "
-					       "segment#%d to PE#%d",
-					       __func__, rc, index, pe->pe_number);
-					break;
-				}
+		index = region.start / phb->ioda.io_segsize;
+		while (index < phb->ioda.total_pe &&
+		       region.start <= region.end) {
+			set_bit(index, segmap);
+			set_bit(index, pe_segmap);
 
-				region.start += phb->ioda.m32_segsize;
-				index++;
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
