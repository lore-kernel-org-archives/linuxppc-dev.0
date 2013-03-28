Return-Path: <B40534@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6BFC22C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 13:29:36 +1100 (EST)
Received: from mail201-co9 (localhost [127.0.0.1])	by
 mail201-co9-R.bigfish.com (Postfix) with ESMTP id 2CE4D3C00A7	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 02:29:30 +0000 (UTC)
Received: from CO9EHSMHS019.bigfish.com (unknown [10.236.132.237])	by
 mail201-co9.bigfish.com (Postfix) with ESMTP id 9270F8010B	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 02:29:27 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/3] powerpc/mpic: add global timer support
Date: Thu, 28 Mar 2013 02:29:26 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EBBE13@039-SN2MPN1-022.039d.mgd.msft.net>
References: <ABB05CD9C9F68C46A5CEDC7F15439259EB857A@039-SN2MPN1-022.039d.mgd.msft.net>
 <1363991395.24790.13@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EBAA0F@039-SN2MPN1-022.039d.mgd.msft.net>
 <1364319099.469.6@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EBB72D@039-SN2MPN1-022.039d.mgd.msft.net>
 <1364404295.31930.1@snotra>
In-Reply-To: <1364404295.31930.1@snotra>
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
> Sent: Thursday, March 28, 2013 1:12 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org;
> Li Yang-R58472
> Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
>=20
> On 03/26/2013 10:23:38 PM, Wang Dongsheng-B40534 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Wednesday, March 27, 2013 1:32 AM
> > > To: Wang Dongsheng-B40534
> > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > linuxppc-dev@lists.ozlabs.org;
> > > Li Yang-R58472
> > > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
> > >
> > > On 03/25/2013 10:29:58 PM, Wang Dongsheng-B40534 wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Wood Scott-B07421
> > > > > Sent: Saturday, March 23, 2013 6:30 AM
> > > > > To: Wang Dongsheng-B40534
> > > > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > > > linuxppc-dev@lists.ozlabs.org;
> > > > > Li Yang-R58472
> > > > > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
> > > > >
> > > > > On 03/22/2013 01:14:51 AM, Wang Dongsheng-B40534 wrote:
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Wood Scott-B07421
> > > > > > > Sent: Thursday, March 21, 2013 7:00 AM
> > > > > > > To: Wang Dongsheng-B40534
> > > > > > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > > > > > linuxppc-dev@lists.ozlabs.org;
> > > > > > > Li Yang-R58472
> > > > > > > Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer
> > support
> > > > > > >
> > > > > > > BTW, the input clock frequency has been similarly scaled,
> > yet
> > > > you
> > > > > > don't
> > > > > > > try to scrounge up that information to get further
> > precision...
> > > > > > >
> > > > > > Let's go back patch, do you think the code is repeated?
> > > > > > I will remove "if (!(priv->flags & FSL_GLOBAL_TIMER))" branch,
> > > > there
> > > > > > will be no redundant code.
> > > > >
> > > > > I'd rather that branch be kept and the more complicated branch
> > > > deleted,
> > > > > and priv->timerfreq frequency be adjusted on initialization to
> > > > account
> > > > > for the scaler.
> > > >
> > > > static void convert_ticks_to_time(struct timer_group_priv *priv,
> > > >                 const u64 ticks, struct timeval *time) {
> > > >         u64 tmp_sec;
> > > >
> > > >         time->tv_sec =3D (__kernel_time_t)div_u64(ticks,
> > > > priv->timerfreq);
> > > >         tmp_sec =3D (u64)time->tv_sec * (u64)priv->timerfreq;
> > > >
> > > >         time->tv_usec =3D (__kernel_suseconds_t)
> > > >                 div_u64((ticks - tmp_sec) * 1000000,
> > priv->timerfreq);
> > > >
> > > >         return;
> > > > }
> > > >
> > > > timer_group_get_freq() {
> > > > 	...
> > > > 	if (priv->flags & FSL_GLOBAL_TIMER) {
> > > > 		div =3D (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
> > > > 		priv->timerfreq /=3D div;
> > > > 	}
> > > > 	...
> > > > }
> > > > Do you want to do that?
> > >
> > > 	if (priv->flags & FSL_GLOBAL_TIMER)
> > > 		priv->timerfreq /=3D 64;
> > >
> > > ...but otherwise yes.
> > Ok, I would like do this.
> >
> > if (priv->flags & FSL_GLOBAL_TIMER) {
> > 	div =3D (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
> > 	priv->timerfreq /=3D div;
>=20
> Why?  What do you get out of that obfuscation?
>=20
Change MPIC_TIMER_TCR_CLKDIV_64 to MPIC_TIMER_TCR_CLKDIV

/* Clock Ratio
 * Divide by 64 0x00000300
 * Divide by 32 0x00000200
 * Divide by 16 0x00000100
 * Divide by  8 0x00000000 (Hardware default div)
 */
#define MPIC_TIMER_TCR_CLKDIV 0x00000300

timer_group_init() {
	...
	/* Init FSL timer hardware */
      if (priv->flags & FSL_GLOBAL_TIMER)
      	setbits32(priv->group_tcr, MPIC_TIMER_TCR_CLKDIV);
	...
}

mpic_timer_resume() {
	...
	/* Init FSL timer hardware */
      if (priv->flags & FSL_GLOBAL_TIMER)
      	setbits32(priv->group_tcr, MPIC_TIMER_TCR_CLKDIV);
	...
}

Because macro is friendly, and other functions also used the macro.
