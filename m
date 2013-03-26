Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4A802C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 04:31:50 +1100 (EST)
Received: from mail213-co9 (localhost [127.0.0.1])	by
 mail213-co9-R.bigfish.com (Postfix) with ESMTP id AEA21A00AB	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 17:31:45 +0000 (UTC)
Received: from CO9EHSMHS012.bigfish.com (unknown [10.236.132.237])	by
 mail213-co9.bigfish.com (Postfix) with ESMTP id 0C1802E0056	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 17:31:44 +0000 (UTC)
Date: Tue, 26 Mar 2013 12:31:39 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <ABB05CD9C9F68C46A5CEDC7F15439259EB857A@039-SN2MPN1-022.039d.mgd.msft.net>
 <1363991395.24790.13@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EBAA0F@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EBAA0F@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Mon Mar 25 22:29:58 2013)
Message-ID: <1364319099.469.6@snotra>
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

On 03/25/2013 10:29:58 PM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, March 23, 2013 6:30 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Gala Kumar-B11780; =20
> linuxppc-dev@lists.ozlabs.org;
> > Li Yang-R58472
> > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
> >
> > On 03/22/2013 01:14:51 AM, Wang Dongsheng-B40534 wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Thursday, March 21, 2013 7:00 AM
> > > > To: Wang Dongsheng-B40534
> > > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > > linuxppc-dev@lists.ozlabs.org;
> > > > Li Yang-R58472
> > > > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
> > > >
> > > > BTW, the input clock frequency has been similarly scaled, yet =20
> you
> > > don't
> > > > try to scrounge up that information to get further precision...
> > > >
> > > Let's go back patch, do you think the code is repeated?
> > > I will remove "if (!(priv->flags & FSL_GLOBAL_TIMER))" branch, =20
> there
> > > will be no redundant code.
> >
> > I'd rather that branch be kept and the more complicated branch =20
> deleted,
> > and priv->timerfreq frequency be adjusted on initialization to =20
> account
> > for the scaler.
>=20
> static void convert_ticks_to_time(struct timer_group_priv *priv,
>                 const u64 ticks, struct timeval *time)
> {
>         u64 tmp_sec;
>=20
>         time->tv_sec =3D (__kernel_time_t)div_u64(ticks, =20
> priv->timerfreq);
>         tmp_sec =3D (u64)time->tv_sec * (u64)priv->timerfreq;
>=20
>         time->tv_usec =3D (__kernel_suseconds_t)
>                 div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq);
>=20
>         return;
> }
>=20
> timer_group_get_freq() {
> 	...
> 	if (priv->flags & FSL_GLOBAL_TIMER) {
> 		div =3D (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
> 		priv->timerfreq /=3D div;
> 	}
> 	...
> }
> Do you want to do that?

	if (priv->flags & FSL_GLOBAL_TIMER)
		priv->timerfreq /=3D 64;

...but otherwise yes.

-Scott=
