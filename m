Return-Path: <berlemont.hauw@free.fr>
Received: from fb2.tech.numericable.fr (fb2.tech.numericable.fr
	[82.216.111.50]) by ozlabs.org (Postfix) with ESMTP id 8351ADDE31
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 10:01:36 +1100 (EST)
Received: from smtp7.tech.numericable.fr (smtp7.nc.sdv.fr [10.0.0.95])
	by fb2.tech.numericable.fr (Postfix) with ESMTP id 6087E19D071
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 23:30:29 +0100 (CET)
Received: from [192.168.0.186] (abo-181-30-68.rns.modulonet.fr [85.68.30.181])
	by smtp7.tech.numericable.fr (Postfix) with ESMTP id 6CB8916381B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 23:30:23 +0100 (CET)
From: Alexis Berlemont <berlemont.hauw@free.fr>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto use PPC4xx memory to memory DMA
Date: Fri, 19 Jan 2007 23:32:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701192332.05156.berlemont.hauw@free.fr>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I would like to add some comments on this topic, I am very interested by more 
details.

> Here are a few things to check:
>
> 1. Your memory destination and source addresses are contiguous. You can get
> this using something like:
>
> mem = (void*)__get_free_pages(GFP_KERNEL | GFP_DMA, get_order(size));
>
> 2. Your source and dest addresses are _bus_ addresses. You can get these
> by:
>
> source = virt_to_bus((u32 *)mem);

But you must check that your src and dst addresses does not point to 
a "vmallocated" buffer (unless you allocated less than PAGE_SIZE and you know 
how to convert a virtual kernel address into a physical address, for example 
thanks to the function iopa() ). 
Consequently, with a 2.6 kernel, the function virt_to_bus() will not work 
properly on a virtual address.

Consequently, if the dst or the src address belongs to a buffer allocated with 
vmalloc() or ioremap(), you will have to use the function iopa() to perform 
the translation.

Besides, I have a question : I do not understand why the 2.6 implementation of 
the function virt_to_bus() is different from the 2.4 version; 
->on 2.4, virt_to_bus() calls iopa() (if CONFIG_PPC4xx is defined),therefore 
it works with virtual addresses (vmallocated or ioremapped);
->on 2.6, virt_to_bus works with logical address (kmallocated or 
get_free_pages);

Do you know why ?

> Ooh - and the 3d thing - cache coherence. I.e.:
>
>       dma_cache_inv((u32)mem, (u32)nBytes);
>

I just add a little precision:

With PPC405 (no cache coherency integrated), you have to invalidate the cache 
of the destination buffer (with dma_cache_inv() )and you have to write back 
the cache of the source buffer (with dma_cache_wback() ). But if you do not 
want to care about the direction point, you can use dma_cache_inv_wback() 
which does both operations.

Of course, if you work with an "ioremapped" area (either as source or 
destination buffer), this functions are useless for this buffer (ioremap() 
maps the address range with the flag "PAGE_NO_CACHE").

>
>
> Also, we had some trouble with the ppc4xx_ functions using 440 - it seems
> these functions are specific to the PLB4. So if you are trying to do DMA on
> say the PLB peripheral bus on a memory mapped device, you definitely have
> some trouble.

I do not understand, I would be very interested by what kind of trouble you 
had to cope with.

Alexis.
