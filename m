Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0109.outbound.protection.outlook.com [207.46.100.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8EE91A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 13:50:55 +1000 (AEST)
Message-ID: <1436413840.2658.113.camel@freescale.com>
Subject: Re: [PATCH 2/2] rheap: move rheap.c from arch/powerpc/lib/ to lib/
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xie
 Xiaobo-R63061" <X.Xie@freescale.com>
Date: Wed, 8 Jul 2015 22:50:40 -0500
In-Reply-To: <CY1PR0301MB1545D6DA1DDAEEF3B2FC82E79B900@CY1PR0301MB1545.namprd03.prod.outlook.com>
References: <1432717920-43563-1-git-send-email-B45475@freescale.com>
 <1432717920-43563-2-git-send-email-B45475@freescale.com>
 <1432748213.4089.23.camel@freescale.com>
 <SN1PR0301MB15500729CC3A65394FED67389BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1433398423.3415.34.camel@freescale.com>
 <SN1PR0301MB1550B0B2F863A80559FE8B6B9BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1433457659.31070.2.camel@freescale.com>
 <SN1PR0301MB155069ED5F42D54AF2A769F09B910@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1436324117.2658.64.camel@freescale.com>
 <SN1PR0301MB1550F2C30F1393CA26F4FF3B9B910@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1436326077.2658.65.camel@freescale.com>
 <SN1PR0301MB155084FCD058F8EAAC5C5AEA9B910@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1436381938.2658.79.camel@freescale.com>
 <CY1PR0301MB1545D6DA1DDAEEF3B2FC82E79B900@CY1PR0301MB1545.namprd03.prod.outlook.com>
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

On Wed, 2015-07-08 at 22:18 -0500, Zhao Qiang-B45475 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, July 09, 2015 2:59 AM
> > To: Zhao Qiang-B45475
> > Cc: linuxppc-dev@lists.ozlabs.org; Xie Xiaobo-R63061
> > Subject: Re: [PATCH 2/2] rheap: move rheap.c from arch/powerpc/lib/ to
> > lib/
> >
> > On Wed, 2015-07-08 at 02:25 -0500, Zhao Qiang-B45475 wrote:
> > > So I will add two func for my use, do you think it is ok?
> > > I need to align the address of allocated muram.
> > > And I will set algo = gen_pool_first_fit_align.
> > >
> > > +unsigned long gen_pool_alloc_align(struct gen_pool *pool, size_t size,
> > > +               unsigned long align)
> >
> > Again, please explain why you need this for CPM/QE.  I don't see
> > rh_alloc_align() currently being used by either.
> >
> > Also, please stop top-posting.
>  
>  
> unsigned long rh_alloc(struct _rh_info *info, int size, const char *owner)
> {
>         return rh_alloc_align(info, size, info->alignment, owner);
> }
> EXPORT_SYMBOL_GPL(rh_alloc);

That doesn't involve a different alignment for each allocation.  It uses the 
same alignment for all of them, and the alignment that cpm_common.c provides 
to rh_init() is 1 byte.

...but sigh, cpm_muram_alloc() is changing cpm_muram_info.alignment behind 
the rheap code's back.  Despite the existence of rh_alloc_align().

So yes, add aligned allocation functionality to genalloc, but don't duplicate 
gen_pool_alloc() to do so.  Instead, rename gen_pool_alloc() to 
gen_pool_alloc_align() with an alignment parameter (also modifying the algo 
function to take an alignment arg, which gen_pool_first_fit_order_align() 
would ignore), and provide a gen_pool_alloc() wrapper that specifies 1 as the 
required alignment.  Also be sure to CC lkml on the patchset since you're 
touching core code that doesn't have its own maintainer or list.

-Scott
