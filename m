Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0134.outbound.protection.outlook.com [207.46.100.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B75B01A0591
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 03:07:08 +1000 (AEST)
Message-ID: <1438276013.2993.357.camel@freescale.com>
Subject: Re: [RFC v2] genalloc:add an gen_pool_first_fit_align algo to genalloc
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "lauraa@codeaurora.org" <lauraa@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "olof@lixom.net"
 <olof@lixom.net>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "Xie
 Xiaobo-R63061" <X.Xie@freescale.com>
Date: Thu, 30 Jul 2015 12:06:53 -0500
In-Reply-To: <SN1PR0301MB1550595DB65EF4319109C95A9B8B0@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1437991074-35377-1-git-send-email-qiang.zhao@freescale.com>
 <1438032043.2993.311.camel@freescale.com>
 <SN1PR0301MB155080E4B7B2313969E30DAC9B8D0@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1438186761.2993.337.camel@freescale.com>
 <SN1PR0301MB1550595DB65EF4319109C95A9B8B0@SN1PR0301MB1550.namprd03.prod.outlook.com>
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

On Wed, 2015-07-29 at 20:27 -0500, Zhao Qiang-B45475 wrote:
> On Thu, 2015-07-30 at 5:21, Scott Wood wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, July 30, 2015 12:19 AM
> > To: Zhao Qiang-B45475
> > Cc: lauraa@codeaurora.org; linux-kernel@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; akpm@linux-foundation.org; olof@lixom.net;
> > catalin.marinas@arm.com; Xie Xiaobo-R63061
> > Subject: Re: [RFC v2] genalloc:add an gen_pool_first_fit_align algo to
> > genalloc
> > 
> > On Tue, 2015-07-28 at 00:32 -0500, Zhao Qiang-B45475 wrote:
> > > On Tue, 2015-07-28 at 5:21, Scott Wood wrote:
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Tuesday, July 28, 2015 5:21 AM
> > > > To: Zhao Qiang-B45475
> > > > Cc: lauraa@codeaurora.org; linux-kernel@vger.kernel.org; linuxppc-
> > > > dev@lists.ozlabs.org; akpm@linux-foundation.org; olof@lixom.net;
> > > > catalin.marinas@arm.com; Xie Xiaobo-R63061
> > > > Subject: Re: [RFC v2] genalloc:add an gen_pool_first_fit_align algo
> > > > to genalloc
> > > > 
> > > > On Mon, 2015-07-27 at 17:57 +0800, Zhao Qiang wrote:
> > > > 
> > > > Where's the part that adds the ability to pass in data to each
> > > > allocation call, as per the previous discussion?
> > > 
> > > You means to use gen_pool_alloc_data()?
> > 
> > Yes.
> > 
> > > Previously you said that the format of data is algorithm-specific, So
> > > I think it is better to handle data in algorithm function.
> > 
> > It is a channel for communication from the API caller to the algorithm.
> > 
> > > If you still prefer gen_pool_alloc_data(), I will modify it.
> > > But there still are details I want to confirm with you.
> > > 1. If use gen_pool_alloc_data(), should I pass data as a parameter?
> > 
> > Yes.
> > 
> > > 2. Should I count align_mask in gen_pool_alloc_data(), meanwhile, add
> > >    a align_mask to data as a member?
> > 
> > gen_pool_alloc_data() should just pass data to the algorithm.  The
> > algorithm should calculate align_mask based on align.  I don't think
> > exposing align_mask to API users would be very friendly.
> 
> If calculate align_mask in algorithm, I need to get pool->min_alloc_order 
> in algorithm,
> Like:
>                order = data->pool->min_alloc_order;
>                align_mask = ((data->align + (1UL << order) - 1) >> order) - 
> 1; 
> so I add pool to structure data as a member. Is there any other better 
> idea? 

Pass pool as a parameter to the algorithm.

-Scott
