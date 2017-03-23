Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vq3C05T9xzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 10:47:56 +1100 (AEDT)
Subject: Re: [v1 0/5] parallelized "struct page" zeroing
To: David Miller <davem@davemloft.net>, willy@infradead.org
References: <1490310113-824438-1-git-send-email-pasha.tatashin@oracle.com>
 <20170323232638.GB29134@bombadil.infradead.org>
 <20170323.163520.123614131649571916.davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.or
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <c399ad8b-32d8-09d7-bb47-dd6bc528b133@oracle.com>
Date: Thu, 23 Mar 2017 19:47:23 -0400
MIME-Version: 1.0
In-Reply-To: <20170323.163520.123614131649571916.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/23/2017 07:35 PM, David Miller wrote:
> From: Matthew Wilcox <willy@infradead.org>
> Date: Thu, 23 Mar 2017 16:26:38 -0700
>
>> On Thu, Mar 23, 2017 at 07:01:48PM -0400, Pavel Tatashin wrote:
>>> When deferred struct page initialization feature is enabled, we get a
>>> performance gain of initializing vmemmap in parallel after other CPUs are
>>> started. However, we still zero the memory for vmemmap using one boot CPU.
>>> This patch-set fixes the memset-zeroing limitation by deferring it as well.
>>>
>>> Here is example performance gain on SPARC with 32T:
>>> base
>>> https://hastebin.com/ozanelatat.go
>>>
>>> fix
>>> https://hastebin.com/utonawukof.go
>>>
>>> As you can see without the fix it takes: 97.89s to boot
>>> With the fix it takes: 46.91 to boot.
>>
>> How long does it take if we just don't zero this memory at all?  We seem
>> to be initialising most of struct page in __init_single_page(), so it
>> seems like a lot of additional complexity to conditionally zero the rest
>> of struct page.
>
> Alternatively, just zero out the entire vmemmap area when it is setup
> in the kernel page tables.

Hi Dave,

I can do this, either way is fine with me. It would be a little slower 
compared to the current approach where we benefit from having memset() 
to work as prefetch. But that would become negligible, once in the 
future we will increase the granularity of multi-threading, currently it 
is only one thread per-mnode to multithread vmemamp. Your call.

Thank  you,
Pasha
