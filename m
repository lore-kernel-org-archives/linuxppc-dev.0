Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 15CE72C01FA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2012 18:13:52 +1100 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: [RFC PATCH] powerpc/fsl: add timer wakeup source
Date: Mon, 8 Oct 2012 07:13:26 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259DF1A14@039-SN2MPN1-021.039d.mgd.msft.net>
References: <6170650E-9D3C-4686-BF13-6C41DBFFB79D@kernel.crashing.org>	(from
 galak@kernel.crashing.org on Wed Oct  3 08:35:58 2012)
 <1349302807.31013.20@snotra>
In-Reply-To: <1349302807.31013.20@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wang Dongsheng <dongsheng.wds@gmail.com>, "linuxppc-dev@lists.ozlabs.org
 list" <linuxppc-dev@lists.ozlabs.org>, Li Yang-R58472 <r58472@freescale.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
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
> Sent: Thursday, October 04, 2012 6:20 AM
> To: Kumar Gala
> Cc: Wang Dongsheng; Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org list=
;
> Wang Dongsheng-B40534; Li Yang-R58472; linux-pm@vger.kernel.org
> Subject: Re: [RFC PATCH] powerpc/fsl: add timer wakeup source
>=20
> On 10/03/2012 08:35:58 AM, Kumar Gala wrote:
> >
> > On Oct 3, 2012, at 5:42 AM, Wang Dongsheng wrote:
> >
> > > This is only for freescale powerpc platform. The driver provides a
> > way
> > > to wake up system. Proc
> > interface(/proc/powerpc/wakeup_timer_seconds).
> > >
> > > eg: "echo 5 > /proc/powerpc/wakeup_timer_seconds", 5 seconds after
> > > the system will be woken up. echo another time into proc
> > interface
> > > to update the time.
> > >
> > > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > Signed-off-by: Li Yang <leoli@freescale.com>
> > > ---
> > > arch/powerpc/platforms/Kconfig            |   23 +++
> > > arch/powerpc/platforms/Makefile           |    1 +
> > > arch/powerpc/platforms/fsl_timer_wakeup.c |  217
> > +++++++++++++++++++++++++++++
> > > 3 files changed, 241 insertions(+)
> > > create mode 100644 arch/powerpc/platforms/fsl_timer_wakeup.c
> >
> > Adding the Linux PM list to see if there is some existing support for
> > this on other arch's in kernel.
> >
> > I'm pretty sure /proc/ is NOT where we want this exposed.
>=20
> Should probably go under the sysfs directory of the mpic device.  Or
> better, make a generic interface for timer-based suspend wakeup (if there
> isn't one already).  This current approach sits in an unpleasant middle
> ground between generic and device-specific.
> =09
/sys/power/wakeup_timer_seconds how about this?
I think it is a freescale generic interface, this interface control by
FSL_SOC && SUSPEND.

> > > diff --git a/arch/powerpc/platforms/Kconfig
> > b/arch/powerpc/platforms/Kconfig
> > > index b190a6e..7b9232a 100644
> > > --- a/arch/powerpc/platforms/Kconfig
> > > +++ b/arch/powerpc/platforms/Kconfig
> > > @@ -99,6 +99,29 @@ config MPIC_TIMER
> > > 	  only tested on fsl chip, but it can potentially support
> > > 	  other global timers complying to Open-PIC standard.
> > >
> > > +menuconfig FSL_WAKEUP_SOURCE
> > > +	bool "Freescale wakeup source"
> > > +	depends on FSL_SOC && SUSPEND
> > > +	default n
> > > +	help
> > > +	  This option enables wakeup source for wake up system
> > > +	  features. This is only for freescale powerpc platform.
> > > +
> > > +if FSL_WAKEUP_SOURCE
> > > +
> > > +config FSL_TIMER_WAKEUP
> > > +	tristate "Freescale mpic global timer wakeup event"
> > > +	default n
> > > +	help
> > > +	  This is only for freescale powerpc platform. The driver
> > > +	  provides a way to wake up system.
> > > +	  Proc interface(/proc/powerpc/wakeup_timer_seconds).
> > > +	  eg: "echo 5 > /proc/powerpc/wakeup_timer_seconds",
> > > +	  5 seconds after the system will be woken up. echo another
> > > +	  time into proc interface to update the time.
> > > +
> > > +endif
>=20
> Use depends rather than if/else.  Why do you need FSL_WAKEUP_SOURCE?
>
It lists all wake up source. If later have wakeup source can be improved by
it to control. Buttons event wakeup source will be added after the timer.

> These names are overly broad -- this is only for FSL MPIC, not for other
> FSL chips (e.g. mpc83xx has a different global timer implementation, and
> there's FSL ARM chips, etc).
>=20
Yes, thanks. Change to FSL_MPIC_TIMER_WAKEUP.

> > > +static ssize_t timer_wakeup_write(struct file *file, const char
> > __user *buf,
> > > +		size_t count, loff_t *off)
> > > +{
> > > +	struct fsl_timer_wakeup *priv;
> > > +	struct inode *inode =3D file->f_path.dentry->d_inode;
> > > +	struct proc_dir_entry *dp;
> > > +	struct timeval time;
> > > +	char *kbuf;
> > > +
> > > +	dp =3D PDE(inode);
> > > +	priv =3D dp->data;
> > > +
> > > +	kbuf =3D kzalloc(count + 1, GFP_KERNEL);
> > > +	if (!kbuf)
> > > +		return -ENOMEM;
> > > +
> > > +	if (copy_from_user(kbuf, buf, count)) {
> > > +		kfree(kbuf);
> > > +		return -EFAULT;
> > > +	}
> > > +
> > > +	kbuf[count] =3D '\0';
> > > +
> > > +	if (kstrtol(kbuf, 0, &time.tv_sec)) {
> > > +		kfree(kbuf);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	kfree(kbuf);
> > > +
> > > +	time.tv_usec =3D 0;
> > > +
> > > +	mutex_lock(&priv->mutex);
> > > +
> > > +	if (!time.tv_sec) {
> > > +		if (priv->timer) {
> > > +			mpic_free_timer(priv->timer);
> > > +			priv->timer =3D NULL;
> > > +		}
> > > +		mutex_unlock(&priv->mutex);
> > > +
> > > +		return count;
> > > +	}
> > > +
> > > +	if (priv->timer) {
> > > +		mpic_free_timer(priv->timer);
> > > +		priv->timer =3D NULL;
> > > +	}
> > > +
> > > +	priv->timer =3D mpic_request_timer(timer_event_interrupt, priv,
> > &time);
>=20
> If the new time is zero, consider that a cancellation of the timer and
> don't request a new one or return -EINVAL.
>=20
Thanks, I think i should add comments. Let this patch easy to read.
Here is get a new timer.
If the new time is zero, consider that has been checked.

if (!time.tv_sec) {...} this is check zero.
The "mpic_request_timer" before this code.

 - Dongsheng
