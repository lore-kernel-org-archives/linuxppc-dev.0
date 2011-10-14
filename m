Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7CD29B6F80
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 18:40:04 +1100 (EST)
Subject: Re: How to handle cache when I allocate phys memory?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20111012210816.GA17878@crust.elkhashab.com>
References: <20111012210816.GA17878@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 Oct 2011 09:39:51 +0200
Message-ID: <1318577991.29415.514.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-10-12 at 16:08 -0500, Ayman El-Khashab wrote:
> I'm using the 460sx (440 core) so no snooping here.  What
> I've done is reserved the top of memory for my driver.  My
> driver can read/write the memory and I can mmap it just
> fine.  The problem is I want to enable caching on the mmap
> for performance but I don't know / can't figure out how to
> tell the kernel to sync the cache after it gets dma data
> from the device or after i put data into it from user space.
> I know how to do it from regular devices, but not when I've
> allocated the physical memory myself.  I suppose what I am
> looking for is something akin to dma_sync_single cpu/device.
> 
> In my device driver, I am allocating the memory like this, 
> in this case the buffer is about 512MB.
> 
>  vma->vm_flags |= VM_LOCKED | VM_RESERVED;
> 
>  /* map the physical area into one buffer */
>  rc = remap_pfn_range(vma, vma->vm_start, 
>                          (PHYS_MEM_ADDR)>>PAGE_SHIFT, 
>                          len, vma->vm_page_prot);
> 
> Is this going to give me the best performance, or is there
> something more I can do?
> 
> Failing that, what is the best way to do this (i need a very
> large contiguous buffer).  it runs in batch mode, so it
> DMAs, stops, cpu reads, cpu writes, repeat ...

Did you try looking at what the dma_* functions do under the hood and
call it directly (or reproducing it) ?

Basically it boils down to using dcbf instructions to flush dirty data
or dcbi to invalidate cache lines.

Cheers,
Ben.
