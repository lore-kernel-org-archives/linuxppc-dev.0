Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0141.outbound.protection.outlook.com [157.56.110.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6D1E1A0214
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 16:47:26 +1000 (AEST)
Message-ID: <1436424433.2658.122.camel@freescale.com>
Subject: Re: [PATCH 2/2] rheap: move rheap.c from arch/powerpc/lib/ to lib/
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xie
 Xiaobo-R63061" <X.Xie@freescale.com>
Date: Thu, 9 Jul 2015 01:47:13 -0500
In-Reply-To: <SN1PR0301MB1550000498E21C586CA9B52B9B900@SN1PR0301MB1550.namprd03.prod.outlook.com>
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
 <1436413840.2658.113.camel@freescale.com>
 <SN1PR0301MB1550CBF05BAD7AB19EC244519B900@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1436422143.2658.121.camel@freescale.com>
 <SN1PR0301MB1550000498E21C586CA9B52B9B900@SN1PR0301MB1550.namprd03.prod.outlook.com>
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

On Thu, 2015-07-09 at 01:14 -0500, Zhao Qiang-B45475 wrote:
> On Wed, 2015-07-09 at 02:09PM -0500, Wood Scott wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, July 09, 2015 2:09 PM
> > To: Zhao Qiang-B45475
> > Cc: linuxppc-dev@lists.ozlabs.org; Xie Xiaobo-R63061
> > Subject: Re: [PATCH 2/2] rheap: move rheap.c from arch/powerpc/lib/ to
> > lib/
> > 
> > On Thu, 2015-07-09 at 01:05 -0500, Zhao Qiang-B45475 wrote:
> > > On Wed, 2015-07-09 at 11:51 -0500, Wood Scott wrote:
> > > 
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Thursday, July 09, 2015 11:51 AM
> > > > To: Zhao Qiang-B45475
> > > > Cc: linuxppc-dev@lists.ozlabs.org; Xie Xiaobo-R63061
> > > > Subject: Re: [PATCH 2/2] rheap: move rheap.c from arch/powerpc/lib/
> > > > to lib/
> > > > 
> > > > That doesn't involve a different alignment for each allocation.  It
> > > > uses the same alignment for all of them, and the alignment that
> > > > cpm_common.c provides to rh_init() is 1 byte.
> > > > 
> > > > ...but sigh, cpm_muram_alloc() is changing cpm_muram_info.alignment
> > > > behind the rheap code's back.  Despite the existence of
> > rh_alloc_align().
> > > > 
> > > > So yes, add aligned allocation functionality to genalloc, but don't
> > > > duplicate
> > > > gen_pool_alloc() to do so.  Instead, rename gen_pool_alloc() to
> > > > gen_pool_alloc_align() with an alignment parameter (also modifying
> > > > the algo function to take an alignment arg, which
> > > > gen_pool_first_fit_order_align() would ignore), and provide a
> > > 
> > > Here, I don’t understand how to handle the algo In your mind.
> > > Can you explain more detailly?
> > 
> > The algorithms would be unchanged except that they would receive a new
> > alignment (or alignment mask) parameter.  gen_pool_first_fit_order_align()
> > would ignore it, but the other algorithms would pass it through to the
> > bitmap allocator.
> 
> How about to add an align_mask parameter to gen_pool_first_fit? 

All of the algorithms have to have the same function signature.

-Scott
