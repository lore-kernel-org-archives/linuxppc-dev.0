Return-Path: <david@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Ktw02t87zF116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 20:09:36 +1000 (AEST)
Subject: Re: [PATCH v2 5/6] powerpc/powernv: hold device_hotplug_lock when
 calling memtrace_offline_pages()
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
 devel@linuxdriverproject.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Rashmica Gupta <rashmica.g@gmail.com>, Michael Neuling <mikey@neuling.org>
References: <20180925091457.28651-1-david@redhat.com>
 <20180925091457.28651-6-david@redhat.com> <20180925121504.GH8537@350D>
From: David Hildenbrand <david@redhat.com>
Message-ID: <19de0a52-2abd-6e79-1b8e-dcf17eff3fba@redhat.com>
Date: Wed, 26 Sep 2018 12:09:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180925121504.GH8537@350D>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/09/2018 14:15, Balbir Singh wrote:
> On Tue, Sep 25, 2018 at 11:14:56AM +0200, David Hildenbrand wrote:
>> Let's perform all checking + offlining + removing under
>> device_hotplug_lock, so nobody can mess with these devices via
>> sysfs concurrently.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Rashmica Gupta <rashmica.g@gmail.com>
>> Cc: Balbir Singh <bsingharora@gmail.com>
>> Cc: Michael Neuling <mikey@neuling.org>
>> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
>> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  arch/powerpc/platforms/powernv/memtrace.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
>> index fdd48f1a39f7..d84d09c56af9 100644
>> --- a/arch/powerpc/platforms/powernv/memtrace.c
>> +++ b/arch/powerpc/platforms/powernv/memtrace.c
>> @@ -70,6 +70,7 @@ static int change_memblock_state(struct memory_block *mem, void *arg)
>>  	return 0;
>>  }
>>  
>> +/* called with device_hotplug_lock held */
>>  static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
>>  {
>>  	u64 end_pfn = start_pfn + nr_pages - 1;
>> @@ -111,6 +112,7 @@ static u64 memtrace_alloc_node(u32 nid, u64 size)
>>  	end_pfn = round_down(end_pfn - nr_pages, nr_pages);
>>  
>>  	for (base_pfn = end_pfn; base_pfn > start_pfn; base_pfn -= nr_pages) {
>> +		lock_device_hotplug();
> 
> Why not grab the lock before the for loop? That way we can avoid bad cases like a
> large node being scanned for a small number of pages (nr_pages). Ideally we need
> a cond_resched() in the loop, but I guess offline_pages() has one.

Yes, it does.

I can move it out of the loop, thanks!

> 
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> 


-- 

Thanks,

David / dhildenb
