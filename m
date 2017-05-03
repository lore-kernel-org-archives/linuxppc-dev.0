Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJ1hx4RRSzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 01:06:57 +1000 (AEST)
Subject: Re: [v2 3/5] mm: add "zero" argument to vmemmap allocators
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, willy@infradead.org
References: <1490383192-981017-1-git-send-email-pasha.tatashin@oracle.com>
 <1490383192-981017-4-git-send-email-pasha.tatashin@oracle.com>
 <20170503.103428.1598887340082574002.davem@davemloft.net>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <3921e0c8-2c18-60e9-cc99-78dbed2dce90@oracle.com>
Date: Wed, 3 May 2017 11:05:45 -0400
MIME-Version: 1.0
In-Reply-To: <20170503.103428.1598887340082574002.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dave,

Thank you for the review. I will address your comment and update patchset..

Pasha

On 05/03/2017 10:34 AM, David Miller wrote:
> From: Pavel Tatashin <pasha.tatashin@oracle.com>
> Date: Fri, 24 Mar 2017 15:19:50 -0400
> 
>> Allow clients to request non-zeroed memory from vmemmap allocator.
>> The following two public function have a new boolean argument called zero:
>>
>> __vmemmap_alloc_block_buf()
>> vmemmap_alloc_block()
>>
>> When zero is true, memory that is allocated by memblock allocator is zeroed
>> (the current behavior), when argument is false, the memory is not zeroed.
>>
>> This change allows for optimizations where client knows when it is better
>> to zero memory: may be later when other CPUs are started, or may be client
>> is going to set every byte in the allocated memory, so no need to zero
>> memory beforehand.
>>
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> 
> I think when you add a new argument that can adjust behavior, you
> should add the new argument but retain exactly the current behavior in
> the existing calls.
> 
> Then later you can piece by piece change behavior, and document properly
> in the commit message what is happening and why the transformation is
> legal.
> 
> Here, you are adding the new boolean to __earlyonly_bootmem_alloc() and
> then making sparse_mem_maps_populate_node() pass false, which changes
> behavior such that it doesn't get zero'd memory any more.
> 
> Please make one change at a time.  Otherwise review and bisection is
> going to be difficult.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
