Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77A441A0CAF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:56 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:13:56 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 582E83578055
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:54 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDkik16449688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:54 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDKT3019070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:22 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 11/50] powerpc/powernv: IO and M32 mapping based on PCI
 device resources
Date: Thu,  5 Nov 2015 00:12:11 +1100
Message-Id: <1446642770-4681-12-git-send-email-gwshan@linux.vnet.ibm.com>
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

Currently, the IO and M32 segments are mapped to the corresponding
PE based on the windows of the parent bridge of PE's primary bus.
It's not going to work when the windows of root port or upstream
port of the PCIe switch behind root port are extended to PHB's
aperatuses in order to support hotplug in subsequent patch.

This fixes the issue by mapping IO and M32 segments based on the
resources of the PCI devices included in the PE, instead of the
windows of the parent bridge of the PE's primary bus.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 131 +++++++++++++++++-------------
 1 file changed, 75 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 553d3f3..4ab93f8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2741,71 +2741,90 @@ truncate_iov:
 }
 #endif /* CONFIG_PCI_IOV */
 
-/*
- * This function is supposed to be called on basis of PE from top
- * to bottom style. So the the I/O or MMIO segment assigned to
- * parent PE could be overrided by its child PEs if necessary.
- */
-static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
-				  struct pnv_ioda_pe *pe)
+static int pnv_ioda_setup_one_res(struct pnv_ioda_pe *pe,
+				  struct resource *res)
 {
-	struct pnv_phb *phb = hose->private_data;
+	struct pnv_phb *phb = pe->phb;
 	struct pci_bus_region region;
-	struct resource *res;
-	unsigned int segsize;
-	int *segmap, index, i;
+	unsigned int index, segsize;
+	int *segmap;
 	uint16_t win;
 	int64_t rc;
 
-	/*
-	 * NOTE: We only care PCI bus based PE for now. For PCI
-	 * device based PE, for example SRIOV sensitive VF should
-	 * be figured out later.
-	 */
-	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
+	if (!res->parent || !res->flags || res->start > res->end)
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
+		win          = OPAL_IO_WINDOW_TYPE;
+	} else if ((res->flags & IORESOURCE_MEM) &&
+		   !pnv_pci_is_mem_pref_64(res->flags)) {
+		region.start = res->start -
+			       phb->hose->mem_offset[0] -
+			       phb->ioda.m32_pci_base;
+		region.end   = res->end -
+			       phb->hose->mem_offset[0] -
+			       phb->ioda.m32_pci_base;
+		segsize      = phb->ioda.m32_segsize;
+		segmap       = phb->ioda.m32_segmap;
+		win          = OPAL_M32_WINDOW_TYPE;
+	} else {
+		return 0;
+	}
 
-		if (res->flags & IORESOURCE_IO) {
-			region.start = res->start - phb->ioda.io_pci_base;
-			region.end   = res->end - phb->ioda.io_pci_base;
-			segsize      = phb->ioda.io_segsize;
-			segmap       = phb->ioda.io_segmap;
-			win          = OPAL_IO_WINDOW_TYPE;
-		} else if ((res->flags & IORESOURCE_MEM) &&
-			   !pnv_pci_is_mem_pref_64(res->flags)) {
-			region.start = res->start -
-				       hose->mem_offset[0] -
-				       phb->ioda.m32_pci_base;
-			region.end   = res->end -
-				       hose->mem_offset[0] -
-				       phb->ioda.m32_pci_base;
-			segsize      = phb->ioda.m32_segsize;
-			segmap       = phb->ioda.m32_segmap;
-			win          = OPAL_M32_WINDOW_TYPE;
-		} else {
-			continue;
+	region.start = _ALIGN_DOWN(region.start, segsize);
+	region.end   = _ALIGN_UP(region.end, segsize);
+	index = region.start / segsize;
+	while (index < phb->ioda.total_pe_num && region.start < region.end) {
+		rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+				pe->pe_number, win, 0, index);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Error %lld mapping (%d) seg#%d to PHB#%d-PE#%d\n",
+				__func__, rc, win, index,
+				phb->hose->global_number,
+				pe->pe_number);
+			return -EIO;
 		}
 
-		index = region.start / segsize;
-		while (index < phb->ioda.total_pe_num &&
-		       region.start <= region.end) {
-			segmap[index] = pe->pe_number;
-			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
-					pe->pe_number, win, 0, index);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("%s: Error %lld mapping (%d) seg#%d to PHB#%d-PE#%d\n",
-					__func__, rc, win, index,
-					pe->phb->hose->global_number,
-					pe->pe_number);
-				break;
-			}
+		segmap[index] = pe->pe_number;
+		region.start += segsize;
+		index++;
+	}
+
+	return 0;
+}
+
+static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
+{
+	struct pci_dev *pdev;
+	struct resource *res;
+	int i;
+
+	/* This function only works for bus dependent PE */
+	WARN_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
+
+	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
+		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+			res = &pdev->resource[i];
+			if (pnv_ioda_setup_one_res(pe, res))
+				return;
+		}
+
+		/*
+		 * If the PE contains all subordinate PCI buses, the
+		 * windows of the child bridges should be mapped to
+		 * the PE as well.
+		 */
+		if (!(pe->flags & PNV_IODA_PE_BUS_ALL && pci_is_bridge(pdev)))
+			continue;
 
-			region.start += segsize;
-			index++;
+		for (i = 0; i <= PCI_BRIDGE_RESOURCE_NUM; i++) {
+			res = &pdev->resource[PCI_BRIDGE_RESOURCES + i];
+			if (pnv_ioda_setup_one_res(pe, res))
+				return;
 		}
 	}
 }
@@ -2819,7 +2838,7 @@ static void pnv_pci_ioda_setup_seg(void)
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		phb = hose->private_data;
 		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
-			pnv_ioda_setup_pe_seg(hose, pe);
+			pnv_ioda_setup_pe_seg(pe);
 		}
 	}
 }
-- 
2.1.0
