Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 121A6679E6
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 11:43:10 +1100 (EST)
Date: Fri, 24 Mar 2006 17:29:50 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: memory with __get_free_pages and disabling caching
Message-ID: <20060324172950.B20731@cox.net>
References: <478F19F21671F04298A2116393EEC3D50A9C8D@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
	<1143246035.3710.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1143246035.3710.29.camel@localhost.localdomain>;
	from benh@kernel.crashing.org on Sat, Mar 25, 2006 at 11:20:34AM
	+1100
Cc: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 25, 2006 at 11:20:34AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2006-03-24 at 15:44 -0800, Kallol Biswas wrote:
> > Thank you.
> > 
> > I wonder how consistent ptes are used if all kernel memory is mapped with large tlb.
> > In the __dma_alloc_coherent() routine pages are allocated with alloc_pages(), new virtual address is created in consistent region,
> > then consistent ptes are populated. Looks like that the routine creates a new virtual mapping. The memory is addressed with the new address. 
> > 
> > Do we have two mappings in the TLB for the same physical address?
> 
> Yes, it seems like we do... the consistent DMA stuff assumes that is
> safe to do, which is not the case on 6xx CPUs but might be on 4xx.

It is safe on 4xx. The doomsday scenario on 4xx is two mapping in the
TBL for the same virtual address range. Operation at that point is
boundedly undefined. :)

-Matt
