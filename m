Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 44B96DE738
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 05:30:49 +1000 (EST)
Message-ID: <4888D808.8000406@freescale.com>
Date: Thu, 24 Jul 2008 14:29:12 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Remi Machet <rmachet@slac.stanford.edu>
Subject: Re: Hard-coded virtual address used by dma_alloc_coherent
References: <1216927153.19203.62.camel@pcds-ts102.slac.stanford.edu>
In-Reply-To: <1216927153.19203.62.camel@pcds-ts102.slac.stanford.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remi Machet wrote:
> I have noticed that the DMA allocation for non-coherent PowerPC
> architecture is using a hard coded virtual memory address for its memory
> pool. This address is typically 0xFF100000 (set by
> CONFIG_CONSISTENT_START) and can conflict with early ioremap in systems
> that enable HIGHMEM.
> 
> Is there any reason why we have to use an arbitrary virtual address ? If
> the virtual address must be known at compile time, can't we use fixmap ?

The hardcoded address predates when fixmap was added to powerpc.  It 
should be updated to use fixmap.

> I also can't figure out why we need to use a virtual address known at
> compilation time and cannot just allocate pages using get_free_pages and
> mark them as non cacheable and non swappable.

We probably don't need a compile-time address, though we can't just 
change the page attributes in-place as the pages will often covered by 
large TLB entries.

-Scott
