Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55A591A0165
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 10:09:14 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 5 Feb 2015 09:09:13 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2E9922CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 10:09:11 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t14N92MP42860776
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 10:09:11 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t14N8biI008514
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 10:08:37 +1100
Date: Thu, 5 Feb 2015 07:08:16 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V11 12/17] powerpc/powernv: Reserve additional space for
 IOV BAR according to the number of total_pe
Message-ID: <20150204230816.GB18037@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-13-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150204212607.GA20072@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150204212607.GA20072@google.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 04, 2015 at 03:26:07PM -0600, Bjorn Helgaas wrote:
>On Thu, Jan 15, 2015 at 10:28:02AM +0800, Wei Yang wrote:
>> On PHB3, PF IOV BAR will be covered by M64 BAR to have better PE isolation.
>> Mostly the total_pe number is different from the total_VFs, which will lead
>> to a conflict between MMIO space and the PE number.
>> 
>> For example, total_VFs is 128 and total_pe is 256, then the second half of
>> M64 BAR space will be part of other PCI device, which may already belongs
>> to other PEs.
>> 
>> This patch reserve additional space for the PF IOV BAR, which is total_pe
>> number of VF's BAR size. By doing so, it prevents the conflict.
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/machdep.h        |    4 ++
>>  arch/powerpc/include/asm/pci-bridge.h     |    3 ++
>>  arch/powerpc/kernel/pci-common.c          |    5 +++
>>  arch/powerpc/platforms/powernv/pci-ioda.c |   59 +++++++++++++++++++++++++++++
>>  4 files changed, 71 insertions(+)
>> 
>> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
>> index c8175a3..965547c 100644
>> --- a/arch/powerpc/include/asm/machdep.h
>> +++ b/arch/powerpc/include/asm/machdep.h
>> @@ -250,6 +250,10 @@ struct machdep_calls {
>>  	/* Reset the secondary bus of bridge */
>>  	void  (*pcibios_reset_secondary_bus)(struct pci_dev *dev);
>>  
>> +#ifdef CONFIG_PCI_IOV
>> +	void (*pcibios_fixup_sriov)(struct pci_bus *bus);
>> +#endif /* CONFIG_PCI_IOV */
>> +
>>  	/* Called to shutdown machine specific hardware not already controlled
>>  	 * by other drivers.
>>  	 */
>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>> index 334e745..b857ec4 100644
>> --- a/arch/powerpc/include/asm/pci-bridge.h
>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>> @@ -170,6 +170,9 @@ struct pci_dn {
>>  #define IODA_INVALID_PE		(-1)
>>  #ifdef CONFIG_PPC_POWERNV
>>  	int	pe_number;
>> +#ifdef CONFIG_PCI_IOV
>> +	u16     max_vfs;		/* number of VFs IOV BAR expended */
>> +#endif /* CONFIG_PCI_IOV */
>>  #endif
>>  	struct list_head child_list;
>>  	struct list_head list;
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>> index 889f743..832b7e1 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -1636,6 +1636,11 @@ void pcibios_scan_phb(struct pci_controller *hose)
>>  	if (ppc_md.pcibios_fixup_phb)
>>  		ppc_md.pcibios_fixup_phb(hose);
>>  
>> +#ifdef CONFIG_PCI_IOV
>> +	if (ppc_md.pcibios_fixup_sriov)
>> +		ppc_md.pcibios_fixup_sriov(bus);
>> +#endif /* CONFIG_PCI_IOV */
>> +
>>  	/* Configure PCI Express settings */
>>  	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
>>  		struct pci_bus *child;
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 31335a7..6704fdf 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1721,6 +1721,62 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
>>  static void pnv_pci_init_ioda_msis(struct pnv_phb *phb) { }
>>  #endif /* CONFIG_PCI_MSI */
>>  
>> +#ifdef CONFIG_PCI_IOV
>> +static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>> +{
>> +	struct pci_controller *hose;
>> +	struct pnv_phb *phb;
>> +	struct resource *res;
>> +	int i;
>> +	resource_size_t size;
>> +	struct pci_dn *pdn;
>> +
>> +	if (!pdev->is_physfn || pdev->is_added)
>> +		return;
>> +
>> +	hose = pci_bus_to_host(pdev->bus);
>> +	phb = hose->private_data;
>> +
>> +	pdn = pci_get_pdn(pdev);
>> +	pdn->max_vfs = 0;
>
>^^^ point A
>
>> +
>> +	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
>> +		res = &pdev->resource[i];
>> +		if (!res->flags || res->parent)
>> +			continue;
>> +		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>> +			dev_warn(&pdev->dev, " Skipping expanding IOV BAR %pR on %s\n",
>> +				 res, pci_name(pdev));
>> +			continue;
>> +		}
>> +
>> +		dev_dbg(&pdev->dev, " Fixing VF BAR[%d] %pR to\n", i, res);
>> +		size = pci_iov_resource_size(pdev, i);
>> +		res->end = res->start + size * phb->ioda.total_pe - 1;
>> +		dev_dbg(&pdev->dev, "                       %pR\n", res);
>> +		dev_info(&pdev->dev, "VF BAR%d: %pR (expanded to %d VFs for PE alignment)",
>> +				i - PCI_IOV_RESOURCES,
>> +				res, phb->ioda.total_pe);
>> +	}
>> +	pdn->max_vfs = phb->ioda.total_pe;
>
>I don't think you change phb->ioda.total_pe between point A (above) and
>here.  Does that mean "max_vfs == 0" is some kind of flag, maybe related to
>the three cases in pnv_pci_iov_resource_alignment()?  Ewww!
>

Not a flag exactly.

The pci_dn is initialized to 0, I reset it to 0 explicitly since on the
hotplug case, we need to redo all those stuff again.

Putting this in a function like pcibios_release_device() seems more
reasonable. I will think about it later.


>If it doesn't change, just set "pdn->max_vfs = phb->ioda.total_pe" at
>point A and be done with it.

This will change. As you see in another patch.
Will reply that mail for details.

>
>But hopefully you can just remove this fixup path altogether.
>

Agree.

Use a weak function as you proposed is a better way.

>> +}
>> +
>> +static void pnv_pci_ioda_fixup_sriov(struct pci_bus *bus)
>> +{
>> +	struct pci_dev *pdev;
>> +	struct pci_bus *b;
>> +
>> +	list_for_each_entry(pdev, &bus->devices, bus_list) {
>> +		b = pdev->subordinate;
>> +
>> +		if (b)
>> +			pnv_pci_ioda_fixup_sriov(b);
>> +
>> +		pnv_pci_ioda_fixup_iov_resources(pdev);
>> +	}
>> +}
>> +#endif /* CONFIG_PCI_IOV */
>> +
>>  /*
>>   * This function is supposed to be called on basis of PE from top
>>   * to bottom style. So the the I/O or MMIO segment assigned to
>> @@ -2097,6 +2153,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
>>  	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
>>  	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
>> +#ifdef CONFIG_PCI_IOV
>> +	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
>> +#endif /* CONFIG_PCI_IOV */
>>  	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
>>  
>>  	/* Reset IODA tables to a clean state */
>> -- 
>> 1.7.9.5
>> 

-- 
Richard Yang
Help you, Help me
