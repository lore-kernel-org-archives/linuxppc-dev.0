Return-Path: <B40534@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 096712C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 17:15:01 +1100 (EST)
Received: from mail52-am1 (localhost [127.0.0.1])	by mail52-am1-R.bigfish.com
 (Postfix) with ESMTP id CFCA11A00BD	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 22 Mar 2013 06:14:55 +0000 (UTC)
Received: from AM1EHSMHS016.bigfish.com (unknown [10.3.201.254])	by
 mail52-am1.bigfish.com (Postfix) with ESMTP id 8254B2A0261	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 06:14:53 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/3] powerpc/mpic: add global timer support
Date: Fri, 22 Mar 2013 06:14:51 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EB857A@039-SN2MPN1-022.039d.mgd.msft.net>
References: <ABB05CD9C9F68C46A5CEDC7F15439259EB77BB@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Wed Mar 20 01:45:03 2013)
 <1363820378.25034.31@snotra>
In-Reply-To: <1363820378.25034.31@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, March 21, 2013 7:00 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org;
> Li Yang-R58472
> Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
>=20
> On 03/20/2013 01:45:03 AM, Wang Dongsheng-B40534 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Wednesday, March 20, 2013 6:59 AM
> > > To: Wang Dongsheng-B40534
> > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > linuxppc-dev@lists.ozlabs.org;
> > > Li Yang-R58472
> > > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
> > >
> > > On 03/19/2013 02:55:58 AM, Wang Dongsheng-B40534 wrote:
> > > > > > +static void convert_ticks_to_time(struct timer_group_priv
> > *priv,
> > > > > > +		const u64 ticks, struct timeval *time) {
> > > > > > +	u64 tmp_sec;
> > > > > > +	u32 rem_us;
> > > > > > +	u32 div;
> > > > > > +
> > > > > > +	if (!(priv->flags & FSL_GLOBAL_TIMER)) {
> > > > > > +		time->tv_sec =3D (__kernel_time_t)
> > > > > > +			div_u64_rem(ticks, priv->timerfreq,
> > &rem_us);
> > > > > > +		tmp_sec =3D (u64)time->tv_sec *
> > (u64)priv->timerfreq;
> > > > > > +		time->tv_usec =3D (__kernel_suseconds_t)
> > > > > > +			div_u64((ticks - tmp_sec) * 1000000,
> > > > > > priv->timerfreq);
> > > > > > +
> > > > > > +		return;
> > > > > > +	}
> > > > > > +
> > > > > > +	div =3D (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
> > > > > > +
> > > > > > +	time->tv_sec =3D (__kernel_time_t)div_u64(ticks, priv-
> > > >timerfreq
> > > > > > / div);
> > > > > > +	tmp_sec =3D div_u64((u64)time->tv_sec *
> > (u64)priv->timerfreq,
> > > > > > div);
> > > > > > +
> > > > > > +	time->tv_usec =3D (__kernel_suseconds_t)
> > > > > > +		div_u64((ticks - tmp_sec) * 1000000,
> > priv->timerfreq /
> > > > > > div);
> > > > > > +
> > > > > > +	return;
> > > > >
> > > > > Why don't you just adjust the clock frequency up front for
> > > > CLKDIV_64,
> > > > > rather than introduce alternate (and untested!) code paths
> > > > throughout the
> > > > > driver?
> > > > >
> > > > No, It cannot be integrated. The div cannot be removed.
> > > > Because if do priv->timerfreq /=3D div, that will affect the
> > accuracy.
> > > >
> > > > Like:
> > > > 3 * 5 / 2 =3D 7;
> > > > 3 / 2 * 5 =3D 5;
> > >
> > > I don't follow -- a change in the clock speed is a change in the
> > clock
> > > speed, no matter how you accomplish it.
> > >
> > This is not change hardware clock frequency.
>=20
> Citation needed.  It looks like a change in the timer frequency to me:
>=20
>    Clock ratio. Specifies the ratio of the timer frequency to the MPIC
> input clock (platform clock/2) . The
>    following clock ratios are supported:
>    00
>    01
>    10
>    11
>    Default. Divide by 8
>    Divide by 16
>    Divide by 32
>    Divide by 64
>=20
> The end result is that the counter in the timer register changes only
> 1/64 as often as the input clock.  There's nothing special about that,
> compared to having an input clock that is 1/64 the speed.
>=20
> > The mpic timer hardware clock is not be changed after initialization.
> > This is just conversion ticks.
> > These calculated ticks will be set to the hardware.
> >
> > > How you round is a different question.  You should probably be
> > rounding
> > > up always, based on the final clock frequency -- though it's
> > unlikely to
> > > matter much given the high precision of the timer relative to the
> > input
> > > granularity.
> > >
> > Each ticks are based on the mpic timer hardware clock frequency.
> > The conversion and calculation are in order to make the tick value is
> > more
> > accurate, more close to real time.
> > If echo 40 seconds may be difference is not obvious. But echo
> > 315360000(10 years)
> > difference is obvious.
>=20
> So basically you're taking advantage of the fact that you have what
> appears to be a more precise value of the frequency than is expressible
> in integer Hz -- but I think that's false precision; odds are the
> frequency is not accurate to 1 Hz to begin with.  Even if it is, I doubt
> it's worth worrying about.  The error as a percentage will still be very
> small with an input frequency of many MHz.  Does an error of a few
> minutes really matter if you're delaying for 10 years?  That's
> acceptable
> clock drift for something not synced to network time.  The main thing is
> to ensure that you round up, not down, so that software doesn't see an
> early wakeup as measured by its own timers.
>=20
> BTW, the input clock frequency has been similarly scaled, yet you don't
> try to scrounge up that information to get further precision...
>=20
Let's go back patch, do you think the code is repeated?
I will remove "if (!(priv->flags & FSL_GLOBAL_TIMER))" branch, there will b=
e no redundant code.
