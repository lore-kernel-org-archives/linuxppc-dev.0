Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C400A2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 09:54:40 +1100 (EST)
Received: from mail215-co9 (localhost [127.0.0.1])	by
 mail215-co9-R.bigfish.com (Postfix) with ESMTP id E94C422010F	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 22:54:35 +0000 (UTC)
Received: from CO9EHSMHS012.bigfish.com (unknown [10.236.132.243])	by
 mail215-co9.bigfish.com (Postfix) with ESMTP id B1E99480049	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 22:54:34 +0000 (UTC)
Date: Tue, 19 Mar 2013 17:54:32 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EB7111@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Mar 19 01:25:42 2013)
Message-ID: <1363733672.16671.34@snotra>
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

On 03/19/2013 01:25:42 AM, Wang Dongsheng-B40534 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, March 19, 2013 8:31 AM
> > To: Wang Dongsheng-B40534
> > Cc: Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org; Wang =20
> Dongsheng-
> > B40534; Zhao Chenhui-B35336; Li Yang-R58472
> > Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
> >
> > On 03/08/2013 01:38:47 AM, Wang Dongsheng wrote:
> > > +static ssize_t fsl_timer_wakeup_store(struct device *dev,
> > > +				struct device_attribute *attr,
> > > +				const char *buf,
> > > +				size_t count)
> > > +{
> > > +	struct timeval interval;
> > > +	int ret;
> > > +
> > > +	interval.tv_usec =3D 0;
> > > +	if (kstrtol(buf, 0, &interval.tv_sec))
> > > +		return -EINVAL;
> >
> > I don't think the buffer will NUL-terminated...  Ordinarily =20
> there'll be
> > an LF terminator, but you can't rely on that (many other sysfs =20
> attributes
> > seem to, though...).
> >
> I think we don't need to care about LF terminator.
> The kstrtol--> _kstrtoull has been done.

My point is, what happens if userspace passes in a buffer that has no =20
terminator of any sort?  kstrtol will continue reading beyond the end =20
of the buffer.

> > > +	mutex_lock(&sysfs_lock);
> > > +
> > > +	if (fsl_wakeup->timer && !interval.tv_sec) {
> > > +		disable_irq_wake(fsl_wakeup->timer->irq);
> > > +		mpic_free_timer(fsl_wakeup->timer);
> > > +		fsl_wakeup->timer =3D NULL;
> > > +		mutex_unlock(&sysfs_lock);
> > > +
> > > +		return count;
> > > +	}
> > > +
> > > +	if (fsl_wakeup->timer) {
> > > +		mutex_unlock(&sysfs_lock);
> > > +		return -EBUSY;
> > > +	}
> >
> > So to change an already-set timer you have to set it to zero and =20
> then to
> > what you want?  Why not just do:
> >
> > 	if (fsl_wakeup->timer) {
> > 		disable_irq_wake(...);
> > 		mpic_free_timer(...);
> > 		fsl_wakeup_timer =3D NULL;
> > 	}
> >
> > 	if (!interval.tv_sec) {
> > 		mutex_unlock(&sysfs_lock);
> > 		return count;
> > 	}
> >
> You can't break up the it.
> if echo zero the code will cancel the timer that is currently running.
> Not echo non-zero value just zero to cancel.

Echoing a nonzero value wouldn't just be to cancel, it would be to set =20
a new timer after cancelling the old.

> > > +	for (i =3D 0; mpic_attributes[i]; i++) {
> > > +		ret =3D device_create_file(mpic_subsys.dev_root,
> > > +					mpic_attributes[i]);
> > > +		if (ret)
> > > +			goto err2;
> > > +	}
> >
> > Is this code ever going to register more than one?
> >
> No, just one. I only keep the style here.
> If you don't think it's necessary I can remove this loop.

I don't think it's necessary.

-Scott=
