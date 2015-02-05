Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38A241A09FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 11:08:23 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 5 Feb 2015 10:08:21 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2B9EB2CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 11:08:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1508ASD28639358
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 11:08:19 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1507jie010183
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 11:07:45 +1100
Date: Thu, 5 Feb 2015 08:07:24 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V11 16/17] powerpc/powernv: Reserve additional space for
 IOV BAR, with m64_per_iov supported
Message-ID: <20150205000724.GC18037@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-17-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150204220518.GB20072@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150204220518.GB20072@google.com>
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

On Wed, Feb 04, 2015 at 04:05:18PM -0600, Bjorn Helgaas wrote:
>On Thu, Jan 15, 2015 at 10:28:06AM +0800, Wei Yang wrote:
>> M64 aperture size is limited on PHB3. When the IOV BAR is too big, this
>> will exceed the limitation and failed to be assigned.
>> 
>> This patch introduce a different mechanism based on the IOV BAR size:
>> 
>> IOV BAR size is smaller than 64M, expand to total_pe.
>> IOV BAR size is bigger than 64M, roundup power2.

To be consistent, IOV BAR in the change log should be VF BAR.

>
>Can you elaborate on this a little more?  I assume this is talking about an
>M64 BAR.  What is the size limit for this?
>

Yes, this is a corner case. This is really not easy to understand and I don't
talk about it in the Documentation.

>If I understand correctly, hardware always splits an M64 BAR into 256
>segments.  If you wanted each 128MB VF BAR in a separate PE, the M64 BAR
>would have to be 256 * 128MB = 32GB.  So maybe the idea is that instead of
>consuming 32GB of address space, you let each VF BAR span several segments.
>If each 128MB VF BAR spanned 4 segments, each segment would be 32MB and the
>whole M64 BAR would be 256 * 32MB = 8GB.  But you would have to use
>"companion" PEs so all 4 segments would be in the same "domain," and that
>would reduce the number of VFs you could support from 256 to 256/4 = 64.
>

You are right on the reason. When the VF BAR is big and we still use the
previous mechanism, this will used up the total M64 window. 

>If that were the intent, I would think TotalVFs would be involved, but it's
>not.  For a device with TotalVFs=8 and a 128MB VF BAR, it would make sense
>to dedicate 4 segments to each of those BARs because you could only use 8*4
>= 32 segments total.  If the device had TotalVFs=128, your only choices
>would be 1 segment per BAR (256 segments * 128MB/segment = 32GB) or 2
>segments per BAR (256 segments * 64MB/segment = 16GB).
>

Hmm... it is time to tell you another usage of the M64 BAR. There are two mode
of the M64 BAR. First one is the M64 BAR will cover a 256 even segmented
space, with each segment maps to a PE. Second one is the M64 BAR specify a
space and the whole space belongs to one PE. It is called "Single PE" mode.

In this implementation of this case, we choose the "Single PE" mode. The
advantage of this choice is in some case, we still have a chance to map a VF
into an individual PE, while the mechanism you proposed couldn't. I have to
admit, our choice has disadvantages. It will use more M64 BAR than yours.

Let me explain how current choice works, so that you could know the
difference.

When we detected the VF BAR is big enough, we expand the IOV BAR to another
number of VF BARs instead of 256. The number should be power_of_2 value, since
the M64 BAR hardware requirement.

Then we decide to use 4 M64 BARs for one IOV BAR at most. (So sad, we just
have 16 M64 BARs) Then how we map it?

If the user want to enable less than or equal to 4 VFs, that's great! We could
use one M64 BAR to map one VF BAR, since the M64 BAR works in "Single Mode".
In this case, each VF sits in their own PE.

If the user want to enable more VFs, so sad several VFs have to share one PE.

The logic for PE sharing is in the last commit.

m64_per_iov 
   This is a mark.
   If it is 1, means VF BAR size is not big. Use M64 BAR in segmented mode.
   If it is M64_PER_IOV, means VF BAR size is big. Use M64 BAR in "Single PE"
   mode.
vf_groups
   Indicates one IOV BAR will be divided in how many groups, and each group
   use one M64 BAR.
   In normal case, one M64 BAR per IOV BAR.
   In this special case, depends on the vf_num user want to enable.
vf_per_group
   In normal case, this is not used.
   In this special case, it helps to calculate the start address and size of
   each M64 BAR.

