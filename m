Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29B5167A39
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 07:06:22 +1000 (EST)
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <28892.1145559466@www088.gmx.net>
References: <28892.1145559466@www088.gmx.net>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 07:03:45 +1000
Message-Id: <1145567025.17087.77.camel@localhost.localdomain>
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

On Thu, 2006-04-20 at 20:57 +0200, Gerhard Pircher wrote:

> 1. The AmigaOne is similar to the PREP platform, i.e. DMA can only be
> performed in the first 16MB for ISA devices (there's only a VIA southbridge,
> no other SuperI/O IC with 32bit capable DMA controller). I guess the first
> 16MB cannot be reserved for not coherent DMA operation, because this memory
> area is occupied by kernel data? (not to talk about the performance loss, if
> the kernel data area would be excluded from the BAT mapping).

Yeah that would suck. Are you sure you need ISA DMA ? You can do pseudo
DMA like pegasos for the floppy. Anything else should be able to do 32
bits DMA unless you have a very broken chipset.

> 2. I'm not sure how to allocate memory for DMA operation. I think
> alloc_pages() will not do the job for me, as the page tables for not
> coherent DMA are reserved (SetPageReserved()) and removed from the available
> lowmem.

alloc_pages() ? How so ? No, you want to allocate from your reserved
pool, you'll have to implement your own allocator. Easiest is a running
bitmap, look at ppc64 iommu code for an example.

>  Also memory fragmentation may be a problem, if a lot DMA operations
> with different buffer sizes are performed. Therefore a system could quickly
> run out of memory for not coherent DMA operation, right?
> Is there a way to minimize fragmentation?

Best you can do is have separate pools for small and big allocations I
suppose.

> 3. How are DMA buffers used outside the kernel? Do user programs get a
> pointer to the DMA buffer (in theory) from the device driver or is the data
> copied to another buffer allocated by an user program?

There are cases where some drivers try that but you should ignore it for
the moment. Won't happen in most cases.

Ben.
