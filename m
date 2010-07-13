Return-Path: <nfont@austin.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C7B0BB6F06
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 01:59:53 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6DFhm1v030611
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 11:43:48 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6DFxodi091182
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 11:59:50 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6DFxnAD028973
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 11:59:49 -0400
Message-ID: <4C3C8D75.5000409@austin.ibm.com>
Date: Tue, 13 Jul 2010 10:59:49 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/7] Split the memory_block structure
References: <4C3B3446.5090302@austin.ibm.com> <4C3B37CE.50802@austin.ibm.com>
	<4C3C718C.6080402@linux.vnet.ibm.com>
In-Reply-To: <4C3C718C.6080402@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/13/2010 09:00 AM, Brian King wrote:
> On 07/12/2010 10:42 AM, Nathan Fontenot wrote:
>> @@ -123,13 +130,20 @@
>>  static ssize_t show_mem_removable(struct sys_device *dev,
>>  			struct sysdev_attribute *attr, char *buf)
>>  {
>> -	unsigned long start_pfn;
>> -	int ret;
>> -	struct memory_block *mem =
>> -		container_of(dev, struct memory_block, sysdev);
>> +	struct list_head *pos, *tmp;
>> +	struct memory_block *mem;
>> +	int ret = 1;
>> +
>> +	mem = container_of(dev, struct memory_block, sysdev);
>> +	list_for_each_safe(pos, tmp, &mem->sections) {
>> +		struct memory_block_section *mbs;
>> +		unsigned long start_pfn;
>> +
>> +		mbs = list_entry(pos, struct memory_block_section, next);
>> +		start_pfn = section_nr_to_pfn(mbs->phys_index);
>> +		ret &= is_mem_section_removable(start_pfn, PAGES_PER_SECTION);
>> +	}
> 
> I don't see you deleting anyting from the list in this loop. Why do you need
> to use list_for_each_safe? That won't protect you if someone else is messing
> with the list.

Yes, Kame pointed this out too.  I think I'll need to update the patches to
always take the mutex when walking the list and use list_for_each_entry

> 
>>
>> -	start_pfn = section_nr_to_pfn(mem->phys_index);
>> -	ret = is_mem_section_removable(start_pfn, PAGES_PER_SECTION);
>>  	return sprintf(buf, "%d\n", ret);
>>  }
>>
> 
> 
>> @@ -238,19 +252,40 @@
>>  static int memory_block_change_state(struct memory_block *mem,
>>  		unsigned long to_state, unsigned long from_state_req)
>>  {
>> +	struct memory_block_section *mbs;
>> +	struct list_head *pos;
>>  	int ret = 0;
>> +
>>  	mutex_lock(&mem->state_mutex);
>>
>> -	if (mem->state != from_state_req) {
>> -		ret = -EINVAL;
>> -		goto out;
>> +	list_for_each(pos, &mem->sections) {
>> +		mbs = list_entry(pos, struct memory_block_section, next);
>> +
>> +		if (mbs->state != from_state_req)
>> +			continue;
>> +
>> +		ret = memory_block_action(mbs, to_state);
>> +		if (ret)
>> +			break;
>> +	}
> 
> Would it be better here to loop through all the sections and ensure they
> are in the proper state first before starting to change the state of any
> of them? Then you could easily return -EINVAL if one or more is in
> the incorrect state and wouldn't need to the code below.

The code below is needed in cases where the add/remove of one of the
memory_block_sections fails.  The code can then return all of the
memory_block_sections in the memory_block to the original state.

> 
>> +	if (ret) {
>> +		list_for_each(pos, &mem->sections) {
>> +			mbs = list_entry(pos, struct memory_block_section,
>> +					 next);
>> +
>> +			if (mbs->state == from_state_req)
>> +				continue;
>> +
>> +			if (memory_block_action(mbs, to_state))
>> +				printk(KERN_ERR "Could not re-enable memory "
>> +				       "section %lx\n", mbs->phys_index);
>> +		}
>>  	}
>>
>> -	ret = memory_block_action(mem, to_state);
>>  	if (!ret)
>>  		mem->state = to_state;
>>
>> -out:
>>  	mutex_unlock(&mem->state_mutex);
>>  	return ret;
>>  }
> 
> 
>> @@ -498,19 +496,97 @@
>>
>>  	return mem;
>>  }
>> +static int add_mem_block_section(struct memory_block *mem,
>> +				 int section_nr, unsigned long state)
>> +{
>> +	struct memory_block_section *mbs;
>> +
>> +	mbs = kzalloc(sizeof(*mbs), GFP_KERNEL);
>> +	if (!mbs)
>> +		return -ENOMEM;
>> +
>> +	mbs->phys_index = section_nr;
>> +	mbs->state = state;
>> +
>> +	list_add(&mbs->next, &mem->sections);
> 
> I don't think there is sufficient protection for this list. Don't we
> need to be holding a lock of some sort when adding/deleting/iterating
> through this list? 

You're right.  we should be holding the mutex.

I think there are a couple other places that I missed with this.  I'll fix
it for a v2 of the patches.

> 
>> +	return 0;
>> +}
> 
