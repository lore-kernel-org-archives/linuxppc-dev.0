Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id DA264DDE16
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 03:20:38 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 18 Dec 2007 09:20:32 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 07/10] powerpc: Implement kmap_atomic_pfn on powerpc
Message-ID: <20071218162032.GB28931@xyzzy.farnsworth.org>
References: <20071122154638.GA26514@xyzzy.farnsworth.org>
	<1197699461.6696.45.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1197699461.6696.45.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 15, 2007 at 05:17:41PM +1100, Benjamin Herrenschmidt wrote:
> 
> On Thu, 2007-11-22 at 08:46 -0700, Dale Farnsworth wrote:
> > This is needed for the ppc32 /dev/oldmem driver of crash dump.
> 
> Kumar's working (well, last I heard he was) on a fixmap mechanism
> so we can do that sort of thing without CONFIG_HIGHMEM, you may
> want to sync with him here, that would allow to shrink the crash
> kernel by not having highmem selected.
> 
> Cheers,
> Ben.

Kumar, are you close to posting something that would make the
patch below unnecessary (or change it significantly)?  If so,
I'll hold off.

-Dale

> > Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> > ---
> >  include/asm-powerpc/highmem.h |   18 ++++++++++++++++++
> >  1 files changed, 18 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/asm-powerpc/highmem.h b/include/asm-powerpc/highmem.h
> > index f7b21ee..88d9e05 100644
> > --- a/include/asm-powerpc/highmem.h
> > +++ b/include/asm-powerpc/highmem.h
> > @@ -117,6 +117,24 @@ static inline void kunmap_atomic(void *kvaddr, enum km_type type)
> >  	pagefault_enable();
> >  }
> >  
> > +/* This is the same as kmap_atomic() but can map memory that doesn't
> > + * have a struct page associated with it.
> > + */
> > +static inline void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
> > +{
> > +	unsigned int idx;
> > +	unsigned long vaddr;
> > +
> > +	pagefault_disable();
> > +
> > +	idx = type + KM_TYPE_NR * smp_processor_id();
> > +	vaddr = KMAP_FIX_BEGIN + idx * PAGE_SIZE;
> > +	set_pte_at(&init_mm, vaddr, kmap_pte+idx, pfn_pte(pfn, kmap_prot));
> > +	flush_tlb_page(NULL, vaddr);
> > +
> > +	return (void*) vaddr;
> > +}
> > +
> >  static inline struct page *kmap_atomic_to_page(void *ptr)
> >  {
> >  	unsigned long idx, vaddr = (unsigned long) ptr;
