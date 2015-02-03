Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69A2C1A0BE9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 12:31:00 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 3 Feb 2015 11:30:58 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 36AF2357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 12:30:57 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t131UnAc28377260
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Feb 2015 12:30:57 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t131UN0s027908
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Feb 2015 12:30:23 +1100
Date: Tue, 3 Feb 2015 09:30:05 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V11 14/17] powerpc/powernv: Shift VF resource with an
 offset
Message-ID: <20150203013005.GB5901@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-15-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150130230803.GA6795@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150130230803.GA6795@google.com>
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

On Fri, Jan 30, 2015 at 05:08:03PM -0600, Bjorn Helgaas wrote:
>On Thu, Jan 15, 2015 at 10:28:04AM +0800, Wei Yang wrote:
>> On PowrNV platform, resource position in M64 implies the PE# the resource
>> belongs to. In some particular case, adjustment of a resource is necessary
>> to locate it to a correct position in M64.
>> 
>> This patch introduces a function to shift the 'real' PF IOV BAR address
>> according to an offset.
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/pci-ioda.c |   31 +++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 8bad2b0..62bb2eb 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/pci.h>
>>  #include <linux/crash_dump.h>
>> +#include <linux/pci_regs.h>
>>  #include <linux/debugfs.h>
>>  #include <linux/delay.h>
>>  #include <linux/string.h>
>> @@ -749,6 +750,36 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
>>  	return 10;
>>  }
>>  
>> +#ifdef CONFIG_PCI_IOV
>> +static void pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>> +{
>> +	struct pci_dn *pdn = pci_get_pdn(dev);
>> +	int i;
>> +	struct resource *res;
>> +	resource_size_t size;
>> +
>> +	if (!dev->is_physfn)
>> +		return;
>> +
>> +	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
>> +		res = &dev->resource[i];
>> +		if (!res->flags || !res->parent)
>> +			continue;
>> +
>> +		if (!pnv_pci_is_mem_pref_64(res->flags))
>> +			continue;
>> +
>> +		dev_info(&dev->dev, " Shifting VF BAR %pR to\n", res);
>> +		size = pci_iov_resource_size(dev, i);
>> +		res->start += size*offset;
>
>It seems like you should adjust res->end, too.  Am I missing something?
>

Bjorn, below is the mail I didn't manage to send yesterday.
------------------------------------------------------------------------------
No, what I am doing here is a little tricky.

After reserve extra space for the IOV BAR, this range is marked down in the
resource tree. And this function is called in pnv_pci_sriov_enable(), which is
called when driver wants to enable the VF. How much the size this function
want to shift depends on the PE number range is assigned in this turn. (The PE
number range is recorded in the pdn->offset for the start number.)

So we don't dear to extend the end address, otherwise it will overlap other
devices' space. Or "Shrink" is more accurate than "Shift", we just "Shift" the
start address instead of the end address. The consequence is the IOV BAR is
told be sit on a new place.

Previously I think this has no problem, while taking a close look at it, there
is a potential problem. The real size of the IOV BAR is in hardware itself.
This means when we "Shift" the start address of the IOV BAR, the end address
is also "Shift". If the end address is out of the space we have reserved, the
MMIO transaction in this range will be seen by two devices. (If this my
understanding of this part is not correct, please let me know.)

So what I need to fix is make sure after the shift, the real end address(start
+ total_vf * size) is still in the range of the extended IOV BAR range.
Because we have reserved more space for the IOV BAR, we have some extra space
to shift the IOV BAR.

One thing I am not sure is could the real end address be
(start + num_vf * size)?


>And I'm not sure it's safe to move the resource here, because if we move it
>outside the bounds of the parent, we'll corrupt the resource tree.  Maybe
>we're safe for some reason here, but it requires more analysis than I've
>done to prove it.
>
>> +
>> +		dev_info(&dev->dev, "                 %pR\n", res);
>> +		pci_update_resource(dev, i);
>> +	}
>> +	pdn->max_vfs -= offset;
>> +}
>> +#endif /* CONFIG_PCI_IOV */
>> +
>>  #if 0
>>  static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
>>  {
>> -- 
>> 1.7.9.5
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me
