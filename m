Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2FDB4679E0
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Mar 2006 09:11:54 +1100 (EST)
Subject: Re: Unmapping pages from the linear addressing without HIGHMEM support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <15153.1141912297@www026.gmx.net>
References: <15153.1141912297@www026.gmx.net>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 09:11:41 +1100
Message-Id: <1141942301.3603.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-03-09 at 14:51 +0100, Gerhard Pircher wrote:
> Hi,
> 
> I'm trying to implement non-coherent DMA for PPC desktop systems (like the
> AmigaOne with G3/G4 CPU). For this I want to use the code in
> arch/ppc/kernel/dma-mapping.c. The DMA memory allocation function
> implemented in this file allocates pages with alloc_pages() and maps them to
> its own linear address space, but without unmapping the allocated pages from
> the kernel linear addressing. Due to this the pages are mapped twice, which
> results in a conflict between the different WIMG settings of the pages.
> 
> Is there an API that can be used to unmap the allocated pages from the
> kernel linear addressing? I thought about using kunmap() and
> flush_all_zero_pkmaps(), but I'm not sure if this is the right approach and
> HIGHMEM doesn't work on the AmigaOne too (the highmem base is occupied by
> the PCI/ISA I/O space!). Wouldn't it be possible to just clear the valid (V)
> bit of the PTE and do a TLB cache flush?

The main problem is that the mappings may be covered by a BAT and thus
pages may not be unmappable individually...

What I would suggest is that your dig in the low level RAM mapping code
and limit it at boot to RAM minus a pool of the size you want.

Ben.
