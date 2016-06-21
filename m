Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYXWn6lGSzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:59:49 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L2wmPF103509
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:59:47 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n2cqtjvd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:59:47 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Tue, 21 Jun 2016 12:59:44 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5BC6E2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:59:41 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L2xfWn4719044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:59:41 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L2xe6S028106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:59:41 +1000
Subject: Re: [RESEND PATCH v2 2/4] PCI: Do not Use IORESOURCE_STARTALIGN to
 identify bridge resources
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1464846411-16895-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1464846411-16895-3-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160621015045.GB30307@localhost>
Cc: nikunj@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 linux-doc@vger.kernel.org, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 corbet@lwn.net, linux-kernel@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com,
 alex.williamson@redhat.com, paulus@samba.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Tue, 21 Jun 2016 10:59:51 +0800
MIME-Version: 1.0
In-Reply-To: <20160621015045.GB30307@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <522cb95b-349a-f34c-9930-9c3633b62419@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/6/21 9:50, Bjorn Helgaas wrote:

> On Thu, Jun 02, 2016 at 01:46:49PM +0800, Yongji Xie wrote:
>> Now we use the IORESOURCE_STARTALIGN to identify bridge resources
>> in __assign_resources_sorted(). That's quite fragile. We can't
>> make sure that the PCI devices' resources will not use
>> IORESOURCE_STARTALIGN any more.
> Can you explain this a little more?  I don't quite understand the
> problem.  Maybe you can give an example of the problem?

Now there are two kinds of additional resources in the list: bridge
resource and SR-IOV resource. Here we just want to fix the
additional alignment for bridge. But if SR-IOV resource get the
flag IORESOURCE_STARTALIGN which is not only for bridge, the
current check seems to be wrong. And kernel parameter
"resource_alignment" could set IORESOURCE_STARTALIGN for
SR-IOV resource with my next patch applied.

Thanks,
Yongji

>> In this patch, we try to use a more robust way to identify
>> bridge resources.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>>   drivers/pci/setup-bus.c |    9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 55641a3..216ddbc 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -390,6 +390,7 @@ static void __assign_resources_sorted(struct list_head *head,
>>   	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
>>   	unsigned long fail_type;
>>   	resource_size_t add_align, align;
>> +	int index;
>>   
>>   	/* Check if optional add_size is there */
>>   	if (!realloc_head || list_empty(realloc_head))
>> @@ -410,11 +411,13 @@ static void __assign_resources_sorted(struct list_head *head,
>>   
>>   		/*
>>   		 * There are two kinds of additional resources in the list:
>> -		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
>> -		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
>> +		 * 1. bridge resource
>> +		 * 2. SR-IOV resource
>>   		 * Here just fix the additional alignment for bridge
>>   		 */
>> -		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
>> +		index = dev_res->res - dev_res->dev->resource;
>> +		if (index < PCI_BRIDGE_RESOURCES ||
>> +			index > PCI_BRIDGE_RESOURCE_END)
> I think the code looks OK; at least, it seems to match the comment.
> I'd just like to understand the problem a little better.
>
>>   			continue;
>>   
>>   		add_align = get_res_add_align(realloc_head, dev_res->res);
>> -- 
>> 1.7.9.5
>>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
