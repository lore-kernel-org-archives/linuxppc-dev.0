Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 884831A09C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 09:46:39 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 5 Feb 2015 08:46:37 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0A1042CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 09:46:35 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t14MkQL44194402
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 09:46:34 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t14Mk0cG013269
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 09:46:01 +1100
Date: Thu, 5 Feb 2015 06:45:40 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V11 13/17] powerpc/powernv: Implement
 pcibios_iov_resource_alignment() on powernv
Message-ID: <20150204224540.GA18037@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-14-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150204212614.GB11271@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150204212614.GB11271@google.com>
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

On Wed, Feb 04, 2015 at 03:26:14PM -0600, Bjorn Helgaas wrote:
>On Thu, Jan 15, 2015 at 10:28:03AM +0800, Wei Yang wrote:
>> This patch implements the pcibios_iov_resource_alignment() on powernv
>> platform.
>> 
>> On PowerNV platform, there are 3 cases for the IOV BAR:
>> 1. initial state, the IOV BAR size is multiple times of VF BAR size
>> 2. after expanded, the IOV BAR size is expanded to meet the M64 segment size
>> 3. sizing stage, the IOV BAR is truncated to 0
>> 
>> pnv_pci_iov_resource_alignment() handle these three cases respectively.
>>
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/machdep.h        |    3 +++
>>  arch/powerpc/kernel/pci-common.c          |   14 ++++++++++++++
>>  arch/powerpc/platforms/powernv/pci-ioda.c |   20 ++++++++++++++++++++
>>  3 files changed, 37 insertions(+)
>> 
>> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
>> index 965547c..12e8eb8 100644
>> --- a/arch/powerpc/include/asm/machdep.h
>> +++ b/arch/powerpc/include/asm/machdep.h
>> @@ -252,6 +252,9 @@ struct machdep_calls {
>>  
>>  #ifdef CONFIG_PCI_IOV
>>  	void (*pcibios_fixup_sriov)(struct pci_bus *bus);
>> +	resource_size_t (*pcibios_iov_resource_alignment)(struct pci_dev *,
>> +			                                    int resno,
>> +							    resource_size_t align);
>>  #endif /* CONFIG_PCI_IOV */
>>  
>>  	/* Called to shutdown machine specific hardware not already controlled
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>> index 832b7e1..8751dfb 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -130,6 +130,20 @@ void pcibios_reset_secondary_bus(struct pci_dev *dev)
>>  	pci_reset_secondary_bus(dev);
>>  }
>>  
>> +#ifdef CONFIG_PCI_IOV
>> +resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev,
>> +						 int resno,
>> +						 resource_size_t align)
>> +{
>> +	if (ppc_md.pcibios_iov_resource_alignment)
>> +		return ppc_md.pcibios_iov_resource_alignment(pdev,
>> +							       resno,
>> +							       align);
>> +
>> +	return 0;
>
>This isn't right, is it?  The default (weak) version returns
>pci_iov_resource_size(dev, resno).  When you don't have a
>ppc_md.pcibios_iov_resource_alignment pointer, don't you
>want to do that, too?
>

You are right, this isn't correct.

It should return align here.

>> +}
>> +#endif /* CONFIG_PCI_IOV */
>> +
>>  static resource_size_t pcibios_io_size(const struct pci_controller *hose)
>>  {
>>  #ifdef CONFIG_PPC64
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 6704fdf..8bad2b0 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1953,6 +1953,25 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
>>  	return phb->ioda.io_segsize;
>>  }
>>  
>> +#ifdef CONFIG_PCI_IOV
>> +static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>> +							    int resno,
>> +							    resource_size_t align)
>> +{
>> +	struct pci_dn *pdn = pci_get_pdn(pdev);
>> +	resource_size_t iov_align;
>> +
>> +	iov_align = resource_size(&pdev->resource[resno]);
>> +	if (iov_align)
>> +		return iov_align;
>> +
>> +	if (pdn->max_vfs)
>> +		return pdn->max_vfs * align;
>> +
>> +	return align;
>
>pcibios_iov_resource_alignment() returns different things depending on when
>you call it?  That doesn't sound good.
>

Agree, this is not a good way to address this problem.

>Is this related to my questions about sriov_init() and
>pnv_pci_ioda_fixup_iov_resources()?  If you adopted my suggestion and set
>the size once in sriov_init(), would that get rid of one of these cases?
>
>Maybe it would help me understand if you explained the three cases a bit
>more.

Sure, and this helps me too :)

First pci_sriov_resource_alignment() returns the single VF BAR size in the
original version. And the purpose for introducing the
pcibios_iov_resource_alignment() is to give arch a chance to return different
value. For powernv platform, we want to return the 256 * single VF BAR size.

This size is used in the pbus_size_mem() for sizing stage and in
pci_assign_unassigned_root_bus_resources() for assigning stage. Normally, on
powernv platform, it just need to return the resource_size() of this IOV BAR,
while there is a problem in pci_assign_unassigned_root_bus_resources().

Since the IOV BAR is an "additional" resource, in pbus_size_mem() the resource
will be truncated to 0. So the first case will fail. And the size needs to be
calculated from the max_vfs * VF BAR size.

max_vfs is field in pci_dn, which may not be set before the fixup is called.
Even currently I don't see someone ask for IOV BAR alignment before fixup, I
am not sure in the future no one will do this.  I believe you method mentioned
in another mail will solve this problem. This means when sriov_init() returns,
we get the exact number of VF BAR size it reseved.

The last case is to make the logic tight. In case both the above two cases
fails, this will return the original value.

I believe after using your proposed method, to "fixup" the IOV BAR in
sriov_init(), we could just return the max_vfs * VF BAR size.

>
>> +}
>> +#endif /* CONFIG_PCI_IOV */
>> +
>>  /* Prevent enabling devices for which we couldn't properly
>>   * assign a PE
>>   */
>> @@ -2155,6 +2174,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
>>  #ifdef CONFIG_PCI_IOV
>>  	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
>> +	ppc_md.pcibios_iov_resource_alignment = pnv_pci_iov_resource_alignment;
>>  #endif /* CONFIG_PCI_IOV */
>>  	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
>>  
>> -- 
>> 1.7.9.5
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me
