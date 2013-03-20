Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8754F2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 08:49:15 +1100 (EST)
Received: from mail107-co9 (localhost [127.0.0.1])	by
 mail107-co9-R.bigfish.com (Postfix) with ESMTP id 346242C009E	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 21:49:10 +0000 (UTC)
Received: from CO9EHSMHS015.bigfish.com (unknown [10.236.132.233])	by
 mail107-co9.bigfish.com (Postfix) with ESMTP id 2D53CC005C	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 21:49:08 +0000 (UTC)
Date: Wed, 20 Mar 2013 16:48:58 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EB7712@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Mar 19 22:48:53 2013)
Message-ID: <1363816138.25034.21@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/19/2013 10:48:53 PM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, March 20, 2013 6:55 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Gala Kumar-B11780; =20
> linuxppc-dev@lists.ozlabs.org;
> > Zhao Chenhui-B35336; Li Yang-R58472
> > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
> >
> > On 03/19/2013 01:25:42 AM, Wang Dongsheng-B40534 wrote:
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Tuesday, March 19, 2013 8:31 AM
> > > > To: Wang Dongsheng-B40534
> > > > Cc: Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org; Wang
> > > Dongsheng-
> > > > B40534; Zhao Chenhui-B35336; Li Yang-R58472
> > > > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup =20
> support
> > > >
> > > > On 03/08/2013 01:38:47 AM, Wang Dongsheng wrote:
> > > > > +static ssize_t fsl_timer_wakeup_store(struct device *dev,
> > > > > +				struct device_attribute *attr,
> > > > > +				const char *buf,
> > > > > +				size_t count)
> > > > > +{
> > > > > +	struct timeval interval;
> > > > > +	int ret;
> > > > > +
> > > > > +	interval.tv_usec =3D 0;
> > > > > +	if (kstrtol(buf, 0, &interval.tv_sec))
> > > > > +		return -EINVAL;
> > > >
> > > > I don't think the buffer will NUL-terminated...  Ordinarily
> > > there'll be
> > > > an LF terminator, but you can't rely on that (many other sysfs
> > > attributes
> > > > seem to, though...).
> > > >
> > > I think we don't need to care about LF terminator.
> > > The kstrtol--> _kstrtoull has been done.
> >
> > My point is, what happens if userspace passes in a buffer that has =20
> no
> > terminator of any sort?  kstrtol will continue reading beyond the =20
> end of
> > the buffer.
> >
> Do not care about terminator.

kstrtol() obviously *does* because it doesn't take the buffer length as =20
a parameter.

> kstrtol--> _kstrtoull--> _parse_integer
>=20
> _kstrtoull(...) {
> 	...
> 	rv =3D _parse_integer(s, base, &_res);
> 	if (rv & KSTRTOX_OVERFLOW)
> 		return -ERANGE;
> 	rv &=3D ~KSTRTOX_OVERFLOW;
> 	if (rv =3D=3D 0)
> 		return -EINVAL;
> 	s +=3D rv;
>=20
> 	if (*s =3D=3D '\n')
> 		s++;
> 	if (*s)
> 		return -EINVAL;
> 	...
> }
>=20
> _parse_integer(...) {
> 	...
> 	while (*s) {
> 		if ('0' <=3D *s && *s <=3D '9')
> 			val =3D *s - '0';
> 		else if ('a' <=3D _tolower(*s) && _tolower(*s) <=3D 'f')
> 			val =3D _tolower(*s) - 'a' + 10;
> 		else
> 			break;	//this will break out to convert.

Really?  How do you know that the next byte after the buffer isn't a =20
valid hex digit?  How do you even know that we won't take a fault =20
accessing it?

> > Echoing a nonzero value wouldn't just be to cancel, it would be to =20
> set a
> > new timer after cancelling the old.
> >
> If you think this way is better, I can change.

I do.

> But why should do it?
> Explicitly stop the timer (echo 0) before reuse it is more reasonable =20
> for me.

It's an unnecessary restriction, and eliminating it doesn't make =20
anything simpler.

-Scott=
