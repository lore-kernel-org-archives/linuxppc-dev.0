Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj7Xc33jzzDqMc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 00:43:12 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7UEgCWI019621
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 10:43:10 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cntm0q4n0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 10:43:10 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Wed, 30 Aug 2017 10:43:08 -0400
Subject: Re: [PATCH] powerpc/pseries: Don't attempt to acquire drc during
 memory hot add for assigned lmbs
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <fc2ad536-a772-f006-43c4-1ddf6e296ebb@linux.vnet.ibm.com>
 <87bmmx3hr8.fsf@concordia.ellerman.id.au>
 <cad79893-3d1a-f2ea-892f-6481a22f261a@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 09:43:00 -0500
MIME-Version: 1.0
In-Reply-To: <cad79893-3d1a-f2ea-892f-6481a22f261a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <c2e6a370-b648-4a25-8fe8-2dad41dce5c8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/30/2017 09:35 AM, Nathan Fontenot wrote:
> On 08/29/2017 09:35 PM, Michael Ellerman wrote:
>> John Allen <jallen@linux.vnet.ibm.com> writes:
>>
>>> Check if an LMB is assigned before attempting to call dlpar_acquire_drc in
>>> order to avoid any unnecessary rtas calls. This substantially reduces the
>>> running time of memory hot add on lpars with large amounts of memory.
>>>
>>> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
>>> ---
>>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> index ca9b2f4..95cf2ff 100644
>>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> @@ -817,6 +817,9 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
>>>  		return -EINVAL;
>>>
>>>  	for (i = 0; i < num_lmbs && lmbs_to_add != lmbs_added; i++) {
>>> +		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
>>> +			continue;
>>> +
>>>  		rc = dlpar_acquire_drc(lmbs[i].drc_index);
>>>  		if (rc)
>>>  			continue;
>>
>> This doesn't build for me, see below. What compiler are you using to
>> test this?> 
>>   arch/powerpc/platforms/pseries/hotplug-memory.c: In function 'dlpar_memory':
>>   arch/powerpc/platforms/pseries/hotplug-memory.c:1081:2: error: 'rc' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>     return rc;
>>     ^
>>
> 
> I don't see this build failure either, looks like its time to update my
> compiler too.

This also builds for me. I'm using gcc version 4.8.5

> 
>> It's a bit confusing because you didn't modify that function, but the
>> function you did modify has been inlined into there.
>>
>> Possibly the compiler is wrong and we do always initialise rc, but it's
>> not clear at all.
>>
>> And it raises a bigger question, how is this supposed to actually work?
>>
>> If we go around the loop and find that something is already assigned:
>>
>> 	for (i = 0; i < num_lmbs && lmbs_to_add != lmbs_added; i++) {
>> 		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
>> 			continue;
>>                 ...
>> 		lmbs_added++;
>>                 ...
>>         }
>>
>> We don't increment lmbs_added, so at the end of the loop we will see
>> that lmbs_added is not equal to lmbs_to_add, and so we remove
>> everything:
> 
> There is a loop just before this code verifies there are enough
> LMBs available to satisfy the add request. This counts the number
> of LMBs that do not have the assigned flag set. This is where we
> update lmbs_available and if there are not enough lmbs available to
> satisfy the request, we bail.
> 
> When the loop you referenced above exits we should have attempted to
> enough LMBs to satisfy the request.
> 
>>
>> 	if (lmbs_added != lmbs_to_add) {
>> 		pr_err("Memory hot-add failed, removing any added LMBs\n");
>>
>> 		for (i = 0; i < num_lmbs; i++) {
>> 			if (!lmbs[i].reserved)
>> 				continue;
>>
>> 			rc = dlpar_remove_lmb(&lmbs[i]);
>>
>>
> 
> if we get into this recovery path, we only try to remove any LMBs
> that were added in the loop above. The code marks any LMB that is
> added as 'reserved' so that we only try to remove LMBs marked
> as 'reserved' in the cleanup path.
> 
>> So it seems like if we ever hit that continue you added, the whole
>> operation will fail anyway. So I'm confused.
> 
> The added code was to skip over any LMBs that are already assigned to
> the partition. As the code is written now, we walk through the entire list
> of LMBs possible. For large systems this can be tens, or hundreds of thousands
> of LMBs.
> 
> Without this check the code will try to acquire the drc for (this
> is done via rtas-set-indicator calls) which will fail for LMBs that are
> already assigned to the partition.
> 
> As an example on a large system that has 100,000 LMBs where the first
> 50,000 are assigned to the partition. When we get an add request to add
> X more LMBs we do see that there are 50,000 available to add. We then try
> to add X LMBs but start at the beginning of the LMB list when trying to
> add them. This results in 50,000 attempts to acquire the drc for LMbs
> that we already own. Instead we should just skip trying to acquire them.
> 
> Hopefully that helps clarify things.
> 
> -Nathan
> 
>>
>> cheers
>>
> 
