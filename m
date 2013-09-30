Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 73EA12C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 09:06:38 +1000 (EST)
Received: from mail157-co1 (localhost [127.0.0.1])	by
 mail157-co1-R.bigfish.com (Postfix) with ESMTP id E1AE7C400F5	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 23:06:30 +0000 (UTC)
Received: from CO1EHSMHS030.bigfish.com (unknown [10.243.78.233])	by
 mail157-co1.bigfish.com (Postfix) with ESMTP id 552E0C004B	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 23:06:28 +0000 (UTC)
Message-ID: <1380582385.24959.542.camel@snotra.buserror.net>
Subject: Re: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Mon, 30 Sep 2013 18:06:25 -0500
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259010920B0@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1380014925-23300-2-git-send-email-dongsheng.wang@freescale.com>
 <1380014925-23300-4-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0717F8F9@039-SN2MPN1-011.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F154392590108FF41@039-SN2MPN1-021.039d.mgd.msft.net>
 <1380131815.24959.185.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010909C3@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07183D0B@039-SN2MPN1-011.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F1543925901090B4F@039-SN2MPN1-021.039d.mgd.msft.net>
 <1380231435.24959.328.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010911C2@039-SN2MPN1-021.039d.mgd.msft.net>
 <1380317594.24959.490.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010920B0@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-09-29 at 01:57 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, September 28, 2013 5:33 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Bhushan Bharat-R65777; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20 state and
> > altivec idle
> > 
> > On Thu, 2013-09-26 at 22:34 -0500, Wang Dongsheng-B40534 wrote:
> > > cycle = div_u64(ns * tb_ticks_per_usec, 1000); It's look good.
> > > But why we need:
> > > 	if (ns >= 10000)
> > > 		cycle = ((ns + 500) / 1000) * tb_ticks_per_usec; ?
> > >
> > > I think "cycle = div_u64(ns * tb_ticks_per_usec, 1000)" is good
> > > enough. :)
> > 
> > It's to deal with overflow if a very large value of ns is provided
> > (and/or tb_ticks_per_usec is larger than we expect).
> > 
> :), as I think, it's to deal with overflow. But you version cannot do deal with it.
> Because ns is u64, if ns > 0xffffffff_fffffe0b, ns + 500 will overflow, And if tb_ticks_per_usec > 1000 and ns > (0xffffffff_ffffffff / 10) cycle also will overflow.

Sigh... It significantly increases the value of ns at which you'll get
overflow problems. :-)  I was more concerned with
large-but-somewhat-reasonable values of ns (e.g. than with trying to
handle every possible input.  Even without that test, getting overflow
is stretching the bounds of reasonableness (e.g. a 1 GHz timebase would
require a timeout of over 7 months to overflow), but it was low-hanging
fruit.  And the worst case is we go to pw20 sooner than the user wanted,
so let's not go too overboard.

I doubt you would see > 0xffffffff_fffffe0b except if someone is trying
to disable it by setting 0xffffffff_ffffffff even though a separate API
is provided to cleanly disable it.

> I think we need to do this:
> 
> #define U64_LOW_MASK            0xffffffffULL
> #define U64_MASK                0xffffffffffffffffULL
> 
>         u32 tmp_rem;
>         u64 ns_u_rem, ns_u, ns_l, ns_l_carry;
>         u64 cycle;
> 
>         ns_u = ns >> 32;
>         ns_l = ns & U64_LOW_MASK;
> 
>         ns_l *= tb_ticks_per_usec;
>         ns_l_carry = ns_l >> 32;
>         ns_u *= tb_ticks_per_usec;
>         ns_u += ns_l_carry;
> 
>         ns_u = div_u64_rem(ns_u, 1000, &tmp_rem);
>         ns_u_rem = tmp_rem;
>         ns_l = (ns_l & U64_LOW_MASK) | ((ns_u_rem) << 32);
>         ns_l = div_u64(ns_l, 1000);
> 
>         if (ns_u >> 32)
>                 cycle = U64_MASK;
>         else
>                 cycle = (ns_u << 32) | (ns_l & U64_LOW_MASK);
> 
> I has already tested this code, and works good. :)

Ugh.  I don't think we need to get this complicated (and I'd rather not
spend the time verifying the correctness of this).

If for some reason we did need something like this in some other context
(I don't want to see it just for pw20), I'd be more inclined to see
general 128-bit mult/divide support.

-Scott
