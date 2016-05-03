Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVSy1nwgzDqHF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:14 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:43:13 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5D6813578060
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:09 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435h1bY19529956
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:43:09 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435gamE007486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 08/26] powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
Date: Tue,  3 May 2016 15:41:27 +1000
Message-Id: <1462254105-24128-9-git-send-email-gwshan@linux.vnet.ibm.com>
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

pnv_ioda_setup_pe_seg() associates the IO and M32 segments with the
owner PE. The code mapping segments should be fixed and immune from
logic changes introduced to pnv_ioda_setup_pe_seg().

This moves the code mapping segments to helper pnv_ioda_setup_pe_res().
The data type for @rc is changed to "int64_t". Also, argument @hose is
removed from pnv_ioda_setup_pe() as it can be got from @pe. No functional
changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 121 +++++++++++++++---------------
 1 file changed, 62 insertions(+), 59 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 59b20e5..b954fbc 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2929,19 +2929,72 @@ truncate_iov:
 }
 #endif /* CONFIG_PCI_IOV */
 
+static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
+				  struct resource *res)
+{
+	struct pnv_phb *phb = pe->phb;
+	struct pci_bus_region region;
+	int index;
+	int64_t rc;
+
+	if (!res || !res->flags || res->start > res->end)
+		return;
+
+	if (res->flags & IORESOURCE_IO) {
+		region.start = res->start - phb->ioda.io_pci_base;
+		region.end   = res->end - phb->ioda.io_pci_base;
+		index = region.start / phb->ioda.io_segsize;
+
+		while (index < phb->ioda.total_pe_num &&
+		       region.start <= region.end) {
+			phb->ioda.io_segmap[index] = pe->pe_number;
+			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+				pe->pe_number, OPAL_IO_WINDOW_TYPE, 0, index);
+			if (rc != OPAL_SUCCESS) {
+				pr_err("%s: Error %lld mapping IO segment#%d to PE#%d\n",
+				       __func__, rc, index, pe->pe_number);
+				break;
+			}
+
+			region.start += phb->ioda.io_segsize;
+			index++;
+		}
+	} else if ((res->flags & IORESOURCE_MEM) &&
+		   !pnv_pci_is_mem_pref_64(res->flags)) {
+		region.start = res->start -
+			       phb->hose->mem_offset[0] -
+			       phb->ioda.m32_pci_base;
+		region.end   = res->end -
+			       phb->hose->mem_offset[0] -
+			       phb->ioda.m32_pci_base;
+		index = region.start / phb->ioda.m32_segsize;
+
+		while (index < phb->ioda.total_pe_num &&
+		       region.start <= region.end) {
+			phb->ioda.m32_segmap[index] = pe->pe_number;
+			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+				pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
+			if (rc != OPAL_SUCCESS) {
+				pr_err("%s: Error %lld mapping M32 segment#%d to PE#%d",
+				       __func__, rc, index, pe->pe_number);
+				break;
+			}
+
+			region.start += phb->ioda.m32_segsize;
+			index++;
+		}
+	}
+}
+
 /*
  * This function is supposed to be called on basis of PE from top
  * to bottom style. So the the I/O or MMIO segment assigned to
  * parent PE could be overrided by its child PEs if necessary.
  */
-static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
-				  struct pnv_ioda_pe *pe)
+static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
 {
-	struct pnv_phb *phb = hose->private_data;
-	struct pci_bus_region region;
 	struct resource *res;
-	int i, index;
-	int rc;
+	int i;
 
 	/*
 	 * NOTE: We only care PCI bus based PE for now. For PCI
@@ -2950,58 +3003,8 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 	 */
 	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
 
-	pci_bus_for_each_resource(pe->pbus, res, i) {
-		if (!res || !res->flags ||
-		    res->start > res->end)
-			continue;
-
-		if (res->flags & IORESOURCE_IO) {
-			region.start = res->start - phb->ioda.io_pci_base;
-			region.end   = res->end - phb->ioda.io_pci_base;
-			index = region.start / phb->ioda.io_segsize;
-
-			while (index < phb->ioda.total_pe_num &&
-			       region.start <= region.end) {
-				phb->ioda.io_segmap[index] = pe->pe_number;
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
-		} else if ((res->flags & IORESOURCE_MEM) &&
-			   !pnv_pci_is_mem_pref_64(res->flags)) {
-			region.start = res->start -
-				       hose->mem_offset[0] -
-				       phb->ioda.m32_pci_base;
-			region.end   = res->end -
-				       hose->mem_offset[0] -
-				       phb->ioda.m32_pci_base;
-			index = region.start / phb->ioda.m32_segsize;
-
-			while (index < phb->ioda.total_pe_num &&
-			       region.start <= region.end) {
-				phb->ioda.m32_segmap[index] = pe->pe_number;
-				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
-					pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
-				if (rc != OPAL_SUCCESS) {
-					pr_err("%s: OPAL error %d when mapping M32 "
-					       "segment#%d to PE#%d",
-					       __func__, rc, index, pe->pe_number);
-					break;
-				}
-
-				region.start += phb->ioda.m32_segsize;
-				index++;
-			}
-		}
-	}
+	pci_bus_for_each_resource(pe->pbus, res, i)
+		pnv_ioda_setup_pe_res(pe, res);
 }
 
 static void pnv_pci_ioda_setup_seg(void)
@@ -3018,7 +3021,7 @@ static void pnv_pci_ioda_setup_seg(void)
 			continue;
 
 		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
-			pnv_ioda_setup_pe_seg(hose, pe);
+			pnv_ioda_setup_pe_seg(pe);
 		}
 	}
 }
-- 
2.1.0
