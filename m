Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0117.outbound.protection.outlook.com [65.55.169.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A3231A0663
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 06:25:21 +1000 (AEST)
Message-ID: <1442521509.19102.72.camel@freescale.com>
Subject: Re: [PATCH v9 2/5] genalloc:support allocating specific region
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>
Date: Thu, 17 Sep 2015 15:25:09 -0500
In-Reply-To: <1442521184.19102.69.camel@freescale.com>
References: <1442194700-6194-1-git-send-email-qiang.zhao@freescale.com>
 <1442194700-6194-2-git-send-email-qiang.zhao@freescale.com>
 <1442521184.19102.69.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-17 at 15:19 -0500, Scott Wood wrote:
> On Mon, 2015-09-14 at 09:38 +0800, Zhao Qiang wrote:
> > Add new algo for genalloc, it reserve a specific region of
> > memory matching the size requirement (no alignment constraint)
> > 
> > Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> > ---
> > Changes for v9:
> >       - reserve a specific region, if the return region
> >       - is not during the specific region, return fail.
> > 
> >  include/linux/genalloc.h | 11 +++++++++++
> >  lib/genalloc.c           | 30 ++++++++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+)
> > 
> > diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
> > index aaf3dc2..85e3b2f 100644
> > --- a/include/linux/genalloc.h
> > +++ b/include/linux/genalloc.h
> > @@ -82,6 +82,13 @@ struct genpool_data_align {
> >       int align;              /* alignment by bytes for starting address 
> > */
> >  };
> >  
> > +/*
> > + *  gen_pool data descriptor for gen_pool_fixed_fit.
> > + */
> > +struct genpool_data_fixed {
> > +     unsigned long offset;           /* The offset of the specific 
> > region */
> > +};
> > +
> >  extern struct gen_pool *gen_pool_create(int, int);
> >  extern phys_addr_t gen_pool_virt_to_phys(struct gen_pool *pool, unsigned 
> > long);
> >  extern int gen_pool_add_virt(struct gen_pool *, unsigned long, 
> > phys_addr_t,
> > @@ -121,6 +128,10 @@ extern unsigned long gen_pool_first_fit(unsigned 
> > long 
> > *map, unsigned long size,
> >               unsigned long start, unsigned int nr, void *data,
> >               struct gen_pool *pool);
> >  
> > +extern unsigned long gen_pool_fixed_fit(unsigned long *map,
> > +             unsigned long size, unsigned long start, unsigned int nr,
> > +             void *data, struct gen_pool *pool);
> > +
> 
> "fixed fit" doesn't make much sense...  How about "fixed_alloc"?
> 
>  /**
> > + * gen_pool_fixed_fit - reserve a specific region of
> > + * matching the size requirement (no alignment constraint)
> > + * @map: The address to base the search on
> > + * @size: The bitmap size in bits
> > + * @start: The bitnumber to start searching at
> > + * @nr: The number of zeroed bits we're looking for
> > + * @data: data for alignment
> > + * @pool: pool to get order from
> > + */
> > +unsigned long gen_pool_fixed_fit(unsigned long *map, unsigned long size,
> > +             unsigned long start, unsigned int nr, void *data,
> > +             struct gen_pool *pool)
> > +{
> > +     struct genpool_data_fixed *fixed_data;
> > +     int order;
> > +     unsigned long offset_bit;
> > +     unsigned long start_bit;
> > +
> > +     fixed_data = data;
> > +     order = pool->min_alloc_order;
> > +     offset_bit = fixed_data->offset >> order;
> > +     start_bit = bitmap_find_next_zero_area(map, size,
> > +                     start + offset_bit, nr, 0);
> > +     if (start_bit != offset_bit)
> > +             start_bit = size;
> > +     return start_bit;
> > +}
> > +EXPORT_SYMBOL(gen_pool_fixed_fit);
> 
> This would be simpler with bitmap_allocate_region().

Never mind, that doesn't fit with how the algorithm is used by the caller, 
and unlike genalloc isn't atomic.

-Scott
