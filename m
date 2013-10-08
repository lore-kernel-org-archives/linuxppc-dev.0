Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A994F2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 01:50:21 +1100 (EST)
Received: from mail11-db9 (localhost [127.0.0.1])	by mail11-db9-R.bigfish.com
 (Postfix) with ESMTP id A9FDFC0064	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 14:50:15 +0000 (UTC)
Received: from DB9EHSMHS025.bigfish.com (unknown [10.174.16.237])	by
 mail11-db9.bigfish.com (Postfix) with ESMTP id 54ACD30006B	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 14:50:14 +0000 (UTC)
Message-ID: <1381243807.7979.198.camel@snotra.buserror.net>
Subject: Re: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Tue, 8 Oct 2013 09:50:07 -0500
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F1543925901094898@039-SN2MPN1-021.039d.mgd.msft.net>
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
 <1380582385.24959.542.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F1543925901094898@039-SN2MPN1-021.039d.mgd.msft.net>
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

On Mon, 2013-10-07 at 22:58 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, October 01, 2013 7:06 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Bhushan Bharat-R65777; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20 state and
> > altivec idle
> > 
> > On Sun, 2013-09-29 at 01:57 -0500, Wang Dongsheng-B40534 wrote:
> > > I think we need to do this:
> > >
> > > #define U64_LOW_MASK            0xffffffffULL
> > > #define U64_MASK                0xffffffffffffffffULL
> > >
> > >         u32 tmp_rem;
> > >         u64 ns_u_rem, ns_u, ns_l, ns_l_carry;
> > >         u64 cycle;
> > >
> > >         ns_u = ns >> 32;
> > >         ns_l = ns & U64_LOW_MASK;
> > >
> > >         ns_l *= tb_ticks_per_usec;
> > >         ns_l_carry = ns_l >> 32;
> > >         ns_u *= tb_ticks_per_usec;
> > >         ns_u += ns_l_carry;
> > >
> > >         ns_u = div_u64_rem(ns_u, 1000, &tmp_rem);
> > >         ns_u_rem = tmp_rem;
> > >         ns_l = (ns_l & U64_LOW_MASK) | ((ns_u_rem) << 32);
> > >         ns_l = div_u64(ns_l, 1000);
> > >
> > >         if (ns_u >> 32)
> > >                 cycle = U64_MASK;
> > >         else
> > >                 cycle = (ns_u << 32) | (ns_l & U64_LOW_MASK);
> > >
> > > I has already tested this code, and works good. :)
> > 
> > Ugh.  I don't think we need to get this complicated (and I'd rather not
> > spend the time verifying the correctness of this).
> > 
> > If for some reason we did need something like this in some other context
> > (I don't want to see it just for pw20), I'd be more inclined to see
> > general 128-bit mult/divide support.
> > 
> I would like to use my version,:), because it can handle any situation and we do not need to restrict users.

It also would take more time to review than I have to spend on it, not
to mention the impact on anyone in the future that wants to understand
or maintain this code -- all for very unlikely situations (and the
"failure" in those very unlikely situations is just that we go into PW20
more often than intended).

-Scott
