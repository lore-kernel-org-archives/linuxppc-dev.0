Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2647C1A0E13
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:45:00 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:44:59 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1AF9A2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:56 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hWgu50462964
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:40 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546h8gJ002918
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:09 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 06/42] powerpc/powernv: Improve IO and M32 mapping
Date: Thu,  4 Jun 2015 16:41:35 +1000
Message-Id: <1433400131-18429-7-git-send-email-gwshan@linux.vnet.ibm.com>
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

The PHB's IO or M32 window is divided evenly to segments, each of
them can be mapped to arbitrary PE# by IODT or M32DT. Current code
figures out the consumed IO and M32 segments by one particular PE
from the windows of the PE's upstream bridge. It won't be reliable
once we extend M64 windows of root port, or the upstream port of
the PCIE switch behind root port to PHB's IO or M32 window, in order
to support PCI hotplug in future.

The patch improves the above situation by calculating PE's consumed
IO or M32 segments from its contained devices, no PCI bridge windows
involved if the PE doesn't contain all the subordinate PCI buses.
Otherwise, the PCI bridge windows still contribute to PE's consumed
IO or M32 segments.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 136 ++++++++++++++++++------------
 1 file changed, 80 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3bb4ce8..46a5e10 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2959,76 +2959,100 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 }
 #endif /* CONFIG_PCI_IOV */
 
-/*
- * This function is supposed to be called on basis of PE from top
- * to bottom style. So the the I/O or MMIO segment assigned to
- * parent PE could be overrided by its child PEs if necessary.
- */
-static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
-				  struct pnv_ioda_pe *pe)
+static int pnv_ioda_map_pe_one_res(struct pci_controller *hose,
+				   struct pnv_ioda_pe *pe,
+				   struct resource *res)
 {
 	struct pnv_phb *phb = hose->private_data;
 	struct pci_bus_region region;
-	struct resource *res;
-	int i, index;
+	int index;
 	unsigned int segsize;
 	unsigned long *segmap, *pe_segmap;
 	uint16_t win;
 	int64_t rc;
 
-	/*
-	 * NOTE: We only care PCI bus based PE for now. For PCI
-	 * device based PE, for example SRIOV sensitive VF should
-	 * be figured out later.
-	 */
-	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
+	/* Check if we need map the resource */
+	if (!res->parent ||
+	    !res->flags ||
+	    res->start > res->end ||
+	    pnv_pci_is_mem_pref_64(res->flags))
+		return 0;
 
-	pci_bus_for_each_resource(pe->pbus, res, i) {
-		if (!res || !res->flags ||
-		    res->start > res->end)
-			continue;
+	if (res->flags & IORESOURCE_IO) {
+		region.start = res->start - phb->ioda.io_pci_base;
+		region.end   = res->end - phb->ioda.io_pci_base;
+		segsize      = phb->ioda.io_segsize;
+		segmap       = phb->ioda.io_segmap;
+		pe_segmap    = pe->io_segmap;
+		win          = OPAL_IO_WINDOW_TYPE;
+	} else if ((res->flags & IORESOURCE_MEM) &&
+		   !pnv_pci_is_mem_pref_64(res->flags)) {
+		region.start = res->start -
+			       hose->mem_offset[0] -
+			       phb->ioda.m32_pci_base;
+		region.end   = res->end -
+			       hose->mem_offset[0] -
+			       phb->ioda.m32_pci_base;
+		segsize      = phb->ioda.m32_segsize;
+		segmap       = phb->ioda.m32_segmap;
+		pe_segmap    = pe->m32_segmap;
+		win          = OPAL_M32_WINDOW_TYPE;
+	} else {
+		return 0;
+	}
 
-		if (res->flags & IORESOURCE_IO) {
-			region.start = res->start - phb->ioda.io_pci_base;
-			region.end   = res->end - phb->ioda.io_pci_base;
-			segsize      = phb->ioda.io_segsize;
-			segmap       = phb->ioda.io_segmap;
-			pe_segmap    = pe->io_segmap;
-			win          = OPAL_IO_WINDOW_TYPE;
-		} else if ((res->flags & IORESOURCE_MEM) &&
-			    !pnv_pci_is_mem_pref_64(res->flags)) {
-			region.start = res->start -
-				       hose->mem_offset[0] -
-				       phb->ioda.m32_pci_base;
-			region.end   = res->end -
-				       hose->mem_offset[0] -
-				       phb->ioda.m32_pci_base;
-			segsize      = phb->ioda.m32_segsize;
-			segmap       = phb->ioda.m32_segmap;
-			pe_segmap    = pe->m32_segmap;
-			win          = OPAL_M32_WINDOW_TYPE;
-		} else {
-			continue;
+	index = region.start / phb->ioda.io_segsize;
+	while (index < phb->ioda.total_pe &&
+	       region.start <= region.end) {
+		set_bit(index, segmap);
+		set_bit(index, pe_segmap);
+
+		rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+				pe->pe_number, win, 0, index);
+		if (rc != OPAL_SUCCESS) {
+			pr_err("%s: Error %lld mapping (%d) seg#%d to PHB#%d-PE#%d\n",
+				__func__, rc, win, index,
+				pe->phb->hose->global_number,
+				pe->pe_number);
+			return -EIO;
 		}
 
-		index = region.start / phb->ioda.io_segsize;
-		while (index < phb->ioda.total_pe &&
-		       region.start <= region.end) {
-			set_bit(index, segmap);
-			set_bit(index, pe_segmap);
+		region.start += segsize;
+		index++;
+	}
 
-			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
-					pe->pe_number, win, 0, index);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("%s: Error %lld mapping (%d) seg#%d to PHB#%d-PE#%d\n",
-					__func__, rc, win, index,
-					pe->phb->hose->global_number,
-					pe->pe_number);
-				break;
-			}
+	return 0;
+}
+
+static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
+				  struct pnv_ioda_pe *pe)
+{
+	struct pci_dev *pdev;
+	struct resource *res;
+	int i;
+
+	/* This function only works for bus dependent PE */
+	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
+
+	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
+		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+			res = &pdev->resource[i];
+			if (pnv_ioda_map_pe_one_res(hose, pe, res))
+				return;
+		}
+
+		/* If the PE contains all subordinate PCI buses, the
+		 * resources of the child bridges should be mapped
+		 * to the PE as well.
+		 */
+		if (!(pe->flags & PNV_IODA_PE_BUS_ALL) ||
+		    (pdev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
+			continue;
 
-			region.start += segsize;
-			index++;
+		for (i = 0; i <= PCI_BRIDGE_RESOURCE_NUM; i++) {
+			res = &pdev->resource[PCI_BRIDGE_RESOURCES + i];
+			if (pnv_ioda_map_pe_one_res(hose, pe, res))
+				return;
 		}
 	}
 }
-- 
2.1.0
