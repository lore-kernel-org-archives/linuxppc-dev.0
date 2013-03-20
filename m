Return-Path: <B40534@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 843082C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 17:45:12 +1100 (EST)
Received: from mail21-co9 (localhost [127.0.0.1])	by mail21-co9-R.bigfish.com
 (Postfix) with ESMTP id 9C05FC0128	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 20 Mar 2013 06:45:07 +0000 (UTC)
Received: from CO9EHSMHS015.bigfish.com (unknown [10.236.132.239])	by
 mail21-co9.bigfish.com (Postfix) with ESMTP id CDC5D1C01D0	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 06:45:05 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/3] powerpc/mpic: add global timer support
Date: Wed, 20 Mar 2013 06:45:03 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EB77BB@039-SN2MPN1-022.039d.mgd.msft.net>
References: <ABB05CD9C9F68C46A5CEDC7F15439259EB717E@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Mar 19 02:55:58 2013)
 <1363733951.16671.35@snotra>
In-Reply-To: <1363733951.16671.35@snotra>
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
> Sent: Wednesday, March 20, 2013 6:59 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org;
> Li Yang-R58472
> Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
>=20
> On 03/19/2013 02:55:58 AM, Wang Dongsheng-B40534 wrote:
> > > > +static void convert_ticks_to_time(struct timer_group_priv *priv,
> > > > +		const u64 ticks, struct timeval *time) {
> > > > +	u64 tmp_sec;
> > > > +	u32 rem_us;
> > > > +	u32 div;
> > > > +
> > > > +	if (!(priv->flags & FSL_GLOBAL_TIMER)) {
> > > > +		time->tv_sec =3D (__kernel_time_t)
> > > > +			div_u64_rem(ticks, priv->timerfreq, &rem_us);
> > > > +		tmp_sec =3D (u64)time->tv_sec * (u64)priv->timerfreq;
> > > > +		time->tv_usec =3D (__kernel_suseconds_t)
> > > > +			div_u64((ticks - tmp_sec) * 1000000,
> > > > priv->timerfreq);
> > > > +
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	div =3D (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
> > > > +
> > > > +	time->tv_sec =3D (__kernel_time_t)div_u64(ticks, priv-
> >timerfreq
> > > > / div);
> > > > +	tmp_sec =3D div_u64((u64)time->tv_sec * (u64)priv->timerfreq,
> > > > div);
> > > > +
> > > > +	time->tv_usec =3D (__kernel_suseconds_t)
> > > > +		div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq /
> > > > div);
> > > > +
> > > > +	return;
> > >
> > > Why don't you just adjust the clock frequency up front for
> > CLKDIV_64,
> > > rather than introduce alternate (and untested!) code paths
> > throughout the
> > > driver?
> > >
> > No, It cannot be integrated. The div cannot be removed.
> > Because if do priv->timerfreq /=3D div, that will affect the accuracy.
> >
> > Like:
> > 3 * 5 / 2 =3D 7;
> > 3 / 2 * 5 =3D 5;
>=20
> I don't follow -- a change in the clock speed is a change in the clock
> speed, no matter how you accomplish it.
>=20
This is not change hardware clock frequency. The mpic timer hardware clock
is not be changed after initialization. This is just conversion ticks.
These calculated ticks will be set to the hardware.

> How you round is a different question.  You should probably be rounding
> up always, based on the final clock frequency -- though it's unlikely to
> matter much given the high precision of the timer relative to the input
> granularity.
>=20
Each ticks are based on the mpic timer hardware clock frequency.
The conversion and calculation are in order to make the tick value is more
accurate, more close to real time.
If echo 40 seconds may be difference is not obvious. But echo 315360000(10 =
years)
difference is obvious.
