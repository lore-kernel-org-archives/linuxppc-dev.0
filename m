Return-Path: <B40534@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D712E2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 17:25:50 +1100 (EST)
Received: from mail160-tx2 (localhost [127.0.0.1])	by
 mail160-tx2-R.bigfish.com (Postfix) with ESMTP id 3CBF01C01A4	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 06:25:46 +0000 (UTC)
Received: from TX2EHSMHS027.bigfish.com (unknown [10.9.14.234])	by
 mail160-tx2.bigfish.com (Postfix) with ESMTP id 29BD53E0048	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 06:25:44 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
Date: Tue, 19 Mar 2013 06:25:42 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EB7111@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1362728327-21013-3-git-send-email-dongsheng.wang@freescale.com>
 (from dongsheng.wang@freescale.com on Fri Mar  8 01:38:47 2013)
 <1363653058.27435.24@snotra>
In-Reply-To: <1363653058.27435.24@snotra>
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

Hi Scoot,

Thanks for reviewing.

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, March 19, 2013 8:31 AM
> To: Wang Dongsheng-B40534
> Cc: Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-
> B40534; Zhao Chenhui-B35336; Li Yang-R58472
> Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
>=20
> On 03/08/2013 01:38:47 AM, Wang Dongsheng wrote:
> > The driver provides a way to wake up the system by the MPIC timer.
> >
> > For example,
> > echo 5 > /sys/devices/system/mpic/timer_wakeup
> > echo standby > /sys/power/state
> >
> > After 5 seconds the MPIC timer will generate an interrupt to wake up
> > the system.
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
>=20
> Does this work with deep sleep (echo mem > /sys/power/state on mpc8536,
> p1022, etc) or just regular sleep?
>=20
The deep sleep can also work.

> > ---
> >  arch/powerpc/platforms/Kconfig              |    9 ++
> >  arch/powerpc/sysdev/Makefile                |    1 +
> >  arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c |  185
> > +++++++++++++++++++++++++++
> >  3 files changed, 195 insertions(+), 0 deletions(-)  create mode
> > 100644 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
> >
> > diff --git a/arch/powerpc/platforms/Kconfig
> > b/arch/powerpc/platforms/Kconfig index 5af04fa..487c37f 100644
> > --- a/arch/powerpc/platforms/Kconfig
> > +++ b/arch/powerpc/platforms/Kconfig
> > @@ -99,6 +99,15 @@ config MPIC_TIMER
> >  	  only tested on fsl chip, but it can potentially support
> >  	  other global timers complying to Open-PIC standard.
> >
> > +config FSL_MPIC_TIMER_WAKEUP
> > +	tristate "Freescale MPIC global timer wakeup driver"
> > +	depends on FSL_SOC &&  MPIC_TIMER
> > +	default n
> > +	help
> > +	  This is only for freescale powerpc platform.
>=20
> This sentence is redundant... It already says "Freescale MPIC" in the
> name and depends on "FSL_SOC && MPIC_TIMER".
>=20
Um...yes, I will remove it.
=20
> > +static irqreturn_t fsl_mpic_timer_irq(int irq, void *dev_id) {
> > +	struct fsl_mpic_timer_wakeup *wakeup =3D dev_id;
> > +
> > +	schedule_work(&wakeup->free_work);
> > +	return IRQ_HANDLED;
> > +}
>=20
> return wakeup->timer ? IRQ_HANDLED : IRQ_NONE;
>=20
Looks better, thanks.

> > +
> > +static ssize_t fsl_timer_wakeup_show(struct device *dev,
> > +				struct device_attribute *attr,
> > +				char *buf)
> > +{
> > +	struct timeval interval;
> > +	int val =3D 0;
> > +
> > +	mutex_lock(&sysfs_lock);
> > +	if (fsl_wakeup->timer) {
> > +		mpic_get_remain_time(fsl_wakeup->timer, &interval);
> > +		val =3D interval.tv_sec + 1;
> > +	}
> > +	mutex_unlock(&sysfs_lock);
> > +
> > +	return sprintf(buf, "%d\n", val);
> > +}
> > +
> > +static ssize_t fsl_timer_wakeup_store(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf,
> > +				size_t count)
> > +{
> > +	struct timeval interval;
> > +	int ret;
> > +
> > +	interval.tv_usec =3D 0;
> > +	if (kstrtol(buf, 0, &interval.tv_sec))
> > +		return -EINVAL;
>=20
> I don't think the buffer will NUL-terminated...  Ordinarily there'll be
> an LF terminator, but you can't rely on that (many other sysfs attributes
> seem to, though...).
>=20
I think we don't need to care about LF terminator.
The kstrtol--> _kstrtoull has been done.

> > +	mutex_lock(&sysfs_lock);
> > +
> > +	if (fsl_wakeup->timer && !interval.tv_sec) {
> > +		disable_irq_wake(fsl_wakeup->timer->irq);
> > +		mpic_free_timer(fsl_wakeup->timer);
> > +		fsl_wakeup->timer =3D NULL;
> > +		mutex_unlock(&sysfs_lock);
> > +
> > +		return count;
> > +	}
> > +
> > +	if (fsl_wakeup->timer) {
> > +		mutex_unlock(&sysfs_lock);
> > +		return -EBUSY;
> > +	}
>=20
> So to change an already-set timer you have to set it to zero and then to
> what you want?  Why not just do:
>=20
> 	if (fsl_wakeup->timer) {
> 		disable_irq_wake(...);
> 		mpic_free_timer(...);
> 		fsl_wakeup_timer =3D NULL;
> 	}
>=20
> 	if (!interval.tv_sec) {
> 		mutex_unlock(&sysfs_lock);
> 		return count;
> 	}
>=20
You can't break up the it.
if echo zero the code will cancel the timer that is currently running.
Not echo non-zero value just zero to cancel.

> > +	ret =3D subsys_system_register(&mpic_subsys, NULL);
> > +	if (ret)
> > +		goto err;
>=20
> Maybe arch/powerpc/sysdev/mpic.c should be doing this?
>=20
This can be registered by mpic. Maybe better than here.

> > +
> > +	for (i =3D 0; mpic_attributes[i]; i++) {
> > +		ret =3D device_create_file(mpic_subsys.dev_root,
> > +					mpic_attributes[i]);
> > +		if (ret)
> > +			goto err2;
> > +	}
>=20
> Is this code ever going to register more than one?
>=20
No, just one. I only keep the style here.
If you don't think it's necessary I can remove this loop.
