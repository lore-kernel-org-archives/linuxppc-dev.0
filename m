Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sld135cq8zDvLq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 13:56:55 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8U3qcUJ017901
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 23:56:52 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25s8sssd5q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 23:56:52 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 30 Sep 2016 13:56:49 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 45FED3578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 13:56:46 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8U3ukHN1442270
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 13:56:46 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8U3ujoC015921
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 13:56:46 +1000
Subject: Re: [PATCH v5 3/4] PCI: Add a new option for resource_alignment to
 reassign alignment
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1473757234-5284-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1473757234-5284-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160928224246.GC20897@localhost>
 <6e4d1079-a3a6-5d3f-7339-ae4d0e1ee828@linux.vnet.ibm.com>
 <20160929115422.GA31048@localhost>
Cc: zhong@linux.vnet.ibm.com, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, alex.williamson@redhat.com,
 paulus@samba.org, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Fri, 30 Sep 2016 11:56:46 +0800
MIME-Version: 1.0
In-Reply-To: <20160929115422.GA31048@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <aa83b424-e037-1e86-906f-f231b6195429@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/9/29 19:54, Bjorn Helgaas wrote:

> On Thu, Sep 29, 2016 at 10:38:01AM +0800, Yongji Xie wrote:
>> On 2016/9/29 6:42, Bjorn Helgaas wrote:
>>
>>> On Tue, Sep 13, 2016 at 05:00:33PM +0800, Yongji Xie wrote:
>>>> When using resource_alignment kernel parameter, the current
>>>> implement reassigns the alignment by changing resources' size
>>>> which can potentially break some drivers. For example, the driver
>>>> uses the size to locate some register whose length is related
>>>> to the size.
>>>>
>>>> This patch adds a new option "noresize" for the parameter to
>>>> solve this problem.
>>>>
>>>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>>>> ---
>>>>   Documentation/kernel-parameters.txt |    9 ++++++---
>>>>   drivers/pci/pci.c                   |   37 +++++++++++++++++++++++++----------
>>>>   2 files changed, 33 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>>>> index a4f4d69..d6a340d 100644
>>>> --- a/Documentation/kernel-parameters.txt
>>>> +++ b/Documentation/kernel-parameters.txt
>>>> @@ -3023,9 +3023,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>>>   				window. The default value is 64 megabytes.
>>>>   		resource_alignment=
>>>>   				Format:
>>>> -				[<order of align>@][<domain>:]<bus>:<slot>.<func>[; ...]
>>>> -				[<order of align>@]pci:<vendor>:<device>\
>>>> -						[:<subvendor>:<subdevice>][; ...]
>>>> +				[<order of align>@][noresize@][<domain>:]
>>>> +				<bus>:<slot>.<func>[; ...]
>>>> +				[<order of align>@][noresize@]pci:<vendor>:<device>
>>>> +				[:<subvendor>:<subdevice>][; ...]
>>>>   				Specifies alignment and device to reassign
>>>>   				aligned memory resources.
>>>>   				If <order of align> is not specified,
>>>> @@ -3036,6 +3037,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>>>   				instances of a device, the PCI vendor,
>>>>   				device, subvendor, and subdevice may be
>>>>   				specified, e.g., 4096@pci:8086:9c22:103c:198f
>>>> +				noresize: Don't change the resources' sizes when
>>>> +				reassigning alignment.
>>>>   		ecrc=		Enable/disable PCIe ECRC (transaction layer
>>>>   				end-to-end CRC checking).
>>>>   				bios: Use BIOS/firmware settings. This is the
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index b8357d7..37f8062 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -4946,11 +4946,13 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
>>>>   /**
>>>>    * pci_specified_resource_alignment - get resource alignment specified by user.
>>>>    * @dev: the PCI device to get
>>>> + * @resize: whether or not to change resources' size when reassigning alignment
>>>>    *
>>>>    * RETURNS: Resource alignment if it is specified.
>>>>    *          Zero if it is not specified.
>>>>    */
>>>> -static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>>>> +static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>>>> +		bool *resize)
>>>>   {
>>>>   	int seg, bus, slot, func, align_order, count;
>>>>   	unsigned short vendor, device, subsystem_vendor, subsystem_device;
>>>> @@ -4974,6 +4976,13 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>>>>   		} else {
>>>>   			align_order = -1;
>>>>   		}
>>>> +
>>>> +		if (!strncmp(p, "noresize@", 9)) {
>>>> +			*resize = false;
>>>> +			p += 9;
>>>> +		} else
>>>> +			*resize = true;
>>>> +
>>>>   		if (strncmp(p, "pci:", 4) == 0) {
>>>>   			/* PCI vendor/device (subvendor/subdevice) ids are specified */
>>>>   			p += 4;
>>>> @@ -5045,6 +5054,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>>>>   {
>>>>   	int i;
>>>>   	struct resource *r;
>>>> +	bool resize = true;
>>>>   	resource_size_t align, size;
>>>>   	u16 command;
>>>> @@ -5058,7 +5068,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>>>>   		return;
>>>>   	/* check if specified PCI is target device to reassign */
>>>> -	align = pci_specified_resource_alignment(dev);
>>>> +	align = pci_specified_resource_alignment(dev, &resize);
>>>>   	if (!align)
>>>>   		return;
>>>> @@ -5086,15 +5096,22 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>>>>   		}
>>>>   		size = resource_size(r);
>>>> -		if (size < align) {
>>>> -			size = align;
>>>> -			dev_info(&dev->dev,
>>>> -				"Rounding up size of resource #%d to %#llx.\n",
>>>> -				i, (unsigned long long)size);
>>>> +		if (resize) {
>>>> +			if (size < align) {
>>>> +				size = align;
>>>> +				dev_info(&dev->dev,
>>>> +					"Rounding up size of resource #%d to %#llx.\n",
>>>> +					i, (unsigned long long)size);
>>>> +			}
>>>> +			r->flags |= IORESOURCE_UNSET;
>>>> +			r->end = size - 1;
>>>> +			r->start = 0;
>>> Why do you want to keep this code that changes the size of the resource?
>>> Can't we just *always* use IORESOURCE_STARTALIGN as below?  It seems like
>>> that would potentially fix bugs, as you mention.
>>>
>>> I think it'd be better if we didn't change the size, even if the user
>>> didn't specify "noresize@".  We wouldn't even need the "noresize@" option
>>> then.
>>>
>>> Or is there some reason to keep the resize?  If it's just a question of
>>> being afraid to change the existing behavior because of the risk, I'm
>>> willing to take that risk.
>> Hi Bjorn,
>>
>> Thanks for your time. The reason is just like what you said.  I'm worried
>> that this may break the existing behavior.  I'll updated this patch as
>> you suggested.
> I guess one problem is that if we *don't* change the size, there's
> nothing to prevent something else from being allocated right after the
> resource.  For example, if we have a 1K BAR, and the objective is to
> make sure it's on a 4K page by itself, not only do we have to align
> the BAR on 4K, we *also* have to keep anything else from using the
> remaining 3K of that page.

In VFIO module, a dummy resource would be allocated into the
right after the resource which can make sure the BAR is on an exclusive
page.

If the resource_alignment is used for other purpose, it's true that
some other resources may be allocated into the right after the resource.
But I'm not sure whether we need to care about this in those cases.
It may be a problem when there are some existing applications
need this guarantee.

> Maybe it's easier to fix the drivers so they don't rely on the size.
> Do you have examples of such drivers?

ata/sata_sis.c:    (pci_resource_len(pdev, SIS_SCR_PCI_BAR) < 128))) {

> I'm hesitant to add a new option to the "pci=resource_alignment"
> parameter because it's already very complicated and it exposes more
> kernel internals than I'm really comfortable with.  If we can figure
> out a way to make the existing parameter work for everybody, I would
> prefer that.

If we can make sure the PCI driver only use pci_resource_len() to get
the BAR's length,  we can enhance this function to have an ability to
get the original length of the BAR so that we can still change resource's
size when using resource_alignment. For example, we can introduce an
addtional field to "struct resource::ori_lengh". In pci_resource_len(),
we do something like:

if (resource->ori_length)
     return resource->ori_length;

Thanks,
Yongji
