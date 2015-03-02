Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F0BD1A0196
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 18:33:43 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 2 Mar 2015 17:33:42 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B02DA2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 18:33:38 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t227XTxb21954618
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 18:33:38 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t227X3NV002335
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 18:33:04 +1100
Date: Mon, 2 Mar 2015 15:32:47 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 10/21] PCI: Consider additional PF's IOV BAR
 alignment in sizing and assigning
Message-ID: <20150302073247.GE21571@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083406.32124.65957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224084152.GG6220@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150224084152.GG6220@google.com>
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

On Tue, Feb 24, 2015 at 02:41:52AM -0600, Bjorn Helgaas wrote:
>On Tue, Feb 24, 2015 at 02:34:06AM -0600, Bjorn Helgaas wrote:
>> From: Wei Yang <weiyang@linux.vnet.ibm.com>
>> 
>> When sizing and assigning resources, we divide the resources into two
>> lists: the requested list and the additional list.  We don't consider the
>> alignment of additional VF(n) BAR space.
>> 
>> This is reasonable because the alignment required for the VF(n) BAR space
>> is the size of an individual VF BAR, not the size of the space for *all*
>> VFs.  But some platforms, e.g., PowerNV, require additional alignment.
>> 
>> Consider the additional IOV BAR alignment when sizing and assigning
>> resources.  When there is not enough system MMIO space, the PF's IOV BAR
>> alignment will not contribute to the bridge.  When there is enough system
>> MMIO space, the additional alignment will contribute to the bridge.
>
>I don't understand the ""when there is not enough system MMIO space" part.
>How do we tell if there's enough MMIO space?
>

In __assign_resources_sorted(), it has two resources list, one for requested
(head) and one for additional (realloc_head). This function will first try to
combine them and assign. If failed, this means we don't have enough MMIO
space.

>> Also, take advantage of pci_dev_resource::min_align to store this
>> additional alignment.
>
>This comment doesn't seem to make sense; this patch doesn't save anything
>in min_align.
>

At the end of this patch:

   add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);

The add_align is stored in pci_dev_resource::min_align in add_to_list(). And
retrieved by get_res_add_align() in below code. This field is not used
previously, so I took advantage of this field to store the alignment of the
additional resources.

