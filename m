Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 733BFB6F71
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 15:00:15 +1100 (EST)
Message-ID: <1322712006.3729.14.camel@pasglop>
Subject: Re: lmb_alloc() and page memory overlap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Prashant Bhole <prashantsmailcenter@gmail.com>
Date: Thu, 01 Dec 2011 15:00:06 +1100
In-Reply-To: <CAD6p20evHeESH1UwpB4rg8NTxndAtQW9C1S1bpJWFLmS-rOu5w@mail.gmail.com>
References: <CAD6p20evHeESH1UwpB4rg8NTxndAtQW9C1S1bpJWFLmS-rOu5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-29 at 18:51 +0530, Prashant Bhole wrote:
> Hi,
> I am using custom 460ex board with kernel version 2.6.30.
> I noticed that page_alloc() is returning a page whose memory
> is already allocated by lmb_alloc() while unflattening the device
> tree. As per my knowledge the memory allocated by lmb_alloc()
> should be reserved till the end, right?

This should have been fixed in memblock in recent kernel, at least I
believe it is. It looks like this is caused by overlapping lmb_reserve()
at boot (or lmb_reserve() overlapping an lmb_alloc'ated region which
boils down to the same thing).

Old lmb didn't deal with that well at all and that lead to corruption of
the lmb list. We fixed that in

8f7a66051b7523108c5aefb08c6a637e54aedc47

    mm/memblock: properly handle overlaps and fix error path

Which got merged in 2.6.39.

If you absolutely need to stick to 2.6.30, you can try backporting the
fix to lmb.

Cheers,
Ben.

> Some more explanation of what I observed:
> 
> unflatten_device_tree() allocates memory, which will be used
> for "struct node" objects in the device tree. I obtained base
> address of allocated memory in "unsigned long base_mem"
> 
> Now I executed the following code after the kernel booted properly.
> 
> ---------------------------------------------------------------
> extern unsigned long mem; // lmb_alloc() memory
> struct page *test_page = virt_to_page(mem);
> struct page *new_page = NULL;
> 
> while(1)
> {
>     new_page = NULL;
>     new_page = alloc_page(GFP_KERNEL);
>     if(!new_page)
>     {
>         printk("Allocation failed\n");
>         while(1);
>     }
>     if(test_page == new_page)
>     {
>          printk("Memory already allocated by lmb_alloc\n");
>          while(1);
>     }
> }
> ---------------------------------------------------------------
> 
> After many page allocations, I always hit the condition (test_page == new_page).
> Am I doing anything wrong here?
> Has anybody faced this kind of problem before?
> 
> 
> I also noticed that lmb_dump_all() shows 2 regions overlapping (last two):
> 
> LMB configuration:
>  rmo_size    = 0x30000000
>  memory.size = 0x30000000
>  memory.cnt  = 0x1
>  memory[0x0]    0x0000000000000000 - 0x000000002fffffff, 0x30000000 bytes
>  reserved.cnt  = 0x6
>  reserved[0x0]  0x0000000000000000 - 0x00000000006bffff, 0x6c0000 bytes
>  reserved[0x1]  0x0000000000ffa000 - 0x0000000000ffcfff, 0x3000 bytes
>  reserved[0x2]  0x000000002fdd0000 - 0x000000002fddffff, 0x10000 bytes
>  reserved[0x3]  0x000000002fde4000 - 0x000000002fde9fff, 0x6000 bytes
>  reserved[0x4]  0x000000002fdeb060 - 0x000000002ffff768, 0x214709 bytes
>  reserved[0x5]  0x000000002fdee000 - 0x000000002ffff769, 0x21176a bytes
> 
> 
> Thanks,
> Prashant
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
