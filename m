Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgeamrelo02.lge.com (lgeamrelo02.lge.com [156.147.1.126])
 by lists.ozlabs.org (Postfix) with ESMTP id 9E5851A02C4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 15:58:14 +1000 (EST)
Date: Thu, 12 Jun 2014 15:02:11 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2 02/10] DMA, CMA: fix possible memory leak
Message-ID: <20140612060211.GC30128@js1304-P5Q-DELUXE>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-3-git-send-email-iamjoonsoo.kim@lge.com>
 <20140612052543.GE12415@bbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140612052543.GE12415@bbox>
Cc: kvm-ppc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

On Thu, Jun 12, 2014 at 02:25:43PM +0900, Minchan Kim wrote:
> On Thu, Jun 12, 2014 at 12:21:39PM +0900, Joonsoo Kim wrote:
> > We should free memory for bitmap when we find zone mis-match,
> > otherwise this memory will leak.
> 
> Then, -stable stuff?

I don't think so. This is just possible leak candidate, so we don't
need to push this to stable tree.

> 
> > 
> > Additionally, I copy code comment from ppc kvm's cma code to notify
> > why we need to check zone mis-match.
> > 
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > 
> > diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> > index bd0bb81..fb0cdce 100644
> > --- a/drivers/base/dma-contiguous.c
> > +++ b/drivers/base/dma-contiguous.c
> > @@ -177,14 +177,24 @@ static int __init cma_activate_area(struct cma *cma)
> >  		base_pfn = pfn;
> >  		for (j = pageblock_nr_pages; j; --j, pfn++) {
> >  			WARN_ON_ONCE(!pfn_valid(pfn));
> > +			/*
> > +			 * alloc_contig_range requires the pfn range
> > +			 * specified to be in the same zone. Make this
> > +			 * simple by forcing the entire CMA resv range
> > +			 * to be in the same zone.
> > +			 */
> >  			if (page_zone(pfn_to_page(pfn)) != zone)
> > -				return -EINVAL;
> > +				goto err;
> 
> At a first glance, I thought it would be better to handle such error
> before activating.
> So when I see the registration code(ie, dma_contiguous_revere_area),
> I realized it is impossible because we didn't set up zone yet. :(
> 
> If so, when we detect to fail here, it would be better to report more
> meaningful error message like what was successful zone and what is
> new zone and failed pfn number?

What I want to do in early phase of this patchset is to make cma code
on DMA APIs similar to ppc kvm's cma code. ppc kvm's cma code already
has this error handling logic, so I make this patch.

If we think that we need more things, we can do that on general cma code
after merging this patchset.

Thanks.
