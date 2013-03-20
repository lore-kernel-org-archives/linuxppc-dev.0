Return-Path: <B40534@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE2972C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 14:49:14 +1100 (EST)
Received: from mail190-tx2 (localhost [127.0.0.1])	by
 mail190-tx2-R.bigfish.com (Postfix) with ESMTP id 6B6E1300132	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 03:49:09 +0000 (UTC)
Received: from TX2EHSMHS020.bigfish.com (unknown [10.9.14.225])	by
 mail190-tx2.bigfish.com (Postfix) with ESMTP id 8E6882C0214	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 03:48:54 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
Date: Wed, 20 Mar 2013 03:48:53 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EB7712@039-SN2MPN1-022.039d.mgd.msft.net>
References: <ABB05CD9C9F68C46A5CEDC7F15439259EB7111@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Mar 19 01:25:42 2013)
 <1363733672.16671.34@snotra>
In-Reply-To: <1363733672.16671.34@snotra>
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
> Sent: Wednesday, March 20, 2013 6:55 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org;
> Zhao Chenhui-B35336; Li Yang-R58472
> Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
>=20
> On 03/19/2013 01:25:42 AM, Wang Dongsheng-B40534 wrote:
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Tuesday, March 19, 2013 8:31 AM
> > > To: Wang Dongsheng-B40534
> > > Cc: Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org; Wang
> > Dongsheng-
> > > B40534; Zhao Chenhui-B35336; Li Yang-R58472
> > > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
> > >
> > > On 03/08/2013 01:38:47 AM, Wang Dongsheng wrote:
> > > > +static ssize_t fsl_timer_wakeup_store(struct device *dev,
> > > > +				struct device_attribute *attr,
> > > > +				const char *buf,
> > > > +				size_t count)
> > > > +{
> > > > +	struct timeval interval;
> > > > +	int ret;
> > > > +
> > > > +	interval.tv_usec =3D 0;
> > > > +	if (kstrtol(buf, 0, &interval.tv_sec))
> > > > +		return -EINVAL;
> > >
> > > I don't think the buffer will NUL-terminated...  Ordinarily
> > there'll be
> > > an LF terminator, but you can't rely on that (many other sysfs
> > attributes
> > > seem to, though...).
> > >
> > I think we don't need to care about LF terminator.
> > The kstrtol--> _kstrtoull has been done.
>=20
> My point is, what happens if userspace passes in a buffer that has no
> terminator of any sort?  kstrtol will continue reading beyond the end of
> the buffer.
>=20
Do not care about terminator.

kstrtol--> _kstrtoull--> _parse_integer

_kstrtoull(...) {
	...
	rv =3D _parse_integer(s, base, &_res);
	if (rv & KSTRTOX_OVERFLOW)
		return -ERANGE;
	rv &=3D ~KSTRTOX_OVERFLOW;
	if (rv =3D=3D 0)
		return -EINVAL;
	s +=3D rv;

	if (*s =3D=3D '\n')
		s++;
	if (*s)
		return -EINVAL;
	...
}

_parse_integer(...) {
	...
	while (*s) {
		if ('0' <=3D *s && *s <=3D '9')
			val =3D *s - '0';
		else if ('a' <=3D _tolower(*s) && _tolower(*s) <=3D 'f')
			val =3D _tolower(*s) - 'a' + 10;
		else
			break;	//this will break out to convert.

		if (val >=3D base)
			break;
	}
	...
}

> > > > +	mutex_lock(&sysfs_lock);
> > > > +
> > > > +	if (fsl_wakeup->timer && !interval.tv_sec) {
> > > > +		disable_irq_wake(fsl_wakeup->timer->irq);
> > > > +		mpic_free_timer(fsl_wakeup->timer);
> > > > +		fsl_wakeup->timer =3D NULL;
> > > > +		mutex_unlock(&sysfs_lock);
> > > > +
> > > > +		return count;
> > > > +	}
> > > > +
> > > > +	if (fsl_wakeup->timer) {
> > > > +		mutex_unlock(&sysfs_lock);
> > > > +		return -EBUSY;
> > > > +	}
> > >
> > > So to change an already-set timer you have to set it to zero and
> > then to
> > > what you want?  Why not just do:
> > >
> > > 	if (fsl_wakeup->timer) {
> > > 		disable_irq_wake(...);
> > > 		mpic_free_timer(...);
> > > 		fsl_wakeup_timer =3D NULL;
> > > 	}
> > >
> > > 	if (!interval.tv_sec) {
> > > 		mutex_unlock(&sysfs_lock);
> > > 		return count;
> > > 	}
> > >
> > You can't break up the it.
> > if echo zero the code will cancel the timer that is currently running.
> > Not echo non-zero value just zero to cancel.
>=20
> Echoing a nonzero value wouldn't just be to cancel, it would be to set a
> new timer after cancelling the old.
>=20
If you think this way is better, I can change.
But why should do it?=20
Explicitly stop the timer (echo 0) before reuse it is more reasonable for m=
e.=20

> > > > +	for (i =3D 0; mpic_attributes[i]; i++) {
> > > > +		ret =3D device_create_file(mpic_subsys.dev_root,
> > > > +					mpic_attributes[i]);
> > > > +		if (ret)
> > > > +			goto err2;
> > > > +	}
> > >
> > > Is this code ever going to register more than one?
> > >
> > No, just one. I only keep the style here.
> > If you don't think it's necessary I can remove this loop.
>=20
> I don't think it's necessary.
>=20
Ok, I will remove this loop.
