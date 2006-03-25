Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 0275D67A3D
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 12:25:51 +1100 (EST)
Date: Fri, 24 Mar 2006 18:25:49 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: memory with __get_free_pages and disabling caching
Message-ID: <20060324182549.C20731@cox.net>
References: <478F19F21671F04298A2116393EEC3D50A9C8D@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
	<20060324172733.A20731@cox.net>
	<1143248571.3710.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1143248571.3710.33.camel@localhost.localdomain>;
	from benh@kernel.crashing.org on Sat, Mar 25, 2006 at 12:02:51PM
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

On Sat, Mar 25, 2006 at 12:02:51PM +1100, Benjamin Herrenschmidt wrote:
> 
> > Yes, that's how it works. After being allocated by the dma api
> > routines, the direct map is never accessed. Accessing the same
> > physical address via the cached direct map would cause serious
> > problems but you aren't allowed to touch address space like
> > that unless it's been allocated through a kernel allocator for
> > your use.
> 
> That is still broken for at least 6xx CPUs ... they may well prefetch it
> and you die...
 
Right.

> For example, page A is a normal page allocated for kernel use, page B
> just a after A is used by the DMA allocator for uncacheable accesses
> (and is thus mapped twice). If something does a loop going through an
> array in page A, you have no guarantee that some smart prefetcher &
> speculative accesses will not bring bits of page B into the cache since
> it's mapped and cacheable...

We had a similar scenario on 4xx with the smart prefetching that is
used in copy_tofrom_user. It had to be modified not to prefetch
across pages for 4xx. Eugene first saw corruption due to adjacent
page prefetches into a dmaable page.

-Matt
