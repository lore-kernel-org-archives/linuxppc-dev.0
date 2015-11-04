Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04AA21A0CB4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:56 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:13:55 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E17BD2BB005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDjet16384214
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDKwq009878
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:21 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 10/50] powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
Date: Thu,  5 Nov 2015 00:12:10 +1100
Message-Id: <1446642770-4681-11-git-send-email-gwshan@linux.vnet.ibm.com>
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

The original implementation of pnv_ioda_setup_pe_seg() configures
IO and M32 segments by separate logics, which can be merged by
by caching @segmap, @seg_size, @win in advance. This shouldn't
cause any behavioural changes.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 62 ++++++++++++++-----------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7ee7cfe..553d3f3 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2752,8 +2752,10 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 	struct pnv_phb *phb = hose->private_data;
 	struct pci_bus_region region;
 	struct resource *res;
-	int i, index;
-	int rc;
+	unsigned int segsize;
+	int *segmap, index, i;
+	uint16_t win;
+	int64_t rc;
 
 	/*
 	 * NOTE: We only care PCI bus based PE for now. For PCI
@@ -2770,23 +2772,9 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 		if (res->flags & IORESOURCE_IO) {
 			region.start = res->start - phb->ioda.io_pci_base;
 			region.end   = res->end - phb->ioda.io_pci_base;
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
+			segsize      = phb->ioda.io_segsize;
+			segmap       = phb->ioda.io_segmap;
+			win          = OPAL_IO_WINDOW_TYPE;
 		} else if ((res->flags & IORESOURCE_MEM) &&
 			   !pnv_pci_is_mem_pref_64(res->flags)) {
 			region.start = res->start -
@@ -2795,23 +2783,29 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 			region.end   = res->end -
 				       hose->mem_offset[0] -
 				       phb->ioda.m32_pci_base;
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
+			segsize      = phb->ioda.m32_segsize;
+			segmap       = phb->ioda.m32_segmap;
+			win          = OPAL_M32_WINDOW_TYPE;
+		} else {
+			continue;
+		}
 
-				region.start += phb->ioda.m32_segsize;
-				index++;
+		index = region.start / segsize;
+		while (index < phb->ioda.total_pe_num &&
+		       region.start <= region.end) {
+			segmap[index] = pe->pe_number;
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
