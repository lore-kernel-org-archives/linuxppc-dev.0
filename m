Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A668E14008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 01:14:14 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 26 Mar 2014 19:44:09 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 231C4394004C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 19:44:08 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2QEEBps56229954
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 19:44:11 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2QEE6ii015704
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 19:44:06 +0530
Message-ID: <5332E0AE.9040304@linux.vnet.ibm.com>
Date: Wed, 26 Mar 2014 19:44:06 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH v2] powerpc/powernv: Platform dump interface
References: <20140116121411.624.55662.stgit@hegdevasant.in.ibm.com>
 <20140209082034.0329833d@kryten>	<52FB8CC6.2010005@linux.vnet.ibm.com>
 <20140325165243.22c0109d@kryten>
In-Reply-To: <20140325165243.22c0109d@kryten>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/25/2014 11:22 AM, Anton Blanchard wrote:
> Hi Vasant,
>
>> On 02/09/2014 02:50 AM, Anton Blanchard wrote:
>>>
>>> Hi Vasant,
>>>
>>>> +static void free_dump_sg_list(struct opal_sg_list *list)
>>>> +{
>>>> +	struct opal_sg_list *sg1;
>>>> +	while (list) {
>>>> +		sg1 = list->next;
>>>> +		kfree(list);
>>>> +		list = sg1;
>>>> +	}
>>>> +	list = NULL;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Build dump buffer scatter gather list
>>>> + */
>>>> +static struct opal_sg_list *dump_data_to_sglist(void)
>>>> +{
>>>> +	struct opal_sg_list *sg1, *list = NULL;
>>>> +	void *addr;
>>>> +	int64_t size;
>>>> +
>>>> +	addr = dump_record.buffer;
>>>> +	size = dump_record.size;
>>>> +
>>>> +	sg1 = kzalloc(PAGE_SIZE, GFP_KERNEL);
>>>> +	if (!sg1)
>>>> +		goto nomem;
>>>> +
>>>> +	list = sg1;
>>>> +	sg1->num_entries = 0;
>>>> +	while (size > 0) {
>>>> +		/* Translate virtual address to physical address
>>>> */
>>>> +		sg1->entry[sg1->num_entries].data =
>>>> +			(void *)(vmalloc_to_pfn(addr) <<
>>>> PAGE_SHIFT); +
>>>> +		if (size > PAGE_SIZE)
>>>> +			sg1->entry[sg1->num_entries].length =
>>>> PAGE_SIZE;
>>>> +		else
>>>> +			sg1->entry[sg1->num_entries].length =
>>>> size; +
>>>> +		sg1->num_entries++;
>>>> +		if (sg1->num_entries >= SG_ENTRIES_PER_NODE) {
>>>> +			sg1->next = kzalloc(PAGE_SIZE,
>>>> GFP_KERNEL);
>>>> +			if (!sg1->next)
>>>> +				goto nomem;
>>>> +
>>>> +			sg1 = sg1->next;
>>>> +			sg1->num_entries = 0;
>>>> +		}
>>>> +		addr += PAGE_SIZE;
>>>> +		size -= PAGE_SIZE;
>>>> +	}
>>>> +	return list;
>>>> +
>>>> +nomem:
>>>> +	pr_err("%s : Failed to allocate memory\n", __func__);
>>>> +	free_dump_sg_list(list);
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Translate sg list address to absolute
>>>> + */
>>>> +static void sglist_to_phy_addr(struct opal_sg_list *list)
>>>> +{
>>>> +	struct opal_sg_list *sg, *next;
>>>> +
>>>> +	for (sg = list; sg; sg = next) {
>>>> +		next = sg->next;
>>>> +		/* Don't translate NULL pointer for last entry */
>>>> +		if (sg->next)
>>>> +			sg->next = (struct opal_sg_list
>>>> *)__pa(sg->next);
>>>> +		else
>>>> +			sg->next = NULL;
>>>> +
>>>> +		/* Convert num_entries to length */
>>>> +		sg->num_entries =
>>>> +			sg->num_entries * sizeof(struct
>>>> opal_sg_entry) + 16;
>>>> +	}
>>>> +}
>>>> +
>>>> +static void free_dump_data_buf(void)
>>>> +{
>>>> +	vfree(dump_record.buffer);
>>>> +	dump_record.size = 0;
>>>> +}
>>>
>>
>> Anton,
>>
>>> This looks identical to the code in opal-flash.c. Considering how
>>> complicated it is, can we put it somewhere common?
>>
>> Thanks for the review.. Will look into it next week.
>

Anton,

> This doesn't appear to have been fixed in the version that went into
> next.
>

Stewart rewrote dump interface.. That set of patch went into next, not my 
original patch..
Yes.. SG list separation is not yet done.. Never got a chance to look into this 
one.. Will try to
do it soon.

-Vasant

> Anton
>
