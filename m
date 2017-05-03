Return-Path: <rashmicy@gmail.com>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHnlf4tBMzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 16:08:30 +1000 (AEST)
Received: by mail-pf0-x234.google.com with SMTP id e64so7841224pfd.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 May 2017 23:08:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] v1 powerpc/powernv: Enable removal of memory for in
 memory tracing
To: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <20170428054227.9176-1-rashmica.g@gmail.com>
 <20170428054227.9176-2-rashmica.g@gmail.com>
 <c3b65fe7-37b2-6a87-1d81-966196b4ce20@linux.vnet.ibm.com>
 <1498ebd3-1239-9e5b-847c-920546443638@gmail.com>
From: Rashmica Gupta <rashmicy@gmail.com>
Message-ID: <94710510-15a7-baf3-1626-7736785a71aa@gmail.com>
Date: Wed, 3 May 2017 16:08:23 +1000
MIME-Version: 1.0
In-Reply-To: <1498ebd3-1239-9e5b-847c-920546443638@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/05/17 13:52, Rashmica Gupta wrote:
> On 28/04/17 19:52, Anshuman Khandual wrote:
> ....
>>> +static int check_memblock_online(struct memory_block *mem, void *arg)
>>> +{
>>> +    if (mem->state != MEM_ONLINE)
>>> +        return -1;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int change_memblock_state(struct memory_block *mem, void *arg)
>>> +{
>>> +    unsigned long state = (unsigned long)arg;
>>> +
>>> +    mem->state = state;
>>> +    return 0;
>>> +}
>>> +
>>> +static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 
>>> nr_pages)
>>> +{
>>> +    u64 end_pfn = start_pfn + nr_pages - 1;
>>> +
>>> +    if (walk_memory_range(start_pfn, end_pfn, NULL,
>>> +        check_memblock_online))
>>> +        return false;
>>> +
>>> +    walk_memory_range(start_pfn, end_pfn, (void *)MEM_GOING_OFFLINE,
>>> +              change_memblock_state);
>>> +
>> walk_memory_range() might be expensive, cant we just change the state
>> to MEM_GOING_OFFLINE while checking the state for MEM_ONLINE during
>> the first loop and bail out if any of the memblock is not in MEM_ONLINE
>> in the first place.
>
> Good idea.
>

This is assuming that it's more likely that the state of memory will be 
MEM_ONLINE rather than anything else (if the state isn't MEM_ONLINE we 
will still have to do a second call of walk_memory_range() to revert the 
state of any memory blocks that we changed). Seems like a reasonable 
assumption to me, thoughts?
