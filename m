Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDD9B684B9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Oct 2005 23:52:33 +1000 (EST)
Date: Wed, 5 Oct 2005 20:05:32 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Earl Olsen <earl.olsen@dilithiumnetworks.com>
Message-ID: <20051005230532.GA10220@logos.cnet>
References: <B8561865DB141248943E2376D0E8521501420346@DHOST001-17.DEX001.intermedia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B8561865DB141248943E2376D0E8521501420346@DHOST001-17.DEX001.intermedia.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: problems with dma_alloc_coherent and consistent_alloc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 05, 2005 at 02:21:01PM -0700, Earl Olsen wrote:
> 
> (Sorry, I had trouble outlook and messed up the subject line)
> 
> We are using a PPC 750 with 512m of RAM.

I dont know much about your hardware, but I'll shoot anyway.

> 1) When we try to allocate memory using consistent_alloc we get a 
> failure with get_pteptr - there is no pte.  
> 
> 2) When we try using dma_alloc_coherent the system locks up when
> we try to access that memory.
> 
> I'm guessing these problems stem from the memory being allocated
> is from the 384 bytes of RAM that gets handed over to BATs 2 AND 3,

You mean Mbytes?

> not the remaining memory handled by the page table.
> 
> In the first case, pages are allocated, but since if came from the
> BAT region, will not have a page table mapping.
> 
> In the second case, if dma_alloc_init gets memory from the BAT
> region, then we have the BAT and page management mechanisms
> both trying to control the memory.
> 
> Does this sound like a good theory?  Has anybody encountered
> this problem before?

The kernel should create pte tables for all RAM, even if parts of 
memory are not accessed through pagetable mappings.