>If you use 2 segments per BAR and you want NumVFs=128, you can't shift
>anything, so the PE assignments are completely fixed (VF0 in PE0, VF1 in
>PE1, etc.)
>
>It seems like you'd make different choices about pdn->max_vfs for these two
>devices, but currently you only look at the VF BAR size, not at TotalVFs.
>
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/pci-bridge.h     |    2 ++
>>  arch/powerpc/platforms/powernv/pci-ioda.c |   33 ++++++++++++++++++++++++++---
>>  2 files changed, 32 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>> index d61c384..7156486 100644
>> --- a/arch/powerpc/include/asm/pci-bridge.h
>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>> @@ -174,6 +174,8 @@ struct pci_dn {
>>  	u16     max_vfs;		/* number of VFs IOV BAR expended */
>>  	u16     vf_pes;			/* VF PE# under this PF */
>>  	int     offset;			/* PE# for the first VF PE */
>> +#define M64_PER_IOV 4
>> +	int     m64_per_iov;
>>  #define IODA_INVALID_M64        (-1)
>>  	int     m64_wins[PCI_SRIOV_NUM_BARS];
>>  #endif /* CONFIG_PCI_IOV */
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 94fe6e1..23ea873 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -2180,6 +2180,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  	int i;
>>  	resource_size_t size;
>>  	struct pci_dn *pdn;
>> +	int mul, total_vfs;
>>  
>>  	if (!pdev->is_physfn || pdev->is_added)
>>  		return;
>> @@ -2190,6 +2191,32 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  	pdn = pci_get_pdn(pdev);
>>  	pdn->max_vfs = 0;
>>  
>> +	total_vfs = pci_sriov_get_totalvfs(pdev);
>> +	pdn->m64_per_iov = 1;
>> +	mul = phb->ioda.total_pe;
>> +
>> +	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
>> +		res = &pdev->resource[i];
>> +		if (!res->flags || res->parent)
>> +			continue;
>> +		if (!pnv_pci_is_mem_pref_64(res->flags)) {
>> +			dev_warn(&pdev->dev, " non M64 IOV BAR %pR on %s\n",
>> +					res, pci_name(pdev));
>> +			continue;
>> +		}
>> +
>> +		size = pci_iov_resource_size(pdev, i);
>> +
>> +		/* bigger than 64M */
>> +		if (size > (1 << 26)) {
>> +			dev_info(&pdev->dev, "PowerNV: VF BAR[%d] size "
>> +					"is bigger than 64M, roundup power2\n", i);
>> +			pdn->m64_per_iov = M64_PER_IOV;
>> +			mul = __roundup_pow_of_two(total_vfs);
>
>I think this might deserve more comment in dmesg.  "roundup power2" doesn't
>really tell me anything, especially since you mention a BAR, but you're
>actually rounding up total_vfs, not the BAR size.
>
>Does this reduce the number of possible VFs?  We already can't set NumVFs
>higher than TotalVFs.  Does this make it so we can't set NumVFs higher than
>pdn->max_vfs?
>

Hope my explanation above could help you understand this.

I am on IRC now, any problem, you could ping me :-)

>
>> +			break;
>> +		}
>> +	}
>> +
>>  	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
>>  		res = &pdev->resource[i];
>>  		if (!res->flags || res->parent)
>> @@ -2202,13 +2229,13 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>>  
>>  		dev_dbg(&pdev->dev, " Fixing VF BAR[%d] %pR to\n", i, res);
>>  		size = pci_iov_resource_size(pdev, i);
>> -		res->end = res->start + size * phb->ioda.total_pe - 1;
>> +		res->end = res->start + size * mul - 1;
>>  		dev_dbg(&pdev->dev, "                       %pR\n", res);
>>  		dev_info(&pdev->dev, "VF BAR%d: %pR (expanded to %d VFs for PE alignment)",
>>  				i - PCI_IOV_RESOURCES,
>> -				res, phb->ioda.total_pe);
>> +				res, mul);
>>  	}
>> -	pdn->max_vfs = phb->ioda.total_pe;
>> +	pdn->max_vfs = mul;
>
>Maybe this is the part that makes it hard to compute the size in
>sriov_init() -- you reduce pdn->max_vfs in some cases, and maybe that can
>affect the space you reserve for IOV BARs?  E.g., maybe you reduce
>pdn->max_vfs to 128 because VF BAR 3 is larger than 64MB, but you've
>already expanded the IOV space for VF BAR 1 based on 256 PEs?
>
>But then I'm still confused because the loop here in
>pnv_pci_ioda_fixup_iov_resources() always expands the resource based on
>phb->ioda.total_pe; that part doesn't depend on "mul" or pdn->max_vfs at
>all.
>
>Or maybe this is just a bug in the fixup loop, and it *should* depend on
>"mul"?
>
>>  }
>>  
>>  static void pnv_pci_ioda_fixup_sriov(struct pci_bus *bus)
>> -- 
>> 1.7.9.5
>> 

-- 
Richard Yang
Help you, Help me
