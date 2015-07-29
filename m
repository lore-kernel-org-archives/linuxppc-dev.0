Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F7731A04C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 13:17:30 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 08:47:26 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 95AC5394004E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 08:47:22 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T3HLo850856034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 08:47:22 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T3HLlD024584
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 08:47:21 +0530
Date: Wed, 29 Jul 2015 11:17:18 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V9 11/11] powerpc/powernv: compound PE for VFs
Message-ID: <20150729031718.GA18069@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1437112961-17275-12-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437112961-17275-12-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Michael

Hope you didn't take this yet. We may change this patch a little.

On Fri, Jul 17, 2015 at 02:02:41PM +0800, Wei Yang wrote:
>When VF BAR size is larger than 64MB, we group VFs in terms of M64 BAR,
>which means those VFs in a group should form a compound PE.
>
>This patch links those VF PEs into compound PE in this case.
>
>[gwshan: code refactoring for a bit]
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>---
> arch/powerpc/platforms/powernv/pci-ioda.c |   46 +++++++++++++++++++++++++----
> arch/powerpc/platforms/powernv/pci.c      |   17 +++++++++--
> 2 files changed, 56 insertions(+), 7 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 5738d31..d1530cb 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -1359,9 +1359,20 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
> 	}
>
> 	list_for_each_entry_safe(pe, pe_n, &phb->ioda.pe_list, list) {
>+		struct pnv_ioda_pe *s, *sn;
> 		if (pe->parent_dev != pdev)
> 			continue;
>
>+		if ((pe->flags & PNV_IODA_PE_MASTER) &&
>+		    (pe->flags & PNV_IODA_PE_VF)) {
>+			list_for_each_entry_safe(s, sn, &pe->slaves, list) {
>+				pnv_pci_ioda2_release_dma_pe(pdev, s);
>+				list_del(&s->list);
>+				pnv_ioda_deconfigure_pe(phb, s);
>+				pnv_ioda_free_pe(phb, s->pe_number);
>+			}
>+		}
>+
> 		pnv_pci_ioda2_release_dma_pe(pdev, pe);
>
> 		/* Remove from list */
>@@ -1414,7 +1425,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
> 	struct pci_bus        *bus;
> 	struct pci_controller *hose;
> 	struct pnv_phb        *phb;
>-	struct pnv_ioda_pe    *pe;
>+	struct pnv_ioda_pe    *pe, *master_pe;
> 	int                    pe_num;
> 	u16                    vf_index;
> 	struct pci_dn         *pdn;
>@@ -1456,10 +1467,13 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
> 			continue;
> 		}
>
>-		/* Put PE to the list */
>-		mutex_lock(&phb->ioda.pe_list_mutex);
>-		list_add_tail(&pe->list, &phb->ioda.pe_list);
>-		mutex_unlock(&phb->ioda.pe_list_mutex);
>+		/* Put PE to the list, or postpone it for compound PEs */
>+		if ((pdn->m64_per_iov != M64_PER_IOV) ||
>+		    (num_vfs <= M64_PER_IOV)) {
>+			mutex_lock(&phb->ioda.pe_list_mutex);
>+			list_add_tail(&pe->list, &phb->ioda.pe_list);
>+			mutex_unlock(&phb->ioda.pe_list_mutex);
>+		}
>
> 		pnv_pci_ioda2_setup_dma_pe(phb, pe);
> 	}
>@@ -1472,10 +1486,32 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
> 		vf_per_group = roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
>
> 		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++) {
>+			master_pe = NULL;
>+
> 			for (vf_index = vf_group * vf_per_group;
> 			     vf_index < (vf_group + 1) * vf_per_group &&
> 			     vf_index < num_vfs;
> 			     vf_index++) {
>+
>+				/*
>+				 * Figure out the master PE and put all slave
>+				 * PEs to master PE's list.
>+				 */
>+				pe = &phb->ioda.pe_array[pdn->offset + vf_index];
>+				if (!master_pe) {
>+					pe->flags |= PNV_IODA_PE_MASTER;
>+					INIT_LIST_HEAD(&pe->slaves);
>+					master_pe = pe;
>+					mutex_lock(&phb->ioda.pe_list_mutex);
>+					list_add_tail(&pe->list, &phb->ioda.pe_list);
>+					mutex_unlock(&phb->ioda.pe_list_mutex);
>+				} else {
>+					pe->flags |= PNV_IODA_PE_SLAVE;
>+					pe->master = master_pe;
>+					list_add_tail(&pe->list,
>+						&master_pe->slaves);
>+				}
>+
> 				for (vf_index1 = vf_group * vf_per_group;
> 				     vf_index1 < (vf_group + 1) * vf_per_group &&
> 				     vf_index1 < num_vfs;
>diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>index 0e4f42e..f3aead0 100644
>--- a/arch/powerpc/platforms/powernv/pci.c
>+++ b/arch/powerpc/platforms/powernv/pci.c
>@@ -739,7 +739,7 @@ void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
> 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> 	struct pnv_phb *phb = hose->private_data;
> #ifdef CONFIG_PCI_IOV
>-	struct pnv_ioda_pe *pe;
>+	struct pnv_ioda_pe *pe, *slave;
> 	struct pci_dn *pdn;
>
> 	/* Fix the VF pdn PE number */
>@@ -751,10 +751,23 @@ void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
> 			    (pdev->devfn & 0xff))) {
> 				pdn->pe_number = pe->pe_number;
> 				pe->pdev = pdev;
>-				break;
>+				goto found;
>+			}
>+
>+			if ((pe->flags & PNV_IODA_PE_MASTER) &&
>+			    (pe->flags & PNV_IODA_PE_VF)) {
>+				list_for_each_entry(slave, &pe->slaves, list) {
>+					if (slave->rid == ((pdev->bus->number << 8)
>+					   | (pdev->devfn & 0xff))) {
>+						pdn->pe_number = slave->pe_number;
>+						slave->pdev = pdev;
>+						goto found;
>+					}
>+				}
> 			}
> 		}
> 	}
>+found:
> #endif /* CONFIG_PCI_IOV */
>
> 	if (phb && phb->dma_dev_setup)
>-- 
>1.7.9.5

-- 
Richard Yang
Help you, Help me
