Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CAFDB2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 11:31:08 +1100 (EST)
Received: from mail117-co9 (localhost [127.0.0.1])	by
 mail117-co9-R.bigfish.com (Postfix) with ESMTP id 0822D3000F8	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 00:31:04 +0000 (UTC)
Received: from CO9EHSMHS017.bigfish.com (unknown [10.236.132.225])	by
 mail117-co9.bigfish.com (Postfix) with ESMTP id 4A884D80058	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 00:31:01 +0000 (UTC)
Date: Mon, 18 Mar 2013 19:30:58 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] powerpc/fsl: add MPIC timer wakeup support
To: Wang Dongsheng <dongsheng.wang@freescale.com>
In-Reply-To: <1362728327-21013-3-git-send-email-dongsheng.wang@freescale.com>
 (from dongsheng.wang@freescale.com on Fri Mar  8 01:38:47 2013)
Message-ID: <1363653058.27435.24@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>,
 Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/2013 01:38:47 AM, Wang Dongsheng wrote:
> The driver provides a way to wake up the system by the MPIC timer.
>=20
> For example,
> echo 5 > /sys/devices/system/mpic/timer_wakeup
> echo standby > /sys/power/state
>=20
> After 5 seconds the MPIC timer will generate an interrupt to wake up
> the system.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>

Does this work with deep sleep (echo mem > /sys/power/state on mpc8536, =20
p1022, etc) or just regular sleep?

> ---
>  arch/powerpc/platforms/Kconfig              |    9 ++
>  arch/powerpc/sysdev/Makefile                |    1 +
>  arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c |  185 =20
> +++++++++++++++++++++++++++
>  3 files changed, 195 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
>=20
> diff --git a/arch/powerpc/platforms/Kconfig =20
> b/arch/powerpc/platforms/Kconfig
> index 5af04fa..487c37f 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -99,6 +99,15 @@ config MPIC_TIMER
>  	  only tested on fsl chip, but it can potentially support
>  	  other global timers complying to Open-PIC standard.
>=20
> +config FSL_MPIC_TIMER_WAKEUP
> +	tristate "Freescale MPIC global timer wakeup driver"
> +	depends on FSL_SOC &&  MPIC_TIMER
> +	default n
> +	help
> +	  This is only for freescale powerpc platform.

This sentence is redundant... It already says "Freescale MPIC" in the =20
name and depends on "FSL_SOC && MPIC_TIMER".

> +static irqreturn_t fsl_mpic_timer_irq(int irq, void *dev_id)
> +{
> +	struct fsl_mpic_timer_wakeup *wakeup =3D dev_id;
> +
> +	schedule_work(&wakeup->free_work);
> +	return IRQ_HANDLED;
> +}

return wakeup->timer ? IRQ_HANDLED : IRQ_NONE;

> +
> +static ssize_t fsl_timer_wakeup_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct timeval interval;
> +	int val =3D 0;
> +
> +	mutex_lock(&sysfs_lock);
> +	if (fsl_wakeup->timer) {
> +		mpic_get_remain_time(fsl_wakeup->timer, &interval);
> +		val =3D interval.tv_sec + 1;
> +	}
> +	mutex_unlock(&sysfs_lock);
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t fsl_timer_wakeup_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf,
> +				size_t count)
> +{
> +	struct timeval interval;
> +	int ret;
> +
> +	interval.tv_usec =3D 0;
> +	if (kstrtol(buf, 0, &interval.tv_sec))
> +		return -EINVAL;

I don't think the buffer will NUL-terminated...  Ordinarily there'll be
an LF terminator, but you can't rely on that (many other sysfs =20
attributes
seem to, though...).

> +	mutex_lock(&sysfs_lock);
> +
> +	if (fsl_wakeup->timer && !interval.tv_sec) {
> +		disable_irq_wake(fsl_wakeup->timer->irq);
> +		mpic_free_timer(fsl_wakeup->timer);
> +		fsl_wakeup->timer =3D NULL;
> +		mutex_unlock(&sysfs_lock);
> +
> +		return count;
> +	}
> +
> +	if (fsl_wakeup->timer) {
> +		mutex_unlock(&sysfs_lock);
> +		return -EBUSY;
> +	}

So to change an already-set timer you have to set it to zero and then to
what you want?  Why not just do:

	if (fsl_wakeup->timer) {
		disable_irq_wake(...);
		mpic_free_timer(...);
		fsl_wakeup_timer =3D NULL;
	}

	if (!interval.tv_sec) {
		mutex_unlock(&sysfs_lock);
		return count;
	}

> +	ret =3D subsys_system_register(&mpic_subsys, NULL);
> +	if (ret)
> +		goto err;

Maybe arch/powerpc/sysdev/mpic.c should be doing this?

> +
> +	for (i =3D 0; mpic_attributes[i]; i++) {
> +		ret =3D device_create_file(mpic_subsys.dev_root,
> +					mpic_attributes[i]);
> +		if (ret)
> +			goto err2;
> +	}

Is this code ever going to register more than one?

-Scott=
