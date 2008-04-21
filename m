Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C342FDE2AD
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 03:45:03 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20080419110740.107700@gmx.net>
Subject: Re: [PATCH] [POWERPC] Port fixmap from x86 and use for kmap_atomic
References: <Pine.LNX.4.64.0804172156390.32124@blarg.am.freescale.net>
	<20080419110740.107700@gmx.net>
Message-Id: <0744A9B5-A855-440A-A833-F0BA45FEE179@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Mon, 21 Apr 2008 12:44:55 -0500
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 19, 2008, at 6:07 AM, Gerhard Pircher wrote:
>
> -------- Original-Nachricht --------
>> Datum: Thu, 17 Apr 2008 21:57:05 -0500 (CDT)
>> Von: Kumar Gala <galak@kernel.crashing.org>
>> An: Paul Mackerras <paulus@samba.org>
>> CC: linuxppc-dev@ozlabs.org
>> Betreff: [PATCH] [POWERPC] Port fixmap from x86 and use for  
>> kmap_atomic
>
>> The fixmap code from x86 allows us to have compile time virtual  
>> addresses
>> that we change the physical addresses of at run time.
> ...
>> +/*
>> + * Here we define all the compile-time 'special' virtual
>> + * addresses. The point is to have a constant address at
>> + * compile time, but to set the physical address only
>> + * in the boot process. We allocate these special addresses
>> + * from the end of virtual memory (0xfffff000) backwards.
>> + * Also this lets us do fail-safe vmalloc(), we
>> + * can guarantee that these special addresses and
>> + * vmalloc()-ed addresses never overlap.
> I don't understand how highmem works, but I'm just interested to  
> know, if
> this implementation could conflict somehow with the non coherent DMA
> implementation in dma-noncoherent.c (which uses address space from
> 0xff100000 to 0xff300000 for DMA memory).

if the size is fixed we can easily change it so the Kconfig options  
aren't needed anymore.

> On the other side could dma-noncoherent.c benefit from fixmaps so  
> that it
> isn't necessary to configure a start address for DMA allocations?

Its possible however the fixmap is all about keeping the VA the same  
while changing the PA. I think some work that is being done for the SW  
IOMMU might be more useful to your needs.

- k
