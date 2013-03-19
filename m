Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62A932C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 09:59:20 +1100 (EST)
Received: from mail137-co9 (localhost [127.0.0.1])	by
 mail137-co9-R.bigfish.com (Postfix) with ESMTP id AE9E93A00F5	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 22:59:15 +0000 (UTC)
Received: from CO9EHSMHS008.bigfish.com (unknown [10.236.132.226])	by
 mail137-co9.bigfish.com (Postfix) with ESMTP id A51132E04F2	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 22:59:13 +0000 (UTC)
Date: Tue, 19 Mar 2013 17:59:11 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EB717E@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Mar 19 02:55:58 2013)
Message-ID: <1363733951.16671.35@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
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

On 03/19/2013 02:55:58 AM, Wang Dongsheng-B40534 wrote:
> > > +static void convert_ticks_to_time(struct timer_group_priv *priv,
> > > +		const u64 ticks, struct timeval *time) {
> > > +	u64 tmp_sec;
> > > +	u32 rem_us;
> > > +	u32 div;
> > > +
> > > +	if (!(priv->flags & FSL_GLOBAL_TIMER)) {
> > > +		time->tv_sec =3D (__kernel_time_t)
> > > +			div_u64_rem(ticks, priv->timerfreq, &rem_us);
> > > +		tmp_sec =3D (u64)time->tv_sec * (u64)priv->timerfreq;
> > > +		time->tv_usec =3D (__kernel_suseconds_t)
> > > +			div_u64((ticks - tmp_sec) * 1000000,
> > > priv->timerfreq);
> > > +
> > > +		return;
> > > +	}
> > > +
> > > +	div =3D (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
> > > +
> > > +	time->tv_sec =3D (__kernel_time_t)div_u64(ticks, priv->timerfreq
> > > / div);
> > > +	tmp_sec =3D div_u64((u64)time->tv_sec * (u64)priv->timerfreq,
> > > div);
> > > +
> > > +	time->tv_usec =3D (__kernel_suseconds_t)
> > > +		div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq /
> > > div);
> > > +
> > > +	return;
> >
> > Why don't you just adjust the clock frequency up front for =20
> CLKDIV_64,
> > rather than introduce alternate (and untested!) code paths =20
> throughout the
> > driver?
> >
> No, It cannot be integrated. The div cannot be removed.
> Because if do priv->timerfreq /=3D div, that will affect the accuracy.
>=20
> Like:
> 3 * 5 / 2 =3D 7;
> 3 / 2 * 5 =3D 5;

I don't follow -- a change in the clock speed is a change in the clock =20
speed, no matter how you accomplish it.

How you round is a different question.  You should probably be rounding =20
up always, based on the final clock frequency -- though it's unlikely =20
to matter much given the high precision of the timer relative to the =20
input granularity.

> BTW
> if (!(priv->flags & FSL_GLOBAL_TIMER)) {
> 	time->tv_sec =3D (__kernel_time_t)
> 		div_u64_rem(ticks, priv->timerfreq, &rem_us);
> 	tmp_sec =3D (u64)time->tv_sec * (u64)priv->timerfreq;
> 	time->tv_usec =3D (__kernel_suseconds_t)
> 		div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq);
>=20
> 	return;
> }
> This branch I has been tested.
>=20
> Test methods:
> 1. Get timerfreq and set timerfreq.
>    timerfreq /=3D 64;(Clock ratio is divide by 64)
>=20
> 2. Clear FSL_GLOBAL_TIMER flag.

Even if it was tested once, it's unlikely to continue to be tested =20
without a user.

-Scott=
