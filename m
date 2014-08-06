Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 945921A01F2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 12:16:33 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 6 Aug 2014 12:06:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B40243578048
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 12:06:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7626hiY17170618
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 12:06:43 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s76268vh032104
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 12:06:08 +1000
Date: Wed, 6 Aug 2014 12:06:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Fix IOMMU group lost
Message-ID: <20140806020604.GA5244@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1407227258-17732-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20140805160323.GA9066@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140805160323.GA9066@richard>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 06, 2014 at 12:03:23AM +0800, Wei Yang wrote:
>I just give a shot with patch on PHB3 with hotplug case. From the functional
>point of view, it works. The iommu group is created and attached with device.
>While it still has the problem we had which commit 3f28c5a tried to solve.
>
>In the test case, the pci bus is not removed. This means in
>pcibios_add_device(), it will try to add iommu group since the
>pci_bus->is_added is true. And at this moment the pci_dev->kobj->sd is not
>initialized properly. This makes the iommu_add_device() fail.
>

Yes, it's expected behaviour. I'll remove the PCI bus notifier
where we try to add IOMMU group, but fail eventually since
pdev->dev->kobj->sd isn't populated. This mechanism isn't taking
effect in full/partial hotplug cases. It would be separate fix,
I guess.

>Your patch delete the warning at this place, so from the log it looks good. But
>actually, it is not that clear to address the problem. We still have two
>problems:
>   1. iommu group will fail to be created
>   2. iommu group will be created multiple times
>

IOMMU group won't fail to be created since we have the condition:
If the IOMMU group (for one specific PCI device) has been created,
we simply bail without warning messages.

The problem (2) could be resolved by remove the PCI bus notifier.
And it should fail if we try add IOMMU group for PCI device who
had attached IOMMU group.

>My opinion is to make a clear understanding of the order/sequence of the iommu
>group creation in both pci bus removed/not removed cases, than create and
>attach it properly.
>

Please take a look on the function calls listed in the commit log.
For full hotplug case, IOMMU group is attached at (C). For partial
hotplug case (your test case), IOMMU group is bound at (A).

Thanks,
Gavin

>On Tue, Aug 05, 2014 at 06:27:38PM +1000, Gavin Shan wrote:
>>When we take full hotplug to recover from EEH errors, PCI buses
>>could be involved. For the case, the child devices of involved
>>PCI buses can't be attached to IOMMU group properly, which is
>>caused by commit 3f28c5a ("powerpc/powernv: Reduce multi-hit of
>>iommu_add_device()").
>>
>>When adding the PCI devices of the newly created PCI buses to
>>the system, the IOMMU group is expected to be added in (C).
>>(A) fails to bind the IOMMU group because bus->is_added is
>>false. (B) fails because the device doesn't have binding IOMMU
>>table yet. bus->is_added is set to true at end of (C) and
>>pdev->is_added is set to true at (D).
>>
>>   pcibios_add_pci_devices()
>>      pci_scan_bridge()
>>         pci_scan_child_bus()
>>            pci_scan_slot()
>>               pci_scan_single_device()
>>                  pci_scan_device()
>>                  pci_device_add()
>>                     pcibios_add_device()           A: Ignore
>>                     device_add()                   B: Ignore
>>                  pcibios_fixup_bus()
>>                     pcibios_setup_bus_devices()
>>                        pcibios_setup_device()      C: Hit
>>      pcibios_finish_adding_to_bus()
>>         pci_bus_add_devices()
>>            pci_bus_add_device()                    D: Add device
>>
>>If the parent PCI bus isn't involved in hotplug, the IOMMU
>>group is expected to be bound in (A).
>>
>>The patch fixes the issue by reverting commit 3f28c5a and remove
>>WARN_ON() in iommu_add_device() to allow calling the function
>>even the specified device already has associated IOMMU group.
>>
>>Cc: <stable@vger.kernel.org>  # 3.16+
>>Reported-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>Tested-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>---
>> arch/powerpc/kernel/iommu.c               | 30 +++++++++++++-----------------
>> arch/powerpc/platforms/powernv/pci-ioda.c |  2 +-
>> 2 files changed, 14 insertions(+), 18 deletions(-)
>>
>>diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>>index 88e3ec6..4663c10 100644
>>--- a/arch/powerpc/kernel/iommu.c
>>+++ b/arch/powerpc/kernel/iommu.c
>>@@ -1120,37 +1120,33 @@ EXPORT_SYMBOL_GPL(iommu_release_ownership);
>> int iommu_add_device(struct device *dev)
>> {
>> 	struct iommu_table *tbl;
>>-	int ret = 0;
>>
>>-	if (WARN_ON(dev->iommu_group)) {
>>-		pr_warn("iommu_tce: device %s is already in iommu group %d, skipping\n",
>>-				dev_name(dev),
>>-				iommu_group_id(dev->iommu_group));
>>+	if (dev->iommu_group) {
>>+		pr_debug("%s: Skipping device %s with iommu group %d\n",
>>+			 __func__, dev_name(dev),
>>+			 iommu_group_id(dev->iommu_group));
>> 		return -EBUSY;
>> 	}
>>
>> 	tbl = get_iommu_table_base(dev);
>> 	if (!tbl || !tbl->it_group) {
>>-		pr_debug("iommu_tce: skipping device %s with no tbl\n",
>>-				dev_name(dev));
>>+		pr_debug("%s: Skipping device %s with no tbl\n",
>>+			 __func__, dev_name(dev));
>> 		return 0;
>> 	}
>>
>>-	pr_debug("iommu_tce: adding %s to iommu group %d\n",
>>-			dev_name(dev), iommu_group_id(tbl->it_group));
>>+	pr_debug("%s: Adding %s to iommu group %d\n",
>>+		 __func__, dev_name(dev),
>>+		 iommu_group_id(tbl->it_group));
>>
>> 	if (PAGE_SIZE < IOMMU_PAGE_SIZE(tbl)) {
>>-		pr_err("iommu_tce: unsupported iommu page size.");
>>-		pr_err("%s has not been added\n", dev_name(dev));
>>+		pr_err("%s: Invalid IOMMU page size %lx (%lx) on %s\n",
>>+		       __func__, IOMMU_PAGE_SIZE(tbl),
>>+		       PAGE_SIZE, dev_name(dev));
>> 		return -EINVAL;
>> 	}
>>
>>-	ret = iommu_group_add_device(tbl->it_group, dev);
>>-	if (ret < 0)
>>-		pr_err("iommu_tce: %s has not been added, ret=%d\n",
>>-				dev_name(dev), ret);
>>-
>>-	return ret;
>>+	return iommu_group_add_device(tbl->it_group, dev);
>> }
>> EXPORT_SYMBOL_GPL(iommu_add_device);
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index de19ede..86290eb 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -462,7 +462,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
>>
>> 	pe = &phb->ioda.pe_array[pdn->pe_number];
>> 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
>>-	set_iommu_table_base(&pdev->dev, &pe->tce32_table);
>>+	set_iommu_table_base_and_group(&pdev->dev, &pe->tce32_table);
>> }
>>
>> static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
>>-- 
>>1.8.3.2
>
>-- 
>Richard Yang
>Help you, Help me
