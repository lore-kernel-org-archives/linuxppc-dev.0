Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 4D043679A6
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 13:44:55 +1100 (EST)
Date: Fri, 24 Mar 2006 17:27:33 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
Subject: Re: memory with __get_free_pages and disabling caching
Message-ID: <20060324172733.A20731@cox.net>
References: <478F19F21671F04298A2116393EEC3D50A9C8D@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <478F19F21671F04298A2116393EEC3D50A9C8D@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>;
	from Kallol_Biswas@pmc-sierra.com on Fri, Mar 24, 2006 at 03:44:42PM
	-0800
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 24, 2006 at 03:44:42PM -0800, Kallol Biswas wrote:
> Thank you.
> 
> I wonder how consistent ptes are used if all kernel memory is mapped with large tlb.
> In the __dma_alloc_coherent() routine pages are allocated with alloc_pages(), new virtual address is created in consistent region, then consistent ptes are populated. Looks like that the routine creates a new virtual mapping. The memory is addressed with the new address. 
> 
> Do we have two mappings in the TLB for the same physical address?

Yes, that's how it works. After being allocated by the dma api
routines, the direct map is never accessed. Accessing the same
physical address via the cached direct map would cause serious
problems but you aren't allowed to touch address space like
that unless it's been allocated through a kernel allocator for
your use.

-Matt
