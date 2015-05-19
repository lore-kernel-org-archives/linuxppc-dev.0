Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B5611A1276
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 11:43:30 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 19 May 2015 11:43:28 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E2AF42CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 11:43:25 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4J1hHLL29294630
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 11:43:26 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4J1grN8006789
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 11:42:53 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Subject: [PATCH V6 10/10] powerpc/powernv: compound PE for VFs
Date: Tue, 19 May 2015 09:35:12 +0800
Message-Id: <1431999312-10517-11-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When VF BAR size is larger than 64MB, we group VFs in terms of M64 BAR,
which means those VFs in a group should form a compound PE.

This patch links those VF PEs into compound PE in this case.

[gwshan: code refactoring for a bit]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   46 +++++++++++++++++++++++++----
 arch/powerpc/platforms/powernv/pci.c      |   17 +++++++++--
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f8bc950..56e7b65 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1363,9 +1363,20 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 	}
 
 	list_for_each_entry_safe(pe, pe_n, &phb->ioda.pe_list, list) {
+		struct pnv_ioda_pe *s, *sn;
 		if (pe->parent_dev != pdev)
 			continue;
 
+		if ((pe->flags & PNV_IODA_PE_MASTER) &&
+		    (pe->flags & PNV_IODA_PE_VF)) {
+			list_for_each_entry_safe(s, sn, &pe->slaves, list) {
+				pnv_pci_ioda2_release_dma_pe(pdev, s);
+				list_del(&s->list);
+				pnv_ioda_deconfigure_pe(phb, s);
+				pnv_ioda_free_pe(phb, s->pe_number);
+			}
+		}
+
 		pnv_pci_ioda2_release_dma_pe(pdev, pe);
 
 		/* Remove from list */
@@ -1418,7 +1429,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 	struct pci_bus        *bus;
 	struct pci_controller *hose;
 	struct pnv_phb        *phb;
-	struct pnv_ioda_pe    *pe;
+	struct pnv_ioda_pe    *pe, *master_pe;
 	int                    pe_num;
 	u16                    vf_index;
 	struct pci_dn         *pdn;
@@ -1464,10 +1475,13 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 				GFP_KERNEL, hose->node);
 		pe->tce32_table->data = pe;
 
-		/* Put PE to the list */
-		mutex_lock(&phb->ioda.pe_list_mutex);
-		list_add_tail(&pe->list, &phb->ioda.pe_list);
-		mutex_unlock(&phb->ioda.pe_list_mutex);
+		/* Put PE to the list, or postpone it for compound PEs */
+		if ((pdn->m64_per_iov != M64_PER_IOV) ||
+		    (num_vfs <= M64_PER_IOV)) {
+			mutex_lock(&phb->ioda.pe_list_mutex);
+			list_add_tail(&pe->list, &phb->ioda.pe_list);
+			mutex_unlock(&phb->ioda.pe_list_mutex);
+		}
 
 		pnv_pci_ioda2_setup_dma_pe(phb, pe);
 	}
@@ -1480,10 +1494,32 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 		vf_per_group = roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
 
 		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++) {
+			master_pe = NULL;
+
 			for (vf_index = vf_group * vf_per_group;
 			     vf_index < (vf_group + 1) * vf_per_group &&
 			     vf_index < num_vfs;
 			     vf_index++) {
+
+				/*
+				 * Figure out the master PE and put all slave
+				 * PEs to master PE's list.
+				 */
+				pe = &phb->ioda.pe_array[pdn->offset + vf_index];
+				if (!master_pe) {
+					pe->flags |= PNV_IODA_PE_MASTER;
+					INIT_LIST_HEAD(&pe->slaves);
+					master_pe = pe;
+					mutex_lock(&phb->ioda.pe_list_mutex);
+					list_add_tail(&pe->list, &phb->ioda.pe_list);
+					mutex_unlock(&phb->ioda.pe_list_mutex);
+				} else {
+					pe->flags |= PNV_IODA_PE_SLAVE;
+					pe->master = master_pe;
+					list_add_tail(&pe->list,
+						&master_pe->slaves);
+				}
+
 				for (vf_index1 = vf_group * vf_per_group;
 				     vf_index1 < (vf_group + 1) * vf_per_group &&
 				     vf_index1 < num_vfs;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 10bc8c3..717a58e 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -667,7 +667,7 @@ static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
 #ifdef CONFIG_PCI_IOV
-	struct pnv_ioda_pe *pe;
+	struct pnv_ioda_pe *pe, *slave;
 	struct pci_dn *pdn;
 
 	/* Fix the VF pdn PE number */
@@ -679,10 +679,23 @@ static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 			    (pdev->devfn & 0xff))) {
 				pdn->pe_number = pe->pe_number;
 				pe->pdev = pdev;
-				break;
+				goto found;
+			}
+
+			if ((pe->flags & PNV_IODA_PE_MASTER) &&
+			    (pe->flags & PNV_IODA_PE_VF)) {
+				list_for_each_entry(slave, &pe->slaves, list) {
+					if (slave->rid == ((pdev->bus->number << 8)
+					   | (pdev->devfn & 0xff))) {
+						pdn->pe_number = slave->pe_number;
+						slave->pdev = pdev;
+						goto found;
+					}
+				}
 			}
 		}
 	}
+found:
 #endif /* CONFIG_PCI_IOV */
 
 	if (phb && phb->dma_dev_setup)
-- 
1.7.9.5
