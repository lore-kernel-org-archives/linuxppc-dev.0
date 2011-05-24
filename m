Return-Path: <andre.schwarz@matrix-vision.de>
Received: from mail2.matrix-vision.com (mail2.matrix-vision.com
	[85.214.244.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "template", Issuer "template" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CD36CB6FAC
	for <linuxppc-dev@ozlabs.org>; Tue, 24 May 2011 20:02:53 +1000 (EST)
Message-ID: <4DDB8248.8010406@matrix-vision.de>
Date: Tue, 24 May 2011 12:02:48 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: PCI DMA to user mem on mpc83xx
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AD4B@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD4B@saturn3.aculab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David,

>> we have a pretty old PCI device driver here that needs some
>> basic rework running on 2.6.27 on several MPC83xx.
>> It's a simple char-device with "give me some data" implemented
>> using read() resulting in zero-copy DMA to user mem.
>>
>> There's get_user_pages() working under the hood along with
>> SetPageDirty() and page_cache_release().
> Does that dma use the userspace virtual address, or the
> physical address - or are you remapping the user memory into
> kernel address space.

no mapping at all AFAIK.

I'm using get_user_pages() followed by allocation of a struct 
scatterlist being filled with sg_set_page().
After the transfer the pages are marked dirty using SetPageDirty().

> If the memory is remapped into the kernel address space, the
> cost of the mmu and tlb operations (especially on MP systems)
> is such that a dma to kernel memory followed by copyout/copytouser
> may well be faster!
no mapping.

> That may even be the case even if the dma is writing to the
> user virtual (or physical) addresses when it is only
> necessary to ensure the memory page is resident and that
> the caches are coherent.
All I need is physical addresses of user mem.
Since the allocating user driver is using mlock() and there's no swap I 
expect to be safe ... is this a stupid assumption ?
> In any case the second copy is probably far faster than the
> PCI one!
huh - I observed memcpy() to be very expensive (at least on 83xx PowerPC).
> I've recently written driver that supports a pread/pwrite interface
> to the memory windows on a PCIe card. It was important to use
> dma for the PCIe transfers (to get a sensible transfer size).
> I overlapped the copyin/copyout with the next dma transfer.
> The dma's are fast enough that it is worth spinning waiting
> for completion - but slow enough to make the overlapped
> operation worthwhile (same speed as a single word pio transfer).


Thanks for your feedback.


Cheers,
André


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
