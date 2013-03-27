Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C92B62C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 04:11:51 +1100 (EST)
Received: from mail51-db8 (localhost [127.0.0.1])	by mail51-db8-R.bigfish.com
 (Postfix) with ESMTP id E5161DA01A0	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 27 Mar 2013 17:11:41 +0000 (UTC)
Received: from DB8EHSMHS027.bigfish.com (unknown [10.174.8.233])	by
 mail51-db8.bigfish.com (Postfix) with ESMTP id 77D7D3C0065	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 17:11:40 +0000 (UTC)
Date: Wed, 27 Mar 2013 12:11:35 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <ABB05CD9C9F68C46A5CEDC7F15439259EB857A@039-SN2MPN1-022.039d.mgd.msft.net>
 <1363991395.24790.13@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EBAA0F@039-SN2MPN1-022.039d.mgd.msft.net>
 <1364319099.469.6@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EBB72D@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EBB72D@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Mar 26 22:23:38 2013)
Message-ID: <1364404295.31930.1@snotra>
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

On 03/26/2013 10:23:38 PM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, March 27, 2013 1:32 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Gala Kumar-B11780; =20
> linuxppc-dev@lists.ozlabs.org;
> > Li Yang-R58472
> > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
> >
> > On 03/25/2013 10:29:58 PM, Wang Dongsheng-B40534 wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Saturday, March 23, 2013 6:30 AM
> > > > To: Wang Dongsheng-B40534
> > > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > > linuxppc-dev@lists.ozlabs.org;
> > > > Li Yang-R58472
> > > > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
> > > >
> > > > On 03/22/2013 01:14:51 AM, Wang Dongsheng-B40534 wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Wood Scott-B07421
> > > > > > Sent: Thursday, March 21, 2013 7:00 AM
> > > > > > To: Wang Dongsheng-B40534
> > > > > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > > > > linuxppc-dev@lists.ozlabs.org;
> > > > > > Li Yang-R58472
> > > > > > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer =20
> support
> > > > > >
> > > > > > BTW, the input clock frequency has been similarly scaled, =20
> yet
> > > you
> > > > > don't
> > > > > > try to scrounge up that information to get further =20
> precision...
> > > > > >
> > > > > Let's go back patch, do you think the code is repeated?
> > > > > I will remove "if (!(priv->flags & FSL_GLOBAL_TIMER))" branch,
> > > there
> > > > > will be no redundant code.
> > > >
> > > > I'd rather that branch be kept and the more complicated branch
> > > deleted,
> > > > and priv->timerfreq frequency be adjusted on initialization to
> > > account
> > > > for the scaler.
> > >
> > > static void convert_ticks_to_time(struct timer_group_priv *priv,
> > >                 const u64 ticks, struct timeval *time) {
> > >         u64 tmp_sec;
> > >
> > >         time->tv_sec =3D (__kernel_time_t)div_u64(ticks,
> > > priv->timerfreq);
> > >         tmp_sec =3D (u64)time->tv_sec * (u64)priv->timerfreq;
> > >
> > >         time->tv_usec =3D (__kernel_suseconds_t)
> > >                 div_u64((ticks - tmp_sec) * 1000000, =20
> priv->timerfreq);
> > >
> > >         return;
> > > }
> > >
> > > timer_group_get_freq() {
> > > 	...
> > > 	if (priv->flags & FSL_GLOBAL_TIMER) {
> > > 		div =3D (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
> > > 		priv->timerfreq /=3D div;
> > > 	}
> > > 	...
> > > }
> > > Do you want to do that?
> >
> > 	if (priv->flags & FSL_GLOBAL_TIMER)
> > 		priv->timerfreq /=3D 64;
> >
> > ...but otherwise yes.
> Ok, I would like do this.
>=20
> if (priv->flags & FSL_GLOBAL_TIMER) {
> 	div =3D (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
> 	priv->timerfreq /=3D div;

Why?  What do you get out of that obfuscation?

-Scott=
