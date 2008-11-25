Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id D1061DDE19
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 04:05:35 +1100 (EST)
In-Reply-To: <1227571828.20022.5.camel@localhost>
References: <4b6790c7a989dce8c200000687275224@bga.com>
	<84e16946c1ed4b782568f6492931512a@bga.com>
	<200811141609.44161.hollisb@us.ibm.com>
	<1227557235.17746.25.camel@localhost.localdomain>
	<1227571828.20022.5.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e46a947625709d642a08e101e70b1e24@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
Date: Tue, 25 Nov 2008 11:10:38 -0600
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Wolfgang Denk <wd@denx.de>,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 24, 2008, at 6:10 PM, Michael Ellerman wrote:
> On Mon, 2008-11-24 at 14:07 -0600, Hollis Blanchard wrote:
>> On Fri, 2008-11-14 at 16:09 -0600, Hollis Blanchard wrote:
>>>
>>> If this is all too much, then I'm close to giving up and burning a
>>> 64KB page, which requires only ALIGN_DOWN() in the kernel.
>>
>> ppc: force memory size to be a multiple of PAGE_SIZE
>>
>> Ensure that total memory size is page-aligned, because otherwise
>> bootmem.c gets upset.
>>
>> This error case was triggered by using 64 KiB pages in the kernel 
>> while
>> arch/powerpc/boot/4xx.c arbitrarily reduced the amount of memory by 
>> 4096 (to
>> work around the "CHIP11" errata which affects the last 256 bytes of 
>> physical memory).
>>
>> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
>> ---
>> This is on a common code path, and lmb_enforce_memory_limit() will now
>> always take action, so wider testing would be good.
>>
>> This patch supercedes http://patchwork.ozlabs.org/patch/8211/ .
>>
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -1200,6 +1200,11 @@ void __init early_init_devtree(void *par
>>  	early_reserve_mem();
>>  	phyp_dump_reserve_mem();
>>
>> +	/* Ensure that total memory size is page-aligned, because otherwise
>> +	 * bootmem.c gets upset. */
>> +	lmb_analyze();
>> +	memory_limit = lmb_phys_mem_size() & PAGE_MASK;
>
> All of the current code using memory_limit looks like it'll be safe 
> with
> this change, although there are several cases of this we could remove:
>
> if (memory_limit && <some other condition>)
>
> Because memory_limit will now always be true.

memory_limit was the result of parsing mem= from the command line.   
Does this break that?

>
> Still, I think it would be better to only set memory_limit when the mem
> size is not a multiple of the PAGE_SIZE - so that memory_limit retains
> it's function as both the value of the limit and a boolean.

I would have expected this trimming to occur where we actually transfer 
the memory from lmb to bootmem, since it is bootmem that has the 
aligned size requirement.

milton
