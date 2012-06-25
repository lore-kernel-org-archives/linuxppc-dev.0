Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CACBA1008C2
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2012 01:53:17 +1000 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 25 Jun 2012 11:53:14 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 4265F6E8068
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 11:44:26 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5PFiPZU172064
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 11:44:26 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5PFhSnd030656
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 09:43:29 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8] ppc/pnv: I/O and MMIO resource assignment for PEs
Date: Mon, 25 Jun 2012 23:43:16 +0800
Message-Id: <1340639001-28152-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340639001-28152-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340639001-28152-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There're 2 types of PCI bus sensitive PEs: (A) The PE includes
single PCI bus. (B) The PE includes the PCI bus and all the subordinate
PCI buses, and the patch tries to assign I/O and MMIO resources
based on created PEs. Fortunately, we figured out unified scheme
to do resource assignment for all types of PCI bus based PEs according
to Ben's idea:

	- Resource assignment based on PE from top to bottom.
	- The soureces, either I/O or MMIO, of the PE are figured out
	  from the assigned PCI bus.
	- The occupied resource by parent PE could possibilly be overrided
	  by children PEs.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   89 +++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6a7672e..1071820 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1155,9 +1155,98 @@ static void __devinit pnv_pci_ioda_fixup_phb(struct pci_controller *hose)
 	}
 }
 
+/*
+ * This function is supposed to be called on basis of PE from top
+ * to bottom style. So the the I/O or MMIO segment assigned to
+ * parent PE could be overrided by its child PEs if necessary.
+ */
+static void __devinit pnv_ioda_setup_pe_seg(struct pci_controller *hose,
+                                struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_bus_region region;
+	struct resource *res;
+	int i, index;
+	int rc;
+
+	/*
+	 * NOTE: We only care PCI bus based PE for now. For PCI
+	 * device based PE, for example SRIOV sensitive VF should
+	 * be figured out later.
+	 */
+	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
+
+	pci_bus_for_each_resource(pe->pbus, res, i) {
+		if (!res || !res->flags ||
+		    res->start > res->end)
+			continue;
+
+		if (res->flags & IORESOURCE_IO) {
+			region.start = res->start - phb->ioda.io_pci_base;
+			region.end   = res->end - phb->ioda.io_pci_base;
+			index = region.start / phb->ioda.io_segsize;
+
+			while (index < phb->ioda.total_pe &&
+			       region.start <= region.end) {
+				phb->ioda.io_segmap[index] = pe->pe_number;
+				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+					pe->pe_number, OPAL_IO_WINDOW_TYPE, 0, index);
+				if (rc != OPAL_SUCCESS) {
+					pr_err("%s: OPAL error %d when mapping IO "
+					       "segment #%d to PE#%d\n",
+						__func__, rc, index, pe->pe_number);
+					break;
+				}
+
+				region.start += phb->ioda.io_segsize;
+				index++;
+			}
+		} else if (res->flags & IORESOURCE_MEM) {
+			region.start = res->start -
+				       hose->pci_mem_offset -
+				       phb->ioda.m32_pci_base;
+			region.end   = res->end -
+				       hose->pci_mem_offset -
+				       phb->ioda.m32_pci_base;
+			index = region.start / phb->ioda.m32_segsize;
+
+			while (index < phb->ioda.total_pe &&
+			       region.start <= region.end) {
+				phb->ioda.m32_segmap[index] = pe->pe_number;
+				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+					pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
+				if (rc != OPAL_SUCCESS) {
+					pr_err("%s: OPAL error %d when mapping M32 "
+					       "segment#%d to PE#%d",
+					       __func__, rc, index, pe->pe_number);
+					break;
+				}
+
+				region.start += phb->ioda.m32_segsize;
+				index++;
+			}
+		}
+	}
+}
+
+static void __devinit pnv_pci_ioda_setup_seg(void)
+{
+	struct pci_controller *tmp, *hose;
+	struct pnv_phb *phb;
+	struct pnv_ioda_pe *pe;
+
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		phb = hose->private_data;
+		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
+			pnv_ioda_setup_pe_seg(hose, pe);
+		}
+	}
+}
+
 static void __devinit pnv_pci_ioda_fixup(void)
 {
 	pnv_pci_ioda_setup_PEs();
+	pnv_pci_ioda_setup_seg();
 }
 
 /* Prevent enabling devices for which we couldn't properly
-- 
1.7.9.5
