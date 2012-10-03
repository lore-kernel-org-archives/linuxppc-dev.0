Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C5CB12C037B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 08:20:21 +1000 (EST)
Date: Wed, 3 Oct 2012 17:20:07 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH] powerpc/fsl: add timer wakeup source
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6170650E-9D3C-4686-BF13-6C41DBFFB79D@kernel.crashing.org>
 (from galak@kernel.crashing.org on Wed Oct  3 08:35:58 2012)
Message-ID: <1349302807.31013.20@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <b07421@freescale.com>, linux-pm@vger.kernel.org,
 Wang Dongsheng <dongsheng.wds@gmail.com>,
 Wang Dongsheng <dongsheng.wang@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/03/2012 08:35:58 AM, Kumar Gala wrote:
>=20
> On Oct 3, 2012, at 5:42 AM, Wang Dongsheng wrote:
>=20
> > This is only for freescale powerpc platform. The driver provides a =20
> way
> > to wake up system. Proc =20
> interface(/proc/powerpc/wakeup_timer_seconds).
> >
> > eg: "echo 5 > /proc/powerpc/wakeup_timer_seconds", 5 seconds
> > after the system will be woken up. echo another time into proc =20
> interface
> > to update the time.
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > arch/powerpc/platforms/Kconfig            |   23 +++
> > arch/powerpc/platforms/Makefile           |    1 +
> > arch/powerpc/platforms/fsl_timer_wakeup.c |  217 =20
> +++++++++++++++++++++++++++++
> > 3 files changed, 241 insertions(+)
> > create mode 100644 arch/powerpc/platforms/fsl_timer_wakeup.c
>=20
> Adding the Linux PM list to see if there is some existing support for =20
> this on other arch's in kernel.
>=20
> I'm pretty sure /proc/ is NOT where we want this exposed.

Should probably go under the sysfs directory of the mpic device.  Or =20
better, make a generic interface for timer-based suspend wakeup (if =20
there isn't one already).  This current approach sits in an unpleasant =20
middle ground between generic and device-specific.

> > diff --git a/arch/powerpc/platforms/Kconfig =20
> b/arch/powerpc/platforms/Kconfig
> > index b190a6e..7b9232a 100644
> > --- a/arch/powerpc/platforms/Kconfig
> > +++ b/arch/powerpc/platforms/Kconfig
> > @@ -99,6 +99,29 @@ config MPIC_TIMER
> > 	  only tested on fsl chip, but it can potentially support
> > 	  other global timers complying to Open-PIC standard.
> >
> > +menuconfig FSL_WAKEUP_SOURCE
> > +	bool "Freescale wakeup source"
> > +	depends on FSL_SOC && SUSPEND
> > +	default n
> > +	help
> > +	  This option enables wakeup source for wake up system
> > +	  features. This is only for freescale powerpc platform.
> > +
> > +if FSL_WAKEUP_SOURCE
> > +
> > +config FSL_TIMER_WAKEUP
> > +	tristate "Freescale mpic global timer wakeup event"
> > +	default n
> > +	help
> > +	  This is only for freescale powerpc platform. The driver
> > +	  provides a way to wake up system.
> > +	  Proc interface(/proc/powerpc/wakeup_timer_seconds).
> > +	  eg: "echo 5 > /proc/powerpc/wakeup_timer_seconds",
> > +	  5 seconds after the system will be woken up. echo another
> > +	  time into proc interface to update the time.
> > +
> > +endif

Use depends rather than if/else.  Why do you need FSL_WAKEUP_SOURCE?

These names are overly broad -- this is only for FSL MPIC, not for =20
other FSL chips (e.g. mpc83xx has a different global timer =20
implementation, and there's FSL ARM chips, etc).

> > +static ssize_t timer_wakeup_write(struct file *file, const char =20
> __user *buf,
> > +		size_t count, loff_t *off)
> > +{
> > +	struct fsl_timer_wakeup *priv;
> > +	struct inode *inode =3D file->f_path.dentry->d_inode;
> > +	struct proc_dir_entry *dp;
> > +	struct timeval time;
> > +	char *kbuf;
> > +
> > +	dp =3D PDE(inode);
> > +	priv =3D dp->data;
> > +
> > +	kbuf =3D kzalloc(count + 1, GFP_KERNEL);
> > +	if (!kbuf)
> > +		return -ENOMEM;
> > +
> > +	if (copy_from_user(kbuf, buf, count)) {
> > +		kfree(kbuf);
> > +		return -EFAULT;
> > +	}
> > +
> > +	kbuf[count] =3D '\0';
> > +
> > +	if (kstrtol(kbuf, 0, &time.tv_sec)) {
> > +		kfree(kbuf);
> > +		return -EINVAL;
> > +	}
> > +
> > +	kfree(kbuf);
> > +
> > +	time.tv_usec =3D 0;
> > +
> > +	mutex_lock(&priv->mutex);
> > +
> > +	if (!time.tv_sec) {
> > +		if (priv->timer) {
> > +			mpic_free_timer(priv->timer);
> > +			priv->timer =3D NULL;
> > +		}
> > +		mutex_unlock(&priv->mutex);
> > +
> > +		return count;
> > +	}
> > +
> > +	if (priv->timer) {
> > +		mpic_free_timer(priv->timer);
> > +		priv->timer =3D NULL;
> > +	}
> > +
> > +	priv->timer =3D mpic_request_timer(timer_event_interrupt, priv, =20
> &time);

If the new time is zero, consider that a cancellation of the timer and =20
don't request a new one or return -EINVAL.

-Scott=
