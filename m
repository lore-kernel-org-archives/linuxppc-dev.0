Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0131.outbound.protection.outlook.com [157.56.110.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A1E81A0017
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 15:50:27 +1100 (AEDT)
Message-ID: <1445921408.701.303.camel@freescale.com>
Subject: Re: [PATCH v12 3/6] CPM/QE: use genalloc to manage CPM/QE muram
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Mon, 26 Oct 2015 23:50:08 -0500
In-Reply-To: <SN1PR0301MB15504A8672AFF152F56D48C19B230@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1444806968-4627-1-git-send-email-qiang.zhao@freescale.com>
 <1444806968-4627-3-git-send-email-qiang.zhao@freescale.com>
 <1445569177.701.133.camel@freescale.com>
 <SN1PR0301MB1550906A0C2A2F6BA4EF807D9B260@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1445633947.701.231.camel@freescale.com>
 <SN1PR0301MB15504A8672AFF152F56D48C19B230@SN1PR0301MB1550.namprd03.prod.outlook.com>
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

On Sun, 2015-10-25 at 22:15 -0500, Zhao Qiang-B45475 wrote:
> On Sat, 2015-10-24 at 04:59 AM, Wood Scott-B07421 <scottwood@freescale.com> 
> wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, October 24, 2015 4:59 AM
> > To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061 <X.Xie@freescale.com>;
> > benh@kernel.crashing.org; Li Yang-Leo-R58472 <LeoLi@freescale.com>;
> > paulus@samba.org
> > Subject: Re: [PATCH v12 3/6] CPM/QE: use genalloc to manage CPM/QE muram
> > 
> > Don't send HTML e-mail.
> > 
> > On Fri, 2015-10-23 at 02:06 -0500, Zhao Qiang-B45475 wrote:
> > > On Fri, 2015-10-23 at 11:00 AM, Wood Scott-B07421
> > > <scottwood@freescale.com>
> > > wrote:
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Friday, October 23, 2015 11:00 AM
> > > > To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
> > > > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > > lauraa@codeaurora.org; Xie Xiaobo-R63061 <X.Xie@freescale.com>;
> > > > benh@kernel.crashing.org; Li Yang-Leo-R58472 <LeoLi@freescale.com>;
> > > > paulus@samba.org
> > > > Subject: Re: [PATCH v12 3/6] CPM/QE: use genalloc to manage CPM/QE
> > > > muram
> > > > 
> > > > On Wed, 2015-10-14 at 15:16 +0800, Zhao Qiang wrote:
> > > > > -/**
> > > > > +/*
> > > > >   * cpm_muram_alloc - allocate the requested size worth of
> > > > > multi-user
> > > ram
> > > > >   * @size: number of bytes to allocate
> > > > >   * @align: requested alignment, in bytes @@ -141,59 +151,102 @@ 
> > > > > out:
> > > > >   */
> > > > >  unsigned long cpm_muram_alloc(unsigned long size, unsigned long
> > > > > align)  {
> > > > > -     unsigned long start;
> > > > >       unsigned long flags;
> > > > > -
> > > > > +     unsigned long start;
> > > > > +     static struct genpool_data_align muram_pool_data;
> > > > >       spin_lock_irqsave(&cpm_muram_lock, flags);
> > > > > -     cpm_muram_info.alignment = align;
> > > > > -     start = rh_alloc(&cpm_muram_info, size, "commproc");
> > > > > -     memset(cpm_muram_addr(start), 0, size);
> > > > > +     muram_pool_data.align = align;
> > > > > +     gen_pool_set_algo(muram_pool, gen_pool_first_fit_align,
> > > > > +                       &muram_pool_data);
> > > > > +     start = cpm_muram_alloc_common(size, &muram_pool_data);
> > > > >       spin_unlock_irqrestore(&cpm_muram_lock, flags);
> > > > > -
> > > > >       return start;
> > > > >  }
> > > > >  EXPORT_SYMBOL(cpm_muram_alloc);
> > > > 
> > > > Why is muram_pool_data static?  Why is it being passed to
> > > > gen_pool_set_algo()?
> > > Cpm_muram use both align algo and fixed algo, so we need to set
> > > corresponding algo and Algo data.
> > 
> > The data gets passed in via gen_pool_alloc_data().  The point was to 
> > allow it to
> > be on the caller's stack, not a long-lived data structure shared by all 
> > callers and
> > needing synchronization.
> 
> You mean it is not necessary to point pool->data to data, just passing the 
> data to gen_pool_alloc_data()?
> However, the algo it needed to be set.
> 
> > 
> > > > The whole reason we're adding gen_pool_alloc_data()  is to avoid
> > > > that.  Do we need gen_pool_alloc_algo() too?
> > > 
> > > We add gen_pool_alloc_data() to pass data to algo, because align algo
> > > and fixed algo, Because align and fixed algos need specific data.
> > 
> > And my point is that because of that, it seems like we need a version that
> > accepts an algorithm as well.
> 
> It the user just use only one algo, it doesn’t need to set algo, 
> However, qe_muram use two algos with alloc_align function
> And alloc_fixed function.

Yes.  That is why gen_pool_alloc_data() does not accomplish what we want.  
When we were discussing gen_pool_alloc_data(), you had not yet mentioned the 
need for fixed allocations.

-Scott
