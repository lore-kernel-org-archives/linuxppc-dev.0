Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7E341A010C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 12:45:18 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 10 Feb 2015 11:45:16 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5EFDF2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 12:45:14 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A1j6fq34865324
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 12:45:14 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A1iex5029976
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 12:44:40 +1100
Date: Tue, 10 Feb 2015 09:44:24 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH V11 03/17] PCI: Add weak pcibios_iov_resource_alignment()
 interface
Message-ID: <20150210014424.GB6326@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <1423528379.4924.69.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423528379.4924.69.camel@au1.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 10, 2015 at 11:32:59AM +1100, Benjamin Herrenschmidt wrote:
>On Thu, 2015-01-15 at 10:27 +0800, Wei Yang wrote:
>> The alignment of PF's IOV BAR is designed to be the individual size of a
>> VF's BAR size. This works fine for many platforms, but on PowerNV platform
>> it needs some change.
>> 
>> The original alignment works, since at sizing and assigning stage the
>> requirement is from an individual VF's BAR size instead of the PF's IOV
>> BAR.  This is the reason for the original code to just retrieve the
>> individual VF BAR size as the alignment.
>> 
>> On PowerNV platform, it is required to align the whole PF IOV BAR to a
>> hardware segment. Based on this fact, the alignment of PF's IOV BAR should
>> be calculated seperately.
>> 
>> This patch introduces a weak pcibios_iov_resource_alignment() interface,
>> which gives platform a chance to implement specific method to calculate
>> the PF's IOV BAR alignment.
>
>While the patch is probably fine, I find the above explanation quite
>confusing :)
>

I will try to make it more clear.

>>From my memory (vague now) of the scheme we put in place, we need to
>practically reserve a portion of address space that corresponds to
>VF_size * Number_of_PEs. IE, it's not just the alignment that has
>constraints but also the size that need to be allocated.
>
>Now I suppose if we make the alignment to be the size of the M64
>window and if the core also bounces the allocated size to the
>alignment boundary, then we are fine, but that should be explained.
>

The purpose of this patch is to give a chance to different archs to calculate
the alignment of PF's IOV BAR.

How about I move the detailed explanation on powernv platform in the following
patch? And focus on what this patch does in this log?

>Cheers,
>Ben.
>
>
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/iov.c   |   11 ++++++++++-
>>  include/linux/pci.h |    3 +++
>>  2 files changed, 13 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index 933d8cc..5f48201 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -556,6 +556,12 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno)
>>  		4 * (resno - PCI_IOV_RESOURCES);
>>  }
>>  
>> +resource_size_t __weak pcibios_iov_resource_alignment(struct pci_dev *dev,
>> +		int resno, resource_size_t align)
>> +{
>> +	return align;
>> +}
>> +
>>  /**
>>   * pci_sriov_resource_alignment - get resource alignment for VF BAR
>>   * @dev: the PCI device
>> @@ -570,12 +576,15 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
>>  {
>>  	struct resource tmp;
>>  	int reg = pci_iov_resource_bar(dev, resno);
>> +	resource_size_t align;
>>  
>>  	if (!reg)
>>  		return 0;
>>  
>>  	__pci_read_base(dev, pci_bar_unknown, &tmp, reg);
>> -	return resource_alignment(&tmp);
>> +	align = resource_alignment(&tmp);
>> +
>> +	return pcibios_iov_resource_alignment(dev, resno, align);
>>  }
>>  
>>  /**
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 74ef944..ae7a7ea 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1163,6 +1163,9 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
>>  void pci_setup_bridge(struct pci_bus *bus);
>>  resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>>  					 unsigned long type);
>> +resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev,
>> +						 int resno,
>> +						 resource_size_t align);
>>  
>>  #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
>>  #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
>

-- 
Richard Yang
Help you, Help me
