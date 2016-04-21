Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqzwb2gzLzDqb5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 10:22:39 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 21 Apr 2016 10:22:38 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 568612CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 10:22:35 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3L0MQ0C5571028
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 10:22:35 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3L0M2Px031675
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 10:22:02 +1000
Date: Thu, 21 Apr 2016 10:21:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel 2/2] powerpc/powernv/ioda2: Delay PE disposal
Message-ID: <20160421002107.GB8367@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1460097404-35422-1-git-send-email-aik@ozlabs.ru>
 <1460097404-35422-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460097404-35422-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 08, 2016 at 04:36:44PM +1000, Alexey Kardashevskiy wrote:
>When SRIOV is disabled, the existing code presumes there is no
>virtual function (VF) in use and destroys all associated PEs.
>However it is possible to get into the situation when the user
>activated SRIOV disabling while a VF is still in use via VFIO.
>For example, unbinding a physical function (PF) while there is a guest
>running with a VF passed throuhgh via VFIO will trigger the bug.
>
>This defines an IODA2-specific IOMMU group release() callback.
>This moves all the disposal code from pnv_ioda_release_vf_PE() to this
>new callback so the cleanup happens when the last user of an IOMMU
>group released the reference.
>
>As pnv_pci_ioda2_release_dma_pe() was reduced to just calling
>iommu_group_put(), this merges pnv_pci_ioda2_release_dma_pe()
>into pnv_ioda_release_vf_PE().
>

Sorry, I don't understand how it works. When PF's driver disables
IOV capability, the VF cannnot work. The guest is unlikely to know
that and still continue accessing the VF's resources (e.g. config
space and MMIO registers). It would cause EEH errors.

>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 33 +++++++++++++------------------
> 1 file changed, 14 insertions(+), 19 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index ce9f2bf..8108c54 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -1333,27 +1333,25 @@ static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
> static void pnv_pci_ioda2_group_release(void *iommu_data)
> {
> 	struct iommu_table_group *table_group = iommu_data;
>+	struct pnv_ioda_pe *pe = container_of(table_group,
>+			struct pnv_ioda_pe, table_group);
>+	struct pci_controller *hose = pci_bus_to_host(pe->parent_dev->bus);

pe->parent_dev would be NULL for non-VF-PEs and it's protected by CONFIG_PCI_IOV
in pci.h.

>+	struct pnv_phb *phb = hose->private_data;
>+	struct iommu_table *tbl = pe->table_group.tables[0];
>+	int64_t rc;
>
>-	table_group->group = NULL;
>-}
>-
>-static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe *pe)
>-{
>-	struct iommu_table    *tbl;
>-	int64_t               rc;
>-
>-	tbl = pe->table_group.tables[0];
> 	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
> 	if (rc)
> 		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
>
> 	pnv_pci_ioda2_set_bypass(pe, false);
>-	if (pe->table_group.group) {
>-		iommu_group_put(pe->table_group.group);
>-		BUG_ON(pe->table_group.group);
>-	}
>+
>+	BUG_ON(!tbl);
> 	pnv_pci_ioda2_table_free_pages(tbl);
>-	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>+	iommu_free_table(tbl, of_node_full_name(pe->parent_dev->dev.of_node));
>+
>+	pnv_ioda_deconfigure_pe(phb, pe);
>+	pnv_ioda_free_pe(phb, pe->pe_number);
> }

It's not correct enough. One PE is comprised of DMA, MMIO, mapping info etc.
This function disposes all of them when DMA finishes its job. I don't figure
out a better way to represent all of them and their relationship. I guess it's
worthy to have something in long term though it's not trival work.

>
> static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
>@@ -1376,16 +1374,13 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
> 		if (pe->parent_dev != pdev)
> 			continue;
>
>-		pnv_pci_ioda2_release_dma_pe(pdev, pe);
>-
> 		/* Remove from list */
> 		mutex_lock(&phb->ioda.pe_list_mutex);
> 		list_del(&pe->list);
> 		mutex_unlock(&phb->ioda.pe_list_mutex);
>
>-		pnv_ioda_deconfigure_pe(phb, pe);
>-
>-		pnv_ioda_free_pe(phb, pe->pe_number);
>+		if (pe->table_group.group)
>+			iommu_group_put(pe->table_group.group);
> 	}
> }
>
>-- 
>2.5.0.rc3
>
