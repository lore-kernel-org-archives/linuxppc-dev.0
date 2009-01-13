Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 944B5DE1BE
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 20:03:34 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LMfBL-0001W1-9j
	for linuxppc-dev@ozlabs.org; Tue, 13 Jan 2009 01:03:31 -0800
Message-ID: <21431621.post@talk.nabble.com>
Date: Tue, 13 Jan 2009 01:03:31 -0800 (PST)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: When do i need to allocate DMA buffer
In-Reply-To: <d194b8ce0901121216v2c154d0ha21148514351c8d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <21413193.post@talk.nabble.com>
	<d194b8ce0901121216v2c154d0ha21148514351c8d3@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


1. so my question is: is there any difference between the DMA engine & the
DMA controller?
2. i have read the following section in my reference manual: "The MPC8555E
DMA engine is capable of transferring blocks of data from any legal address
range to any
other legal address range. Therefore, it can perform a DMA transfer between
any of its I/O or memory
ports or even between two devices or locations on the same port."

does it mean that it can copy data from source to destination directly
without using the DMA buffer?
3.can i use the DMA-PCI or the generic DMA APIs or DMA ISA APIs to drive the
DMA Engine or i m obligitaed to use the driver of DMA engine?


Sylvain Joyeau wrote:
> 
> Hi Wael,
> 
> 1. The DMA engine source and destination registers are based on
> physical memory addresses, whatever is the bus connected on, thus you
> need to provide it physical addresses.
> It looks like you are a bit confused about the terminology "DMA
> buffer": a DMA buffer is either the source and/or destination buffer,
> but not a intermediate buffer that you could bypass. Perhaps anybody
> speaking english more fluently can explain that better than me.
> 
> 2. Know nothing about Linux DMA API, but more thant a bit about
> MPC8555 DMA, and I can say it's quite easy to program, directly
> (through DMA registers) if your application doesn't require
> portability across platforms.
> AFAIK, the better way to allocate source and/or destination RAM buffer
> in the kernel side is dma_alloc_coherent(): that's one seems rather
> portable !
> 
> Best regards.
> --
> sj
> 
> 2009/1/12 wael showair <showair2003@yahoo.com>:
>>
>> Hi All,
>> i have MPC8555 processor, also i have linux-kernel 2.6.19-rc5 on my
>> board.i
>> want to use the DMA on my board, just a simple example is enough for me
>> but
>> during my reading on how to use the DMA i have some questions:
>> 1. The DMA buffer is always needed for all kind of buses or not? (I think
>> this is valid in the ISA bus but not in the PCI bus, plz correct me if i
>> m
>> wrong?)
>> Note that my target is to transfer data from memory location to another
>> memory location & it will be an overhead if i copy the data from the src
>> to
>> the DMA buffer then from the DMA buffer to the Destination.
>> isn't there any other way to avoid using that DMA buffer & to copy data
>> from
>> src to dest directly?
>> i read the documentation of my board & it tells me that it contain DMA
>> engine which "is capable of transferring blocks of data from any legal
>> address range to any
>> other legal address range."
>>
>> 2. i have read DMA-API.txt in the linux Documentation folder but i m
>> little
>> confused about the APIs that exist in this file. Actually, it is stated
>> in
>> this file the following:
>> "This document describes the DMA API.This API is split into two pieces.
>> Part I describes the API and the corresponding pci_ API".
>>
>> so if the DMA controller is connected to the PCI bus, am i obligated to
>> use
>> the pci_API & for any other case (like ISA bus or any other bus types)
>> shall
>> i use this generic API?
>> also what r the benefits of these APIs over the normal kmalloc? specially
>> that i have read the following section in the DMA-mapping.txt:
>> "If you acquired your memory via the page allocator
>> (i.e. __get_free_page*()) or the generic memory allocators
>> (i.e. kmalloc() or kmem_cache_alloc()) then you may DMA to/from
>> that memory using the addresses returned from those routines."
>>
>> thanks in advance for ur help
>> --
>> View this message in context:
>> http://www.nabble.com/When-do-i-need-to-allocate-DMA-buffer-tp21413193p21413193.html
>> Sent from the linuxppc-dev mailing list archive at Nabble.com.
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
> 
> 
> 
> -- 
> ------------------
> Sylvain JOYEAU
> Freelance Engineer
> Software RT-OS R&D
> sylvain.joyeau@gmail.com
> "A good idea is one side of the coin. The other side is the practical
> usefulness". J. Liedke.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/When-do-i-need-to-allocate-DMA-buffer-tp21413193p21431621.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
