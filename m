Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwtNv0y1JzF17N
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 10:32:46 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id q13so182586pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 15:32:46 -0800 (PST)
Date: Wed, 7 Mar 2018 09:32:34 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 09/10] powerpc/mm/slice: use the dynamic high slice size
 to limit bitmap operations
Message-ID: <20180307093234.560e666c@roar.ozlabs.ibm.com>
In-Reply-To: <525f5482-550e-4978-3367-feee257d4023@c-s.fr>
References: <20180306132507.10649-1-npiggin@gmail.com>
 <20180306132507.10649-10-npiggin@gmail.com>
 <525f5482-550e-4978-3367-feee257d4023@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Mar 2018 16:02:20 +0100
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 06/03/2018 à 14:25, Nicholas Piggin a écrit :
> > The number of high slices a process might use now depends on its
> > address space size, and what allocation address it has requested.
> > 
> > This patch uses that limit throughout call chains where possible,
> > rather than use the fixed SLICE_NUM_HIGH for bitmap operations.
> > This saves some cost for processes that don't use very large address
> > spaces.
> > 
> > Perormance numbers aren't changed significantly, this may change
> > with larger address spaces or different mmap access patterns that
> > require more slice mask building.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   arch/powerpc/mm/slice.c | 75 +++++++++++++++++++++++++++++--------------------
> >   1 file changed, 45 insertions(+), 30 deletions(-)
> > 
> > diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> > index 086c31b8b982..507d17e2cfcd 100644
> > --- a/arch/powerpc/mm/slice.c
> > +++ b/arch/powerpc/mm/slice.c
> > @@ -61,14 +61,12 @@ static void slice_print_mask(const char *label, const struct slice_mask *mask) {
> >   #endif
> >   
> >   static void slice_range_to_mask(unsigned long start, unsigned long len,
> > -				struct slice_mask *ret)
> > +				struct slice_mask *ret,
> > +				unsigned long high_slices)
> >   {
> >   	unsigned long end = start + len - 1;
> >   
> >   	ret->low_slices = 0;
> > -	if (SLICE_NUM_HIGH)
> > -		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
> > -
> >   	if (start < SLICE_LOW_TOP) {
> >   		unsigned long mend = min(end,
> >   					 (unsigned long)(SLICE_LOW_TOP - 1));
> > @@ -77,6 +75,10 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
> >   			- (1u << GET_LOW_SLICE_INDEX(start));
> >   	}
> >   
> > +	if (!SLICE_NUM_HIGH)
> > +		return;
> > +
> > +	bitmap_zero(ret->high_slices, high_slices);  
> 
> In include/linux/bitmap.h, it is said:
> 
>   * Note that nbits should be always a compile time evaluable constant.
>   * Otherwise many inlines will generate horrible code.
> 
> Not sure that's true, but it is written ...

Good question, I'll check that.

> >   static inline void slice_or_mask(struct slice_mask *dst,
> >   					const struct slice_mask *src1,
> > -					const struct slice_mask *src2)
> > +					const struct slice_mask *src2,
> > +					unsigned long high_slices)
> >   {
> >   	dst->low_slices = src1->low_slices | src2->low_slices;
> >   	if (!SLICE_NUM_HIGH)
> >   		return;
> > -	bitmap_or(dst->high_slices, src1->high_slices, src2->high_slices, SLICE_NUM_HIGH);
> > +	bitmap_or(dst->high_slices, src1->high_slices, src2->high_slices,
> > +			high_slices);  
> 
> Why a new line here, this line is shorter than before.
> Or that was forgotten in a previous patch ?

Yeah it was previously a longer line. I will fix those.

> > @@ -643,17 +652,17 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
> >   	if (addr == -ENOMEM)
> >   		return -ENOMEM;
> >   
> > -	slice_range_to_mask(addr, len, &potential_mask);
> > +	slice_range_to_mask(addr, len, &potential_mask, high_slices);
> >   	slice_dbg(" found potential area at 0x%lx\n", addr);
> >   	slice_print_mask(" mask", &potential_mask);
> >   
> >    convert:
> > -	slice_andnot_mask(&potential_mask, &potential_mask, &good_mask);
> > +	slice_andnot_mask(&potential_mask, &potential_mask, &good_mask, high_slices);
> >   	if (compat_maskp && !fixed)
> > -		slice_andnot_mask(&potential_mask, &potential_mask, compat_maskp);
> > +		slice_andnot_mask(&potential_mask, &potential_mask, compat_maskp, high_slices);
> >   	if (potential_mask.low_slices ||
> >   		(SLICE_NUM_HIGH &&
> > -		 !bitmap_empty(potential_mask.high_slices, SLICE_NUM_HIGH))) {
> > +		 !bitmap_empty(potential_mask.high_slices, high_slices))) {  
> 
> Are we sure high_slices is not nul here when SLICE_NUM_HIGH is not nul ?

On 64/s it should be for 64-bit processes, but perhaps not 32. I have
to look into that, so another good catch.

Perhaps I will leave this patch off the series for now because I didn't
measure much difference. Aneesh wants to expand address space even more,
so I might revisit after his patches go in, to see if the optimistation
becomes worthwhile.

Thanks,
Nick
