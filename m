Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0CBA7DDEDE
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 07:43:35 +1000 (EST)
Subject: Re: Hard-coded virtual address used by dma_alloc_coherent
From: Remi Machet <rmachet@slac.stanford.edu>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4888D808.8000406@freescale.com>
References: <1216927153.19203.62.camel@pcds-ts102.slac.stanford.edu>
	<4888D808.8000406@freescale.com>
Content-Type: text/plain
Date: Thu, 24 Jul 2008 14:43:25 -0700
Message-Id: <1216935807.19203.71.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-24 at 14:29 -0500, Scott Wood wrote:
> Remi Machet wrote:
> > I have noticed that the DMA allocation for non-coherent PowerPC
> > architecture is using a hard coded virtual memory address for its memory
> > pool. This address is typically 0xFF100000 (set by
> > CONFIG_CONSISTENT_START) and can conflict with early ioremap in systems
> > that enable HIGHMEM.
> > 
> > Is there any reason why we have to use an arbitrary virtual address ? If
> > the virtual address must be known at compile time, can't we use fixmap ?
> 
> The hardcoded address predates when fixmap was added to powerpc.  It 
> should be updated to use fixmap.
Ok, I will look into that.

> > I also can't figure out why we need to use a virtual address known at
> > compilation time and cannot just allocate pages using get_free_pages and
> > mark them as non cacheable and non swappable.
> 
> We probably don't need a compile-time address, though we can't just 
> change the page attributes in-place as the pages will often covered by 
> large TLB entries.
If we use alloc_pages to allocate the physical memory and get_vm_area to
get a virtual address (and its associated PTE), wouldn't map_vm_area
take care of breaking the TLB into smaller chunks if necessary ?

Remi
