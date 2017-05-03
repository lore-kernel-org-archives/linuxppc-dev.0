Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHwpj47ngzDqCf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 21:26:37 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v43BOMXc072826
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 May 2017 07:26:34 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a7b7f0u9p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 May 2017 07:26:34 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 3 May 2017 21:26:31 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v43BQKY24325666
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 May 2017 21:26:28 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v43BPtXu011954
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 May 2017 21:25:55 +1000
Subject: Re: [PATCH 2/2] v1 powerpc/powernv: Enable removal of memory for in
 memory tracing
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170428054227.9176-1-rashmica.g@gmail.com>
 <20170428054227.9176-2-rashmica.g@gmail.com>
 <c3b65fe7-37b2-6a87-1d81-966196b4ce20@linux.vnet.ibm.com>
 <1498ebd3-1239-9e5b-847c-920546443638@gmail.com>
 <94710510-15a7-baf3-1626-7736785a71aa@gmail.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 3 May 2017 16:55:38 +0530
MIME-Version: 1.0
In-Reply-To: <94710510-15a7-baf3-1626-7736785a71aa@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <6d200f03-b6bb-b97a-220d-5472d6071aa6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2017 11:38 AM, Rashmica Gupta wrote:
> 
> 
> On 03/05/17 13:52, Rashmica Gupta wrote:
>> On 28/04/17 19:52, Anshuman Khandual wrote:
>> ....
>>>> +static int check_memblock_online(struct memory_block *mem, void *arg)
>>>> +{
>>>> +    if (mem->state != MEM_ONLINE)
>>>> +        return -1;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int change_memblock_state(struct memory_block *mem, void *arg)
>>>> +{
>>>> +    unsigned long state = (unsigned long)arg;
>>>> +
>>>> +    mem->state = state;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64
>>>> nr_pages)
>>>> +{
>>>> +    u64 end_pfn = start_pfn + nr_pages - 1;
>>>> +
>>>> +    if (walk_memory_range(start_pfn, end_pfn, NULL,
>>>> +        check_memblock_online))
>>>> +        return false;
>>>> +
>>>> +    walk_memory_range(start_pfn, end_pfn, (void *)MEM_GOING_OFFLINE,
>>>> +              change_memblock_state);
>>>> +
>>> walk_memory_range() might be expensive, cant we just change the state
>>> to MEM_GOING_OFFLINE while checking the state for MEM_ONLINE during
>>> the first loop and bail out if any of the memblock is not in MEM_ONLINE
>>> in the first place.
>>
>> Good idea.
>>
> 
> This is assuming that it's more likely that the state of memory will be
> MEM_ONLINE rather than anything else (if the state isn't MEM_ONLINE we
> will still have to do a second call of walk_memory_range() to revert the
> state of any memory blocks that we changed). Seems like a reasonable
> assumption to me, thoughts?

Revert the state of memory blocks that we changed till the point we
discover that something is not MEM_ONLINE and when we decide to abort.
In that case we have to remember all the changes we have done till
that point for us to revert back. Lets keep it as it is.
