Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8F6CDDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 04:40:21 +1100 (EST)
Message-ID: <49945EFE.8000401@emcraft.com>
Date: Thu, 12 Feb 2009 20:40:14 +0300
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: rework dma-noncoherent to use generic vmap/vunmap
	functions
References: <1231505915-16082-1-git-send-email-yanok@emcraft.com>
	<1233722625.16867.249.camel@pasglop>
In-Reply-To: <1233722625.16867.249.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

excuse me for so long time to reply.

Benjamin Herrenschmidt wrote:
>> This patch rewrites consistent dma allocations support to use vmalloc
>> layer to allocate virtual memory space from vmalloc pool and get rid
>> of CONFIG_CONSISTENT_{START,SIZE}.
>>     
>
> So as commented before, please drop the defconfig updates.
>   

Ok.

>> -/*
>>   * Allocate DMA-coherent memory space and return both the kernel remapped
>>   * virtual and bus address for that space.
>>   */
>> @@ -151,19 +41,17 @@ void *
>>  __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
>>  {
>>  	struct page *page;
>> -	struct vm_region *c;
>>  	unsigned long order;
>> +	void *v;
>> +	int i;
>> +	struct page *pages[PAGE_ALIGN(size)>>PAGE_SHIFT];
>>     
>
> I'm not -too- fan of that page list one the stack up there.
>
> I understand why you don't wantto kmalloc something here etc... but
> that's what __vmalloc_area() does and it's somewhat useful to keep track
> of the page array that way, it might prove handy in the future.
>   

I don't like array being on stack too... But I fear I didn't understand
what were you talking about here...
__vmalloc_area does kmalloc or vmalloc to allocate pages array and then
allocates pages one by one but we need physically contiguous pages
here... (And that is why we don't really need to store pages array)
So I just added kmalloc/vmalloc to allocate the pages array and stored
it in vm_struct structure.

> Might even be worth adding a generic patch to add a VM_COHERENT_DMA flag
> so they can be listed as such and make sure you set the "caller" field
> yourself with your own caller.
>   
I used __builtin_return_address(1) as the 'caller' so I get useful
output in /proc/vmallocinfo (btw, ioremap doesn't provide useful 'caller').
Do you think we have high chances of such a patch being accepted in
lkml? Well, I'll try to do this (for now I stick with VM_IOREMAP).

> (Hint: look at the output of /proc/vmallocinfo)
>
> Also, the mucking around with PG_Reserved shouldn't be of any use
> anymore.
>   
Ok, removed.

Please review the updated patch (I'll post it as a followup).

Regards, Ilya.
