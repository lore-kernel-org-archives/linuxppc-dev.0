Date: Tue, 4 Mar 2003 16:45:35 -0700
From: Matt Porter <porter@cox.net>
To: Dan Malek <dan@embeddededge.com>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Fix *dma_sync_single() and flush_dcache_all
Message-ID: <20030304164535.G2120@home.com>
References: <20030304153637.E2120@home.com> <3E6532B4.2090506@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E6532B4.2090506@embeddededge.com>; from dan@embeddededge.com on Tue, Mar 04, 2003 at 06:11:48PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Mar 04, 2003 at 06:11:48PM -0500, Dan Malek wrote:
> Matt Porter wrote:
>
> > That means the ARM and MIPS implementations that use a
> > bus_to_virt() on the dma_handle in *dma_sync_single are
> > correct and our (performance killing) call to flush_dcache_all
> > is unnecessary.
>
> Well, to be fair it seems this code has gone through a couple
> of revisions since it was originally written.  I suspect a "better
> safe than sorry" approach was taken when changes were made. :-)

I figured that. :)

> > If there are no objections, then I will commit to following
> > patch to 2_4_devel and 2.5.  The 2.5 pci_map_single/sync_single
> > are horked up anyway for 4xx so that will get fixed too.
>
> OK, go for it.  A couple of comments though.........
>
>
> >  #define CACHE_NWAYS	64
> >  #define CACHE_NLINES	16
>
> I made these #defines in the original code and I believe they were
> set to values based upon the processor selection.  When did they
> change to 'worst case' and the most popular and most performance
> challenged processors are paying the price for unnecessary cache
> operations?

I don't know the answer that.  It happened before I first touched
it.  I simply upped the worst case to cover the larger 440 core
dcache.

> > -#ifdef CONFIG_NOT_COHERENT_CACHE
> > -	/* The bus_to_virt() can't be used here, in case dma_handle
> > -	 * points to something that doesn't have the same cache attributes
> > -	 * as the 1:1 mapped kernel memory.
>
> Ummm....this is a very important comment (not because I wrote it) :-)
> On the 4xx and 8xx processors you can't use bus_to_virt() (unless we
> are still calling iopa() and properly tracking all of the pages that
> may be part of the DMA).  Are we _sure_ we aren't using consistent_alloc()'ed
> memory with these APIs?

Yes, I completely understand the comment. :)

As I said, the DMA API explicitly lists what memory can be passed to
this family of API's.  Memory allocated from pci_alloc_consistent
cannot be passed in.  Nor can ioremapped addresses.  DaveM suggests
another API be created to handle device to device transfers for 2.5+
for that specific case.

I listed the types of allocated addresses that the API documentation
explicitly mentions in the previous mail.  Memory allocated via
those methods will always be able to be converted back to a
virtual address via bus_to_virt() because the allocations come
from 1:1 kernel lowmem and are guaranteed to be contiguous.  highmem
is not a consideration since the *_single() family of calls is only
usable on lowmem...*_page() would be used for highmem.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
