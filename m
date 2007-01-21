Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 929B8DDE27
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Jan 2007 06:54:23 +1100 (EST)
Date: Sun, 21 Jan 2007 11:47:40 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Alexis Berlemont <berlemont.hauw@free.fr>
Subject: Re: Howto use PPC4xx memory to memory DMA
Message-ID: <20070121194740.GA6339@gate.ebshome.net>
References: <200701192332.05156.berlemont.hauw@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200701192332.05156.berlemont.hauw@free.fr>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jan 19, 2007 at 11:32:04PM +0100, Alexis Berlemont wrote:
> Hi,
> 
> I would like to add some comments on this topic, I am very interested by more 
> details.
> 
> > Here are a few things to check:
> >
> > 1. Your memory destination and source addresses are contiguous. You can get
> > this using something like:
> >
> > mem = (void*)__get_free_pages(GFP_KERNEL | GFP_DMA, get_order(size));
> >
> > 2. Your source and dest addresses are _bus_ addresses. You can get these
> > by:
> >
> > source = virt_to_bus((u32 *)mem);
> 
> But you must check that your src and dst addresses does not point to 
> a "vmallocated" buffer (unless you allocated less than PAGE_SIZE and you know 
> how to convert a virtual kernel address into a physical address, for example 
> thanks to the function iopa() ). 
> Consequently, with a 2.6 kernel, the function virt_to_bus() will not work 
> properly on a virtual address.
> 
> Consequently, if the dst or the src address belongs to a buffer allocated with 
> vmalloc() or ioremap(), you will have to use the function iopa() to perform 
> the translation.
> 
> Besides, I have a question : I do not understand why the 2.6 implementation of 
> the function virt_to_bus() is different from the 2.4 version; 
> ->on 2.4, virt_to_bus() calls iopa() (if CONFIG_PPC4xx is defined),therefore 
> it works with virtual addresses (vmallocated or ioremapped);
> ->on 2.6, virt_to_bus works with logical address (kmallocated or 
> get_free_pages);
> 
> Do you know why ?

virt_to_bus was never supposed to work on anything else except for 
directly mapped kernel address. 2.6 version just fixes this for 4xx. 
And yes, virt_to_bus is deprecated.


> 
> > Ooh - and the 3d thing - cache coherence. I.e.:
> >
> >       dma_cache_inv((u32)mem, (u32)nBytes);
> >
> 
> I just add a little precision:
> 
> With PPC405 (no cache coherency integrated), you have to invalidate the cache 
> of the destination buffer (with dma_cache_inv() )and you have to write back 
> the cache of the source buffer (with dma_cache_wback() ). But if you do not 
> want to care about the direction point, you can use dma_cache_inv_wback() 
> which does both operations.
> 
> Of course, if you work with an "ioremapped" area (either as source or 
> destination buffer), this functions are useless for this buffer (ioremap() 
> maps the address range with the flag "PAGE_NO_CACHE").

Guys, please stop reinventing the wheel. There is a documented kernel 
API which takes care of coherency issues and it should be used for any 
sort of DMA (be it general purpose DMA controller or external 
DMA-capable device).

PLEASE, read Documentation/DMA-API.txt and use it to obtain DMA-able 
address for your buffer.

-- 
Eugene
