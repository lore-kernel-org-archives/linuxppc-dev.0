Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A926A2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jan 2005 05:59:40 +1100 (EST)
Date: Thu, 6 Jan 2005 10:59:37 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Laurent Lagrange <lagrange@fr.oleane.com>
Message-ID: <20050106185937.GC6539@gate.ebshome.net>
References: <20050105174154.GB14485@gate.ebshome.net>
	<000001c4f417$25e84260$5201a8c0@GEG2400>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001c4f417$25e84260$5201a8c0@GEG2400>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8260 strange virtual addresses returned by kmalloc()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jan 06, 2005 at 06:42:50PM +0100, Laurent Lagrange wrote:
> My PAGE_OFFSET is defined as follow :
> #define PAGE_OFFSET  CONFIG_KERNEL_START     in
> ./linux/include/asm-ppc/page.h
> #define CONFIG_KERNEL_START (0xc0000000)     in
> ./linux/include/linux/autoconf.h
> 
> After reading kmalloc manual pages, I am in doubt.
> My call is like
> if ((tmpbuffer = kmalloc(128 * 1024, GFP_KERNEL)) == NULL){
>     return(1);
> }
> 
> This is the first time, I kmallocate a 128KB buffer which seems to be the
> max
> contiguous memory space which can be allocated.
> Is it true on PPC ? Some PPC drivers seems to only allocate multiple
> PAGE_SIZE (4KB) buffers.

kmalloc implementation isn't PPC specific. It's the same code for 
every arch.

Regardless, if kmalloc cannot allocate amount of memory you have 
requested, it'll return NULL and you must handle this gracefully. 

kmalloc _always_ allocate physically continuous pages. That's why 
trying to allocate 128K is bad idea, because it's more likely to fail.

> My allocated buffer is intended to be used for DMA accesses.
> Must I add the GFP_DMA flag to force the kmalloc to use contiguous memory ?

You need to use this flag to get DMA memory, although on PPC usually 
all RAM is available for DMA.

> > The Linux code for vmalloc is based on successive kmalloc calls, but I don't
> know
> what the kmalloc do when the desired size is greater than the PAGE_SIZE.

That's not correct. vmalloc uses kmalloc only to allocate vm_struct. 
Actual memory is allocated using alloc_page and then this page is 
mapped by installing PTE into the kernel page table.

> What is the right way to allocate big (128KB ???) DMA buffers ?
> The manual pages say "Only for DMA kmalloc or __get_dma_pages() has to be
> used"

Generally for PAGE_SIZE * n allocations it's more efficient to use 
__get_free_pages and friends. But kmalloc should also be OK. The only 
limitation is the maximum size of such allocations, but you already 
know this.

> The global variable is well in the loaded module.
> OK, I use a kmalloc for the buffer instead of using the global variable.

Memory for DMA should always be allocated using specially designed 
functions. Don't use stack or static storage unless you know what you 
are doing :).

--
Eugene
