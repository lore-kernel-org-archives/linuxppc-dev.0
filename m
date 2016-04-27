Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvhgQ1b1WzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:09:06 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 11:09:04 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 12B54357805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:08:46 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3R18XhO47906970
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:08:45 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3R188fQ000644
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 11:08:08 +1000
Date: Wed, 27 Apr 2016 11:07:42 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 2/2] powerpc/powernv/ioda2: Delay PE disposal
Message-ID: <20160427010742.GA23726@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1460097404-35422-1-git-send-email-aik@ozlabs.ru>
 <1460097404-35422-3-git-send-email-aik@ozlabs.ru>
 <20160421002107.GB8367@gwshan> <571846E9.80800@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <571846E9.80800@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 21, 2016 at 01:20:09PM +1000, Alexey Kardashevskiy wrote:
>On 04/21/2016 10:21 AM, Gavin Shan wrote:
>>On Fri, Apr 08, 2016 at 04:36:44PM +1000, Alexey Kardashevskiy wrote:
>>>When SRIOV is disabled, the existing code presumes there is no
>>>virtual function (VF) in use and destroys all associated PEs.
>>>However it is possible to get into the situation when the user
>>>activated SRIOV disabling while a VF is still in use via VFIO.
>>>For example, unbinding a physical function (PF) while there is a guest
>>>running with a VF passed throuhgh via VFIO will trigger the bug.
>>>
>>>This defines an IODA2-specific IOMMU group release() callback.
>>>This moves all the disposal code from pnv_ioda_release_vf_PE() to this
>>>new callback so the cleanup happens when the last user of an IOMMU
>>>group released the reference.
>>>
>>>As pnv_pci_ioda2_release_dma_pe() was reduced to just calling
>>>iommu_group_put(), this merges pnv_pci_ioda2_release_dma_pe()
>>>into pnv_ioda_release_vf_PE().
>>>
>>
>>Sorry, I don't understand how it works. When PF's driver disables
>>IOV capability, the VF cannnot work. The guest is unlikely to know
>>that and still continue accessing the VF's resources (e.g. config
>>space and MMIO registers). It would cause EEH errors.
>
>The host disables IOV which removes VF devices which unbinds vfio_pci driver
>and does all the cleanup, eventually we get to QEMU's
>vfio_req_notifier_handler() and PCI hot unplug is initiated and the device
>disappears from the guest.
>
>If the guest cannot do PCI hotunplug, then EEH will make host stop it anyway.
>
>Here we do not really care what happens to the guest (it can detect EEH or
>hotunplug or simply crash), we need to make sure that the _host_ does not
>crash in any case because the root user did something weird.
>

Thanks for the detailed explanation. My concern is there should have some
race: the guest doesn't receive the signal and unplug it in time. The guest
could possibly produces PCI traffic that cannnot be handled by VF. My first
impression would be raised EEH as the result. If it's a fenced PHB and the
host is going to be affected. Would it be a problem? I think it would be nice
if the guest can work without issue under this situation.

As you claimed, it's a _weird_ behaviour for user to unbind PF's driver that
in turn disables IOV capability when VFs are owned by guest. Why not stop user
from doing it?

>
>>
>>>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>---
>>>arch/powerpc/platforms/powernv/pci-ioda.c | 33 +++++++++++++------------------
>>>1 file changed, 14 insertions(+), 19 deletions(-)
>>>
>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>index ce9f2bf..8108c54 100644
>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>@@ -1333,27 +1333,25 @@ static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
>>>static void pnv_pci_ioda2_group_release(void *iommu_data)
>>>{
>>>	struct iommu_table_group *table_group = iommu_data;
>>>+	struct pnv_ioda_pe *pe = container_of(table_group,
>>>+			struct pnv_ioda_pe, table_group);
>>>+	struct pci_controller *hose = pci_bus_to_host(pe->parent_dev->bus);
>>
>>pe->parent_dev would be NULL for non-VF-PEs and it's protected by CONFIG_PCI_IOV
>>in pci.h.
>
>
>Yeah, I'll fix it.
>
>>
>>>+	struct pnv_phb *phb = hose->private_data;
>>>+	struct iommu_table *tbl = pe->table_group.tables[0];
>>>+	int64_t rc;
>>>
>>>-	table_group->group = NULL;
>>>-}
>>>-
>>>-static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe *pe)
>>>-{
>>>-	struct iommu_table    *tbl;
>>>-	int64_t               rc;
>>>-
>>>-	tbl = pe->table_group.tables[0];
>>>	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
>>>	if (rc)
>>>		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
>>>
>>>	pnv_pci_ioda2_set_bypass(pe, false);
>>>-	if (pe->table_group.group) {
>>>-		iommu_group_put(pe->table_group.group);
>>>-		BUG_ON(pe->table_group.group);
>>>-	}
>>>+
>>>+	BUG_ON(!tbl);
>>>	pnv_pci_ioda2_table_free_pages(tbl);
>>>-	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>>>+	iommu_free_table(tbl, of_node_full_name(pe->parent_dev->dev.of_node));
>>>+
>>>+	pnv_ioda_deconfigure_pe(phb, pe);
>>>+	pnv_ioda_free_pe(phb, pe->pe_number);
>>>}
>>
>>It's not correct enough. One PE is comprised of DMA, MMIO, mapping info etc.
>>This function disposes all of them when DMA finishes its job. I don't figure
>>out a better way to represent all of them and their relationship. I guess it's
>>worthy to have something in long term though it's not trival work.
>
>
>Sorry, I am missing your point here. I am not changing the resource
>deallocation here, I am just doing it slightly later and all I wonder at the
>moment is if there are races - like having 2 scripts - one doing unbind PF
>and another doing bind PF - will this crash the host in theory?
>

One PE is comprised of multiple facets like DMA/MMIO/PELTM/EEH as I
explained in last reply. pnv_pci_ioda2_release_dma_pe() called to
destroy DMA window is going to tear down all (or most) of them.
That means DMA and PE are equivalent, but they're not. Furturemore,
not all PE have associated enabled DMA windows.

>>
>>>
>>>static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
>>>@@ -1376,16 +1374,13 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
>>>		if (pe->parent_dev != pdev)
>>>			continue;
>>>
>>>-		pnv_pci_ioda2_release_dma_pe(pdev, pe);
>>>-
>>>		/* Remove from list */
>>>		mutex_lock(&phb->ioda.pe_list_mutex);
>>>		list_del(&pe->list);
>>>		mutex_unlock(&phb->ioda.pe_list_mutex);
>>>
>>>-		pnv_ioda_deconfigure_pe(phb, pe);
>>>-
>>>-		pnv_ioda_free_pe(phb, pe->pe_number);
>>>+		if (pe->table_group.group)
>>>+			iommu_group_put(pe->table_group.group);
>>>	}
>>>}
>>>
>>>--
>>>2.5.0.rc3
>>>
>>
>
>
>-- 
>Alexey
>
