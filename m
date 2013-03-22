Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F8052C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 16:46:32 +1100 (EST)
Received: from mail7-ch1 (localhost [127.0.0.1])	by mail7-ch1-R.bigfish.com
 (Postfix) with ESMTP id 0F7323E0391	for <linuxppc-dev@lists.ozlabs.org>; Fri,
 22 Mar 2013 05:46:27 +0000 (UTC)
Received: from CH1EHSMHS026.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.232])	by mail7-ch1.bigfish.com (Postfix) with ESMTP id
 5F47460047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 05:46:25 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
Date: Fri, 22 Mar 2013 05:46:24 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EB854F@039-SN2MPN1-022.039d.mgd.msft.net>
References: <ABB05CD9C9F68C46A5CEDC7F15439259EB7712@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Mar 19 22:48:53 2013)
 <1363816138.25034.21@snotra>
In-Reply-To: <1363816138.25034.21@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
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



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, March 21, 2013 5:49 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org;
> Zhao Chenhui-B35336; Li Yang-R58472
> Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
>=20
> On 03/19/2013 10:48:53 PM, Wang Dongsheng-B40534 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Wednesday, March 20, 2013 6:55 AM
> > > To: Wang Dongsheng-B40534
> > > Cc: Wood Scott-B07421; Gala Kumar-B11780;
> > linuxppc-dev@lists.ozlabs.org;
> > > Zhao Chenhui-B35336; Li Yang-R58472
> > > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
> > >
> > > On 03/19/2013 01:25:42 AM, Wang Dongsheng-B40534 wrote:
> > > > > -----Original Message-----
> > > > > From: Wood Scott-B07421
> > > > > Sent: Tuesday, March 19, 2013 8:31 AM
> > > > > To: Wang Dongsheng-B40534
> > > > > Cc: Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org; Wang
> > > > Dongsheng-
> > > > > B40534; Zhao Chenhui-B35336; Li Yang-R58472
> > > > > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup
> > support
> > > > >
> > > > > On 03/08/2013 01:38:47 AM, Wang Dongsheng wrote:
> > > > > > +static ssize_t fsl_timer_wakeup_store(struct device *dev,
> > > > > > +				struct device_attribute *attr,
> > > > > > +				const char *buf,
> > > > > > +				size_t count)
> > > > > > +{
> > > > > > +	struct timeval interval;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	interval.tv_usec =3D 0;
> > > > > > +	if (kstrtol(buf, 0, &interval.tv_sec))
> > > > > > +		return -EINVAL;
> > > > >
> > > > > I don't think the buffer will NUL-terminated...  Ordinarily
> > > > there'll be
> > > > > an LF terminator, but you can't rely on that (many other sysfs
> > > > attributes
> > > > > seem to, though...).
> > > > >
> > > > I think we don't need to care about LF terminator.
> > > > The kstrtol--> _kstrtoull has been done.
> > >
> > > My point is, what happens if userspace passes in a buffer that has
> > no
> > > terminator of any sort?  kstrtol will continue reading beyond the
> > end of
> > > the buffer.
> > >
> > Do not care about terminator.
>=20
> kstrtol() obviously *does* because it doesn't take the buffer length as
> a parameter.
>=20
> > kstrtol--> _kstrtoull--> _parse_integer
> >
> > _kstrtoull(...) {
> > 	...
> > 	rv =3D _parse_integer(s, base, &_res);
> > 	if (rv & KSTRTOX_OVERFLOW)
> > 		return -ERANGE;
> > 	rv &=3D ~KSTRTOX_OVERFLOW;
> > 	if (rv =3D=3D 0)
> > 		return -EINVAL;
> > 	s +=3D rv;
> >
> > 	if (*s =3D=3D '\n')
> > 		s++;
> > 	if (*s)
> > 		return -EINVAL;
> > 	...
> > }
> >
> > _parse_integer(...) {
> > 	...
> > 	while (*s) {
> > 		if ('0' <=3D *s && *s <=3D '9')
> > 			val =3D *s - '0';
> > 		else if ('a' <=3D _tolower(*s) && _tolower(*s) <=3D 'f')
> > 			val =3D _tolower(*s) - 'a' + 10;
> > 		else
> > 			break;	//this will break out to convert.
>=20
> Really?  How do you know that the next byte after the buffer isn't a
> valid hex digit?  How do you even know that we won't take a fault
> accessing it?
>=20
Under what case is unsafe, please make sense.

"kstrtol" is used in almost of sysfs interface, I think it should be accept=
ed in defaule :).
