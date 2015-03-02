Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 743211A0196
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 18:56:40 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 2 Mar 2015 17:56:38 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B70392BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 18:56:35 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t227uRt838535222
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 18:56:35 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t227u16u001948
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 18:56:02 +1100
Date: Mon, 2 Mar 2015 15:55:45 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 18/21] powerpc/powernv: Reserve additional space for
 IOV BAR, with m64_per_iov supported
Message-ID: <20150302075545.GI21571@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083504.32124.23374.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224090657.GM6220@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150224090657.GM6220@google.com>
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

On Tue, Feb 24, 2015 at 03:06:57AM -0600, Bjorn Helgaas wrote:
>On Tue, Feb 24, 2015 at 02:35:04AM -0600, Bjorn Helgaas wrote:
>> From: Wei Yang <weiyang@linux.vnet.ibm.com>
>> 
>> M64 aperture size is limited on PHB3.  When the IOV BAR is too big, this
>> will exceed the limitation and failed to be assigned.
>> 
>> Introduce a different mechanism based on the IOV BAR size:
>> 
>>   - if IOV BAR size is smaller than 64MB, expand to total_pe
>>   - if IOV BAR size is bigger than 64MB, roundup power2
>> 
>> [bhelgaas: make dev_printk() output more consistent, use PCI_SRIOV_NUM_BARS]
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  arch/powerpc/include/asm/pci-bridge.h     |    2 ++
>>  arch/powerpc/platforms/powernv/pci-ioda.c |   33 ++++++++++++++++++++++++++---
>>  2 files changed, 32 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>> index 011340df8583..d824bb184ab8 100644
>> --- a/arch/powerpc/include/asm/pci-bridge.h
>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>> @@ -179,6 +179,8 @@ struct pci_dn {
>>  	u16     max_vfs;		/* number of VFs IOV BAR expended */
>>  	u16     vf_pes;			/* VF PE# under this PF */
>>  	int     offset;			/* PE# for the first VF PE */
>> +#define M64_PER_IOV 4
>> +	int     m64_per_iov;
>>  #define IODA_INVALID_M64        (-1)
>>  	int     m64_wins[PCI_SRIOV_NUM_BARS];
>>  #endif /* CONFIG_PCI_IOV */
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index a3c2fbe35fc8..30b7c3909746 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -2242,6 +2242,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  	int i;
>>  	resource_size_t size;
>>  	struct pci_dn *pdn;
>> +	int mul, total_vfs;
>>  
>>  	if (!pdev->is_physfn || pdev->is_added)
>>  		return;
>> @@ -2252,6 +2253,32 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  	pdn = pci_get_pdn(pdev);
>>  	pdn->max_vfs = 0;
>>  
>> +	total_vfs = pci_sriov_get_totalvfs(pdev);
>> +	pdn->m64_per_iov = 1;
>> +	mul = phb->ioda.total_pe;
>> +
>> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>> +		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>> +		if (!res->flags || res->parent)
>> +			continue;
>> +		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>> +			dev_warn(&pdev->dev, " non M64 VF BAR%d: %pR\n",
>> +				 i, res);
>
>Why is this a dev_warn()?  Can the user do anything about it?  Do you want
>bug reports if users see this message?  There are several other instances
>of this in the other patches, too.
>

Thanks for your question.

Actually, on current implementation, powernv platform can't support a SRIOV
device with non M64 IOV BAR, since we map the IOV BAR with M64 BAR on PHB.
Actually, I am not sure which one is better.

>> +			continue;
>> +		}
>> +
>> +		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>> +
>> +		/* bigger than 64M */
>> +		if (size > (1 << 26)) {
>> +			dev_info(&pdev->dev, "PowerNV: VF BAR%d: %pR IOV size is bigger than 64M, roundup power2\n",
>> +				 i, res);
>> +			pdn->m64_per_iov = M64_PER_IOV;
>> +			mul = __roundup_pow_of_two(total_vfs);
>
>Why is this __roundup_pow_of_two() instead of roundup_pow_of_two()?
>I *think* __roundup_pow_of_two() is basically a helper function for
>implementing roundup_pow_of_two() and not intended to be used by itself.
>
>I think there are other patches that use __roundup_pow_of_two(), too.

Got it, will change it.

>
>> +			break;
>> +		}
>> +	}
>> +
>>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>>  		res = &pdev->resource[i + PCI_IOV_RESOURCES];
>>  		if (!res->flags || res->parent)
>> @@ -2264,12 +2291,12 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  
>>  		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
>>  		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>> -		res->end = res->start + size * phb->ioda.total_pe - 1;
>> +		res->end = res->start + size * mul - 1;
>>  		dev_dbg(&pdev->dev, "                       %pR\n", res);
>>  		dev_info(&pdev->dev, "VF BAR%d: %pR (expanded to %d VFs for PE alignment)",
>> -				i, res, phb->ioda.total_pe);
>> +			 i, res, mul);
>>  	}
>> -	pdn->max_vfs = phb->ioda.total_pe;
>> +	pdn->max_vfs = mul;
>>  }
>>  
>>  static void pnv_pci_ioda_fixup_sriov(struct pci_bus *bus)
>> 

-- 
Richard Yang
Help you, Help me
