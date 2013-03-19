Return-Path: <B40534@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 546662C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 18:56:09 +1100 (EST)
Received: from mail6-db3 (localhost [127.0.0.1])	by mail6-db3-R.bigfish.com
 (Postfix) with ESMTP id 3ED5F48006B	for <linuxppc-dev@lists.ozlabs.org>; Tue,
 19 Mar 2013 07:56:03 +0000 (UTC)
Received: from DB3EHSMHS019.bigfish.com (unknown [10.3.81.228])	by
 mail6-db3.bigfish.com (Postfix) with ESMTP id EA39B2E004A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 07:56:01 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/3] powerpc/mpic: add global timer support
Date: Tue, 19 Mar 2013 07:55:58 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EB717E@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1362728327-21013-2-git-send-email-dongsheng.wang@freescale.com>
 (from dongsheng.wang@freescale.com on Fri Mar  8 01:38:46 2013)
 <1363650392.27435.22@snotra>
In-Reply-To: <1363650392.27435.22@snotra>
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

> > +static void convert_ticks_to_time(struct timer_group_priv *priv,
> > +		const u64 ticks, struct timeval *time) {
> > +	u64 tmp_sec;
> > +	u32 rem_us;
> > +	u32 div;
> > +
> > +	if (!(priv->flags & FSL_GLOBAL_TIMER)) {
> > +		time->tv_sec =3D (__kernel_time_t)
> > +			div_u64_rem(ticks, priv->timerfreq, &rem_us);
> > +		tmp_sec =3D (u64)time->tv_sec * (u64)priv->timerfreq;
> > +		time->tv_usec =3D (__kernel_suseconds_t)
> > +			div_u64((ticks - tmp_sec) * 1000000,
> > priv->timerfreq);
> > +
> > +		return;
> > +	}
> > +
> > +	div =3D (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
> > +
> > +	time->tv_sec =3D (__kernel_time_t)div_u64(ticks, priv->timerfreq
> > / div);
> > +	tmp_sec =3D div_u64((u64)time->tv_sec * (u64)priv->timerfreq,
> > div);
> > +
> > +	time->tv_usec =3D (__kernel_suseconds_t)
> > +		div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq /
> > div);
> > +
> > +	return;
>=20
> Why don't you just adjust the clock frequency up front for CLKDIV_64,
> rather than introduce alternate (and untested!) code paths throughout the
> driver?
>=20
No, It cannot be integrated. The div cannot be removed.
Because if do priv->timerfreq /=3D div, that will affect the accuracy.

Like:
3 * 5 / 2 =3D 7;
3 / 2 * 5 =3D 5;

BTW
if (!(priv->flags & FSL_GLOBAL_TIMER)) {
	time->tv_sec =3D (__kernel_time_t)
		div_u64_rem(ticks, priv->timerfreq, &rem_us);
	tmp_sec =3D (u64)time->tv_sec * (u64)priv->timerfreq;
	time->tv_usec =3D (__kernel_suseconds_t)
		div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq);

	return;
}
This branch I has been tested.

Test methods:
1. Get timerfreq and set timerfreq.
   timerfreq /=3D 64;(Clock ratio is divide by 64)

2. Clear FSL_GLOBAL_TIMER flag.

Test Log:
[root@p5020 root]# echo 20 > /sys/devices/system/mpic/timer_wakeup
[root@p5020 root]# cat /sys/devices/system/mpic/timer_wakeup
sec =3D 18, ticks =3D 118295518.., timerfreq =3D 6249999..
19
[root@p5020 root]# cat /sys/devices/system/mpic/timer_wakeup
sec =3D 17, ticks =3D 110095766.., timerfreq =3D 6249999..
18
[root@p5020 root]# cat /sys/devices/system/mpic/timer_wakeup
sec =3D 16, ticks =3D 105095737.., timerfreq =3D 6249999..
17
[root@p5020 root]# cat /sys/devices/system/mpic/timer_wakeup
sec =3D 15, ticks =3D 99495711.., timerfreq =3D 6249999..
16
