Message-ID: <3E6532B4.2090506@embeddededge.com>
Date: Tue, 04 Mar 2003 18:11:48 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Fix *dma_sync_single() and flush_dcache_all
References: <20030304153637.E2120@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:

> That means the ARM and MIPS implementations that use a
> bus_to_virt() on the dma_handle in *dma_sync_single are
> correct and our (performance killing) call to flush_dcache_all
> is unnecessary.

Well, to be fair it seems this code has gone through a couple
of revisions since it was originally written.  I suspect a "better
safe than sorry" approach was taken when changes were made. :-)

> If there are no objections, then I will commit to following
> patch to 2_4_devel and 2.5.  The 2.5 pci_map_single/sync_single
> are horked up anyway for 4xx so that will get fixed too.

OK, go for it.  A couple of comments though.........


>  #define CACHE_NWAYS	64
>  #define CACHE_NLINES	16

I made these #defines in the original code and I believe they were
set to values based upon the processor selection.  When did they
change to 'worst case' and the most popular and most performance
challenged processors are paying the price for unnecessary cache
operations?


> -#ifdef CONFIG_NOT_COHERENT_CACHE
> -	/* The bus_to_virt() can't be used here, in case dma_handle
> -	 * points to something that doesn't have the same cache attributes
> -	 * as the 1:1 mapped kernel memory.

Ummm....this is a very important comment (not because I wrote it) :-)
On the 4xx and 8xx processors you can't use bus_to_virt() (unless we
are still calling iopa() and properly tracking all of the pages that
may be part of the DMA).  Are we _sure_ we aren't using consistent_alloc()'ed
memory with these APIs?

Happy testing :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
