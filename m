Return-Path: <tomof@acm.org>
Received: from mfo11.iij4u.or.jp (mfo11.iij4u.or.jp [210.138.174.81])
	by ozlabs.org (Postfix) with ESMTP id C9360DDDEB
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 19:30:03 +1100 (EST)
Date: Fri, 28 Dec 2007 16:48:33 +0900
To: balbir@linux.vnet.ibm.com
Subject: Re: SCSI errors on powerpc with 2.6.24-rc6-mm1
From: FUJITA Tomonori <tomof@acm.org>
In-Reply-To: <4774A74B.3000105@linux.vnet.ibm.com>
References: <47733C01.1080002@linux.vnet.ibm.com>
	<20071228143043U.fujita.tomonori@lab.ntt.co.jp>
	<4774A74B.3000105@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20071228165115O.tomof@acm.org>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 28 Dec 2007 13:05:39 +0530
Balbir Singh <balbir@linux.vnet.ibm.com> wrote:

> FUJITA Tomonori wrote:
> [snip]
> > Thanks,
> > 
> > Can you try this?
> > 
> > 
> > diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
> > index e7d8544..495575a 100644
> > --- a/lib/iommu-helper.c
> > +++ b/lib/iommu-helper.c
> > @@ -8,15 +8,20 @@
> >  static unsigned long find_next_zero_area(unsigned long *map,
> >  					 unsigned long size,
> >  					 unsigned long start,
> > -					 unsigned int nr)
> > +					 unsigned int nr,
> > +					 unsigned long align_mask)
> >  {
> >  	unsigned long index, end, i;
> >  again:
> >  	index = find_next_zero_bit(map, size, start);
> > +
> > +	/* Align allocation */
> > +	index = (index + align_mask) & ~align_mask;
> > +
> >  	end = index + nr;
> > -	if (end > size)
> > +	if (end >= size)
> >  		return -1;
> > -	for (i = index + 1; i < end; i++) {
> > +	for (i = index; i < end; i++) {
> >  		if (test_bit(i, map)) {
> >  			start = i+1;
> >  			goto again;
> > @@ -50,9 +55,8 @@ unsigned long iommu_area_alloc(unsigned long *map, unsigned long size,
> >  {
> >  	unsigned long index;
> >  again:
> > -	index = find_next_zero_area(map, size, start, nr);
> > +	index = find_next_zero_area(map, size, start, nr, align_mask);
> >  	if (index != -1) {
> > -		index = (index + align_mask) & ~align_mask;
> >  		if (is_span_boundary(index, nr, shift, boundary_size)) {
> >  			/* we could do more effectively */
> >  			start = index + 1;
> 
> This on top of -mm? Or on top of the reverted iommu patch.

Oops, it's for -mm.

Thanks,
