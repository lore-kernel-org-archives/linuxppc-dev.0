Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B78DE679F6
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 12:03:08 +1100 (EST)
Subject: Re: memory with __get_free_pages and disabling caching
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20060324172733.A20731@cox.net>
References: <478F19F21671F04298A2116393EEC3D50A9C8D@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
	<20060324172733.A20731@cox.net>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 12:02:51 +1100
Message-Id: <1143248571.3710.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yes, that's how it works. After being allocated by the dma api
> routines, the direct map is never accessed. Accessing the same
> physical address via the cached direct map would cause serious
> problems but you aren't allowed to touch address space like
> that unless it's been allocated through a kernel allocator for
> your use.

That is still broken for at least 6xx CPUs ... they may well prefetch it
and you die...

For example, page A is a normal page allocated for kernel use, page B
just a after A is used by the DMA allocator for uncacheable accesses
(and is thus mapped twice). If something does a loop going through an
array in page A, you have no guarantee that some smart prefetcher &
speculative accesses will not bring bits of page B into the cache since
it's mapped and cacheable...

Ben.