>Another question below...
>
>> [bhelgaas: changelog, printk cast]
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  drivers/pci/setup-bus.c |   83 ++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 70 insertions(+), 13 deletions(-)
>> 
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index e3e17f3c0f0f..affbceae560f 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -99,8 +99,8 @@ static void remove_from_list(struct list_head *head,
>>  	}
>>  }
>>  
>> -static resource_size_t get_res_add_size(struct list_head *head,
>> -					struct resource *res)
>> +static struct pci_dev_resource *res_to_dev_res(struct list_head *head,
>> +					       struct resource *res)
>>  {
>>  	struct pci_dev_resource *dev_res;
>>  
>> @@ -109,17 +109,37 @@ static resource_size_t get_res_add_size(struct list_head *head,
>>  			int idx = res - &dev_res->dev->resource[0];
>>  
>>  			dev_printk(KERN_DEBUG, &dev_res->dev->dev,
>> -				 "res[%d]=%pR get_res_add_size add_size %llx\n",
>> +				 "res[%d]=%pR res_to_dev_res add_size %llx min_align %llx\n",
>>  				 idx, dev_res->res,
>> -				 (unsigned long long)dev_res->add_size);
>> +				 (unsigned long long)dev_res->add_size,
>> +				 (unsigned long long)dev_res->min_align);
>>  
>> -			return dev_res->add_size;
>> +			return dev_res;
>>  		}
>>  	}
>>  
>> -	return 0;
>> +	return NULL;
>> +}
>> +
>> +static resource_size_t get_res_add_size(struct list_head *head,
>> +					struct resource *res)
>> +{
>> +	struct pci_dev_resource *dev_res;
>> +
>> +	dev_res = res_to_dev_res(head, res);
>> +	return dev_res ? dev_res->add_size : 0;
>> +}
>> +
>> +static resource_size_t get_res_add_align(struct list_head *head,
>> +					 struct resource *res)
>> +{
>> +	struct pci_dev_resource *dev_res;
>> +
>> +	dev_res = res_to_dev_res(head, res);
>> +	return dev_res ? dev_res->min_align : 0;
>>  }
>>  
>> +
>>  /* Sort resources by alignment */
>>  static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
>>  {
>> @@ -368,8 +388,9 @@ static void __assign_resources_sorted(struct list_head *head,
>>  	LIST_HEAD(save_head);
>>  	LIST_HEAD(local_fail_head);
>>  	struct pci_dev_resource *save_res;
>> -	struct pci_dev_resource *dev_res, *tmp_res;
>> +	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
>>  	unsigned long fail_type;
>> +	resource_size_t add_align, align;
>>  
>>  	/* Check if optional add_size is there */
>>  	if (!realloc_head || list_empty(realloc_head))
>> @@ -384,10 +405,38 @@ static void __assign_resources_sorted(struct list_head *head,
>>  	}
>>  
>>  	/* Update res in head list with add_size in realloc_head list */
>> -	list_for_each_entry(dev_res, head, list)
>> +	list_for_each_entry_safe(dev_res, tmp_res, head, list) {
>>  		dev_res->res->end += get_res_add_size(realloc_head,
>>  							dev_res->res);
>>  
>> +		/*
>> +		 * There are two kinds of additional resources in the list:
>> +		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
>> +		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
>> +		 * Here just fix the additional alignment for bridge
>> +		 */
>> +		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
>> +			continue;
>> +
>> +		add_align = get_res_add_align(realloc_head, dev_res->res);
>> +
>> +		/* Reorder the list by their alignment */
>
>Why do we need to reorder the list by alignment?

Resource list "head" is sorted by the alignment, while the alignment would be
changed after we considering the additional resource.

Take powernv platform as an example. The IOV BAR is expanded and need to be
aligned with its total size instead of the individual VF BAR size. If we don't
reorder it, the IOV BAR would be assigned after some other resources, which
may cause the real assignment fail even the total size is enough.

>
>> +		if (add_align > dev_res->res->start) {
>> +			dev_res->res->start = add_align;
>> +			dev_res->res->end = add_align +
>> +				            resource_size(dev_res->res);
>> +
>> +			list_for_each_entry(dev_res2, head, list) {
>> +				align = pci_resource_alignment(dev_res2->dev,
>> +							       dev_res2->res);
>> +				if (add_align > align)
>> +					list_move_tail(&dev_res->list,
>> +						       &dev_res2->list);
>> +			}
>> +               }
>> +
>> +	}
>> +
>>  	/* Try updated head list with add_size added */
>>  	assign_requested_resources_sorted(head, &local_fail_head);
>>  
>> @@ -962,6 +1011,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>>  	struct resource *b_res = find_free_bus_resource(bus,
>>  					mask | IORESOURCE_PREFETCH, type);
>>  	resource_size_t children_add_size = 0;
>> +	resource_size_t children_add_align = 0;
>> +	resource_size_t add_align = 0;
>>  
>>  	if (!b_res)
>>  		return -ENOSPC;
>> @@ -986,6 +1037,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>>  			/* put SRIOV requested res to the optional list */
>>  			if (realloc_head && i >= PCI_IOV_RESOURCES &&
>>  					i <= PCI_IOV_RESOURCE_END) {
>> +				add_align = max(pci_resource_alignment(dev, r), add_align);
>>  				r->end = r->start - 1;
>>  				add_to_list(realloc_head, dev, r, r_size, 0/* don't care */);
>>  				children_add_size += r_size;
>> @@ -1016,19 +1068,23 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>>  			if (order > max_order)
>>  				max_order = order;
>>  
>> -			if (realloc_head)
>> +			if (realloc_head) {
>>  				children_add_size += get_res_add_size(realloc_head, r);
>> +				children_add_align = get_res_add_align(realloc_head, r);
>> +				add_align = max(add_align, children_add_align);
>> +			}
>>  		}
>>  	}
>>  
>>  	min_align = calculate_mem_align(aligns, max_order);
>>  	min_align = max(min_align, window_alignment(bus, b_res->flags));
>>  	size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
>> +	add_align = max(min_align, add_align);
>>  	if (children_add_size > add_size)
>>  		add_size = children_add_size;
>>  	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
>>  		calculate_memsize(size, min_size, add_size,
>> -				resource_size(b_res), min_align);
>> +				resource_size(b_res), add_align);
>>  	if (!size0 && !size1) {
>>  		if (b_res->start || b_res->end)
>>  			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
>> @@ -1040,10 +1096,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>>  	b_res->end = size0 + min_align - 1;
>>  	b_res->flags |= IORESOURCE_STARTALIGN;
>>  	if (size1 > size0 && realloc_head) {
>> -		add_to_list(realloc_head, bus->self, b_res, size1-size0, min_align);
>> -		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window %pR to %pR add_size %llx\n",
>> +		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
>> +		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window %pR to %pR add_size %llx add_align %llx\n",
>>  			   b_res, &bus->busn_res,
>> -			   (unsigned long long)size1-size0);
>> +			   (unsigned long long) (size1 - size0),
>> +			   (unsigned long long) add_align);
>>  	}
>>  	return 0;
>>  }
>> 
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me
