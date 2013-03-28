Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A3D112C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 06:48:08 +1100 (EST)
Received: from mail211-co9 (localhost [127.0.0.1])	by
 mail211-co9-R.bigfish.com (Postfix) with ESMTP id 63D0880272	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 19:48:04 +0000 (UTC)
Received: from CO9EHSMHS001.bigfish.com (unknown [10.236.132.237])	by
 mail211-co9.bigfish.com (Postfix) with ESMTP id 3919B46004E	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 19:48:03 +0000 (UTC)
Date: Thu, 28 Mar 2013 14:47:59 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <ABB05CD9C9F68C46A5CEDC7F15439259EB857A@039-SN2MPN1-022.039d.mgd.msft.net>
 <1363991395.24790.13@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EBAA0F@039-SN2MPN1-022.039d.mgd.msft.net>
 <1364319099.469.6@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EBB72D@039-SN2MPN1-022.039d.mgd.msft.net>
 <1364404295.31930.1@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EBBE13@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EBBE13@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Wed Mar 27 21:29:26 2013)
Message-ID: <1364500079.32327.10@snotra>
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

On 03/27/2013 09:29:26 PM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, March 28, 2013 1:12 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Gala Kumar-B11780; =20
> linuxppc-dev@lists.ozlabs.org;
> > Li Yang-R58472
> > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
> >
> > On 03/26/2013 10:23:38 PM, Wang Dongsheng-B40534 wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Wednesday, March 27, 2013 1:32 AM
> > > > To: Wang Dongsheng-B40534
> > > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > > linuxppc-dev@lists.ozlabs.org;
> > > > Li Yang-R58472
> > > > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
> > > >
> > > > On 03/25/2013 10:29:58 PM, Wang Dongsheng-B40534 wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Wood Scott-B07421
> > > > > > Sent: Saturday, March 23, 2013 6:30 AM
> > > > > > To: Wang Dongsheng-B40534
> > > > > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > > > > linuxppc-dev@lists.ozlabs.org;
> > > > > > Li Yang-R58472
> > > > > > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer =20
> support
> > > > > >
> > > > > > On 03/22/2013 01:14:51 AM, Wang Dongsheng-B40534 wrote:
> > > > > > >
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Wood Scott-B07421
> > > > > > > > Sent: Thursday, March 21, 2013 7:00 AM
> > > > > > > > To: Wang Dongsheng-B40534
> > > > > > > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > > > > > > linuxppc-dev@lists.ozlabs.org;
> > > > > > > > Li Yang-R58472
> > > > > > > > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer
> > > support
> > > > > > > >
> > > > > > > > BTW, the input clock frequency has been similarly =20
> scaled,
> > > yet
> > > > > you
> > > > > > > don't
> > > > > > > > try to scrounge up that information to get further
> > > precision...
> > > > > > > >
> > > > > > > Let's go back patch, do you think the code is repeated?
> > > > > > > I will remove "if (!(priv->flags & FSL_GLOBAL_TIMER))" =20
> branch,
> > > > > there
> > > > > > > will be no redundant code.
> > > > > >
> > > > > > I'd rather that branch be kept and the more complicated =20
> branch
> > > > > deleted,
> > > > > > and priv->timerfreq frequency be adjusted on initialization =20
> to
> > > > > account
> > > > > > for the scaler.
> > > > >
> > > > > static void convert_ticks_to_time(struct timer_group_priv =20
> *priv,
> > > > >                 const u64 ticks, struct timeval *time) {
> > > > >         u64 tmp_sec;
> > > > >
> > > > >         time->tv_sec =3D (__kernel_time_t)div_u64(ticks,
> > > > > priv->timerfreq);
> > > > >         tmp_sec =3D (u64)time->tv_sec * (u64)priv->timerfreq;
> > > > >
> > > > >         time->tv_usec =3D (__kernel_suseconds_t)
> > > > >                 div_u64((ticks - tmp_sec) * 1000000,
> > > priv->timerfreq);
> > > > >
> > > > >         return;
> > > > > }
> > > > >
> > > > > timer_group_get_freq() {
> > > > > 	...
> > > > > 	if (priv->flags & FSL_GLOBAL_TIMER) {
> > > > > 		div =3D (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * =20
> 8;
> > > > > 		priv->timerfreq /=3D div;
> > > > > 	}
> > > > > 	...
> > > > > }
> > > > > Do you want to do that?
> > > >
> > > > 	if (priv->flags & FSL_GLOBAL_TIMER)
> > > > 		priv->timerfreq /=3D 64;
> > > >
> > > > ...but otherwise yes.
> > > Ok, I would like do this.
> > >
> > > if (priv->flags & FSL_GLOBAL_TIMER) {
> > > 	div =3D (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
> > > 	priv->timerfreq /=3D div;
> >
> > Why?  What do you get out of that obfuscation?
> >
> Change MPIC_TIMER_TCR_CLKDIV_64 to MPIC_TIMER_TCR_CLKDIV

OK, that would at least provide the ability to adjust the clock divider =20
in one place rather than two -- though I don't know why we'd ever need =20
to change the divider.

> Because macro is friendly, and other functions also used the macro.

Using the macro rather than hardcoding register bit encodings is =20
friendly.  The calculation to turn the bit encoding into an actual =20
divider value is not particularly friendly.

-Scott=
