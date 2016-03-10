Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A376F1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 15:47:47 +1100 (AEDT)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Thu, 10 Mar 2016 10:17:43 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2A4lXiA24313950
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 10:17:34 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2A4lUJX007303
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 10:17:32 +0530
Subject: Re: [RFC PATCH v4 1/7] PCI: Add a new option for resource_alignment
 to reassign alignment
To: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1457336918-3893-2-git-send-email-xyjxie@linux.vnet.ibm.com>
 <56E0D9BB.5010300@ozlabs.ru>
Cc: bhelgaas@google.com, corbet@lwn.net, alex.williamson@redhat.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <56E0FC6D.6060709@linux.vnet.ibm.com>
Date: Thu, 10 Mar 2016 12:47:41 +0800
MIME-Version: 1.0
In-Reply-To: <56E0D9BB.5010300@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/3/10 10:19, Alexey Kardashevskiy wrote:
> On 03/07/2016 06:48 PM, Yongji Xie wrote:
>> When using resource_alignment kernel parameter, the current
>> implement reassigns the alignment by changing resources' size
>> which can potentially break some drivers.
>
> How can this possibly break any driver?... It rounds up, not down, 
> what do I miss here?
>

If the driver uses the size to locate some register, e.g. the length of
register is related to the size,  or get some other information of the
device. The wrong size may break this driver.

So I think it's better not to touch the size here.  The resource_size()
should be the real size.

>>
>> So this patch adds a new option "noresize" for the parameter
>> to solve this problem.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   Documentation/kernel-parameters.txt |    5 ++++-
>>   drivers/pci/pci.c                   |   36 
>> +++++++++++++++++++++++++----------
>>   2 files changed, 30 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/kernel-parameters.txt 
>> b/Documentation/kernel-parameters.txt
>> index 9a53c92..d8b29ab 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -2912,13 +2912,16 @@ bytes respectively. Such letter suffixes can 
>> also be entirely omitted.
>>                   window. The default value is 64 megabytes.
>>           resource_alignment=
>>                   Format:
>> -                [<order of align>@][<domain>:]<bus>:<slot>.<func>[; 
>> ...]
>> +                [<order of align>@][<domain>:]<bus>:<slot>.<func>
>> +                [:noresize][; ...]
>>                   Specifies alignment and device to reassign
>>                   aligned memory resources.
>>                   If <order of align> is not specified,
>>                   PAGE_SIZE is used as alignment.
>>                   PCI-PCI bridge can be specified, if resource
>>                   windows need to be expanded.
>> +                noresize: Don't change the resources' sizes when
>> +                reassigning alignment.
>>           ecrc=        Enable/disable PCIe ECRC (transaction layer
>>                   end-to-end CRC checking).
>>                   bios: Use BIOS/firmware settings. This is the
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 602eb42..760cce5 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4598,7 +4598,8 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
>>    * RETURNS: Resource alignment if it is specified.
>>    *          Zero if it is not specified.
>>    */
>> -static resource_size_t pci_specified_resource_alignment(struct 
>> pci_dev *dev)
>> +static resource_size_t pci_specified_resource_alignment(struct 
>> pci_dev *dev,
>> +        bool *resize)
>>   {
>>       int seg, bus, slot, func, align_order, count;
>>       resource_size_t align = 0;
>> @@ -4626,6 +4627,11 @@ static resource_size_t 
>> pci_specified_resource_alignment(struct pci_dev *dev)
>>               }
>>           }
>>           p += count;
>> +        if (!strncmp(p, ":noresize", 9)) {
>> +            *resize = false;
>> +            p += 9;
>> +        } else
>> +            *resize = true;
>>           if (seg == pci_domain_nr(dev->bus) &&
>>               bus == dev->bus->number &&
>>               slot == PCI_SLOT(dev->devfn) &&
>> @@ -4658,11 +4664,12 @@ void 
>> pci_reassigndev_resource_alignment(struct pci_dev *dev)
>>   {
>>       int i;
>>       struct resource *r;
>> +    bool resize;
>>       resource_size_t align, size;
>>       u16 command;
>>
>>       /* check if specified PCI is target device to reassign */
>> -    align = pci_specified_resource_alignment(dev);
>> +    align = pci_specified_resource_alignment(dev, &resize);
>
> A compiler should have warned here about passing a pointer to 
> unitialized @resize.
>

OK. I'll fix it.

Thanks,
Yongji Xie

>>       if (!align)
>>           return;
>>
>> @@ -4684,15 +4691,24 @@ void 
>> pci_reassigndev_resource_alignment(struct pci_dev *dev)
>>           if (!(r->flags & IORESOURCE_MEM))
>>               continue;
>>           size = resource_size(r);
>> -        if (size < align) {
>> -            size = align;
>> -            dev_info(&dev->dev,
>> -                "Rounding up size of resource #%d to %#llx.\n",
>> -                i, (unsigned long long)size);
>> +        if (resize) {
>> +            if (size < align) {
>> +                size = align;
>> +                dev_info(&dev->dev,
>> +                    "Rounding up size of resource #%d to %#llx.\n",
>> +                    i, (unsigned long long)size);
>> +            }
>> +            r->flags |= IORESOURCE_UNSET;
>> +            r->end = size - 1;
>> +            r->start = 0;
>> +        } else {
>> +            if (size > align)
>> +                align = size;
>> +            r->flags &= ~IORESOURCE_SIZEALIGN;
>> +            r->flags |= IORESOURCE_STARTALIGN | IORESOURCE_UNSET;
>> +            r->start = align;
>> +            r->end = r->start + size - 1;
>>           }
>> -        r->flags |= IORESOURCE_UNSET;
>> -        r->end = size - 1;
>> -        r->start = 0;
>>       }
>>       /* Need to disable bridge's resource window,
>>        * to enable the kernel to reassign new resource
>>
>
>
