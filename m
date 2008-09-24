Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E156EDDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 00:16:40 +1000 (EST)
Message-Id: <61059ECE-2B42-46B3-B5B3-E5CFA3A5EFC9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1222265583.4257.21.camel@johannes.berg>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: enforce sane MAX_ORDER
Date: Wed, 24 Sep 2008 09:16:35 -0500
References: <1222262654.4257.4.camel@johannes.berg>
	<B38CBE3A-B9DA-44BA-8646-AEE81FB82437@kernel.crashing.org>
	<1222265583.4257.21.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 24, 2008, at 9:13 AM, Johannes Berg wrote:

> On Wed, 2008-09-24 at 09:05 -0500, Kumar Gala wrote:
>
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -415,8 +415,11 @@ config PPC_64K_PAGES
>>>
>>> config FORCE_MAX_ZONEORDER
>>> 	int "Maximum zone order"
>>> +	range 9 999 if PPC_64K_PAGES
>>> 	default "9" if PPC_64K_PAGES
>>> +	range 13 999 if PPC64 && !PPC_64K_PAGES
>>> 	default "13" if PPC64 && !PPC_64K_PAGES
>>> +	range 11 999
>>> 	default "11"
>>> 	help
>>> 	  The kernel memory allocator divides physically contiguous memory
>>
>> Hope about setting the upper bound to 32 or 64.
>
> Works for me, I'm interested in the lower bound because if you set
> CONFIG_PM on a machine with dart iommu and set this to 9 then the  
> thing
> will BUG_ON during boot.
>
>> Since I believe this
>> in effect 2^FORCE_MAX_ZONEORDER, so 999 is just insane.
>
> Indeed it is, and no argument that it's insane. But it's not limited  
> at
> all right now, so you can in theory set it to 10000, write a kernel
> module that calls alloc_pages(1000) and have it fail because not  
> enough
> memory is available, rather than failing because of the MAX_ORDER  
> check.
>
>> I'd almost
>> prefer something like 16 since that might still be in the realm of
>> reasonable and able to work.
>
> with 4k pages that would be 256M memory, that seems well possible to
> allocate. Even 20 might still be possible (4G memory) if you  
> allocate it
> early enough at boot and have a lot of memory (on a 64-bit system).
>
> On the other hand, why bother limiting it? If people set it too  
> large in
> their config all that will happen is that it takes a bit longer to  
> fail
> to allocate such a ridiculous amount of memory.

We'll I'm ok with that, but I dont think we should be values that make  
no sense.  64 would seem the max even in a 64-bit system.

- k
