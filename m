Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0103.outbound.protection.outlook.com [207.46.100.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B71FD1A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 15:08:43 +1000 (AEST)
Message-ID: <1443157709.32298.104.camel@freescale.com>
Subject: Re: [PATCH v10 3/5] CPM/QE: use genalloc to manage CPM/QE muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Fri, 25 Sep 2015 00:08:29 -0500
In-Reply-To: <SN1PR0301MB155054D1577D5F4B5724BD4A9B420@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1442560521-19354-1-git-send-email-qiang.zhao@freescale.com>
 <1442560521-19354-3-git-send-email-qiang.zhao@freescale.com>
 <20150921224720.GA12709@home.buserror.net>
 <SN1PR0301MB1550726A1D45051888E35EB59B450@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1442967567.19102.318.camel@freescale.com>
 <SN1PR0301MB1550F7AC5D2885AD97B30CE59B440@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1442980978.19102.321.camel@freescale.com>
 <SN1PR0301MB155040D7F785F40B2B07E6219B440@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1443137406.32298.74.camel@freescale.com>
 <SN1PR0301MB155054D1577D5F4B5724BD4A9B420@SN1PR0301MB1550.namprd03.prod.outlook.com>
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

On Thu, 2015-09-24 at 21:50 -0500, Zhao Qiang-B45475 wrote:
> On Fri, Sep 25, 2015 at 7:30 AM +0800, Wood Scott-B07421 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, September 25, 2015 7:30 AM
> > To: Zhao Qiang-B45475
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> > Yang-Leo-R58472; paulus@samba.org
> > Subject: Re: [PATCH v10 3/5] CPM/QE: use genalloc to manage CPM/QE muram
> > 
> > On Wed, 2015-09-23 at 00:28 -0500, Zhao Qiang-B45475 wrote:
> > > On Wen, Sep 23, 2015 at 12:03 AM +0800, Wood Scott-B07421 wrote:
> > > 
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Wednesday, September 23, 2015 12:03 PM
> > > > To: Zhao Qiang-B45475
> > > > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org;
> > > > Li Yang-Leo-R58472; paulus@samba.org
> > > > Subject: Re: [PATCH v10 3/5] CPM/QE: use genalloc to manage CPM/QE
> > > > muram
> > > > 
> > > > On Tue, 2015-09-22 at 21:20 -0500, Zhao Qiang-B45475 wrote:
> > > > > On Wen, Sep 23, 2015 at 8:19 AM +0800, Wood Scott-B07421 wrote:
> > > > > 
> > > > > > > > >  {
> > > > > > > > > - int ret;
> > > > > > > > > +
> > > > > > > > > + unsigned long start;
> > > > > > > > >   unsigned long flags;
> > > > > > > > > + unsigned long size_alloc = size; struct muram_block
> > > > > > > > > + *entry; int end_bit; int order =
> > > > > > > > > + muram_pool->min_alloc_order;
> > > > > > > > > 
> > > > > > > > >   spin_lock_irqsave(&cpm_muram_lock, flags);
> > > > > > > > > - ret = rh_free(&cpm_muram_info, offset);
> > > > > > > > > + end_bit = (offset >> order) + ((size + (1UL << order) -
> > > > > > > > > + 1)
> > > > > > > > > + >>
> > > > > > > > order);
> > > > > > > > > + if ((offset + size) > (end_bit << order))
> > > > > > > > > +         size_alloc = size + (1UL << order);
> > > > > > > > 
> > > > > > > > Why do you need to do all these calculations here?
> > > > > > > 
> > > > > > > So do it in gen_pool_fixed_alloc?
> > > > > > 
> > > > > > Could you explain why they're needed at all?
> > > > > 
> > > > > Why it does the calculations?
> > > > > If the min block of gen_pool is 8 bytes, and I want to allocate a
> > > > > Region with offset=7, size=8bytes, I actually need block 0 and
> > > > > block 1, And the allocation will give me block 0.
> > > > 
> > > > How can you have offset 7 if the minimum order is 2 bytes?
> > > 
> > > Offset has no relationship with minimum order, it is not decided by
> > > minimum order.
> > 
> > All allocations begin and end on a multiple of the minimum order.
> 
> So it is the problem. CPM require to allocate a specific region,
> who can ensure that the specific is just the begin of minimum order.

Do you have any reason to believe that there is any caller of this function 
with an odd address?

If so, set the minimum order to zero.  If not, what is the problem?

> So the algo will find the first block covering the specific region's 
> Start address, then because my specific region's start address is not equal
> To the address returned by algo, the end address is not equal to my 
> specific region's end address, so the calculation is to keep the end 
> address larger than specific region's end address.
> 
> > 
> > > I want to allocate a specific region with offset=7, then algo to
> > > calculate the block bit.
> > > And I just take it for example, it is not I really need to region
> > offset=7.
> > 
> > Do you really need any fixed allocations that begin on an odd address?
> 
> Maybe I don’t need an odd address, but the calculation is needed in case.

No.  "In case" the caller does something that is not allowed, the allocation 
should fail.

-Scott
