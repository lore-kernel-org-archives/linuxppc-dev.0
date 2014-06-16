Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgemrelse6q.lge.com (LGEMRELSE6Q.lge.com [156.147.1.121])
 by lists.ozlabs.org (Postfix) with ESMTP id C13C61A00EF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 15:19:14 +1000 (EST)
Date: Mon, 16 Jun 2014 14:23:25 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH v2 05/10] DMA, CMA: support arbitrary bitmap granularity
Message-ID: <20140616052325.GC23210@js1304-P5Q-DELUXE>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-6-git-send-email-iamjoonsoo.kim@lge.com>
 <xa1t61k6juph.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <xa1t61k6juph.fsf@mina86.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2014 at 12:19:54PM +0200, Michal Nazarewicz wrote:
> On Thu, Jun 12 2014, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> > ppc kvm's cma region management requires arbitrary bitmap granularity,
> > since they want to reserve very large memory and manage this region
> > with bitmap that one bit for several pages to reduce management overheads.
> > So support arbitrary bitmap granularity for following generalization.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
> 
> > diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> > index bc4c171..9bc9340 100644
> > --- a/drivers/base/dma-contiguous.c
> > +++ b/drivers/base/dma-contiguous.c
> > @@ -38,6 +38,7 @@ struct cma {
> >  	unsigned long	base_pfn;
> >  	unsigned long	count;
> 
> Have you considered replacing count with maxno?

No, I haven't.
I think that count is better than maxno, since it represent number of
pages in this region.

> 
> >  	unsigned long	*bitmap;
> > +	int order_per_bit; /* Order of pages represented by one bit */
> 
> I'd make it unsigned.

Will fix it.

> >  	struct mutex	lock;
> >  };
> >  
> > +static void clear_cma_bitmap(struct cma *cma, unsigned long pfn, int
> > count)
> 
> For consistency cma_clear_bitmap would make more sense I think.  On the
> other hand, you're just moving stuff around so perhaps renaming the
> function at this point is not worth it any more.

Will fix it.

> > +{
> > +	unsigned long bitmapno, nr_bits;
> > +
> > +	bitmapno = (pfn - cma->base_pfn) >> cma->order_per_bit;
> > +	nr_bits = cma_bitmap_pages_to_bits(cma, count);
> > +
> > +	mutex_lock(&cma->lock);
> > +	bitmap_clear(cma->bitmap, bitmapno, nr_bits);
> > +	mutex_unlock(&cma->lock);
> > +}
> > +
> >  static int __init cma_activate_area(struct cma *cma)
> >  {
> > -	int bitmap_size = BITS_TO_LONGS(cma->count) * sizeof(long);
> > +	int bitmap_maxno = cma_bitmap_maxno(cma);
> > +	int bitmap_size = BITS_TO_LONGS(bitmap_maxno) * sizeof(long);
> >  	unsigned long base_pfn = cma->base_pfn, pfn = base_pfn;
> >  	unsigned i = cma->count >> pageblock_order;
> >  	struct zone *zone;
> 
> bitmap_maxno is never used again, perhaps:
> 
> +	int bitmap_size = BITS_TO_LONGS(cma_bitmap_maxno(cma)) * sizeof(long);
> 
> instead? Up to you.

Okay!!

Thanks.
