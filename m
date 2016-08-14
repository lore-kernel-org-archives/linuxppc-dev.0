Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCBQ00L9xzDr3N
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 07:21:27 +1000 (AEST)
Message-ID: <1471209670.12231.60.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: populate the default bus with
 machine_arch_initcall
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robh@kernel.org>, Kevin Hao <haokexin@gmail.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Date: Mon, 15 Aug 2016 07:21:10 +1000
In-Reply-To: <CAL_Jsq+_K-uU7bFkSm-tq-Q0DPhQt4j=f84OzQSCJFEC29O-8A@mail.gmail.com>
References: <1470913781-9204-1-git-send-email-haokexin@gmail.com>
 <87k2fmtxbv.fsf@concordia.ellerman.id.au>
 <20160812054934.GJ17275@pek-khao-d1>
 <CAL_Jsq+_K-uU7bFkSm-tq-Q0DPhQt4j=f84OzQSCJFEC29O-8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-08-12 at 14:30 -0500, Rob Herring wrote:
> 
> > With the commit 44a7185c2ae6 ("of/platform: Add common method to
> > populate default bus"), a default function is introduced to
> > populate
> > the default bus and this function is invoked at the
> > arch_initcall_sync
> > level. But a lot of ppc boards use machine_device_initcall() to
> > populate the default bus. This means that the default populate
> > function
> > has higher priority and would override the arch specific population
> > of
> > the bus. The side effect is that some arch specific bus are not
> > probed,
> > then cause various malfunction due to the miss of some devices.
> > Since
> > it is very possible to introduce bugs if we simply change the
> > initcall
> > level for all these boards(about 30+). This just disable this
> > default
> > function for all the ppc boards.
> > 
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  drivers/of/platform.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> I've applied this one.

Not fan of the hard #ifdef at all... it will make it hard to convert
platforms one by one. Why not an arch_want_default_of_probe() or
something like this which we can then plumb into ppc_md. ?

Cheers,
Ben.
