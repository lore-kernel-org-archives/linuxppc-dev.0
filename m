Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgemrelse7q.lge.com (LGEMRELSE7Q.lge.com [156.147.1.151])
 by lists.ozlabs.org (Postfix) with ESMTP id 9CAA11A032B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 18:13:44 +1000 (EST)
Date: Thu, 19 Jun 2014 17:18:07 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 -next 4/9] DMA, CMA: support arbitrary bitmap
 granularity
Message-ID: <20140619081807.GA28611@js1304-P5Q-DELUXE>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402897251-23639-5-git-send-email-iamjoonsoo.kim@lge.com>
 <20140618134815.69c4d0a5f916846f9857e9ff@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140618134815.69c4d0a5f916846f9857e9ff@linux-foundation.org>
Cc: kvm-ppc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 kvm@vger.kernel.org, linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>,
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

On Wed, Jun 18, 2014 at 01:48:15PM -0700, Andrew Morton wrote:
> On Mon, 16 Jun 2014 14:40:46 +0900 Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> 
> > PPC KVM's CMA area management requires arbitrary bitmap granularity,
> > since they want to reserve very large memory and manage this region
> > with bitmap that one bit for several pages to reduce management overheads.
> > So support arbitrary bitmap granularity for following generalization.
> > 
> > ...
> >
> > --- a/drivers/base/dma-contiguous.c
> > +++ b/drivers/base/dma-contiguous.c
> > @@ -38,6 +38,7 @@ struct cma {
> >  	unsigned long	base_pfn;
> >  	unsigned long	count;
> >  	unsigned long	*bitmap;
> > +	unsigned int order_per_bit; /* Order of pages represented by one bit */
> >  	struct mutex	lock;
> >  };
> >  
> > @@ -157,9 +158,37 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
> >  
> >  static DEFINE_MUTEX(cma_mutex);
> >  
> > +static unsigned long cma_bitmap_aligned_mask(struct cma *cma, int align_order)
> > +{
> > +	return (1 << (align_order >> cma->order_per_bit)) - 1;
> > +}
> 
> Might want a "1UL << ..." here.

Okay!

> 
> > +static unsigned long cma_bitmap_maxno(struct cma *cma)
> > +{
> > +	return cma->count >> cma->order_per_bit;
> > +}
> > +
> > +static unsigned long cma_bitmap_pages_to_bits(struct cma *cma,
> > +						unsigned long pages)
> > +{
> > +	return ALIGN(pages, 1 << cma->order_per_bit) >> cma->order_per_bit;
> > +}
> 
> Ditto.  I'm not really sure what the compiler will do in these cases,
> but would prefer not to rely on it anyway!

Okay!

Thanks for fix!
