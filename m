Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0109.outbound.protection.outlook.com [157.56.110.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4696C1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 14:03:10 +1000 (AEST)
Message-ID: <1442980978.19102.321.camel@freescale.com>
Subject: Re: [PATCH v10 3/5] CPM/QE: use genalloc to manage CPM/QE muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Tue, 22 Sep 2015 23:02:58 -0500
In-Reply-To: <SN1PR0301MB1550F7AC5D2885AD97B30CE59B440@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1442560521-19354-1-git-send-email-qiang.zhao@freescale.com>
 <1442560521-19354-3-git-send-email-qiang.zhao@freescale.com>
 <20150921224720.GA12709@home.buserror.net>
 <SN1PR0301MB1550726A1D45051888E35EB59B450@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1442967567.19102.318.camel@freescale.com>
 <SN1PR0301MB1550F7AC5D2885AD97B30CE59B440@SN1PR0301MB1550.namprd03.prod.outlook.com>
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

On Tue, 2015-09-22 at 21:20 -0500, Zhao Qiang-B45475 wrote:
> On Wen, Sep 23, 2015 at 8:19 AM +0800, Wood Scott-B07421 wrote:
> 
> > > > >  {
> > > > > - int ret;
> > > > > +
> > > > > + unsigned long start;
> > > > >   unsigned long flags;
> > > > > + unsigned long size_alloc = size; struct muram_block *entry; int
> > > > > + end_bit; int order = muram_pool->min_alloc_order;
> > > > > 
> > > > >   spin_lock_irqsave(&cpm_muram_lock, flags);
> > > > > - ret = rh_free(&cpm_muram_info, offset);
> > > > > + end_bit = (offset >> order) + ((size + (1UL << order) - 1) >>
> > > > order);
> > > > > + if ((offset + size) > (end_bit << order))
> > > > > +         size_alloc = size + (1UL << order);
> > > > 
> > > > Why do you need to do all these calculations here?
> > > 
> > > So do it in gen_pool_fixed_alloc?
> > 
> > Could you explain why they're needed at all?
> 
> Why it does the calculations? 
> If the min block of gen_pool is 8 bytes, and I want to allocate a 
> Region with offset=7, size=8bytes, I actually need block 0 and block 1,
> And the allocation will give me block 0.  

How can you have offset 7 if the minimum order is 2 bytes?

-Scott
